From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 62/94] builtin/apply: move check_apply_state() to apply.c
Date: Wed, 11 May 2016 15:17:13 +0200
Message-ID: <20160511131745.2914-63-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:20:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4D-00040Q-G2
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbcEKNUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36534 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbcEKNUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9352887wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h9gdAK7CBxZjmxG1ZOH4aNf12+JV196ttiqAt3gXjPE=;
        b=JtVCnTaMW+2wY+9drc6LK8+mqBVlgXSTNSP0oEFTk2qY+Zl68v1T0SIJq7CiuUGxrD
         eSdpzrvWLqL2iQOgI9OsE2IjHt+wmCJjemXV/adSP0SJCGBTQL12erFoZB3dmX6mPRKh
         kYDDmfMGmHQm2/dVw23To2Jv+2xtDaLR+2rw6e8jNkzOxCtfxF1Zl7RnlOuvLYUloQ24
         ME554j74gxa/719Hfii63erT3wWTS0U3gg42kL+CkC+IrpUukxxSNKuzOXN9O/J+s7xR
         fr87tP2dR0tL/4/f+nSN4IUYGbtKgVohb0NNpbYyREFQHTm8E8q73iTWN7TkHBiNc3oY
         5yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h9gdAK7CBxZjmxG1ZOH4aNf12+JV196ttiqAt3gXjPE=;
        b=e3oqugquAFTg/cleHwvg6FmLvv3iSofz8Zk4nduWpuLDnpTHEaYvA7UehWBu9cEX0Y
         oSNzcDGv1lkbN5W/TECZPAO8hHDWpFKGwvCWu5JMUX/cJ60wQxuGRRUk9AwL5IP7+tFL
         yLTgD9zp3OzgFeaw1sGcogrtOnBWjRN1e7WVBsuzKupqzK1ofpYOQQxkOLd2OFAt7anR
         PNS0xtBYn/mMTm2uSS3KZ4OIXHlBQTvDdIkCevCoXsyjvpQWTIHOgKyViVzHE7sVQYzQ
         KJDPjtUVH362mL16PzfrXdbsbG+ux8a4LFEpBFSsBZZAHMdAzG1q9aJvw5rlHQIo5ycd
         ogDA==
X-Gm-Message-State: AOPr4FWQ5RFjvpy/9pPc6btJDLcB8TKQV0CHjwiwb7VMzJpfxtI7bRT8ldeebhWWD/xfpA==
X-Received: by 10.194.6.164 with SMTP id c4mr4240191wja.133.1462972834837;
        Wed, 11 May 2016 06:20:34 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:34 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294283>

To libify `git apply` functionality we must make check_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 29 +++++++++++++++++++++++++++++
 apply.h         |  1 +
 builtin/apply.c | 29 -----------------------------
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/apply.c b/apply.c
index 1e2b802..2128594 100644
--- a/apply.c
+++ b/apply.c
@@ -82,3 +82,32 @@ int init_apply_state(struct apply_state *state,
 	return 0;
 }
 
+int check_apply_state(struct apply_state *state, int force_apply)
+{
+	int is_not_gitdir = !startup_info->have_repository;
+
+	if (state->apply_with_reject && state->threeway)
+		return error("--reject and --3way cannot be used together.");
+	if (state->cached && state->threeway)
+		return error("--cached and --3way cannot be used together.");
+	if (state->threeway) {
+		if (is_not_gitdir)
+			return error(_("--3way outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->apply_with_reject)
+		state->apply = state->apply_verbosely = 1;
+	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
+		state->apply = 0;
+	if (state->check_index && is_not_gitdir)
+		return error(_("--index outside a repository"));
+	if (state->cached) {
+		if (is_not_gitdir)
+			return error(_("--cached outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->check_index)
+		state->unsafe_paths = 0;
+	return 0;
+}
+
diff --git a/apply.h b/apply.h
index f3b2ae4..5266612 100644
--- a/apply.h
+++ b/apply.h
@@ -120,5 +120,6 @@ extern int parse_ignorewhitespace_option(struct apply_state *state,
 extern int init_apply_state(struct apply_state *state,
 			    const char *prefix,
 			    struct lock_file *lock_file);
+extern int check_apply_state(struct apply_state *state, int force_apply);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 2b3d10b..ae16f99 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4540,35 +4540,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static int check_apply_state(struct apply_state *state, int force_apply)
-{
-	int is_not_gitdir = !startup_info->have_repository;
-
-	if (state->apply_with_reject && state->threeway)
-		return error("--reject and --3way cannot be used together.");
-	if (state->cached && state->threeway)
-		return error("--cached and --3way cannot be used together.");
-	if (state->threeway) {
-		if (is_not_gitdir)
-			return error(_("--3way outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
-	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
-		state->apply = 0;
-	if (state->check_index && is_not_gitdir)
-		return error(_("--index outside a repository"));
-	if (state->cached) {
-		if (is_not_gitdir)
-			return error(_("--cached outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->check_index)
-		state->unsafe_paths = 0;
-	return 0;
-}
-
 static int apply_all_patches(struct apply_state *state,
 			     int argc,
 			     const char **argv,
-- 
2.8.2.490.g3dabe57
