Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D3CC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32FA60E09
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 15:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhGYOXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 10:23:41 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:63235 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhGYOXl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 10:23:41 -0400
Received: from [87.152.157.21] (helo=[192.168.2.202])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m7feN-0002VV-0a
        for git@vger.kernel.org; Sun, 25 Jul 2021 17:02:43 +0200
From:   Martin <git@mfriebe.de>
To:     git@vger.kernel.org
Subject: Files modified, even after: git reset --hard
Message-ID: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
Date:   Sun, 25 Jul 2021 17:04:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some files, that will show up modified. Always.

If I just switch to a commit, with clean worktree before, then those 
files will be modified.

I can not stash them.
git reset --hard does not change anything.

Diff shows the entire file is modified. I suspect its the line endings..

This happens on windows, and
   autocrlf=true

The checked out file (which is marked as modified) has the correct CrLf 
endings.

What I have not been able to find, is what line endings are stored in 
the blob.
Its an xml file, so they should be just Lf.
But I *suspect* that the blob contains either CrLf, or mixed line-endings.

Could that be? that if a file does have unexpected line endings in the 
commit's blob, that it shows as modified?

One the one hand, yes, If I commit, that file will change.
On the other hand, if I just check out (or do reset-hard) then I don't 
expect modified files....

So what should happen?

This also causes problems, because in order to for example rebase 
something, I first need to switch to some commit that can be checked out 
without modified files.
Or rebase will not work.

Also in that repro, I had problems that some rebases failed with (with 
and without --reapply-cherry-picks)
    error: add_cacheinfo failed
Those rebase where between an orphaned branch, and a "normal" branch.
And it is possible that the file only had the line ending issues in one 
of the 2 branches....
But that I was not able to further investigate.



//git for windows
git version 2.32.0.windows.2

