Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A8DC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDBE20814
	for <git@archiver.kernel.org>; Fri, 29 May 2020 11:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgE2LlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 07:41:06 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:18306 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2LlG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 07:41:06 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jedNm-0005o5-A1; Fri, 29 May 2020 12:41:03 +0100
Subject: Re: [PATCH 1/2] doc: fixup/squash: clarify use of <oid-hash> in
 subject line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email>
 <20200525213632.1626-1-philipoakley@iee.email>
 <20200525213632.1626-2-philipoakley@iee.email>
 <xmqqmu5tl1qa.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <a2ef3923-f3d5-d0cc-61b2-326adaf4ef6b@iee.email>
Date:   Fri, 29 May 2020 12:41:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqmu5tl1qa.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/2020 18:35, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> The use of ellision `...` isn't great, as it gives no hint or clue,
>> leaving the subsequent test with a difficult explanation.
> True.  If you are planning to correct it in 2/2, then I think it
> makes more sense to squash that in to have a single patch.
OK
>> Clarify if a full oid has is required, or a unique abbreviation within
>> the respository, or just uniques within the rebase instruction?
> Puzzled.  You must know the answer to "do we need a full object
> name, or is it sufficient to have anything that gives us a unique
> commit object name?" so why not write it in the patch instead of
> asking the question here?  Or do you not know the answer and this is
> a RFC/WIP patch????
This was a left over note about deeper questions outside of this patch
series.
>
>> This is a minimal change that sidesteps the chance to rewrite/clarify
>> the potential wider confusions over specifying the <commit> being
>> referred to in the fixup/squash process.
> Hmph.  So this step cannot be reviewed to judge if it is a good
> change by itself?

I was working on 'small incremental steps' here.
>
> Let me locally recreate a squashed single patch and review _that_
> instead.
>
>>  Documentation/git-rebase.txt | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 4624cfd288..462cb4c52c 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -571,16 +571,18 @@ See also INCOMPATIBLE OPTIONS below.
>>  
>>  --autosquash::
>>  --no-autosquash::
>> -	When the commit log message begins with "squash! ..." (or
>> -	"fixup! ..."), and there is already a commit in the todo list that
>> -	matches the same `...`, automatically modify the todo list of rebase
>> +	When the commit log message begins with "squash! <line>" (or
>> +	"fixup! <line>"), and there is already a commit in the todo list that
>> +	matches the same `<line>`, automatically modify the todo list of rebase
>>  	-i so that the commit marked for squashing comes right after the
>>  	commit to be modified, and change the action of the moved commit
>> +	from `pick` to `squash` (or `fixup`).
>> ++
>> +A commit matches the `<line>` if
>> +the commit subject matches, or if the `<line>` refers to the commit's
>> +hash. As a fall-back, partial matches of the commit subject work,
>> +too.  The recommended way to create fixup/squash commits is by using
>> +the `--fixup`/`--squash` options of linkgit:git-commit[1].
>>  +
> Overall it looks much better than the original.
>
> The original did not even attempt to define what is a "match" for
> the purpose of this option, so the ellipses may have been OK, but
> once we need to refer to what is there, we need a name to refer to
> it and ellipses no longer are sufficient, and using the step 1/2
> alone would not make any sense.  We definitely should take the step
> 2/2 together with it.
I'd taken the idea of being able to name the thing as step 1, to get
past the Newspeak problem.
>
> "A commit matches the <line> if the commit subject matches" is not a
> great definition of what a "match" is, though.  The readers are left
> in the same darkness about what constitutes a "match" of <line>
> against "the commit subject".  If you define this "subject matches"
> as a substring match, for example, you do not even have to say "as a
> fall-back"---it is by (the updated version of your) definition that
> how the commit subject and <line> matches so there is no need to
> allow any fall-back involved.
The fall back does include the commit hash, and (not yet in this series)
is the extra information that Dscho provided at [1], so it's not a
simple substring match, nor partial string match.
Part of this reader confusion comes out of the `commit --fixup` option
that effectively directs the reader away from using a hash, to using the
target's full commit message for the fixup! line.

At this stage, the aim is to make the option for the use of the commit
hash a bit more visible within the text. Even after many years of
reading, it still didn't stand out in the old 'wall of text', hence the
all important paragraph break

I'll combine the two patches at this stage.

Philip

[1]
https://public-inbox.org/git/nycvar.QRO.7.76.6.2005180522230.55@tvgsbejvaqbjf.bet/    
"It's even worse"
