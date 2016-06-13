From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 23/40] builtin/apply: make write_out_one_result() return -1 on error
Date: Mon, 13 Jun 2016 18:09:25 +0200
Message-ID: <20160613160942.1806-24-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURk-0003mr-7i
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424945AbcFMQKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33508 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424931AbcFMQK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so16044139wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lDcNiUg7K9dSsZHEL13omJw1W8rJ4uZceD1VkgsgJxc=;
        b=O9XtFXvxY030GIky4MYhpxerhN4kBu94rsbuEvMeQErPXilV5rZPPuLbB9UUV8EgHE
         bhJM9I70mSe53U4rY/aITR3Ur+lqFl1uZfcp6EyEjtvwTFcWroej7a6lGkQ8fFQ4a8Oa
         jUU0DK2nKPr3Rc1hcgD2P32v/dOd2bb139l/nYQdkwNqiVgrO+ov75cKQZwG/B3BW5Mh
         rzSY7plmeqnXcCW6rgrn/uPMjrS9CetpMNnnEnbaDbVBPmlvrvcNv3WqduNFcEb+ZgQQ
         MlCGby3NJhKuuzZID17yeUgKtF5bkIsSrzC+bZmsBmjY9l7B5vC4O/1uUixy89xgfEI8
         eHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lDcNiUg7K9dSsZHEL13omJw1W8rJ4uZceD1VkgsgJxc=;
        b=Xpv7mJLBg+fFDudhzSx4PH0A3GqGCsf5YNOMTlEapDoym4yE15pK8pxqkuXXdTuM3b
         N/4GjKNT8A6k1ABDemkk4bjOsmpf/Lsx2Ip3x4/MhsaLoFMs6T+0w3b81jKPhLSo4FYc
         kgE9E55ISbn57G3qChic1KhDXku3Z1LfqGbYmdfJP9Lnqx9QuZGPcSs5FR9k4S/336j4
         TUNTW9nLt2HKvRsH2xcPIsUsJ+H7PafM6Zw/QArgfhaNKGodmJMXclQONKvSOKDXrtiC
         m08IV/jkBWgHeYidXCvug98UKi+NJ5re0tlfoJljF9Tuc6D/DN7M4a7uMjsCARvLXRLe
         NtbQ==
X-Gm-Message-State: ALyK8tLvUvQvn2Phf5vHg2+hLrZMCewm4vxljKgwL1dt6b8rBX7I+lFl9SL+aMuizv5vzw==
X-Received: by 10.28.157.199 with SMTP id g190mr2053057wme.2.1465834228052;
        Mon, 13 Jun 2016 09:10:28 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:27 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297202>

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
2.9.0.rc2.411.g3e2ca28
