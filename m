From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 03/11] update-index: add --test-untracked-cache
Date: Wed, 23 Dec 2015 22:03:51 +0100
Message-ID: <1450904639-25592-4-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqaJ-0008Ca-Te
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbbLWVEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:32 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33565 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965277AbbLWVE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:29 -0500
Received: by mail-wm0-f44.google.com with SMTP id p187so158632358wmp.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4KMNdnsEJw1nol9DqOYxx7WVTNNNTEGIHfxcT4LiU14=;
        b=UmNVwmVy7i7TbPiJ0rk4OIjp8AoY9dF+/yPZw29dOvhhCIFwqjC3ysJ3L4lbtyd7LA
         3oyreXjBKC88u6i75d9x57uaHhQAPA3taHTn5bAqoK1/sqKXweCYJRb0xpS6aMilmAxb
         YRvRMSdaPrvQjgsDubOwbhPSJ32ou+7N7+qzAUoA1d0U19FKHsQcMZzEiia+kPzVoKYu
         fCxwmX1bV5eauQ6l/AOuiCV0czemRUNLZP9I2gBvMPVdV8Yz91U/ix6mzV6bBGfvGJQA
         xj18nUOvtCHDZaudtkWlpqcGEAeJHgFxxGNGk8LA8N9MqFvueGkSm82wPxqIe5XWaa/j
         lYdQ==
X-Received: by 10.194.110.35 with SMTP id hx3mr42395258wjb.0.1450904667676;
        Wed, 23 Dec 2015 13:04:27 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:26 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282958>

It is nice to just be able to test if untracked cache is
supported without enabling it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 9 ++++++++-
 builtin/update-index.c             | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index f4e5a85..a0ee0c9 100644
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
@@ -180,6 +180,13 @@ may not support it yet.
 	system must change `st_mtime` field of a directory if files
 	are added or deleted in that directory.
 
+--test-untracked-cache::
+	Only perform tests on the working directory to make sure
+	untracked cache can be used. You have to manually enable
+	untracked cache using `--force-untracked-cache` (or
+	`--untracked-cache` but this will run the tests again)
+	afterwards if you really want to use it.
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
2.7.0.rc2.11.g68ccdd4
