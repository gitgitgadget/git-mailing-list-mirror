From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 42/49] builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:19 +0200
Message-ID: <20160524081126.16973-43-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:13:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Sn-00018M-IM
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbcEXIM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34955 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699AbcEXIMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id f75so3658513wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qhJXzjW7/5ItVUxlSJptU24FgbNa8I3rmM7c8cgQHIk=;
        b=1EXsh5MX2IN8HRJUf6xyAODCeCk5fdEQrJgjAri0bVZBNKHMCEePMePEcNI0BEraXQ
         YYIIPwx0Yw8JWM1riYhyrIGvy19fxx4BiGyePZJ7HrHueruGZteiTr9k0RJetaOpnfhc
         KDNNQPDhXQshCbIydsu95ood6NYYRGz6vJsElwIuYBU7Ayvej+JWU6gOH0i1BIbR+Oy/
         mjg7GJkodiTZaVptqT3DoN7o//v7EGpfbJV6vYH2lcYf1a1kUAN2edc0CnRFTRycrxk8
         NqbESAKenLlrhsaxAo3CJCDJyiZxVmOUVbOQBmOPGFYwo0xzvhicRLrsJW+zC1RibNPJ
         TmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qhJXzjW7/5ItVUxlSJptU24FgbNa8I3rmM7c8cgQHIk=;
        b=FCiDaqNYbYWtDzQ11zMEsBzrEt/bewuOl6+t37W1gy3nx1sb5mNmE/QgMlOntogCsn
         4nvLtSv/XrBg0Z8bmucokB9hU3ZLvykM3mw69hXJJjQCE/eqJrUxsGEK3H8WwvDlucnF
         LcLMlkRauDkiig0//G+A0UWzot4UzbFGq9Xc6R+uVJ924Wn4+s8nuekLbapQeMJQ8j/S
         8TBv/jFXIo5RohZ4VeXCGtaB8SKzWYJepbVB6xrLx7zuoLtCLMAj6mpx9jEL9AKtlleo
         Cy625nCgdcaXCHRm/7lHyDebJREP/G3JpQSrUdcbtiE7taMAhJHd9xi+A2aybh9fGfE7
         8rKg==
X-Gm-Message-State: ALyK8tK3C1bF3exFJdegHrwn1DIDT9Wfw64vUnq7jICPsu9CT0XmFrtLF5mztMK5eX/pdA==
X-Received: by 10.194.0.138 with SMTP id 10mr2775655wje.73.1464077564097;
        Tue, 24 May 2016 01:12:44 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:43 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295446>

To libify the apply functionality the 'max_change' and 'max_len'
variables should not be static and global to the file. Let's move
them into 'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e5bc9cc..9e7d181 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -73,6 +73,14 @@ struct apply_state {
 	struct string_list limit_by_name;
 	int has_include;
 
+	/*
+	 * For "diff-stat" like behaviour, we keep track of the biggest change
+	 * we've seen, and the longest filename. That allows us to do simple
+	 * scaling.
+	 */
+	int max_change;
+	int max_len;
+
 	/* These control whitespace errors */
 	enum ws_error_action ws_error_action;
 	enum ws_ignore ws_ignore_action;
@@ -141,13 +149,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
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
@@ -2172,7 +2173,7 @@ static const char pluses[] =
 static const char minuses[]=
 "----------------------------------------------------------------------";
 
-static void show_stats(struct patch *patch)
+static void show_stats(struct apply_state *state, struct patch *patch)
 {
 	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
@@ -2183,7 +2184,7 @@ static void show_stats(struct patch *patch)
 	/*
 	 * "scale" the filename
 	 */
-	max = max_len;
+	max = state->max_len;
 	if (max > 50)
 		max = 50;
 
@@ -2206,13 +2207,13 @@ static void show_stats(struct patch *patch)
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
@@ -4038,7 +4039,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 	discard_index(&result);
 }
 
-static void stat_patch_list(struct patch *patch)
+static void stat_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int files, adds, dels;
 
@@ -4046,7 +4047,7 @@ static void stat_patch_list(struct patch *patch)
 		files++;
 		adds += patch->lines_added;
 		dels += patch->lines_deleted;
-		show_stats(patch);
+		show_stats(state, patch);
 	}
 
 	print_stat_summary(stdout, files, adds, dels);
@@ -4144,25 +4145,25 @@ static void summary_patch_list(struct patch *patch)
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
 
@@ -4519,7 +4520,7 @@ static int apply_patch(struct apply_state *state,
 		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
-			patch_stats(patch);
+			patch_stats(state, patch);
 			*listp = patch;
 			listp = &patch->next;
 		}
@@ -4563,7 +4564,7 @@ static int apply_patch(struct apply_state *state,
 		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
-		stat_patch_list(list);
+		stat_patch_list(state, list);
 
 	if (state->numstat)
 		numstat_patch_list(state, list);
-- 
2.8.3.443.gaeee61e
