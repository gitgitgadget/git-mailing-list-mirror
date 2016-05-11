From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 50/94] builtin/apply: move 'newfd' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:17:01 +0200
Message-ID: <20160511131745.2914-51-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6d-0006fJ-Cy
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbcEKNUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33399 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260AbcEKNUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so9412763wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOxkjoUeKHdX1h8jNzqc0JVh0krCUiNxpjUM24cObjk=;
        b=txhrkyUc9QMtHmM7p35PltAPf3rnqeKi7IcBjmbDeIfaC+gmYNghQYXj39z9NwSM3f
         QNL1Dpj+jS76/qI1w4z1tBKLWF4PNFgUmCUxV+U/hdW9h3rcwvwO5DIH86NL9TC/+eZC
         aKEpsptEHLjskmL32HWKkjNCh0bvtRdSq6/BZK767lGVPBKeZvCwPcik12QfV31CEwSr
         dCBNaBr9nemZjKBf7PidRQNI8kw4h5ZEhA9fKJoMlEBEaD2ddzwsCIkkNhubgm4pU2q7
         yIfri1vtzuunJAyWh619ivQ7uqHRjMY3XRFIgOTC2PGZR5w7Xz1pHowSWdNCkea+ctto
         EoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOxkjoUeKHdX1h8jNzqc0JVh0krCUiNxpjUM24cObjk=;
        b=WeOFRqDpOShN/Q7ySS2xQ9AVMxR7HWpjykuk5mTZIGhgD25St2FnViI2gBhukFw9jk
         vZFIyZRqQBZXZNrZ8ZX4ZmtPeeouGrIpl6iQpNWtRUab5qKOHng9NoYxM5cfaRGZHw9V
         D0+WleAMHjKy2TgDLcam0zFlagw/w5PnhhIIRcqFUjLvUit8Y5ahKSAqTgK40qYhpNCm
         Cgz1WRS/JAVBoCOv+kkRXc+ccfGITgmCEkavziZt0hyoLI8FjcUWQZCXyLe9MjyROVPR
         CEhyFBTHmYFSgh/XDpwZZNUwPTOcqjCfjiNRoSkgizir8wVxEhVdDuGZ0QI4yTUCWA+5
         BWzQ==
X-Gm-Message-State: AOPr4FVf4KgebXoU1Eof5uUXnFsToMtOjY9DJNhfMdhVzaq/2Lm5LiNrfnoOypvVuGTtSQ==
X-Received: by 10.194.72.103 with SMTP id c7mr4008855wjv.65.1462972809504;
        Wed, 11 May 2016 06:20:09 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:08 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294320>

To libify the apply functionality the 'newfd' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index cad2c56..ec55768 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,6 +57,7 @@ struct apply_state {
 	 * lock_file structures, it isn't safe to free(lock_file).
 	 */
 	struct lock_file *lock_file;
+	int newfd;
 
 	int apply;
 	int allow_overlap;
@@ -131,8 +132,6 @@ struct apply_state {
 	enum ws_ignore ws_ignore_action;
 };
 
-static int newfd = -1;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -4561,8 +4560,8 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(state->lock_file, 1);
+	if (state->update_index && state->newfd < 0)
+		state->newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4671,6 +4670,7 @@ static void init_apply_state(struct apply_state *state,
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->lock_file = lock_file ? lock_file : xcalloc(1, sizeof(*lock_file));
+	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4780,6 +4780,7 @@ static int apply_all_patches(struct apply_state *state,
 	if (state->update_index) {
 		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
+		state->newfd = -1;
 	}
 
 	return !!errs;
-- 
2.8.2.490.g3dabe57
