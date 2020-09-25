Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6FBC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B96206E5
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=artfulrobot.uk header.i=@artfulrobot.uk header.b="h4HRDTSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgIYQ32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:29:28 -0400
Received: from mail.artfulrobot.uk ([185.13.148.55]:43092 "EHLO
        ar4.artfulrobot.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYQ32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 12:29:28 -0400
X-Greylist: delayed 2444 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 12:29:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=artfulrobot.uk; s=20151210; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8l2Mr1e5L6FE3GnBGMlrh5vaNMP8mEiYoUCz29YxhuU=; b=h4HRDTSv+29hgkabWqNDamglLM
        IfAJRMGf4FtOhwWHMALoBrG37Bpk9gtFCLUn5l42bAUjzrFefKxqYc+8ld2LQKXWvdwWXaltYRgxz
        iJD5NHAp6oBl+zMhwKc6UjNygocvrMGnUzkcTsm6y81H2eWim8TIMOjYPz9yVGw9gPOE=;
Received: from shinyblue.plus.com ([81.174.169.217] helo=[192.168.1.118])
        by mail.artfulrobot.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <forums@artfulrobot.uk>)
        id 1kLpxi-00022Z-UG
        for git@vger.kernel.org; Fri, 25 Sep 2020 16:48:43 +0100
To:     git@vger.kernel.org
From:   Rich <forums@artfulrobot.uk>
Subject: Segfault during fsck and spreading brokenness
Message-ID: <2aa62ff7-0780-8e20-e87d-387152524971@artfulrobot.uk>
Date:   Fri, 25 Sep 2020 16:48:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was encouraged by a couple of people on stackoverflow to post to this 
list. Apols in advance if it's not the right place.


I encountered a Segfault during fsck on a damaged bare repo (probably 
due to a powercut. Possibly during an operation, although not sure):

git --version
git version 2.11.0

git fsck --full -v
Checking HEAD link
Checking object directory
Checking tree 11bbc847cf1b4422b3e37830a9eac2e7af6559de
Checking tree 11be4abeb20314de6145dfc0e6180807a74c03dc
--->8 snip 8<---------------------------------------------------------------
Checking tree 14a4423e86f06c7ad75bf391d138e0cf7790508f
Checking tree 147aeaec72b2f29bf1813494c942fbce497be679
zsh: segmentation fault  git fsck --full -v

Host: Debian 10. Linux 4.9.0-13-amd64 #1 SMP Debian 4.9.228-1 
(2020-07-05) x86_64 GNU/Linux

FS: BTRFS


I learnt about the damage while trying to `git push`  from my dev 
working tree. I think I did a `git pull` when the `git push` failed. The 
result of this was that my *local* repo was also damaged: there was an 
empty file created that would stop git operations and on deleting that I 
got a page full of errors.

Original SO question: 
https://stackoverflow.com/questions/64044995/can-one-corrupt-git-repo-corrupt-another?noredirect=1


Unfortunately I don't think I'm at liberty to give access to the repo as 
it possibly contains sensitive info/personal data.

I have solved the problem for myself (took a morning to do it!) but 
reporting here in case it's useful to do so. I use git all the time and 
I'm grateful for it. I'm not a systems-level coder, so not sure what use 
I'll be, but happy to answer any Qs or try things on the broken copies.


Thanks,

Rich

