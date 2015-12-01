From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 2/8] update-index: add --test-untracked-cache
Date: Tue,  1 Dec 2015 21:31:33 +0100
Message-ID: <1449001899-18956-3-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbL-00081a-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058AbbLAUcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:32:36 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36127 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbLAUcd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:33 -0500
Received: by wmec201 with SMTP id c201so5027890wme.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dtKPLRCZdDs6HoqLyInL5rF3pD4YcifFwdal8oFitPs=;
        b=DpNMEhfjrZXQtuI0GuC4eCIUYTe8RuuDI0Jhhx+W8oU2XQFr279vwm+/7qbe4EuOm9
         1eeiE+kvDPBQCvIWWCa5KxgQhIf7/i+mpqkrefCDOYOeb2Xe9e5h68R6mfhY7avy+Uej
         SZTRUySEUzuYrP4NvYwJ1jejXcXgjrJmiOxp4ZG0y7OS4amYc6OECawFZPI9YQgnn2+H
         NUNTS6/F+lqEJAnv+1j7GnhmGaEaEr0bv9tntoKPGTdpTjZooBak0aQs3cBn/rPeiyfg
         FdliERCgzqsLiPWtvpczOoAAyaRo4SAAvOa7OsxE+WCmSS4VaZZfQ1fHWn8DINp+TUnT
         TrCg==
X-Received: by 10.28.32.22 with SMTP id g22mr71734wmg.43.1449001952508;
        Tue, 01 Dec 2015 12:32:32 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:31 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281845>

It is nice to just be able to test if untracked cache is
supported without enabling it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 9 ++++++++-
 builtin/update-index.c             | 8 ++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

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
index e568acc..b7b5108 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -996,8 +996,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("enable or disable split index")),
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
+		OPT_SET_INT(0, "test-untracked-cache", &untracked_cache,
+			    N_("test if the filesystem supports untracked cache"), 2),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
-			    N_("enable untracked cache without testing the filesystem"), 2),
+			    N_("enable untracked cache without testing the filesystem"), 3),
 		OPT_END()
 	};
 
@@ -1107,10 +1109,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (untracked_cache > 0) {
 		struct untracked_cache *uc;
 
-		if (untracked_cache < 2) {
+		if (untracked_cache < 3) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
+			if (untracked_cache == 2)
+				return 0;
 		}
 		if (!the_index.untracked) {
 			uc = xcalloc(1, sizeof(*uc));
-- 
2.6.3.391.g95a3a5c
