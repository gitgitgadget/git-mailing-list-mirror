From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/8] update-index: add --test-untracked-cache
Date: Tue,  8 Dec 2015 18:15:11 +0100
Message-ID: <1449594916-21167-4-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:15:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Lrf-00061D-LP
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbbLHRPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:45 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34115 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbbLHRPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:43 -0500
Received: by wmvv187 with SMTP id v187so223408643wmv.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xebw4ewhiq5FzpLDzIRLUqjCTxDlRUhmOQf/csXWVRY=;
        b=HyQrvdaWZg6zQiJ7kOPtEB6w6+y+5Jgd/PFishxzakAiBQoOlIL6wvy0PmX+aSSABt
         Cwq9Q0Wpyr8H0aEfhEo53gXBcsQxqSpKg0as1McCG5jo5M1H1Gi/dxHQjSELoEW0DZSc
         lElhejOyuDGKr6lUwEaYSpz7gLU43/tv7OqTw4ZlCrHwuIANC40ZYYjidEXU20dCmyvH
         VwlcoptQh4hj5o/w5XrzVXdOkn672dw0PZvKWW1P6yZ0IdkUNQzIbAHBtnGusAGHbXRt
         Ugr3yu3vB8bSgE0zrFKYSwIN1W9itV74xuleGE41w3BnXGUFIWycqrgM7kqJmPo+LO0l
         Vxjg==
X-Received: by 10.28.52.213 with SMTP id b204mr6209927wma.32.1449594942237;
        Tue, 08 Dec 2015 09:15:42 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:41 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282162>

It is nice to just be able to test if untracked cache is
supported without enabling it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 9 ++++++++-
 builtin/update-index.c             | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 3df9c26..0ff7396 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
 	     [--ignore-submodules]
-	     [--[no-|force-]untracked-cache]
+	     [--[no-|test-|force-]untracked-cache]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
@@ -179,6 +179,13 @@ may not support it yet.
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
index 246b3d3..ecb685d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -40,6 +40,7 @@ enum uc_mode {
 	UNDEF_UC = -1,
 	NO_UC = 0,
 	UC,
+	TEST_UC,
 	FORCE_UC
 };
 
@@ -1004,6 +1005,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("enable or disable split index")),
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
+		OPT_SET_INT(0, "test-untracked-cache", &untracked_cache,
+			    N_("test if the filesystem supports untracked cache"), TEST_UC),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), FORCE_UC),
 		OPT_END()
@@ -1119,6 +1122,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
+			if (untracked_cache == TEST_UC)
+				return 0;
 		}
 		if (!the_index.untracked) {
 			uc = xcalloc(1, sizeof(*uc));
-- 
2.6.3.478.g9f95483.dirty
