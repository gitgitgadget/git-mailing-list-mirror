From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 16/49] builtin/apply: move 'update_index' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:53 +0200
Message-ID: <20160524081126.16973-17-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:15:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Uw-0001vH-I8
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbcEXIMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33217 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcEXIMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id 67so3639774wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eu1V/m9Ai9bMQ39X1SRNS6FBc84eus0M+vQCz/00luI=;
        b=uN+JFYZ+j4zQHZZwURtARN6wTn7KCUQruKk0fWquicOMAhk0tKikofebGbWtlFQNqd
         WIQPTHXit413QD0JkQeT8hGw3WAdvxPtyppW2EUcgDSRGS2+oAnGaSwwC8SIBmfWPul0
         JaAoarptLWJ/+iQ6fU/79ohBWRBG4gOygmZtM4C9WWbkDR+btnyh06EKMYhXW+u2nqWM
         J4dN3xIbMpUUjF3kswea4xSevUelGsfYWUdy2euRLOxWNHf4MbgQE1jBXWJPCtIZ3Dj7
         0+kXzGbhVZ2Fboao+HYKXwTmc5BBm79DdU/IaphRB5GBGSW0Q+cTprKAbb6qwdFP7lnb
         yrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eu1V/m9Ai9bMQ39X1SRNS6FBc84eus0M+vQCz/00luI=;
        b=MsyJqZ/inMqlvwkmwFv/G7r1TWrX3ljBJfcz42RaYV7YQny4CgEIkp8gouLGICpHX3
         ZlSlZissXpzyw3RnN7Gtmr1IamcHGAVb2M/ugDb1VLxaW/ChlmdPYGF+3l3iae3hlyxG
         0s9q2/8f33dzXvYQA2WyQvByyWX2wr5XOh4qXYgoT8aE7nqgazWLrQLlkuWFveA4hfHB
         YTQtVLPPjzsETNEOKFmzbwfEc+/Nj3dAhS8YDIXOvJrZeKpz/hjLEfAB2wMUR9DBOA8v
         D6x0WrXByqNraF2ho5MVUsTOqBa/QZSV91uDe/C3j2nebnAOdS7xK8Y9C/pcGJe9SVgw
         COuw==
X-Gm-Message-State: ALyK8tISSQF4jbPSq73Iu1Zjk+ie/aolfr4dBI9XSqVt5v6QoTgI3Q+GK7GXnKewW1df2A==
X-Received: by 10.28.170.197 with SMTP id t188mr2360865wme.84.1464077528437;
        Tue, 24 May 2016 01:12:08 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:07 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295464>

To libify the apply functionality the 'update_index' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 07dc89d..7b5abb9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -28,6 +28,7 @@ struct apply_state {
 	/* These control what gets looked at and modified */
 	int check; /* preimage must match working tree, don't actually apply */
 	int check_index; /* preimage must match the indexed version */
+	int update_index; /* check_index && apply */
 
 	/* These boolean parameters control how the apply is done */
 	int apply_in_reverse;
@@ -46,7 +47,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int update_index;
 static int cached;
 static int diffstat;
 static int numstat;
@@ -4090,9 +4090,9 @@ static void patch_stats(struct patch *patch)
 	}
 }
 
-static void remove_file(struct patch *patch, int rmdir_empty)
+static void remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
-	if (update_index) {
+	if (state->update_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
 			die(_("unable to remove %s from index"), patch->old_name);
 	}
@@ -4103,14 +4103,18 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 	}
 }
 
-static void add_index_file(const char *path, unsigned mode, void *buf, unsigned long size)
+static void add_index_file(struct apply_state *state,
+			   const char *path,
+			   unsigned mode,
+			   void *buf,
+			   unsigned long size)
 {
 	struct stat st;
 	struct cache_entry *ce;
 	int namelen = strlen(path);
 	unsigned ce_size = cache_entry_size(namelen);
 
-	if (!update_index)
+	if (!state->update_index)
 		return;
 
 	ce = xcalloc(1, ce_size);
@@ -4220,13 +4224,14 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct patch *patch)
+static void add_conflicted_stages_file(struct apply_state *state,
+				       struct patch *patch)
 {
 	int stage, namelen;
 	unsigned ce_size, mode;
 	struct cache_entry *ce;
 
-	if (!update_index)
+	if (!state->update_index)
 		return;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
@@ -4247,7 +4252,7 @@ static void add_conflicted_stages_file(struct patch *patch)
 	}
 }
 
-static void create_file(struct patch *patch)
+static void create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4259,22 +4264,24 @@ static void create_file(struct patch *patch)
 	create_one_file(path, mode, buf, size);
 
 	if (patch->conflicted_threeway)
-		add_conflicted_stages_file(patch);
+		add_conflicted_stages_file(state, patch);
 	else
-		add_index_file(path, mode, buf, size);
+		add_index_file(state, path, mode, buf, size);
 }
 
 /* phase zero is to remove, phase one is to create */
-static void write_out_one_result(struct patch *patch, int phase)
+static void write_out_one_result(struct apply_state *state,
+				 struct patch *patch,
+				 int phase)
 {
 	if (patch->is_delete > 0) {
 		if (phase == 0)
-			remove_file(patch, 1);
+			remove_file(state, patch, 1);
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
 		if (phase == 1)
-			create_file(patch);
+			create_file(state, patch);
 		return;
 	}
 	/*
@@ -4282,9 +4289,9 @@ static void write_out_one_result(struct patch *patch, int phase)
 	 * thing: remove the old, write the new
 	 */
 	if (phase == 0)
-		remove_file(patch, patch->is_rename);
+		remove_file(state, patch, patch->is_rename);
 	if (phase == 1)
-		create_file(patch);
+		create_file(state, patch);
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
@@ -4371,7 +4378,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(l, phase);
+				write_out_one_result(state, l, phase);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4451,8 +4458,8 @@ static int apply_patch(struct apply_state *state,
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
 
-	update_index = state->check_index && apply;
-	if (update_index && newfd < 0)
+	state->update_index = state->check_index && apply;
+	if (state->update_index && newfd < 0)
 		newfd = hold_locked_index(&lock_file, 1);
 
 	if (state->check_index) {
@@ -4727,7 +4734,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 				whitespace_error);
 	}
 
-	if (update_index) {
+	if (state.update_index) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
-- 
2.8.3.443.gaeee61e
