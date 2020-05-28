Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A2C433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA8720DD4
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="MBr3IwMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgE1BNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgE1BNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 21:13:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77044C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:47 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 205so1669733qkg.3
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSHDcGyMSOWtL3ibVv404PEVikM2kLhMzgl7mmq+CEc=;
        b=MBr3IwMhsnJECpzJZe5zcpqoU4sIQ2srK6J8f2NNxqnT7aq9qlna/qawpEUvgJI6Fq
         u8mhUlvBwZVlZlgPvFODSWef78UKHzp7O3PQJWqKAi0N7xdZFKRaVB9hO3UCMFdIKjtT
         BkXeCnUMVaW5L6OodNA0t0vLGQFGiLXbzipmKW3iXtVxxBBa4DEOmbazFLteKazY6JXV
         dI5ZuDzjuuLhA12NyqK8E0St2U8lySp8q+Cdgoj4W44XlpPE4BHmGE8IT4TZBZJD0z0x
         3PfNIO6jPmwNe4Y1md/nROlwaXFkUk/aHvHSmvqGrVKF0VepdDykkEpwuEOgk0Egjq24
         daoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSHDcGyMSOWtL3ibVv404PEVikM2kLhMzgl7mmq+CEc=;
        b=NkeHoGwPLLlJRPqxW52c/3i3OQsvMaIjzZmx33J11m+iVCZlup7BEXY5jZWSQZDH6a
         eVXDgmDK0aDU15Hi41cgtlr5vX4rwnCHc2xU8POteoNJwFiTroiGjN1rQ1ZVgFNuCSyY
         rWawDekPsCyIUJCzwO97e7tvNx/nbopDbXyTgKunDxDpA/NN1vJd0aAbQ9InFhzQMot8
         brv8+om1lHDWD1VY9MU9LcrXGVe9z6cO03FEL94wyIot1Ef8JqTHbwxIq5HxYtzW+BdT
         dAUWPNDSAOvrlS6SNRrRLVfZJte/wGjfv9ssFXvUD0iZfAav0ejjFpXMa+08faO7jSWK
         qHuA==
X-Gm-Message-State: AOAM533BLcSoZaXaRbAeHqu8PjGk+OmT+EXz/K6eBpy5Ep4XFkHfcKiD
        SkkfOiF9Rx5VKXt8LZnwEoe58tNBBoC7pQ==
X-Google-Smtp-Source: ABdhPJxSXTdMb3QNqTcZh8lH/3OCoXtWMjTaPn6rkMicJ9OYouNaJbsyLuzs5r1ycuUiuoPO/YR8PA==
X-Received: by 2002:a05:620a:132a:: with SMTP id p10mr583414qkj.494.1590628426107;
        Wed, 27 May 2020 18:13:46 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id a188sm3547872qkg.11.2020.05.27.18.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:13:45 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v3 2/5] t/helper/test-config: return exit codes consistently
Date:   Wed, 27 May 2020 22:13:00 -0300
Message-Id: <43402007adb0916846f92c3e4ff86d4131056ce0.1590627264.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590627264.git.matheus.bernardino@usp.br>
References: <cover.1590627264.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test-config helper may exit with a variety of at least four
different codes, to reflect the status of the requested operations.
These codes are sometimes checked in the tests, but not all of the codes
are returned consistently by the helper: 1 will usually refer to a
"value not found", but usage errors can also return 1 or 128. The latter
is also expected on errors within the configset functions. These
inconsistent uses of the exit codes can lead to false positives in the
tests. Although all tests that currently check the helper's exit code,
on errors, do also check the output, it's still better to standardize
the exit codes and avoid future problems in new tests. While we are
here, let's also check that we have the expected argc for
configset_get_value and configset_get_value_multi, before trying to use
argv.

Note: this change is implemented with the unification of the exit
labels. This might seem unnecessary, for now, but it will benefit the
next patch, which will increase the cleanup section.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 76 ++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 234c722b48..1c8e965840 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -30,6 +30,14 @@
  * iterate -> iterate over all values using git_config(), and print some
  *            data for each
  *
+ * Exit codes:
+ *     0:   success
+ *     1:   value not found for the given config key
+ *     2:   config file path given as argument is inaccessible or doesn't exist
+ *     129: test-config usage error
+ *
+ * Note: tests may also expect 128 for die() calls in the config machinery.
+ *
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
@@ -64,35 +72,42 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
+enum test_config_exit_code {
+	TC_SUCCESS = 0,
+	TC_VALUE_NOT_FOUND = 1,
+	TC_CONFIG_FILE_ERROR = 2,
+	TC_USAGE_ERROR = 129,
+};
+
 int cmd__config(int argc, const char **argv)
 {
 	int i, val;
 	const char *v;
 	const struct string_list *strptr;
 	struct config_set cs;
+	enum test_config_exit_code ret = TC_SUCCESS;
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
 		read_early_config(early_config_cb, (void *)argv[2]);
-		return 0;
+		return TC_SUCCESS;
 	}
 
 	setup_git_directory();
 
 	git_configset_init(&cs);
 
-	if (argc < 2) {
-		fprintf(stderr, "Please, provide a command name on the command-line\n");
-		goto exit1;
-	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
+	if (argc < 2)
+		goto print_usage_error;
+
+	if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
 		strptr = git_config_get_value_multi(argv[2]);
@@ -104,41 +119,38 @@ int cmd__config(int argc, const char **argv)
 				else
 					printf("%s\n", v);
 			}
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
 		if (!git_config_get_int(argv[2], &val)) {
 			printf("%d\n", val);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
 		if (!git_config_get_bool(argv[2], &val)) {
 			printf("%d\n", val);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
 		if (!git_config_get_string_const(argv[2], &v)) {
 			printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (!strcmp(argv[1], "configset_get_value")) {
+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
-				goto exit2;
+				ret = TC_CONFIG_FILE_ERROR;
+				goto out;
 			}
 		}
 		if (!git_configset_get_value(&cs, argv[2], &v)) {
@@ -146,17 +158,17 @@ int cmd__config(int argc, const char **argv)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
-				goto exit2;
+				ret = TC_CONFIG_FILE_ERROR;
+				goto out;
 			}
 		}
 		strptr = git_configset_get_value_multi(&cs, argv[2]);
@@ -168,27 +180,19 @@ int cmd__config(int argc, const char **argv)
 				else
 					printf("%s\n", v);
 			}
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (!strcmp(argv[1], "iterate")) {
 		git_config(iterate_cb, NULL);
-		goto exit0;
+	} else {
+print_usage_error:
+		fprintf(stderr, "Invalid syntax. Usage: test-tool config <cmd> [args]\n");
+		ret = TC_USAGE_ERROR;
 	}
 
-	die("%s: Please check the syntax and the function name", argv[0]);
-
-exit0:
-	git_configset_clear(&cs);
-	return 0;
-
-exit1:
-	git_configset_clear(&cs);
-	return 1;
-
-exit2:
+out:
 	git_configset_clear(&cs);
-	return 2;
+	return ret;
 }
-- 
2.26.2

