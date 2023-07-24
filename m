Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD21EC0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGXSvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGXSvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 14:51:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D3E10F6
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 11:51:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F392334CC9;
        Mon, 24 Jul 2023 14:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tP6U4eznqqBk
        vM6aIhPMbveBzWUS3C61BKL55ept9uk=; b=nwMMoRjOitpJQCCYO555UycDUuW6
        fTwvOuJTSDMRE7/HhyOvukEgCr+ELcq/cTLEP2ouYvSB/13q4mh/SbDNsdtqJraD
        jsFpLC5MHkmJBOeZr8Gcb+7991IGCOiD4zr9IKkKatehzhy2kq65sX5vILfamyaM
        +3VPJwRt88NCS8g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC9BA34CC8;
        Mon, 24 Jul 2023 14:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7127734CC7;
        Mon, 24 Jul 2023 14:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
        <xmqq351hz5xp.fsf@gitster.g>
        <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
        <xmqq4jlxuiuu.fsf@gitster.g>
        <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
Date:   Mon, 24 Jul 2023 11:51:19 -0700
In-Reply-To: <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 24 Jul 2023 14:29:33 +0200")
Message-ID: <xmqqr0oxnnx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 14356886-2A53-11EE-B727-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 21.07.23 um 22:09 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> -    -D, --no-doubt        begins with 'no-'
>>> +    -D, --[no-]no-doubt   begins with 'no-'
>>
>> Hmph, I really really loved the neat trick to allow "no-doubt"
>> option to be "positivised" by _dropping_ the leading "no-" at around
>> 0f1930c5 (parse-options: allow positivation of options starting,
>> with no-, 2012-02-25).
>
> Yeah, if there is a better way to document A) that the "no-" is optiona=
l
> and B) whether it's present by default, I'm all ears.

Some options take "no-" prefix while some others do not, so
indicating that "this can take negative forms" vs "this do not take
negative forms" by "--[no-]xyzzy" and "--frotz" makes sense.

Yikes.  There are tons of options whose names begin with "no-" and
marked PARSE_OPT_NONEG, so "an option '--no-nitfol' that does not
have the 'no-' part in [brackets] can drop 'no-' to make it
positive" would not fly as a rule/convention.

If we do not mind getting longer, we could say

	-D, --no-doubt, --doubt

and explain in the description that --no-doubt is the same as -D and
--doubt is the default.  It is making the developers responsible for
clarify, which is not very satisfying.

We may not reject "--no-no-doubt" but with the positivization
support, double negation is not something we'd encourage without
feeling embarrassed.

> Hard to say for me -- these are synthetic test cases and I lack context
> to make that decision.  In t0040 (t/helper/test-parse-options.c rather)
> we do have a few PARSE_OPT_NONEG uses already.  In t1502 we need to add
> some...

True.  The test coverage will be hurt if we start futzing with
OPT_NONEG bit "randomly".

>>> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseo=
pt.sh
>>> index dd811b7fb4..0a67e2dd4f 100755
>>> --- a/t/t1502-rev-parse-parseopt.sh
>>> +++ b/t/t1502-rev-parse-parseopt.sh
>>> @@ -64,33 +64,38 @@ test_expect_success 'test --parseopt help output'=
 '
>>>  |
>>>  |    some-command does foo and bar!
>>>  |
>>> -|    -h, --help            show the help
>>> -|    --foo                 some nifty option --foo
>>> -|    --bar ...             some cool option --bar with an argument
>>> -|    -b, --baz             a short and long option
>>> +|    -h, --[no-]help       show the help
>>
>> Indeed it is amusing, but we probably should give PARSE_OPT_NONEG
>> appropriately, instead of changing the expectations, for many of the
>> changes we see here, I think.
>
> ... and --help is the one obvious choice for me, because --no-help is
> not supported, of course.  But we can use some more dedicated tests of
> negation and double-negation.

Yeah.
