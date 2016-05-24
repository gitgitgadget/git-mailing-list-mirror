From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 21/49] builtin/apply: move 'summary' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:58 +0200
Message-ID: <20160524081126.16973-22-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57VN-00024m-FN
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbcEXIPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34624 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283AbcEXIMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so3659128wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OECOly3Pf9EUngUyELBCFvQQmhLR8ogvxLc/QUOO10=;
        b=tsA/2zNOIkh5sv5QdHOEXIZ2DGXdXvua7euN/gUzIWchAy8uroFQlRCQzjy+DSyCO7
         /sfJa+ELYFi5bxOLefyqW78h5s9oXM8/eGAtamSYIYmM/l3tEDLf3eGYyy5Dc2sIvOtg
         5BHD2Qf9AjDAyetjoqubGppPpVSLUzQDscMQhIrpeWDzT6iAqy2R3hd4NKBH5VsZPm/e
         Gls7kbZQAM2eY1ic24H7s/QApM31lnjiet0p6KRNCFpuirhietIj1isfANThXJxo70DF
         n6M3abV2CNjLqFUgK4D4thOyHk71SyWbQh+CwFUEZSenDx3mkCm1L2DSDBDhn2r3OxsX
         hUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OECOly3Pf9EUngUyELBCFvQQmhLR8ogvxLc/QUOO10=;
        b=ZqndIQDgxSai7JxzPK0m+OEF0c0D1QD5PDpcDaEnFNw+XUMi72hrBUl0Y4Zpsvv7AU
         uULBRbZWzr28nV1lDZLEQIShhL5bBiE/IlQSWazZj9Pw/dnrDk8sGXrDh9xq5Urbxnc7
         D1x9uuRnbKOVk1F6TN3CE5I6Mk2bN/WGrdLVIVuUBqCvtsMcKDkbrnV2q/i83aVRs9rB
         1In9+3vjuATDS7gU85qUy+dz5G3B0+JjmY4YMJq8FTvdnbGFeVnwZPpP5jlu1DgbJN1U
         oOe4recztIb96EFEo/wcjd3g3OGowPv+iSeRlGe6d9K4rc2AGrch7K5zGMz4EAqB+foc
         IgUQ==
X-Gm-Message-State: ALyK8tK8XQ07DyRf3NIIzYZCG9fBaAXzlQdQQcK0ArOHQ0nyiQgpvS9QzDOZbsmisa56SA==
X-Received: by 10.194.62.99 with SMTP id x3mr2856066wjr.128.1464077534960;
        Tue, 24 May 2016 01:12:14 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:14 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295467>

To libify the apply functionality the 'summary' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 47a45a7..f174a42 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -34,6 +34,7 @@ struct apply_state {
 	/* These control cosmetic aspect of the output */
 	int diffstat; /* just show a diffstat, and don't actually apply */
 	int numstat; /* just show a numeric diffstat, and don't actually apply */
+	int summary; /* just report creation, deletion, etc, and don't actually apply */
 
 	/* These boolean parameters control how the apply is done */
 	int allow_overlap;
@@ -50,7 +51,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int summary;
 static int apply = 1;
 static int no_add;
 static int threeway;
@@ -4492,7 +4492,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->numstat)
 		numstat_patch_list(list);
 
-	if (summary)
+	if (state->summary)
 		summary_patch_list(list);
 
 	free_patch_list(list);
@@ -4608,7 +4608,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
-		OPT_BOOL(0, "summary", &summary,
+		OPT_BOOL(0, "summary", &state.summary,
 			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
@@ -4675,7 +4675,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.3.443.gaeee61e
