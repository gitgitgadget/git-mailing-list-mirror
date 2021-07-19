Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8A5C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3685D60FE9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349246AbhGSQ2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354391AbhGSQ04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:26:56 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48EC078806
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:28:22 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z9so20678878iob.8
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qzbX+NRKVtsuOUQhTsGuAgY8W2CVpzztDXeMLAj55c0=;
        b=wX++1hFYWFw86wqLnjFed1QddFBr0GU4M5KIKrI7hEEd/825xgyWWM1qNplD/xy1U0
         PcpLjKl+ErjsHCkDz2LmrPvjQttgs6zeIFXZ0mhgdQsg8XItnjaxFXxsFz7vzYWLaYVC
         Cre3fYZIqgibQjjdzgMpZlrw5HfL/mSoZL3mlFMDvu+nJTxmeH+x5sYJ9L+Lp+b392AL
         yvwrMopObwhcKcsftqI7YODEqKZsyjOGIaWuWfvRi7PrHE0vp+c3vPuoiqmQzZK8xdgI
         DWMMvL7edwFoTsW3otP5XzsmEWITQrcEjYWKx54Ji3G0PYgAMhDfDds3Xv9W6mUPP1YL
         7ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qzbX+NRKVtsuOUQhTsGuAgY8W2CVpzztDXeMLAj55c0=;
        b=ZT9qQBIfYtTaMTXMCgcDkRwweXHgXrr9gFoRe3WYQDbtIT60NLlNn9UAyykvxFScga
         KRFzwGXmB667pOYcPdbWqz59d2Mj+qar4HChpEJqocUucEbMRij/YETaGJaoiVPe55wR
         yjHtvnJymtgX4lA7j//+QJ816U3NNwAk6uIonyUKTGbeaGq1MsTZcwRGwH7uxuO0SNl5
         K7++QWGUZMxMHRmFl8uwYzikuXDwi1HjnNJiiKfV+vbb2hvPALi7FsU5JVMBd617eh0I
         nYOwXOgo5qKi/XyiPu8Txl4ldeVn4ffKU+xKMMCrCXJUozhyQPd7WRVsagkgPQ9i/cly
         BsGQ==
X-Gm-Message-State: AOAM530cPXQDo2Wv85MrAMIQcdLpYQQkhFCLMcPN5OfguW6219vqM18q
        1nxB4dP+CEQkSNcxRJknAsAkAg==
X-Google-Smtp-Source: ABdhPJw6orQ6EC9EN18Ay1TMNvsvFJvQJ2f5haDIsV2xYnk60YVHNe0p6LDN5EOzIYn3Mm918ZEliw==
X-Received: by 2002:a05:6602:1203:: with SMTP id y3mr12378409iot.192.1626713415036;
        Mon, 19 Jul 2021 09:50:15 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id t24sm11033506ioh.24.2021.07.19.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 09:50:14 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:50:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] commit-graph: use parse_options_concat()
Message-ID: <YPWtRd+523N1cWR/@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <patch-3.5-2e7d9b0b8e4-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.5-2e7d9b0b8e4-20210718T074936Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 09:58:07AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Make use of the parse_options_concat() so we don't need to copy/paste
> common options like --object-dir. This is inspired by a similar change
> to "checkout" in 2087182272
> (checkout: split options[] array in three pieces, 2019-03-29).
>
> A minor behavior change here is that now we're going to list both
> --object-dir and --progress first, before we'd list --progress along
> with other options.

This is very reminiscent to the patch I sent to do the same in the
`multi-pack-index` builtin, probably because you were the person to
recommend I do that cleanup in the first place ;).

I got some good advice from Peff in [1] went I sent that patch, which
I'll try to summarize here, since I think a few pieces of it could be
applied to clean up this patch a little.

[1]: https://lore.kernel.org/git/YGG7tWBzo5NGl2+g@coredump.intra.peff.net/

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index baead04a03b..ff125adf2d5 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -44,6 +44,21 @@ static struct opts_commit_graph {
>  	int enable_changed_paths;
>  } opts;
>
> +static struct option *add_common_options(struct option *prevopts)
> +{
> +	struct option options[] = {
> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
> +			   N_("dir"),
> +			   N_("the object directory to store the graph")),
> +		OPT_BOOL(0, "progress", &opts.progress,
> +			 N_("force progress reporting")),
> +		OPT_END()
> +	};

Not from Peff's mail, but is there any reason to non statically allocate
this?

The only reason I could think of is that `opts` is heap allocated, but
it's not, so I think we could probably mark `options` as static here
(and perhaps rename it to `common_opts` while we're at it, if for no
other reason than to be consistent with what's in the multi-pack-index
builtin).

> +	struct option *newopts = parse_options_concat(options, prevopts);
> +	free(prevopts);

Since we're not concatenating more than one layer on top of the common
options (unlike in `checkout`), this can be simplified to just return
parse_options_concat without freeing prevopts.

We should be careful to make sure we free the return value from
parse_options_concat eventually, though.

> +	return newopts;
> +}
> +
>  static struct object_directory *find_odb(struct repository *r,
>  					 const char *obj_dir)
>  {
> @@ -77,20 +92,18 @@ static int graph_verify(int argc, const char **argv)
>  	int flags = 0;
>
>  	static struct option builtin_commit_graph_verify_options[] = {
> -		OPT_STRING(0, "object-dir", &opts.obj_dir,
> -			   N_("dir"),
> -			   N_("the object directory to store the graph")),
>  		OPT_BOOL(0, "shallow", &opts.shallow,
>  			 N_("if the commit-graph is split, only verify the tip file")),
> -		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>  		OPT_END(),
>  	};
> +	struct option *options = parse_options_dup(builtin_commit_graph_verify_options);
> +	options = add_common_options(options);

Likewise down here (and in the other callers, too) this dup is pointless
if we're going to immediately free it after calling
parse_options_concat. So we can drop that, too.

Here's something to consider squashing in on top:

--- >8 ---

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ff125adf2d..00b0721789 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -44,19 +44,18 @@ static struct opts_commit_graph {
 	int enable_changed_paths;
 } opts;

-static struct option *add_common_options(struct option *prevopts)
+static struct option common_opts[] = {
+	OPT_STRING(0, "object-dir", &opts.obj_dir,
+		   N_("dir"),
+		   N_("the object directory to store the graph")),
+	OPT_BOOL(0, "progress", &opts.progress,
+		 N_("force progress reporting")),
+	OPT_END()
+};
+
+static struct option *add_common_options(struct option *to)
 {
-	struct option options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			   N_("dir"),
-			   N_("the object directory to store the graph")),
-		OPT_BOOL(0, "progress", &opts.progress,
-			 N_("force progress reporting")),
-		OPT_END()
-	};
-	struct option *newopts = parse_options_concat(options, prevopts);
-	free(prevopts);
-	return newopts;
+	return parse_options_concat(common_opts, to);
 }

 static struct object_directory *find_odb(struct repository *r,
@@ -96,8 +95,7 @@ static int graph_verify(int argc, const char **argv)
 			 N_("if the commit-graph is split, only verify the tip file")),
 		OPT_END(),
 	};
-	struct option *options = parse_options_dup(builtin_commit_graph_verify_options);
-	options = add_common_options(options);
+	struct option *options = add_common_options(builtin_commit_graph_verify_options);

 	trace2_cmd_mode("verify");

@@ -120,6 +118,7 @@ static int graph_verify(int argc, const char **argv)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);

 	FREE_AND_NULL(graph_name);
+	FREE_AND_NULL(options);

 	if (open_ok)
 		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
@@ -245,8 +244,7 @@ static int graph_write(int argc, const char **argv)
 			0, write_option_max_new_filters),
 		OPT_END(),
 	};
-	struct option *options = parse_options_dup(builtin_commit_graph_write_options);
-	options = add_common_options(options);
+	struct option *options = add_common_options(builtin_commit_graph_write_options);

 	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
@@ -316,6 +314,7 @@ static int graph_write(int argc, const char **argv)
 		result = 1;

 cleanup:
+	FREE_AND_NULL(options);
 	string_list_clear(&pack_indexes, 0);
 	strbuf_release(&buf);
 	return result;
@@ -323,8 +322,7 @@ static int graph_write(int argc, const char **argv)

 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
-	struct option *no_options = parse_options_dup(NULL);
-	struct option *builtin_commit_graph_options = add_common_options(no_options);
+	struct option *builtin_commit_graph_options = common_opts;

 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
