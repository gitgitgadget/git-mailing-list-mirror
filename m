From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 14/83] builtin/apply: move 'update_index' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:14 +0200
Message-ID: <1461504863-15946-15-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFQ-0001Ek-VN
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbcDXNit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:49 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37532 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbcDXNfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id n3so90199279wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XbFGWL5mYa635XtrwYiHEWPiwY5mM75uczXUqKTCxmE=;
        b=WOSZZHi+pZzK/0T0YSupAEf+0EN0zthohCyGwG8loNdmQxhoVZ/Dde2WH7Bkvr2kjm
         KthGWiOMTUtDDAR0BmxGbeabnVDektVZ2+cA94uw5TeyE2uvtbFqIKO5oh2BtT/vYv6F
         /ZURhkWYJt+CyV0YoO4XNLSzf4idwOw0d9K31+faExbZiz7y1IrYmz/enI6x6NOUIj7f
         NuptOgK/9AhrKntNlSLXnjsNmQUnOk8A+i9G93B9rF1tlMlm0N3bAP59/+xV3CAqbB65
         Jyf3x5oITrcWisgJznxoIi3/2YwQVI/dsjCPf2DFM87i0WhQrKGYbfxbHc5+i6RdLzvG
         UshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XbFGWL5mYa635XtrwYiHEWPiwY5mM75uczXUqKTCxmE=;
        b=aAg7iNm6WAyi3lFAVf+aTP31WIt5ww1PgRfka3RJ0+kgoPdsWthIVcLnw1/KyU+Sst
         O0X5Xh4VrU4l3pKyVsnbifeLOw6EUtU9Bo2zha6JzFZ9qtJRZEF76Xw1B9l8r+XcHnDa
         ZF6cldDadkNvLyE3aF90DBgR3bhat1gQvEkxS6N67V65lmFPnWZk/Z3wiFYH0bHaojJY
         9dHqU0/us16DASKTlhNu6xfOSWjf04ykh9fPPhjcdEUSDARxxzC4lWoYhz7wey2n9xDY
         Yr6WzLkQnhFL1QvdbUh/XCspDUKql7GyjYRb4t3ibLULv675gpf44Xpc0N5MzCsRpVur
         AvyA==
X-Gm-Message-State: AOPr4FV1fciwjF+t8C+hOOeYcNUvEDdMywTBQaQ/dsHj5BfDZP4Nv6T5jw4Jv075d9aPcg==
X-Received: by 10.194.117.70 with SMTP id kc6mr32777131wjb.94.1461504904924;
        Sun, 24 Apr 2016 06:35:04 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:03 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292391>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 154679e..b57be2c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -39,6 +39,8 @@ struct apply_state {
 	int check_index;
 
 	int unidiff_zero;
+
+	int update_index;
 };
 
 /*
@@ -51,7 +53,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int update_index;
 static int cached;
 static int diffstat;
 static int numstat;
@@ -4097,9 +4098,9 @@ static void patch_stats(struct patch *patch)
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
@@ -4110,14 +4111,18 @@ static void remove_file(struct patch *patch, int rmdir_empty)
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
@@ -4227,13 +4232,14 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
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
@@ -4254,7 +4260,7 @@ static void add_conflicted_stages_file(struct patch *patch)
 	}
 }
 
-static void create_file(struct patch *patch)
+static void create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4266,22 +4272,24 @@ static void create_file(struct patch *patch)
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
@@ -4289,9 +4297,9 @@ static void write_out_one_result(struct patch *patch, int phase)
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
@@ -4378,7 +4386,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(l, phase);
+				write_out_one_result(state, l, phase);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4458,8 +4466,8 @@ static int apply_patch(struct apply_state *state,
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
 
-	update_index = state->check_index && apply;
-	if (update_index && newfd < 0)
+	state->update_index = state->check_index && apply;
+	if (state->update_index && newfd < 0)
 		newfd = hold_locked_index(&lock_file, 1);
 
 	if (state->check_index) {
@@ -4723,7 +4731,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 				whitespace_error);
 	}
 
-	if (update_index) {
+	if (state.update_index) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
-- 
2.8.1.300.g5fed0c0
