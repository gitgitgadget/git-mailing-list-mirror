Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA23C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068C5613A9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhFAIK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhFAIK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 04:10:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAA0C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 01:09:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb17so20274219ejc.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=X1Tfhzxf6EUzMPl+3qSzsyIeA238x8ccQmNU6WBW5Bk=;
        b=GNjtcvv0uk3oofxg0KneglKF74TCGF0ndOEbFNL/FGv4xp1EL1L3ePWbnVCcC7X4HZ
         SlbpknqHmyL/W10hudgB+gMGV6/v4mMAbQAhpeS2WavXsmkZBzxza2GeyqvGCd1tqMmP
         iwmM3k436ZlLD650BL5EHsxno6Hb1NFX9PXl+XHydR3EaBqu1GpSBB2FO/ma6O3i6q6n
         0qPUswnpgPoDbk8VdDHh9dXdF3FNdCCFgseFHLQQTvdIQqRE1V7o9/KA8FOfaEgV0adI
         czVJndxCzN7oPAcU4eJ92I7yA4pCFgtcrgE5Dwc56zW0Rn2Z+RkHTnRNXahLjO6bLHPd
         li/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=X1Tfhzxf6EUzMPl+3qSzsyIeA238x8ccQmNU6WBW5Bk=;
        b=tHMbkMvhw9iO3Js0dHinF/WavPB3VVFSTbwv7/PUdtSkzrXu4FlNRxQPxlBxdsghTm
         WKHteusDzctufP29ZoTOdAxsRdWhK3rL+KUMQAEZWx6Zel+TF2xdkz5DtnqeTXSnyg3C
         VbpgpAvNRLZCII4cTUrEE3slbC9T8UsBOgW4CIgeouzrA6colgqcmEi6ZQ5h5eby4eDD
         ei590gbNh1sR8Bj9V4yGtqYzVJRi+f9wKYa4J5zFYXWia4ZUixvNJLbi4DDJ7yHks5pw
         KE7maQGZv3899t33OhT25tmTm9xeyLtOv1e5jesFNEMDiKuDKYYYOXSrmBak/c5wUvTX
         uiEw==
X-Gm-Message-State: AOAM530HjfNdK7lo14YpcugAIwgPS1qWghW2pQkwoELw3uxGBrVqddGa
        Yw9g9/EwGLxY/ARwj4PszO46QS/cx0RnBQ==
X-Google-Smtp-Source: ABdhPJzAHAzdzGG+YZ3cPAMvGcqiBUQ/28Oue4/3HMStsnWujkmgQFJamv/SXyGSTdHYNt/jhC5uBw==
X-Received: by 2002:a17:906:f84:: with SMTP id q4mr28908929ejj.442.1622534953936;
        Tue, 01 Jun 2021 01:09:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cs18sm1501800ejc.123.2021.06.01.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:09:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/fsck.c: don't conflate "int" and "enum" in
 callback
Date:   Tue, 01 Jun 2021 10:04:21 +0200
References: <patch-1.1-f109a61b11-20210601T000433Z-avarab@gmail.com>
 <de9dea3a-6138-5e2f-7dc8-8a2ddf28bb84@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <de9dea3a-6138-5e2f-7dc8-8a2ddf28bb84@kdbg.org>
Message-ID: <87k0ne0zx3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Johannes Sixt wrote:

> Am 01.06.21 um 02:05 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Fix a warning on AIX's xlc compiler that's been emitted since my
>> a1aad71601a (fsck.h: use "enum object_type" instead of "int",
>> 2021-03-28):
>>=20
>>     "builtin/fsck.c", line 805.32: 1506-068 (W) Operation between
>>     types "int(*)(struct object*,enum object_type,void*,struct
>>     fsck_options*)" and "int(*)(struct object*,int,void*,struct
>>     fsck_options*)" is not allowed.
>>=20
>> I.e. it complains about us assigning a function with a prototype "int"
>> where we're expecting "enum object_type". Enums are just ints in C,
>> but it seems xlc is more picky than some about conflating them at the
>> source level.
>
> Is that true? I thought compilers were allowed to use whatever data type
> is sufficient to represent all enumeration values. For this reason, you
> sometimes see
>
>    enum X { A, B, X_MAX =3D 0x7fffffff };
>
> that ensures that an int must be used for representation of enum X. So,
> AFAICS, your patch is an actual fix, not just cosmetic.

	The identifiers in an enumerator list are declared as constants
	that have type int and may appear wherever such are
	permitted. [...] Each enumerated type shall be compatible with
	char,asigned integer type, or an unsigned integer type. The
	choice of type is implementation-defined,110) but shall be
	capable of representing the values of all the members of the
	enumeration [...] Thus, the identifiers of enumeration constants
	declared in the same scope shall all be distinct from each other
	and from other identifiers declared in ordinary declarators

	--C99, 6.7.2.2 @
          http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf

My reading of that is that mixing the two (which we indeed, do all over
the place) is guaranteed to work, we've got plenty of places where
e.g. enum object_type is passed to something else as an "int".

This xlc warning in particular probably has nothing per-se to do with
enum v.s. int, but just that it's complaining that a function pointer
doesn't have exactly the expected type.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>=20
>> This is new in v2.32.0, so sending this during the rc phase, just a
>> warning though, so unless you're using fatal warnings on that
>> OS/platform it won't impact anything, and even then it's just a minor
>> annoyance...
>>=20
>>  builtin/fsck.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/builtin/fsck.c b/builtin/fsck.c
>> index 87a99b0108..b42b6fe21f 100644
>> --- a/builtin/fsck.c
>> +++ b/builtin/fsck.c
>> @@ -109,7 +109,8 @@ static int fsck_error_func(struct fsck_options *o,
>>=20=20
>>  static struct object_array pending;
>>=20=20
>> -static int mark_object(struct object *obj, int type, void *data, struct=
 fsck_options *options)
>> +static int mark_object(struct object *obj, enum object_type type,
>> +		       void *data, struct fsck_options *options)
>>  {
>>  	struct object *parent =3D data;
>>=20=20
>>=20

