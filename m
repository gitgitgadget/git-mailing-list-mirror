Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E524C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59AB60FDC
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhHTAJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTAJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:09:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA4C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:08:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w8so7469280pgf.5
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nHAkTExAT6RnaeYKOtdj9ZnStCSHAX9Bbn1S3H5b4Rw=;
        b=YB94eJPxrqVUZnNwTvHg3fQ9ME8SI0NQ334xYnnvxdUD7GHUaAKYgmZR23Z/AGrTNl
         ep6zLxtKuHlCA6SJoSdVhT0Kx3kFkQFPuBA6ShrM8O+gvPQan/CSUfI5PGf6QoTUqAmN
         8Oqvm62K+4+njMo9cvlmK/WFNfdYQ1IAza2hYZwiFlCOl273mvAKjfuDZaBuODzUiA8W
         +ThPM/88yvUwZBcguQbWblH5FPi6L4G7FTxCs60roTt3nfoeKudZoVVx+CzoqRE/0pYZ
         B+N90zSpA/kQf6JGXHvE4EU0Ew4xr3IqAJERVJzLmyPKj+AUVWER4AHuPgOkhnpeIum3
         EKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nHAkTExAT6RnaeYKOtdj9ZnStCSHAX9Bbn1S3H5b4Rw=;
        b=HgpcXpwTK7RjZPS02LRF2edpWuIJBVC88Da/yoQnQ/pBeFqqbKkQbaB3ZD4YDWD4jy
         o6v81g1LsRFj+8xlLeIytk/FtRXWyqocFcz+bInJxsdHwAy+fRw3ROwhR4S2F5Ill+qp
         nZIPGJel/AE0gZHTcQk4E95CAZIW79g0P0enpkXBmKKccftGrlPczqTVhshbpgiwPM+N
         BI/bnxD2kMaSx7jOBjWeBkWIP4rPkgYN3ITWuHaVhSN01qx1ATza3Ox3q8yO2V6BUVfQ
         LHfzCOmItLRPamT6T+ruedCgiqWUp26n/5n4wTv1AtZdgvPGXJMnn3rvgaoR2XOpSroj
         AAgw==
X-Gm-Message-State: AOAM530X1XsnqSdhaffShJU4x/wNmwpU43ViWn3Cqro/s6tPoDZh/zA1
        EGQY6rdEbx1KtPitL8dSH6iofA==
X-Google-Smtp-Source: ABdhPJxtiCQKlUsbMxtkByHK1hP8s1QtJ8Lbg0i0jIsYQ9P+4pWc/IgLRRlCWLfJb73achUCPvB33w==
X-Received: by 2002:a62:ee11:0:b029:3e0:88dc:193f with SMTP id e17-20020a62ee110000b02903e088dc193fmr16572581pfi.78.1629418118831;
        Thu, 19 Aug 2021 17:08:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id s29sm5696381pgl.38.2021.08.19.17.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:08:38 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:08:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 04/36] hook.[ch]: move find_hook() to this new library
Message-ID: <YR7yfiJXJutOKhn/@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-04.36-89c4d44b0c3-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-04.36-89c4d44b0c3-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:30PM +0200, Ævar Arnfjörð Bjarmason wrote:

The subject is now a little confusing (and I guess it would have been
before, too). Can we remove "this new library" and replace it with
something that makes sense on its own?

> 
> Move the find_hook() function from run-command.c to a new hook.c
> library. This change establishes a stub library that's pretty
> pointless right now, but will see much wider use with Emily Shaffer's
> upcoming "configuration-based hooks" series.
> 
> Eventually all the hook related code will live in hook.[ch]. Let's
> start that process by moving the simple find_hook() function over
> as-is.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

It doesn't make sense for me to add a Reviewed-by line here, I guess.
But it seems to me to be fine to do this early on instead of at the very
end.

 - Emily
