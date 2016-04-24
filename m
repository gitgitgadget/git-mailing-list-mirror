From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 49/83] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:49 +0200
Message-ID: <1461504863-15946-50-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCn-0008GD-Ng
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbcDXNf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:59 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38513 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbcDXNf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:56 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so89943073wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39/MF8NQS7Ybic4sXuK8d4yXNA2Lr4vsONDmMsdnTvk=;
        b=EYxUz3WeB/vpTy6dG86WFT6ET32a8aWdgwHL+z2x3osK4ymOgH0AOHauKfZVU3a0I2
         OMDG2lim2C+XnJQHLXXRHqinV35XzPMZsKmwyP+I3TKLmf/RLhGLRRvuH4+sIHq3ZKPp
         HhS7BP5pJ4l3sk0fcz32d3b0Esqxi6LmKLHQFn5OGXcGKTcCgDbnxQu7uz0cTzP1X7Sp
         1FDLjVmgfnhB+upCGeTqetQMKs6eGD4/a3Y8YF9h4EwteMt7K5ShM1k5ghFVBKa9ISlg
         yi4irqnEF5SKvBcme/HUgUKQ+BLDtw91mccSegcvs3uCQ3cLhi2KrswapbbT49mbQ0lV
         SHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39/MF8NQS7Ybic4sXuK8d4yXNA2Lr4vsONDmMsdnTvk=;
        b=kPf1JeB+4urDArQVrmm1eF+1OS7XEGF6OSkDKDlai7EuejZtsCdB+ywaMfFzXmbtGM
         jxz8aSgzXTpcPDQseheyTsoVMlEbiNMNQ22PfigGQZykLiiL5Pb+PUn03quUkQgeNZ6+
         gQ4rPtSh0gNYN0cxo1AG34a9ceDOo26QMRH+unQ+pqgcFpPp3tLDNJneYwCQSxpurtDN
         ksjXM2GqruRV0GnmP5z/3dOxnHYurTx9ikkwdAbQk8I8imX7N5WkijiwStU3bGieyE63
         YXzfeDSM/Ws+TOajtG0XMsOvW6rovBo8NJ+TEKpMvrlUObEWOCrp8wMlY2uBR/pxNGE2
         +lcg==
X-Gm-Message-State: AOPr4FW9bVU6Zcn8ax9NysX8GJ5XrGcnmDBE7R/vWrpbMDsZjDCGvc14+XOnJSOiq5BLXQ==
X-Received: by 10.28.57.214 with SMTP id g205mr7281774wma.24.1461504954837;
        Sun, 24 Apr 2016 06:35:54 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:54 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292347>

We cannot have a 'struct lock_file' allocated on the stack, as lockfile.c
keeps a linked list of all created lock_file structures.
So let's make the 'lock_file' variable a pointer to a 'struct lock_file'
and let's alloc the struct when needed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6c0b153..d26419a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,12 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/*
+	 * Since lockfile.c keeps a linked list of all created
+	 * lock_file structures, it isn't safe to free(lock_file).
+	 */
+	struct lock_file *lock_file;
+
 	int apply;
 	int allow_overlap;
 	int apply_in_reverse;
@@ -4515,8 +4521,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 	return errs;
 }
 
-static struct lock_file lock_file;
-
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
@@ -4568,8 +4572,10 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(&lock_file, 1);
+	if (state->update_index && newfd < 0) {
+		state->lock_file = xcalloc(1, sizeof(struct lock_file));
+		newfd = hold_locked_index(state->lock_file, 1);
+	}
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4782,7 +4788,7 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
 
-- 
2.8.1.300.g5fed0c0
