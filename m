Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3144AC3F68F
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED20C20838
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aTbNOYmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgAXJZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:33 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52084 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgAXJZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:32 -0500
Received: by mail-wm1-f45.google.com with SMTP id t23so983805wmi.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCK1M6XYbZYN8AO5fuXYUV2/8jZqq1qwxiW1947lphs=;
        b=aTbNOYmoLMWpnPOdXQ825OAodTFBfMfHyNSmbpk6uFAuYEPOk/kuWMWtn61rwLtX3r
         dQjeS7BnV/jb1WhuaZZUntFASax2EsTJ/9uRhQJS8bzfMM3kPwD/ihbYMuvGPnOaoovs
         sywoZGZCp6WUbS1rKcxsgPUo/AEXzQvtYdC17e2iZzZuTWFJNXBuQYL8NP4lMLYOX1KM
         hE7MuVAW4cH9S8lIrXOlMJGCtqyZJBQBk6TE4QkhZyMeRVyxD9Q4HxI292Wb4SFAnucR
         KaJX88pwgJ9ZPIefIu1b9OcA3dY2LJKsuK24o5Uwd4PSm2u0x8yVZGBBjGeO2tGiz45t
         hczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCK1M6XYbZYN8AO5fuXYUV2/8jZqq1qwxiW1947lphs=;
        b=SBD4EKHzD1Wja+pFQ+YwB/dUiuldqLUoWbKxw/Ju5LOwn9kDKpidcrmjtodRER4Q5A
         rwpq1hsHuLJuWj4CznC2roxJLWoPO7VavJTABd1hLFloy/ZtAk532llAIJ54hn483tXC
         SadmHxc/RVNP/UZmm3oSt8f2WT8ZLeldNGMjBy+n9fVkA7MIlN6qkJV5cuqI8ybo3JvM
         Gn3UdiF01zoxr+p+YK/d8b+9Zyaf0p2bVT3HfN1/ldDYI9YjAVUvbwNBRbIo6gC02v1r
         PpL7ZGJFfo4XFiOpkqsY3YkmVvh/Q9BSjuQ+4F1IHR09H0rLrmwF6LCjQOer9oPSfqHK
         mo4g==
X-Gm-Message-State: APjAAAUITbyfNPy5rH7kNlahdcIbnqKLhnoq48nTdJOpI/X5vGrkOmBU
        YQjZwlknrFG26seKfso=
X-Google-Smtp-Source: APXvYqzkWUyg6vs5F7UxIG+0XoZhuhaR8RUnWt8LqHJ3YdC5d56v3AytojA80YjF5q2ShFNH7ysYTw==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr2386965wmj.75.1579857930155;
        Fri, 24 Jan 2020 01:25:30 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id q6sm7132757wrx.72.2020.01.24.01.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:29 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
Date:   Fri, 24 Jan 2020 10:25:21 +0100
Message-Id: <803d3aa1162da020b3e284be04de6ebad88935aa.1579857394.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
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
Changes since v1:
 * Add comment that 'git remote rename' considers unknown `.rebase' values
   as false

Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>
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

