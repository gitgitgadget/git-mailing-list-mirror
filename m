Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6AAC04E30
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4892077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5jzTwD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLJCeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:34:06 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:47233 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJCeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 21:34:06 -0500
Received: by mail-yw1-f73.google.com with SMTP id j9so13319846ywg.14
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 18:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L4/lhw0eWd7OzgLDjeTG7MAEG4lKOXjksggmyh8Tb5k=;
        b=R5jzTwD4SPNhTEGoLY8Exs1foYGONL5uTz1cykWhmOSMr/vfg8bS3uORWABLWyB4Rt
         OiPQMiYfgsWjvFYzE5LbziBMCeqzcDJAP6GGMtjp0vDxBXBqXUD1n1YApzE7bNiL/M/j
         JE1ECqiiVwomo6+oc55bcw1B7JIlhFbMLeq3N0y/cO5jFJk/EtYhHZlenFLVSIKNVoqd
         fW2vPjdJcd9hBWjE+832nGnCUat/fx+I5q9SG9T2KCadiak1U+vieBWO/as7RD85uFVs
         NgbK0dhgdOKmN+ofla8cUsGkZbyLCjcaTaGz3obNZZLJiBqiFHK3CbEh7/KFf3z1cAtT
         jpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L4/lhw0eWd7OzgLDjeTG7MAEG4lKOXjksggmyh8Tb5k=;
        b=Yl0pBgCmHS1S9KdXVzDVCF4nJ/+p4T5LzlUKjXHPPGv9N6KWg11Ui71q0TmC4duL/L
         N7S/7qud3U/koTrc18qqJczqdkoTyPDL3ZcVeEl+zWCQ+wWGNk6YBfk917Ni3hxwfREG
         TAgp7xkUR1I61JHSopu8hDAzbH9JelNVc2JocJpLwXoW/d4ZdRIr8y1uG9kisDbda8gL
         9fv89RrkrueVgiB+Vg6y59T/767MQIsWZndpSN3EU8Yp/Lvfsp/1vHUogSlatPPXa01O
         z1CNQR+mVPe1JEdTgaVKsq5jfmoqDCFoaqbOgeZeIGW+C8ZpPBEnI+lYPMzDTn0H+BB2
         23Uw==
X-Gm-Message-State: APjAAAV12+BSTIZrcoU/SYZi+nd9g8xX75AmvliFKAqMkOt947IlDM6c
        nIKdno7+S261oBL01bu+wez3ZuSmuSe/DvDkhlK1Qzzis63u4uOXdom+pNlleJHcUUznVWkTsXf
        JYoS0gPZSAB7y7WYxSOkiQr2rWVCl/ula0OldNXlU8TuO4b/gUvQnl0B5F4XhC+y7VjE4xMATnQ
        ==
X-Google-Smtp-Source: APXvYqz8c/UOxhdyw8yJ7D7EwUnoWafOiT/IRD99A25NzFMWlkCHY3HLmaON6Vz2BERxt7F6Q2VXbt8nyTecytVYpT8=
X-Received: by 2002:a81:af5f:: with SMTP id x31mr24108915ywj.264.1575945245151;
 Mon, 09 Dec 2019 18:34:05 -0800 (PST)
Date:   Mon,  9 Dec 2019 18:33:35 -0800
In-Reply-To: <20191210023335.49987-1-emilyshaffer@google.com>
Message-Id: <20191210023335.49987-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 6/6] hook: teach --porcelain mode
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It might be desirable - for a user script, or a scripted Git command -
to run the appropriate set of hooks from outside of the compiled Git
binary. So, teach --porcelain in a way that enables the following:

  git hook --list --porcelain pre-commit | xargs -I% sh "%"

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    |  5 ++++-
 builtin/hook.c                | 19 +++++++++++++------
 t/t1360-config-based-hooks.sh | 12 ++++++++++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index b4a992d43f..34276f5bce 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,7 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' -l | --list <hook-name>
+'git hook' -l | --list [--porcelain] <hook-name>
 
 DESCRIPTION
 -----------
@@ -45,6 +45,9 @@ OPTIONS
 	in the order they should be run. Output of this command follows the
 	format '<order number> <origin config> <hook command>'.
 
+--porcelain::
+	Print in a machine-readable format suitable for scripting.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/hook.c b/builtin/hook.c
index 8261302b27..b76dd3ad8f 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -16,7 +16,7 @@ enum hook_command {
 	HOOK_LIST,
 };
 
-static int print_hook_list(const struct strbuf *hookname)
+static int print_hook_list(const struct strbuf *hookname, int porcelain)
 {
 	struct list_head *head, *pos;
 	struct hook *item;
@@ -25,10 +25,14 @@ static int print_hook_list(const struct strbuf *hookname)
 
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct hook, list);
-		if (item)
-			printf("%.3d\t%s\t%s\n", item->order,
-			       config_scope_to_string(item->origin),
-			       item->command.buf);
+		if (item) {
+			if (porcelain)
+				printf("%s\n", item->command.buf);
+			else
+				printf("%.3d\t%s\t%s\n", item->order,
+				       config_scope_to_string(item->origin),
+				       item->command.buf);
+		}
 	}
 
 	return 0;
@@ -38,11 +42,14 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 {
 	enum hook_command command = 0;
 	struct strbuf hookname = STRBUF_INIT;
+	int porcelain = 0;
 
 	struct option builtin_hook_options[] = {
 		OPT_CMDMODE('l', "list", &command,
 			    N_("list scripts which will be run for <hookname>"),
 			    HOOK_LIST),
+		OPT_BOOL(0, "porcelain", &porcelain,
+			 N_("display in machine parseable format")),
 		OPT_END(),
 	};
 
@@ -59,7 +66,7 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 
 	switch(command) {
 		case HOOK_LIST:
-			return print_hook_list(&hookname);
+			return print_hook_list(&hookname, porcelain);
 			break;
 		default:
 			usage_msg_opt("no command given.", builtin_hook_usage,
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 66e70ae222..6f16ea1dd8 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -33,6 +33,18 @@ test_expect_success 'git hook --list orders by order number' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook --list --porcelain' '
+	cat >expected <<-\EOF &&
+	/path/def
+	/path/ghi
+	/path/rst
+	/path/uvw
+	EOF
+
+	git hook --list --porcelain pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'order number collisions resolved in config order' '
 	cat >expected <<-\EOF &&
 	010	global	/path/def
-- 
2.24.0.393.g34dc348eaf-goog

