From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 23/44] builtin/apply: make write_out_one_result() return -1 on error
Date: Fri, 10 Jun 2016 22:10:57 +0200
Message-ID: <20160610201118.13813-24-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmz-0003PH-MN
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbcFJUMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33468 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296AbcFJUMN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so1069264wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZD+i9jse/91xthX9mURDvsOq9FEURs8ALqfXrzztz38=;
        b=Oy8Xo2ewiKDrl5vyZZhSOMuquv9BxJOXAb+noFF1H2oAYpYRPJQD+ex64afrFqYdUC
         7DEE0MS75+ymnz3BC7s0FiF149+oppOqU/6crmeE1wl4qja6kJo+hOMAOcPcDqljegqu
         m7F/cZB79MRL/i8z/SvLFp6+PlaosYRsSfipIt2koPMn3r4xcI2KQphUT1+6VA6tF15x
         eUH0fGFwy9+nPu82pavaG1l7+ZkdTYYxqkcYkhjuCJfWWVV1eLzEVY7imH+higpkcGwl
         DX0Vs1FlAGqXzRwfWJvsOyharjTGjOI0SOHEXb0/5fDrP2aK819bWxsfq+kpUneYBluL
         W7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZD+i9jse/91xthX9mURDvsOq9FEURs8ALqfXrzztz38=;
        b=JqJxcE5uyWnHVEpjODBS64mwIWiKXpeD6tQn/9rRg7IJEje8Gp0hjhAif//K6apJhh
         1lA40O2NYUcZSROVVkfA/j6A7/rr+pMS0uL+1hqtmPCMG4y6fu0s00+U08bdVFKB1AoD
         3fzqX4yXw33FmpQjWHpei+vWKRX1w+Iso8nbewyxcfvhev9djdxVgpGxXkE/bFz9cuEh
         6dx4NY6XYKCDGgmWih9s1GBg1M+X1E8XwHCjIiNxWWQmGQDpkfs/eyDFcPVGoUKX3CLo
         F8rE3XpRedwJo49rd03B6Ahk43IZWYkMqjt3kNZKkuzBC8/KewVOUwmPgEKaPIBeG49J
         yNJA==
X-Gm-Message-State: ALyK8tJT7/+Z8P92cxy10Ka7YRFOY8+47iqth6vqdMbe7c336jLE7oQbNE5AMWUhv/Bh4A==
X-Received: by 10.194.83.103 with SMTP id p7mr3745285wjy.110.1465589531855;
        Fri, 10 Jun 2016 13:12:11 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:10 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297032>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", write_out_one_result() should just return what
remove_file() and create_file() are returning instead of calling
exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 76d473c..291e24e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4276,36 +4276,29 @@ static int create_file(struct apply_state *state, struct patch *patch)
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
@@ -4392,7 +4385,8 @@ static int write_out_results(struct apply_state *state, struct patch *list)
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
2.9.0.rc2.362.g3cd93d0
