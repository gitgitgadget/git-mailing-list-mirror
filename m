Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45703C433E3
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6F220842
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="fL7e3qV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFLPp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFLPp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 11:45:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6CC03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n141so9409984qke.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZlZ2FsoucErK0zl2waO2I4VMkptcf3pdnuiX62GMbqM=;
        b=fL7e3qV3LmctDh4Q53ifCeqiv536iJqQLzpH9NG4cUsUIfnvI9WGrvU5558NMFqEMb
         qogYFlrG/F3XeJwz4aH/120zjtoem15Qcxcxf1EiqM6lt7ud0sfpZ+f484ZZRPvcrhab
         tbpIAgXNjjNd5+aycZ7mBHZjKdd3CkYPJdAVas4AE/qjplEUQrTItwiVO6Rdbu5cLsqW
         bXdI2qVXKot2tuoiVy9bxrsP0Lp5HtWkV8Nqu4lyb7rVrZ3vSLm04tGuOP70MNVJsmD9
         jIpn6VZjt4kRtFVkNNu0wFIZXFspgJ/jBihNm/qQuJlfsvvGmCWmj+p+3srJCkZkrnvv
         0e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZlZ2FsoucErK0zl2waO2I4VMkptcf3pdnuiX62GMbqM=;
        b=nuKA8GMpXOmHIVqHVhgJk3wkLxFB1sWkIfvQSUIueaEGSMaYUf7wNSUEhLW3MDZ8ek
         bpFGA8rnVlGCqvQRQzx6442XyauNV4bQe+cyeTbye4LBypr+UN2X5QA4eWfo6BjtvPvp
         vjzoVXvb8uYTqrge6RmDGZkawHMhUNGd0XB+B36BrzkJhLJzfcdG/TLgAmspyqFrUJcO
         anmHi8nMC9V1qlKDqQokCIGH7yEBeWaSuU4zR+wcB8byLtWPwXnUjkxAcgaFlqHT3Xcq
         cGf0pK6e7kK1I1ANxizMRI1S7mpWpKQ/Lf2FDSZSdRJitWhpzBHLdvASN2zU4j0HYGmr
         RCHg==
X-Gm-Message-State: AOAM531/brilyZornOT0eQFU5At8p9a0tZ4YNvcRoOja16FK75vDFPQ5
        e4DYvyFx/v6NxzjtnOed0TySGagXBkktcQ==
X-Google-Smtp-Source: ABdhPJx8IK6XCR2BItUOWybZ/dvFYaDrJh4TXXO+JNBwjO2vZsYAYYDOd/NFSc2UKJ7mGYiPAWzx4A==
X-Received: by 2002:a37:555:: with SMTP id 82mr3574811qkf.279.1591976723553;
        Fri, 12 Jun 2020 08:45:23 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::3])
        by smtp.gmail.com with ESMTPSA id r37sm4988157qtk.34.2020.06.12.08.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:45:22 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v4 3/6] t/helper/test-config: facilitate addition of new cli options
Date:   Fri, 12 Jun 2020 12:45:01 -0300
Message-Id: <e9eaaecccc1be4be9ecae31e09422189c027e010.1591974940.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591974940.git.matheus.bernardino@usp.br>
References: <cover.1591974940.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-config parses its arguments in an if-else chain, with one arm for
each available subcommand. Every arm expects (and checks) that argv
corresponds to something like "config <subcommand> [<subcommand args>]".
This means that whenever we want to change the syntax to accommodate a
new argument before <subcommand> (as we will do in the next patch), we
also need to increment the indexes accessing argv everywhere in the
if-else chain. This makes patches adding new options much noisier than
they need to be, besides being error-prone. So let's skip the "config"
argument in argv and argc to take the extra complexity out of such
patches (as the following one).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 64 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 1c8e965840..61da2574c5 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -84,33 +84,35 @@ int cmd__config(int argc, const char **argv)
 	int i, val;
 	const char *v;
 	const struct string_list *strptr;
-	struct config_set cs;
+	struct config_set cs = { .hash_initialized = 0 };
 	enum test_config_exit_code ret = TC_SUCCESS;
 
-	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
-		read_early_config(early_config_cb, (void *)argv[2]);
+	argc--; /* skip over "config" */
+	argv++;
+
+	if (argc == 0)
+		goto print_usage_error;
+
+	if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
+		read_early_config(early_config_cb, (void *)argv[1]);
 		return TC_SUCCESS;
 	}
 
 	setup_git_directory();
-
 	git_configset_init(&cs);
 
-	if (argc < 2)
-		goto print_usage_error;
-
-	if (argc == 3 && !strcmp(argv[1], "get_value")) {
-		if (!git_config_get_value(argv[2], &v)) {
+	if (argc == 2 && !strcmp(argv[0], "get_value")) {
+		if (!git_config_get_value(argv[1], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
-		strptr = git_config_get_value_multi(argv[2]);
+	} else if (argc == 2 && !strcmp(argv[0], "get_value_multi")) {
+		strptr = git_config_get_value_multi(argv[1]);
 		if (strptr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
@@ -120,32 +122,32 @@ int cmd__config(int argc, const char **argv)
 					printf("%s\n", v);
 			}
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
-		if (!git_config_get_int(argv[2], &val)) {
+	} else if (argc == 2 && !strcmp(argv[0], "get_int")) {
+		if (!git_config_get_int(argv[1], &val)) {
 			printf("%d\n", val);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
-		if (!git_config_get_bool(argv[2], &val)) {
+	} else if (argc == 2 && !strcmp(argv[0], "get_bool")) {
+		if (!git_config_get_bool(argv[1], &val)) {
 			printf("%d\n", val);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
-		if (!git_config_get_string_const(argv[2], &v)) {
+	} else if (argc == 2 && !strcmp(argv[0], "get_string")) {
+		if (!git_config_get_string_const(argv[1], &v)) {
 			printf("%s\n", v);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
-		for (i = 3; i < argc; i++) {
+	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value")) {
+		for (i = 2; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
@@ -153,17 +155,17 @@ int cmd__config(int argc, const char **argv)
 				goto out;
 			}
 		}
-		if (!git_configset_get_value(&cs, argv[2], &v)) {
+		if (!git_configset_get_value(&cs, argv[1], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
-		for (i = 3; i < argc; i++) {
+	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value_multi")) {
+		for (i = 2; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
@@ -171,7 +173,7 @@ int cmd__config(int argc, const char **argv)
 				goto out;
 			}
 		}
-		strptr = git_configset_get_value_multi(&cs, argv[2]);
+		strptr = git_configset_get_value_multi(&cs, argv[1]);
 		if (strptr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
@@ -181,10 +183,10 @@ int cmd__config(int argc, const char **argv)
 					printf("%s\n", v);
 			}
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (!strcmp(argv[1], "iterate")) {
+	} else if (!strcmp(argv[0], "iterate")) {
 		git_config(iterate_cb, NULL);
 	} else {
 print_usage_error:
-- 
2.26.2

