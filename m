Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4131DC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 17:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3F96124C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 17:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhFRR45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhFRR44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 13:56:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639CC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 10:54:47 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f9-20020a056a0022c9b029030058c72fafso1212564pfj.1
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=38xlouQmrMVXES16a2btL25H/8r0d0nw/zo/BpECXkA=;
        b=WduzcD1JpfFc8N4O1WBlbmx6Ke+4krCx2rlTEWe+gu0BCA1cblshh0Q1cHE2xVK9Gu
         NWia6JfpR2cJDseXoUuZlNpSmuUqLgaKyVXyGFmWpUC5w3iJls2oQ0KWrNMS/tGGlm8o
         M0MgiUXF3hQ4SbVzt1ZADeoWcvyaSd0fo0OwCTnjjqbQQWrVvH9mXTGDr2R2B92DMHON
         9X5AZL1Bx/8RlvG2ATb+EzDURezXAoW/UCKuIgASjKMHI1MXwIpS7vRZ+tsWl6mASAT/
         cKDWnTfV5nkIGtwwzSDxmFYAYBmar7C/U5tld0XGEfL+Z+kxmT2dLWYX5Zq9yeC6MUpv
         QSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=38xlouQmrMVXES16a2btL25H/8r0d0nw/zo/BpECXkA=;
        b=M4Mq4O4YgBAWs7/XEWijuNNYQ0xvwpE4YxckYxDa8PrRGLK4+R73cIaCTwBDq/GlFu
         z5h72WxIzDT5FOcJTO8CPIlsEV19NcZBHG/QlN4PEIMZxU6PTyS36bKtcKJRl/XaQ05C
         9lbxNMCxXpTIO5q/3oubR5a0lArr4I9kMnGmDqcradp8CE5m38Wz+tBKEluVCSoZB5J9
         MpGk77az2bBYI4w0LrjxNBzAapKduoMuMOchp70HPR5R5rNqReyJQ1rsDx/lhckdABtR
         YPK1VILAbNd1Y+XS5rJ4kYI2G1fnfJvplm87xjUnJLneDqYI5q2IlEf4Arv8XGKtxouR
         s1sA==
X-Gm-Message-State: AOAM5335XKpYCA9TclP3LBt+WRg9IgSOFz7rW6P4zxget6i08cLNszrH
        ddqNep8W4YPSLxph7znWJ76YdJ3dSrhfRMlW1DIb
X-Google-Smtp-Source: ABdhPJxk8hOEstAMbaavxmQvFb4uXJLFC96tu/eG+/vMWt7up5n+4R0/QVBFfeImTMC+dK90PYiRsWLzDFi5PrHKAcwS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:c796:: with SMTP id
 gn22mr509626pjb.0.1624038886284; Fri, 18 Jun 2021 10:54:46 -0700 (PDT)
Date:   Fri, 18 Jun 2021 10:54:43 -0700
In-Reply-To: <patch-2.4-d88b2c0410-20210617T105537Z-avarab@gmail.com>
Message-Id: <20210618175443.773403-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-2.4-d88b2c0410-20210617T105537Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [PATCH v2 2/4] revision.h: unify "disable_stdin" and "read_from_stdin"
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        zhiyou.jx@alibaba-inc.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About the subject:

> revision.h: unify "disable_stdin" and "read_from_stdin"

Hmm...there is no unification, I think? Both of these remain distinct -
it's just that both were renamed and one was changed into an enum.

> @@ -114,9 +119,22 @@ struct rev_info {
>  	int rev_input_given;
>  
>  	/*
> -	 * Whether we read from stdin due to the --stdin option.
> +	 * How should we handle seeing --stdin?
> +	 *
> +	 * Defaults to reading if we see it with
> +	 * REV_INFO_STDIN_CONSUME_ON_OPTION.
> +	 *
> +	 * Can be set to REV_INFO_STDIN_IGNORE to ignore any provided
> +	 * --stdin option.
> +	 */
> +	enum rev_info_stdin stdin_handling;

This was changed to an enum, because (looking at the next patches) we
want to add an entry to it. Maybe mention it here - at the very least,
this will help reviewers check that the addition of extra entries to the
enum in future commits will not negatively affect functionality
introduced in this commit.

> +	/*
> +	 * Did we read from stdin due to stdin_handling ==
> +	 * REV_INFO_STDIN_CONSUME_ON_OPTION and seeing the --stdin
> +	 * option?
>  	 */
> -	int read_from_stdin;
> +	int consumed_stdin_per_option;

The usage of "per" here seems correct to me, but it's not the first
meaning that springs to mind. Could this just be called
"consumed_stdin"?
