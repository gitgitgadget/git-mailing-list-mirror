Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B9CC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 21:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347197AbiC3VQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345618AbiC3VQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 17:16:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB24FC41
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:14:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h1so25975257edj.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+6uNSijkrr3KItwsCatcuFPu6aukFVplprwPN1FYm6k=;
        b=bgq/+VLztxu2O0Dajeb0s7E0IHtttwoGmP/SmVPRE8a3VQhwKR/5zMk15UJhId6xDQ
         ifM9cj3hNTl7C/wbumrMtidGTHccnxjwhcudN73erJ8kGjzmHR7hURlKC7SX3jElNWga
         8q89w7ngKK/eVvSDE50twH7qdGJjqrKcn7X3+LE2Lw6iyoeej/FC6aGXfD2IgDNeH6gd
         UMPUgT4Uo88njKc0OsNpWiUIrUkN1jI1jr4FZ/PgNodJe95OE+EAHf9gzP3hqIuPxL83
         DAXoU0SipdZ1FeLlYJrSw5WfjV16MvDq4XcgRcXeo3U7eOchOtarl41D7ZOUhd4X3vLV
         td1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+6uNSijkrr3KItwsCatcuFPu6aukFVplprwPN1FYm6k=;
        b=xuSHfRcP1O/QqFMsCb8DFY3oqV9EgjbutVMqjwsudxY8lPT3EziDrfBkXRgDAFaGhi
         wQiy8nNtJ/Foilrg2u6RpEoOtC2f4cFdI2Esuh9EUjAML6HOmH7GPuwVaO5Ih+G/ZrZq
         FdfDp/39EHzQFc4iaplqypPGGRaGyM7L9+elc7qWrGNel9I4/9VHn0la9/NgtltmWewx
         HK2Joe9emw/d5gsTLrLCf/9OLclVOfyjQwdcEuVxSFW1S1P+danYOOj8QJkvuRBmwDMw
         Ruj1vkB0w1KOp7zXg7xfz63weELebIPjp1MN8B2TxBoxVWaRoqYCQfvl5vxgr9ZEplDk
         S1Yw==
X-Gm-Message-State: AOAM53184kLm55OHOnuUWDh2Q8ar+7PgtFk9OomwSoFATRiD/n5q58Ne
        xD1r8tiryb/a7YMQ3pyN0pUa3qNre54=
X-Google-Smtp-Source: ABdhPJyTMFheKxkLFoZFbrTKv6q04z7NyT3iHhWdLVMNsc0ncEAEvuW0i3v2Jo2ltpYk/i85ALrgsg==
X-Received: by 2002:a50:ee15:0:b0:41b:67a0:860 with SMTP id g21-20020a50ee15000000b0041b67a00860mr5062280eds.48.1648674873066;
        Wed, 30 Mar 2022 14:14:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906614600b006e133d37f8bsm2415448ejl.138.2022.03.30.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:14:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZfe7-0001ea-Rg;
        Wed, 30 Mar 2022 23:14:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec
 error
Date:   Wed, 30 Mar 2022 23:09:49 +0200
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
 <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
 <220330.864k3fpo32.gmgdl@evledraar.gmail.com> <xmqqmth76use.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqmth76use.fsf@gitster.g>
Message-ID: <220330.86o81nta6k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Mar 30 2022, Tao Klerks via GitGitGadget wrote:
>>
>>> From: Tao Klerks <tao@klerks.biz>
>>
>>> +		case 2:
>>> +			// there are at least two remotes; backfill the first one
>>
>> Nit: I think it's been Junio's preference not to introduce C99 comments,
>
> I often mention the rule to new contributors, simply because it has
> been that way in our code base, regardless of what my personal
> preference might be, and sticking to the style will be more
> consistent.  It's not like I am forcing my personal preference on
> developers.  Do not mislead new people into thinking so.  It is
> especially irritating to see ...
>
>> despite other C99 features now being used (and I think it should work in
>> practice as far as portability goes, see
>> https://lore.kernel.org/git/87wnmwpwyf.fsf@evledraar.gmail.com/)
>
> ... a mention like this, when you know that it is not about
> portability but is about consistency, and also you know I've
> mentioned more than once on the list if we want to loosen some
> written CodingGuidelines rules, especially those that tools do not
> necessarily catch.

I know, and I didn't mean to imply that you were standing in the way of
C99 progress or anything like that.

Personally, I much prefer not to have //-style comments introduced. I
merely mentioned the portability concern because I thought it helped
give a relatively new contributor some context.

I.e. that despite any new developments on the C99 front they might
discover this particular thing is stylistic and not about portability
(although that may also have been a reason in the past).

>>> +	if (tracking.matches > 1) {
>>> +		int status =3D die_message(_("not tracking: ambiguous information fo=
r ref %s"),
>>> +					    orig_ref);
>>
>> This isn't per-se new, but I wonder if while we're at it we shold just
>> quote '%s' here, which we'd usually do. I.e. this message isn't new, but
>> referring again to "ref %s" (and not "ref '%s'") below is.
>
> Good.
>
>>> +				 "To support setting up tracking branches, ensure that\n"
>>> +				 "different remotes' fetch refspecs map into different\n"
>>> +				 "tracking namespaces."),
>>> +			       orig_ref,
>>> +			       remotes_advice.buf
>>> +			       );
>>
>> Nit: The usual style for multi-line arguments is to "fill" lines until
>> you're at 79 characters, so these last three lines (including the ");")
>> can all go on the "tracking namespaces" line (until they're at 79, then
>> wrap)>
>
> I didn't know about the magic "79" number.  It makes the resulting
> source code extremely hard to read, though, while making it easier
> to grep for specific messages.

I'm referring to the "80 characters per line", but omitted the \n, but
yeah, I should have just said 80.

