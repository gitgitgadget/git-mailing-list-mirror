Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1745C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02B361DC2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhF2TGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:06:49 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:47147 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhF2TGm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:06:42 -0400
Received: from [79.233.236.111] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lyJ1J-0000Ci-Si; Tue, 29 Jun 2021 21:03:41 +0200
From:   Martin <git@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
Message-ID: <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
Date:   Tue, 29 Jun 2021 21:04:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0mcy6g2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll redo the patch, when we got a better text....

On 29/06/2021 18:35, Junio C Hamano wrote:
> Martin<git@mfriebe.de>  writes:
>
>>   	Similar to `--create` except that if `<new-branch>` already
>> -	exists, it will be reset to `<start-point>`. This is a
>> -	convenient shortcut for:
>> +	exists, it will be reset to `<start-point>`.
>> +	This forces the branch to the new location.
> I would have written "This forces the branch to point at a different
> commit", as we do not have to use a fuzzy word "location" in this
> context (is it a location in the directory structure in the working
> tree?  is it a location in the history dag?  is it a location in
> some other dimension?).
Ok.

> Up to this point, it makes sense.
>
>> + It also forces
>> +	any commit hold by the branch to be dropped, unless the
>> +	commit is also part of any other branch too. You may
>> +	therefore loose some of your data.
> Aside from typo on "lose" (not "loose") and "held" (not "hold"),
> this paragraph does not seem to add much value, at least to me, and
> I suspect that it makes things even more confusing to new readers.
>
>   * Repointing the branch tip to a different commit is not limited to
>     "git switch -C".  Any commands that allow you to move the branch
>     tip, like "git branch -f", "git checkout -B", "git push --force",
>     "git reset", share the same property and singling "switch -C" out
>     gives a false impression that all other commands are OK.
Well, yes. There may be more doc pages that could be updated. But that 
should not stop us
from starting at some point.
I chose "git switch", because as I understand it, it was made in an 
effort to make git
easier to use (by distinguishing between the clumped together commands 
that were
all done with "git checkout")
In that sense, I see "git switch" as a particular important improvement 
for people new
to git. Hence I felt that its documentation needed the extra bit of 
attention.

>   * "to be dropped" is unnecessarily alarming (and not even correct).
>     "gc" will not reclaim while the reflog entries hold onto them.
>
>     "Some commits that used to be reachable from the original branch
>     tip may become unreachable." would not be an incorrect
>     description per-se (and would be a vast improvement over what is
>     in the posted patch), but it is dubious to stress the obvious,
>     especially given that the whole point of "branch -f" is to make
>     wrong commits disappear by pointing at corrected commits with the
>     branch tip.
My text may indeed have lacked clarity. I was trying to emphasize to 
hard, that this
command's "force" enables 2 actions that may both not be wanted. Usually 
if one applies
"force" to a command only one such action is expected, or at least I 
would only expect the one.
The actions being, giving up the link to the commit that is the tip of 
the branch; and
making commits unreachable.  (for an expert in git tightly linked 
together, but not for everyone)

Because you already need force, just to give up link to the tip, it is 
not clear that there
might be additional unwanted actions that are enabled with the same "force".
(And the "unreachable commits" do not always happen, which makes it even
more dangerous, as a user may misjudge if it applies to his current case 
/ I started
another mail on that too).

In general the direction of your proposed text is ok for me. But I 
highly doubt that a user
who is new to git, will understand "reachable" without further context.
Maybe
    " As a result some commits may be removed from the reachable part
      of the repository and will be scheduled to be purged (see reflog 
documentation)"

or
    " As a result some commits may no longer be in a reachable part
      of the repository and will be scheduled to be purged (see reflog 
documentation)"

It is the same "reachable" that you used (the reflog can be reached, but 
one usually does not
want the reflog to be the only place from where to access data still needed)
. It adds the word "removed" which most people (regardless of their git 
skill,
or English skills) will recognize.

The intend is, that a new user should clearly take the message, those 
commits will
"go away" (even if they "only" go to the reflog)

> Because "switch -c <new-branch>", unlike "switch <existing-branch>"
> would not have to touch the working tree at all, the only reason why
> the user has to force the operation by using "-C" is to override the
> safety offered by "-c" that protects existing branches from accidental
> overwriting.  Perhaps adding some description on "why" -c prevents
> an existing branch from being overwritten would help reduce the
> confusion better than an additional warning on "-C"?
>
Well, I am not convinced. The "danger" lies in the "-C" (which is why it 
is a "force" command).
So it should be explained there.

It could be explained as "Unlike -c this does not protect your existing 
branch".
But the entire point is, that the user must be aware what happens when a 
branch is
removed (before it is recreated).

However the current documentation only mentions "if |<new-branch>| 
already exists, it will be reset to ".
There is no explanation what "reset" means.
The doc does not even mention, the branch is ..."re-created" or "removed 
and re-created".
Nor does it mention that the newly (re-)created  branch is created 
without any of the commits that it contained.

All of this, is very obvious to you and me. But it's not that obvious 
for new users (who relay on the
docs more than anyone else).

Based on that, another approach to create clarity might be

     Force creating a branch, means that an existing branch of the same 
name is removed.
    And that a new branch is created at the specified <start point>. The 
new branch will not
    necessarily have all the commits of that the existing branch used to 
have.
    It therefore also means that commits from the old existing branch 
may be no longer reachable.

Here I think it can be left at "no longer reachable" as it already has 
been indicated, that the commits may no longer be on that branch.
The "also means" underlines that this is a second potentially unwanted 
effect of this command.


