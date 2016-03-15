From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/16] ref-filter: move get_head_description() from branch.c
Date: Tue, 15 Mar 2016 22:17:05 +0530
Message-ID: <1458060436-1215-6-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8G-0000lK-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbcCOQrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:39 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36005 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934729AbcCOQrf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:35 -0400
Received: by mail-pf0-f175.google.com with SMTP id u190so35740725pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9R/9cGh9z6I4vsQWz/FHn1VQEAISBKbRXkYYEv4uo7U=;
        b=TS5CxbNvWUE2GFCZTJiqE2DGI5AcTTw1JN4qHH9cgJFMvnEUw9UTwiP6C3uvpGdLMo
         riUJc9+UhpflMxAVcmDfYFamwHQHPUxhvJ412esHdT4R5yF/l3/rKDGtEcZHRaS2CG/u
         1a63FBVFSW94V4qBlXyFGHKdBClGcJlXuvU1G7ypcbIP83Rf1Ko+uBBLgo55TkG0xTOa
         xqATy63HApqiWIaq3oo0y7muuEWy9AaA7MxrMm2UsswqJH798FT7gdTQbDoV76mNE4Pa
         fgUulqLC2IcCZxq6jreEXgq2OX8FZKoEn9HrAmAzcFYBRs85nJJTcM1CZywM4yebd7g6
         647g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9R/9cGh9z6I4vsQWz/FHn1VQEAISBKbRXkYYEv4uo7U=;
        b=Pmiln7uvGUCQpNcQjL298RusPFkZQUgovBJEeayQD/KclfKYKOigAO/6ZPkVn+QWYw
         lzGKdke8B4OeqxgVoz9AlLiw7LbObbQAKYXyykxEEfLnK7//e2WyGXShvFDcIwX4eNIo
         Om8gDuBWyxDV34ApPRH24Khn+ORJpU7+2q8WNxOWTWxxzPtL6zJDL/zRN6qYhFE+WrNA
         ne37gDToD4TTNLYatp9JhLWMw5VqM7sdGAwlsgkcGkayRGNgWOdsvlx3OaHyVf1gb2IQ
         l+sVZWXl++Gh4LshgQ7HBAeKVjyW1DuYyh87SP+/sJtUaOQe5MEe8ekDk44i7F5j9RCr
         H1cw==
X-Gm-Message-State: AD7BkJIjwmBTnaKPnty4IQ+z8k297/kMTlqeMWZULhV4i+zm1PK+Nnv17AsenLgj+lDGEQ==
X-Received: by 10.98.68.71 with SMTP id r68mr40080649pfa.119.1458060454715;
        Tue, 15 Mar 2016 09:47:34 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:34 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288867>

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
2.7.3
