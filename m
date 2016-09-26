Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A827207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965099AbcIZOp5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 10:45:57 -0400
Received: from a1i216.smtp2go.com ([43.228.184.216]:44405 "EHLO
        a1i216.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbcIZOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 10:45:56 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Sep 2016 10:45:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpcorp.com; s=a0-2; h=Feedback-ID:X-Smtpcorp-Track:Date:Subject:To:From:
        Reply-To:Message-ID:List-Unsubscribe;
        bh=os/ZwIqXTFmUTTJ2eR7EzPSmSF65pWsdSi498N4RrN4=; b=4AtnDYK2ONk7ubfpbC93Mq526O
        MMw3II/hDOsRUaflS0Bj/feqDsJAT98HLMPPfEIFlxUVXncXM2IL08r2HbH3khIEy5qNvdybBx+Nl
        K2kzlqAv6qKgay4SngJEQL2gF89lG34S822IKM3pK8SobyteGd5G0G0Djk4NZMJXg6cgubwRxdvah
        1goohid2ew/w2i6i0ryMF3M850/mfXRK6GjJRtwx9ej2k1zTKyt2dVgFkP+9qUmeA9GAXtPNT4fkG
        m+0Q1261HRAsKM6ZYaO45Hzprmun0nAx7q+ZrW+VI0cvgJo25l9qIIsXCYsNA5qxQkeZbu1uqjNo5
        5Y9Ic/bQ==;
Message-ID: <1173701ACA474229ABC1A14468682474@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Vegard Nossum" <vegard.nossum@oracle.com>
Cc:     <git@vger.kernel.org>,
        =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
        "Kevin Bracey" <kevin@bracey.fi>
References: <20160925085511.12515-1-vegard.nossum@oracle.com><E7D489891E404823BF34F48E7B9E5618@PhilipOakley> <xmqq7f9zwl2q.fsf@gitster.mtv.corp.google.com>
Subject: Re: [RFC PATCH v2] revision: new rev^-n shorthand for rev^n..rev
Date:   Mon, 26 Sep 2016 14:00:04 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1Pob3q9EFOHYQL.6RuRlgA_b
Feedback-ID: 66524m:66524aMf6O2Y:66524sJeyYz1TXv:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Vegard Nossum" <vegard.nossum@oracle.com>
>>>I use rev^..rev daily, and I'm surely not the only one.
>>
>> Not everyone knows the 'trick' and may not use it daily.
>>
>> Consider stating what it is useful for (e.g. "useful to get the
>> commits and all  commits in the branches that were merged into commit"
>> - paraphrased from the doc text)
>>
>>> To save typing
>>> (or copy-pasting, if the rev is long -- like a full SHA-1 or branch 
>>> name)
>>> we can make rev^- a shorthand for that.
>>>
>>> The existing syntax rev^! seems like it should do the same, but it
>>> doesn't really do the right thing for merge commits (it gives only the
>>> merge itself).
>>
>> .. rather than the commit and those on side branches).
>>> As a natural generalisation, we also accept rev^-n where n excludes the
>>> nth parent of rev,
>>
>>> although this is expected to be generally less useful.
>>
>> Presumptious? for a two parent merge, surely(?) rev^-2 will give you
>> what has been going on on the main line while the branch was being
>> prepared... compare A^- and A^-2.
>
> All good comments.  It often is a good strategy to avoid subjective
> "this is useful" and "this is not useful" assessment, and instead
> let the feature itself find its supporters in the reading public.
>
>>> +Parent Exclusion Notation
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +The '<rev>{caret}-{<n>}', Parent Exclusion Notation::
>>> +Shorthand for '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
>>> +given. This is typically useful for merge commits where you
>>> +can just pass '<commit>{caret}-' to get all the commits in the branch
>>
>> s/get all the/get the commit and all the/ ?
>> It could be misread as a way of selecting just those commits that are
>> within the side branch without including the given commit itself.
>>
>>> +that was merged in merge commit '<commit>'.
>>> +
>>> Other <rev>{caret} Parent Shorthand Notations
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> Two other shorthands exist, particularly useful for merge commits,
>
> Is it just me that this new thing belongs to this "other shorthand
> notations", making the total to three from two?  It really is a
> closely related cousin of existing 'r1{caret}!'; instead of
> excluding all of its parents, it only excludes the specified one of
> its parents.  IOW, this new one is better described as the third
> other shorthand in this "Other Notations" section, without creating
> a new "Parent Exclusion Notation" section.
>
True. It probably should be there.

>>> @@ -316,6 +324,10 @@ Revision Range Summary
>>>  <rev2> but exclude those that are reachable from both.  When
>>>  either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
>>>
>>> +'<rev>{caret}-{<n>}', e.g. 'HEAD{caret}, HEAD{caret}-2'::
>
> Huh?  Isn't the first example missing the necessary minus sign?
>
>>> + Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
>>> + given.
>>> +
>>> '<rev>{caret}@', e.g. 'HEAD{caret}@'::
>>>   A suffix '{caret}' followed by an at sign is the same as listing
>>>   all parents of '<rev>' (meaning, include anything reachable from
>>> @@ -339,6 +351,8 @@ spelt out:
>>>    C                            I J F C
>>>    B..C   = ^B C                C
>>>    B...C  = B ^F C              G H D E B C
>>> +   B^-    = B^..B
>>> +   = B ^B^1              E I J F B
>
> Even though these are order independent, the second line should say
>
>   = ^B^1 B              E I J F B
>
> to be consistent with the expansion of B..C, I would think.

Agreed.
>
>>> diff --git builtin/rev-parse.c builtin/rev-parse.c
>>> index 76cf05e..ad5e6ac 100644
>>> --- builtin/rev-parse.c
>>> +++ builtin/rev-parse.c
>>> @@ -292,6 +292,32 @@ static int try_difference(const char *arg)
>>>  return 0;
>>> }
>>>
>>> +static int try_parent_exclusion(const char *arg)
>>> +{
>>> + int ret = 0;
>>> + char *to_rev = NULL;
>>> + char *from_rev = NULL;
>>> + unsigned char to_sha1[20];
>>> + unsigned char from_sha1[20];
>>> +
>>> + if (parse_parent_exclusion(arg, &to_rev, &from_rev))
>>> + goto out;
>>> + if (get_sha1_committish(to_rev, to_sha1))
>>> + goto out;
>>> + if (get_sha1_committish(from_rev, from_sha1))
>>> + goto out;
>>> +
>>> + show_rev(NORMAL, to_sha1, to_rev);
>>> + show_rev(REVERSED, from_sha1, from_rev);
>>> +
>>> + ret = 1;
>>> +
>>> +out:
>>> + free(to_rev);
>>> + free(from_rev);
>>> + return ret;
>>> +}
>>> +
>>> static int try_parent_shorthands(const char *arg)
>>> {
>>>  char *dotdot;
>
> I did not expect that this needs an entirely new helper function,
> instead of being implemented as a new special case of existing
> try_parent_shorthands() function.  You'd need to strstr "^-" and
> parse a sequence of digits that follow it, which may want a helper
> to make sure you can error out if fed "some^-12thing" saying that
> "12thing" is not an integer, extend the existing "parents-only"
> thing so that it can represent three cases (i.e. @? !? or -?), and
> need a new variable to denote which parent is to be excluded when it
> is the '-' kind.  You'd need to temporarily *dotdot = '\0', parse
> what is before "^-" and revert *dotdot = '^' like existing helper
> function just the same.
>
> Exactly the same comment probably applies to the changes to the
> parser in revision.c, I would imagine, but I didn't read it ;-)

Sounds sensible. I hadn't double checked Vegard's implementation at this 
point.
--
Philip
> 

