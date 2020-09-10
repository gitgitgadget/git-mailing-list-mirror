Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C44C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225872064B
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="bvWMBO3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgIJRXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgIJRWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:22:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47550C061796
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so6811915qke.13
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EK27lZ324OgqS0qIvd2X9pmkmZc2U3JsTfC8sb6036E=;
        b=bvWMBO3e4AOSikkACEwhOITVQcryzhsay5sv3U0leCJYakep/7mBQPovvqEVtElqlF
         9m0csvQdXR3X0xBbDnalXP8RHAGYE8DggchkE57z6ywNOKCkvYJJ4FQK+hOh52gtMlGs
         ZBqZQ+RYkBWKYFv4oNDPyUrJxazCQJ5I11WvpnSfMJ10CsYBx+sNaD2ZMyYWuKTaGu96
         Xh7YeipY4EWktFY/ZhwE5/6PC39wbPTtnYLBByPQfRKjmM2D9ndHUDaKDpAIdacHiwk8
         28RXFSk40XL9Q24bcYu6K3SY3jZWj3Ik9YO6/YuITPEEmyw4FqypWFf01laiW9UGmrLQ
         CqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EK27lZ324OgqS0qIvd2X9pmkmZc2U3JsTfC8sb6036E=;
        b=jxlh2yqXWjdruimA7V8r4slNN9gIW817HwwZtI7uvNdbcDg0NLS9uWSBAxGjJiJ9i1
         ydw2F2fqfmtRu30QM0dg3a0RlBRQBzOrno7U0ZCWXdDcHNZhZvpu7qqpxfTiFg+oVq7S
         bYDH+xaKvlS5Grm6SCuZDgpxQt4UZWq23orh4VnX2W0GB4P3hZbkqP2JFftXXLc5XrU7
         6WgmvLbnuNPa/VdIn0qMWoSnw7TTT+PanGKhyyAxz6RXfNVmgEakVPltEGXDVkZ0adLo
         0JEnJjIokSuOpcN370EP/24dOVQc8KpzkYi1qmUB7+6Tlwbtbao16Ricuyt9sjZWHcbD
         4gFw==
X-Gm-Message-State: AOAM532uOq/MzP3DYelO/Sa0XFWVP5YCdTGLtmqGx8swdJP0r4/dc6gS
        DeIjFOhoCLyr2bm3mCLlzsjDSeJmaBBVvA==
X-Google-Smtp-Source: ABdhPJwEfcXSB183jupbhNIEoPAsl1wTj2tU5oOHG0Ztf4BV5TGlamuoG7HBVvjznP7+/DUKO7SL4A==
X-Received: by 2002:a37:8047:: with SMTP id b68mr8423889qkd.299.1599758516068;
        Thu, 10 Sep 2020 10:21:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:21:55 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 5/9] t/helper/test-config: unify exit labels
Date:   Thu, 10 Sep 2020 14:21:24 -0300
Message-Id: <924d2e8ceb8b2131a13bafa356c5dc98eccae806.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-config's main function has three different exit labels, all of
which have to perform the same cleanup code before returning. Unify the
labels in preparation for a future patch which will increase the cleanup
section.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 49 ++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 26d9c2ac4c..06c61d91e1 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -69,9 +69,12 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
+#define TC_VALUE_NOT_FOUND 1
+#define TC_CONFIG_FILE_ERROR 2
+
 int cmd__config(int argc, const char **argv)
 {
-	int i, val;
+	int i, val, ret = 0;
 	const char *v;
 	const struct string_list *strptr;
 	struct config_set cs;
@@ -94,10 +97,9 @@ int cmd__config(int argc, const char **argv)
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
@@ -109,41 +111,38 @@ int cmd__config(int argc, const char **argv)
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
 		if (!git_config_get_string_tmp(argv[2], &v)) {
 			printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
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
@@ -151,17 +150,17 @@ int cmd__config(int argc, const char **argv)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
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
@@ -173,27 +172,17 @@ int cmd__config(int argc, const char **argv)
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
+		die("%s: Please check the syntax and the function name", argv[0]);
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
2.28.0

