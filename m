Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCFC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6588461A7C
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352104AbhKOXV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353019AbhKOXSe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB1C09CE6F
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso393122wms.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeU7w/1dCy0hbl1wfz0v3pWixGmjpUeWg3nEJ0q89hc=;
        b=I7hf86wXp0fn35j2ASTCSO39LrxDf2jir0AN3cwAk6zKNXcJpWhIKTKDDzZuW0pjRD
         umBE6rIIQOLFemgWIzL2L9GPBjZv6JKJi5zoNSin/fOmXQ3NgKzUnSTX/3jq1kq7wYrW
         P+tnx2/O1ZnYJQVPYldxHTd34YCrn9D9J9FHVHzGZLSAS3nAhaWudnQ6L2tSpJxwlsgP
         y+TtRW5/uZxvewvB79ztEocgE8pZPIAdHa7L7LaSAiWjzdaT6X7wzG8sH4/LmPslcqtj
         EB4SBsiIgwL8wBjZO8B0Vr/nZVLB/ij9X3I1wGe/jkSn7Z6UqY8UB8nubS4FIBDXmHu7
         TW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeU7w/1dCy0hbl1wfz0v3pWixGmjpUeWg3nEJ0q89hc=;
        b=Y6FReMPHD47uCrn9v/eJj9oCXxYhzoxBPqfoiVkpvJA20tPEXNw8qhk9VU4dfuRs/x
         NnYF67eCQf7DDn9sfIWsX4rFNUSMoAn6sD9jbO7xQ6Gq1lrvj4abgxI9CHFhXUleZJRf
         PLpyTJUpm9je4d1S3ClKw24n/hvAbIJFNBn7tHQ0OxbIJnQdisJiPLNII47yesLp8TaY
         lp+p5PwbwrWfzufEJMCHF2KwnXMCa9eVGl3z3Aq4VkP9YaxOaPm3AhPz+gcEbzLAwJ0j
         o3M476ic4vdkGccDg1LuYBKA5R6qjUBKlJ2ZsHJ6VNV2llFX7IkzibkoguavomQgT5u0
         4/Ow==
X-Gm-Message-State: AOAM531PJWhBSqnh6Yu4e22r/unPtlKMVBbHTFTexxeQOUvbvsehLLQU
        VDcWkyjn6frWGhaHGbY1JReKH9eq5iocXQ==
X-Google-Smtp-Source: ABdhPJzwk+qh5WCwPzMzR0I0eDn8N5NZrrd37oanzuxRtYZB9Dw5FiiIV/hiszd/29GHrPC5+1Iyuw==
X-Received: by 2002:a1c:7ed3:: with SMTP id z202mr2127398wmc.110.1637014729626;
        Mon, 15 Nov 2021 14:18:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 21/21] usage API: add "core.usageAddSource" config to add <file>:<line>
Date:   Mon, 15 Nov 2021 23:18:31 +0100
Message-Id: <RFC-patch-21.21-69630364f1a-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optionally extend the support that BUG() has had for emitting line
numbers to the {usage,fatal,error,warning}{,_errno}() functions.

Before we'd unconditionally get error messages like:

    $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
    fatal: bad boolean config value 'y' for 'core.x'

Which can be changed with core.usageAddSource=true to include the file
and line numbers:

    $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
    fatal: config.c:1241: bad boolean config value 'y' for 'core.x'

As the added documentation notes this is primarily intended to be
useful to developers of git itself, but is being exposed as a user
setting to e.g. help file better bug reports.

This also adds a "GIT_TEST_USAGE_ADD_SOURCE" setting intended to run
the test suite in this mode.

Currently it has a lot of failures. Most of those are rather trivial,
and can be "fixed" by pointing GIT_TEST_CMP to a "diff -u" that does a
s/^(usage|fatal|error|warning): [^:]+:[0-9]+/$1/g on its input files,
and likewise for a "grep" wrapper that does the same.

Even if we can't run the tests in this mode yet I'd like to have this
for ad-hoc debugging, and to make it easier to work towards running
the tests in this mode. If we can turn this on permanently it'll be
much easier to read test output, as we won't need to worry about the
indirection of looking up where an error might have been emitted,
which can be especially painful when the message being emitted isn't
unique within git.git.

This new code needs to be guarded by the "dying" variable for the
reasons explained in 2d3c02f5db6 (die(): stop hiding errors due to
overzealous recursion guard, 2017-06-21), and for those same reasons
it's racy under multi-threading.

Here the worst case is that incrementing the variable will run away
from us, and we won't get our desired <file>:<line> number. That's OK
in this case, those cases should be isolated to the config code (if we
can't parse the config), memory allocation etc, but we'll get it right
in the common cases.

Using GIT_TEST_USAGE_ADD_SOURCE should be immune from any racyness, as
it only needs a getenv() and git_parse_maybe_bool(), which won't die.

Add a repo_cfg_bool_env() wrapper to repo-settings.c for
GIT_TEST_USAGE_ADD_SOURCE, in 3050b6dfc75 (repo-settings.c: simplify
the setup, 2021-09-21) I indicated that the GIT_TEST_MULTI_PACK_INDEX
env variable/config pair in that file has odd semantics, but users of
repo_cfg_bool_env() have straightforward and expected semantics. If
the environment variable is set (true or false) we'll use it,
otherwise we'll use the config, and finally fall back on the
default (of "false", in this case).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt |  7 +++++++
 repo-settings.c               | 11 +++++++++++
 repository.h                  |  2 ++
 usage.c                       | 24 ++++++++++++++++++++++--
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..a2d8c274c6a 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -101,6 +101,13 @@ core.untrackedCache::
 	`feature.manyFiles` is enabled which sets this setting to
 	`true` by default.
 
+core.usageAddSource::
+	Adds the source "<file>:<line>" numbers to usage messages
+	("usage:", "fatal:", "error:", "warning:"). This setting is
+	primarily intended for those debugging or developing git
+	itself, or to compose a bug report against git itself (see
+	linkgit:git-bugreport[1]).
+
 core.checkStat::
 	When missing or is set to `default`, many fields in the stat
 	structure are checked to detect if a file has been modified
diff --git a/repo-settings.c b/repo-settings.c
index b93e91a212e..33eb582d590 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -10,6 +10,15 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 		*dest = def;
 }
 
+static void repo_cfg_bool_env(struct repository *r, const char *env,
+			      const char *key, int *dest, int def)
+{
+	*dest = git_env_bool(env, -1);
+	if (*dest != -1)
+		return;
+	repo_cfg_bool(r, key, dest, def);
+}
+
 void prepare_repo_settings(struct repository *r)
 {
 	int experimental;
@@ -45,6 +54,8 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
+	repo_cfg_bool_env(r, "GIT_TEST_USAGE_ADD_SOURCE", "core.usageaddsource",
+			  &r->settings.usage_add_source, 0);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 
 	/*
diff --git a/repository.h b/repository.h
index a057653981c..0e362f4adb2 100644
--- a/repository.h
+++ b/repository.h
@@ -41,6 +41,8 @@ struct repo_settings {
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
+
+	int usage_add_source;
 };
 
 struct repository {
diff --git a/usage.c b/usage.c
index 62313862977..409f857a8f7 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,7 @@
  */
 #include "git-compat-util.h"
 #include "cache.h"
+#include "config.h"
 
 enum usage_kind {
 	USAGE_USAGE,
@@ -14,6 +15,8 @@ enum usage_kind {
 	USAGE_BUG,
 };
 
+static int dying;
+
 static void vreportf(enum usage_kind kind,
 		     const char *file, int line,
 		     const char *err, va_list params)
@@ -23,6 +26,24 @@ static void vreportf(enum usage_kind kind,
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
 	size_t prefix_len;
+	static int addln = -1;
+
+	if (addln < 0 && dying <= 1) {
+		struct repository *r = the_repository;
+		prepare_repo_settings(r);
+		addln = r->settings.usage_add_source;
+	} else if (addln < 0 && dying) {
+		/*
+		 * We're already dying when trying to read our config,
+		 * presumably via prepare_repo_settings(). Do a
+		 * last-ditch effort of trying to get it from the
+		 * environment.
+		 */
+		const char *v = getenv("GIT_TEST_USAGE_ADD_SOURCE");
+		addln = v ? git_parse_maybe_bool(v) : 0;
+		if (addln < 1)
+			addln = 0;
+	}
 
 	switch (kind) {
 	case USAGE_USAGE:
@@ -43,7 +64,7 @@ static void vreportf(enum usage_kind kind,
 	}
 
 	/* truncation via snprintf is OK here */
-	if (kind == USAGE_BUG)
+	if (kind == USAGE_BUG || addln)
 		snprintf(prefix, sizeof(prefix), "%s%s:%d: ", prefix_i18n, file, line);
 	else
 		snprintf(prefix, sizeof(prefix), "%s", prefix_i18n);
@@ -123,7 +144,6 @@ static void warning_builtin(const char *file, int line, const char *warn, va_lis
 
 static int die_is_recursing_builtin(void)
 {
-	static int dying;
 	/*
 	 * Just an arbitrary number X where "a < x < b" where "a" is
 	 * "maximum number of pthreads we'll ever plausibly spawn" and
-- 
2.34.0.rc2.809.g11e21d44b24

