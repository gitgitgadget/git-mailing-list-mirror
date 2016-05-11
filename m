From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 16/94] builtin/apply: move 'update_index' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:27 +0200
Message-ID: <20160511131745.2914-17-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:26:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U9F-0001Vi-TT
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbcEKNZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:25:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35423 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcEKNTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9401740wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tzXwU1D06dBGewO4rI88re6bWlh76QB+FXrQuHlLZC0=;
        b=Wsf/BGTnuC331c7nWLtNh/QkXE/H/+3Q+1Misf2cOV2WywFJj1hhujKdALMAkW61iY
         ckV1UpxAmSCoVPJGhF0El/6sagHOYxOn77LqNBdgi1u8JUqR2KMldGC3cQWmU02uaiVX
         hhBDIxxwGZAlb+jXKTXkCcYTjkluUYTN0QNCMGsB/uCGIuHtaCTA5Cl1SbuOVOBmqMbc
         daT8hN7shbI1VITVnESx7Q6IjugcwgATfi83AQmOdnIgww/BP8aZ8lIucTHaV4Cc+YRG
         UoGGIKU16/a1Gvb+IbduzAaU+QUJTfgnrNBoKjB9iGOR4UaduIgRotbzhG2uYcVfa7A9
         ic6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tzXwU1D06dBGewO4rI88re6bWlh76QB+FXrQuHlLZC0=;
        b=Xtkl6FJLAi50o4W+ZQvqsvRIoYOdUWH8IZg8CZFCcoxF7k5EKkiNX8HOedZAWIUS/y
         7RafTeJjt0JoDrG2IZQCg0siRTtd50o5/zguJQikdcEEvKS6rDHiHC2jCrfoRZfUVS7W
         kENGK11Fzlci4P5RBPdUAUv2EOqYcnE0wiL09kjeE4biJWbTonqBM9LMppM5s6Wx74s3
         HBuGI+S22jPUtoL8GeAhoA6jB4h3C2WBoszyPxX8Mpwvs8vpqzVSU5A2PQIFqjdOO6FP
         P8Z96S/rh7f75H8qp7d1YEdIUDG8uzWFU0WvYh0n5zKtaLUJShqaO2PP3jYh2CXDhWLD
         GgJA==
X-Gm-Message-State: AOPr4FWcg6tQXWrh8Tcd1Hsq5QATUixVBe1CtThFFQo4ZPYB85XzIG8lwL7zmwN3NutBxg==
X-Received: by 10.28.39.196 with SMTP id n187mr4313487wmn.4.1462972738723;
        Wed, 11 May 2016 06:18:58 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:57 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294338>

To libify the apply functionality the 'update_index' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 97af6ea..635a9ff 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -39,6 +39,7 @@ struct apply_state {
 	int check_index;
 
 	int unidiff_zero;
+	int update_index;
 };
 
 /*
@@ -51,7 +52,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int update_index;
 static int cached;
 static int diffstat;
 static int numstat;
@@ -4095,9 +4095,9 @@ static void patch_stats(struct patch *patch)
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
@@ -4108,14 +4108,18 @@ static void remove_file(struct patch *patch, int rmdir_empty)
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
@@ -4225,13 +4229,14 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
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
@@ -4252,7 +4257,7 @@ static void add_conflicted_stages_file(struct patch *patch)
 	}
 }
 
-static void create_file(struct patch *patch)
+static void create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4264,22 +4269,24 @@ static void create_file(struct patch *patch)
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
@@ -4287,9 +4294,9 @@ static void write_out_one_result(struct patch *patch, int phase)
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
@@ -4376,7 +4383,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(l, phase);
+				write_out_one_result(state, l, phase);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4456,8 +4463,8 @@ static int apply_patch(struct apply_state *state,
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
 
-	update_index = state->check_index && apply;
-	if (update_index && newfd < 0)
+	state->update_index = state->check_index && apply;
+	if (state->update_index && newfd < 0)
 		newfd = hold_locked_index(&lock_file, 1);
 
 	if (state->check_index) {
@@ -4727,7 +4734,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 				whitespace_error);
 	}
 
-	if (update_index) {
+	if (state.update_index) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
-- 
2.8.2.490.g3dabe57
