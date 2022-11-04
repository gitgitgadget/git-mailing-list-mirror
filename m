Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406E1C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiKDNvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiKDNvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:51:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E43E21E2C
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:51:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso5476178wma.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+cJUNhx9Oxk91M9atUeYAn4L9DZBSOOwzOdjWPbqz4=;
        b=cjWr+CWqMgNB4S4ukd+QBuw6LUay1fIIiVFR0O/cHxm3195magYZDBAH0G34tm/2Nm
         vYZ8QbJ4cBTNz0f+JUkeFRx6ilLFyeRZzu43n/ZVia2G3NMsoDIYkChlgfnFJirqThgl
         zjjFu6Q5OKBZL30c07Jn5VkAawcL+3O7MTpdLXBbdi/NlNAnHWpqMzNBnaajC41VF4H0
         Tw8dfStFipTziDVj4Dl1/F90JXlN/AYUZ6lef89ZT3InTDFyuPVvwEnIT2CIfleKSjUy
         5cBf5i0i2dfas0DjYdZ6GDRAt431usDUZx9H/mYpCzrAHHbrpYgyvE8r1/9fiyOt2s3C
         ETcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+cJUNhx9Oxk91M9atUeYAn4L9DZBSOOwzOdjWPbqz4=;
        b=H48l7A95zpg03m3uQ0VPKHyzrOIWHLMRMloGjQh4UUXtdTOBD7gb7ou7TOF5Uddt0e
         VZdgcUEL3yc3frjbOha+xfWrkoXbEAAuWXmueusp1sATYQ7K/KYtU7oFYNir76a4Wpf1
         vrWnqc7+6bPRaZWKtssailBEYCEYi/KRb50u9M5G5My7EaE6KBS3YlbE0O08fn7aW3Jo
         FCWiRTPgwi56obGp7UCwrpGTooXfSgTL8t5SSSLxotiYsB3Bjc+blD1ieDgVY2dm1FTV
         DoxdO8F4Jt8gpITnQbT61d6ZH8+7kblVa256u/TxyDB4lRTMxhO5wY0lrwuAulF1vFX0
         c9Iw==
X-Gm-Message-State: ACrzQf1BTjmexfuWbvK02NRue0UWVqgzQye1km1BN3mrjl62W6aSMP3c
        SBEgO/wyGwXemHPkxAtYpec=
X-Google-Smtp-Source: AMsMyM63TtFHEa72UPq2rQ1LERAcJwwFOvFmWStUCEs40XLvNcF0VkPcxj7kBhhA88PJ3DLRI3SHkw==
X-Received: by 2002:a05:600c:539b:b0:3cf:51ce:cd7a with SMTP id hg27-20020a05600c539b00b003cf51cecd7amr29411791wmb.11.1667569867615;
        Fri, 04 Nov 2022 06:51:07 -0700 (PDT)
Received: from gmgdl (j99119.upc-j.chello.nl. [24.132.99.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a7bc4c3000000b003cf6c2f9513sm2940910wmk.2.2022.11.04.06.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:51:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqx6A-000F0j-1u;
        Fri, 04 Nov 2022 14:51:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] bisect--helper: parse subcommand with OPT_SUBCOMMAND
Date:   Fri, 04 Nov 2022 14:46:18 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
 <76c585d22bf415e719762fcf5decf4b71efa5bfb.1667561761.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <76c585d22bf415e719762fcf5decf4b71efa5bfb.1667561761.git.congdanhqx@gmail.com>
Message-ID: <221104.86mt96ygj9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> As of it is, we're parsing subcommand with OPT_CMDMODE, which will
> continue to parse more options even if the command has been found.
>
> When we're running "git bisect run" with a command that expecting
> a "--log" or "--no-log" arguments, or one of those "--bisect-..."
> arguments, bisect--helper may mistakenly think those options are
> bisect--helper's option.
>
> We may fix those problems by passing "--" when calling from
> git-bisect.sh, and skip that "--" in bisect--helper. However, it may
> interfere with user's "--".
>
> Let's parse subcommand with OPT_SUBCOMMAND since that API was born for
> this specific use-case.

If we go for this approch over my series, let's pretty please...

> +		OPT_SUBCOMMAND("bisect-reset", &fn, cmd_bisect__reset),
> +		OPT_SUBCOMMAND("bisect-terms", &fn, cmd_bisect__terms),

Not call this "bisect-reset" etc, but just "reset", the whole point of
the greater problem here is...

> -		git bisect--helper --bisect-start "$@" ;;
> +		git bisect--helper bisect-start "$@" ;;

...to be able to eventually remove this shimmy layer completely,
which...

>  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
> -		git bisect--helper --bisect-state "$cmd" "$@" ;;
> +		git bisect--helper bisect-state "$cmd" "$@" ;;

...as you can see in my
https://lore.kernel.org/git/patch-12.13-13745e3f18f-20221104T132118Z-avarab=
@gmail.com/
we still need to handle this special snowflake, but...


>  	skip)
> -		git bisect--helper --bisect-skip "$@" || exit;;
> +		git bisect--helper bisect-skip "$@" || exit;;
>  	next)
>  		# Not sure we want "next" at the UI level anymore.
> -		git bisect--helper --bisect-next "$@" || exit ;;
> +		git bisect--helper bisect-next "$@" || exit ;;
>  	visualize|view)
> -		git bisect--helper --bisect-visualize "$@" || exit;;
> +		git bisect--helper bisect-visualize "$@" || exit;;
>  	reset)
> -		git bisect--helper --bisect-reset "$@" ;;
> +		git bisect--helper bisect-reset "$@" ;;
>  	replay)
> -		git bisect--helper --bisect-replay "$@" || exit;;
> +		git bisect--helper bisect-replay "$@" || exit;;

...instead of doing all of this, get rid of most of this case statement, an=
d just do:

	bad|good|...)
		[...]
	*)
		git bisect--helper "$cmd" "$@"=20
                ;;

>  	log)
> -		git bisect--helper --bisect-log || exit ;;
> +		git bisect--helper bisect-log || exit ;;

But note that there are subtle behavior differences in some,
e.g. because we do the "|| exit" we'll eat the exit code, and this one
also doesn't get parameters, so it should be left out of such a list
(see tests in my topic for a regression check for that, we're currently
flying blind in that area).

> +# We want to make sure --log is not eaten
> +test_expect_success '"git bisect run" simple case' '
> +	git bisect start &&
> +	git bisect good $HASH1 &&
> +	git bisect bad $HASH4 &&
> +	git bisect run printf "%s\n" --log >my_bisect_log.txt &&
> +	grep -e --log my_bisect_log.txt &&
> +	git bisect reset
> +'

Check out my 1/13 to see all the cases you missed:
https://lore.kernel.org/git/patch-01.13-beb1ea22a27-20221104T132117Z-avarab=
@gmail.com/
:)
