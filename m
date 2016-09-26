Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663271F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 00:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941240AbcIZAjr (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 20:39:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52175 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941229AbcIZAjq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 20:39:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DF7242907;
        Sun, 25 Sep 2016 20:39:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CIzhQofaAXhrFnOmry0ionj87n0=; b=Jz4PAm
        +zbBIf4IhazjB04TLXO8DhXQb3ZYiDEm79nhCEZGTmBo6g0+HZlZAhBNTU5D7JSF
        PZBGQs3VTqFS8iYWYkigfZ6DEDoniDTwz9K0AV/5J2khWqhiJOti44SDp4eBLeiG
        3y3dINh8TjfdhsT2Dl0HtBV+cjLs/SHeiKi4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wG8VPH/WWGT37m5L2jy3SpaqV2cHoq4P
        Y81w2rsbesdEGUIxir/4JH2nSpITjR22ImpLTpS89iFGC94FRYKRF4W1WrrflBFv
        qfTacjMer+34dEReD/elMDdN5Pz6rPnrDj/xA1p/46gWoSoALjlbOWG5DTw83o42
        xAuO2sOxsKs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83C8F42906;
        Sun, 25 Sep 2016 20:39:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C28B942905;
        Sun, 25 Sep 2016 20:39:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Vegard Nossum" <vegard.nossum@oracle.com>, <git@vger.kernel.org>,
        Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
        "Kevin Bracey" <kevin@bracey.fi>
Subject: Re: [RFC PATCH v2] revision: new rev^-n shorthand for rev^n..rev
References: <20160925085511.12515-1-vegard.nossum@oracle.com>
        <E7D489891E404823BF34F48E7B9E5618@PhilipOakley>
Date:   Sun, 25 Sep 2016 17:39:41 -0700
In-Reply-To: <E7D489891E404823BF34F48E7B9E5618@PhilipOakley> (Philip Oakley's
        message of "Sun, 25 Sep 2016 18:37:42 +0100")
Message-ID: <xmqq7f9zwl2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7BEAD12-8381-11E6-89E2-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Vegard Nossum" <vegard.nossum@oracle.com>
>>I use rev^..rev daily, and I'm surely not the only one.
>
> Not everyone knows the 'trick' and may not use it daily.
>
> Consider stating what it is useful for (e.g. "useful to get the
> commits and all  commits in the branches that were merged into commit"
> - paraphrased from the doc text)
>
>> To save typing
>> (or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
>> we can make rev^- a shorthand for that.
>>
>> The existing syntax rev^! seems like it should do the same, but it
>> doesn't really do the right thing for merge commits (it gives only the
>> merge itself).
>
> .. rather than the commit and those on side branches).
>> As a natural generalisation, we also accept rev^-n where n excludes the
>> nth parent of rev,
>
>> although this is expected to be generally less useful.
>
> Presumptious? for a two parent merge, surely(?) rev^-2 will give you
> what has been going on on the main line while the branch was being
> prepared... compare A^- and A^-2.

All good comments.  It often is a good strategy to avoid subjective
"this is useful" and "this is not useful" assessment, and instead
let the feature itself find its supporters in the reading public.

>> +Parent Exclusion Notation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The '<rev>{caret}-{<n>}', Parent Exclusion Notation::
>> +Shorthand for '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
>> +given. This is typically useful for merge commits where you
>> +can just pass '<commit>{caret}-' to get all the commits in the branch
>
> s/get all the/get the commit and all the/ ?
> It could be misread as a way of selecting just those commits that are
> within the side branch without including the given commit itself.
>
>> +that was merged in merge commit '<commit>'.
>> +
>> Other <rev>{caret} Parent Shorthand Notations
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> Two other shorthands exist, particularly useful for merge commits,

Is it just me that this new thing belongs to this "other shorthand
notations", making the total to three from two?  It really is a
closely related cousin of existing 'r1{caret}!'; instead of
excluding all of its parents, it only excludes the specified one of
its parents.  IOW, this new one is better described as the third
other shorthand in this "Other Notations" section, without creating
a new "Parent Exclusion Notation" section.

>> @@ -316,6 +324,10 @@ Revision Range Summary
>>  <rev2> but exclude those that are reachable from both.  When
>>  either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
>>
>> +'<rev>{caret}-{<n>}', e.g. 'HEAD{caret}, HEAD{caret}-2'::

Huh?  Isn't the first example missing the necessary minus sign?

>> + Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
>> + given.
>> +
>> '<rev>{caret}@', e.g. 'HEAD{caret}@'::
>>   A suffix '{caret}' followed by an at sign is the same as listing
>>   all parents of '<rev>' (meaning, include anything reachable from
>> @@ -339,6 +351,8 @@ spelt out:
>>    C                            I J F C
>>    B..C   = ^B C                C
>>    B...C  = B ^F C              G H D E B C
>> +   B^-    = B^..B
>> +   = B ^B^1              E I J F B

Even though these are order independent, the second line should say

   = ^B^1 B              E I J F B

to be consistent with the expansion of B..C, I would think.  

>> diff --git builtin/rev-parse.c builtin/rev-parse.c
>> index 76cf05e..ad5e6ac 100644
>> --- builtin/rev-parse.c
>> +++ builtin/rev-parse.c
>> @@ -292,6 +292,32 @@ static int try_difference(const char *arg)
>>  return 0;
>> }
>>
>> +static int try_parent_exclusion(const char *arg)
>> +{
>> + int ret = 0;
>> + char *to_rev = NULL;
>> + char *from_rev = NULL;
>> + unsigned char to_sha1[20];
>> + unsigned char from_sha1[20];
>> +
>> + if (parse_parent_exclusion(arg, &to_rev, &from_rev))
>> + goto out;
>> + if (get_sha1_committish(to_rev, to_sha1))
>> + goto out;
>> + if (get_sha1_committish(from_rev, from_sha1))
>> + goto out;
>> +
>> + show_rev(NORMAL, to_sha1, to_rev);
>> + show_rev(REVERSED, from_sha1, from_rev);
>> +
>> + ret = 1;
>> +
>> +out:
>> + free(to_rev);
>> + free(from_rev);
>> + return ret;
>> +}
>> +
>> static int try_parent_shorthands(const char *arg)
>> {
>>  char *dotdot;

I did not expect that this needs an entirely new helper function,
instead of being implemented as a new special case of existing
try_parent_shorthands() function.  You'd need to strstr "^-" and
parse a sequence of digits that follow it, which may want a helper
to make sure you can error out if fed "some^-12thing" saying that
"12thing" is not an integer, extend the existing "parents-only"
thing so that it can represent three cases (i.e. @? !? or -?), and
need a new variable to denote which parent is to be excluded when it
is the '-' kind.  You'd need to temporarily *dotdot = '\0', parse
what is before "^-" and revert *dotdot = '^' like existing helper
function just the same.

Exactly the same comment probably applies to the changes to the
parser in revision.c, I would imagine, but I didn't read it ;-)
