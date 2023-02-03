Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DBAC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 21:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjBCVwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjBCVw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 16:52:29 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9857728848
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 13:52:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g13so1849412ple.10
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGirtnY+tGlGH37zwpljEPazEHAUIxX8f7sjtPOzR1s=;
        b=nc1g+EqR4FbEJolSGF4av6XefQO5C0x1SSwP2g4m0EoIi+NVQmVLgJOMcvtGGCJ8VN
         2u+dLwy0zXnNjhZVThvtwcihayYAyo1Yv3dQfFI1X1OUrwJguFKt/EdBujnqJQU4atj7
         AHBKhjxAcJW/FhPQg75A+hEYUzrY0YAMQ6DNwtoMn5+JGp+kICf+xNM/JFrNr3tfgJtX
         yLX+ZQ2hwvRhrW8kpdqdXVdAoYpXgR4dglJlCJQbRuYZDT+M5/9R6YQKwvOHSMUVBfhz
         mZfNSohHrETLx7UbbXa78gvr33Ucrf8Bkl80vDOgZ6r//+IJwpEgKxXMT1ukHAKWyXGX
         4XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGirtnY+tGlGH37zwpljEPazEHAUIxX8f7sjtPOzR1s=;
        b=6KgmeyaWXRFN8cuP4frjWI8q2Df4hrKt5EPtwAyrGIdwvDNEK9b5l+TftAMj5kXtq6
         BfredBwXXM8sXeVMvoy3+t8Fq5oomrLrwQNvapeTqoLAkYkDPCTH4K+T0RzkCcjTlBgb
         7okioOQn2/uKHGxtWscqtvJWM4uRrrpuSwJIgsBmFaXoSPsvTW+0HIK3kTp3hQQKKgOW
         LCImj5maI0KXpafBN0uWyDWeILWG2Wb5hrawwExl9LfnOmdflJHnIB+RAY+HYVODzwZx
         U8+4+pmoN5aJMN98xfIHxnzkL/4XL/JWmcdIs/BvZKno1ksxZoQmK5vpgQMcOGW3Z3V9
         Go1w==
X-Gm-Message-State: AO0yUKUXnYcDbPm4d7qLDlzxqM3YqaKECXpgiRr7UDJBo4afrgfBAmtr
        1kxBFfWYubaG8Sk4TA8P1FI=
X-Google-Smtp-Source: AK7set+RbAgmPYqZRLHB0Gk4xCotM705Tbakfe2YEj1xYsB/Ur4k0ixiq3NNAUXZWOYFTG0u0WsQWA==
X-Received: by 2002:a17:902:e5c3:b0:196:4643:e1e7 with SMTP id u3-20020a170902e5c300b001964643e1e7mr14999152plf.30.1675461146005;
        Fri, 03 Feb 2023 13:52:26 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id p21-20020a1709028a9500b0019311ec702asm2094813plo.36.2023.02.03.13.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:52:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v4 4/9] versioncmp.c: refactor config reading next commit
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
        <patch-v4-4.9-aae1d5c12a9-20230202T131155Z-avarab@gmail.com>
Date:   Fri, 03 Feb 2023 13:52:25 -0800
In-Reply-To: <patch-v4-4.9-aae1d5c12a9-20230202T131155Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 14:27:16
        +0100")
Message-ID: <xmqq1qn6o1ra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Refactor the reading of the versionSort.suffix and
> versionSort.prereleaseSuffix configuration variables to stay within
> the bounds of our CodingGuidelines when it comes to line length, and
> to avoid repeating ourselves.
>
> Let's also split out the names of the config variables into variables
> of our own, so we don't have to repeat ourselves, 

You do not have to repeat "we don't have to repeat" by mentioning it
twice in two paragraphs.

> Moving the "initialized = 1" assignment allows us to move some of this
> to the variable declarations in the subsequent commit.

Unclear until looking at these subsequent steps; let's see what
happens next ;-).

>  	if (!initialized) {
> -		const struct string_list *deprecated_prereleases;
> +		const char *const newk = "versionsort.suffix";
> +		const char *const oldk = "versionsort.prereleasesuffix";
> +		const struct string_list *oldl;

With s/oldl/deprecated_prereleases/ the damage would even be
smaller.  It's not like a more descriptive name in this small scope
hurts line length or readability, is it?

> +		prereleases = git_config_get_value_multi(newk);
> +		oldl = git_config_get_value_multi(oldk);

> +		if (prereleases && oldl)
> +			warning("ignoring %s because %s is set", oldk, newk);
> +		else if (!prereleases)
> +			prereleases = oldl;

This makes it more clear than the original what is going on, even
though they are equivalent.  If we have both, we ignore the
fallback, and if we don't have what we need, we replace it with the
fallback, which could be NULL in which case we end up not having
any.

It is a very nice added bonus that we ended up with a shallow
nesting.
