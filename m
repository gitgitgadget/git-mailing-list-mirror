From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 03/11] update-index: add --test-untracked-cache
Date: Wed, 27 Jan 2016 07:57:59 +0100
Message-ID: <1453877887-11586-4-git-send-email-chriscool@tuxfamily.org>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:04:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOK9C-0002ie-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbcA0HEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:05 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33246 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcA0HDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:46 -0500
Received: by mail-wm0-f41.google.com with SMTP id 123so137507668wmz.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ju+80e3RFwrxn1dZg6E6wunwZibSnWL5r5AAg9MJUXY=;
        b=KcVmDZPFQ4WI6trRxrJB8dLUcX2Xa4uuVX/FcONUD0ax5qwxNF43hceG0yYzBKm3pd
         Q7in+UeSJ69beH1koP86uymi4ZUTuOT61gxki5vWCsv3lnY6eK/jsDPTsSnbA9KDdHp3
         PtoeBNAXVD3K8g2XNwICfvD/+yv8kP1qw/qvKuw6cd3lSYyLQcRk4rcNSZfyEl048PG0
         k4ajYubOad+ecO+EQpjW5mD2wmSiU0xugq3sEBVjXpkEZt+PsSjSN854hGLzFvCdktqu
         ziAqvHUM32qGh43yreBaFaLWHXAZ2x8Rv6pstxYdnk+HzZkb8g19G+Kxumnj66flQBmH
         jJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ju+80e3RFwrxn1dZg6E6wunwZibSnWL5r5AAg9MJUXY=;
        b=deD8azVvH6ImhoutyIya7ZqcSTPko4fz+fHtkdBdGwYMIUF9CtntpyyNUcTFLK+XIg
         gNYzejZ5E/EATTjBS2sx+lJ1w0+fEBJDBTs+n1GB7a5XsX+wo9YxKZCPtpDloJFjNtHE
         fKRRniCuwq8u622cYYgRs2eJewAz8kw0d0rMOA5xTUCmfh42oLaGia8Tb2yJcf2sh/Xu
         k+VuwEajt04yBvmLNAEMPFwuFMrvBZNhHSPPgu8PvvYioNIDdzAcwyLCPT4hAUiCazDi
         jM49qX+Z6lPy6XbEi8esSH+V77M9+TAf4P6C9+UYdFdvfnqY+YstPqpnWTv2/gB/DoZ+
         tUQw==
X-Gm-Message-State: AG10YOQ+hCit72iAfK0nuIhdbPVRBDWRfAg/fLG5OJwjJS7AOuEcSnwyVyyd2wkP6xKApw==
X-Received: by 10.194.80.65 with SMTP id p1mr31078947wjx.152.1453878224700;
        Tue, 26 Jan 2016 23:03:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:43 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284875>

It is nice to just be able to test if untracked cache is
supported without enabling it.

Helped-by: David Turner <dturner@twopensource.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
2.7.0.181.g07d31f8
