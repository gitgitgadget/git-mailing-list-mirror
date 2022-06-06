Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28315CCA473
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 21:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiFFV4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiFFV4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 17:56:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1425C37034
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 14:56:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id k4so4775321qth.8
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q6lyaGzXwnC7KZwO7I7PvRE2s11djeenH/MJGdJJJq0=;
        b=mGCT4QdHxbLvtdykscLnj5yn9nO5waZdwb3vo3nHg8aTFpJgK7vBYgu+yT9Iu6w82+
         WF0gQ2UOFsAu8dN2qA2iyZ4KT/ti5zho5SWjErBNZf4ycuQtKNUCZ26odter0AecwCtV
         AhoBR3YjI97A74bpe/ghOukfoCd0wcxiGJp+s1Ay85WsI4fwLKMtvnsEmCyoHqsqgadD
         r6TO4j6wGepdy1fRYn/uN/6qZ5wHfUY8Htpko1PBQ3IWbqph8OLnw9T/J0A7G3uXO9s/
         UPcOvGerSV06bvLvDaEUUpve5zVYXYRrFACHRGjOaPQDvMWfnmpVdl8sUrChA5+8uEYv
         nVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q6lyaGzXwnC7KZwO7I7PvRE2s11djeenH/MJGdJJJq0=;
        b=LqBB0YfKRfoFzO2Kp4tKHm5FMMA7TzJiyM+PsZmrSVnRQd62FagjM/Ac3lVJL92jIW
         zzp56GyE9V42TQCxWUb2odAUnH/khKYq32nEMZ3uRGZru8eABDwWsinQ5x42es4c9sBD
         Pzc0tWzCZ7Vn2JihYe6vknxpkOZJZlU72h3Tvky/wiBhJA8sKgsAirxuL6pU6y9xxEus
         IXcD4I6jaVIAXwZGIlEaz8kNY34IKd+T5ptWnXbX+WOAbPCCY9T3zFjjIzMOlENlmHkR
         6jIQszDUr8BBHrob6uH1qEyv7e1eTlWOj1pE9vAgUtCJ4z5xuMbSDNzUQU/9IxWN/UhF
         xi/A==
X-Gm-Message-State: AOAM533thPNoFuK2/Fgz0aiIjyU7xl27aLbVTxSYTTAQy7J/uUk3vDkF
        yXUoZohjoXKcWiqn3SCu0GBXXTHVt9vUa3yz
X-Google-Smtp-Source: ABdhPJwiOtkzJhBvMcfToirqhU18AlIqW/vL6/jxaIi02oMS2xSY8gUslI2LXK5g3aXFpQgEA2g//Q==
X-Received: by 2002:a05:622a:45:b0:303:521e:a9a0 with SMTP id y5-20020a05622a004500b00303521ea9a0mr20754149qtw.621.1654552569027;
        Mon, 06 Jun 2022 14:56:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a411400b006a377a015d4sm13602370qko.39.2022.06.06.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:56:08 -0700 (PDT)
Date:   Mon, 6 Jun 2022 17:56:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
Subject: [PATCH 2/2] builtin/show-ref.c: limit output with `--count`
Message-ID: <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
References: <cover.1654552560.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1654552560.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git show-ref` is a useful tool for answering existential questions
about whether or not certain (kinds of) references exist or not. For
example, to quickly determine whether or not a repository has any tags,
one could run:

    $ git show-ref -q --tags | head -1

and check whether there was any output.

But certain environments (like spawning Git processes from Ruby code) do
not have ergonomic ways to simulate sending SIGPIPE back to `show-ref`
when they have seen enough output.

Callers _could_ use `for-each-ref`, which has supports a `--count`
option to limit output, but this is sub-par for latency-sensitive
callers since `for-each-ref` buffers all results before printing
anything. In the above instance, even something like:

    $ git for-each-ref --count=1 -- 'refs/tags/*'

will enumerate every tag in a repository before deciding to print just
the first one. (The current behavior exists to accommodate sorting the
output from for-each-ref, and could be improved. See [1] for previous
work in this area).

In the meantime, introduce support for a similar `--count` option in
`show-ref`, so that callers can run:

    $ git show-ref -q --tags --count=1

to quickly determine whether a repository has any (e.g.) tags or not by
only enumerating at most one reference.

(This option is currently "incompatible" with `--verify`, though there
is no reason why the meaning of `--count` couldn't be extended to mean,
"with `--verify`, only verify `<n>` references".)

[1]: https://lore.kernel.org/git/YTNpQ7Od1U%2F5i0R7@coredump.intra.peff.net/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-show-ref.txt |  7 ++++++-
 builtin/show-ref.c             | 23 ++++++++++++++++++++++-
 t/t1403-show-ref.sh            | 21 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ab4d271925..28256c04dd 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
 	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
-	     [--heads] [--] [<pattern>...]
+	     [--heads] [--count=<n>] [--] [<pattern>...]
 'git show-ref' --exclude-existing[=<pattern>]
 
 DESCRIPTION
@@ -84,6 +84,11 @@ OPTIONS
 	(4) ignore if refname is a ref that exists in the local repository;
 	(5) otherwise output the line.
 
+--count::
+
+	Do not print more than `<n>` matching references, or print all
+	references if `<n>` is 0. Incompatible with `--exclude-existing`
+	and `--verify`.
 
 <pattern>...::
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 17d5f98fe4..f0af8e8eec 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -15,7 +15,7 @@ static const char * const show_ref_usage[] = {
 };
 
 static int deref_tags, show_head, tags_only, heads_only, matches_nr, verify,
-	   quiet, hash_only, abbrev, exclude_arg;
+	   quiet, hash_only, abbrev, exclude_arg, max_count = 0;
 static const char **pattern;
 static const char *exclude_existing_arg;
 
@@ -82,6 +82,8 @@ static int show_ref(const char *refname, const struct object_id *oid,
 
 	show_one(refname, oid);
 
+	if (max_count && matches_nr >= max_count)
+		return -1; /* avoid opening any more refs */
 	return 0;
 }
 
@@ -178,6 +180,7 @@ static const struct option show_ref_options[] = {
 	OPT_CALLBACK_F(0, "exclude-existing", &exclude_existing_arg,
 		       N_("pattern"), N_("show refs from stdin that aren't in local repository"),
 		       PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback),
+	OPT_INTEGER(0, "count", &max_count, N_("show only <n> matched refs")),
 	OPT_END()
 };
 
@@ -188,6 +191,24 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
 
+	if (max_count) {
+		int compatible = 0;
+
+		if (max_count < 0)
+			error(_("invalid --count argument: (`%d' < 0)"),
+			      max_count);
+		else if (verify)
+			error(_("--count is incompatible with %s"), "--verify");
+		else if (exclude_arg)
+			error(_("--count is incompatible with %s"),
+			      "--exclude-existing");
+		else
+			compatible = 1;
+
+		if (!compatible)
+			usage_with_options(show_ref_usage, show_ref_options);
+	}
+
 	if (exclude_arg)
 		return exclude_existing(exclude_existing_arg);
 
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9252a581ab..b79e114c1e 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,4 +196,25 @@ test_expect_success 'show-ref --verify with dangling ref' '
 	)
 '
 
+test_expect_success 'show-ref --count limits relevant output' '
+	git show-ref --heads --count=1 >out &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'show-ref --count rejects invalid input' '
+	test_must_fail git show-ref --count=-1 2>err &&
+	grep "invalid ..count argument: (.-1. < 0)" err
+'
+
+test_expect_success 'show-ref --count incompatible with --verify' '
+	test_must_fail git show-ref --count=1 --verify HEAD 2>err &&
+	grep "..count is incompatible with ..verify" err
+'
+
+test_expect_success 'show-ref --count incompatible with --exclude-existing' '
+	echo "refs/heads/main" >in &&
+	test_must_fail git show-ref --count=1 --exclude-existing <in 2>err &&
+	grep "..count is incompatible with ..exclude.existing" err
+'
+
 test_done
-- 
2.36.1.94.gb0d54bedca
