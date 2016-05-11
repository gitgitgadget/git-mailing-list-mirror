From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 61/94] builtin/apply: make check_apply_state() return -1 instead of die()ing
Date: Wed, 11 May 2016 15:17:12 +0200
Message-ID: <20160511131745.2914-62-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:22:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U66-00069s-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbcEKNUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33636 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbcEKNUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so9414812wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjKjW701bw58we4p5CaZGTv+1WPJpFXSTNpzIOEt1q8=;
        b=B+P3mvqxNpChKXUY4EZpNc/MVHvDHaX7gSMq0tMs3l4900tCvA8fNiJ8gFBmfSky14
         NawO7QYXImILss2aWBHEPTO48mC8DQdxol/Z24Rr75u3Kl8BCgb/0qbZWWGR2l9SthoV
         1mEGIE9wSCFvUCASJqAZDWy4r5XSkowt8GufL7yZVJMokXVeoUpC18vZQHcFOsl42meo
         Sx4IosAHwJvRXy+psuZy1qDNjs6EsjTD+Rx4PPklI8LLvnCxRzRADyN+UKUl3VdXfcmM
         OocvmKLC0VEc3llXviqhfUEqQyfQ9FjuVk5rdAMzfv3AHg67eNDyjGHV8KA6TPf+pG9j
         tFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zjKjW701bw58we4p5CaZGTv+1WPJpFXSTNpzIOEt1q8=;
        b=V0erqYihjExP9+O/FNEG2pcCFlCpvS6hal1CF6sMoCxdRchhcsZYtm2gZcM07TdKdO
         Y5DlwQ/zwdo9lwryPyHmSlEjwCkdeaIIKrBq7p1Tu4bx0KtEWAiRrKNNWJJJytxcnRi2
         4NRKsd7rDq1bTeeUSxkkYSW0bSzEuopsec9W752RbZR7nE4Qi82saCuevPtOkEgjvuFb
         Jo0uJ7wqtRSav7DwzT5P8ZsXh4oGgh0xNccuHTTea70CCKIP607mMqWx8GC0VB1aAPew
         U6mgHlwXosTRp6qiT2/pGZ9cLr8L5f/z1R42VoNuTOZjUZ1PXPqRepqIoJJwe+1cq5lU
         4RCQ==
X-Gm-Message-State: AOPr4FUu8zMmV3ai2s47O+3aSACPp/onMbLIR6QCuL42Scyd4BXA/I7fKo3Kl8JYM/ZKDQ==
X-Received: by 10.28.168.76 with SMTP id r73mr75737wme.44.1462972832964;
        Wed, 11 May 2016 06:20:32 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294315>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", check_apply_state() should return -1 using
error() instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b31f9eb..2b3d10b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4540,17 +4540,17 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void check_apply_state(struct apply_state *state, int force_apply)
+static int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		return error("--reject and --3way cannot be used together.");
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		return error("--cached and --3way cannot be used together.");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
+			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject)
@@ -4558,14 +4558,15 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
+		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
+			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
+	return 0;
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4730,7 +4731,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	check_apply_state(&state, force_apply);
+	if (check_apply_state(&state, force_apply))
+		exit(1);
 
 	return apply_all_patches(&state, argc, argv, options);
 }
-- 
2.8.2.490.g3dabe57
