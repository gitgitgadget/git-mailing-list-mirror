Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758EDC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiALMzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbiALMzg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:55:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A1C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:55:36 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k15so9472635edk.13
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3Os5qGubUHLDmaDxygxTgAYKnTDGEZcrn144Sig2dDQ=;
        b=ZzfIzHQ+idBF/t76cbV0UML8ZIrOtmVmd9NOcuNvjrXzLmB3GX7AByqVd+a4VVy1bG
         tkdJsmpCyVO7WXvsSm3br8tFVXF5JqC4OZAQPCisROXxT9yj3vJEQ8wCwCGlj+iH1Zp5
         xrqglkuwPfsz9IbmSFtuFe67Y9v5bWbJA8ubLQZ2bi93N+pZKd1GAdehxraymRYM6Z51
         lFtoVjx/eQXcTPkh6NNTTtR68HqBjdg9D7G6lMEcI2TADZz6SnYgMiswK/Op8imAmyew
         jcCXZl91+c7k6j6CEg42rNTQjiLkqnvYsdYgMIkh+E1+7Em3OiMnBPBpbVmONSMXJEc4
         1iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3Os5qGubUHLDmaDxygxTgAYKnTDGEZcrn144Sig2dDQ=;
        b=X/fvpBiI5EAlxVYYQVX0Bm8MwEFy3Aq58OnUr450rfA7UWEeiLaMrMRk2o7w2db1+5
         VPN62nLqoHDFcLRUYaOSYsb1UITYZNDrYYrQAnOUTmbXPKUK88oAwktu1IwRYC6XgQtn
         +jREuswq+imRPDv+0I86BuXLr5HRmWRptz56R5rjEscuzSzZamr5uIf74+GDYzuv+5xM
         45dQUxoamvsxD7lbU2jLgoGi8LQA8fgBvGLCTKk2Ar+4CIosAVXQ8nJvgj9lmN/Yu2Hr
         g6pf2aULTr1D4Bc0Hqb6FAjQLZx/gVXp+JPSnwXBHtGXkajqZADJrgEh6/oRX/WTFncf
         FdLw==
X-Gm-Message-State: AOAM532mtGl1X2K4zh7+l877gPn1irHHCf2YMkOjOJVax4hYaxFMFkci
        ZZ7LIQe7sRSkYs2SoVwkddY=
X-Google-Smtp-Source: ABdhPJy0YPDPQhvLacMd9d9o4ujxYQ39d8uiaACRWCBLNoBgw10W7spuAF+0glZxC5k1xxdrzs7ytQ==
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr7421535ejc.715.1641992134631;
        Wed, 12 Jan 2022 04:55:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z16sm772011eji.153.2022.01.12.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:55:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7dA5-000iq9-CQ;
        Wed, 12 Jan 2022 13:55:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] reftable: remove unreachable "return" statements
Date:   Wed, 12 Jan 2022 13:47:40 +0100
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
 <Yd3XpLaZ3qc25PzQ@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yd3XpLaZ3qc25PzQ@nand.local>
Message-ID: <220112.865yqpxge2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 11 2022, Taylor Blau wrote:

> On Tue, Jan 11, 2022 at 05:40:22PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Remove unreachable return statements added in acb533440fc (reftable:
>> implement refname validation, 2021-10-07) and f14bd719349 (reftable:
>> write reftable files, 2021-10-07).
>>
>> This avoids the following warnings on SunCC 12.5 on
>> gcc211.fsffrance.org:
>>
>>     "reftable/refname.c", line 135: warning: statement not reached
>>     "reftable/refname.c", line 135: warning: statement not reached
>
> Interesting. From a cursory reading, I agree with the assessment of
> at least my compiler that these return statements are both unnecessary,
> but...
>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  reftable/refname.c | 1 -
>>  reftable/writer.c  | 1 -
>>  2 files changed, 2 deletions(-)
>>
>> diff --git a/reftable/refname.c b/reftable/refname.c
>> index 95734969324..136001bc2c7 100644
>> --- a/reftable/refname.c
>> +++ b/reftable/refname.c
>> @@ -132,7 +132,6 @@ static int validate_refname(const char *name)
>>  			return REFTABLE_REFNAME_ERROR;
>>  		name =3D next + 1;
>>  	}
>> -	return 0;
>>  }
>
> In this case the loop inside of validate_refname() should always
> terminate the function within the loop body. But removing this return
> statement here relies on the compiler to determine that fact.
>
> I could well imagine on the other end of the spectrum there exists a
> compiler which _doesn't_ make this inference pass, and would complain
> about the opposite thing as you're reporting from SunCC (i.e., that this
> function which returns something other than void does not have a return
> statement outside of the loop).
>
> So in that sense, I disagree with the guidance of SunCC's warning. In
> other words: by quelching this warning under one compiler, are we
> introducing a new warning under a different/less advanced compiler?

I'd think that any compiler who'd warn about this sort of thing at all
would be able to spot constructs like this one, which are basically:

    while (1) {
    	...
        if (x)
        	return;
	...
    }
    return; /* unreachable */

Where the elided code contains no "break", "goto" or other mechanism for
exiting the for-loop.

I.e. GCC and Clang don't bother to note the unreachable code, but I
don't think the reverse will be true, that a compiler will say that a
"return" is missing there. Having a function be just a loop body that
returns an some point is a common pattern.

>>  int validate_ref_record_addition(struct reftable_table tab,
>> diff --git a/reftable/writer.c b/reftable/writer.c
>> index 35c8649c9b7..70a7bf142a2 100644
>> --- a/reftable/writer.c
>> +++ b/reftable/writer.c
>> @@ -39,7 +39,6 @@ writer_reftable_block_stats(struct reftable_writer *w,=
 uint8_t typ)
>>  		return &w->stats.log_stats;
>>  	}
>>  	abort();
>> -	return NULL;
>>  }
>
> Here I'm less skeptical, since it's almost certain that any compiler
> would recognize this call to abort() as terminating the whole program.
> So it should be able to infer that anything after it is unreachable.

That's also correct, but in terms of compiler implementations I'd think
you'd get basic loop flow analysis first, and the annotation of
unreturn-able functions like abort() or a custom die() later.
> ...
