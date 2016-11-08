Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82AC206A1
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933016AbcKHUMZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:25 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33400 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932923AbcKHUMV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:21 -0500
Received: by mail-pf0-f195.google.com with SMTP id 144so12330786pfv.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UgW14OrZzp1KIiGvHJHkE4d+WD8OThOXIUEmcdk2WI0=;
        b=bpYZj2nj2TADna1e3DJdGrQhLdQSB/3bXT5Cmcvj7UMiTNxZQNVJhaflTv7xziH2bi
         CgoPzr6AuttLiieWGigoSmJVsr7WyT0uxiaBqb1uinTofiGKb/QTDXwbwpCmesZuf4vd
         erT0XN+rGdLgVBi5SN6OK/wPThugx6KWowU/wuJA3cRW1/73MPHTGZjpNYImvmeJowQA
         Zh4N88FrfZ0HqXcb6vJSD0MGscvL54x7waNnAwxttw1EHNh2yUcBQKW0fKFfMeXct0lW
         7NO1nrq5v5iGwppuNQkmaijgyOgfD1vh5QB/UBjojH08+ZYFb1p+lc1AJ+Uwif1oBhjT
         S60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UgW14OrZzp1KIiGvHJHkE4d+WD8OThOXIUEmcdk2WI0=;
        b=Q8gYv5gHFnlSvMvtnQvYIlQT3/l/ZYDP2nG3N2JIpqn4J2EZCmc4BgIPHMvTj4Pvld
         fUQDsCDbZJ5GJUVlHB6Z8NhPUR5jgsah7F66mY4af5GcwUphbom0u+BtyHdm5bdHfCsG
         wGNemNBhOFNDluVcfI6H8PlNcwWqrK49iQsdwaQcsz+ntvlb4wJXuSAjPtebWIVFSZUl
         DS0biF3oY6atSjP62FRSoYCwEI3PqNxduhX+J3Pb2J13lHUQVIJoBifvLfBwBXvYaM8D
         P8Ab1zEn1iUMPduByfOHovKOCbYFmoyZtyLnliYZaRPwgh9pV8U0xHBlVX7nJ3wD63cq
         snEw==
X-Gm-Message-State: ABUngvfjahEkVZyDWXy0TTTQhGZUGAmzeZjSixDD3Lyvaz+iwoe36R8IGHScm54PmjRK/g==
X-Received: by 10.98.99.68 with SMTP id x65mr22388513pfb.65.1478635940332;
        Tue, 08 Nov 2016 12:12:20 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:19 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 05/17] ref-filter: move get_head_description() from branch.c
Date:   Wed,  9 Nov 2016 01:41:59 +0530
Message-Id: <20161108201211.25213-6-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

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
index d5d93a8..be9773a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -364,39 +364,6 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
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
index fe4ea2b..40bdf97 100644
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
2.10.2

