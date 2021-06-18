Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF1DC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436AD613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhFRS7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhFRS7m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:59:42 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF34C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:57:32 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 5-20020ac859450000b029024ba4a903ccso8192130qtz.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dt/AIQBFN2nMKOg+aEECTxRqkYZiil6hoj1EwwxGGps=;
        b=DH62ovt1sjsavxWtCGGulEoCYSdXXT5AIKZbCzW+ysKMdnD3ucHLBvpjJjgyLoQmb8
         2Hzd3dlB96Z0mj0lECZb4GwCgV3CzTIuhbN5qeNYRMnCx+7xCs3pHBIjFhvwkTcTnvZI
         aIujn1aAkzXGnpVbtoOX7Hy4OzqCniehwWtIWYem3oiOecxCz78OM+wi6jdhs77uTelo
         RZoYQe1SF8k8TcXLD3NQygOJYdTdbPqUxlyRlEABZwKlWSlVUgie5D5kTWA2eaFDaueI
         SVGi27nMJ1GA+zfAopBU8g67v5yl5c4737n/WyG7yT8fhm6HapVfoCfVoXwK3fXDZZMo
         gGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dt/AIQBFN2nMKOg+aEECTxRqkYZiil6hoj1EwwxGGps=;
        b=Fb8u9ECP/p9TBCho5V6Nx3RiqwPg8tZcrMRThhJiRQvdSNPPY+0UTDkek0p5riv24C
         Wgp/0e0CiFaIAfRITHl8TcbLMTLQHj9guv0ws1BIy8jec+RrkA9y2i33C4iq3bbodwhY
         gE9KXng6UQZ6tZxRUrztyAxY7cl5GW2c3QxL/WD4IwyDt564OWVPl0NatnxKGGHR1KN9
         J0lGUenmKMaUmyXRSMI+3Wx+6B3idDlH6JAoXodWMW2oHVYmUGyiTMX6tc9Lr09U5rGB
         rQxB5Rlv8WHxJVmOfbAxtV4vt2rRbrAojo00x6ZL0AQobA608PABPl4htQoY6daeEFkr
         ajMQ==
X-Gm-Message-State: AOAM531YZGhqNajQ29Csf3bYWTBxHXX85V3vgTxZJzClpDx0PjKAknnB
        sDBedcibhJFZi3GGmbxaZJFB/hv4N9BXXxMFT36H
X-Google-Smtp-Source: ABdhPJwH0FoAjHIZ6lAd5u8WciCjm+yt2Ads/Hdv06O6+kkilE1mgD1BUHWR+h2G+nH4sxawbn2a13p/jzanhB81PNai
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:4256:: with SMTP id
 p83mr15287213yba.212.1624042650960; Fri, 18 Jun 2021 11:57:30 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:57:27 -0700
In-Reply-To: <patch-3.4-d433d7b24a-20210617T105537Z-avarab@gmail.com>
Message-Id: <20210618185728.779629-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-3.4-d433d7b24a-20210617T105537Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [PATCH v2 3/4] pack-objects.c: do stdin parsing via revision.c's API
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        zhiyou.jx@alibaba-inc.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Change the fgets(..., stdin) parsing in pack-objects.c to use a
> now-extended version of the rev_info stdin parsing API.

This leads me to think that the stdin parsing API is already present,
but it turns out that it still needs to be extended. Maybe rewrite this
as "extend the rev_info stdin parsing API to support <whatever we need
to support>, and change the <...> in pack-objects.c to use it".

> @@ -136,6 +149,28 @@ struct rev_info {
>  	 */
>  	int consumed_stdin_per_option;
>  
> +	/*
> +	 * When reading from stdin (see "stdin_handling" above) define
> +	 * a handle_stdin_line function to consume the lines.
> +	 *
> +	 * - Return REV_INFO_STDIN_LINE_PROCESS to continue
> +	 *   revision.c's normal processing of the line (after
> +	 *   possibly munging the provided strbuf).
> +	 *
> +	 * - Return REV_INFO_STDIN_LINE_BREAK to process no further
> +	 *   lines, or anything further from the current line (just
> +	 *   like REV_INFO_STDIN_LINE_CONTINUE).
> +	 *
> +	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
> +	 *   line is fully processed, moving onto the next line (if
> +	 *   any)
> +	 *
> +	 * Use the "stdin_line_priv" to optionally pass your own data
> +	 * around.
> +	 */
> +	rev_info_stdin_line_func handle_stdin_line;
> +	void *stdin_line_priv;

I assume that all 3 of these are needed now to minimize the diff (which
is fine), but maybe comment on which of these are intended to stay and
which are only temporary. In particular, (once things are stabilized)
when would a caller need BREAK?

Also mention what happens if handle_stdin_line is not given (I presume
that it would just be like a no-op function that returns PROCESS every
time).

Looking at the bigger picture, though, and looking at the next patch,
this looks like a confusing API especially with the presence of "--not".
(In the next patch, you had to introduce a flags field, and the callback
has to remember to always handle "--not" and to toggle the flag.)
Perhaps the "--not" problem can be solved by making it revision.c's
concern and having the callback take a boolean parameter indicating
whether "--not" is active or not.
