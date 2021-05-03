Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45762C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059CB61151
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhECJDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECJDX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 05:03:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459DC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 02:02:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i24so5407464edy.8
        for <git@vger.kernel.org>; Mon, 03 May 2021 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ffek5F7sEHA7rVBDMNwaV7UHpr7hSiMX2+RlleDkQ9s=;
        b=FIbTAO04jxSc1mOPBAcYGWRA7BVFUEWP6E6FN8VZdYyGYZB/JPszErXeDweVQ9SkjR
         91Qw9oq/iHiipN5fbQUQ/KyreuwYXOYXUEwbKZky7q3kivahTmonvGxkgHXi5edxFx3u
         urSdOxjytYGsI/JKWgR3nmhfEFD8slP0xZ5IOf8npFRJWt/aSm2xJ5B+I+8nGdmckqUR
         kQ20imRzbQNaD+7+uzCcg0CgqkYAb4RatdYEarEipkxCJitm6H6nw434Y0/E0X3LPbg4
         S72M8IpqYoeIbJDsOTfFOoAxJyH9sbcPq1mr5KOQJRizCF6hvFg8nY1TRljlgTdycNxF
         K17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ffek5F7sEHA7rVBDMNwaV7UHpr7hSiMX2+RlleDkQ9s=;
        b=WxDD3QGxdTkZJOQGwn8rhemkYM5O9+ZOLKSPxczXVWpbcNkOgjuCXdn6MVlSEbhysf
         gE8L9zAmwE9Ej6haB8wVhFDeV1UOqB1Zy9fNhVFg36//8QRy7MpdVXO3SGWjm/BqYEAM
         KYEtrKLW0cbrmquNuiHLBdEBlt0oqWgma8L2G7gGEYr+e9sbqXIoqhBVigub4G+zbC8j
         zKWjUqtwu1JbmKNYn4UMLIEBoN6QSbZjwJIKax9Tq1f8tZcWuoe96e0R2rvR8M/8xWre
         TfzNMrksHoGyUoQbtb4+padI9DEdF/bnWXL17Aq6fp3n68CHfbCSlL30QRLshRliBBXM
         Vjtw==
X-Gm-Message-State: AOAM531kM0Ox5kxlBx2G8p/t0kOmeig1U7n21nMKjNRtxRkmBCe/JUjQ
        excSuswNjmsIZPoWq54GOuA=
X-Google-Smtp-Source: ABdhPJwqtRZALMXLKA21DV/jiMQK6Frzkx8aDxG+5XV1Y+5ItCaOER2WWYtWxWJ50Y68yy+3OfZfqQ==
X-Received: by 2002:a05:6402:1807:: with SMTP id g7mr18544695edy.335.1620032547601;
        Mon, 03 May 2021 02:02:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q16sm12298931edv.61.2021.05.03.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 02:02:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Date:   Mon, 03 May 2021 11:01:27 +0200
References: <xmqqfsz4a23x.fsf@gitster.g>
 <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g> <xmqqo8ds8k6r.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqo8ds8k6r.fsf_-_@gitster.g>
Message-ID: <877dkgxk9p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 03 2021, Junio C Hamano wrote:

> 01d3a526 (t0000: check whether the shell supports the "local"
> keyword, 2017-10-26) raised a test balloon to see if those who build
> and test Git use a platform with a shell that lacks support for the
> "local" keyword.  After two years, 7f0b5908 (t0000: reword comments
> for "local" test, 2019-08-08) documented that "local" keyword, even
> though is outside POSIX, is allowed in our test scripts.
>
> Let's write it in the CodingGuidelines, too.  It might be tempting
> to allow it in scripted Porcelains (we have avoided getting them
> contaminiated by "local" so far), but they are on their way out and
> getting rewritten in C.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 45465bc0c9..ea70676a30 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -175,6 +175,11 @@ For shell scripts specifically (not exhaustive):
>  
>     does not have such a problem.
>  
> + - Even though "local" is not part of POSIX, we make heavy use of it
> +   in our test suite.  We do not use it in scripted Porcelains, and
> +   hopefully nobody starts using "local" before they are reimplemented
> +   in C ;-)
> +

Is there any portability reason to avoid "local" in the porcelains? I
don't have any plans for using it, but I don't see why we'd explicitly
forbid it.
