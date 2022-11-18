Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9ECC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 07:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiKRHKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKRHKO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 02:10:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57C11A0D
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 23:10:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v17so5877559edc.8
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 23:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BqTGvBcjDkT3Gf/88bReAfWFx5OQ0OhOoH4nzHAhB9g=;
        b=FW8qxJnIdqegiXHtqCeq7rVRI1BSbZRDl/lMl1/xANnkgR/PutWvsdt2zgNZVg5nmf
         6Vd+frpYEl9kWHxSX2mMkjXw9QWSEwfxVWD8Tc3g3uvqaGSlbnFbd6zNOUmP9ZraMJMU
         nyq8GihGILn64CxMZKditH4mZMoq3P6+BjyHZRyJhB27SdAOECdEgcj0vEG7VHJ19mpH
         hwr+/+NSDM9PhbLUEHRqULyj1M9506FiQmRjNuovBB+inALFL8TXpzme0t+XlRaGYCvn
         38zbcj7CPhW/XAk6rSNd/D4HksTRiQiR6myarqTju3VlS4+fAIKghAyUhlGgB7+gFTQ+
         v65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqTGvBcjDkT3Gf/88bReAfWFx5OQ0OhOoH4nzHAhB9g=;
        b=uSKkitlhdyaDHpx8Y/k06n9w2C+eUbP9scHs9jr6uEHiT8wNHR0PpZq7PbXZG7EHb0
         f5IE0Gy0bkm9DNP2FbHMalLC0SUERuz7SCVQ0ufChxyLCTwvmyl9KJwh86rpdGwrYxuT
         xkAQb1AjbLexix+lLT5VODyNSPBGxh3xDxCd9uQQOjFKQCKzx+rv6eFl8vSEgtyIjv1K
         dFZUhH3eS3pYifV7dXYc4GMh1FDo7o/V2/jrnPmqnI2oPeAy2Av92K5G4aYHBjEK20Oo
         ocf3F/HzrN9hq2XFfvRXMzau46GT7LovzB12YWyduHsE1zoV7NDY7QALwws2wOYsbXu/
         m0DQ==
X-Gm-Message-State: ANoB5pmw6Lzi0+OMj8dvBxo02vpQxq+zuUw/ocgpIvnNOkpbPPNLfiTw
        K3W+5JpWDYL3ByueWBk07Gh2Rx9QWfeLqg==
X-Google-Smtp-Source: AA0mqf7Hg7zzK/3kiL5Vx5Ns7RfCjAGlrP1kEfeozpWvuJG8zIATDZ9hcEuoxeIaYeIMuO9M3rROrg==
X-Received: by 2002:a05:6402:104b:b0:461:7d1f:1a7b with SMTP id e11-20020a056402104b00b004617d1f1a7bmr4955231edu.400.1668755411392;
        Thu, 17 Nov 2022 23:10:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b007a4e02e32ffsm1303085ejb.60.2022.11.17.23.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:10:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovvVq-005IPy-1K;
        Fri, 18 Nov 2022 08:10:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] delta-islands: free island-related data after use
Date:   Fri, 18 Nov 2022 02:51:34 +0100
References: <20221116105013.1777440-1-e@80x24.org>
 <221116.861qq2kieu.gmgdl@evledraar.gmail.com>
 <20221117230658.M516129@dcvr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221117230658.M516129@dcvr>
Message-ID: <221118.86zgcog2lp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Eric Wong wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>> On Wed, Nov 16 2022, Eric Wong wrote:
>> >   Memory savings were measured using the following patch which
>> >   relies on a patched LD_PRELOAD-based malloc debugger:
>> >   https://80x24.org/spew/20221116095404.3974691-1-e@80x24.org/raw
>>=20
>> FWIW SANITIZE=3Dleak will find this if you stick a "remote_islands =3D N=
ULL"
>> and run e.g. t5320-delta-islands.sh, but maybe you needed this closer to
>> production.
>>=20
>> Valgrind will also work, but of course be *much* slower.
>
> Yeah, I run that LD_PRELOAD thing in production since it's
> cheap compared to valgrind.
>
>> Perfect shouldn't be the enemy of the good & all that, but in this case
>> it's not too much more effort to just give this data an appropriate
>> lifetime instead of the global, I tried that out for just the "regex"
>> part of this below.
>>=20
>> The free_remote_islands() seems to be similarly alive between
>> "find_island_for_ref" and "deduplicate_islands".
>>=20
>> Your version also works, but the root cause of this sort of thing is
>> these global lifetimes, which sometimes we do for a good reason, but in
>> this case we don't.
>
> Agreed on all points.  Overall, the amount of globals in git has
> long seemed excessive and offputting to me (and likely other
> drive-by hackers).
>
>> diff --git a/delta-islands.c b/delta-islands.c
>> index 26f9e99e1a9..ef86a91059c 100644
>> --- a/delta-islands.c
>> +++ b/delta-islands.c
>> @@ -312,29 +312,41 @@ void resolve_tree_islands(struct repository *r,
>>  	free(todo);
>>  }
>>=20=20
>> -static regex_t *island_regexes;
>> -static unsigned int island_regexes_alloc, island_regexes_nr;
>> +struct island_config_data {
>> +	regex_t *rx;
>> +	size_t nr;
>> +	size_t alloc;
>> +};
>
> I've added kh_str_t *remote_islands and renamed
> s/island_config_data/island_load_data/ in the below version
> to reflect the slightly different scope of remote_islands.
>
>>  static const char *core_island_name;
>>=20=20
>> -static int island_config_callback(const char *k, const char *v, void *c=
b UNUSED)
>> +static void island_config_data_release(struct island_config_data *icd)
>> +{
>> +	for (size_t i =3D 0; i < icd->nr; i++)
>> +		regfree(&icd->rx[i]);
>> +	free(icd->rx);
>> +}
>
> icd =3D> ild since config =3D> load
>
>> +static int island_config_callback(const char *k, const char *v, void *c=
b)
>>  {
>> +	struct island_config_data *data =3D cb;
>> +
>
> data =3D> ild
>
> I don't like the name `data' for a typed variable.

Hah! My thought process when deciding on it was "hrm, what *do* we call
the two variables when we have a void * and turn it into a 'util'?
data? cb? util? ... and which one was which?"

I started grepping, then decided I was wasting too much time on that for
a one-off reply, and just went with the first thing I found. The names
you picked are a lot better :)

> Aside from that, v2 below still frees the regex memory early on
> in the hopes deduplicate_islands() can reuse some of the freed
> regexp memory.
>
> Anyways, here's v2, which seems to work.  I'm still trying to
> figure out SATA errors+resets after replacing a CMOS battery,
> but I really hope this patch isn't the cause.
>
> -----8<-----
> From: Eric Wong <e@80x24.org>
> Subject: [PATCH] delta-islands: free island-related data after use
>
> On my use case involving 771 islands of Linux on kernel.org,
> this reduces memory usage by around 25MB.  The bulk of that
> comes from free_remote_islands, since free_config_regexes only
> saves around 40k.
>
> This memory is saved early in the memory-intensive pack process,
> making it available for the remainder of the long process.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> Co-authored-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

This all looks good to me, thanks a lot for the follow-up.
