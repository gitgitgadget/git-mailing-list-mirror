From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 03/11] update-index: add --test-untracked-cache
Date: Fri, 15 Jan 2016 07:59:44 +0100
Message-ID: <1452841192-620-4-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:01:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNk-0005LO-HK
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbcAOHBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:01:08 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35267 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbcAOHAc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:32 -0500
Received: by mail-wm0-f49.google.com with SMTP id f206so8314112wmf.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JB/RHcJDQnv8P33XjXybZMddCvZ2NZO/DwnupE0O598=;
        b=k3FWaP147bkHIEB87Urts6lTEhY/mif19cNEghkxIsy3wtxNdo7p/2Vuh2Rz+xa4kU
         PfLhz2mgg4UlUj5QiCRf7Oq22QSFp8LhXY2xbre7E1K2rtUDikPI0iG95KBwd8Pu/q7s
         2Lr4OW993Soa3HjI9TOIrCJtTqC2T+bgrIr+B0aE/KvioXrvKxcte5qHI0JyCO0XdYof
         3rgE5iqRqSxTz4vbtbl5GDx979MGlex1Zry3aeOsozdlRfoSKJu64nWfBk8UQsvpQYsg
         DWkNmz/OPq8HgZB8LQnh6dTYX1/mtF2rRMONSA3oLPpS1tUKJdn/8/kXqOPkWQhi73+2
         KMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JB/RHcJDQnv8P33XjXybZMddCvZ2NZO/DwnupE0O598=;
        b=J+MiCjKEYZHkBQ43bDgdDhysD2Nef+mUmoLEuFd4aKYKZ0voqmsN21EGsNwjYVZuri
         YatEfRmGPCJ4E6dFRz/v4C4JYDYbk2kGNv3/12q3yVy0y3ts5eecuXzfpUWq/Feacoci
         9+c7rZelwmESAxFeH/XM2wxQvOlIuKIdMI/bYpf+MK8yXC2RXL7OzEp/K3OmiBcExXap
         k1BhY3jn1edHuiN7oMSfexmlSqgtMRhm+CI0rSmlRY+V3uPNOC2UUpmBXLt4OrHzHblZ
         DQOgGr9dEO+O8+RN6/8Khq8e5DJHz9zadcWOYMuyhLoc+06QmO0vNaOXc+UAftm8P5qK
         pxpw==
X-Gm-Message-State: AG10YOSOZPHG9lacTvtqoUfNgokgQf0XPXVeOpA4GLiYm2dBVqJM3U0/cYlpJmDQZfDaIw==
X-Received: by 10.28.52.195 with SMTP id b186mr1489680wma.40.1452841230576;
        Thu, 14 Jan 2016 23:00:30 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:29 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284149>

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
2.7.0.36.g20612a7
