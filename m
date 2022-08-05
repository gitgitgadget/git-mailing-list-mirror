Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA04C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 05:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiHEFxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 01:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiHEFxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 01:53:18 -0400
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Aug 2022 22:53:16 PDT
Received: from forward104p.mail.yandex.net (forward104p.mail.yandex.net [77.88.28.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8992717E
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 22:53:16 -0700 (PDT)
Received: from sas8-c6148047b62a.qloud-c.yandex.net (sas8-c6148047b62a.qloud-c.yandex.net [IPv6:2a02:6b8:c1b:2a11:0:640:c614:8047])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id 2F67E3C20FE4
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 08:45:03 +0300 (MSK)
Received: by sas8-c6148047b62a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id V3pkWC7qGv-j2hmgZkB;
        Fri, 05 Aug 2022 08:45:02 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail; t=1659678302;
        bh=gOIQUzv88NC+21EljujBFUCaaZciKfreJcXFpHKdnZo=;
        h=Subject:From:To:Date:Message-ID;
        b=mCXJ6X1TGobptzfiiZXI9KiURyj++TbS0b5fDGB28kbR1OFOYmvmdsBydyfUAdQMH
         Oj19ta3K+rRvKAjZftNOsagA7CSLlGNlMMJ1RU7FjZ9nSDDcK3HpggZd+t4yYPoT6R
         zBh2DHL9yIzitngXrZc44lZ07J88JRnuqWg0//6A=
Authentication-Results: sas8-c6148047b62a.qloud-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <30015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
Date:   Fri, 5 Aug 2022 08:45:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Content-Language: en-US
To:     git@vger.kernel.org
From:   Ilya K <me@0upti.me>
Subject: [bug] Segfault in git commit when a hook has a broken shebang
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! I ran into a weird bug just now that is probably easier to show 
than explain:
❯ git init
Initialized empty Git repository in /home/k900/test/.git/
❯ echo '#!/usr/bin/oops' > .git/hooks/pre-commit
❯ chmod +x .git/hooks/pre-commit
❯ touch oops
❯ git add oops
❯ git commit -a
fatal: cannot run .git/hooks/pre-commit: No such file or directory
[1]    24580 segmentation fault (core dumped)  git commit -a
This happens consistently with git 2.37.x, and I don't think it happened 
with git 2.36 or earlier.

I'm not sure if this has been reported already, but a quick search of 
the list archives didn't get me anywhere, so apologies if this is a 
duplicate.
Thanks!

