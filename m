Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630CCC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 08:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6EF613A6
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 08:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbhI2IwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbhI2IwL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 04:52:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A1CC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 01:50:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dj4so5785284edb.5
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 01:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=x1u0VsqQhFbD4fJnKfQ045PWdSnYqy7653VwvFGNEi8=;
        b=Qmt2+S+DRPAPgVUWPcXPzNAfIN7NTBaWv2k83+bOTOP8+xss6jIifJ1pqtRhgmEC9K
         CYt8hOXjQkeiqL96+BcHcwdWNIMK4xO9u6vWbyqsg48zINekVHLggPisPJ8FTrLFS+x4
         uEyaWQq2od5Tm9XO5jKoFu0u1jpCn3EXbASNGMfmlUhHcPhJ5dyuvlWWi4b+Lwy6Etr8
         gtjT15fvEVL6bkxF1hbvRQRAHB+kN++76qHJfQ0WyAPX4yQCCgsG5r1xTUfF6kNqiXTQ
         lK1IkyBXgiq2W0l7utfT2tAJeqS54y2rmewQKQu1zOK8o9Y+JKCAXB2Xtz8ggQ97xk3e
         rLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=x1u0VsqQhFbD4fJnKfQ045PWdSnYqy7653VwvFGNEi8=;
        b=zDgJVnfZWm3KUmvt0rqsQcQNDZpY0CvCsaItsgi6HAVUdViZg1+Owd6RZfOU0uI8qN
         U3sFmyOTXAfS8V9qpwpauG/RZNIg5vgNJujKN2JaF4AdAhmA7r/WTxFDwcXAkjzJgEqY
         iFW7CVowENp7actu1uwQwpg+Os4vnJx7TmGjRkOo6HoYprW7Ffx47MNHqrdqo6ON8qVD
         mjYs5AsxEIFap96nLvL4YsYdhR//byXBWxtFqxglz32TthLOuFoXvpJkxpr1hjuyvqkG
         Q4BnpWt8GgQZ8PhahdTzDLDxYnw5VeHHMsLB0cwQcAWeyh9R8qf4IpVyj2FUeU6RGXsA
         kx1A==
X-Gm-Message-State: AOAM530L0j6GsvhYAIT9p0ik/exvXoVLnoiiWaLsFAVV4aD/ka8heOMO
        hc/JigGODsVf1Vslys/wzTxGKwgs7Mjo6w==
X-Google-Smtp-Source: ABdhPJxXDfxljoZicm2zNKwihU/4q0sI8CvpECJD8Qo9NaU9wYTg+z0/20gPEYA4P8xOdWnEbWrkMw==
X-Received: by 2002:a17:906:289b:: with SMTP id o27mr12561403ejd.252.1632905428036;
        Wed, 29 Sep 2021 01:50:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p8sm954061ejo.2.2021.09.29.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 01:50:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] parse-options.c: use exhaustive "case" arms for
 "enum parse_opt_type"
Date:   Wed, 29 Sep 2021 10:48:52 +0200
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
 <patch-04.10-624a19000e1-20210928T130905Z-avarab@gmail.com>
 <xmqq5yukgrlm.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq5yukgrlm.fsf@gitster.g>
Message-ID: <87tui3vk8y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change code in get_value(), parse_options_check() etc. to do away with
>> the "default" case in favor of exhaustively checking the relevant
>> fields.
>
> I am not sure if this is a good idea in the bigger picture.
>
> If we know that unlisted cases should not happen, having "default:
> BUG()" without explicitly listing them is just as expressive as the
> result of this patch with much shorter code.
>
> When a new enum member is added without adding corresponding
> processing of the new value, either way it will be caught as a
> BUG().  Removing "default: BUG()" does allow you to catch such an
> error at compilation time, and keeping it may prevent you from doing
> so, but in practice, you'd be adding test coverage for the new case,
> which means that, even if your compiler is not cooperating, your
> test suite addition will hit "default: BUG();" in such a case.

Yes we'll catch them since these are loops over all options. But that
assumes that:

1) You have a test that's stressing the relevant entry point

2) That you run all your tests, e.g. one of these entry points is the
   "git completion" one

I think listing the remaining enum arms is a small price to pay for
having that all moved to compile-time.

>> -	default:
>> +	/* special types */
>> +	case OPTION_END:
>> +	case OPTION_GROUP:
>> +	case OPTION_NUMBER:
>> +	case OPTION_ALIAS:
>>  		BUG("opt->type %d should not happen", opt->type);
>>  	}
>> +	return -1; /* gcc 10.2.1-6's -Werror=3Dreturn-type */
>>  }

