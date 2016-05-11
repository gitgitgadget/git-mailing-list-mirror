From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 21/94] builtin/apply: move 'summary' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:32 +0200
Message-ID: <20160511131745.2914-22-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:24:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U7n-0008Ae-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbcEKNTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36612 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbcEKNTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9345023wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7IsddwS2RnMb+76b7Beq2szpL/oyQF231Y4c9v29AWg=;
        b=T4x84fKjwj7ACYrOE3u3dAkSrTeaDk6O/7dsj/ggVIMzUy27kTNV/HBE5ZCVcet55H
         6d9m3w4zzSJSM8J8M9KAXNC3tTCDLvCygzk7KPSXSqopLXMSska1rWyqbrxBdXjQtVT1
         DdFIPTHnqeqsCi7/ZnwyAt43kcyLgq/g7/RqT5xzlbqq4iBFPuP+Un5jDMKZxIQQRaIC
         FqappbhzN4PSd0UmaBPUYLNMhY60EnIZZTQawT4Ii+af4kbT+ZxenEOhPu8i3w3+F5Xm
         VsfoGJV8gQeBsM1XR2OoF5zOZZgNEbrsetURJhn81r348z4ANwNNspdSIaxyrHBndYP4
         GLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7IsddwS2RnMb+76b7Beq2szpL/oyQF231Y4c9v29AWg=;
        b=E9NcwZsLRbJYoit3BRYQX5PIJyNqDbuVrmzh/AxC6n4YWhMXxBsFN86VnkUKCtMzzY
         YsYvtsXMVN+cNWgYGory4AybTNzPLInufkKa3xkx9buagF443oEF479UyMgg3OJ3supb
         xbnF6pOkqJQkKOWrKB+6E31tNqL4PFq+paYfVgzXDRbMI/+JvLp40+nun/2wAxp1ceuh
         QtG/TYjLwsDkZpBgDJDuhVh/IHwkhREZfd5SDGakQHeC2im4sFHGv3uO1nX0L/5X7/BE
         ctA+Iu4NuO1AGPMhuHq6Crjnp6yoKMzDm0BXVyOrjJm9XZviWTTweTTptKgH5zmbqtY/
         n/rg==
X-Gm-Message-State: AOPr4FV3uphJQFIVSvcHNHb0TZn82tfTGoNE7g+AIiQpxzMYJ0fn65fuSxgPrpSSbNzyzw==
X-Received: by 10.28.31.73 with SMTP id f70mr4546363wmf.77.1462972748632;
        Wed, 11 May 2016 06:19:08 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:07 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294331>

To libify the apply functionality the 'summary' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 887c5d0..6216723 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -39,6 +39,8 @@ struct apply_state {
 	/* --numstat does numeric diffstat, and doesn't actually apply */
 	int numstat;
 
+	int summary;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -59,7 +61,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int summary;
 static int apply = 1;
 static int no_add;
 static int threeway;
@@ -4501,7 +4502,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->numstat)
 		numstat_patch_list(list);
 
-	if (summary)
+	if (state->summary)
 		summary_patch_list(list);
 
 	free_patch_list(list);
@@ -4612,7 +4613,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
-		OPT_BOOL(0, "summary", &summary,
+		OPT_BOOL(0, "summary", &state.summary,
 			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
@@ -4679,7 +4680,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.2.490.g3dabe57
