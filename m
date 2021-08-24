Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0DFC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ED16138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhHXVzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbhHXVzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFD5C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d11so47195187eja.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ABxbFZUktIqmhVS8cNOi5RC/tP6oGPhR39d/r+QS2WY=;
        b=Zm/m2Hrc6A5h74kR+jK7Tm6yedgCUJrASH8rqC7iIT31ffocO2Pl8mO9s/il4bkO0i
         w+zmgiTDKWGKFU9IlBLbgOO+OY/x4dLz9m2kflZuToK2wWAwCawHAQ7HqWIXTPSOHesO
         s4zf6rBnuHuIkqQ920rFSt2vCh2Tbdfm+3uzzDL2gc7hhGD35U1HB7A8qgWg8N8ptpYB
         ChejUYedd9EZem2g0mD9a0OyQcGQCZNFiAGcbH532L20sIzbrPi7NYc682uaAV2qsfsa
         8zG1X10YcP9grDMJB7ekmXCv3nh7p7rqFnrakrgVGQWjej8gCVvbt+krKjDLNPrBHsYM
         IQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ABxbFZUktIqmhVS8cNOi5RC/tP6oGPhR39d/r+QS2WY=;
        b=n2ZV85Gz2Q83PiZDhuUa97Gc3ivRTaBXNcCZwkHtdvyNqLxBDb7+zufbNG5DHVb1nL
         fy68EV2AtiMRv6ZFbPOaYj9+BlC1H96qym+7nXOBRGDJzMvITEsurWrCFmgW+8Gk9eBw
         I4hgOYSqmsQrccJhA4brAWgCZ9Gxj8BqqrUQQIx+Z0uupCHpsjnU983xR9mLt5bntSWs
         FAdAFT60O73+xExdTYZKtIdmTZY2cIWwFc2UVTaQNmy1cZZKCEyD74XwgrMgiD0Nq54J
         mQOYCOBTcXC6I3JgUhrwkrVXmdTw8Dl61NAkaFHxYMDa16L/jzM5t8j4f3eV0ty/ztXU
         AQIg==
X-Gm-Message-State: AOAM532KicnV5+9lJr4SwCesp6J1eqxvWIFStthpsO+qMs9s1UhyZGD6
        TRpl28juyS4WeixiyLfMoZ8=
X-Google-Smtp-Source: ABdhPJzL3y+5bsAydU7PqDmxR+1DsLPuBp53Ny8M9F4DceQZ8Basouzby0TciYyDFAoPvGFEaREHKA==
X-Received: by 2002:a17:906:248e:: with SMTP id e14mr832671ejb.343.1629842054741;
        Tue, 24 Aug 2021 14:54:14 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q14sm1777034ejc.93.2021.08.24.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] bundle API: start writing API documentation
Date:   Tue, 24 Aug 2021 23:48:32 +0200
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-1.4-dc8591f6d0b-20210823T110136Z-avarab@gmail.com>
 <1193fbe3-f4f6-d8e7-3730-770d2932655d@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <1193fbe3-f4f6-d8e7-3730-770d2932655d@gmail.com>
Message-ID: <874kbeecfu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, Derrick Stolee wrote:

> On 8/23/2021 7:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> There are no other API docs in bundle.h, but this is at least a
>> start. We'll add a parameter to this function in a subsequent commit,
>> but let's start by documenting it.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  bundle.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>=20
>> diff --git a/bundle.h b/bundle.h
>> index 1927d8cd6a4..84a6df1b65d 100644
>> --- a/bundle.h
>> +++ b/bundle.h
>> @@ -27,6 +27,13 @@ int create_bundle(struct repository *r, const char *p=
ath,
>>  		  int version);
>>  int verify_bundle(struct repository *r, struct bundle_header *header, i=
nt verbose);
>>  #define BUNDLE_VERBOSE 1
>> +
>> +/**
>
> nit: what's the use of the "/**" start to these doc comments?
>
> I see examples in the codebase of both, but we are not consistent even
> within a single file. Here is how I counted instances of each:
>
> $ git grep "^/\\*\\*\$" -- *.h | wc -l
> 266
> $ git grep "^/\\*\$" -- *.h | wc -l
> 775
>
> So we use "/*" three times as often as "/**". Should we attempt to
> be more consistent in the future?

They're not the same thing. "/*\n" is a normal comment, "/**\n" is an
API documentation comment.

Looking around I don't think this was documented in CodingGuidelines,
but see bdfdaa4978d (strbuf.h: integrate api-strbuf.txt documentation,
2015-01-16) and 6afbbdda333 (strbuf.h: unify documentation comments
beginnings, 2015-01-16).

This is commonly supported by various tooling, e.g. in GNU Emacs a "/**"
comment is highlighted differently than a "/*" comment
(font-lock-doc-face v.s. font-lock-comment-face).

So e.g. something_followed_by_open_close_parens() in a comment in C code
will be highlighted as a function name with a "/**" comment, but not
with a "/*" comment. I imagine that the same is true of various other
editors/tooling.
