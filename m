Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CBC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAED76148E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhBRT7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhBRT4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:56:35 -0500
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Feb 2021 11:55:55 PST
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C002C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 11:55:55 -0800 (PST)
Received: from postfix01.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout01.mail.de (Postfix) with ESMTP id 15B2410056D
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 20:49:29 +0100 (CET)
Received: from smtp04.mail.de (smtp04.bt.mail.de [10.0.121.214])
        by postfix01.mail.de (Postfix) with ESMTP id ECA4F801C3
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 20:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1613677769;
        bh=yjD5ll9cM6SZbUljz/RwfEuzhLN5N0//XhAf/vwZFm4=;
        h=To:From:Subject:Date:From;
        b=vgISWx86RUUR3lpbpJiIRm0QcaH4K39cV3rDGFpb3KpyhMEr0nk3LIUsyAlEZ0jiR
         kBmkY084890IHD6EwBRg1b3ijvcivEOl2dmnoldjmPyErKcYrZWH07yVWuKbVakzKz
         OvbnlReLheIYBic0I8xdWd4D38Yxs5zRp5gXbVqHXZjdAtby8xiiM7BCqUilGC8YQR
         gF3OHD1Ee+unBtn02Vrm0udvwZ/sDELOMXras/XoqGaWVacaxZaPN5RWVf71MC0IRz
         A7iCNOdztdyqu/4gSMy7qcSCvPeBg1u+OVSZE0Sudsi9MrfbtSbpsS482cELILLxaq
         LH+LeLxNWoTvA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp04.mail.de (Postfix) with ESMTPSA id 99E67C00F8
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 20:49:28 +0100 (CET)
To:     git@vger.kernel.org
From:   "Sven R. Kunze" <srkunze@mail.de>
Subject: git subtree pull vs git pull
Message-ID: <988c57dd-58dc-8ec7-7b00-60313473277c@mail.de>
Date:   Thu, 18 Feb 2021 20:49:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1323
X-purgate-ID: 154282::1613677768-00003B00-D9C7E4ED/0/0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

that's my first question here, so please bare with me. I got an 
unexplained behavior using git-subtree.


Please consider (git --version := 2.30.0):

me@host:~/repo$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
         modified: somechanges

no changes added to commit (use "git add" and/or "git commit -a")

me@host:~/repo$ git pull --no-rebase
Already up to date.

me@host:~/repo$ git subtree pull --prefix=prefix/ subtree-origin master
Working tree has modifications.  Cannot add.


My expectation would be that I can pull the subtree as I could pull the 
main repo without any issue. The subtree does not even touch the 
modified file.

Is there a reason for this or can this restriction be lifted?

Where am I coming from? The work-around would be "git stash, git subtree 
pull, git stash pop" which would work on a first glance, but other tools 
like IDEs lose their context information regarding these changes (e.g. 
changelists). This can be a little bit annoying given that mostly there 
are not changes at the subtree-origin.

Best regards,
Sven

