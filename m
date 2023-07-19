Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F97C0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGSSKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGSSKw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 14:10:52 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250C411C
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 11:10:51 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so7132837276.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689790250; x=1692382250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oY/V9b0gbxYoeGMqnQVxjIpLm7oMb/w1bvVRns3EzyU=;
        b=j8BQe1U+2mWMsH2H4c4RFidutFvJtlYbjGTImNn3mHaxB9cUhQ4HS0kcr7wL2SsZVR
         C7MLw+dvbChzCqw+okOYPUk3s/pUv/8F/a3Xa3kQiH/F6CkWKq0h7MJX38kq7Xf5aUAF
         aWsKYnVU2iNStFJPo89Z0IgRmZkntfJ8yV7xVRvtcsInR94tdtPCtCSMtgU+U5mXQ+vP
         7jLzJbEi9DXytWdmmWnXdJWvYOhCjnJJZpqqvpU1GcKt+NriCECdYES2YJcA5JHKza0F
         HZSD6ITYD2dz6EyHXEe41LnXr+UGfN2c0wvsTnnJ1kFX444jIMjTKV4MKna4gJFNf5xz
         Z+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689790250; x=1692382250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY/V9b0gbxYoeGMqnQVxjIpLm7oMb/w1bvVRns3EzyU=;
        b=TVHtcfd6efi/QRw+DBx4GkJfvPQIxBo7t4nsv2qNO7UqKCGdxQGhq5yYVZfcfTxerJ
         s6y3MB7eNLx7+VRU1vPKkj8clxX6FuVWKxhc7q9rSHR2mYqw+KiUUjP57QGJ3ImthHt9
         Sng/TxvpeLTAF1Y+7HftGQaaXJElm32KO6CtGOCCKz5uZJuvsq49+XP7aVc9F5KsuCWS
         /4i2o2sqOR8r3799zJGarzvXh9l7Xqlw44hEh4U2G6BauVoFWsDAAJIYZqk0h+YNvjrT
         ylz65na/Xdbo6RwrgbVnuI5tp02IlSXczSDKf9L5kiAB1HP4EbZVVD5n7nU3d/OmBBSo
         tr3w==
X-Gm-Message-State: ABy/qLYCOZiG8fImDEfk+ZAfhhg3qF6jwDz6b9tDbCoEhM7J62OgKFOm
        A+p8v6KFxepDsRXlz5OEifetdw==
X-Google-Smtp-Source: APBJJlEtaqbWvc83r9cwnBlEwx5KclymrNzcXI9mbdSVBH+DUKM09LI5Nmtbc0zSv012qFuZdJGO1A==
X-Received: by 2002:a81:9189:0:b0:583:6db3:a007 with SMTP id i131-20020a819189000000b005836db3a007mr1630924ywg.17.1689790250339;
        Wed, 19 Jul 2023 11:10:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z16-20020a81c210000000b005731dbd4928sm1115581ywc.69.2023.07.19.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:10:49 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:10:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <ZLgnJdo3o9WA5sNy@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1689283789.git.jonathantanmy@google.com>
 <131095666d414ff68416526112c8f8deb31ac9e1.1689283789.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <131095666d414ff68416526112c8f8deb31ac9e1.1689283789.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 02:42:10PM -0700, Jonathan Tan wrote:
> diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
> index 30604e4a4c..07f3799e05 100644
> --- a/Documentation/config/commitgraph.txt
> +++ b/Documentation/config/commitgraph.txt
> @@ -9,6 +9,19 @@ commitGraph.maxNewFilters::
>  	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
>
>  commitGraph.readChangedPaths::
> -	If true, then git will use the changed-path Bloom filters in the
> -	commit-graph file (if it exists, and they are present). Defaults to
> -	true. See linkgit:git-commit-graph[1] for more information.
> +	Deprecated. Equivalent to changedPathsVersion=-1 if true, and
> +	changedPathsVersion=0 if false.

What happens if we have a combination of the two, like:

    [commitGraph]
        readChangedPaths = false
        changedPathsVersion = 1

? From reading the implementation below, I think the answer is that
changedPathsVersion would win out. I think that's fine behavior to
implement (the more modern configuration option taking precedence over
the deprecated one). But I think that we should either (a) note that
precedence in the documentation here, or (b) issue a warning() when both
are set.

For my $.02, I think that doing just (a) would be sufficient.

> diff --git a/commit-graph.c b/commit-graph.c
> index c11b59f28b..9b72319450 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -399,7 +399,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
>  			graph->read_generation_data = 1;
>  	}
>
> -	if (s->commit_graph_read_changed_paths) {
> +	if (s->commit_graph_changed_paths_version != 0) {
>  		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
>  			   &graph->chunk_bloom_indexes);
>  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,

Just a small note, but writing this as

    if (!s->commit_graph_changed_paths_version)

would probably be more in line with our coding guidelines.

> diff --git a/repo-settings.c b/repo-settings.c
> index 3dbd3f0e2e..e3b6565ffc 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -24,6 +24,7 @@ void prepare_repo_settings(struct repository *r)
>  	int value;
>  	const char *strval;
>  	int manyfiles;
> +	int readChangedPaths;

Small note: this should be snake-cased like "read_changed_paths".

> diff --git a/repository.h b/repository.h
> index e8c67ffe16..1f1c32a6dd 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -32,7 +32,7 @@ struct repo_settings {
>
>  	int core_commit_graph;
>  	int commit_graph_generation_version;
> -	int commit_graph_read_changed_paths;

Nice, I'm glad that we're getting rid of this variable and replacing it
with commit_graph_changed_paths_version instead.

> +	int commit_graph_changed_paths_version;

Looking good.

Thanks,
Taylor
