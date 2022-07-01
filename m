Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC4CCA47F
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiGAKiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbiGAKiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:38:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF7796BD
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso3464754wma.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxmfR5y6T5NnZd//ZN2GPidqJSmmnmEmUMsaSAz4EEs=;
        b=HdDLwL6a0Jfj/vLJxBX97iR7d3l/oAoEInoD81iC/kTnr+3iZu2qM3JWI1P3DbsgkW
         cln7cLrW1BfPZzf046HE4bAHIBtBQo/qI10jcG9Kkz5tJMfJdns9Xug23j2MKEck8JTC
         4p+pPsG9A8ica35vsfTc2JzQQguu/q8IM0S+94OY0fXHO+WSyuRByW4cDtF+1Y/KZzio
         s3eQadbgkkXQGR8OV4YH2RxDunnYjwe9T3nF0D2G1ZZn3uMPde3OAZY0DwyQ7hwX5wlu
         Q7XMrb/QDC660oS6YZjACaMhzFQ9p7xKGzEXOqFhfM1dDfijOlyreTbdeZZgj/Z80inY
         ywKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxmfR5y6T5NnZd//ZN2GPidqJSmmnmEmUMsaSAz4EEs=;
        b=4m2q4c2gUKZaI8M1U78Iae9WBdZyjo7UWUhr5wa7PAn7/YI+opk0ARqGexy+tulUgv
         8/FiYs7fvrUJKK30HTDAWUJ3tLgkG3z+OlmRVLX8gkw5nXxK8OmEL3ZUqqBXSAXFLpwu
         tmgSc6g7qWrLVoIEsT7qIdfK+s4i5f61Bej6nqhrFyRgO0bqow1KcPEIECjCXBtKQH0k
         060HBfXCKMbEC0adZiJA5eg5z0pexaZ8evpHJi3HRREhd6bAuLS5NB6aXYeMICDAj2s6
         jf0MS7iOpTEX4h+AZ1mr+Y54bpeo+mR+Nty0zX/ZOXgDfw/GmkWBcBIDe1k/sIWj097E
         pqtQ==
X-Gm-Message-State: AJIora+uWKzKMhoW1RreS8awfcRlO+xUDh4f2q6AvbEeyfI/hK8+sCoI
        qVOwHLdqzA2yszGk7z/q2LNHE4fPXu1/Mw==
X-Google-Smtp-Source: AGRyM1vKcbd7usXwFP0g4kj/YujBoifBreBC9JoxGUp5vxCwjWRzHAVyg7pxV64ggZSXvV0Tgu5hkQ==
X-Received: by 2002:a05:600c:3d18:b0:3a1:8f1e:cc05 with SMTP id bh24-20020a05600c3d1800b003a18f1ecc05mr1481173wmb.78.1656671876176;
        Fri, 01 Jul 2022 03:37:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] test-tool delta: fix a memory leak
Date:   Fri,  1 Jul 2022 12:37:40 +0200
Message-Id: <patch-v2-9.9-0968f549957-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in a310d434946 ([PATCH] Deltification
library work by Nicolas Pitre., 2005-05-19), as a result we can mark
another test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-delta.c                 | 21 ++++++++++++++-------
 t/t5303-pack-corruption-resilience.sh |  2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index e749a49c88e..b15481ea596 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -20,8 +20,9 @@ int cmd__delta(int argc, const char **argv)
 {
 	int fd;
 	struct stat st;
-	void *from_buf, *data_buf, *out_buf;
+	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
 	unsigned long from_size, data_size, out_size;
+	int ret = 1;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "usage: %s\n", usage_str);
@@ -38,21 +39,21 @@ int cmd__delta(int argc, const char **argv)
 	if (read_in_full(fd, from_buf, from_size) < 0) {
 		perror(argv[2]);
 		close(fd);
-		return 1;
+		goto cleanup;
 	}
 	close(fd);
 
 	fd = open(argv[3], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[3]);
-		return 1;
+		goto cleanup;
 	}
 	data_size = st.st_size;
 	data_buf = xmalloc(data_size);
 	if (read_in_full(fd, data_buf, data_size) < 0) {
 		perror(argv[3]);
 		close(fd);
-		return 1;
+		goto cleanup;
 	}
 	close(fd);
 
@@ -66,14 +67,20 @@ int cmd__delta(int argc, const char **argv)
 				      &out_size);
 	if (!out_buf) {
 		fprintf(stderr, "delta operation failed (returned NULL)\n");
-		return 1;
+		goto cleanup;
 	}
 
 	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
 	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
 		perror(argv[4]);
-		return 1;
+		goto cleanup;
 	}
 
-	return 0;
+	ret = 0;
+cleanup:
+	free(from_buf);
+	free(data_buf);
+	free(out_buf);
+
+	return ret;
 }
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 41e6dc4dcfc..2926e8dfc41 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='resilience to pack corruptions with redundant objects'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note: the test objects are created with knowledge of their pack encoding
-- 
2.37.0.900.g4d0de1cceb2

