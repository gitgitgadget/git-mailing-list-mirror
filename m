From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 41/83] builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:41 +0200
Message-ID: <1461504863-15946-42-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEW-0000kl-Nx
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbcDXNft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:49 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38458 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcDXNfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:45 -0400
Received: by mail-wm0-f47.google.com with SMTP id u206so89939379wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Squ0WxkF7w4qsn63HQBlOvC3b2t9nN2FDZQO+/CYLug=;
        b=P4HVplHSoJk6v35Sn6Cr2ZaRGmjIMsYOIHUhyd7ACY8Xe0tCSQanehUHEIPQjbDLca
         VESFj/9k7e4Z97TV9emiR37qW5LZbi7PLDfxmcikrr8790/QdKq+RiAm9cO/Dbf8rr4o
         JpJL5vhhqlov917Z+ASyHMfIlzYis4MeEwN9XeYlEWrMLGD5qyLmi2uZZy7XMUGNogG7
         E7ytufWs7PCuWPSa9FtTpKP4nERT7P7F4EzkyvoDB+dl8O8iVSHk+QUygVl9IXsf1dg6
         m38IM7gf8zvtLY+rixeoKWZ4QcdtnTO3IPXm3ecqqsSYDDaQ7Js4r3+pvYpseOhdLJAb
         dcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Squ0WxkF7w4qsn63HQBlOvC3b2t9nN2FDZQO+/CYLug=;
        b=ZycYoqt3hewIv0jVOLS8y0k0rgTpgUzYbMPaDSakvstf7jckbbrVWJrD2YBLAyWin3
         Il0SJHOPkTQlqRc8vyqc3f4Bpj3yJh2KCJSDNynToMhugLl+4X/XcQi+sy6VDTLBlap/
         K8lm3huZsmuIoKQlHjesxwpkgfIqgJ9TbvojfWCI27GaTprHszSrRRCekNdej16MksWS
         h11/KO/8jporRqd1Fu+GhQbd0kIodrjVtlRZ/vVjjAAcHtWkwRDnxKjaihI+3Kamkx4p
         PWAJUA+MsIlSQbCjFCVpFWpdmz9pbkwoOh4Nd4vLMCNPBFTGrz31UsgEMMbjod+vAbdd
         fs5Q==
X-Gm-Message-State: AOPr4FW4LJp5fulj3AdK1SDX2On+almFwhZxDJGfdfuFitcN4w3dt43LRV+n/zgixpZcpg==
X-Received: by 10.28.130.6 with SMTP id e6mr7471063wmd.94.1461504944356;
        Sun, 24 Apr 2016 06:35:44 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:43 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292379>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fa07b33..bb58174 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -78,6 +78,14 @@ struct apply_state {
 
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
@@ -158,13 +166,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
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
@@ -2188,7 +2189,7 @@ static const char pluses[] =
 static const char minuses[]=
 "----------------------------------------------------------------------";
 
-static void show_stats(struct patch *patch)
+static void show_stats(struct apply_state *state, struct patch *patch)
 {
 	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
@@ -2199,7 +2200,7 @@ static void show_stats(struct patch *patch)
 	/*
 	 * "scale" the filename
 	 */
-	max = max_len;
+	max = state->max_len;
 	if (max > 50)
 		max = 50;
 
@@ -2222,13 +2223,13 @@ static void show_stats(struct patch *patch)
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
@@ -4055,7 +4056,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 	discard_index(&result);
 }
 
-static void stat_patch_list(struct patch *patch)
+static void stat_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int files, adds, dels;
 
@@ -4063,7 +4064,7 @@ static void stat_patch_list(struct patch *patch)
 		files++;
 		adds += patch->lines_added;
 		dels += patch->lines_deleted;
-		show_stats(patch);
+		show_stats(state, patch);
 	}
 
 	print_stat_summary(stdout, files, adds, dels);
@@ -4161,25 +4162,25 @@ static void summary_patch_list(struct patch *patch)
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
 
@@ -4536,7 +4537,7 @@ static int apply_patch(struct apply_state *state,
 		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
-			patch_stats(patch);
+			patch_stats(state, patch);
 			*listp = patch;
 			listp = &patch->next;
 		}
@@ -4580,7 +4581,7 @@ static int apply_patch(struct apply_state *state,
 		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
-		stat_patch_list(list);
+		stat_patch_list(state, list);
 
 	if (state->numstat)
 		numstat_patch_list(state, list);
-- 
2.8.1.300.g5fed0c0
