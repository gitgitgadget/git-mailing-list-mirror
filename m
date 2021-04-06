Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60020C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3216E600D4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhDFSsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbhDFSsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:48:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B1C061760
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 11:47:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so4701280wmk.4
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kvY5G+SapFzP5WhQpiuvL0EY93uTcLFi8N2kpBfVTFg=;
        b=oqJV20bQ0DNRFcGpUNlWTgdlX4jpkwSZfJE4X4nVO+WDt69tY4xaE1AKlmgG+2o38T
         KbjotQ5OxGFnlxmNj+0c76rirAfz6LiQhFwx1bK17xyIQbHZ/HLjSyM4+x8R/nhiwmzk
         rZxf5PJEjDnWeCd3+M+O7M0UiokDmOFzWkfgejrnbPi7CGhmZXvcrvwQYUtZ6667D4AH
         CUb4u0UrN0jSzGhTU94TyFA868MvW4WBrgO/+woHueddzuNvUSqkVYghFaLy6AH4x9ij
         KvSXtBstPP/5e18Oi5d0mx/j7mNbTiT4f1hbo1MjOn/1g03Qev4lCjDyHwsVUj0UCMSI
         6iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kvY5G+SapFzP5WhQpiuvL0EY93uTcLFi8N2kpBfVTFg=;
        b=GSe0+O9C3G3SkWlMiXoXrywuIU9ash1ks0Lbzmxa7CGNI4YuBI5JJdlhXm2VyTQDYo
         dsYna9nxXWDsWZi2vGHUi0KNEkaLaVbhIkkkqae5zXskjFyAT7hjBOCqlnQ706xG4K4S
         B8HZqjL5PSBFVakJka4eCl1/qaQqwk8EnjUow2WRf1muutQflxFv9yYIM9eCNBfxmSMv
         GKIAtRMWxabA0606z1pKtONF8zE5w9MAlCZ0OZ9o4XUqWnsYqYWPJthGtAhGRreZDMJ6
         VBm3Ku7N+8ZzA/3M5ZFoVfN2l3/tuDB5c8l2vxjPgEhEnoDc6EE/YpwPTAETsqrNUAT7
         cdeQ==
X-Gm-Message-State: AOAM533urqqbOXy0nwEtboQQclU2cG5LeewE6tTuLVC659r7Wk+Hs2B/
        5TWxoNuPmqmevbwgszxHRRg1r629J4g=
X-Google-Smtp-Source: ABdhPJxwgpVUjw3zsJDTG7Z2FQMytpU6X0xXlg9eDFwDx1n2sb75xxurqk8Kc1AjiBpT28yAf2/CmQ==
X-Received: by 2002:a05:600c:4f8e:: with SMTP id n14mr5485450wmq.34.1617734875248;
        Tue, 06 Apr 2021 11:47:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm18148530wrw.2.2021.04.06.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:47:54 -0700 (PDT)
Message-Id: <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Apr 2021 18:47:50 +0000
Subject: [PATCH v2 5/5] maintenance: allow custom refspecs during prefetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
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
 builtin/gc.c                      | 37 +++++++++++++++++++++++++-
 t/t7900-maintenance.sh            | 43 ++++++++++++++++++++++++++-----
 3 files changed, 74 insertions(+), 9 deletions(-)

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
index fa8128de9ae1..76f347dd6b11 100644
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
@@ -886,7 +888,40 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
-	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
+	for (i = 0; i < remote->fetch.nr; i++) {
+		struct refspec_item replace;
+		struct refspec_item *rsi = &remote->fetch.items[i];
+		struct strbuf new_dst = STRBUF_INIT;
+		size_t ignore_len = 0;
+		char *replace_string;
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
+		replace_string = refspec_item_format(&replace);
+		strvec_push(&child.args, replace_string);
+		free(replace_string);
+
+		refspec_item_clear(&replace);
+	}
 
 	return !!run_command(&child);
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 37eed6ed3aa3..03487be3af38 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -142,20 +142,51 @@ test_expect_success 'prefetch multiple remotes' '
 	test_commit -C clone2 two &&
 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
-	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remote1/*" <run-prefetch.txt &&
-	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remote2/*" <run-prefetch.txt &&
+	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote1/*" <run-prefetch.txt &&
+	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <run-prefetch.txt &&
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
+	git config --add remote.remote1.fetch "+refs/heads/special/fetched:refs/heads/fetched" &&
+	git config --add remote.remote1.fetch "^refs/heads/special/secret/not-fetched" &&
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
+	test_subcommand git fetch remote1 $fetchargs "$rs1" "$rs2" "$rs3" <prefetch-refspec.txt &&
+	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <prefetch-refspec.txt &&
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
