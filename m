Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C63FC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346454AbiAKCTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiAKCTP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:19:15 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32890C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:19:15 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id ik6-20020a170902ab0600b0014a1e5aab34so2720873plb.21
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dqIWeR6q1b6Y34YnavF5f51IOfw1RUORif4AjPNbiGc=;
        b=MRZbhdTbw/cL5ouIcAeSv2QwVx+WwBPt24F/55EBkx1TlykKzd7uYJhR+bjjXO2aI3
         eHBqqF/wYVOGg6pYMo42pSjvxr9LIiXAqDMglfU1fCXHFAep83OghxTQtcZNktGgUJ/b
         0pJUzR8NiwBI9zB410N+Mlhs03djptzhahKo5wzjPbZ7u+TQ8R9qmgVrUzj6nw7NhKMq
         RWrWkcMlQgrrt94e0gLfncrOcJ1Ia+URCzPC069iz7EqOFOAvEq89B66ncKk+0tsWApl
         7U2Vt8aYYg3Ir+qv0SuhPXTpitXrEiL1fycUUDq3efZAFs2DTgiOhfE+CfpH3PDvoEH4
         B9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dqIWeR6q1b6Y34YnavF5f51IOfw1RUORif4AjPNbiGc=;
        b=25T2CS3ny7mx5c1I+AMeyH6qkBJKcUiXwW2IX0UB9O8arAY4L6o85quz4Ct5JEOyyC
         qsCICZBFIfUIInvdEzOax82ZOCbkFeyqHFsfPFvkVRduy1dMJEWX9fp1baZtr+nxh1A7
         enuAD3BRmONs4g57YmLt3Fa70/dxWyrfKI8jpjLRM0PIYm0/W/K9WZrBKq9V30+wTdtY
         TGA6qQHxmg0wCOO+mCctazJyNTIEl7dNHXWgsJiWTOpbvAtMUlrj4aNKlEVycURqyvB7
         2REYX64sm8lM7IXLZuxoz3vEwESDtyH/2GbPMlgISbaH5sDVD0IdwHie+5bcOPwgHSau
         dkQA==
X-Gm-Message-State: AOAM533P62qaQjY5mOfxyV7k2r9uAZXWZyM0PJBjKmye6K96EjFT0ohn
        BTw8OGZ+iDSSXx4o5xasPQlUsBO7yxUpV4d4542g
X-Google-Smtp-Source: ABdhPJwXPw3LrWS+KYpZkCVHSs4IAH7SDLrQq4f7QKItLyLu6CzKVVpTilplh7EYLAKx6rD4bR5e2v6IRTkaLMbIEidy
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:688d:: with SMTP id
 a13mr761878pjd.164.1641867554627; Mon, 10 Jan 2022 18:19:14 -0800 (PST)
Date:   Mon, 10 Jan 2022 18:19:12 -0800
In-Reply-To: <20211220233459.45739-3-chooglen@google.com>
Message-Id: <20220111021912.1228794-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-3-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH v6 2/5] branch: make create_branch() always create a branch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> create_branch() was formerly used to set tracking without creating a
> branch. Since the previous commit replaces this use case with
> dwim_and_setup_tracking(), we can simplify create_branch() so that it
> always creates a branch.
> 
> Do this simplification, in particular:
> 
> * remove the special handling of BRANCH_TRACK_OVERRIDE because it is no
>   longer used
> * assert that clobber_head_ok can only be provided with force
> * check that we're handling clobber_head_ok and force correctly by
>   introducing tests for `git branch --force`

This might have been more simply explained as:

  With the previous commit, these are true of create_branch():
   * BRANCH_TRACK_OVERRIDE is no longer passed
   * if clobber_head_ok is true, force is also true

  Assert these situations, delete dead code, and ensure that we're
  handling clobber_head_ok and force correctly by introducing tests for
  `git branch --force`. This also means that create_branch() now always
  creates a branch.

> @@ -426,15 +426,17 @@ void create_branch(struct repository *r, const char *name,
>  	char *real_ref;
>  	struct strbuf ref = STRBUF_INIT;
>  	int forcing = 0;
> -	int dont_change_ref = 0;
> -
> -	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
> -	    ? validate_branchname(name, &ref)
> -	    : validate_new_branchname(name, &ref, force)) {
> -		if (!force)
> -			dont_change_ref = 1;
> -		else
> -			forcing = 1;
> +	struct ref_transaction *transaction;
> +	struct strbuf err = STRBUF_INIT;
> +	char *msg;
> +
> +	if (clobber_head_ok && !force)
> +		BUG("'clobber_head_ok' can only be used with 'force'");
> +
> +	if (clobber_head_ok ?
> +			  validate_branchname(name, &ref) :
> +			  validate_new_branchname(name, &ref, force)) {
> +		forcing = 1;
>  	}

Also assert that track is not BRANCH_TRACK_OVERRIDE.

> @@ -42,6 +42,23 @@ test_expect_success 'git branch abc should create a branch' '
>  	git branch abc && test_path_is_file .git/refs/heads/abc
>  '
>  
> +test_expect_success 'git branch abc should fail when abc exists' '
> +	test_must_fail git branch abc
> +'
> +
> +test_expect_success 'git branch --force abc should fail when abc is checked out' '
> +	test_when_finished git switch main &&
> +	git switch abc &&
> +	test_must_fail git branch --force abc HEAD~1
> +'
> +
> +test_expect_success 'git branch --force abc should succeed when abc exists' '
> +	git rev-parse HEAD~1 >expect &&
> +	git branch --force abc HEAD~1 &&
> +	git rev-parse abc >actual &&
> +	test_cmp expect actual
> +'

These tests make sense.
