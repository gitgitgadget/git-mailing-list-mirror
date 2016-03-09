From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 42/48] builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:10 +0100
Message-ID: <1457545756-20616-43-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJL-0000P4-IP
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933786AbcCIRyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:13 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35115 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933766AbcCIRxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:55 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so190256361wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SRiHU7AaXNcwnKs6RkZE3GacWMc5ffapx9q/+vqtUGU=;
        b=y377nbN4CorJVES1jl395/EDveDxqLrZqONZEGRbWwB+8i4DExFldwOSm3gqj+HeuS
         qHaj6ln3UqIuz4n8Nq3CWdMrb1U+BiEm2N1UtZqTKBzs9vSQUxP9h9y+X8qZTDnNqLjj
         rkIo582ydPWGv+YnLbUPUSSQFKkBm3mZJoGUADZ/iN/UrYlJckhOR6KEHb+T+O1QYlbV
         4391n4jnmIvVGCNuKZah8BmT9N7j+uful6RZSq6fR56MaqAD+qfuCTBdCTIKmp3feWWj
         b+zBOi7BRo3O7Z52cl3YRVcyfSuFVcsOanvOiodfynMmTnMCgxfuyeOHbfhYKKO+VTKt
         Ct+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SRiHU7AaXNcwnKs6RkZE3GacWMc5ffapx9q/+vqtUGU=;
        b=KqZqU19gRRnMEPkkmE+WrghpC7LvOBgIs1GGpwj5MvSvW3HFrtIOOlLw7lNv6yn05f
         U1JSmTv1EGWtFVKoBusydcMA/ZyI8xAkEJm2Mk9KMwbyYFVU+TcrnMkOeQqzcCmVsZDS
         Wrn/vJNj88RYcqRAWU19qtlcC0JLfgEOuJWKdJf1XPYIK6IakNCE5hrh9f1MrQ0GQBcI
         lEyr6o1hMKfPQebGxzJkUE7pdBEFA2rvUhCmcr/JB9ADfzTU9KiSMRa9OEHkfTvwDKj9
         Y/33h5JzrwZWCzBrPIxw95vMoieGfGPoUuM6D4vZrcaCR9nxY7HqRLKGuzrkDB3Iy2Wo
         ND3w==
X-Gm-Message-State: AD7BkJId6C5poPPg5NWHoYCW/VRH+Tu3vp27kSulmm+8CTx7npWo9ST12OZBvC4oc4nh1g==
X-Received: by 10.28.147.72 with SMTP id v69mr25679728wmd.79.1457546033512;
        Wed, 09 Mar 2016 09:53:53 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:52 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288530>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dbb9f0b..79224fd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -79,6 +79,14 @@ struct apply_state {
 
 	int line_termination;
 
+	/*
+	 * For "diff-stat" like behaviour, we keep track of the biggest change
+	 * we've seen, and the longest filename. That allows us to do simple
+	 * scaling.
+	 */
+	int max_change;
+	int max_len;
+
 	int p_value;
 	int p_value_known;
 	unsigned int p_context;
@@ -159,13 +167,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
 }
 
 /*
- * For "diff-stat" like behaviour, we keep track of the biggest change
- * we've seen, and the longest filename. That allows us to do simple
- * scaling.
- */
-static int max_change, max_len;
-
-/*
  * Various "current state", notably line numbers and what
  * file (and how) we're patching right now.. The "is_xxxx"
  * things are flags, where -1 means "don't know yet".
@@ -2191,7 +2192,7 @@ static const char pluses[] =
 static const char minuses[]=
 "----------------------------------------------------------------------";
 
-static void show_stats(struct patch *patch)
+static void show_stats(struct apply_state *state, struct patch *patch)
 {
 	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
@@ -2202,7 +2203,7 @@ static void show_stats(struct patch *patch)
 	/*
 	 * "scale" the filename
 	 */
-	max = max_len;
+	max = state->max_len;
 	if (max > 50)
 		max = 50;
 
@@ -2225,13 +2226,13 @@ static void show_stats(struct patch *patch)
 	/*
 	 * scale the add/delete
 	 */
-	max = max + max_change > 70 ? 70 - max : max_change;
+	max = max + state->max_change > 70 ? 70 - max : state->max_change;
 	add = patch->lines_added;
 	del = patch->lines_deleted;
 
-	if (max_change > 0) {
-		int total = ((add + del) * max + max_change / 2) / max_change;
-		add = (add * max + max_change / 2) / max_change;
+	if (state->max_change > 0) {
+		int total = ((add + del) * max + state->max_change / 2) / state->max_change;
+		add = (add * max + state->max_change / 2) / state->max_change;
 		del = total - add;
 	}
 	printf("%5d %.*s%.*s\n", patch->lines_added + patch->lines_deleted,
@@ -4058,7 +4059,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 	discard_index(&result);
 }
 
-static void stat_patch_list(struct patch *patch)
+static void stat_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int files, adds, dels;
 
@@ -4066,7 +4067,7 @@ static void stat_patch_list(struct patch *patch)
 		files++;
 		adds += patch->lines_added;
 		dels += patch->lines_deleted;
-		show_stats(patch);
+		show_stats(state, patch);
 	}
 
 	print_stat_summary(stdout, files, adds, dels);
@@ -4164,25 +4165,25 @@ static void summary_patch_list(struct patch *patch)
 	}
 }
 
-static void patch_stats(struct patch *patch)
+static void patch_stats(struct apply_state *state, struct patch *patch)
 {
 	int lines = patch->lines_added + patch->lines_deleted;
 
-	if (lines > max_change)
-		max_change = lines;
+	if (lines > state->max_change)
+		state->max_change = lines;
 	if (patch->old_name) {
 		int len = quote_c_style(patch->old_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->old_name);
-		if (len > max_len)
-			max_len = len;
+		if (len > state->max_len)
+			state->max_len = len;
 	}
 	if (patch->new_name) {
 		int len = quote_c_style(patch->new_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->new_name);
-		if (len > max_len)
-			max_len = len;
+		if (len > state->max_len)
+			state->max_len = len;
 	}
 }
 
@@ -4535,7 +4536,7 @@ static int apply_patch(struct apply_state *state,
 		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
-			patch_stats(patch);
+			patch_stats(state, patch);
 			*listp = patch;
 			listp = &patch->next;
 		}
@@ -4577,7 +4578,7 @@ static int apply_patch(struct apply_state *state,
 		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
-		stat_patch_list(list);
+		stat_patch_list(state, list);
 
 	if (state->numstat)
 		numstat_patch_list(state, list);
-- 
2.8.0.rc1.49.gca61272
