From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 73/94] builtin/apply: make write_out_one_result() return -1 on error
Date: Wed, 11 May 2016 15:17:24 +0200
Message-ID: <20160511131745.2914-74-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:22:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5q-0005jz-5d
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbcEKNWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:22:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33866 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbcEKNU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so9422223wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3pbKzPl7dclx4fXQ2s3awI5DOnRTmBv8psbJb6ulkGo=;
        b=pfRXf0AbWlwKT7j9PLZwiMCGcVRFff4Kcgx5pM8L5Xl9dtlWbuJKb9wbLty9YZBTQT
         40KljzErte0lUY3mC0Ik39o0bzG0Ue9pQJQ4uaSq0wn25u3bkk9FOAgWvDlogyHRSuHN
         wSGQUOGOAvvePhGyH3wmpcD4NIjdvTWNLzeNBKuArev1m5ex1+xemlyfmNMox+DGsMZ4
         cCn1y1FHsYZw/IwEaVDxhbLoHA6e4Mz741QmJrru8hL5lOmYieVLRcyIXjCkjXeHY0P/
         Wlc6dlHhskV868bEGnXap+hRQ79X8TJFW3b4N0plfATOcECK78gLArm9jtBiSylxAd0T
         gYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3pbKzPl7dclx4fXQ2s3awI5DOnRTmBv8psbJb6ulkGo=;
        b=aGqCRDoO9iEFQL6qBuZ2/vIdRfUvAOcLKHF9RzyuAIEaVzhGqv9h3Dld3XFZmh+xhh
         uutXfMCw5lbLu3QtoumwQPRlQAZJO0BqBkYN/rqfixWa3w6iVSf6OdkXok3ZDVREzJsj
         kUuiDORymFxRSL7Ukm+GWHqRTuVc6kmzOLSnB0hT80hFt/zMne+Oj/aERg6yL01SXFBL
         0GXzWMAf3ohUedJd1EcbhA1G1hAZadYy+A0nWlBPAISWipQ56wNbaMPWsf++yqtMWSKN
         Dbvvj+2EUVARPSL96EEgISRy/Oz4TpfusV17Fza4X702naZgZR6apCKwjtC9o8PPAHGI
         VOXQ==
X-Gm-Message-State: AOPr4FXwh67ZhMjV1shBgnzRH8Ks3IbGZa90MIpiXMRioB2/uBS31EkGl3cxgY/SoAhPUw==
X-Received: by 10.28.172.132 with SMTP id v126mr4451608wme.28.1462972856927;
        Wed, 11 May 2016 06:20:56 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:55 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294313>

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
index 2b562db..f06bf16 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4277,36 +4277,29 @@ static int create_file(struct apply_state *state, struct patch *patch)
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
@@ -4393,7 +4386,8 @@ static int write_out_results(struct apply_state *state, struct patch *list)
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
2.8.2.490.g3dabe57
