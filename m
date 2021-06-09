Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B5C48BD1
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8521601FC
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhFIPXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:23:21 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38744 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhFIPXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 11:23:18 -0400
Received: by mail-ot1-f47.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10667923otk.5
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8Sg3H+nP/SgfkrmMb6X6XLPBYfWYD9XZeJamn1qqvtE=;
        b=Ry7w813qL8jNbnZJWEPVWGPe5DPW92T7OLAk0aw0OyDG2hVuZDJll3IB9dACxRAvOM
         uCBkFKpNJf6lAGbzML1As07k9ZXDWpJJ3KSQg/YrQWhcLe+ceT/1R6sG/oDvTU+pZZdX
         Mv/EEjmrzTG/PP3EhWgAm0PkkZOeV/aUA7XZuvdSlspVFhIOr9Bh0K9qKoYeZ1E1DP15
         VbAk8OyvIr1uGLEdQzLs/o2SQPXVXzjv81jcikNYYOkv0UBXLhYnZxFoxv5kQhYn8M0f
         m1LyktxppX0gn/B8zF9ZDMX5O+6+5NIZUs980f59hrbLydQcJs6e68csD0m1pGpczdJx
         bEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8Sg3H+nP/SgfkrmMb6X6XLPBYfWYD9XZeJamn1qqvtE=;
        b=cS0V83S66h400NBycGKaYpROEv7oRG6h3HWaOVroKzcCV9XtzwurQtNItIn5LF9wze
         jWXvjlPFQnWCEV8PiyLsMx82omu77dHvhr5S1aBdj3/AYTFZbtNEv9DWA4apg8ULv8Ay
         k3HuCqt5+HvkJxnzPsSP6lmJshwWuZCWsqkbMfAdCePaK/L+Z7abkh0Gi1B2E/V7Cror
         Q/RPpj89/1C3CXBBMFihExSCSzF5aRM+zoHgnZRSALuTwCaMgP2iriSDb3K8pmO74nm1
         1zJ1GdMWypf2uc531p+MT2qXH9EtQaUOZqzZLny9Sq3LgGnnr0lQmdBtd1Ye+1QJfXdv
         XlxA==
X-Gm-Message-State: AOAM531FROns6AO3zpCP4Spmk9M1qdMdoUV7r3QNAug6GNzzDGlzdz3b
        RP6Pc6HYDQ8953e2eqCVjDg=
X-Google-Smtp-Source: ABdhPJzS/RfG/ApH0f/q8593hdRkPmr6e0QCbZr6vd1dlUxQpXoDmjebPfHvlEa5EhUnViSIuTZ6sQ==
X-Received: by 2002:a05:6830:17c3:: with SMTP id p3mr167055ota.140.1623252024085;
        Wed, 09 Jun 2021 08:20:24 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id g2sm53901otk.40.2021.06.09.08.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:20:23 -0700 (PDT)
Date:   Wed, 09 Jun 2021 10:20:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c0dc35dc6e1_efb208a1@natae.notmuch>
In-Reply-To: <baa4b326-19c3-6471-36d7-701716d0a836@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <YL8X7PepIggpKlSl@coredump.intra.peff.net>
 <60bf2634beff5_1a700820836@natae.notmuch>
 <baa4b326-19c3-6471-36d7-701716d0a836@gmail.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/8/2021 4:11 AM, Felipe Contreras wrote:
> > Jeff King wrote:
> >> On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> >>
> >>> If we use singular "they/them" pronouns instead of "he/him" or "she/her"
> >>> pronouns, then we can avoid this congitive load on the reader.
> >>>
> >>> Using singular "they" is also incredibly efficient. Choosing a gendered
> >>> pronoun is usually arbitrary between "he" or "she". Using constructs
> >>> such as "he or she", "s/he", or "(s)he" are more complicated than
> >>> singular "they".
> >>
> >> In general, I do like the efficiency and readability of singular "they".
> >> As a native speaker, I have no problem reading it, and I have little
> >> sense that most of my native-speaker acquaintances would, either.
> > 
> > Does this sound correct to you?
> > 
> >   We thank the reviewer for their helpful comments
> 
> In the case of an anonymous reviewer (such as a single-blind review of
> an academic paper), then this is exactly how one should acknowledge a
> single reviewer.

That was not the question.

-- 
Felipe Contreras
