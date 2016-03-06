From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 04/15] ref-filter: move get_head_description() from branch.c
Date: Sun,  6 Mar 2016 17:34:51 +0530
Message-ID: <1457265902-7949-5-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRF-00020g-Id
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbcCFMFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:24 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33939 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbcCFMFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:17 -0500
Received: by mail-pa0-f51.google.com with SMTP id fy10so61755429pac.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/p4C+PWfIWtUCBGZCvc+4RslI2WB0r/FQAuK1l189Y=;
        b=ZQurafMq/Cu8D0KVVqz5PpA0x0Xo8QWyd2TV7qK799xDiAWNpNjV9j+34DjlWwbd0t
         nMK+rbLxlx47Ztdiuf9kiaOIdEePOWUa/5KOq4ewcuBdwoPdw3KdOhS+JVMdYSTa5T7A
         qQVos12ERcHDeKGjoOhuiWtGVY9gXIPrtgXQQgm7LHb+w/SwkVW9ufjQWXcp3duz+QqB
         ZGQG65aru1KQINLNtl48VUFhQq89gd3lGZu5PBeLMDZkAW6gsWj5I7gn+6fS0AJXHtC3
         DFV6vCc1uh7+CdZsSGZwr9qcYRkFIZ8GXixT8E0Ekp+2K75Hra2iLIYYpzYWRIFx3hjs
         OS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/p4C+PWfIWtUCBGZCvc+4RslI2WB0r/FQAuK1l189Y=;
        b=CDdEkbRR9cPi47NJtHDvDb9slp1X4/BGviiHGFdT3A4SQjrY3br6cCt3cDsD9LjewO
         Va74UBmh1y0tfllHlIRa18DUTzTMUmjDgAxACEda0kzY8BSItRnX1xItIVYc7Fn+HbBz
         GvE8+tFYmcqorDdn84o5G9E0hEkI4Ca3/2O7UjZbqe2zaSH8KvmHS1xsurC7rVLrH+3D
         UA+Q1lmt0EmlCvycDgCa7NDfPcnQWELDmstzwvdOTnppzU1U9N+ccyMwUb87+y8cFIIU
         46NeYK+Gvmrwn8ifFkdMNXm3xZ8cKCVsXeKJsf9EDpOrm86/utjH5HV2OTYLS2mEzfqt
         VqCg==
X-Gm-Message-State: AD7BkJIDtO+MrmdtD00LRPdc+IGMpQjczrplkNb9mYotbijAtNLYM8lTj9iHGQSjGHtvCQ==
X-Received: by 10.66.102.104 with SMTP id fn8mr26335619pab.129.1457265917096;
        Sun, 06 Mar 2016 04:05:17 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:16 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288348>

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
index 2ab90d4..f02344c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "git-compat-util.h"
 #include "version.h"
+#include "wt-status.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1067,6 +1068,37 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
@@ -1105,9 +1137,11 @@ static void populate_value(struct ref_array_item *ref)
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
2.7.2
