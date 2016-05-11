From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 20/94] builtin/apply: move 'numstat' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:31 +0200
Message-ID: <20160511131745.2914-21-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:25:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U8Z-0000ii-H2
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbcEKNZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:25:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36588 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbcEKNTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9344785wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G4Pir9r2mz061UnOk6/uSoBv8GPPhEYUqWH6Cq8Vfyo=;
        b=PM/Z8VlMgZ4pS12n8nViJmGtATQ/7YagDZqKnIPw3rTFgYz3CB7CkAIIordykEdvYr
         G3dEkJoL0wZv74hjKjW3K0V/vyC4SWZJS7yrQEbEyK/sBSf/jo7OWIYPIEyKPdHibU3S
         LeV1o2gQxjfbaGstTlq89yZ9oLGYadh3EeibrZgR9Zmg9ePPZF6mOEPh9BvY84dSVMIm
         bb//4sY8YGgBGqCCavUXChTI9YQuYb/2Bp1OAq1bUGPMk4XNdMOLq2AV0j0AVobtK/HG
         otqDIaPnsqNX/GQXVx6CbCjJeMvLy9EHPEzcvU8GnVxX8YY/pDVHVaYLmHYhADiyc6Ix
         NMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G4Pir9r2mz061UnOk6/uSoBv8GPPhEYUqWH6Cq8Vfyo=;
        b=QX1XKUnVsRxf3MYtsCWrnB6+1DysbsKlaS/7/1ZqsInE3NkQTpPutTbdPu+bRwGOT9
         R0vF9TRav4d6wR51Og8Cyqmbd3r4FFGXqL8LRer/GTPAuKqZEJOBBd6q0amdHJrBMd9T
         HJtAX35Urq3JoCdtsGhn146hY5DIF6Zh9ha3jKwm3TxLOOja4/Hpzw6FOs1Ks538T3/J
         qPSrCP0jYMVUSKY//ck5pCEt/RrSm68p6KhS4tS8BW7qRDpA2iMwWF2ErGFW7/5Gk5+a
         MyucBVnY2ndPiqfxnjiv5T+zLsqBtvSv/iU+GWCc7SuUQs6TKG+PLpsqe8I0oYAs0/Lk
         1lpQ==
X-Gm-Message-State: AOPr4FUr/wHp3CDW+yJ94eH2ECuninf2jhHOwNeLbcGlppk3a9IQpV3pHsRvJt4ufBi6JA==
X-Received: by 10.194.77.140 with SMTP id s12mr3817459wjw.24.1462972746590;
        Wed, 11 May 2016 06:19:06 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294336>

To libify the apply functionality the 'numstat' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 43c7198..887c5d0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -36,6 +36,9 @@ struct apply_state {
 	/* --stat does just a diffstat, and doesn't actually apply */
 	int diffstat;
 
+	/* --numstat does numeric diffstat, and doesn't actually apply */
+	int numstat;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -50,14 +53,12 @@ struct apply_state {
 };
 
 /*
- *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int numstat;
 static int summary;
 static int apply = 1;
 static int no_add;
@@ -4497,7 +4498,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->diffstat)
 		stat_patch_list(list);
 
-	if (numstat)
+	if (state->numstat)
 		numstat_patch_list(list);
 
 	if (summary)
@@ -4609,7 +4610,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
-		OPT_BOOL(0, "numstat", &numstat,
+		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
@@ -4678,7 +4679,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.2.490.g3dabe57
