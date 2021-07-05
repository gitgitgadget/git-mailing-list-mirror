Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6585FC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50862613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGEMfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhGEMfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D3C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:41 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q23so20534728oiw.11
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ayC9wq9/e6ZjI7NP5sAlNgcHa3z34mOfxvtAayujs/M=;
        b=D3BldIVnA8GjeEUMYLD3mn/Rlog3oxpctQCLEHsBNzuXcTgDREdVBFG3/qk+lZMltd
         zHIAERjTriYX7EfI753PeTcW2zh8mrnJaQx3qszLrZjyKQb5rdZ8PNIERpUaV1kJsPGz
         FxTUQ34VQ6hldQDvTtMQmpypxwoSmmyoIW+Bt/I19Hkpnvd6yy3nn5eiBlYgdUNyQThF
         BnSSYZWomOnyZOqJUD4f1MlVjWbHswj+PTCTRzXlEMOasbYroLJCI7+wPt5k52/KDn7i
         eLhDWTWpXrzWXUvA+x44c5NPVW3GQrW9gGl40qG6D/CBMdEomMWBM/6rGOEUDNbFjeGx
         GPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ayC9wq9/e6ZjI7NP5sAlNgcHa3z34mOfxvtAayujs/M=;
        b=FuvQnHfwCneqo/U4FcR8d2+XIUAaz1XC458HHzZgD0C+CGdU0HhEyDnelB7QjYHVFn
         B//1Ubd7dbPBTUEoiCoYviTg31Bi/+64DOaSs0EKJYxqpwi5rwkv4Oad6ktLQR4Wxs8Q
         HKbjQi4TiJw6d6TfpYVAdrQ0kZ5N0nXMH1AMvMe/EBYZNmYhcT7q0Ktby0+P67LnArPK
         Ru7Fs5Tx1pRKxm/8mkiiQ7q5LEEZ5G8u66+knm0jAKSl6h+ou+daWFz7lsYgpmKTWEng
         jxq0qQjRIqxtgc9ksLt0SbTmVaqvz7z9H8sg3ZXPrINwQznXY9bvHBJ9IW+Wnrzfd3tw
         Vnhw==
X-Gm-Message-State: AOAM532sBlvrlfB3+knv2ftSpGy3RJSj5su+pNTQwEhSEgV5DTbOF6SO
        o+PThGBb6kBRNBC4JNxToN3QB/hUTHUM8w==
X-Google-Smtp-Source: ABdhPJyIT1P+B99JWsCcjqIyYafZNycYw8y7wcu+dLRlcE88ohhnuPVc0Ruz39PoNn5M0uLsHn8UQA==
X-Received: by 2002:aca:4482:: with SMTP id r124mr9714611oia.153.1625488360531;
        Mon, 05 Jul 2021 05:32:40 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v203sm2674588oib.37.2021.07.05.05.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 17/35] update: add mode configuation
Date:   Mon,  5 Jul 2021 07:31:51 -0500
Message-Id: <20210705123209.1808663-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt        |  2 ++
 Documentation/config/update.txt |  4 ++++
 builtin/update.c                | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 Documentation/config/update.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fc4b49c0d4..998339e6fd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -466,6 +466,8 @@ include::config/trace2.txt[]
 
 include::config/transfer.txt[]
 
+include::config/update.txt[]
+
 include::config/uploadarchive.txt[]
 
 include::config/uploadpack.txt[]
diff --git a/Documentation/config/update.txt b/Documentation/config/update.txt
new file mode 100644
index 0000000000..42a7fe1614
--- /dev/null
+++ b/Documentation/config/update.txt
@@ -0,0 +1,4 @@
+update.mode::
+	When `git update` is run, this determines the mode of operation,
+	possible values are 'fast-forward', 'merge', and 'rebase'. The default
+	is 'fast-forward'.
diff --git a/builtin/update.c b/builtin/update.c
index 989104421e..4a1b82a41d 100644
--- a/builtin/update.c
+++ b/builtin/update.c
@@ -5,9 +5,11 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "config.h"
 #include "dir.h"
 
 enum update_mode_type {
+	UPDATE_MODE_INVALID = -1,
 	UPDATE_MODE_FAST_FORWARD = 0,
 	UPDATE_MODE_MERGE,
 	UPDATE_MODE_REBASE
@@ -34,6 +36,28 @@ static struct option update_options[] = {
 	OPT_END()
 };
 
+static enum update_mode_type update_mode_parse_value(const char *value)
+{
+	if (!strcmp(value, "fast-forward"))
+		return UPDATE_MODE_FAST_FORWARD;
+	if (!strcmp(value, "merge"))
+		return UPDATE_MODE_MERGE;
+	if (!strcmp(value, "rebase"))
+		return UPDATE_MODE_REBASE;
+
+	return UPDATE_MODE_INVALID;
+}
+
+static int git_update_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "update.mode")) {
+		mode = update_mode_parse_value(value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 static int run_fetch(void)
 {
 	struct strvec args = STRVEC_INIT;
@@ -87,6 +111,8 @@ int cmd_update(int argc, const char **argv, const char *prefix)
 	if (!getenv("GIT_REFLOG_ACTION"))
 		setenv("GIT_REFLOG_ACTION", "update", 0);
 
+	git_config(git_update_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, update_options, update_usage, 0);
 
 	if (repo_read_index_unmerged(the_repository))
-- 
2.32.0.36.g70aac2b1aa

