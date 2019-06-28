Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0901F461
	for <e@80x24.org>; Fri, 28 Jun 2019 21:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfF1VmU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 17:42:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61579 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfF1VmU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 17:42:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2778115F8F4;
        Fri, 28 Jun 2019 17:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7vO1SFH8GsBj58Bt1Kurg5l97X8=; b=uqiFUz
        F0P3Si3y2hXou+oLnHIal5yiJFIG3Yr5MeAv4Xcu3ocOj2ywuGWqiJz9OyZDDnDM
        C2+vQhRNHnxYkYXZ785uc6JM6m9rYBw3Ykm2o2+MSXAChJ1/AkCBflUCmqm8WzDf
        AET9g8nG4tBz5q3R6DoQfrrnVeItRr8kUdWuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L79vv19NgvKKfHx83NRugJr7IVcCxR3c
        57ogiqe5FDXr3vqbzg7eOdMGnvtkH4Va/KjhclDztbKtuNKkPY/6gqWJZ3XHWjL8
        a+axkQCH/AqXbWEXlb3l8c23JxuSi96FSCvKVTsM530ZEd2vxMigi7A1ULK5bb8s
        d70nfFtmOkk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ECFD15F8F3;
        Fri, 28 Jun 2019 17:42:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85AA815F8F2;
        Fri, 28 Jun 2019 17:42:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate setting
References: <pull.254.git.gitgitgadget@gmail.com>
        <pull.254.v2.git.gitgitgadget@gmail.com>
        <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
Date:   Fri, 28 Jun 2019 14:42:14 -0700
In-Reply-To: <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 19 Jun 2019
        08:12:00 -0700 (PDT)")
Message-ID: <xmqq8stl8k09.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 987505CA-99ED-11E9-AD31-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -41,7 +42,6 @@ static int aggressive_depth = 50;
>  static int aggressive_window = 250;
>  static int gc_auto_threshold = 6700;
>  static int gc_auto_pack_limit = 50;
> -static int gc_write_commit_graph;
>  static int detach_auto = 1;
>  static timestamp_t gc_log_expire_time;
>  static const char *gc_log_expire = "1.day.ago";
> @@ -148,7 +148,6 @@ static void gc_config(void)
>  	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
>  	git_config_get_int("gc.auto", &gc_auto_threshold);
>  	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
> -	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_get_expiry("gc.pruneexpire", &prune_expire);
>  	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
> @@ -685,7 +684,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		clean_pack_garbage();
>  	}
>  
> -	if (gc_write_commit_graph)
> +	prepare_repo_settings(the_repository);
> +	if (the_repository->settings->gc_write_commit_graph == 1)
>  		write_commit_graph_reachable(get_object_directory(), 0,
>  					     !quiet && !daemonized);

OK, so the general idea is to move per-subsystem local variables to
new fields in the repository structure, stop parsing the configuration
in per-subsystem config callback, which is how the configuration for
the writing side is done above, and ...

>  
> diff --git a/commit-graph.c b/commit-graph.c
> index 7c5e54875f..b09c465a7a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -16,6 +16,7 @@
>  #include "hashmap.h"
>  #include "replace-object.h"
>  #include "progress.h"
> +#include "repo-settings.h"
>  
>  #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> @@ -311,7 +312,6 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
>  static int prepare_commit_graph(struct repository *r)
>  {
>  	struct object_directory *odb;
> -	int config_value;
>  
>  	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
>  		die("dying as requested by the '%s' variable on commit-graph load!",
> @@ -321,9 +321,10 @@ static int prepare_commit_graph(struct repository *r)
>  		return !!r->objects->commit_graph;
>  	r->objects->commit_graph_attempted = 1;
>  
> +	prepare_repo_settings(r);
> +
>  	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
> -	    (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
> -	    !config_value))
> +	    r->settings->core_commit_graph != 1)
>  		/*
>  		 * This repository is not configured to use commit graphs, so
>  		 * do not load one. (But report commit_graph_attempted anyway

... how the reading side is done here.  And then instead let the new
repo-settings module read them ...

> diff --git a/repo-settings.c b/repo-settings.c
> new file mode 100644
> index 0000000000..f7fc2a1959
> --- /dev/null
> +++ b/repo-settings.c
> @@ -0,0 +1,44 @@
> +#include "cache.h"
> +#include "repository.h"
> +#include "config.h"
> +#include "repo-settings.h"
> +
> +#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
> +
> +static int git_repo_config(const char *key, const char *value, void *cb)
> +{
> +	struct repo_settings *rs = (struct repo_settings *)cb;
> +
> +	if (!strcmp(key, "core.featureadoptionrate")) {
> +		int rate = git_config_int(key, value);
> +		if (rate >= 3) {
> +			UPDATE_DEFAULT(rs->core_commit_graph, 1);
> +			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
> +		}
> +		return 0;
> +	}
> +	if (!strcmp(key, "core.commitgraph")) {
> +		rs->core_commit_graph = git_config_bool(key, value);
> +		return 0;
> +	}
> +	if (!strcmp(key, "gc.writecommitgraph")) {
> +		rs->gc_write_commit_graph = git_config_bool(key, value);
> +		return 0;
> +	}
> +
> +	return 1;
> +}

... like this.  If a concrete/underlying configuration variable
appears in the configuration data stream, the fields would get their
values overwritten, and if the adoption rate setting appears
_before_ concreate ones, they affect the value in the fields.  So
the assignment to these fields when the adoption rate setting is
seen survives only when the underlying variable does not appear
anywhere in the configuration dasta stream at all.

Which is exactly what we want.  Nicely written.

> +void prepare_repo_settings(struct repository *r)
> +{
> +	if (r->settings)
> +		return;
> +
> +	r->settings = xmalloc(sizeof(*r->settings));
> +
> +	/* Defaults */
> +	r->settings->core_commit_graph = -1;
> +	r->settings->gc_write_commit_graph = -1;
> +
> +	repo_config(r, git_repo_config, r->settings);
> +}
> diff --git a/repo-settings.h b/repo-settings.h
> new file mode 100644
> index 0000000000..11d08648e1
> --- /dev/null
> +++ b/repo-settings.h
> @@ -0,0 +1,13 @@
> +#ifndef REPO_SETTINGS_H
> +#define REPO_SETTINGS_H
> +
> +struct repo_settings {
> +	char core_commit_graph;
> +	char gc_write_commit_graph;
> +};

I do not see a particular reason to favor type "char" here. "char"
is wider than e.g. "signed int :2", if you wanted to save space
compared to a more obvious and naive type, e.g. "int".  More
importantly, the language does not guarantee signedness of "char",
so the sentinel value of "-1" is a bit tricky to use, as you have to
be prepared to see your code used on an "unsigned char" platform.

Use of "signed char" would be OK, but this is a singleton instance
per repository, so I am not sure how much it matters to save a few
words here by not using the most natural "int" type.
