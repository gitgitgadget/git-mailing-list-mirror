Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3FC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiF3Xrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiF3Xrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FB75A2C1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so3291762wmr.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7zhjo9UipOfMmOXvQkuiGqb5n1ZVHpbHGjB3553cZs=;
        b=hTS8Q/tv8uTdvTejsrorIYbSA47ktan/rnJakCkkOG7GFJVTexbGt6oTGn9BVgGqB1
         9YsRdRC1IwJ0lTWRM2+dcLBo/o6D6zO6CCYBkwiwHeWfVbnXzj//SPvGHfLI8dUYscxE
         pn5x4TJ11Za91VefP5jOo9XKr05Yc8HKi7r9r3g/0z8Q+LlUCyJnTCMyqAsXNfof7ZLu
         KLdEK7+xmNr7Y/iS14U0OSMpDS8Szd3ES9U3NAv5CK2vyRRL5xeJ5i6xucswmRKlVHmX
         TmovE7C/NPLacMVo8k0rIp+q9g5xVUfZUg8mlBkBCJuiMre2dvKuk8kKDrsVmN95VZ7H
         hIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7zhjo9UipOfMmOXvQkuiGqb5n1ZVHpbHGjB3553cZs=;
        b=UHPWTVY0CORLxulCZis++iGfU+eY3A/q006ckDBeBNNAW889BKebQXHdSd3IPCnQAL
         jHQYk3nvmzyofFInyn4O9rAnjGeiPMfmNdmnpw3QUQOGGFvtEc2nT6sYg4kjNoCciJ0F
         AJIDRu/Of8KJIs9qMivpRAXRKCZDjDhR6ahgNCscRUQtM2wZ98QMdVKOUI4T3ycKk5V/
         72KoHeAcP8Zc1wSqewuB58t1TQgNp4Bz1Vd+MhksKhZCAg5aqw9xdgqzfT1diIBzJSvi
         yCQfOJ+JaKPKFKRmNJV9vBXnVkvbDJpkwLm2EEXoKEyq5iEIKU26plkaHdwnfSHoZOwn
         CSUQ==
X-Gm-Message-State: AJIora8PrldooZcWeSeH4fSR6ILxbQ4UhTSLwO5ek9omlXz3XYjcmhTQ
        AasCdqwG/c/vzpfDFGxWx53iTNmX4xeTnw==
X-Google-Smtp-Source: AGRyM1uPCsQ4WqVhecvOvuNi9UdBsrhPIt1mlu67NQvFaAcMgPye1vwcNQeteeOCLkmu3HEp41jiUQ==
X-Received: by 2002:a1c:3b07:0:b0:3a0:333d:ae22 with SMTP id i7-20020a1c3b07000000b003a0333dae22mr12794626wma.1.1656632841824;
        Thu, 30 Jun 2022 16:47:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/9] test-tool json-writer: fix memory leaks
Date:   Fri,  1 Jul 2022 01:47:06 +0200
Message-Id: <patch-6.9-97448b9056e-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks introduced with these tests in
75459410edd (json_writer: new routines to create JSON data,
2018-07-13), as a result we can mark a test as passing with
SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-json-writer.c | 16 ++++++++++++----
 t/t0019-json-writer.sh      |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index 37c452535f8..8c3edacc000 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -181,12 +181,18 @@ static struct json_writer nest1 = JSON_WRITER_INIT;
 
 static void make_nest1(int pretty)
 {
+	make_obj1(0);
+	make_arr1(0);
+
 	jw_object_begin(&nest1, pretty);
 	{
 		jw_object_sub_jw(&nest1, "obj1", &obj1);
 		jw_object_sub_jw(&nest1, "arr1", &arr1);
 	}
 	jw_end(&nest1);
+
+	jw_release(&obj1);
+	jw_release(&arr1);
 }
 
 static char *expect_inline1 =
@@ -313,6 +319,9 @@ static void make_mixed1(int pretty)
 		jw_object_sub_jw(&mixed1, "arr1", &arr1);
 	}
 	jw_end(&mixed1);
+
+	jw_release(&obj1);
+	jw_release(&arr1);
 }
 
 static void cmp(const char *test, const struct json_writer *jw, const char *exp)
@@ -325,8 +334,8 @@ static void cmp(const char *test, const struct json_writer *jw, const char *exp)
 	exit(1);
 }
 
-#define t(v) do { make_##v(0); cmp(#v, &v, expect_##v); } while (0)
-#define p(v) do { make_##v(1); cmp(#v, &v, pretty_##v); } while (0)
+#define t(v) do { make_##v(0); cmp(#v, &v, expect_##v); jw_release(&v); } while (0)
+#define p(v) do { make_##v(1); cmp(#v, &v, pretty_##v); jw_release(&v); } while (0)
 
 /*
  * Run some basic regression tests with some known patterns.
@@ -381,7 +390,6 @@ static int unit_tests(void)
 
 	/* mixed forms */
 	t(mixed1);
-	jw_init(&mixed1);
 	p(mixed1);
 
 	return 0;
@@ -544,7 +552,7 @@ static int scripted(void)
 
 	printf("%s\n", jw.json.buf);
 
-	strbuf_release(&jw.json);
+	jw_release(&jw);
 	return 0;
 }
 
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index 3b0c336b38e..19a730c29ed 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test json-writer JSON generation'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'unit test of json-writer routines' '
-- 
2.37.0.874.g7d3439f13c4

