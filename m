Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2345C35247
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF039214DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BmCj99Dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgA0HEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:04:39 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38862 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0HEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:04:38 -0500
Received: by mail-wm1-f41.google.com with SMTP id a9so840957wmj.3
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecCmAiGO/qz6ap22l9p1SLJLmjwDCtSpoVvn8n401+8=;
        b=BmCj99Dhf5slqACGagyMtGL+s93u3G+nxwDPhc0EHz4I+eUT/EpVoIwdMc18/jDaPt
         47lJm2nCJ6NqvYE8d0Anqt80IDFEKBVOOCdwVHH5XkOORf95HQ5gFLQhKx3pQuHx4uKJ
         tQTwYGQR/imFQZkm43zcKFmG40E4NY0mr2/6Awpywpc83OdBmgvMCIzzn7TsoeN7ogMf
         RtRrzLnA/IBostV34BlxJrvCWaqoyS8gaZ/CVCcpBYrkcCzznGCpnRGyA4OTNqnXgBvs
         C9SP6v8vt0/iuMfp5lTKvaKjNLyiLK6G4Cvv0wM1Cordnero7AYaecisxAUuBPbhNTc0
         mNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecCmAiGO/qz6ap22l9p1SLJLmjwDCtSpoVvn8n401+8=;
        b=OC/DigQ4Hlrrp3bbAhzc4VUVAmXrLMzhFJzqoP48wO9DQwlezA3RaT94VSgI2iOZyc
         bVXMhLRVKraqT6u6jYh7BIEgGVK75BLX/3mYmy3ExxgqNUm+I3tWdPm5wo3c6pGozl+T
         4jYpPrZJSvzBp7fQOpQS2EU/3CnxP2zQXDtxLj00FkdwSfDEQvaDzw32o6c3d5IweE9U
         9or0eHZOvmHLk4H1MyS0jIEobnVbUJb4NY11bPRpsTjCGhpeRq1f5svnQgGeSk/2Oyya
         u1TAHfBdrmliDyXwDkZVWdUq6GYr+buAgHAiHDquaqvGA/MbxttJNkI4CZPtVH3E1Aau
         ChJA==
X-Gm-Message-State: APjAAAVs3mCBe8ma6lJU1wY6V/tDHS7uEoRxMbuzmWYGtZQ8fAaMW29b
        zMOBNcjWJl6cFpm3pO8=
X-Google-Smtp-Source: APXvYqwX+BTMs/EIpk8d4Nozqweye83vFgtZfessfY1VtKNJci+JliFiBuGR+tp3Ckpr3vx8LGPzmg==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr11523716wmg.143.1580108674838;
        Sun, 26 Jan 2020 23:04:34 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id u16sm17189334wmj.41.2020.01.26.23.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 23:04:34 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
Date:   Mon, 27 Jan 2020 08:04:27 +0100
Message-Id: <1bf42c00536b47d1e120fff9a7dc026c445ae3a9.1580108477.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1580108477.git.bert.wesarg@googlemail.com>
References: <cover.1580108477.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 46af44b07d (pull --rebase=<type>: allow single-letter abbreviations
for the type, 2018-08-04) landed in Git, it had the side effect that
not only 'pull --rebase=<type>' accepted the single-letter abbreviations
but also the 'pull.rebase' and 'branch.<name>.rebase' configurations.

However, 'git remote rename' did not honor these single-letter
abbreviations when reading the 'branch.*.rebase' configurations.

We now document the single-letter abbreviations and both code places
share a common function to parse the values of 'git pull --rebase=*',
'pull.rebase', and 'branches.*.rebase'.

The only functional change is the handling of the `branch_info::rebase`
value. Before it was an unsigned enum, thus the truth value could be
checked with `branch_info::rebase != 0`. But `enum rebase_type` is
signed, thus the truth value must now be checked with
`branch_info::rebase >= REBASE_TRUE`

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>

changes since v1:
 * Add comment that 'git remote rename' considers unknown `.rebase' values
   as false
---
 Documentation/config/branch.txt |  7 ++++---
 Documentation/config/pull.txt   |  7 ++++---
 Makefile                        |  1 +
 builtin/pull.c                  | 29 ++++-----------------------
 builtin/remote.c                | 30 +++++++++++-----------------
 rebase.c                        | 35 +++++++++++++++++++++++++++++++++
 rebase.h                        | 15 ++++++++++++++
 7 files changed, 75 insertions(+), 49 deletions(-)
 create mode 100644 rebase.c
 create mode 100644 rebase.h

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index a592d522a7..cc5f3249fc 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -81,15 +81,16 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
-When `merges`, pass the `--rebase-merges` option to 'git rebase'
+When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When `preserve` (deprecated in favor of `merges`), also pass
+When `preserve` (or just 'p', deprecated in favor of `merges`), also pass
 `--preserve-merges` along to 'git rebase' so that locally committed merge
 commits will not be flattened by running 'git pull'.
 +
-When the value is `interactive`, the rebase is run in interactive mode.
+When the value is `interactive` (or just 'i'), the rebase is run in interactive
+mode.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index b87cab31b3..5404830609 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -14,15 +14,16 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
-When `merges`, pass the `--rebase-merges` option to 'git rebase'
+When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When `preserve` (deprecated in favor of `merges`), also pass
+When `preserve` (or just 'p', deprecated in favor of `merges`), also pass
 `--preserve-merges` along to 'git rebase' so that locally committed merge
 commits will not be flattened by running 'git pull'.
 +
-When the value is `interactive`, the rebase is run in interactive mode.
+When the value is `interactive` (or just 'i'), the rebase is run in interactive
+mode.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
diff --git a/Makefile b/Makefile
index 09f98b777c..96ced97bff 100644
--- a/Makefile
+++ b/Makefile
@@ -954,6 +954,7 @@ LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
+LIB_OBJS += rebase.o
 LIB_OBJS += rebase-interactive.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
diff --git a/builtin/pull.c b/builtin/pull.c
index d25ff13a60..888181c07c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -15,6 +15,7 @@
 #include "sha1-array.h"
 #include "remote.h"
 #include "dir.h"
+#include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
 #include "revision.h"
@@ -26,15 +27,6 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
-enum rebase_type {
-	REBASE_INVALID = -1,
-	REBASE_FALSE = 0,
-	REBASE_TRUE,
-	REBASE_PRESERVE,
-	REBASE_MERGES,
-	REBASE_INTERACTIVE
-};
-
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -45,22 +37,9 @@ enum rebase_type {
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
 {
-	int v = git_parse_maybe_bool(value);
-
-	if (!v)
-		return REBASE_FALSE;
-	else if (v > 0)
-		return REBASE_TRUE;
-	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
-		return REBASE_PRESERVE;
-	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
-		return REBASE_MERGES;
-	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
-		return REBASE_INTERACTIVE;
-	/*
-	 * Please update _git_config() in git-completion.bash when you
-	 * add new rebase modes.
-	 */
+	enum rebase_type v = rebase_parse_value(value);
+	if (v != REBASE_INVALID)
+		return v;
 
 	if (fatal)
 		die(_("Invalid value for %s: %s"), key, value);
diff --git a/builtin/remote.c b/builtin/remote.c
index 96bbe828fe..6802765e73 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
 #include "object-store.h"
@@ -248,9 +249,7 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote_name;
 	struct string_list merge;
-	enum {
-		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
-	} rebase;
+	enum rebase_type rebase;
 };
 
 static struct string_list branch_list = STRING_LIST_INIT_NODUP;
@@ -305,17 +304,12 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(&info->merge, xstrdup(value));
-		} else {
-			int v = git_parse_maybe_bool(value);
-			if (v >= 0)
-				info->rebase = v;
-			else if (!strcmp(value, "preserve"))
-				info->rebase = NORMAL_REBASE;
-			else if (!strcmp(value, "merges"))
-				info->rebase = REBASE_MERGES;
-			else if (!strcmp(value, "interactive"))
-				info->rebase = INTERACTIVE_REBASE;
-		}
+		} else
+			/*
+			 * Consider invalid values as false and check the
+			 * truth value with >= REBASE_TRUE.
+			 */
+			info->rebase = rebase_parse_value(value);
 	}
 	return 0;
 }
@@ -943,7 +937,7 @@ static int add_local_to_show_info(struct string_list_item *branch_item, void *cb
 		return 0;
 	if ((n = strlen(branch_item->string)) > show_info->width)
 		show_info->width = n;
-	if (branch_info->rebase)
+	if (branch_info->rebase >= REBASE_TRUE)
 		show_info->any_rebase = 1;
 
 	item = string_list_insert(show_info->list, branch_item->string);
@@ -960,16 +954,16 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	int width = show_info->width + 4;
 	int i;
 
-	if (branch_info->rebase && branch_info->merge.nr > 1) {
+	if (branch_info->rebase >= REBASE_TRUE && branch_info->merge.nr > 1) {
 		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
 			item->string);
 		return 0;
 	}
 
 	printf("    %-*s ", show_info->width, item->string);
-	if (branch_info->rebase) {
+	if (branch_info->rebase >= REBASE_TRUE) {
 		const char *msg;
-		if (branch_info->rebase == INTERACTIVE_REBASE)
+		if (branch_info->rebase == REBASE_INTERACTIVE)
 			msg = _("rebases interactively onto remote %s");
 		else if (branch_info->rebase == REBASE_MERGES)
 			msg = _("rebases interactively (with merges) onto "
diff --git a/rebase.c b/rebase.c
new file mode 100644
index 0000000000..f8137d859b
--- /dev/null
+++ b/rebase.c
@@ -0,0 +1,35 @@
+#include "rebase.h"
+#include "config.h"
+
+/*
+ * Parses textual value for pull.rebase, branch.<name>.rebase, etc.
+ * Unrecognised value yields REBASE_INVALID, which traditionally is
+ * treated the same way as REBASE_FALSE.
+ *
+ * The callers that care if (any) rebase is requested should say
+ *   if (REBASE_TRUE <= rebase_parse_value(string))
+ *
+ * The callers that want to differenciate an unrecognised value and
+ * false can do so by treating _INVALID and _FALSE differently.
+ */
+enum rebase_type rebase_parse_value(const char *value)
+{
+	int v = git_parse_maybe_bool(value);
+
+	if (!v)
+		return REBASE_FALSE;
+	else if (v > 0)
+		return REBASE_TRUE;
+	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
+		return REBASE_PRESERVE;
+	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
+		return REBASE_MERGES;
+	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
+		return REBASE_INTERACTIVE;
+	/*
+	 * Please update _git_config() in git-completion.bash when you
+	 * add new rebase modes.
+	 */
+
+	return REBASE_INVALID;
+}
diff --git a/rebase.h b/rebase.h
new file mode 100644
index 0000000000..cc723d4748
--- /dev/null
+++ b/rebase.h
@@ -0,0 +1,15 @@
+#ifndef REBASE_H
+#define REBASE_H
+
+enum rebase_type {
+	REBASE_INVALID = -1,
+	REBASE_FALSE = 0,
+	REBASE_TRUE,
+	REBASE_PRESERVE,
+	REBASE_MERGES,
+	REBASE_INTERACTIVE
+};
+
+enum rebase_type rebase_parse_value(const char *value);
+
+#endif /* REBASE */
-- 
2.24.1.497.g9abd7b20b4.dirty

