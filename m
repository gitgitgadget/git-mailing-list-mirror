Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B987C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB560F4B
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 19:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhHPTne (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTnc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 15:43:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E26C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 12:43:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 2-20020a17090a1742b0290178de0ca331so13264807pjm.1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x/rs9Zw54Y7rRXWssPqccgnTUpEGfZF5xkWXAvigKIs=;
        b=AS6yz+ZTy1dSKmY6t7ykxtQe3KaQ2IIaVPzNWQPQiw7KM8uOw2zpfd3kKpms8tU4xQ
         RfZPNyjyjxbH8oTDx3MMd6YTXulbvseT/SF3jgmBOvJObe9kDq8rT40mQOLBNbXI7j3m
         UeG+HWJIOuW189kI8QL3XtEg4qZOSac86dnEpoai3lTkamDigWwSmztmXX2wI7R7l+oc
         JuLEjRTPJecdZoaI9Drc+C2+FKgMxp0cvo9IhPkP0lf8WDFszq3TvcMxeXK2wwDKR0Qp
         lozz/9K1oMMZhgOXgjELcMVg2m8IDJ+Q8K0qW41kuPgy0GWs7oCN08/BjjQdmZaWxlZw
         qPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x/rs9Zw54Y7rRXWssPqccgnTUpEGfZF5xkWXAvigKIs=;
        b=Hb4cvV9rHC/xz7BjrceFxJenH5mEmJs8xkZapsT+r9z86LcOFqA4A1bRd7E6xhzckB
         4WvrclMwd1llp6iAT1v79AtJMVCOjXAjOfgqLEFUlK6JAI2iJTBuQv7gMeY88XqvqzPb
         J6UP/OI9zyKByXB1n3S+FglFoIclcD940GWODxUE16vssNmsL1sII9gcrp9Ozsxxuj6H
         7teL9nwUraKSKF5vkbjKKVc4P88RIJ8Zxa2GMTfc3STCGsgpJFRszQN6SsOAUXM0Buz0
         TiSY8gZEG/A8jgBOBjqBz8IBlZjENtca/rL4OpSQFP3jOXrUVOwVangi8AlcCeneAQqo
         Yyag==
X-Gm-Message-State: AOAM530CPBZhjkQ179aZ+QOw2sSqjgjPMp+cG2VJ5xd2f19NAc3weBzG
        YplEb7I8Xd9MT+5b6m3ZALGLN/s65PvWAP8JhIlV
X-Google-Smtp-Source: ABdhPJyqyo/4/Y3tf5rtzGSF9fVr1iGQmb+nSj7T6c7YvWJ4Lwk4IvVuERT4rULrqlIJY9AKaX4UOgv2O5DrjPdFgTFT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8159:0:b029:3bb:9880:d8e8 with
 SMTP id d25-20020aa781590000b02903bb9880d8e8mr339029pfn.3.1629142980198; Mon,
 16 Aug 2021 12:43:00 -0700 (PDT)
Date:   Mon, 16 Aug 2021 12:42:55 -0700
In-Reply-To: <xmqqh7ftuihx.fsf@gitster.g>
Message-Id: <20210816194255.1635406-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqh7ftuihx.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH v2 5/8] grep: allocate subrepos on heap
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, emilyshaffer@google.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +static void free_repos(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < repos_to_free_nr; i++) {
> > +		repo_clear(repos_to_free[i]);
> > +		free(repos_to_free[i]);
> > +	}
> > +	free(repos_to_free);
> > +	repos_to_free_nr = 0;
> > +	repos_to_free_alloc = 0;
> 
> The clearing of nr/alloc is new in this round.
> 
> It does not matter if we won't using anything that allocates
> repositories and accumulates them in repos_to_free after we call
> free_repos() once, but then clearing the nr/alloc would not matter,
> either, so it may be more consistent to FREE_AND_NULL(repos_to_free)
> here, not just free(), to prepare for another call to ALLOC_GROW()
> on the <repos_to_free, repos_to_free_nr, repos_to_free_alloc> tuple,
> which eventually will call into REALLOC_ARRAY() on the pointer, I
> would think.

Yes, FREE_AND_NULL is more consistent. I'll change it.
