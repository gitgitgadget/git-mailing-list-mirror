Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22139C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E9461468
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhGAKIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:08:52 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.108]:11915 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhGAKIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:08:52 -0400
Received: from [84.163.72.76] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lyta6-0005At-7H; Thu, 01 Jul 2021 12:06:02 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
From:   Martin <git@mfriebe.de>
Message-ID: <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
Date:   Thu, 1 Jul 2021 12:06:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2arrmba.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07/2021 00:59, Junio C Hamano wrote:
> Martin <git@mfriebe.de> writes:
>
>> And yes, for the documentation, it *should* be clear that, removing a
>> branch, removes the
>> commits on it.
>> But then it must be said, that the branch is first removed. That is
>> not currently the case.
> Sorry, but I still do not see how it makes any difference if the
> branch is first removed and then made to point at somewhere else, or
> the branch gets just moved without any explicit or impolicit
> removal.  A branch cannot point at two different commits at the same
> time, so the end result is that the commit at the old tip is no
> longer pointed at by the branch after the update.

Well all very obvious, if you know git well.

Let's take a step back. How exactly is the word "branch" actually 
defined? Well it does not matter.
What matters is, how the word is used.
What does a person mean, when they speak of the branch?

And the answer is, it's not always clear.

In the above conversation, we use "branch" to speak of the "pointer to a 
single commit".
We do not include any commits, when speaking of the "branch".
(And this is how it is used in the docs, as far as I can find)

However a lot of people use "branch" to refer to the commits within.
"Push a branch to a remote". That obviously means the objects (e.g. 
commits) in the branch.
The doc says (and yes I am getting a bit picky here)
 >>> Updates remote refs using local refs, while sending objects 
necessary to complete the given refs.
"complete the given ref". The ref is given by the branch, and completing 
means afaik "to make something part of"
Maybe a mistake made, because "branch" is (according to my observation) 
so commonly (mis-)used to include the objects.

Anyway, can we agree, that there are people who  (mistakenly) 
use/understand "branch" as including the objects?
Enough people to call it a "common mistake".
If so, then we should not ignore this.

With this use of "branch" in mind, (re-)creating an existing  branch on 
a new startpoint,
does to the inexperienced user read like a rebase. It recreates all the 
commits.
The fact that as an experienced user, I shake my head in disbelief, does 
not change this.

But true, my attempt on adding "the old branch is removed" does not either.
So not sure which wording will do best.
Probably
        "Creates a new empty branch at <start point>"

Even though "empty" may be a sloppy usage too....


The other problem with the current doc is

> On 01/07/2021 02:06, Matt Rogers wrote:
>> I think the current documentations usage of "reset" in
>>
>>      Similar to --create except that if <new-branch> already exists, it
>> will be reset to <start-point>.
>>
>> Is pretty clear about what happens, although it does rely on users
>> being familiar
>> with the semantics of "resetting" a la git reset.
>
Not everyone is "familiar" with reset.
And if you look up reset, you are left alone if that is a --soft or 
--hard or --mixed.

In any case, while it is ok, to refer to other parts of the doc, it 
should still be possible
to read just the current doc, and get a full understanding of the command.

So a short addition to the current doc, that explains "reset" should be 
added.

I currently am out of ideas how to word it, other than based on my 
previous ideas.

But as in the first part of this mail, maybe just add the "empty" to the 
existing doc?
So the existing
    "it will be reset to |<start-point>|. "
changes to
    "it will be reset to [become] an empty branch at |<start-point>|. "

Happy for any idea, how the reader can be reminded, that "branch" is the 
pointer only, and excludes any objects that it refers to.

I was just about to write "any objects in it (in the branch)". But as 
established the objects are not part, therefore not "in it"...
Just how easy it is to think of branch as more than it is.

