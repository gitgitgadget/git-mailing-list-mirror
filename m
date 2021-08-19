Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2D1C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 00:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498DD610A6
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 00:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhHSASe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 20:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhHSASe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 20:18:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1EDC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 17:17:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa17so3806966pjb.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t1qzoRiBceuqCTwQ7Bt+4GOeYiaBEbnQQfHFVhhnZi4=;
        b=WDpgP2KUAM21Vs6oeNrWfOWXPJctSligIgFSkj0VIXkuWiLEUWHFRvWLIVt8oo/dH0
         vdRHzAJxsTc1Vgg2yC4DhFI+MCltxEMOkvidUpbMmbMtHNPq3HXa2rIfoWesq9K1R5hi
         kuDnMEMEwvvIb3E3ixSZUFu0bwNL8wlqoyEc8jdMkQA6vsNBAZPqdPhMKDIxgsKWTgit
         tRwfwFl1pRX7RQJf67qYiiuza07DhvCL+XCIjGb8R3l+x94BqQ3ldLXeKtyW3z0I28Lu
         8B9B0OZ5mWXjiKKBhOPekagovPEkbpfwE0Kcr/Wgd94ldAjxFnqA8bCa3Dh158s2UmlG
         6uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t1qzoRiBceuqCTwQ7Bt+4GOeYiaBEbnQQfHFVhhnZi4=;
        b=EA8oL8ZJC63Ws3hUBFNlxqkOmQmGv8BUQha4SyARmiHqTbd3dBsF5ikX52pLGf7xQm
         Sp795E0PpzmVH+XV+kr54piUAu8HL4ctmaEpGzxk+9alnq7siGjUjmGzPk1MZEU3qfZM
         qi+9Y495Lky9+1smb7DEkM5lfPs7FMZNlb4tXTVzx4y+KRpq2Gco7c4bqBcKvjbJ89DX
         f8J+h1DSQj0oMRR2LnbktZhx04yVfh8HePdTvR+5rjXf/fQWpGVV9iiCCPbYwUjPB3l5
         2hPwTSn11M8N8VrxHI4fKfMeDO0TqbkCXiKWJmRbwnMrD8anlf8BaHiR/AlEaP4osQ9F
         14Vg==
X-Gm-Message-State: AOAM531NHag6ISpvJjmcz2Mf7O1AsodbuhHLW3iLmn7QROY+70y0IXig
        FeXhDY4zGL2/QKUtHe41JvVvAQ==
X-Google-Smtp-Source: ABdhPJwBycecM9fbVEFis2RdVz87RD4GMKeSS1KN08qV+sr2WOK6dVAkra2Rt5P+JkOY176l7JoyRA==
X-Received: by 2002:a17:90a:7881:: with SMTP id x1mr12132938pjk.102.1629332278172;
        Wed, 18 Aug 2021 17:17:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id 129sm962584pfg.50.2021.08.18.17.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:17:57 -0700 (PDT)
Date:   Wed, 18 Aug 2021 17:17:49 -0700
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
Subject: Re: [PATCH v4 00/36] Run hooks via "git run hook" & hook library
Message-ID: <YR2jLdYQA5CVzX5h@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> This is a v4 re-roll of the "Base for "config-based-hooks" topic.

I performed the rebase of my series on top of this one, and did not find
very much objectionable there, but do not consider this email a thorough
review of the interdiff. I expect to have time for that later in the
week.

> Other updates:
> 
>  * In the base topic the s/Signed-off-by/Reviewed-by/g from René
>    change that Junio applied locally has been folded in.
> 
>  * Almost all the callers were just "one-shot" callers, I introduced a
>    new run_hooks_oneshot() function for those, which gets rid of the
>    verbosity around memory management, see e.g. the "builtin/gc.c" in
>    the range-diff below. That run_hooks_oneshot() can also take a NULL
>    set of options.

I am not so wild about this, to be honest, only because after my patch
2, it is hard to understand whether or not a hook is running in parallel
or in series. It is extra code-reader overhead to know that
run_hooks_oneshot() assumes that a hook can be parallelized, and I think
that is unfortunate.

But that is a pretty minor complaint, and I do like the lower
complexity, and I agree the defaults are "good enough" for most hook
events. So I guess I'm asking for ideas on how to make it more obvious
what this oneshot call does in terms of parallelism.

Thanks, and I hope to get to a fuller review of the interdiff soon.

 - Emily
