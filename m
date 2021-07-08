Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C15C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F66162B
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhGHTYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 15:24:41 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.108]:36423 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHTYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 15:24:39 -0400
Received: from [84.163.72.131] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1ZaO-0001MH-43; Thu, 08 Jul 2021 21:21:24 +0200
Subject: Re: What actually is a branch?
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
Date:   Thu, 8 Jul 2021 21:21:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e736e72da68_30939020850@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2021 19:33, Felipe Contreras wrote:
> The only reason I mentioned @{tail} (or @{base}) is to have a better
> mental model of what a branch is.
> 
>   1. A branch is whatever is inside `branch@{base}..branch`

For this part "branch" = some series of commits.

Then this is what I would say is a common misunderstanding.

Yet that may be the difference between what people want the branch to 
be, and what it (afaik) technically is.

People indeed tend to thing, I branched at X, so anything before is not 
part of the branch.
"--contains" says otherwise.


Thinking of it.

If I look at a feature branch, then my feature starts where I created 
the branch. I want my feature branch to represent this.

But if I look at my local master branch (or any tracking branch), I like 
to believe that it contains the same as the remote branch.
And well, if we just set the base for the local tracking branch to be 
the same as the base for the remote branch that would be fine.
But if (after diverging, due to changes pulled from remote) then, I run
    git rebase @{base} @{remote}
then rebase has to skip all the shared commits.

And since rebase also repoints the "base", my local branch then no 
longer contains the same as the remote.

So limiting the branch to branch@{base}..branch only works for feature 
branches.


So yes, what is a branch? More exactly what does it contain.
Two examples, that to me suggest two answers.


Also if branch@{base}..branch  then there is a problem.
- branch@{base} is then correctly not part of the branch
- So immediately after "git switch -c branch" the branch is empty => ok
But if so, then what is the branch head at that time?
The Pointer would point the @{base}, but @base is outside the branch. So 
the pointer of the branch points outside the branch?



>   2. `branch` is the branch head (`branch@{head}`), but it's not the
>      branch itself
Well technically "branch" is the "pointer" to the head.
Assuming we want "head" to be a commit?
Or do we want head, to be the "branch end" after the last commit? But 
then still "branch is the pointer"

The only problem is:
branch is too often used for "the commits contained in the branch". That 
is way to common to even try to stop it.

Yet, if branch is used for the content, then we do not have a good term 
for the pointer.




> 
> For all intents and purposes on the git documentation the branch, the
> branch name, and the branch head are used interchangeably, but
> semantically speaking they are not the same thing.

I have not proof read all the docs for this....
But I think that "branch name" and "branch head" should or could be used 
in a clear single meaning fashion each...

> 
> When you change the branch head you are effectively changing the branch.
Well if branch is the pointer, then you change the branch, and head is 
being changed.
If branch is the content, then you change the head, and yes the content 
changes.


