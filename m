From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 73/83] builtin/apply: make write_out_results() return -1 on error
Date: Sun, 24 Apr 2016 15:34:13 +0200
Message-ID: <1461504863-15946-74-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDT-0000Cp-JQ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbcDXNgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:31 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35215 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbcDXNg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:29 -0400
Received: by mail-wm0-f51.google.com with SMTP id e201so60547764wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cl5CK1osO+od6FeOVLHZ08ybX4YiFXgfBiHNEOZYxpk=;
        b=GBQ8d2AHLzhS3rQcVuShyKmhjaS403wfNhxok4FSL8iTCYKFJOcxDGlyli0KbCqKnH
         NPmu7eI+9h/D9xL9qweJ2aBQ73/Pr9TaoygsG3jlGaHUVG6r2PLcSGUeCl6gk0OWv61i
         6PF605us9DhandZLAfn46gOf8THEF4HE+i9gOZ5UhAsuJOGq35QcQfMmz4fErCnryzrG
         wV8DRh6mCubqXl+rkt+eeEW47X+dsEyMl6w1J7aHccGTpEwRpHhlJA97uHcMmHZXjI8t
         UcmFBI3PqwcGHMpo7x85uPN1zFaKb6CqZYhr45+MNJR5ZWBxW4675b+csLp4Pa6Mnf2u
         /7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cl5CK1osO+od6FeOVLHZ08ybX4YiFXgfBiHNEOZYxpk=;
        b=BrbIrvUwNUWTBRb7x//SrY95i9XIhqxYLNHEsyW/fzQFZCm8b2yzR9g28WjkaC7xXa
         SUBXS5WZFAwU4N9Iw4XaBmKAyRDYTyhkbg19fB3dzlz7ETHZPy/sBgxk7SfIXu1OIWaG
         wR/I1YuqwRWAzTSOqKmTfpp7y5Nq6TTrEfl2H5xn9cr5dqxzeGUzPNFvEDfqliAXoO9U
         R+cO7DK8chbE1Il4GJtOpupmd+cBXSBmjk3sPpDdy+8DwIxJXavpeTQy4KHfphjTLA03
         6ToNng+pn5CFAQh67W+iyIuUvtwZXUZeea62K8OUvoxUdq4hidK0esaTSfvIDkV7AJDq
         Q2qg==
X-Gm-Message-State: AOPr4FUp/mMgfgv1vtrQbQBHWCGvi8B5is+xobUngg/r2MCrOLxUsq8d/vrdFclIij6yuQ==
X-Received: by 10.194.170.5 with SMTP id ai5mr29697532wjc.75.1461504988003;
        Sun, 24 Apr 2016 06:36:28 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:27 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292362>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dae89e2..49ef4c9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4367,6 +4367,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
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
@@ -4381,7 +4387,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 				errs = 1;
 			else {
 				if (write_out_one_result(state, l, phase))
-					exit(1);
+					return -1;
 				if (phase == 1) {
 					if (write_out_one_reject(state, l))
 						errs = 1;
@@ -4484,11 +4490,16 @@ static int apply_patch(struct apply_state *state,
 	    !state->apply_with_reject)
 		return -1;
 
-	if (state->apply && write_out_results(state, list)) {
-		if (state->apply_with_reject)
+	if (state->apply) {
+		int res = write_out_results(state, list);
+		if (res < 0)
 			return -1;
-		/* with --3way, we still need to write the index out */
-		return 1;
+		if (res > 0) {
+			if (state->apply_with_reject)
+				return -1;
+			/* with --3way, we still need to write the index out */
+			return 1;
+		}
 	}
 
 	if (state->fake_ancestor &&
-- 
2.8.1.300.g5fed0c0
