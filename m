Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B05C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 06:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjHJGQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 02:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHJGQT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 02:16:19 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 23:16:16 PDT
Received: from out-113.mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50AA6
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 23:16:16 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1691647714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F0LU4qk1HKVSN9eq8TOlWSZk3r0zQSd5UDHloXYs6Ok=;
        b=YYMMFMCE9UOI6hloCRnK5NSENRepa7Pma6PA5ACCZnlKRU7tNZKdrw7aZBileT4FP4TtUi
        nSs1Z0ex0N9deqi037ysn3oXO67yudOXwwtmkp4izEt/9USUU5Mwx7Hcfyhbc/B8lIrGnP
        q50nfkAaqg1cc0X5nHEEJ/UgZTzHpOk=
Date:   Thu, 10 Aug 2023 06:08:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <274ec1a2152b0fd53b35c1591f5177e0b0713430@rjp.ie>
TLS-Required: No
Subject: Fetching too many tags?
To:     git@vger.kernel.org
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey git,

I am interested in git performance today and can't figure out what's goin=
g on
here. I was wondering why my git-fetch might be slow in an up-to-date rep=
o:

  $ git pull
  Already up to date.
  $ time git fetch origin master
  From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
   * branch                      master     -> FETCH_HEAD
  git fetch origin master  0.13s user 0.06s system 10% cpu 1.705 total

GIT_TRACE_CURL shows it spends most of the time transfering (all) tags fr=
om the
remote. It's much faster with --no-tags:

  $ time git fetch -n origin master
  From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
   * branch                      master     -> FETCH_HEAD
  git fetch -n origin master  0.11s user 0.03s system 36% cpu 0.383 total

But I don't have tagOpt set:

  $ git config remote.origin.tagOpt || echo $?
  1

And the remote doesn't have to send me any commits, so I don't see why I =
should
receive any tags at all. Why might I be receiving so many tags?

Thanks,
Ronan
