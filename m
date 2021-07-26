Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B1C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B78860F45
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhGZMJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:09:35 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:21335 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhGZMJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:09:34 -0400
Received: from [84.163.73.49] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m801O-0008SJ-Eh; Mon, 26 Jul 2021 14:47:50 +0200
Subject: Re: Files modified, even after: git reset --hard
To:     Philip Oakley <philipoakley@iee.email>,
        Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
 <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
 <fd2f2e6b-0ced-8eb7-b908-956b084f23c7@iee.email>
From:   Martin <git@mfriebe.de>
Message-ID: <abfb0196-ff4e-199a-6464-335abf514a63@mfriebe.de>
Date:   Mon, 26 Jul 2021 14:50:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fd2f2e6b-0ced-8eb7-b908-956b084f23c7@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/2021 12:39, Philip Oakley wrote:
> On 26/07/2021 02:34, Martin wrote:
>> I figured that is the reason why they show modified.
>>
>> Not a problem. Until I am in the middle of a rebase, and i cannot run
>> (after a conflict)
>>    git rebase --continue
>>
>> The modified files are not part of the original series of commits.
>> they are just random files from somewhere else in the tree.
>> I can not reset/restore them.
>> So I must now "git add" files entirely unrelated to continue rebasing.
>> Well or apparently change my config for the duration of the rebase.
> 
> Is this 'mid-rebase' the core case for the 'Files modified' problem? -
> does it happen at other times (excepting maybe cherry-pick)
> 

So far yes.
Potentially, not yet tested, "git bisect" could be affected. That would 
also be a problem.
And yes, when rebase failed, cherry pick would also fail.


I did not see a "force" option for either of them, to ignore a dirty 
worktree.

> i.e. you are rebasing a series of commits where some files had 'old'
> line endings in the repository, but your current line ending setting
> wants the line endings in those un-related, un-changed files to change
> their line endings, and the rebase command can't cope with these
> incidental differences?
> 

I had a series of errors. Some of the errors, are indeed that I can not 
continue after resolving conflicts, because I can not clean the worktree.
(I guess I could set up a .git/info/gitattribute to mark the files as 
binary, and remove it again after the rebase. But that is not a 
desirable solution)


As a once off I also got an
    error: add_cacheinfo failed
One branch really could not be rebase by any means. But it was a single 
commit, so I copied the files.



I did "git replace" now for lots of those files.
But some commits had "modified files" that appear to have the correct 
line ending in the repro (git add --renormalize did not add changes to 
be committed / the file is added, but commit says 0 lines changed, and 
the issue remains).
So for those I have no way to get rid of yet.

Those none-line ending issues existed already before I started to git 
replace.
I did not replace commits, but only the blobs for the file in question 
(had to find several such blobs, per commit series)

