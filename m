From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 05/16] ref-filter: move get_head_description() from branch.c
Date: Sun, 10 Apr 2016 00:15:04 +0530
Message-ID: <1460227515-28437-6-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxt7-0003Zh-SM
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937AbcDISpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:33 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34410 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758858AbcDISpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:32 -0400
Received: by mail-ig0-f193.google.com with SMTP id qu10so6552858igc.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KUQCSbQjkdw78Bz9/S435Kpn43nC7fgJJJ79akXjtdQ=;
        b=a/JcCS3GlVLs8UbwEE1cEsBKo9yPlkYFjk+vpsWISohYiam5AWuVzGar5jCaWbRnj7
         94/je2yrkcDlW7Cl0YJh8zV/xRPW4LU8QCWEqTKgBLvgcL89zNAy3phndOgqrWBRiqMl
         O52WyUAwkaB+BKWxbeiY+sQ7RBiXZGlaW4XxDNYqh8EN8ROdOZH9a0lFd10HJk0TuA6v
         7jK8wv/u9kcGmXXuv3b6mRLaUd1rkAq3+HV/dmu93MXkESWF1nzMBvVtpEVAQiCM0TWw
         O5vM4p7Venn2nTcVbQThmnNSAj6LhYsiDh9+LNMwunYoyaaxuI4Cwo11+JlG+vlC42+t
         BVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KUQCSbQjkdw78Bz9/S435Kpn43nC7fgJJJ79akXjtdQ=;
        b=f+ycQKqtuRJb0H6MH8VikFoGwvuU3EEomXr6P7hi8lygL3VCjvl1Ltx2+bg6AOU/3l
         PoTK3zCz/c6SzVpuZg4ENMmWZnXwjZ4NkJFyj0TkRIatYShRgmvBAPup1jfNhBM0eTvU
         7HhVeHbR69CAyAWb0Vw6YTzighK5oCbT+CdrdEc16bo3ozRWkItNsTeG9NVVB/J5OP2D
         N9Jby5Q7oGrOjoZDfYbnf6XoQyrA+WbEZlY5aCnzvB1akpg5iqQikB3t+A5+etwIRWxL
         T4DkajQcF6gDYGQcSdRVGfxwizD3i650QPE6L+UwLLEd3/RmPWfhibiBNBjb4oisS+yS
         LZrg==
X-Gm-Message-State: AD7BkJI3JJTPVR+xKU6V0RpJ49WpJf9m3mo3J10iCPcwN1himR5NBOBU2yIFlJvAseTJHg==
X-Received: by 10.50.50.234 with SMTP id f10mr10399147igo.37.1460227531855;
        Sat, 09 Apr 2016 11:45:31 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:31 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291109>

Move the implementation of get_head_description() from branch.c to
ref-filter.  This gives a description of the HEAD ref if called. This
is used as the refname for the HEAD ref whenever the
FILTER_REFS_DETACHED_HEAD option is used. Make it public because we
need it to calculate the length of the HEAD refs description in
branch.c:calc_maxwidth() when we port branch.c to use ref-filter
APIs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 31 -------------------------------
 ref-filter.c     | 38 ++++++++++++++++++++++++++++++++++++--
 ref-filter.h     |  2 ++
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..460f32f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -355,37 +355,6 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
 	strbuf_release(&subject);
 }
 
-static char *get_head_description(void)
-{
-	struct strbuf desc = STRBUF_INIT;
-	struct wt_status_state state;
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
-	if (state.rebase_in_progress ||
-	    state.rebase_interactive_in_progress)
-		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
-			    state.branch);
-	else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
-			    state.branch);
-	else if (state.detached_from) {
-		/* TRANSLATORS: make sure these match _("HEAD detached at ")
-		   and _("HEAD detached from ") in wt-status.c */
-		if (state.detached_at)
-			strbuf_addf(&desc, _("(HEAD detached at %s)"),
-				state.detached_from);
-		else
-			strbuf_addf(&desc, _("(HEAD detached from %s)"),
-				state.detached_from);
-	}
-	else
-		strbuf_addstr(&desc, _("(no branch)"));
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
-	return strbuf_detach(&desc, NULL);
-}
-
 static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 				      struct ref_filter *filter, const char *remote_prefix)
 {
diff --git a/ref-filter.c b/ref-filter.c
index 17f781d..7004bf0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "git-compat-util.h"
 #include "version.h"
+#include "wt-status.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1077,6 +1078,37 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = refname;
 }
 
+char *get_head_description(void)
+{
+	struct strbuf desc = STRBUF_INIT;
+	struct wt_status_state state;
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state, 1);
+	if (state.rebase_in_progress ||
+	    state.rebase_interactive_in_progress)
+		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
+			    state.branch);
+	else if (state.bisect_in_progress)
+		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
+			    state.branch);
+	else if (state.detached_from) {
+		/* TRANSLATORS: make sure these match _("HEAD detached at ")
+		   and _("HEAD detached from ") in wt-status.c */
+		if (state.detached_at)
+			strbuf_addf(&desc, _("(HEAD detached at %s)"),
+				state.detached_from);
+		else
+			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+				state.detached_from);
+	}
+	else
+		strbuf_addstr(&desc, _("(no branch)"));
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+	return strbuf_detach(&desc, NULL);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1116,9 +1148,11 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (starts_with(name, "refname")) {
 			refname = ref->refname;
-		else if (starts_with(name, "symref"))
+			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+				refname = get_head_description();
+		} else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e..4aea594 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -106,5 +106,7 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
+/*  Get the current HEAD's description */
+char *get_head_description(void);
 
 #endif /*  REF_FILTER_H  */
-- 
2.8.0
