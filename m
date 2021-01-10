Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C037C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 13:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7DB2376E
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 13:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbhAJNWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 08:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJNWk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 08:22:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC1C061794
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 05:21:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v26so7061096eds.13
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 05:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bctq/jnRJGR0EjQP8Uz8NPWgEkbILohh3V9F4p+4q0c=;
        b=gtgRYNwL1VYCaiipBRkqS+UzlMaLNhsB1cuION5zg3I/zS3V0F+oEpc9R/9TFu73X0
         kaL9SXVgQhe6EwjZj1Ckwj10Yi4OjqRul3t1nmIF4BWT3w6Go4etV+I+ZuQk8JPCpHLL
         Sc8pxScQwdK+1vXTv2t6Cb0opKxcB7gsoR+2soQc7kryCFujVIt479JviGJcEfhUBhkU
         OaPCi+uu9fhoOHzpMUx2xlQnhsKL1ilKLugCpKp5UFk0NHFojq22H1ev91lXNGW1rGWK
         fF/h95dAT7YAueynWoJpQtoCpXdJ2+dHr10r7s1b+U8kENd7ugGo7Y+/Bdkaq64HwFlD
         b9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bctq/jnRJGR0EjQP8Uz8NPWgEkbILohh3V9F4p+4q0c=;
        b=sd6+lSOSS2Mw4b83X8tg5UnKYJJXibvFdQm3Fb+cTsstHmhsAAf8BYDYZF6ZF3kRLH
         5V/N/bsXkXOdEvhh2IgvgUybG2ra1K+wjYsWDgDjp5rMLQu71OX5NMwuDHkXL6UXdee9
         L6PelF5A+ni8YB+FmaeMvYFn5CSaZkvibeab90zRsShVb4sW9lAxCVy/3XG7WNW4fdvW
         kW+DDZ6ZEqf4A0vAqWVuqT9lAnpHmVHOo6E5QgUoa1yputjnQ2W9/p6Qmk3YcL8fsy+Y
         ZgpbKRjvbdO4vw2loN3+aG9DyE7mfAejuxo4BDOIfYxjj4wFf/FcJnevHWs6rfGBKxVL
         ar5A==
X-Gm-Message-State: AOAM5309TwxwzobKJU0ONZpLurGOyRiMyiANHF01enCbrx76EQ//Fhar
        BIahH+ZJiR+K9777L9X4e5c=
X-Google-Smtp-Source: ABdhPJyYb9IUr4/4B4zmlfAEmTTY3UqfhTQ1kjlV9LVRTCk2Di6ESdwfMC3mq/O5CYTiOuYOr0/NnQ==
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr11300910edt.213.1610284918273;
        Sun, 10 Jan 2021 05:21:58 -0800 (PST)
Received: from szeder.dev (84-236-109-1.pool.digikabel.hu. [84.236.109.1])
        by smtp.gmail.com with ESMTPSA id r24sm6344397edc.21.2021.01.10.05.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 05:21:57 -0800 (PST)
Date:   Sun, 10 Jan 2021 14:21:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 12/23] mktag tests: improve verify_object() test
 coverage
Message-ID: <20210110132155.GT8396@szeder.dev>
References: <20201223013606.7972-1-avarab@gmail.com>
 <20210105194252.627-13-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105194252.627-13-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 05, 2021 at 08:42:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> The verify_object() function in "mktag.c" is tasked with ensuring that
> our tag refers to a valid object.
> 
> The existing test for this might fail because it was also testing that
> "type taggg" didn't refer to a valid object type (it should be "type
> tag"), or because we referred to a valid object but got the type
> wrong.
> 
> Let's split these tests up, so we're testing all combinations of a
> non-existing object and in invalid/wrong "type" lines.
> 
> We need to provide GIT_TEST_GETTEXT_POISON=false here because the
> "invalid object type" error is emitted by
> parse_loose_header_extended(), which has that message already marked
> for translation. Another option would be to use test_i18ngrep, but I
> prefer always running the test, not skipping it under gettext poison
> testing.

This is fairly unconvincing.  Why do you prefer it that way?  What is
so special in these tests of 'git mktags' that could possibly warrant
this special treatment WRT gettext poisoning, as opposed to the other
~1500 invocations of test_i18n{grep,cmp}?

> I'm not testing this in combination with "git replace". That'll be
> done in a subsequent commit.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t3800-mktag.sh | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 47380292223..ced540035d4 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -14,7 +14,8 @@ test_description='git mktag: tag object verify test'
>  check_verify_failure () {
>  	expect="$2"
>  	test_expect_success "$1" '
> -		test_must_fail git mktag <tag.sig 2>message &&
> +		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
> +			git mktag <tag.sig 2>message &&
>  		grep "$expect" message
>  	'
>  }
> @@ -136,19 +137,52 @@ check_verify_failure '"type" line type-name length check' \
>  	'^error: char.*: type too long$'
>  
>  ############################################################
> -#  9. verify object (SHA1/type) check
> +#  9. verify object (hash/type) check
>  
>  cat >tag.sig <<EOF
>  object $(test_oid deadbeef)
> +type tag
> +tag mytag
> +tagger . <> 0 +0000
> +
> +EOF
> +
> +check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
> +	'^error: char7: could not verify object.*$'
> +
> +cat >tag.sig <<EOF
> +object $head
>  type tagggg
>  tag mytag
>  tagger . <> 0 +0000
>  
>  EOF
>  
> -check_verify_failure 'verify object (SHA1/type) check' \
> +check_verify_failure 'verify object (hash/type) check -- made-up type, valid object' \
> +	'^fatal: invalid object type'
> +
> +cat >tag.sig <<EOF
> +object $(test_oid deadbeef)
> +type tagggg
> +tag mytag
> +tagger . <> 0 +0000
> +
> +EOF
> +
> +check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
>  	'^error: char7: could not verify object.*$'
>  
> +cat >tag.sig <<EOF
> +object $head
> +type tree
> +tag mytag
> +tagger . <> 0 +0000
> +
> +EOF
> +
> +check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
> +	'^error: char7: could not verify object'
> +
>  ############################################################
>  # 10. verify tag-name check
>  
> -- 
> 2.29.2.222.g5d2a92d10f8
> 
