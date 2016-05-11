From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 11/94] builtin/apply: move 'check' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:22 +0200
Message-ID: <20160511131745.2914-12-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:25:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U8h-0000pW-23
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbcEKNTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35218 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEKNSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9400469wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YIq1Xk8OAi0IawiFDroirmJfBGpi9n0s1meHwaFU3lc=;
        b=VrKODMpK8Si4Cjas9Yje7NFJ89JaNqQl/Leew3V4RqJwQTZSeWNgfMMtSFVLMcOJT6
         AAKiQPNj5Ed4L4PxLgp7hBsIwh5OajPrBmkUuTD73SX8C9VUlINC7Xt8zGtp7MH+i5h4
         r4FxqkOtrEajJcinwgIMErHNPKSJHinGQx8LDFak3/zucVpld9m5F/49m77IUJOug5Mf
         g4/81TzkZQgPol3bznu1i0s+aiHMw81jUeqF4BI+2i7fF/uIaOQi+0sLlQmzXkEnyp8e
         i1Z3DZMOBIjxrn4phKXM/UL/CV7tMA0sl9hOWkP8QkhPIsGERgQGnWlNzencIcq1Mw5w
         Y39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YIq1Xk8OAi0IawiFDroirmJfBGpi9n0s1meHwaFU3lc=;
        b=GSEKB5s1QEmnQIeO6fM/7q0OzBFokutr8WdeHz+uDwOvcNed5m5lQQL1DYV0ImAtVJ
         0SpFUuQTFQO06lpxoK00osuC5+OhBGzOQcaDiYfvoUoWUVWOpqRopD1ax4KU4VoQ4PAR
         7YSNX5aiXmu7MRh1r2drGnpqKVk8PEKimJyHtKeYBIFUZiad7nvidDrl3SvIisIAcY0u
         grrx/OzBIcoVQ8cIns0NS/5X43hg6wkcLoKpSVUyzZjCv+DTeJddbBlLgMMTUI82fX9z
         0CudfC9CULr8XT6RVFjQFm4mo6Usb7Dl58E4NjnBhSg/UTmRr3Xwk77mnEtoN3z+pTUs
         xzhA==
X-Gm-Message-State: AOPr4FXfU5aFkrKyG2avK03t1wc3RmufN+MVQb97jmmSUagdGbUtUwMhDersoHD22kzCFw==
X-Received: by 10.194.17.106 with SMTP id n10mr3727375wjd.131.1462972728294;
        Wed, 11 May 2016 06:18:48 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:47 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294335>

To libify the apply functionality the 'check' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 44ae95d..6bf103a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,12 +25,15 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/*
+	 *  --check turns on checking that the working tree matches the
+	 *    files that are being modified, but doesn't apply the patch
+	 */
+	int check;
 	int unidiff_zero;
 };
 
 /*
- *  --check turns on checking that the working tree matches the
- *    files that are being modified, but doesn't apply the patch
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
@@ -47,7 +50,6 @@ static int cached;
 static int diffstat;
 static int numstat;
 static int summary;
-static int check;
 static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
@@ -2052,7 +2054,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || check) &&
+		if ((apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), state_linenr);
 	}
@@ -4439,7 +4441,7 @@ static int apply_patch(struct apply_state *state,
 			die(_("unable to read index file"));
 	}
 
-	if ((check || apply) &&
+	if ((state->check || apply) &&
 	    check_patch_list(state, list) < 0 &&
 	    !apply_with_reject)
 		exit(1);
@@ -4573,7 +4575,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
-		OPT_BOOL(0, "check", &check,
+		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
@@ -4638,7 +4640,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || check || fake_ancestor))
+	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.2.490.g3dabe57
