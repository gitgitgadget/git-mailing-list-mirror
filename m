Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66762C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128D264E31
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBAHIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhBAHFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:05:32 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5DCC061573
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:04:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z13so10140959pfn.18
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HmFwdIWyrYBP9MMBnyZpH8vYN2ettDFBg6tpGd+0GYw=;
        b=ksuvJjHGOYOVs8nFSe//VlCX5oe5RV3SnmDAnZ33kFlgRRa26BtG83HQVB5y5KksZ5
         yxJTzu1Ksq78toSzNv+eSNVhYJvOIVfBdKvCG0hsZ4lfCVV+UXWCJNFcNHGiM38fBDf7
         kGZ3S/MPyiJB+lj9lpWpS3YLSfs0k/rkZdggh7CDwiWDBuFclWcD/i571QwNUgDG629a
         fOhtm4dIPSgBvxcpFUgDbb5yfaTL/+QvomNbcTWw5wyAX/1ASIYcsx8Bxd8JJozRRTkm
         cNi8UeP6IUJ+7o1mlp+e9LvwHCqA/P6YkcYeqaGBVEXP4EWKkgwvu2lWqaxZV5KuRGDn
         oANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HmFwdIWyrYBP9MMBnyZpH8vYN2ettDFBg6tpGd+0GYw=;
        b=Sd5UeYC9FDwDv+TPpOT5J7cyuVpD49he+++/AibKv2r1oxXD1jTBXjOvzZZ6oNREk3
         Utk/Wzp4GWvPh3pQ9Qlo3xoDhH138MJisbA66+ORd+6g8auRXva+pd7x0xkddI9RDy2o
         bi3ZW3RIO6qmEuJm2BVVJTbiXO9cc+8P0bWO605SUKKSnj7OV9/r0itelEWIbYLWQKVY
         /fIZ6u6pSu0j8U9tp7FNZYMkq0JuGh4Y/EthhEVBHTcuAKf1yPEhIcghIPgvur7LySvu
         o6DFW5YEHOy1zHSJ2KIblTf1VcOS71Gu9BFqRFLusqS9bPYGb+t8HSeIKLOtozhTvtJZ
         K0Kg==
X-Gm-Message-State: AOAM533RPYahcUFTyKqZqy+CMvoxO8qucYlgOI8+kWtcxQXB5vseYJIe
        jqIZTXHZiXdHPOUz2TlI+rWPrtRcZFRCXGSeJUaI
X-Google-Smtp-Source: ABdhPJzD6HxG0RcEbTR4RLl3Czhf5ZpfO0zH1kWRxbXigPll1C2R4yzD8vskZibN3QsCxdn4P2MRU12kq2A8MdWuBf+7
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1393:b029:1b4:7938:ff1d
 with SMTP id t19-20020a056a001393b02901b47938ff1dmr15203863pfg.31.1612163090262;
 Sun, 31 Jan 2021 23:04:50 -0800 (PST)
Date:   Sun, 31 Jan 2021 23:04:48 -0800
In-Reply-To: <20201222000220.1491091-16-emilyshaffer@google.com>
Message-Id: <20210201070448.1325624-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-16-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 15/17] hook: provide stdin by string_list or callback
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In cases where a hook requires only a small amount of information via
> stdin, it should be simple for users to provide a string_list alone. But
> in more complicated cases where the stdin is too large to hold in
> memory, let's provide a callback the users can populate line after line
> with instead.

[snip]

> diff --git a/hook.h b/hook.h
> index 8a7542610c..0ac83fa7ca 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -2,6 +2,7 @@
>  #include "list.h"
>  #include "strbuf.h"
>  #include "strvec.h"
> +#include "run-command.h"
>  
>  struct hook
>  {
> @@ -14,6 +15,12 @@ struct hook
>  	/* The literal command to run. */
>  	struct strbuf command;
>  	int from_hookdir;
> +
> +	/*
> +	 * Use this to keep state for your feed_pipe_fn if you are using
> +	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
> +	 */
> +	void *feed_pipe_cb_data;

When would we need per-hook state? I see in patch 14 that you give each
running process little by little (in pp_buffer_stdin()), perhaps so that
each hook can make progress at roughly the same pace, but I don't think
we can expect all hooks to work the same, so I don't think it's worth
complicating the design for all that.

>  };
>  
>  /*
> @@ -57,12 +64,24 @@ struct run_hooks_opt
>  
>  	/* Path to file which should be piped to stdin for each hook */
>  	const char *path_to_stdin;
> +	/* Pipe each string to stdin, separated by newlines */
> +	struct string_list str_stdin;
> +	/*
> +	 * Callback and state pointer to ask for more content to pipe to stdin.
> +	 * Will be called repeatedly, for each hook. See
> +	 * hook.c:pipe_from_stdin() for an example. Keep per-hook state in
> +	 * hook.feed_pipe_cb_data (per process). Keep initialization context in
> +	 * feed_pipe_ctx (shared by all processes).
> +	 */
> +	feed_pipe_fn feed_pipe;
> +	void *feed_pipe_ctx;

Instead of 3 fields, I think 2 suffice - the function and the data
(called "ctx" here). We can supply a function that treats the data as a
string_list.
