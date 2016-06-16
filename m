From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 42/94] builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:53 +0200
Message-ID: <20160511131745.2914-43-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3W-00036O-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbcEKNT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34996 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226AbcEKNTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9406874wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=31x7ViV64UOebSAstACya9nQCDPeHxt5oPd8lRLRyps=;
        b=m/6jvHHOfRqa1jNksdc6xdlMk4ZP6Yq0WpxooxFzDz9ESEpeGgejwJJg/W71pZyr/4
         1urxLm9KjLLzUsoWfyF9CgXa9plE51gksC8Wr4iozUcoRXcUnmx42bSsU+w8dU7fGukd
         /cTkxA2eB5b37QgJl9Ldmie3kPIXMmeZkIhl80kwU0sza/0N2C5JkRjNwHJHLFbsTbFS
         jAFvP0sw7LPlhQJ4CTEGWgqGXJeSH78FtPlTe9wVeqyotxXH6BMHYNdJF0LfLu79h6tE
         mgU6bGZ+R+soLZHNAg265W9EjE8UHfkbowTwKGsi5siAt0JD/tC9E3n9AqYFJri4by3e
         0JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=31x7ViV64UOebSAstACya9nQCDPeHxt5oPd8lRLRyps=;
        b=XLHHXahA86v742JehVyVjyQeKWZ/NNV5at/+uBCjqFOZA1LAAVQyov0kUDF2itl/pY
         1QylMScXyUlo85Q0CNH7/D4iObE1EEMaDuJq2wQ3Z27q6yb9SgiovzEmMiAp22dZHXsG
         HXZ4iNC5IxkRQlYPaht3fyZlerewDpbRv/hRc5zXMS7HI7Yq9lpeqsvmirjTvWZPYmDX
         UtZADNUJmWfzqgB3BGI92kXWh1ax8xhoB/Is/lHeDAK5r6Mu/Xx9o7pcV11pDFzGRuM5
         LAQQPoV546jMsFSLmlCqs4zUQRdH4V2icdTbwUPrR4OKbR06HiQyYtgoVkLn2S7AYT3w
         8FOA==
X-Gm-Message-State: AOPr4FU6GatiMaO3KXZuNtPSwX4VWOzpSzSw+OxcXy+9ppv2DivrL4SWnZdyZ8YojDVkjw==
X-Received: by 10.194.87.72 with SMTP id v8mr4250324wjz.68.1462972793729;
        Wed, 11 May 2016 06:19:53 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:52 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294272>

To libify the apply functionality the 'max_change' and 'max_len'
variables should not be static and global to the file. Let's move
them into 'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f8c3677..deba14c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -76,6 +76,14 @@ struct apply_state {
 	int unsafe_paths;
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
@@ -148,13 +156,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
 		state->ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
-/*
- * For "diff-stat" like behaviour, we keep track of the biggest change
- * we've seen, and the longest filename. That allows us to do simple
- * scaling.
- */
-static int max_change, max_len;
-
 /*
  * Various "current state", notably line numbers and what
  * file (and how) we're patching right now.. The "is_xxxx"
@@ -2179,7 +2180,7 @@ static const char pluses[] =
 static const char minuses[]=
 "----------------------------------------------------------------------";
 
-static void show_stats(struct patch *patch)
+static void show_stats(struct apply_state *state, struct patch *patch)
 {
 	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
@@ -2190,7 +2191,7 @@ static void show_stats(struct patch *patch)
 	/*
 	 * "scale" the filename
 	 */
-	max = max_len;
+	max = state->max_len;
 	if (max > 50)
 		max = 50;
 
@@ -2213,13 +2214,13 @@ static void show_stats(struct patch *patch)
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
@@ -4045,7 +4046,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 	discard_index(&result);
 }
 
-static void stat_patch_list(struct patch *patch)
+static void stat_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int files, adds, dels;
 
@@ -4053,7 +4054,7 @@ static void stat_patch_list(struct patch *patch)
 		files++;
 		adds += patch->lines_added;
 		dels += patch->lines_deleted;
-		show_stats(patch);
+		show_stats(state, patch);
 	}
 
 	print_stat_summary(stdout, files, adds, dels);
@@ -4151,25 +4152,25 @@ static void summary_patch_list(struct patch *patch)
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
 
@@ -4526,7 +4527,7 @@ static int apply_patch(struct apply_state *state,
 		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
-			patch_stats(patch);
+			patch_stats(state, patch);
 			*listp = patch;
 			listp = &patch->next;
 		}
@@ -4570,7 +4571,7 @@ static int apply_patch(struct apply_state *state,
 		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
-		stat_patch_list(list);
+		stat_patch_list(state, list);
 
 	if (state->numstat)
 		numstat_patch_list(state, list);
-- 
2.8.2.490.g3dabe57
