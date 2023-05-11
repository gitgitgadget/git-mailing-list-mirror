Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A4C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 22:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbjEKWvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbjEKWvU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 18:51:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE39B5265
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:51:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64384274895so6618687b3a.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683845477; x=1686437477;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0Mtz7cZ99YrZUkEtX2osdXKttL1Ya2Pt4Ns99AUG+8=;
        b=D6DLlXfjZHxIc26v8TsxWb95Kvo5xUspmwUeo+AR2echQxW/2n+oZylJlHNxTNbweY
         kTu+xd/GUdPDaM1QaqAWBz01x1Vl1KElQcsx7+/iw2gUZEfGpSte9+fJBegwd8LhqREF
         Pc34JqBTx7lvkkixfSc3ThoubxNzJ8Q52xsKGxFJOGwAu1iDiunPVddVUbz2Hak6+A7X
         whUyyBS32bn1s2IUk7XrmTUZX3RtlncLWKcCOOSsNGvLoWG5DwccG1N+nmjqHCXlgr56
         g4xBEB216uYkY5/rwb+dX4VDDRDyOLVIPuADQdNw6KijH6GMGCjK1Q0O7N6UGG2Q39a0
         6cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683845477; x=1686437477;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0Mtz7cZ99YrZUkEtX2osdXKttL1Ya2Pt4Ns99AUG+8=;
        b=OyrVm4noXAi1PrJ00T0BjxwBaOPkJCAxDYmyob1aAZt9iWj106zJz8lvUJcse0V0XK
         /UMJYDuqL2Y7mBhQaxEyuyGQWkqG94/6SU66V8fB9wBO50V6HsLonCVi60xXxhG8a2WA
         JiwPNCVt0bBGNdbe0sDT3xVBuC8CN2wwkPJRwITtzBeJIycJ2zAKh2rXv8mKj6gzKj5W
         crQ0YfkrbMJUOn88ljpQGv4ffrheOHv814Ix3bhiEb5QSusYNv5PfE0yxN6iha2417eA
         YpoNSD8GV/jTZR7HbTTNKT38oGrbFFdM1QOjIYndPk4BHopHeGpTlV+V961H2bIJHN/3
         +bEg==
X-Gm-Message-State: AC+VfDz6zEJr2AXoj+wlW16+IGH3PJO1VCc58uoDMcKthI6a/UmAki9o
        EKX+LrgPzBCDV0/ykVQXtr4=
X-Google-Smtp-Source: ACHHUZ5yQm6JGh9t4nvoY5VTA8tdRvJm2egM+xhYWJ8XkIqGhAN5hI/nTTDUdMKzR5NcOT4qeD4sfA==
X-Received: by 2002:a17:902:db06:b0:1ac:712d:2049 with SMTP id m6-20020a170902db0600b001ac712d2049mr21135950plx.6.1683845477088;
        Thu, 11 May 2023 15:51:17 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902650900b001a6dc4f4a8csm6523715plk.73.2023.05.11.15.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:51:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: Changed path filter hash differs from murmur3 if char is signed
References: <20230511224101.972442-1-jonathantanmy@google.com>
Date:   Thu, 11 May 2023 15:51:16 -0700
In-Reply-To: <20230511224101.972442-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 11 May 2023 15:40:59 -0700")
Message-ID: <xmqqjzxetrbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> So...how do we proceed? I can see at least 2 ways:
>
>  - Decide that we're going to stick with the details of the existing
>    implementation and declare that "data" is always interpreted as signed.
>    In that case, I would put "signed" wherever necessary, rename the
>    function to something that is not "murmur3", and change the names of
>    byte1 etc. to indicate that they are not constrained to be less than or
>    equal to 0xff.
>
>  - Bump the version number to 2 and correct the implementation to
>    match murmur3 (so, "data" is unsigned). Then we would have to think of
>    a transition plan. One possible one might be to always reject version
>    1 bloom filters, which I'm personally OK with, but it may seem too
>    heavy a cost to some since in the perhaps typical case where a repo has
>    filenames restricted to 0x7f and below, the existing bloom filters are
>    still correct.

If path filter hashing were merely advisory, in the sense that if a
matching data is found, great, the processing goes faster, but if
not, we would get correct results albeit not so quickly, a third
option would be to just update the implementation without updating
the version number.  But we may not be so lucky---you must have seen
a wrong result returned quickly, which is not what we want to see.

But if I recall correctly we made the file format in such a way that
bumping the version number is cheap in that transition can appear
seamless.  An updated implementation can just be told to _ignore_
old and possibly incorrect Bloom filters until it gets told to
recompute, at which time it can write a correct one with a new
version number.  So I would prefer your "Bump the version number and
ignore the old and possibly wrong data".

Thanks.
