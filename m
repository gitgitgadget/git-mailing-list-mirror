Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F38EB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGXUu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGXUu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 16:50:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8FAE74
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 13:50:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29EB51B5C48;
        Mon, 24 Jul 2023 16:50:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jr/qFCBWzotv
        OmbzUC88WKNDVly862evxkYZ3ukMOvI=; b=jw1HeXxZaezIChvYDL8E/Yh/Xa6m
        GvjBuL2d218bpmkWW7fA/ga7HSfBP3nHD236ZRGGOPBwnQ29rYwjestF/kwyMGrg
        O+N9vJ5mae2NsOMc6TFyLE4qlHv82VtCSY1xevJpW7qBLUKlihw/wJpnlQ7lcY9i
        /nR/IAdoinkGg5M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21BE31B5C47;
        Mon, 24 Jul 2023 16:50:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7703C1B5C46;
        Mon, 24 Jul 2023 16:50:20 -0400 (EDT)
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
        <xmqqr0oxnnx4.fsf@gitster.g>
        <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
Date:   Mon, 24 Jul 2023 13:50:19 -0700
In-Reply-To: <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 24 Jul 2023 22:09:36 +0200")
Message-ID: <xmqqh6ptnies.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3FED9F0-2A63-11EE-AF66-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 24.07.23 um 20:51 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Am 21.07.23 um 22:09 schrieb Junio C Hamano:
>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>>
>>>>> -    -D, --no-doubt        begins with 'no-'
>>>>> +    -D, --[no-]no-doubt   begins with 'no-'
>>>>
>>>> Hmph, I really really loved the neat trick to allow "no-doubt"
>>>> option to be "positivised" by _dropping_ the leading "no-" at around
>>>> 0f1930c5 (parse-options: allow positivation of options starting,
>>>> with no-, 2012-02-25).
>>>
>>> Yeah, if there is a better way to document A) that the "no-" is optio=
nal
>>> and B) whether it's present by default, I'm all ears.
>>
>> Some options take "no-" prefix while some others do not, so
>> indicating that "this can take negative forms" vs "this do not take
>> negative forms" by "--[no-]xyzzy" and "--frotz" makes sense.
>>
>> Yikes.  There are tons of options whose names begin with "no-" and
>> marked PARSE_OPT_NONEG, so "an option '--no-nitfol' that does not
>> have the 'no-' part in [brackets] can drop 'no-' to make it
>> positive" would not fly as a rule/convention.
>>
>> If we do not mind getting longer, we could say
>>
>> 	-D, --no-doubt, --doubt
>>
>> and explain in the description that --no-doubt is the same as -D and
>> --doubt is the default.  It is making the developers responsible for
>> clarify, which is not very satisfying.
>
> Adjusting all explanations manually seems quite tedious.
>
>> We may not reject "--no-no-doubt" but with the positivization
>> support, double negation is not something we'd encourage without
>> feeling embarrassed.
>
> Right.  Perhaps --[[no-]no-]doubt?  Looks a bit silly with its nested
> brackets, but it's more correct, because it documents all three accepte=
d
> forms, including the no-less one.

It may look a bit silly but looks very tempting.  Also it is not
much longer than "--[no-]no-doubt".
