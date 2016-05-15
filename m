From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 05/17] ref-filter: move get_head_description() from branch.c
Date: Sun, 15 May 2016 16:15:21 +0530
Message-ID: <1463309133-14503-6-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:46:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tYe-0003aG-3w
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbcEOKpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:45:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36459 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbcEOKpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:45:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id g132so13141619pfb.3
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxyZRRqim8814lHiMKE/KNDPXSB4k99qxWZWwRQqoIk=;
        b=EVU0GyCKmZMEw1RjVvqquh5YCTTgnQpwolDhk5SaexICaO+jpxUEvjmRk6Y9e3ntr/
         DV1+jOgnIzN82UgUGratJ3VG2ybrcPgIQOh+Umg0MwWE7soZh96/6fMViJP5ntf/HFLR
         NXtFmgMNU71OP75zQptC2cZw/HTp4/fPdGVFO5mwyJ0td6KW8AOYP2TWYrFSVGvMx5TI
         pV6XfgdIo8PAFKQEWG2jFy0/MEkrllmcnL+12Voz3qCpeXLVxKdrN4C8c858qZdMSYKV
         Od3qP5kecoMriYMgLmQLr3Nm1MoyqBcvfg67hUEPpO26tpBt+ihLke3YdME7SwJaFCvC
         HvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxyZRRqim8814lHiMKE/KNDPXSB4k99qxWZWwRQqoIk=;
        b=lX8+NbbcF1MLwU0D7TTPcB/WXDfdq76vwVUDxSyEtx/5FK1ZrucrWpGEji2kQY/B5g
         9NmXSvFf1sePBtEDb4H5OJBTcoKONNPBewZOrwaO9PZQrDpDn/U9bZfavsyPzb2yZhQI
         Fr9npO/vKLDpawFXm2m9X68cy8lxSTh2398yTAQ+xr+ADsne9WgiLcmQb7/ryW6puSbP
         ulkwZ1lqyDQsKHtjBfMKRQAAlXtNkvL+djIZdrjC1t83vFM/4ExZ+9P6pIBA3KoFW54q
         /hkfl6UieBLdoRiFeDCFdIRDPjKD5t9a6iku9vmsPs0cEMRGwk8X/V/Qf2CAO3R8HH6F
         j+4w==
X-Gm-Message-State: AOPr4FUR79FRGRZaZqMTtl6cWQ9kZiEw/GY9hAuVoH0gGJrbkCzqDaRfD2xczD7Ga/G9Aw==
X-Received: by 10.98.109.197 with SMTP id i188mr36651866pfc.88.1463309150540;
        Sun, 15 May 2016 03:45:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:45:50 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294652>

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
 builtin/branch.c | 33 ---------------------------------
 ref-filter.c     | 38 ++++++++++++++++++++++++++++++++++++--
 ref-filter.h     |  2 ++
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ecde53..141168d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -361,39 +361,6 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
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
-		if (state.detached_at)
-			/* TRANSLATORS: make sure this matches
-			   "HEAD detached at " in wt-status.c */
-			strbuf_addf(&desc, _("(HEAD detached at %s)"),
-				state.detached_from);
-		else
-			/* TRANSLATORS: make sure this matches
-			   "HEAD detached from " in wt-status.c */
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
2.8.2
