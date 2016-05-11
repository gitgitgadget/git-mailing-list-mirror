From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 26/94] builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:37 +0200
Message-ID: <20160511131745.2914-27-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U7K-0007af-AC
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbcEKNT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36726 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbcEKNTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so9346007wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7Yn0ApKU7N2M1pBIOU8zAX3SMM7sibNdFxaDTDH3ww=;
        b=gy6FhU77seygTtn3/4AaR2YHvgrLDglW9Q08QKpVoNd86mI70bpGTd7KVh+//e/PC9
         i6cSRMkQbT5MTHgFL76by/tF152PLRgMRdcsOZhiZ7m3mR8tJgY07FKa2Qt4MYKBmTuy
         0FLa6V2H/CYDay33u6H/X/Fc1c+MgL63SBz/RcO+p952lZevzn2kru9q66/42gOheFlx
         7visNxo3hf2fxgOzgfxm97uCv7Yd6lJ79oAbZqmV5KTtc8l/44QaNam3qrQIasT1HUnk
         XPKnBx6yPWJvjg77b4YalMA9HMrMG3c1a6HVlYY3DI7CYZFzhfXUUKXyw/sin+NQwPcc
         66hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7Yn0ApKU7N2M1pBIOU8zAX3SMM7sibNdFxaDTDH3ww=;
        b=h+nCijpVdgSSy6yt/xwDsrsRPQc2tDGg18Y30yWaLYxS4ciNvjrz5492K5EGuW7vEH
         /6nocXsEA/bbReBDT9R1bVvtqJPc8y7U/7P0Mbjnbn7egunbPuzUjz7sgiPWus8fBDNb
         i+ml/Cf7sYQkDYiAAkP45IOUaRrXPDi/kuBD3i76v8E6RcLKRXTvzBl1Vwxq5VDx4RcK
         MHlI20Yo4VtgBuzZmryrbIw41kP1K3oEbVOCILO35fhiVJnce1FCgQKGEqzxm0zRYevQ
         hIvXbSmH01M+nPGw7eIM3HnnSjuYBs7rPauIxbE+TuVxYzatFsUGlOiojRCTOnIw086h
         WaNA==
X-Gm-Message-State: AOPr4FU7TFHplLuLvafJyb7sqq/3tpHKmFdXQTXHpHelOsg8HHXP1x5aDYd1eLFXPZTBEw==
X-Received: by 10.28.236.88 with SMTP id k85mr27851wmh.53.1462972758845;
        Wed, 11 May 2016 06:19:18 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:17 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294327>

To libify the apply functionality the 'fake_ancestor' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

By the way remove a comment about '--index-info' that was renamed
'--build-fake-ancestor' in commit 26b28007689d27a921ea90e5a29fc8eb74b0d297
(apply: get rid of --index-info in favor of --build-fake-ancestor,
Sep 17 2007).

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d699d1e..6f9a090 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -42,6 +42,7 @@ struct apply_state {
 	int summary;
 	int threeway;
 	int no_add;
+	const char *fake_ancestor;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -58,15 +59,11 @@ struct apply_state {
 	int line_termination;
 };
 
-/*
- *  --index-info shows the old and new index info for paths if available.
- */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static const char *fake_ancestor;
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
@@ -4494,8 +4491,8 @@ static int apply_patch(struct apply_state *state,
 		return 1;
 	}
 
-	if (fake_ancestor)
-		build_fake_ancestor(list, fake_ancestor);
+	if (state->fake_ancestor)
+		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
 		stat_patch_list(list);
@@ -4629,7 +4626,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
-		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
+		OPT_FILENAME(0, "build-fake-ancestor", &state.fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
@@ -4682,7 +4679,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || state.fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.2.490.g3dabe57
