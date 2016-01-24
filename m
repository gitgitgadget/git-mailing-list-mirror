From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 03/11] update-index: add --test-untracked-cache
Date: Sun, 24 Jan 2016 16:28:16 +0100
Message-ID: <1453649304-18121-4-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbY-0000vY-B1
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbcAXP30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34982 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbcAXP2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so6789709wmz.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XvCcY/upGjEYFQuzJn/2EIFKoUsXA6hX7AwXv8dtzSQ=;
        b=1AbbCxM6xZ2Q4mb4fAq6oJoSJfDyMFsoc17jDhXJyg11faXLWFg8+KHePb6FfaGG0E
         RUb6BkDSQZ5Z3PfWN297M5Yd2gym+uVI02SaE4dQi/GO5wij6HchL3M+4MHW7vXGXmfq
         N6W0yWsoDf1sFRNuv9SVUA0/YCBXN99xMnt8eD59HF2DBJgIx/s3k1VfKsWsM2xRbgkG
         YsTL+tiVT84ZO9VueucB9BXFkQhEVMMGRMSJzkL1Z9qua6FjN0NiIBlKie8D/XXU2OOT
         trWpkewy7VKOOvtOEcHyMjBBalP2Py7/bFmKfbtZGxpJTvMKyDgaHbrA/T3DyMcIDct5
         +PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XvCcY/upGjEYFQuzJn/2EIFKoUsXA6hX7AwXv8dtzSQ=;
        b=BS9qHOak01PioCElYAr4QQUFry2Bcaxrvxw8InWzaiBQeib62qUp1TUhKg+R/0MSHj
         aQ2yMj+cjklp/HJMu3EOnP6MHSmDFBqjU8/eYQvVKutI9s71O5SID5g+jxuwUl2nFqc+
         5pNGq9ePkfkRYPnQX17Fv+n2EExHR9OdoRTzUdYLcHSEiNKf4wkOguGclIyjvm2zl7C9
         BWeB/kd+aPwRG9TqXa4jhIUntY3dAdvIOPeGPtwdC5yt4H0iwDjwTSjwLrkeEmrSt2H+
         3PlC6b/eexnespCVuiWrt57t9riuwgeqF8c3oNTAdrKlcho83QEJrHGv0zVXA0ta/pjA
         voXw==
X-Gm-Message-State: AG10YOS2ysSEZRSTipF/SJJnL8LII2j1EiI0sIkrsYNKmWSdfefsH7yKSAFklphXh5oVYA==
X-Received: by 10.194.80.200 with SMTP id t8mr12771302wjx.74.1453649325192;
        Sun, 24 Jan 2016 07:28:45 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:43 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284653>

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
2.7.0.181.gd7ef666.dirty
