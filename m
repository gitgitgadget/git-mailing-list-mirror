From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 04/16] ref-filter: move get_head_description() from branch.c
Date: Sat, 23 Apr 2016 00:33:55 +0530
Message-ID: <1461351847-22903-5-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:04:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNg-0007zU-OF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbcDVTEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34975 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbcDVTEi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so10796922pfr.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=56vLHY6s2RpBmc6dCoRQGBvy3tb2lupIuEGMT0YJ5Gw=;
        b=oMe4nvqVmiRiJAmTmhQaGJgZEhOEtHhDc28DdEtylqmHFx24MYvyAIgKCZG5vAG28L
         fCl53CmzomUmquQ3mbv00BAtoteYDwia8jSPDt0dsqWXdZWEsKkS9KqhzqzuJuXTx+KN
         53ePxSYxZkkcf5yjVCbKDvrP1MuvBOmR/oVyxUErrdrTXaHSTb/Wil0HKaOkwAXyeovu
         g+WmtQzx4EY7DHq/mXm1iwcwjQMPrfiWfrwblK4UwJ0944sJwcwdmAP0Xig4hbMB8vj/
         LGF+y/B1DwRN+x048zqlAIjdiq9XvknSxGr2LNN1b5kf7oWN5p88O0hfSEIU/pnteq01
         gU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=56vLHY6s2RpBmc6dCoRQGBvy3tb2lupIuEGMT0YJ5Gw=;
        b=mXTo5SqpMVvHPAcsERyEcaGdLNj16hpKmR3pa3dosH84KyLp5aBXhvUqszuRZaNaEH
         tW9FoEgzDIuugQcj7K5uomc7UVcuO+MnGrvRKMMyzdAYH+NwuDquaTaET8vobUoHANaB
         DeQmYg3hYGp1Zu4KKYal0xFahapwjQv+ND7Hwmuky3O5m3rPjgI24SzS7BLbpKbd4q7H
         sqQGmqc6nGrG+B/3QH5O55gKpnXwnWq/De9Xu1XVoTk/CuiUWiLEcqlZLTwe0dxeFvuU
         VJeIt4s8B5CRXSGl9dGiAH2E9Y8/F05SdDZOOLPWQWHgAImWWZ1icWLdryYbyBWJ5IO6
         4byg==
X-Gm-Message-State: AOPr4FUagOes/y+hs5znOHF3qvh0EM8VtGwN72YlI0yGDUWgDelXJ5NwXUbpCgeOXRlAYg==
X-Received: by 10.98.9.129 with SMTP id 1mr30753670pfj.163.1461351877703;
        Fri, 22 Apr 2016 12:04:37 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:37 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292248>

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
index 0adba62..d467840 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -361,37 +361,6 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
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
index 7d3af1c..fcb3353 100644
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
