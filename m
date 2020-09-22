Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C6C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4998B207C3
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Znz7C9FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIVXFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 19:05:41 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292EAC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:05:41 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q16so12475811pfj.7
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=odn46uN7g6uJp5RLL7DOc9tSeZOXIEvXky3AMTvYZ5w=;
        b=Znz7C9FA4eIvKLukwSlVAqNlKjWIArO7IqCmdZhZ4M10vcQvVP/nUnibpD7JnD1kXE
         0SOiNCyQL5W1K4tvy8HGgW/r6Lg6eIXxqSQn+mC594rpsIwFdZyPWHk5KqOeDmoP2Awc
         GThKV+2q4/7u7YxSsTZaFPmaGJwEC1eN8rBtlBxSiUYLAiSwXwJ5XHxn3BXdSRiaMrAY
         cvwsCdAA6euR3s/gG8lSjdWInE9WNV+0/rGdDr5vhX3cKvqI+ne0qmrtirRH99tpK7CG
         mugnvVNXvvNrrqF5UIS1PYC1QmqJF1JDt7FX3x/q9z97h1tNOKn6C9WPULZhh+3Hn7iT
         bsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=odn46uN7g6uJp5RLL7DOc9tSeZOXIEvXky3AMTvYZ5w=;
        b=UBK7sUfw0c+m8lSop+IZ6w7TN5/7MAgIg6bxt4deZbrBIHTUnlrWgi9JwRtuyNUD22
         PyLa9C0JkZ+y7U87K0AVQhQBopxZFpZS9isjU1y1g0XZvp/KcLXiQlGdJYCS1pzILULn
         M/4cWhiWTgtEXCALXVq5gDFKHeGARmrL4I5bxeuY2YquEp0IiHzGpiBlZUugd2UjwWCx
         kE0uimSTtnBxbWaPpBIT3wUs1GTVzyqQDXjdsWhVldFhHVWK4GuLVp4piBgU2oAr3IPJ
         zFOh6dvqW5JY+dVEGs+Jtt7z/n4Ca5qelzWYI6Ke3ZF1xZHwswyYZt9etzwNQ3pvHerA
         Nm/A==
X-Gm-Message-State: AOAM533INqd19Y1RM8osQ0bzrv3uqWJrbsOLg3kkosCRTvy5BlqcvUDg
        qis8KW4gGIt8X/jBPNLEoxE7F2m1h7vbePb45LcP
X-Google-Smtp-Source: ABdhPJw6Dp9stTNEoedSvwNMtL39kSWDMOsntE+mWv67jTNGBUzt9sqlzLmjhLBiRmq3LC0jLOBYqcUfMHcEH4UY6sQa
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:9697:b029:d1:e598:4001 with
 SMTP id n23-20020a1709029697b02900d1e5984001mr6844714plp.59.1600815940433;
 Tue, 22 Sep 2020 16:05:40 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:05:35 -0700
In-Reply-To: <da64c51a8182ec13aeed8f0157079fb29a09ee85.1598380599.git.gitgitgadget@gmail.com>
Message-Id: <20200922230535.903375-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <da64c51a8182ec13aeed8f0157079fb29a09ee85.1598380599.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v3 1/8] maintenance: add prefetch task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When working with very large repositories, an incremental 'git fetch'
> command can download a large amount of data. If there are many other
> users pushing to a common repo, then this data can rival the initial
> pack-file size of a 'git clone' of a medium-size repo.
> 
> Users may want to keep the data on their local repos as close as
> possible to the data on the remote repos by fetching periodically in
> the background. This can break up a large daily fetch into several
> smaller hourly fetches.
> 
> The task is called "prefetch" because it is work done in advance
> of a foreground fetch to make that 'git fetch' command much faster.
> 
> However, if we simply ran 'git fetch <remote>' in the background,
> then the user running a foregroudn 'git fetch <remote>' would lose

-> foreground

I have some more minor comments that I will send as individual replies,
but overall, the patch set looks good to me.

> +static int append_remote(struct remote *remote, void *cbdata)
> +{
> +	struct string_list *remotes = (struct string_list *)cbdata;
> +
> +	string_list_append(remotes, remote->name);
> +	return 0;
> +}
> +
> +static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
> +{
> +	int result = 0;
> +	struct string_list_item *item;
> +	struct string_list remotes = STRING_LIST_INIT_DUP;
> +
> +	if (for_each_remote(append_remote, &remotes)) {
> +		error(_("failed to fill remotes"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	for_each_string_list_item(item, &remotes)
> +		result |= fetch_remote(item->string, opts);
> +
> +cleanup:
> +	string_list_clear(&remotes, 0);
> +	return result;
> +}

I was wondering why the generation of the list and the iteration was
split up, but I see that you want to attempt to fetch each remote even
if one of them fails.
