Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12055C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D399364E2B
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBLTw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:52:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56292 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBLTwz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 14:52:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE3C4ACBF4;
        Fri, 12 Feb 2021 14:52:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ISUiVQcVdn1p
        51eXptoYHYu/3KA=; b=mlM+8QBOR9J43nQKIxJLQ3JTL2ph8FEMP/RDsBkF5xpP
        qMQQkuVEzBQXMRSI8ECvDR3XgJXwsyQ2THBIJqemOyPPqIVxIiDJq+vmEZCV6kwL
        iYDK/yzHS2xWpETq6gbP2J+jFtewVEx7ZxpLeLPH4Ihz7nEWhembEkR7b8X8VXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=E+bcX2
        rHmQkJ/CG/XGsfbgCm9YYbPpKYNf6Xus6n0GxBDDW+idb1aBUYecWqxSF4NUVgvp
        mKwj9p5xfZ54bt4FlSCayzARLrL6oB59AhyaIoONm6VJYc4SlUtNMWIq2KkC68ez
        h62czSejN/MFwlZXTjZ8yidafmnZtQ0bV6XMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E503FACBF3;
        Fri, 12 Feb 2021 14:52:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BD6FACBF2;
        Fri, 12 Feb 2021 14:52:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrew Klotz via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Andrew Klotz <agc.klotz@gmail.com>
Subject: Re: [PATCH v3] config: improve error message for boolean config
References: <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
        <pull.841.v3.git.git.1613075454274.gitgitgadget@gmail.com>
        <YCZarBDX2E3U0OXU@coredump.intra.peff.net>
Date:   Fri, 12 Feb 2021 11:52:08 -0800
In-Reply-To: <YCZarBDX2E3U0OXU@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 12 Feb 2021 05:38:36 -0500")
Message-ID: <xmqqtuqhukrb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CAB339DC-6D6B-11EB-9FDD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks, all the changes here look good to me except for one curiosity:
>
>> diff --git a/config.c b/config.c
>> index b922b4f28572..f90b633dba21 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1180,6 +1180,20 @@ static void die_bad_number(const char *name, co=
nst char *value)
>>  	}
>>  }
>> =20
>> +NORETURN
>> +static void die_bad_bool(const char *name, const char *value)
>> +{
>> +	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
>> +		/*
>> +		 * We explicitly *don't* use _() here since it would
>> +		 * cause an infinite loop with _() needing to call
>> +		 * use_gettext_poison().
>> +		 */
>> +		die("bad boolean config value '%s' for '%s'", value, name);
>> +	else
>> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
>> +}
>
> ...if this is rebased on the current master that does not have
> GIT_TEST_GETTEXT_POISON anymore, then I think this whole function can b=
e
> simplified down to the final line.
>
> Since it looks like Junio applied this on top of v2.30.1, which still
> has GETTEXT_POISON, we need it here. But we should remember to remove i=
t
> with the rest of the GETTEXT_POISON once it's all merged together.

Thanks for being extra careful.  I sort-of considered that this was
a bugfix and that was why it is made mergeable down to the maint
track, but I do not mind making this one of the "incentives" to
upgrade for our users ;-)

I actually suspect that without any of us worrying about it, =C3=86var
will take care of the cleaning up when the dust settles.

Thanks.
