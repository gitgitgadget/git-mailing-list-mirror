Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B7DC43462
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B608B613A9
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhDENEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhDENE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:04:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54792C061788
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:04:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so5605630wmj.2
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YJFPKjbf38fYJcW/14HvAHQpRrYbhNHkMU/HO3rFRFs=;
        b=R9QjggiyYVuiNEij9mWQK9I9Ys3NztdLt4XLFXtvmpkiO1JRg9t28xuy7ckGUfxt9v
         /D2aQ7lJ63RU6M/ewnqvQlML0txvVKy9/iw+2WUXw3Ano9eR+dlSNnrrmsA0crhLPSjJ
         pYstsF4m3bGsNnDITKXfDmx4mDJAdBrIhnscrNZWgfEVwi0tlFGEotfQCHe3xPVgHUwq
         sryLxnM+Z2N4ow/R7JLO817d/xxmLHDLmeYzZuUg0YgAnRtV0Q3OFeb/xPhHTvFvtIiL
         dRMMchlEmaWcQdRtpn76tVIHb0mKeg2/5uqf5hxHNR3MXnNYB117+niNBKnEcefFGJXk
         IsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YJFPKjbf38fYJcW/14HvAHQpRrYbhNHkMU/HO3rFRFs=;
        b=bdvHElL8GwbJ31flErclS2xCUwy4Vp9gac+K2jJ9saYZs5+LRihMbP5jtbkLuvovPU
         vyqHf7gDfq9xqUYB+Tt70BzmY/pdQf2T+zHlwvRG3WOo2MBXrmI4WtQ00SUdKPvD+IRP
         go8iBUEDUbIui5TfKqsidA6GfgIT4PgyWBlZiVmcLISx40rEgA5Iw05qY7t7/TKyLHUQ
         kiWWPycXWlYnJPnfFptV33v0wXtFMbzlfVW1bzkLojf8n8PjgrDLFqdc1j2CU8U7utGq
         bv7QN1GwgWKtnq3fEOzbxUZiEV8poqMJBvVlVsIDmsS0cHekn3S4ymWsBNglFtQHtIE2
         7Dfg==
X-Gm-Message-State: AOAM531vrZP5QKFc08nS7madXSjmPVe6cJSHy7Ey2IGuUDCC8CZqNh3C
        qbxv1qxgxeVhIuey7f1GLvgqhL6PDOU=
X-Google-Smtp-Source: ABdhPJzHFgn/cEIA1rAkl6BnemK4eW7+ZcWbDFkt/kRAvdYe1TtEYVyHuuLruNXtEKfBkLYcnChkdg==
X-Received: by 2002:a1c:9a51:: with SMTP id c78mr14216249wme.160.1617627861099;
        Mon, 05 Apr 2021 06:04:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm23086496wmi.24.2021.04.05.06.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 06:04:20 -0700 (PDT)
Message-Id: <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.git.1617627856.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Apr 2021 13:04:15 +0000
Subject: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The prefetch task previously used the default refspec source plus a
custom refspec destination to avoid colliding with remote refs:

	+refs/heads/*:refs/prefetch/<remote>/*

However, some users customize their refspec to reduce how much data they
download from specific remotes. This can involve restrictive patterns
for fetching or negative patterns to avoid downloading some refs.

Modify fetch_remote() to iterate over the remote's refspec list and
translate that into the appropriate prefetch scenario. Specifically,
re-parse the raw form of the refspec into a new 'struct refspec' and
modify the 'dst' member to replace a leading "refs/" substring with
"refs/prefetch/", or prepend "refs/prefetch/" to 'dst' otherwise.
Negative refspecs do not have a 'dst' so they can be transferred to the
'git fetch' command unmodified.

This prefix change provides the benefit of keeping whatever collisions
may exist in the custom refspecs, if that is a desirable outcome.

This changes the names of the refs that would be fetched by the default
refspec. Instead of "refs/prefetch/<remote>/<branch>" they will now go
to "refs/prefetch/remotes/<remote>/<branch>". While this is a change, it
is not a seriously breaking one: these refs are intended to be hidden
and not used.

Update the documentation to be more generic about the destination refs.
Do not mention custom refpecs explicitly, as that does not need to be
highlighted in this documentation. The important part of placing refs in
refs/prefetch remains.

Reported-by: Tom Saeger <tom.saeger@oracle.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  3 +--
 builtin/gc.c                      | 34 +++++++++++++++++++++++-
 t/t7900-maintenance.sh            | 43 ++++++++++++++++++++++++++-----
 3 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 80ddd33ceba0..95a24264eb10 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -94,8 +94,7 @@ prefetch::
 	objects from all registered remotes. For each remote, a `git fetch`
 	command is run. The refmap is custom to avoid updating local or remote
 	branches (those in `refs/heads` or `refs/remotes`). Instead, the
-	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
-	not updated.
+	refs are stored in `refs/prefetch/`. Also, tags are not updated.
 +
 This is done to avoid disrupting the remote-tracking branches. The end users
 expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
diff --git a/builtin/gc.c b/builtin/gc.c
index fa8128de9ae1..92cb8b4e0bfa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "refspec.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -877,6 +878,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 {
 	struct maintenance_run_opts *opts = cbdata;
 	struct child_process child = CHILD_PROCESS_INIT;
+	int i;
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
@@ -886,7 +888,37 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
-	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
+	for (i = 0; i < remote->fetch.nr; i++) {
+		struct refspec_item replace;
+		struct refspec_item *rsi = &remote->fetch.items[i];
+		struct strbuf new_dst = STRBUF_INIT;
+		size_t ignore_len = 0;
+
+		if (rsi->negative) {
+			strvec_push(&child.args, remote->fetch.raw[i]);
+			continue;
+		}
+
+		refspec_item_init(&replace, remote->fetch.raw[i], 1);
+
+		/*
+		 * If a refspec dst starts with "refs/" at the start,
+		 * then we will replace "refs/" with "refs/prefetch/".
+		 * Otherwise, we will prepend the dst string with
+		 * "refs/prefetch/".
+		 */
+		if (!strncmp(replace.dst, "refs/", 5))
+			ignore_len = 5;
+
+		strbuf_addstr(&new_dst, "refs/prefetch/");
+		strbuf_addstr(&new_dst, replace.dst + ignore_len);
+		free(replace.dst);
+		replace.dst = strbuf_detach(&new_dst, NULL);
+
+		strvec_push(&child.args, refspec_item_format(&replace));
+
+		refspec_item_clear(&replace);
+	}
 
 	return !!run_command(&child);
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index fc2315edec11..3366ea188782 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -142,20 +142,51 @@ test_expect_success 'prefetch multiple remotes' '
 	test_commit -C clone2 two &&
 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
-	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
-	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
+	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote1/* <run-prefetch.txt &&
+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <run-prefetch.txt &&
 	test_path_is_missing .git/refs/remotes &&
-	git log prefetch/remote1/one &&
-	git log prefetch/remote2/two &&
+	git log prefetch/remotes/remote1/one &&
+	git log prefetch/remotes/remote2/two &&
 	git fetch --all &&
-	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
-	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
+	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
+	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
 
 	test_cmp_config refs/prefetch/ log.excludedecoration &&
 	git log --oneline --decorate --all >log &&
 	! grep "prefetch" log
 '
 
+test_expect_success 'prefetch custom refspecs' '
+	git -C clone1 branch -f special/fetched HEAD &&
+	git -C clone1 branch -f special/secret/not-fetched HEAD &&
+
+	# create multiple refspecs for remote1
+	git config --add remote.remote1.fetch +refs/heads/special/fetched:refs/heads/fetched &&
+	git config --add remote.remote1.fetch ^refs/heads/special/secret/not-fetched &&
+
+	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&
+
+	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
+
+	# skips second refspec because it is not a pattern type
+	rs1="+refs/heads/*:refs/prefetch/remotes/remote1/*" &&
+	rs2="+refs/heads/special/fetched:refs/prefetch/heads/fetched" &&
+	rs3="^refs/heads/special/secret/not-fetched" &&
+
+	test_subcommand git fetch remote1 $fetchargs $rs1 $rs2 $rs3 <prefetch-refspec.txt &&
+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <prefetch-refspec.txt &&
+
+	# first refspec is overridden by second
+	test_must_fail git rev-parse refs/prefetch/special/fetched &&
+	git rev-parse refs/prefetch/heads/fetched &&
+
+	# possible incorrect places for the non-fetched ref
+	test_must_fail git rev-parse refs/prefetch/remotes/remote1/secret/not-fetched &&
+	test_must_fail git rev-parse refs/prefetch/remotes/remote1/not-fetched &&
+	test_must_fail git rev-parse refs/heads/secret/not-fetched &&
+	test_must_fail git rev-parse refs/heads/not-fetched
+'
+
 test_expect_success 'prefetch and existing log.excludeDecoration values' '
 	git config --unset-all log.excludeDecoration &&
 	git config log.excludeDecoration refs/remotes/remote1/ &&
-- 
gitgitgadget
