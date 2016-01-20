From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 03/11] update-index: add --test-untracked-cache
Date: Wed, 20 Jan 2016 10:59:36 +0100
Message-ID: <1453283984-8979-4-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpek-0007tL-Cm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209AbcATKGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:19 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33787 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933445AbcATKGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:09 -0500
Received: by mail-wm0-f48.google.com with SMTP id 123so125778440wmz.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFWVktUZ/o9uz8yc24K5/DIdLhykoZCN04BoapJ/tTQ=;
        b=CoCbvGyFYN2P6x2CL7xa4jifnSSA/xBGS7nddTYV24/Pb0WBjQFcQOQVzWT1YT4K+K
         OtskPGuDS8DaAywdYmMV3H35QvGcUonDbXvo9cSC1CxSshFBIqKkTq1bZ3+ET3X5EYYC
         khfDf0zBBkALl0MFVKiQfoBCWDPLBZIS0OnxDTCW4qUXkfWyPNo7gsyrQplcgx7+Xj7s
         TArg2b0lx3XUXDKSsP+BogjMBUslKVKf/+ogd+sF8Vw/EZpbVjSBfRo40iVOSNd3ERzU
         igmsWIUR6uhi07vp14dH5EAlmOjLQU668k8mAjgG/PRwkw6wB6Ij/aU40x4zaMLPuKO2
         +3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFWVktUZ/o9uz8yc24K5/DIdLhykoZCN04BoapJ/tTQ=;
        b=PmLk19/NLxHkWYdQROZeyCrEpL+VailFCt7cK5yCXYwT36QieZOFEZbJPF9a7sNGbF
         9jD4oq3awywtKGymvkyivIFPUENawIIPZ9PKt+XvhAiGHzbAALwRohfSacL+01nKb1Pg
         0LpBhS7EsQyiwUJwM8KtcN30OP2aR5o4q/W6MOEd7xrtL9zL32O9xgb6KiDAZE2044ie
         S2mouak4mLXMhUzMuwxDfV/mbL/a9J5oxj6WTPr5lxmBFf/0A8EWDghS1RgNMuznh0UD
         Xm8LvpiKsgqa4LMGbqCopUNuI9bwYmEoD9I6oy6CzNCNDLxq5nK4WJ9JGOlQTkArlfUE
         BPTw==
X-Gm-Message-State: ALoCoQlVDhEDZLzcIKRk1kGBOJn1Kt8jQ0nnEzihOrUJ8JruuSO/JP3rTF3cYxOnLMGrAc+UFo789A6nVAjB3Phj7ixJeOSOAA==
X-Received: by 10.194.75.202 with SMTP id e10mr40086163wjw.160.1453284367700;
        Wed, 20 Jan 2016 02:06:07 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:06 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284438>

It is nice to just be able to test if untracked cache is
supported without enabling it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-update-index.txt | 12 +++++++++++-
 builtin/update-index.c             |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index f4e5a85..a0afe17 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	     [--[no-]skip-worktree]
 	     [--ignore-submodules]
 	     [--[no-]split-index]
-	     [--[no-|force-]untracked-cache]
+	     [--[no-|test-|force-]untracked-cache]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
@@ -180,6 +180,16 @@ may not support it yet.
 	system must change `st_mtime` field of a directory if files
 	are added or deleted in that directory.
 
+--test-untracked-cache::
+	Only perform tests on the working directory to make sure
+	untracked cache can be used. You have to manually enable
+	untracked cache using `--force-untracked-cache` (or
+	`--untracked-cache` but this will run the tests again)
+	afterwards if you really want to use it. If a test fails
+	the exit code is 1 and a message explains what is not
+	working as needed, otherwise the exit code is 0 and OK is
+	printed.
+
 --force-untracked-cache::
 	For safety, `--untracked-cache` performs tests on the working
 	directory to make sure untracked cache can be used. These
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1e546a3..62222dd 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -40,6 +40,7 @@ enum uc_mode {
 	UC_UNSPECIFIED = -1,
 	UC_DISABLE = 0,
 	UC_ENABLE,
+	UC_TEST,
 	UC_FORCE
 };
 
@@ -1004,6 +1005,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("enable or disable split index")),
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
+		OPT_SET_INT(0, "test-untracked-cache", &untracked_cache,
+			    N_("test if the filesystem supports untracked cache"), UC_TEST),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_END()
@@ -1119,6 +1122,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
+			if (untracked_cache == UC_TEST)
+				return 0;
 		}
 		if (!the_index.untracked) {
 			uc = xcalloc(1, sizeof(*uc));
-- 
2.7.0.36.g6be5eef
