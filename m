From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 72/83] builtin/apply: make write_out_one_result() return -1 on error
Date: Sun, 24 Apr 2016 15:34:12 +0200
Message-ID: <1461504863-15946-73-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDI-00006x-Jw
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbcDXNge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:34 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36978 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbcDXNg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:27 -0400
Received: by mail-wm0-f52.google.com with SMTP id n3so90229350wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jg1kkebIc2UA+Z7KR/uEuZZ2E8lCX3AyvCvti2PDc/4=;
        b=tWsmrQeKlv4jOhtk+9AlKfrj5z8NvINC8gHlKUQaWxxevdAWOcprM8retqmAtxw3Z7
         1ZHDMGo62LPkljnCW2c+A9C8ShEY+QkDkIGFrVutMQVwC2j5vTs6GCbiH0t7fkAwxfz+
         MGehuPRc++Ufpo2+wE9iX3J5z3e5thPQhGooINgaaJB3/PYSHeBBkJnpje0DZrvoqWzF
         p1PxCiMibXi9SqgEVCzIi94KuNjxXtcLmpKSS+VDRs7rBPqMj+JUQ8cnBFVjK0aGTXR0
         g9DIcQwXO36r2glTL8V12LIzqieiFiczMKmNZe2Pv4ztSj+Vtmo/Y6nJfwBCy0bPPNfT
         MfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jg1kkebIc2UA+Z7KR/uEuZZ2E8lCX3AyvCvti2PDc/4=;
        b=idfrfsemv+32OLcx3zGLx+92IgX1WC9Zk/FdgAfMLBhkuuOUalvcjL2HZzljyQyFPj
         Lh7pAiLU/WtU78BhjpdZXtJ2HwczbA48iULTjFWeJ86Oez0GC+E8AikHxzzxcP3GtkfB
         5Ed6+sWLPpTDq6kkxAmtxMX8azYI8gBMveFfbScpi0rYiX2gwsUNAsx2QCgMF4rVeUqr
         eE1G+3PtNGLyfOZxfg8zP8eaeseGgaU9RxvOAnM0d826kdBvx+l/zG5kBwwttXBis/g2
         NyUg5s42Ct5AonkUQql5T6IAm47QF1BQT0coTBHcUwO5RZ471UCTRJswDmXScKiXTu7y
         WKkA==
X-Gm-Message-State: AOPr4FVuhKXuTbiAV5fLvMXatEStZcTGj9+r/YxFbXNaxER612Mx2cssLk/ze7mBFPPUsg==
X-Received: by 10.194.125.201 with SMTP id ms9mr29388874wjb.71.1461504986454;
        Sun, 24 Apr 2016 06:36:26 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:25 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292360>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ebac9ee..dae89e2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4271,36 +4271,29 @@ static int create_file(struct apply_state *state, struct patch *patch)
 }
 
 /* phase zero is to remove, phase one is to create */
-static void write_out_one_result(struct apply_state *state,
-				 struct patch *patch,
-				 int phase)
+static int write_out_one_result(struct apply_state *state,
+				struct patch *patch,
+				int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0) {
-			if (remove_file(state, patch, 1))
-				exit(1);
-		}
-		return;
+		if (phase == 0)
+			return remove_file(state, patch, 1);
+		return 0;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1) {
-			if (create_file(state, patch))
-				exit(1);
-		}
-		return;
+		if (phase == 1)
+			return create_file(state, patch);
+		return 0;
 	}
 	/*
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0) {
-		if (remove_file(state, patch, patch->is_rename))
-			exit(1);
-	}
-	if (phase == 1) {
-		if (create_file(state, patch))
-			exit(1);
-	}
+	if (phase == 0)
+		return remove_file(state, patch, patch->is_rename);
+	if (phase == 1)
+		return create_file(state, patch);
+	return 0;
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
@@ -4387,7 +4380,8 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				write_out_one_result(state, l, phase);
+				if (write_out_one_result(state, l, phase))
+					exit(1);
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
-- 
2.8.1.300.g5fed0c0
