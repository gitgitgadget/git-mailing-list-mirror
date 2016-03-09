From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 14/48] builtin/apply: move 'update_index' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:42 +0100
Message-ID: <1457545756-20616-15-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHy-0007oT-25
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933706AbcCIRwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:44 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:32837 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699AbcCIRwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:38 -0500
Received: by mail-wm0-f52.google.com with SMTP id l68so203667488wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IVqkqp7PYbO5QPGEKQqkwVOgJ7TOCw4fHWnrALBXxfk=;
        b=HeB+ZleBWgSQGAv0bBmwvpVQifW3nms9I5Q0bbiGmjwXsNbhFxYsbMT7I2uMvDsd3H
         Q7xo90K87k7UWkw9JmiTM1GygDjZL+9PKnw88Is0RI5XoCQTkyAg8DlDeHydLWDzd2cr
         c5jPZeqn/LnRVnSRGmVM06iIWrRuZ40GoTwd6yzNf8jxYdQsG8aaxS/ZRkGty0TTAqBT
         bq8/3HtNiZq7bZ5DwgH2Ak4SDQQQH/CrSdBaj22oxL2eS2yubyRwP8rPRG85s4rTO0Rt
         mw1X082cSIW8QNqRSUuyxGGn9a68GDEQNWJ21L39QAEuuCvkB8UaVMq9fhthRzvvB/r1
         oy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IVqkqp7PYbO5QPGEKQqkwVOgJ7TOCw4fHWnrALBXxfk=;
        b=NCWZqViS96bwzpSgzO/3IGCzpIsAphWaofLnd06Dv1xUowsqT8wfCfXjh8d+3lW0OR
         /S6Hk6YX5GpNrGMiJwbuZ6Yp/meMwUXIbFo1gRF5gQpUSAF7xqgYF1MbBn+Xm0oQJNEq
         n3mlNgLqEZ5laGcP7CSXd/kTmrmCb0BgeK6BhmR8eZBevYoMFGaWzLVDU4Clxtx9Eoc5
         nDsgPjlfGB7uzT3JV4qyh4KI0FOFdEi35h8mfqCMDtfBGwgHumQ46iYdbk8iXvEZ8wbj
         zxhxDLVhdJ+U8CredMaVz+cnWqtx5NLtIr4wYOwoGtQKr8rLWyYwGDL7MLC7L/PHCi3j
         1ZPA==
X-Gm-Message-State: AD7BkJK0vxtrIEyb9eR2nfDOHTA2cMxOk5cPQU3zfzdHSWAQM09y1Duud0Y0ebZwV9M0LA==
X-Received: by 10.194.21.197 with SMTP id x5mr34487260wje.90.1457545957230;
        Wed, 09 Mar 2016 09:52:37 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:36 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288502>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4e0737c..a6026cc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -40,6 +40,8 @@ struct apply_state {
 	int check_index;
 
 	int unidiff_zero;
+
+	int update_index;
 };
 
 /*
@@ -51,7 +53,6 @@ struct apply_state {
 
 static int p_value = 1;
 static int p_value_known;
-static int update_index;
 static int cached;
 static int diffstat;
 static int numstat;
@@ -4099,9 +4100,9 @@ static void patch_stats(struct patch *patch)
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
@@ -4112,14 +4113,18 @@ static void remove_file(struct patch *patch, int rmdir_empty)
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
@@ -4229,13 +4234,14 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
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
@@ -4256,7 +4262,7 @@ static void add_conflicted_stages_file(struct patch *patch)
 	}
 }
 
-static void create_file(struct patch *patch)
+static void create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4268,22 +4274,24 @@ static void create_file(struct patch *patch)
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
@@ -4291,9 +4299,9 @@ static void write_out_one_result(struct patch *patch, int phase)
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
@@ -4380,7 +4388,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(l, phase);
+				write_out_one_result(state, l, phase);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4456,8 +4464,8 @@ static int apply_patch(struct apply_state *state,
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
 
-	update_index = state->check_index && apply;
-	if (update_index && state->newfd < 0)
+	state->update_index = state->check_index && apply;
+	if (state->update_index && state->newfd < 0)
 		state->newfd = hold_locked_index(&lock_file, 1);
 
 	if (state->check_index) {
@@ -4722,7 +4730,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 				whitespace_error);
 	}
 
-	if (update_index) {
+	if (state.update_index) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
-- 
2.8.0.rc1.49.gca61272
