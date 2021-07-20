Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E04C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE88160FF3
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhGTUCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbhGTTsd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:48:33 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A2C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:29:10 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id i11-20020a4adf0b0000b0290263e1ba7ff9so81531oou.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=clfOuMWmJF14KBjBcorNEkKmtWYlJrkAtG5l8zGDEO8=;
        b=VA58mlPyQMqYM8DzEsNkaExT/yh1wMdasJwjtikKpOfN29zi6zR6l5Z4I3AdXtaL09
         e4zMB/XlHW5vD8fDQxP0T7nQfhvxr3QjO++rf0/mITFNpw6VRmGg0vvSwlR4WdF1j2D0
         r79nec6rz401cY4FsWz025FZB74Px3FoRFPZ0cwbbazWqx+qPfWW5jnHLt89vl6vtoye
         KLONQb0FNeHqVafhGy7juJSeYPr2gLOPb41EIlteXs35fgSAMdNw/fGkiI1yR3EU9Ig1
         LjHL1RInhYWVhNQYyDcyWzEinsreUiqTvhJR98KPeEh5dtArpesN2tOwVNcDJerh6BL/
         sEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=clfOuMWmJF14KBjBcorNEkKmtWYlJrkAtG5l8zGDEO8=;
        b=o9YUTFvmrGN75BF02aoUF4Ox/Bb89+2xv4oJjz3f92l2SZsylR1CLHZJC0PsLEfT1W
         eysZ6ZiyxQ9l2u3d7wAbxqdVt0AF4Uzs/GT4OWy1hxMbWMs6VfYLPuCwmtNpH1TqKXUK
         33YnHjHaRju4l0/Rb2xkUJJCT6S0Fp66vNI+t2yx0an6p5mUG0khVG0ClaWHNd8VfMP5
         YnBQ+Hqy+NYLCoFSOngpFMcKhiYFfoBRrqqTGogPl1OtWXZSTsXVDya2vNLiJU7UMgze
         ODzDavZouVFPWFO1aqV6s8RxHAhrAmIUQXwhxV0RV8oBxF5vUhyBthh8A8XPzp45EFPF
         2yaA==
X-Gm-Message-State: AOAM53096xORHk+nE4jcf7StuFnAXtE1KvF60LLeGofvAZDUMIglXPLh
        EnRZgQWAP9gpI25QlB5pH7A=
X-Google-Smtp-Source: ABdhPJzD5EiuICbZhVsU89EWRTXBtZEHQP3uHNIUxtjbscQq5tGt5fKgw76vHitrcnM6JIt9LRz6Zw==
X-Received: by 2002:a4a:8f13:: with SMTP id e19mr22056501ool.39.1626812948868;
        Tue, 20 Jul 2021 13:29:08 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id t16sm3358558otm.63.2021.07.20.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:29:08 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:29:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f73213233d7_14a799208f5@natae.notmuch>
In-Reply-To: <xmqq35samac9.fsf@gitster.g>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
 <xmqq35samac9.fsf@gitster.g>
Subject: Re: [PATCH 1/9] t7601: add relative precedence tests for merge and
 rebase flags/options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> > +test_expect_failure '--no-rebase overrides pull.ff=only' '
> > +	test_does_need_full_merge -c pull.ff=only pull --no-rebase
> > +'
> > +
> > +test_expect_success '--rebase takes precedence over pull.ff=only' '
> > +	test_does_rebase -c pull.ff=only pull --rebase
> > +'
> 
> OK.

Since when is it OK to test for a new behavior that 1. will break
compatibility, 2. is not documented, and 3. has zero consensus?

-- 
Felipe Contreras
