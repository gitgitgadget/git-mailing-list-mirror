Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E888DC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B354C2075E
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEMpdWcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHSAJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHSAJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 20:09:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D3C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:09:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u189so23989991ybg.17
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xXTGQZgAdKMvbZRRvQtdkjau3HqHBolsO/at+KOL3m8=;
        b=vEMpdWcR/V9rIet0L9a3+FPVKMcQyvXKcF9H3Ov/iiIT7Tdoalf1IL5TcdvEgm6s1l
         +8Gq3JbXigeRaAIMB+hSGpkcOqdkBDMCCGmwbwnT7Qhr1/n2tpt2Qh/Z/A6M28W46IsW
         6i67WveVKcZQTcW9q++a1yvBNEVG7Wbji8PyrsaORJ6rT8E/eU9I7yHGUfeKQg4Fi5Qn
         T4nCq7u5IIOTiJGtsWD1HxxfJJzbDPf80MtPKo3SCT/I+ane7JN9kD/L5B/qvjeSlAVN
         /mYqNf1bzp0kESocyyQUY92p3Uj/9uhlESP51mjjWbSjLagnu0qOcTWQVvvNnMaKNezz
         SZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xXTGQZgAdKMvbZRRvQtdkjau3HqHBolsO/at+KOL3m8=;
        b=YcCTW4rg1WNNsLMQs7E/EvrLiwIfYUgZ3F82NRCbhoe4CFX5kBqZZ3C7CHPLMrgU9C
         a2JSjH7C4A6DzhTojHqoJz2sVURDZ95TjAWP8h4d/mWCk+QCWVEGSWIsyycflJLd9/su
         Dc2o8orjh5d0NEPRkZbN6MkoI8x8xH8tY6Nij+wB8+YmseEo/zKxB0yxHt4xRkqMQOmT
         0m5KMUifMv2Z2jsQkoP61sGQGvmDeZr3gGPYC3k2ZYA99AqwGOU28nI/OeL9LwegpHcl
         8WHNV3wJ8EZXb+oqTYzRNi2/wmadjV44JYlsSZa2n7+Ed889RBrB6abNMcXXtuNDgI49
         Um7A==
X-Gm-Message-State: AOAM532a+OH/maU+ftoGM0J7xH+e662TE/rugFZVM5mOWlq+fOFS+F0K
        X2RbaKXYns3ajlkJ5ERk0NDla4yk2AbaULaHDdP2
X-Google-Smtp-Source: ABdhPJzLQw3FuChPT6Aas1h/WzrTpxlpA/VSepWeS9T/w6xBntXpjqCFSKASGTdNUUTlUJcKiI2bjvG1mAAA7bBkkATk
X-Received: by 2002:a25:84cd:: with SMTP id x13mr30446459ybm.425.1597795789580;
 Tue, 18 Aug 2020 17:09:49 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:09:47 -0700
In-Reply-To: <fc097c389a963065fc0bb5991bdebdca8824b121.1597760589.git.gitgitgadget@gmail.com>
Message-Id: <20200819000947.2844392-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <fc097c389a963065fc0bb5991bdebdca8824b121.1597760589.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH v2 10/11] maintenance: add auto condition for commit-graph task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Instead of writing a new commit-graph in every 'git maintenance run
> --auto' process (when maintenance.commit-graph.enalbed is configured to

s/enalbed/enabled/

> +/* Remember to update object flag allocation in object.h */
> +#define PARENT1		(1u<<16)

Why this name? "SEEN" seems perfectly fine.

> +static int num_commits_not_in_graph = 0;
> +static int limit_commits_not_in_graph = 100;
> +
> +static int dfs_on_ref(const char *refname,
> +		      const struct object_id *oid, int flags,
> +		      void *cb_data)
> +{

[snip]

> +static int should_write_commit_graph(void)
> +{
> +	int result;
> +
> +	git_config_get_int("maintenance.commit-graph.auto",
> +			   &limit_commits_not_in_graph);
> +
> +	if (!limit_commits_not_in_graph)
> +		return 0;
> +	if (limit_commits_not_in_graph < 0)
> +		return 1;
> +
> +	result = for_each_ref(dfs_on_ref, NULL);

I don't like introducing the mutable global num_commits_not_in_graph
especially when there seems to be at least one easy alternative (e.g.
putting it in cb_data) but I know that this is a pattern than existing
code.
