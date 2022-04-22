Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1AFC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 08:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384513AbiDVI2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiDVI2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 04:28:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20BF286E2
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 01:25:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g18so14868683ejc.10
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=edR2cTtVzDlEHtwY3nwmYZjcxQOZm8pboa14K+nQWtU=;
        b=Hgvwf//ESN8+u3F96seGJHv1S4xL+71GGxXcvPIeapFmUlOIowhj1lesd7MMjKfhdD
         vcsOyFLzpsFNrPHYE0B/boyA88sBO9nx4ifG4wBu+KIy4BjGT4pXbuObCsGJEo79VhIP
         J3yFLe7ayDgnjL1Htk1yEpLkz4H1gyPNwuh3SZ272/wFXnOFTxMTbbp5UhxkmRn/S969
         26ABxfsY810At4acSI4qemHF5TIQRPPc+GOzfEe0if0foDbwbkOR+l716Cj8s6OKoeFS
         Cb+md75A9jH5cElcDhTa2Ew2q/UrhfOymHe8ednhwCiKDhTXoCXs7hEPRzXXmgOmGxL+
         1hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=edR2cTtVzDlEHtwY3nwmYZjcxQOZm8pboa14K+nQWtU=;
        b=ohYHsZVWZh4VT85ayd54DV6OiRZD9WsgZy2MPfHGuOHkwNq8Dgl2gzD8fiG2n2NSuR
         gM4lbzsISg/6+5s/iRG5uVNvvplep+og6SYt+G2DgzEOkUFbKUNJ8WT3JgAL5nPA7Ezq
         rjqmPXKfSzPXxhTmvmwFIrmhDCy+aXuXtMm86awolAOxfk0UBM8UvhVS6s46MFJI+6eg
         PL9bA49PyYQE+RQZgCtuWHZCgBam3Mr/Da8HD0eNfRpKLfxcwdEIvyaahWCgV3yPwi1K
         6q0juNPWH02bzhQEvULD1om4yEBrnub8f6e0A8AJiI8Ed8ZVQmbCAKA8NEgw0Qi4ivod
         9csw==
X-Gm-Message-State: AOAM53216DUBAPQirUYDI3oeIdR009NswxhJjf35mO0t3AlmMTRzFvmK
        y9ROar1NXJqqMfRjPLAGkjaFQO+Kb46DpQ==
X-Google-Smtp-Source: ABdhPJwbecZkXdOmfb162P7tmrebwkCNQ18JE5Nf8nVGrZWDfTdmH6wVWAOrLevXumm6g4VoC7je6A==
X-Received: by 2002:a17:906:58ce:b0:6da:b548:1bbb with SMTP id e14-20020a17090658ce00b006dab5481bbbmr3145892ejs.14.1650615917106;
        Fri, 22 Apr 2022 01:25:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bl20-20020a170906c25400b006efeef97b1esm506858ejb.206.2022.04.22.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 01:25:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhobL-008bFp-TN;
        Fri, 22 Apr 2022 10:25:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH 4/4] object-file: fix a unpack_loose_header() regression
 in 3b6a8db3b03
Date:   Fri, 22 Apr 2022 10:21:50 +0200
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
 <patch-4.4-7698c0f11a8-20220421T200733Z-avarab@gmail.com>
 <xmqqa6cedpt3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqa6cedpt3.fsf@gitster.g>
Message-ID: <220422.86levx5xuc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
>> -				NULL) < 0) {
>> +	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
>> +				    NULL)) {
>> +	case ULHR_OK:
>> +		break;
>> +	case ULHR_BAD:
>> +	case ULHR_TOO_LONG:
>>  		error(_("unable to unpack header of %s"), path);
>>  		goto out;
>>  	}
>
> Sigh, well spotted.  This is why I hate the application of "enum is
> better, let's rewrite the 'negative is error, 0 is good' with it"
> and other dogmatic "clean-up" that touch everywhere in the codebase.

While this is squarely my fault, I'm FWIW not as dogmatic on that point
as you think. I initially made a new error state a -2, and got feedback
on the series that that was too magical, then ended up turning it into
an enum and missed this callsite.

I think it's less that enums are bad in this case, as it's probably
sensible to consistently use negative values for error states.

> Now because it is ULHR_OK or everything else that is an error, I think
> the fix should be
>
> 	if (unpack_loose_header(...) !=3D ULHR_OK) {
> 		error(...);
> 		goto out;
> 	}
>
> It would also be much closer in spirit to the original code before
> the "enum" change broke it.

We have two other callers of the API using the exhaustive enumeration
pattern, so by doing this we'd have the compiler miss this callsite if
another label is added.

It could be refactored etc., but I think this change as-is is the most
minimal & least invasive. I.e. it just adjusts this one caller to match
the other ones, we could also refactor the interface & pattern we use to
call it.

But if we're doing that I don't see the benefit of doing it for just one
caller, and if we're doing it for all of them surely that's better as
some follow-up cleanup...
