Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E25C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616B961139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbhIHBuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbhIHBuX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:50:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB28C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:49:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i6so655062edu.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=R+Djvj8yrzrCTPJ4aUI7xjH0LZ6QQVkyBWw67dCvhZo=;
        b=gn0pERWj9ruk3vzDSXRxswz+L1vO8miAkZCn1b40X7JOicXt1kpDTlqsDWkOixqD75
         bOtzKrkxkFA9c57eB0HGEU7FoDGHVpBldZsp9HZSgTwYPkWp762iO9SWcJEBfpw0Rinq
         lGNNBEsZETKOqVAplBboklDSRxgUIy+SOaZnpBq7X+z06J/3tWxAZo12I2+f1V2EofWP
         +3aGVv/eU7UBkqsoKrXfnz3MaZYr2htkxnkK4Tdhj9IuCoqUMxr84/9sbzGXpop6DnWK
         KJO5ZVN9IcYr6JgeFqN75Ri7bLGTIP+uWMASgFNswg0wigxG/bY7OYiO14QleKtNz0SR
         9reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=R+Djvj8yrzrCTPJ4aUI7xjH0LZ6QQVkyBWw67dCvhZo=;
        b=MrUglhDHXoeeuiFM27lL2BxWRmtslKo4Qo3uAlbIIKorHHFOjrXe0YhEyAimXQqkJU
         G4ZwXzJ1Boj3TBst+4V9mSKv2b+WgDn9MDBOVdB4djY19JAlX296cJg4qTYHPE/gGx7n
         ZjrZ3MfoR7+EOCUm7Ripq9XqVJLNHb+ic3hkBunSV/1rnLoInxAyJaCk76fu6IcED/kl
         6YndfTXNUlJL5dZ3wtYEnaZemUh3L5pYOJnaGsA7EhJ4w2E+aUxcnQTBEGLKcSjwDfGX
         m3DUMdvOECftAajg3y+vOfzfikWz/rRF8c1PUCckBLXIDnJWGzqD4sjfZTk3SpB3E+Tq
         /8gQ==
X-Gm-Message-State: AOAM53353xwwMeB1lQdp2EGCTyZX1Hu/FGZR/kIY1bIapZst7JfXX0sG
        yc6Hyzjg/ZxNU1k0Ro9Fiv460m1bNAvA0A==
X-Google-Smtp-Source: ABdhPJyW4VgFRTuectemTbGWDf38FQOCT/2wHGbjfRF6P1L8bIqh1uk8YQk3sVJoYboRTP1r9yIrAw==
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr1346679edd.186.1631065752755;
        Tue, 07 Sep 2021 18:49:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o21sm295564edc.47.2021.09.07.18.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:49:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Date:   Wed, 08 Sep 2021 03:46:29 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
Message-ID: <87zgsnj0q0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Taylor Blau wrote:

> Now that we both can propagate values from the hashcache, and respect
> the configuration to enable the hashcache at all, test that both of
> these function correctly by hardening their behavior with a test.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t5326-multi-pack-bitmaps.sh | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 4ad7c2c969..24148ca35b 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -283,4 +283,36 @@ test_expect_success 'pack.preferBitmapTips' '
>  	)
>  '
>  
> +test_expect_success 'hash-cache values are propagated from pack bitmaps' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&

It seems the need for this "rm -fr repo" dance instead of just relying
on test_when_finished "rm -rf repo" is because of a 3x tests in a
function in tb/multi-pack-bitmaps that should probably be combined into
one, i.e. they share the same logical "repo" setup.

> +	(
> +		cd repo &&
> +
> +		git config pack.writeBitmapHashCache true &&

s/git config/test_config/, surely.
