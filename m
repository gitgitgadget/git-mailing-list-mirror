Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D68FC433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 16:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357695AbiDLQfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357699AbiDLQfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 12:35:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079865E745
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 09:32:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96F03190DBA;
        Tue, 12 Apr 2022 12:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=svBHE1uUzFKV
        CxiF+LnAJwHQLLd3iUBTK/6u6dNRXkE=; b=eU6JBq11RXo+yJIlOH5CjP8NhPgm
        NarytfO7fN0k/xnKwCBwY0ipKR59+CcUx/qbWbZuhE3DnIPCW0cHkazX90H4zK1z
        EvyUZi4SasaAh7ifalRn1pGJRfClvPYfLZ50W0hbpA2n04Wo2o+T4myEn+16bCOh
        BFU9Soyo3U1rk/s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F684190DB9;
        Tue, 12 Apr 2022 12:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC35A190DB4;
        Tue, 12 Apr 2022 12:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Julien Palard <julien@palard.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] Make a colon translatable
References: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
        <xmqq5ynfh101.fsf@gitster.g>
        <220412.86tuayhga7.gmgdl@evledraar.gmail.com>
Date:   Tue, 12 Apr 2022 09:32:53 -0700
In-Reply-To: <220412.86tuayhga7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 12 Apr 2022 10:03:48 +0200")
Message-ID: <xmqq35iicle2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 344E4F5C-BA7E-11EC-844D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -248,7 +248,7 @@ static void wt_longstatus_print_other_header(stru=
ct wt_status *s,
>>>  					     const char *how)
>>>  {
>>>  	const char *c =3D color(WT_STATUS_HEADER, s);
>>> -	status_printf_ln(s, c, "%s:", what);
>>> +	status_printf_ln(s, c, "%s", what);
>>
>> I.e. this one is better handled by
>>
>> 	status_printf_ln(s, c, _("%s:"), what);
>>
>> as _(...) in C-locale is original-language centric, where we want
>> the label to be <phrase> immediately followed by a colon.  And that
>> allows French translation to have nbsp before the colon.
>
> In this case I think the change as suggested is better, translators get
> zero context from "%s:", whereas "Untracked files:" being status output
> is immediately obvious.

It is unclear if you read the original (and discussion so far).

I understand that Julien wants to turn "%s:" to have nonbreaking
whitespace before the colon.  It does not matter what label we are
using (it can be "Ignored files").  I took it that the patch is
addressing "git status" output but the general thrust is in Julien's
translation, all "label-string followed by colon" should become "the
string followed by nonbreaking whitespace followed by colon".

Moving the colon to the label string is backwards, isn't it?  If the
presentation form accepted in the C-locale, i.e. "%s:", needs to be
localized in Julien's translation to "%s :", shouldn't the "%s:"
that defines the presentation be what is marked for translation?

> His commit message also doesn't mention it, but for existing "headings"
> we already do this, e.g.:
>
>     status_printf_ln(s, c, _("Changes to be committed:"));
>     status_printf_ln(s, c, _("Changes not staged for commit:"));

That's another arugment to translate _("%s:") once for the language,
I would think.
