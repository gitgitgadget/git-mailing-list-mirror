Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E01EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 08:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjFWI7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFWI65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 04:58:57 -0400
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 01:58:53 PDT
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net [178.154.239.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F6D268E
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 01:58:53 -0700 (PDT)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by forward204b.mail.yandex.net (Yandex) with ESMTP id 27E9A69F5A
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 11:53:06 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1113:0:640:fe99:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 9C89260041
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 11:53:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xqCtPc7WxW20-z0l49M8x;
        Fri, 23 Jun 2023 11:53:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687510380;
        bh=C39zBzwKzjZQLNn6wdTY4A22Pd+zYLU8AdQ5nmTbztI=;
        h=Date:To:From:Subject:Message-ID;
        b=t0897R0JmLmxvSXVPswtqpEb45Uxu0rPlhAM9QIuuiSN4UpFMgtam0OO0CIj+6A8+
         cUEXBLr/H5ZfYM29ExdsvQtRfYRqv5rKnAUiCdzwhHEKO6e0YbKIK4ZkbbS/a/bgrB
         2sBuWBjfHLAonXpUniimvRnfurmC//c6dFXjOewM=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <21c8396c1441dd4f74cd2097ac970a2033b81da4.camel@yandex.ru>
Subject: Getting path to a file from arbitrary project directory
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     git@vger.kernel.org
Date:   Fri, 23 Jun 2023 11:52:58 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(please keep me CC'ed, I'm not subscribed)

Hello! I'm trying to solve a simple problem: while I am inside an arbitrary=
 project directory, I want to get a path to a file `filename.c` located els=
ewhere in the same project.=C2=B9

One way to implement that is with a command chain:

	cd $(git rev-parse --show-toplevel) && git ls-files --full-name -- "*filen=
ame.c"

But it is pretty clunky, because that requires you to modify state (changin=
g current directory). It may not matter though, but I'm just wondering if t=
here's a better way to do that, something like `git ls-files --top -- =E2=
=80=A6`, or anything like that? Haven't found nothing similar in `man git-l=
s-files`.

As a separate note, this doesn't work:

	ls-files --full-name -- $(git rev-parse --show-toplevel)"*filename.c"

1: the usecase is I have a Emacs helper function to pick up a an aribtraril=
y mangled path to a file in the project from the primary clipboard and open=
 that file. It's often "mangled", because gdb prints it with `../`, then lo=
gs print no path whatsoever, just a filename=E2=80=A6 So it's generally use=
ful to have.
