From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 74/94] builtin/apply: make write_out_results() return -1 on error
Date: Wed, 11 May 2016 15:17:25 +0200
Message-ID: <20160511131745.2914-75-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:21:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4d-0004Lj-JY
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbcEKNVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33886 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbcEKNVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so9422344wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LEa17Ks/U1XSoc1Joz5Los0X4ClTMUfEXI50qlKm22c=;
        b=t1gK9RXx1gNuXdO5lsqbFD0rn/R8pUg3fqISK/lFaswUDmFPNkWNKy50p4iAJOUVcn
         v+3bRJKNJDIkjItjyrkG+oBJoa98IEGxSUdM/wOBEAjQ9R26Cow1COFsCv0XLtQ19hr7
         msK9VGI088xcwUkec0bNDBNLG8Zx/abwVJEwhLwMBIWm0Yp4or0B0NqviUeDT+FQBgLP
         ZHO/PeGeypJiTrIrvkG1NliI+Fa74zHmfv3fTg9ZmEn/hDrtMpV3bAlcPNwyBonRTOI2
         4SxcSbX3RW7AmrlE1omY4NCZ7FfIpwe2iI2mxFLi45pIj3F+U0Z2/teS8w2OKZG1v7LA
         UrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LEa17Ks/U1XSoc1Joz5Los0X4ClTMUfEXI50qlKm22c=;
        b=Fu1kxgd2FZWZ2k6GLzR2O90YpXRZ2+bRcMcIKKYnj/A+Q60xjpH+FqRt7qFyXn4t6r
         mWgenOnYtheIP0MoFX8+s5D62Skuvi2Rm46kPXPusBAMKct3TkALOtunC1BatfWwFSKf
         BM0qRJpaxsGpTRX1q0gV2aAqiVznILN3aVZ4HuGg+mL1Twy5G5aF7lQoMp+KLKHmPxkD
         kkEeU6NpPETg67CiWR/RLoTn7yPlUH1UKlPyw7gUypZ3prPzfGOV+11u3eeOv8Z7hmIS
         FMYbtQgYmdc8w8xY7rc4HF3z+BZaMIe3fCAadQNCQ8B+E1NxcL7WFpbLAEpJZeqJq+1G
         yYtA==
X-Gm-Message-State: AOPr4FXy1aR6j49aC34Ax34uzQlEwNoey8JKUEK27y8DoZT0o+7st+dYwq3YoOOMlhrWbQ==
X-Received: by 10.28.90.65 with SMTP id o62mr98816wmb.16.1462972859043;
        Wed, 11 May 2016 06:20:59 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:58 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294296>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", write_out_results() should return -1 instead of
calling exit().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f06bf16..97bc704 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4373,6 +4373,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 	return -1;
 }
 
+/*
+ * Returns:
+ *  -1 if an error happened
+ *   0 if the patch applied cleanly
+ *   1 if the patch did not apply cleanly
+ */
 static int write_out_results(struct apply_state *state, struct patch *list)
 {
 	int phase;
@@ -4386,8 +4392,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 			if (l->rejected)
 				errs = 1;
 			else {
-				if (write_out_one_result(state, l, phase))
-					exit(1);
+				if (write_out_one_result(state, l, phase)) {
+					string_list_clear(&cpath, 0);
+					return -1;
+				}
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4497,10 +4505,17 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->apply && write_out_results(state, list)) {
-		/* with --3way, we still need to write the index out */
-		res = state->apply_with_reject ? -1 : 1;
-		goto end;
+	if (state->apply) {
+		int write_res = write_out_results(state, list);
+		if (write_res < 0) {
+			res = -1;
+			goto end;
+		}
+		if (write_res > 0) {
+			/* with --3way, we still need to write the index out */
+			res = state->apply_with_reject ? -1 : 1;
+			goto end;
+		}
 	}
 
 	if (state->fake_ancestor &&
-- 
2.8.2.490.g3dabe57
