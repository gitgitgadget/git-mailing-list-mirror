Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA33C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D120726
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJkB88cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLJCeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:34:03 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39963 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJCeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 21:34:03 -0500
Received: by mail-pl1-f201.google.com with SMTP id o12so8298136pll.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 18:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bb82FN8P4glPGoUSEAdIcE8asLCT95m8hDLYehq9zV0=;
        b=LJkB88cBlPulERyI2SD1s6g/jxFwUs44uEXO2Do/jYDcUBmtLrMidk/yf5dp+PK3mt
         kRap1hDnD+hEHTz5RTJvBPsH9j18dRrRCohMk3r8KfnVPPKCKR6jGnXHkJ9yjtkX5GSg
         nLSsdLg8gow0B91IucDBvmIofw8HeTCkOQqEuTa5OSejNX7v4oCqONa8jIsNuyncKDs0
         QtX/AkBgnL3iB9kNi8pifWa/1BoXrSOw1reiLUAaR8vSs2tGocYxYF01FXUx6K2QfD2K
         uJ4WA9OCp0uQVkvxh3FJ5x5QKiaABLxgHhd6XMv1d3/xtw7OC6FcNLvYy+DqtCIilgPw
         ti+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bb82FN8P4glPGoUSEAdIcE8asLCT95m8hDLYehq9zV0=;
        b=RgBwGtgauA6LJJvpEcxpA1EBc5qZxzPuZdw+nXDISFMY+TcHEC+Z9Gw0OLMQvwpYmG
         iJNEGsXZHik1uI6g55T35AcZLaROLl8ufi8ExoR7Grv5Ai+lyMbmGtyIMBUT1WawUfoD
         hSwebITnOHpDdJo4ACoSDhDJpUtWWy3CbF2TYmf+MPXt6fGpMgrBV5FD1tTmOY/Fd7nd
         TdMf7cBdc5GLvy6edU/ti4aBYKbba2UJSK2ftPT8N/gtxgXCedcFeY+p9XdPQ/sf2c41
         TD6RA2GjCm4qjbLkQs2X4oxdc9Txnc4doScucbK2Gk5pZGOWJiSQDdL6ac8y0XqRn6Av
         0RoQ==
X-Gm-Message-State: APjAAAW65sEECXvNxngCypld0ttqd4jGFISDjsTedw3M0RRNsiK34K/R
        3Z8HY2GV/JIa9iNPkMJmJd0wCbk6oR35fv760FTLQ39cIHCabEdIsUpBtveJvWwJKiTGjyKTusm
        IgbT/buxUNL3OU16gYeBl3ACfC0eTTqzoo8V36Kh4UyS5xjxmwnMjk7w5drGahg8TWnmMODvTiw
        ==
X-Google-Smtp-Source: APXvYqy5EFoVWQRXn8HklfvAOZfw+Moce6K8XOYOkoDUlVQRenjo2fUWEwRzpnjuwIFDxx7n3Ebvz1k+R1aWdO+cxso=
X-Received: by 2002:a63:ed49:: with SMTP id m9mr21814147pgk.304.1575945242566;
 Mon, 09 Dec 2019 18:34:02 -0800 (PST)
Date:   Mon,  9 Dec 2019 18:33:34 -0800
In-Reply-To: <20191210023335.49987-1-emilyshaffer@google.com>
Message-Id: <20191210023335.49987-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 5/6] hook: remove prior hook with '---'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible a user may want to run a hook for nearly every repo,
except for one. Rather than requiring the user to specify the hook
locally in all but one repo, teach 'git hook' how to interpret config
lines intended to remove hooks specified earlier during the config
parse. This means a user can specify such a hook at the system or global
level and override it at the local level.

For example:

$ grep -A2 "\[hook\]" ~/.gitconfig
[hook]
        pre-commit = 001:~/test.sh
        pre-commit = 999:~/baz.sh
$ grep -A2 "\[hook\]" ~/git/.git/config
[hook]
        pre-commit = 900:~/bar.sh
        pre-commit = ---:~/baz.sh
$ ./bin-wrappers/git hook --list pre-commit
001     global  ~/test.sh
900     repo    ~/bar.sh

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    |  8 ++++++++
 hook.c                        | 15 ++++++++++-----
 t/t1360-config-based-hooks.sh | 13 +++++++++++++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 0f7115f826..b4a992d43f 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -28,6 +28,14 @@ The order number of a hook can be changed at a more local scope, e.g.:
 When the order number is respecified this way, the previously specified hook
 configuration is overridden.
 
+A hook specified at a more global scope can be removed by specifying "---"
+instead of an order number, e.g.:
+
+  git config --add --global hook.pre-commit "001:/foo.sh"
+  git config --add --local hook.pre-commit "---:/foo.sh"
+
+When the hook is removed in this way, `/foo.sh` will not be run at all.
+
 OPTIONS
 -------
 
diff --git a/hook.c b/hook.c
index a7dcd18a2e..e7afa140c8 100644
--- a/hook.c
+++ b/hook.c
@@ -49,9 +49,14 @@ static int check_config_for_hooks(const char *var, const char *value, void *hook
 		// TODO this is bad - open to overflows
 		char command[256];
 		int added = 0;
-		if (!sscanf(value, "%d:%s", &order, command))
-			die(_("hook config '%s' doesn't match expected format"),
-			    value);
+		int remove = 0;
+		if (!sscanf(value, "%d:%s", &order, command)) {
+			if (sscanf(value, "---:%s", command))
+				remove = 1;
+			else
+				die(_("hook config '%s' doesn't match expected format"),
+				    value);
+		}
 
 		list_for_each_safe(pos, p, &hook_head) {
 			item = list_entry(pos, struct hook, list);
@@ -60,7 +65,7 @@ static int check_config_for_hooks(const char *var, const char *value, void *hook
 			 * the new entry should go just before the first entry
 			 * which has a higher order number than it.
 			 */
-			if (item->order > order && !added) {
+			if (item->order > order && !added && !remove) {
 				emplace_hook(pos, order, command);
 				added = 1;
 			}
@@ -73,7 +78,7 @@ static int check_config_for_hooks(const char *var, const char *value, void *hook
 				remove_hook(pos);
 		}
 
-		if (!added)
+		if (!added && !remove)
 			emplace_hook(pos, order, command);
 	}
 
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 1af43ef18d..66e70ae222 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -61,4 +61,17 @@ test_expect_success 'adding a command with a different number reorders list' '
 	test_cmp expected actual
 '
 
+test_expect_success 'remove a command with "---:/path/to/cmd"' '
+	cat >expected <<-\EOF &&
+	010	repo	/path/abc
+	050	repo	/path/def
+	100	repo	/path/ghi
+	990	repo	/path/rst
+	EOF
+
+	git config --add --local hook.pre-commit "---:/path/uvw" &&
+	git hook --list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.24.0.393.g34dc348eaf-goog

