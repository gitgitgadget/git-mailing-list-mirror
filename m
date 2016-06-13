From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 24/40] builtin/apply: make write_out_results() return -1 on error
Date: Mon, 13 Jun 2016 18:09:26 +0200
Message-ID: <20160613160942.1806-25-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUS4-00042v-8n
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424964AbcFMQKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35205 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424934AbcFMQKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so16028411wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U9RSTv/yuQeGvAVgJE+tLfEB80N4gkPNobXYUwvjwGU=;
        b=OE2bzB9wGgUU4dPBPboEfEpgGm/ld4y7PNf4voixdf85I8saovWWlBQ9btmyMgEu+W
         xkna3N4OFsEIwpZJ4xrpISVgFefMzAECuJBQZJJPYcURneMF93D2cQhjFSdkUpRpxhkd
         5hmq5e7Uu56wkLHQ3vtGYm5uXfUQhOagLCFWAQ12tWZiNgm+Vke2WSB8r0rQcIsXh1Rz
         HGurLPexOCBQbTlcC9NYSdMiFrUq4g0g7Uf+k6P4/oecmGos9Ku1tUU8wZO+/gXtkp99
         WDfyDcIw9W+0ucayEzovYYCaISUnn/v0dFyPNrGdAmy51zoGe69JT0V5IeLYfWO81XVl
         c1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U9RSTv/yuQeGvAVgJE+tLfEB80N4gkPNobXYUwvjwGU=;
        b=ZezfibXsZErWwnqQAL46tcKwairQdLxyGDZFQk1vMBSXFBw7/cwnkj8tAzYXui4Rb4
         ejdEO+/xKjIDuLOV4H9LDvYDDKe6jrrYNb7QNQ3eZcsZM74wm0NWNPKPj7A2VdpSNDr1
         NpkXJgOD3bqVXZiBKRS6lL8wWs5A+FNs5Z3vPXBFVpZvBfK+O3rJNlMipzivW/LpKuUC
         FV8oJ4tn/heXLjkb478k7mW7ybK2vfsufCQlSi8ZrTqcGj8ES85sPbaZH1fbUpbaAHIa
         W8DWiAhm04SUizPsjOr0pxKs9HIoqqeg6DmT4HZC5loBeaRkPtQM9AP1XLEHYfxjc5S7
         G0OA==
X-Gm-Message-State: ALyK8tKHn4vR5jnNIBrIevO8Qr89jETyMlClLEifAqxR74t6AAYN2VIxJe/Bk/LPC8OASw==
X-Received: by 10.28.21.202 with SMTP id 193mr1852746wmv.92.1465834229386;
        Mon, 13 Jun 2016 09:10:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297209>

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
2.9.0.rc2.411.g3e2ca28
