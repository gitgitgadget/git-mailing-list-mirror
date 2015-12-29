From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 03/10] update-index: add --test-untracked-cache
Date: Tue, 29 Dec 2015 08:09:27 +0100
Message-ID: <1451372974-16266-4-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:12:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSj-0008Us-V7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbbL2HMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:44 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38462 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbbL2HMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:08 -0500
Received: by mail-wm0-f49.google.com with SMTP id b14so2746267wmb.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hxSZ+Rl83SysJZSBXVoGuhu3gl26mvDy77GQbPeMlKo=;
        b=O5H2/8B9/qNoc87TxXcIaOmrkhgJdvN2uPvo87QVUZTB0oWyHjL0yIjo/TAtu92HrA
         NdQx7evtGgAzeYWCekmKZMF+Pz+ZOAQm+KFYyPuctJ6j4L6XwXwlf7NVlQUQzHuMBzCB
         7Ynf6ujMFzKumfR8VX/iFTfRlzr+tA0n7FWT20dp+/tODCQQvS4tyJUoscHaitzDFPZv
         6HrEkGn8Mp0MDfZVkWyi2y7VwCpYfk655KxgFVA+bF8ZVeM5K5z6zRM5xQKZXsPQ/WcN
         lrvgCvjpll+joSWO1q0ediH+etjWyExi2sWG0Rni8Uu70CtpijNOvjbAor/r+s2LjwMS
         HA/w==
X-Received: by 10.194.156.199 with SMTP id wg7mr50858965wjb.114.1451373127285;
        Mon, 28 Dec 2015 23:12:07 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:06 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283085>

It is nice to just be able to test if untracked cache is
supported without enabling it.

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
2.7.0.rc2.10.g544ad6b
