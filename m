Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5CC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiCGOLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiCGOLO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:11:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832156E4CD
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:10:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw13so32104905ejc.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9ULoK2m9wh5xLXBQezm8qQQGuNpWDNaUHY8UVClwCvg=;
        b=XvpSk7NqgQlPx2WkofxJtQq0NJRzqupf4dIU3/oDeRDxeeXMBpeNXztyGKhEM6BV8R
         uU6unJaX4d60jwPMOF85Tsp3y5P8Fb3N3XxRMtnHpe8RnOn7nbIsO7ZAt/UG+4tAIM/0
         NeGHTM4pxsvcNhWTaokkanMjHlgieL4CXJz3CKO4fRYezD1OHtU0DDtICS++jRw/e6yo
         /3Oh1aesO0xavaJ13yBEl4nTPUPhGn4I28ZMym48JkP6rdDkpZ4sY2Ck+C9sTHVVgd0/
         2OfigCVDTC4FtYIvM+N4VAIsBNUZ8NVW/onhzqrHvR6Azk58t8P7kGAmExRMpkzQvxZH
         eJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9ULoK2m9wh5xLXBQezm8qQQGuNpWDNaUHY8UVClwCvg=;
        b=O9r+oooDeIDorGeiJb6dC9hPpKWd/l1VK+yVlDm5T+UV6MOeK92F7Zzx51klPUjR3e
         xqI2PLKBb0Mxa7kPNdv0bQcjpsFjASVdACb3csQMth4LhTFG+Tq2bNorPFiv2RZsrNHJ
         HLJ0/H9a1pLh8jdjqAVfZ1vwzghK7Iu4JbiGq+NtMh0S3cFFtPxYTdjXGbxrHOQ217te
         /sRj6LGMT4VGJPxMypYSYdKusMFGwhsOVn/ln2NE8/B2pV/4msrUZlWxxGOuzXS3Y9Wu
         FT3HG88luZS6RPr0b6hnTtQhlfh+52lOclBY7vgv1mpN9HuAgGHlQLyu3GzOpMc4Mlm4
         IPDA==
X-Gm-Message-State: AOAM533hRyR8SLTTujAviuZSPpy/oVVb4+7EyZTo7BsYK7MHyTjpNY4u
        ZEkyyj/COyrrngaF67ce54c=
X-Google-Smtp-Source: ABdhPJx+BlTcQULkVKAJUbviNa7Uc6GXrL17D9GdxlBXANTMMykbs+im/PdJZhQxFaOAR+hCtbSnfg==
X-Received: by 2002:a17:906:4e8a:b0:6da:a1df:98fe with SMTP id v10-20020a1709064e8a00b006daa1df98femr9278767eju.66.1646662217031;
        Mon, 07 Mar 2022 06:10:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm4734811ejm.103.2022.03.07.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:10:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRE3z-001Wag-7c;
        Mon, 07 Mar 2022 15:10:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] gettext API users: correct use of casts for Q_()
Date:   Mon, 07 Mar 2022 14:54:51 +0100
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
 <patch-1.2-83659fbc459-20220307T113707Z-avarab@gmail.com>
 <a34c37c0-b6fd-9f4f-e990-9869f375937e@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <a34c37c0-b6fd-9f4f-e990-9869f375937e@github.com>
Message-ID: <220307.86wnh5zwe0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Derrick Stolee wrote:

> On 3/7/2022 6:38 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change users of the inline gettext.h Q_() function to cast its
>> argument to "unsigned long" instead of "int" or "unsigned int".
>>=20
>> The ngettext() function (which Q_() resolves to) takes an "unsigned
>> long int", and so does our Q_() wrapper for it, see 0c9ea33b90f (i18n:
>> add stub Q_() wrapper for ngettext, 2011-03-09).
>>=20
>> In a subsequent commit we'll be making more use of this pattern of:
>>=20
>>     func(Q_(..%"PRIuMAX..., (unsigned long)x), (uintmax_t)x);
>>=20
>> By making this change we ensure that this case isn't the odd one out
>> in that post-image.
>
>
>>  	if (!res)
>> -		printf(Q_("updated %d path\n",
>> -			  "updated %d paths\n", count), (int)count);
>> +		printf(Q_("updated %"PRIuMAX" path\n",
>> +			  "updated %"PRIuMAX" paths\n", (unsigned long)count),
>> +		       (uintmax_t)count);
>
> Why are we adding more uses of "unsigned long" which is not consistent
> in its size across 64-bit Linux and 64-bit Windows? Specifically, on
> Windows "unsigned long" is _not_ uintmax_t. Shouldn't we be using
> uintmax_t everywhere instead?

Whatever we do with "unsigned long" v.s. "size_t" or "uintmax_t" here
we'll need to call the ngettext() function, which takes "unsigned long".

Since you're quoting the part of the commit message that's explaining
that I'm not sure if you're meaning this as a suggestion that the
explanation should be clearer/more explicit, or just missed that
ngettext() isn't ours...

I did wonder if we should just skip the casts here and instead do:
=09
	diff --git a/gettext.h b/gettext.h
	index d209911ebb8..095bf6b0e5e 100644
	--- a/gettext.h
	+++ b/gettext.h
	@@ -49,8 +49,10 @@ static inline FORMAT_PRESERVING(1) const char *_(const =
char *msgid)
	 }
=09=20
	 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
	-const char *Q_(const char *msgid, const char *plu, unsigned long n)
	+const char *Q_(const char *msgid, const char *plu, size_t n)
	 {
	+	if (n > ULONG_MAX)
	+		n =3D ULONG_MAX;
	 	return ngettext(msgid, plu, n);
	 }

Which I suppose would be more correct than a cast, but the edge case
where we'd need that ULONG_MAX is so obscure that I don't think it's
worth worrying about it.

I think for this series it probably makes more sense to drop the casts
for the "n" argument entirely, what do you think?
