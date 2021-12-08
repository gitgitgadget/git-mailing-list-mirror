Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C3BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhLHX47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhLHX47 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:56:59 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C13BC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 15:53:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id lt10-20020a17090b354a00b001a649326aedso4674290pjb.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 15:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X1nJ2BpOdyhjJslDvy7XXPjYbOpmrG8ID5H2qo89J38=;
        b=GN3TmQn+OsVP3CnMlhGAi+GRaUzLPMqflmQ9H51qgr41sPGBCE77ZYNYvhVeclytL7
         eO7GBVjiEC4mI7q3rS8thqU4OjjZWXAaFWvieL+KJq+NaiZWMo6QW913wzPcV8LKDIiP
         91UZIMWr9uOHZ6VR6J5optvRD1H4qZ09F8MxZKEFmnYv/lWP3RgLn+4r6sCvKGLiql70
         SVr1jP8aBtcouycwuvM5zBOWpD6B7hf1gwx4PiJq0J0xsuxeuCS9BV4FurVEW1gmEwv4
         Lp12DqXswAU/WFjBzjZWEGK33wf0W2viUKBA07N44TxtFen8jGVqCDqN3aEqkSbyC8Mf
         YuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X1nJ2BpOdyhjJslDvy7XXPjYbOpmrG8ID5H2qo89J38=;
        b=R2pOj25jR+vsJM/2SN5tUCehFMQ8PXKMnZ1x+bEi1tqyfdwALLKINnxTBg1mIYojB3
         wJZPqZ0oRILBakwVo6Z0ssBgZ5yrYjpI7GsB7aXI0XlsvirbnXogxvw9z6pT0IsedfMp
         c52oQmru9u1x201lI6BPQT0f4hp0aS6ZmFL3LV1bjlWbYio9c8fUIQbkHNgw5mgAwJrm
         5ZlimLGQWPiBgSMkWZEmG3DA6UQPE2vFmUZn0vC1GxnB87zZouWOniV4CzZftgY66QF5
         l9M/TLk+jTsOTxdDwp8Szh+YRg6Irj7HSqSV5PzAlqzmYLj+k5eF2QyGh5QLZlDQ8LXi
         W2vQ==
X-Gm-Message-State: AOAM5327uqkmrf7XqoC/S1fYSZd8AQQdSjE+BWEyTYtQh6lk6tkdjUoT
        2M1l4fsGhQMCwdzVLEAu1cTbLhMkKNCFdA==
X-Google-Smtp-Source: ABdhPJwYw2xWpPRifXKcwfSSAKMuilZJ8Nh5sBljXlwbeqYO09O94yIPo9pPObZRewvWYHgOnYrHymjGb7T3Lg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:22c8:b0:4af:437c:5f4c with SMTP
 id f8-20020a056a0022c800b004af437c5f4cmr8598404pfj.71.1639007606137; Wed, 08
 Dec 2021 15:53:26 -0800 (PST)
Date:   Wed, 08 Dec 2021 15:53:24 -0800
In-Reply-To: <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Message-Id: <kl6lr1amac23.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I noticed some test failures due to the printf_ln(msg_fmt) region. Since
you are reworking this, the problem might just go away, but I thought I
should mention it just in case.

> +		if (all_shortnames && origin) {
> +			if (rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s' by rebasing.";
> +			else if (rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s' by rebasing.";
> +			else if (!rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s'.";
> +			else if (!rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s'.";
> +
> +			printf_ln(_(msg_fmt), local, ref_string, origin);

Here 

>  		} else {
> -			if (origin)
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track remote ref '%s'."),
> -					  local, remote);
> -			else
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track local ref '%s'."),
> -					  local, remote);
> +			if (all_shortnames && !origin && rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local branches %s by rebasing.";
> +			if (all_shortnames && !origin && rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local branch %s by rebasing.";
> +			if (all_shortnames && !origin && !rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local branches %s.";
> +			if (all_shortnames && !origin && !rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local branch %s.";
> +			if (!all_shortnames && origin && rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote refs %s by rebasing.";
> +			if (!all_shortnames && origin && rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote ref %s by rebasing.";
> +			if (!all_shortnames && origin && !rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote refs %s.";
> +			if (!all_shortnames && origin && !rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote ref %s.";
> +			if (!all_shortnames && !origin && rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local refs %s by rebasing.";
> +			if (!all_shortnames && !origin && rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local ref %s by rebasing.";
> +			if (!all_shortnames && !origin && !rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local refs %s.";
> +			if (!all_shortnames && !origin && !rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local ref %s.";
> +
> +			printf_ln(_(msg_fmt), local, ref_string);

and here

>  		}
> +
> +		strbuf_release(&ref_string);
>  	}

We print ref_string, which is a strbuf. This causes t/t3200-branch.sh to
segfault on my mac + clang, but inconsistently! With -O2, it doesn't
always segfault, but the wrong memory is read:

  Branch 'my3' set up to track remote branch local from 'Branch '%s' set up to track remote branch %s from '%s'.'.

With -O0, it always segfaults.

You can see this in the osx-clang run in [1], but it looks like the gcc
ones refuse to build.

s/ref_string/ref_string.buf should fix the problem.

[1] https://github.com/chooglen/git/runs/4464134763?check_suite_focus=true
