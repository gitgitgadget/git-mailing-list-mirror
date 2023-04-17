Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B8FC77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 11:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjDQLxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDQLxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 07:53:31 -0400
X-Greylist: delayed 5987 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 04:52:31 PDT
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D8C1706
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 04:52:31 -0700 (PDT)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by forward206a.mail.yandex.net (Yandex) with ESMTP id 3F78749454
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:10:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8cab:0:640:c1ae:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 36A0E60137
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:07:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id P7YUqlUW1W20-Jmh4T0pL;
        Mon, 17 Apr 2023 13:07:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1681726046;
        bh=vKE9tJVnbkTI8RTtrbgM3r4JGdoeQl6BRbow9SyG+gE=;
        h=Date:To:From:Subject:Message-ID;
        b=YwmGQ4dO76/RK/2iO+dT0CLGVHaEY556XH+YzpVhCF7IHVU7CPrHMZkQ6F8Mo7VLQ
         C5f9tSHeQXOxmg/XTWDBeSW+dvamv7Vy8huHov5QjlH+BLb/m49d/SaTjlWeVZd4eg
         jC/bt4/3XhZKvKrupPQaF4T/mBsGZTA81mxQkIdk=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0d8c0c2c6f9348a2afea3992f589ab52db5bb434.camel@yandex.ru>
Subject: What hook is called after `git rebase --abort`?
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     git@vger.kernel.org
Date:   Mon, 17 Apr 2023 13:07:25 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As title says.

The usecase is typical: there's the infamous issue of dangling git-submodul=
e changes
appearing in various operations, leading to problems such as inadvertently =
commiting
a submodule hash change while editing an irrelevant commit.

I already had sprinkled a few `git submodule update`s in `post-checkout` an=
d
`post-rewrite` hooks, but I just found one more case: executing a `git reba=
se
--abort` to abort a `git rebase` operation that involved changing a submodu=
le commit
results in the submodule change appearing in `git diff` even though no reba=
se
operation is ongoing. Apparently there's one more hook that requires to hav=
e the same
command, any ideas what that could be?

P.S.: please keep me CCed, I'm not subscribed to the list

