Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ECEC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108CB64F16
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 14:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBYOIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 09:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhBYOIY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 09:08:24 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157DC061574
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 06:07:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lr13so9055387ejb.8
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 06:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jWcQ8o81VXdvujq2gT/bRsqGsb9lNHSfLl8sZJRhKQk=;
        b=bpAnmuZrH/0sQ92+bqRLz2yeAJT3XEhUg+2f4MdofGMQbAZY7xrEJ6NdgnbY/JPS34
         oIbOJxxwyS484z2hsbIiuJWDPCzQUBwslkvDq6Q5wETsarDSMDyiSFqQSn2b2qvMrBVB
         BAfPd68PN6qLLf/wBmdPK/S6qnxevD+E5g+LmJdU5+/AFaH47e6tv+dJzj4wp2k/rFam
         86iJP3Jv3y0AfP7ZHH5gRiXksBZTKF5Sc/lkvBrjQJN/vk9sq81iWCGt/8Edpsn7MFQ5
         wgPPXWfkAEubX+i0Beil4kzYdcQ2+KYcf9E63SBA2Y4tQTuJeGCIzjB+01T021zDYqCW
         acIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jWcQ8o81VXdvujq2gT/bRsqGsb9lNHSfLl8sZJRhKQk=;
        b=IsHiJ2+eQYzLA5vrZlHg1O8NFGoL+o7PbxnFDj7zqL0Zz3RRCQ/kqLrkw/g6t8bzis
         ZktiwoF+cBeRPzayVBZq4IwCP5yc1gldO5bYnVCt2vLIVjg5YTuAns5RXs9Npx3I/Sas
         a4R7n20f4J8Pvk4y8yJxQmMBL0zCfXJKeXDVV1eUyoppkCu62tjY/O3PR7A1iMGyLatb
         NyIk1dGBuMgV53KhD4Md2ewJbSzWgsRIrB1uGDX3fdt/W0O3oieAMHzohFsvnx/6VY12
         HE78/8ETqmkOPHZR2j9Plg9gr2O/5hQKYizv1N4jHgYglrvIH4fdvzK01AssJPRzhOdR
         PkqQ==
X-Gm-Message-State: AOAM532wXxayzEnR8Hn9CCvBuVyqTq7qf0G7NGejF2kwOMju7LhB8DiD
        ACJBXz2xv0M+FakHbXwaTIM=
X-Google-Smtp-Source: ABdhPJygbyKRtn/IRCejxfkDWyeI2yR5WDyxjNbbIXnUrK6k5Vr6+lOSTmXcGI7Ui2Wg/xrBBGNjZA==
X-Received: by 2002:a17:906:5797:: with SMTP id k23mr2721443ejq.489.1614262063070;
        Thu, 25 Feb 2021 06:07:43 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r23sm3613902edp.34.2021.02.25.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 06:07:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: noisy "warning: repository contains (deprecated) grafts; skipping
 commit-graph" warnings
References: <pull.875.git.1613057954213.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.875.git.1613057954213.gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 15:07:41 +0100
Message-ID: <87pn0o6y1e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 11 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When `gc.writeCommitGraph = true`, it is possible that the commit-graph
> is _still_ not written: replace objects, grafts and shallow repositories
> are incompatible with the commit-graph feature.
>
> Under such circumstances, we need to indicate to the user why the
> commit-graph was not written instead of staying silent about it.

This change really needs to be changed in some way or other, but
unfortunately the commit message has little/no information about when
these warnings are expected, and no tests.

I'm assuming you were targeting the write_commit_graph() caller of
commit_graph_compatible(). In that case this somewhat makes sense I
guess.

But we also call this at a distance when simply checking if we can
lookup things in the commit-graph, observe this on the current git
master:

    $ git clone --depth 1 --no-tags --single-branch --branch master https://github.com/git/git.git /tmp/git.git
    [...]
    warning: repository contains (deprecated) grafts; skipping commit-graph
    warning: repository contains (deprecated) grafts; skipping commit-graph

In that case we reach this via "parse_object()" in the "clone" process,
and print it twice because our rev-list child also spews the warning at
us.

Perhaps a better approach here is to pass down some flag and e.g. write
it only from "git gc" and friends?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Be clear why commit-graph was skipped
>     
>     After repairing my local checkout
>     [https://github.com/gitgitgadget/git/pull/873], I was puzzled that the
>     commit-graph file was not written. Turns out that I still had almost a
>     dozen replace objects. But I only found out that they were blocking the
>     commit-graph when I stepped through git gc in a debugger. This is my
>     attempt to make it more straight-forward to recover from similar
>     situations in the future.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-875%2Fdscho%2Fwarn-if-commit-graph-is-skipped-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-875/dscho/warn-if-commit-graph-is-skipped-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/875
>
>  commit-graph.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 65410602714e..9ad176fa7c8e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -205,16 +205,24 @@ static int commit_graph_compatible(struct repository *r)
>  
>  	if (read_replace_refs) {
>  		prepare_replace_object(r);
> -		if (hashmap_get_size(&r->objects->replace_map->map))
> +		if (hashmap_get_size(&r->objects->replace_map->map)) {
> +			warning(_("repository contains replace objects; "
> +			       "skipping commit-graph"));
>  			return 0;
> +		}
>  	}
>  
>  	prepare_commit_graft(r);
>  	if (r->parsed_objects &&
> -	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))
> +	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent)) {
> +		warning(_("repository contains (deprecated) grafts; "
> +		       "skipping commit-graph"));
>  		return 0;
> -	if (is_repository_shallow(r))
> +	}
> +	if (is_repository_shallow(r)) {
> +		warning(_("repository is shallow; skipping commit-graph"));
>  		return 0;
> +	}
>  
>  	return 1;
>  }
>
> base-commit: f9f2520108bab26a750bcbb00518dc27672cf0a2

