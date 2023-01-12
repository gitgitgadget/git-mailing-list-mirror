Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9A6C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjALQXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjALQWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:22:39 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2AD201F
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:19:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw16so34152643ejc.10
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eFHCbCSzgoXCfjQuxa9nTRtGaukoGQHNP4mqKbJQZtY=;
        b=B4u++LlSt/Aa3y/S6Jlreo4Evp1U5O8rJQF7H2KSfozAb1moWAeJtdGmBz6tHPnIcf
         MYwO6blVJZafhD9omSSpcCioJ3S8AmB2fqnO5WD3Iu5u8SifWhKmJ6ZHcQ7s1DdIzx59
         4b271NrW1zF3Bnj9azJO2J1Cku5ZPMXlfFCfISx2+ZeeMhxS4nA8rAnIvu8tcPrFHDDR
         smDwm71zUKikGzl2zsxiIDf/HMQXDtVJ30cWXDjMXAvDHogjb4MEwUMnNbCH+a3+JX6R
         2iX+wFmcdplNCn/QtNBP4xXSTJmagNMdxR3T4EayZa7zvUmlm2WacajlyWJE+IpwhTUh
         gNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFHCbCSzgoXCfjQuxa9nTRtGaukoGQHNP4mqKbJQZtY=;
        b=sl0p1mWhiG6QF+sYP9/+4/JQlNKfAdXV+IU3/Kj9k2f7x4tUnfFpIcUHmqqvDY1gF1
         wG8mAsjtGXxIX3ZRlk3wUZwWRmGdcuzX34J5res9Y3uGDZX5ycrsfg4TUjINK08YosJ9
         ud903axpm6PQMLdjs60TNCpan0kkktg0KRzBwCDKOJ2HtHrQqfW9jfO0zgcwphCvRTXv
         iW76NDNkzq9+y+dmNXF3chC9k3rVf8f/MteMbVpV8x3Clia1HW/iqSe2jU+a8M0c/ame
         zz2Ng3W1pV3FonHwKAX+7zhr1x0YTIabWCoBdgGnlpJ+Q3Fni16onxJaBEoOI4QEPWlm
         rjLw==
X-Gm-Message-State: AFqh2koxLXJiDNZ022HkNQwVhVZm1iLKb23hUKuBiDbj973uiphQqOuK
        Qw6XYnSgB9YF0x4IZT8EtdAaAdOjmHwNaQ==
X-Google-Smtp-Source: AMrXdXsc2qABeZ/xkJEJQQ3kE1aqWtnxnds+v5Jllb1FdzT8D3X8dv53ly5D8ncyAxrQq4HaTetZbQ==
X-Received: by 2002:a17:907:d50e:b0:81f:fc05:2ba0 with SMTP id wb14-20020a170907d50e00b0081ffc052ba0mr67750753ejc.2.1673540380826;
        Thu, 12 Jan 2023 08:19:40 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906101400b0085ff05d5dbdsm2000757ejm.173.2023.01.12.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:19:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pG0Il-000KNF-3D;
        Thu, 12 Jan 2023 17:19:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 5/6] cache API: add a "INDEX_STATE_INIT"
 macro/function, add release_index()
Date:   Thu, 12 Jan 2023 17:19:20 +0100
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
 <patch-v2-5.6-ae256efe94a-20230112T124842Z-avarab@gmail.com>
 <270ef93c-cfdc-d119-5740-f704d7f2a029@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <270ef93c-cfdc-d119-5740-f704d7f2a029@github.com>
Message-ID: <230112.86zganzpwk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Derrick Stolee wrote:

> On 1/12/2023 7:55 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> As we'll see in a subsequent commit we'll get advantages from always
>> initializing the "repo" member of the "struct index_state". To make
>> that easier let's introduce an initialization macro & function.
>>=20
>> The various ad-hoc initialization of the structure can then be changed
>> over to it, and we can remove the various "0" assignments in
>> discard_index() in favor of calling index_state_init() at the end.
>
>> -	memset(&o->result, 0, sizeof(o->result));
>> +	index_state_init(&o->result);
>>  	o->result.initialized =3D 1;
>
> It's interesting that 'struct index_state' has an 'initialized'
> member that we aren't setting in index_state_init(). Perhaps it's
> only being used in special cases like this, and means something
> more specific than "index_state_init() was run"? Or maybe we
> could add it to INDEX_STATE_INIT and drop this line?

It's unrelated, and doing that would be a bug. It's a bit unfortunately
named, a better name might be "read_index_data" or something.

It was added in 913e0e99b6a (unpack_trees(): protect the handcrafted
in-core index from read_cache(), 2008-08-23), which shows the use-case,
i.e. it's for avoiding re-reading the index file itself (or in that
case, to trust our hand-crafted faked-up version of it).

I opted not to mention it in the commit message, after being
sufficiently convinced that it was unrelated, which was probably a
mistake :)

Just as a sanity check, we do have really good test coverage of the
difference, at least 1/2 of the tests I bothered to wait for failed when
I tried this on top:

diff --git a/cache.h b/cache.h
index 4bf14e0bd94..1f8e5f4e823 100644
--- a/cache.h
+++ b/cache.h
@@ -371,6 +371,7 @@ struct index_state {
  * "r" argument to index_state_init() in that case.
  */
 #define INDEX_STATE_INIT(r) { \
+	.initialized =3D 1, \
 	.repo =3D (r), \
 }
 void index_state_init(struct index_state *istate, struct repository *r);
