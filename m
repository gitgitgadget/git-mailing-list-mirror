From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 24/44] builtin/apply: make write_out_results() return -1 on error
Date: Fri, 10 Jun 2016 22:10:58 +0200
Message-ID: <20160610201118.13813-25-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnP-0003kw-7X
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbcFJUMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34345 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932498AbcFJUMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so1056141wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bh2i65AuwqndVW1rG+L421gM3Gb2Sb93fXpRtqpuW/Y=;
        b=OhEfWOil4BmWvEA5dnBAVwpuQwy5vouFa2xtLSJNym19OEsx03XB+xVnzn87msDydW
         48Bi4tkwErXtWmWD5Hc/NeKF+/4NoWo6OK+ilTO8lK/D/pxwg9ERLvRkXYHeXq0XRlja
         bmxlTf67x6g//f4SeZX0sojVDZ4Tto+FpZELJxgYo0l1tWO7x89UYK6ZWJVwZAeegPHB
         KRI/7UX8bmQBHsshmb3k4mCoh1CVJGIDK4hnAF7WCxx0eCQmj6dNJ0+2WYDEbEKnT3uZ
         w0VunVCXbNaacW8tfyLHO7zHA50hobidbNWhyXFAZ7ZvIuyKOhjCP6uJrm3JXX+nx66B
         sT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bh2i65AuwqndVW1rG+L421gM3Gb2Sb93fXpRtqpuW/Y=;
        b=DhkCJwcQINkLvsXU4hc2RrQhKtG2fZMGoH0lrZt1UjIUiQYAaraCskQazaZiLfVHPV
         d7VEybmWexP/NyzFlcGwoQFOHvtVSuccx9Is0h3iVaMwECR4w3PPHsw9cCPc27e3ynT+
         KcTTGmthpnTwzjHAKPI7NjLK4e69ut0w3rN0CmE9awN+pClF7lrANknjLKdF9UB9ATGi
         WZ30wLJAT7GKPAAJViSQ6yXGNiaFdJ6CcpCF59nXzd+ehAfVLPcZYYOKNDBOucQxjqE3
         +483XUqzf3+6xwQmkodAY0JcHI3xJDUPrTsux/9QQ2RmmSMcNgYHemcmDEp63rm44YBE
         WP7Q==
X-Gm-Message-State: ALyK8tLBoWj4ZVPD5T7JtIBVLylDNE4ih2EqmkXtGYWuyNSgmxdwRww25zL5hoNkOxIVfg==
X-Received: by 10.28.21.202 with SMTP id 193mr609921wmv.92.1465589533122;
        Fri, 10 Jun 2016 13:12:13 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:12 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297041>

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
index 291e24e..f35c901 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4372,6 +4372,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
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
@@ -4385,8 +4391,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
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
@@ -4498,10 +4506,17 @@ static int apply_patch(struct apply_state *state,
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
2.9.0.rc2.362.g3cd93d0
