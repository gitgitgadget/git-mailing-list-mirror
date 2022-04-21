Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF42C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiDUVM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiDUVMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:12:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5546585
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:10:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y10so12440765ejw.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uDtnVsjCIZgUXD+9MuIRIHi8iJFcySbZXPzoI1KIMVo=;
        b=X/yrKcRHzph02XSeOlvVPae3Pj69OMvjPKx4W8Sth0b+A4f1ygA/CHpAiazTsDd2pC
         qF10OXsVi3+6ptBHRQ15Nvg/nweGWO7rKLmi4aTuXUVCW6+bPBFNDO2IrkH8RAjz9TrD
         fHodIcH4cJDALvgaRr4PriWovwgFnzxgVcl0nYDWZB724nYrwheDpblcPNtk85WyCdmy
         j06sCWeNEaRxgp8vOb0GgaMxYce82mXRSFAxJ0M2bwvWpGkTau3whIFzfqgk1lOd/ISr
         ua6bPkICwfDGLoQZxcv8lSuM6plAjQ9pWlGsYLt2+tY3omjIulwHTdlZViZhNAOmL1Az
         v4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uDtnVsjCIZgUXD+9MuIRIHi8iJFcySbZXPzoI1KIMVo=;
        b=weEQ0RB+H9KtiFRK+z0QXONksWqeWVJa0jgt1mSM3hgL7yuzVGcIdj6xww37lpSUgT
         RmuZqQioY4z7HUPh9qk3Tx1ZjPe9WVRmjyjjT9UJ1foSABGPk87DcBIlITJGHFnvAXdA
         TF7P/oyhuFlylC2Pv9k8i5lLxyZQVT/M9LjcB/849RWQQsrniQoJygoqK2P7L6yzteN0
         FgdwWCAJ7yB6k6C7E1qA0PK+6GDm8KEDJ4BUGF64kN33quu0ylDReJbyyZZOGCgz/6Mx
         8lHQD010/iqD9v07AW4YwvosLUL1GHFXRLL6GZM11Jj9G/SaPAWuYR55bkHT9en4Re7J
         s+sA==
X-Gm-Message-State: AOAM531wo3RGSdJkG0HHGvf5fQdwpxPHWmuRNJqRQ5FFNOFr9nfMN61+
        m73oz8awwjPQVJ+TbdOgNKc=
X-Google-Smtp-Source: ABdhPJzCGC93GGL+M8ELMe/XzyKxYfJOzT/4L2LNLf9hakEdJo6ZUHpARCkn27UCu96HjGzM0N2K7A==
X-Received: by 2002:a17:906:4fcb:b0:6e8:74db:6b04 with SMTP id i11-20020a1709064fcb00b006e874db6b04mr1242677ejw.676.1650575403373;
        Thu, 21 Apr 2022 14:10:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p9-20020a05640243c900b0041facb9ac9esm65131edc.1.2022.04.21.14.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:10:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhe3t-008E9c-U5;
        Thu, 21 Apr 2022 23:10:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
Date:   Thu, 21 Apr 2022 23:08:41 +0200
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com>
 <xmqqo80uf9jn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo80uf9jn.fsf@gitster.g>
Message-ID: <220421.86pmla5eja.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In the obscure (but unlikely to ever happen) that the failure is
>> specifically because perforce.com published a bad updated package, and
>> it a failure that their testing wouldn't have caught, but whoever's
>> updating the homebrew SHA-256 recipe would have caught, we will have a
>> failure in our p4 tests that we wouldn't have otherwise had.
>
> Or DNS the CI site consults is tainted and we got a bad package from
> a fake perforce.com?

Yeah, or any number of other things, all probably too obscure to worry abou=
t.

>> @@ -37,7 +37,13 @@ macos-latest)
>>  	test -z "$BREW_INSTALL_PACKAGES" ||
>>  	brew install $BREW_INSTALL_PACKAGES
>>  	brew link --force gettext
>> -	brew install perforce
>> +	brew install perforce || {
>> +		echo Installing perforce failed, assuming and working around SHA256 m=
ismatch >&2 &&
>
> I had to read this three times before realizing what you are
> "assuming".  You suspect without having a way to verify that SHA-256
> mismatch was the reason why the attempt to install failed, and
> working it around.  Makes sense.
>
> What does it buy us to do this only as a fallback?  If we munged the
> $path to disable sha256 checking before the initial "brew install",
> we would install it happily if the package is the correct one, and
> if it is not a kosher one, we'd install it anyway.
>
> Is it so that we can tell if we had the checksum mismatch or not?
> It is unfortunate that no_check is the only "special" value for the
> field (I would have loved to use "warn_only" if it were available).

Yes, just to be able to tell that we tried, and overrode it. If anything
goes wrong we'll be able to see that we did that, in case it caused any
fallout.

>> +
>> +		path=3D$(brew edit --print-path perforce) &&
>> +		sed -i -e 's/\(sha256.\).*/\1:no_check/' "$path" &&
>
> "sed -i" is not POSIX and without macOS box I do not know if it
> works there.  FreeBSD sed manual seems to indicate they have
>
> 	sed -i <extension>
>
> In our current codebase, "sed -i" appears to be used only in vcxproj
> part of config.mak.uname
>
> I would usually have said that "I'd rather see us not to use it
> here, to prevent others from copying and pasting it, if it can be
> helped", but this is very much macOS specific part of an obscure
> corner of the source tree, so as long as we are sure it works there,
> and if it is too cumbersome to avoid editing in-place, I'd let it
> go.
>
> Ah, no, I'd say we should NOT use "sed -i" here, not in the form in
> this patch, after seeing
>
>   https://unix.stackexchange.com/questions/401905/bsd-sed-vs-gnu-sed-and-i
>
> but that is 4-year old information, so...

It works on the OSX we use now:
https://github.com/avar/git/runs/6092916612?check_suite_focus=3Dtrue

I think it's fine to keep it, but we could also use "perl -pi -e" here,
or a rename dance...

>> +		brew install perforce
>> +	}
>>=20=20
>>  	if test -n "$CC_PACKAGE"
>>  	then

