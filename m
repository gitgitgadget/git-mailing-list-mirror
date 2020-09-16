Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B332CC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7050F21941
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuOaCbUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIPUXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgIPR2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:28:40 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126DC061353
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:51:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so7601009qkn.11
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ziKzcCrrK/MRRK7z2ddHIpLxdsGuyi0tqFxIuWoQyFY=;
        b=cuOaCbUrNkQhCGIT1UyJUwfZGnYxUNABI0Ao9JoKJb144VCz8S0L2fkA6q7O8gvpUr
         6cpdZzXZxGG/aZdx7HFGzLfxfHewQUvM/tKsUqpCH+2pJJR4WgFWgewbc2VZXbXJvaQW
         01OMbTvfHp41VpKHJrJzwigrGmZKIpbsAu0fms2J2kpg3TP8VKenHIvoQK4i9p1Yhin6
         k2pAA5rDmZIM3i3Jjt4zNa5yqkLlQdRljheSN4fpuWSyuOmfejNkeOE+cqQjVoTHPlyE
         KRCkQDKUPwhX12OSlb9gy86AcS5jzanO4tBZkUv1N6WPg2WXDU6V1Wc8lEnAywb8ZvMm
         l30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ziKzcCrrK/MRRK7z2ddHIpLxdsGuyi0tqFxIuWoQyFY=;
        b=cOAnhVgPfHamanKegLQT8XFH45mi4dvUJbD1EGfr8Lo7VrTtag6YkXWkAd4QQi/b9f
         AuqLzL9653sIFKnKDS5ywNN1jhkp69U7pyUDxD+/V32Tbr46OMC2Ut8cLJyhPoTk5g9W
         zQ/PwAUU//7K5L3NpbigxnHQ0nOlZ1XEE68FWQuwQQwOccziR/W17nxRc5nZ9rX174Hh
         MrX+ln5/6eX1wM106wyxGhl6ewRmLDFxYf0Kah6bkZjJW3IVAggxRu+rOT5qEGef7VuT
         idOJ2njbs8Qj0pWoVVTBHjmmQ21ECGLtawLsNCyaFCLbb95ThUBzGlP4ZUVKD/TFMok3
         2FXA==
X-Gm-Message-State: AOAM533LO2YBZaIDLorhNhevAiLKpJoHqY4agIPPgCiL+nj9MKEbZtP8
        B/3wJvWm79M8+3LlEYHsVHQ=
X-Google-Smtp-Source: ABdhPJzhVHmoW5vXrcQC7zWtCeFW00JJwkoT/5S4M1k2SyTt4AIhra5XYx72p5v7M0jAqp1tqXtTpA==
X-Received: by 2002:a37:5684:: with SMTP id k126mr21091133qkb.43.1600253475319;
        Wed, 16 Sep 2020 03:51:15 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.106.183])
        by smtp.gmail.com with ESMTPSA id b43sm19387017qtk.84.2020.09.16.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:51:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:21:08 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/7] remote: add reflog check for "force-if-includes"
Message-ID: <20200916105108.GA45240@mail.clickyotomy.dev>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
 <xmqqd02ojep5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd02ojep5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 09/14/2020 13:17, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > Add a check to verify if the remote-tracking ref of the local branch is
> > reachable from one of its "reflog" entries; `set_ref_status_for_push`
> > updated to add a reject reason and disallow the forced push if the
> > check fails.
> 
> I have to wonder (not objecting to, just wondering about) if it is a
> good assumption that the current branch must be where we should have
> seen the tip of the other side we are about to lose.  I ask because
> when I do a large rewrite I often am on a detached HEAD most of the
> time, and after everything looks sensible in the rewritten result,
> I "checkout -B" the local branch.
> 
> We could reduce the rate of false positive ("no you've not looked at
> what you are about to discard, so we won't let you force") by
> checking reflogs of all the local branches and HEAD, but that may be
> too much.  I wonder if checking reflog entries only for HEAD (and
> not any of the current local branches) would be a good compromise.

One scenario I can think of is when there are multiple local branches
that track the same remote. Let's say we have two branches "A" and "B"
and they both track "A" on the remote. If we are currently on "A",
and then we decide to rebase on "origin/A" (after a push from another
repository). Then, if we (accidentally) switch to "B", and force update
with `--force-if-includes` it will _not_ be rejected because HEAD's
reflog has a record of the checkout and there will be an overwrite
if we check only HEAD's reflog.

Thanks.
-- 
Srinidhi Kaushik
