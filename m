From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 01/44] apply: move 'struct apply_state' to apply.h
Date: Fri, 10 Jun 2016 22:10:35 +0200
Message-ID: <20160610201118.13813-2-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmS-0002zI-CO
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbcFJULp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:11:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33181 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcFJULm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1066754wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C1H05LexHO9YDsxvjdbhwO/nt+iByAX4DBFlH99had4=;
        b=YloLYDVX76k+fNWRZ7mrGuyynb1Ah5hG74hPHaMRh9EjVvG+QJEMyGpHWoK+COLPMy
         hFKtxBznUHAUzArU2nAtcJI8kCWHGN8n3hJgpeWCZeBpfherLeMrLhEfQFnVMA89dKc9
         WeWphBLxgBEHJmnajqpBIj8woLF0J51jKsIH3gx7shDaHaUR+1hSXXgryHUutGuEDWDm
         PXoyyujpZhWfLPL+xfzdyXpbIbebSAshX2kMdjPX4k0A2obe3mgd4tx/WGWEr9GRE16k
         JXjWyyz1iKHWa3nadOU/mJYgde2Fa/0YSpStI7BPk0gt40Tz+fzTXN6HcNb/QHJ/oWAm
         x3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C1H05LexHO9YDsxvjdbhwO/nt+iByAX4DBFlH99had4=;
        b=WKm+2+1LTP2q0Agr3Idrfspf7TCip0jCFtD6yqjI5cceGw6u11VkPmaWqi0taLjfLC
         9AbtMoSaixMzj5RARm/KS4ltgzhFrhYGE0BYjf6+CFhWALuxpAI7fYveoTNIXOhcAhRh
         fGZqBqoF1m/gN867Z/2m1oVcBRYUqKiA6OnZ2dH/egWFy1icYqZno79qHWLssCUnKOZO
         hRGcFnqQt9VtGfz3gRpUgYBnDGG6EsZMfxYlrhkkh1kGY8IUqbnosnclyJ10rip0KPA/
         F6PunN8WyRDFF868nElXuYkqt8BvMR1ewG8tLNzLtI0v2aHEHr27IpdcY/m0zAhrx9+y
         rAZg==
X-Gm-Message-State: ALyK8tKAUxkq7ZbYpfbgqGCIapoUUp/57a/Zfb/ncZMWRBOvX+QnsDiRJsjGDxEND5ZwOg==
X-Received: by 10.194.103.105 with SMTP id fv9mr3702385wjb.162.1465589501033;
        Fri, 10 Jun 2016 13:11:41 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297026>

To libify `git apply` functionality we must make 'struct apply_state'
usable outside "builtin/apply.c".

Let's do that by creating a new "apply.h" and moving
'struct apply_state' there.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/apply.c |  98 +-----------------------------------------------------
 2 files changed, 101 insertions(+), 97 deletions(-)
 create mode 100644 apply.h

diff --git a/apply.h b/apply.h
new file mode 100644
index 0000000..9a98eae
--- /dev/null
+++ b/apply.h
@@ -0,0 +1,100 @@
+#ifndef APPLY_H
+#define APPLY_H
+
+enum ws_error_action {
+	nowarn_ws_error,
+	warn_on_ws_error,
+	die_on_ws_error,
+	correct_ws_error
+};
+
+enum ws_ignore {
+	ignore_ws_none,
+	ignore_ws_change
+};
+
+/*
+ * We need to keep track of how symlinks in the preimage are
+ * manipulated by the patches.  A patch to add a/b/c where a/b
+ * is a symlink should not be allowed to affect the directory
+ * the symlink points at, but if the same patch removes a/b,
+ * it is perfectly fine, as the patch removes a/b to make room
+ * to create a directory a/b so that a/b/c can be created.
+ *
+ * See also "struct string_list symlink_changes" in "struct
+ * apply_state".
+ */
+#define SYMLINK_GOES_AWAY 01
+#define SYMLINK_IN_RESULT 02
+
+struct apply_state {
+	const char *prefix;
+	int prefix_length;
+
+	/* These are lock_file related */
+	struct lock_file *lock_file;
+	int newfd;
+
+	/* These control what gets looked at and modified */
+	int apply; /* this is not a dry-run */
+	int cached; /* apply to the index only */
+	int check; /* preimage must match working tree, don't actually apply */
+	int check_index; /* preimage must match the indexed version */
+	int update_index; /* check_index && apply */
+
+	/* These control cosmetic aspect of the output */
+	int diffstat; /* just show a diffstat, and don't actually apply */
+	int numstat; /* just show a numeric diffstat, and don't actually apply */
+	int summary; /* just report creation, deletion, etc, and don't actually apply */
+
+	/* These boolean parameters control how the apply is done */
+	int allow_overlap;
+	int apply_in_reverse;
+	int apply_with_reject;
+	int apply_verbosely;
+	int no_add;
+	int threeway;
+	int unidiff_zero;
+	int unsafe_paths;
+
+	/* Other non boolean parameters */
+	const char *fake_ancestor;
+	const char *patch_input_file;
+	int line_termination;
+	struct strbuf root;
+	int p_value;
+	int p_value_known;
+	unsigned int p_context;
+
+	/* Exclude and include path parameters */
+	struct string_list limit_by_name;
+	int has_include;
+
+	/* Various "current state" */
+	int linenr; /* current line number */
+	struct string_list symlink_changes; /* we have to track symlinks */
+
+	/*
+	 * For "diff-stat" like behaviour, we keep track of the biggest change
+	 * we've seen, and the longest filename. That allows us to do simple
+	 * scaling.
+	 */
+	int max_change;
+	int max_len;
+
+	/*
+	 * Records filenames that have been touched, in order to handle
+	 * the case where more than one patches touch the same file.
+	 */
+	struct string_list fn_table;
+
+	/* These control whitespace errors */
+	enum ws_error_action ws_error_action;
+	enum ws_ignore ws_ignore_action;
+	const char *whitespace_option;
+	int whitespace_error;
+	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
+};
+
+#endif
diff --git a/builtin/apply.c b/builtin/apply.c
index ecb7f1b..3a0c53a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -20,103 +20,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "rerere.h"
-
-enum ws_error_action {
-	nowarn_ws_error,
-	warn_on_ws_error,
-	die_on_ws_error,
-	correct_ws_error
-};
-
-
-enum ws_ignore {
-	ignore_ws_none,
-	ignore_ws_change
-};
-
-/*
- * We need to keep track of how symlinks in the preimage are
- * manipulated by the patches.  A patch to add a/b/c where a/b
- * is a symlink should not be allowed to affect the directory
- * the symlink points at, but if the same patch removes a/b,
- * it is perfectly fine, as the patch removes a/b to make room
- * to create a directory a/b so that a/b/c can be created.
- *
- * See also "struct string_list symlink_changes" in "struct
- * apply_state".
- */
-#define SYMLINK_GOES_AWAY 01
-#define SYMLINK_IN_RESULT 02
-
-struct apply_state {
-	const char *prefix;
-	int prefix_length;
-
-	/* These are lock_file related */
-	struct lock_file *lock_file;
-	int newfd;
-
-	/* These control what gets looked at and modified */
-	int apply; /* this is not a dry-run */
-	int cached; /* apply to the index only */
-	int check; /* preimage must match working tree, don't actually apply */
-	int check_index; /* preimage must match the indexed version */
-	int update_index; /* check_index && apply */
-
-	/* These control cosmetic aspect of the output */
-	int diffstat; /* just show a diffstat, and don't actually apply */
-	int numstat; /* just show a numeric diffstat, and don't actually apply */
-	int summary; /* just report creation, deletion, etc, and don't actually apply */
-
-	/* These boolean parameters control how the apply is done */
-	int allow_overlap;
-	int apply_in_reverse;
-	int apply_with_reject;
-	int apply_verbosely;
-	int no_add;
-	int threeway;
-	int unidiff_zero;
-	int unsafe_paths;
-
-	/* Other non boolean parameters */
-	const char *fake_ancestor;
-	const char *patch_input_file;
-	int line_termination;
-	struct strbuf root;
-	int p_value;
-	int p_value_known;
-	unsigned int p_context;
-
-	/* Exclude and include path parameters */
-	struct string_list limit_by_name;
-	int has_include;
-
-	/* Various "current state" */
-	int linenr; /* current line number */
-	struct string_list symlink_changes; /* we have to track symlinks */
-
-	/*
-	 * For "diff-stat" like behaviour, we keep track of the biggest change
-	 * we've seen, and the longest filename. That allows us to do simple
-	 * scaling.
-	 */
-	int max_change;
-	int max_len;
-
-	/*
-	 * Records filenames that have been touched, in order to handle
-	 * the case where more than one patches touch the same file.
-	 */
-	struct string_list fn_table;
-
-	/* These control whitespace errors */
-	enum ws_error_action ws_error_action;
-	enum ws_ignore ws_ignore_action;
-	const char *whitespace_option;
-	int whitespace_error;
-	int squelch_whitespace_errors;
-	int applied_after_fixing_ws;
-};
+#include "apply.h"
 
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
-- 
2.9.0.rc2.362.g3cd93d0
