From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 02/10] update-index: add --test-untracked-cache
Date: Tue, 15 Dec 2015 17:28:19 +0100
Message-ID: <1450196907-17805-3-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTR-00041v-RK
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbbLOQ3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:02 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38453 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbbLOQ3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:00 -0500
Received: by mail-wm0-f51.google.com with SMTP id l126so1548185wml.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SNbA8kPc9dXysyUrPSGhtRvNC4VGyhKON3GvH/sno8s=;
        b=xHKSY+maz9Ic6o1+FZ8xXcIGwp1DmRO9f4WR3spTkj/jGRtt+vss7fk1ToyUnfHF66
         X72a/BR7yXG7FEJwXSSxQLM2Bln2jclg0NyUAbMvnffdFZ6DZ0SwCdV/X1CuCIfPRfPV
         +B8N3kWrcW7rajUhMqUKRNEx6w3TAvB2J7l3iiCIhlq8CbcwhFvv/eixqcl0X+mxsaqT
         bPLjBXaXJwpenJNPzQVosNLJ+u1PIKEPvZqm5k94T5U+jZ9Db5g7zzwrvvgIZhz/foIc
         U0x1tH7Fi3caKloC3XJKtGYib+lcsg4GauZKjx7xSbgRClh2/z8/IdwmraDA9ej+EqVV
         qdMw==
X-Received: by 10.28.32.22 with SMTP id g22mr5658938wmg.43.1450196939538;
        Tue, 15 Dec 2015 08:28:59 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:28:58 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282484>

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
index 2430a68..e747a6c 100644
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
2.6.3.479.g8eb29d4
