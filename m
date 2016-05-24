From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 26/49] builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:03 +0200
Message-ID: <20160524081126.16973-27-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:14:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Tf-0001Ux-BF
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbcEXIM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33418 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbcEXIMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so3641396wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B5xaMFZYqojSz/sPDsahrBrIY6KdFeQZoNeBjJN9qrQ=;
        b=xx5XVbDIZW2WbdGxUzRZZ+MMYDI/1iZUMbw0R0UMeafOd7Z19JkLV3t8GSYe9aM899
         9gK6dlHTbAo9RJSIgS4shfWmbYWHVuGlbTjj8yg4terLdqPjX/unIj1u/8DrFyNC5gR8
         syzfN3rteTnn2GJhoysoWUFmRyRvqD5Ok8bDUWfw1dHc47xAxZ/oeYT5sMiQPtCf6+Im
         DfSVil1em4WCobHifdPPGfPMZIAOk5TWLB9nyqOv1z0rF/frU2yxiINehG/jmL7X+pW/
         GLwtXVhJART3ehIpr7YexNPG6KVJ3EyoGhdaU4NACh4h9wpDQbTfq0XielfzHVKjmDpf
         aDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B5xaMFZYqojSz/sPDsahrBrIY6KdFeQZoNeBjJN9qrQ=;
        b=P1V/I6O1/+2rFauBSz3wBNlahPl7VVCIh1ArRYhUGtMxBtRmHwbQjuRoFgqGbxWW5a
         2wwcXFshGasIyhkKpcPyQsD/GC9dXt2iNT1YVjFMLcacYL3ygxoBVW6zgYzJX60BA8ZX
         L0BhczeKrVLmRNiacKUmprtMH3rdwDDXtIVMiTj4Wo/NgikdHOuIoJ9E8tHQztdxRFQt
         r9VahiRIyN5MsYplIgAMiNtn/g3/huGGJbp7b0+nkwLVhVfM1186VPK+29w6aYbLXTHq
         H0jlDvoLPLEAwUCYo+d8eWUBLPiLEoOoIzaNzz794uKxACj9zljBWqcFjSMS2aPhYJ9f
         75Uw==
X-Gm-Message-State: ALyK8tJ4doVnogrvNKLZ0qg7czCq2OMcWFNHsCg5uTo11EWB6eW8Sx8ecmZzFBGCd8ll6A==
X-Received: by 10.194.169.37 with SMTP id ab5mr2798503wjc.141.1464077541504;
        Tue, 24 May 2016 01:12:21 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:20 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295453>

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
index 95cd60a..59b0f1b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -47,18 +47,15 @@ struct apply_state {
 	int unsafe_paths;
 
 	/* Other non boolean parameters */
+	const char *fake_ancestor;
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
@@ -4486,8 +4483,8 @@ static int apply_patch(struct apply_state *state,
 		return 1;
 	}
 
-	if (fake_ancestor)
-		build_fake_ancestor(list, fake_ancestor);
+	if (state->fake_ancestor)
+		build_fake_ancestor(list, state->fake_ancestor);
 
 	if (state->diffstat)
 		stat_patch_list(list);
@@ -4626,7 +4623,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
-		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
+		OPT_FILENAME(0, "build-fake-ancestor", &state.fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
@@ -4679,7 +4676,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || state.fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.3.443.gaeee61e
