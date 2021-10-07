Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9183C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2B56103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhJGKDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbhJGKDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0AC061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i12so4706956wrb.7
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlCgU/+Frw7bDLoWbF42QwVh6eVg/dySfZWR2m3lXhg=;
        b=n1kWlS0PagOnV6mS3H3hEj05b0kf6TlBwElpWd+BhOv7WbxddwAMVyIQbT4/+NAO/m
         YBnuwwQwl5Saabh/JJrt+t3zRwsVcU0MhzUcwINqxy4eekA/oFn6QhiDAnWrSvuxLURx
         hKWh90hN8h/FFwOP1Aqbq0g0TsDINfgmuKLRzg3OX6z9upV7npS98TdcgKiEOUq8PS6S
         G2xUUfhHfWqe9swD9amoLjUpG8rT+H/b8uCFvHTpNYCXQF7MX6Du3+oPCsuJrRDIa3Of
         j4acPLeg95xwYMXkVXtu7DlrqLdoXzhSimB2w0CXxcmTcjTGQ3RK2fw7h70cN7jt32fp
         PGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlCgU/+Frw7bDLoWbF42QwVh6eVg/dySfZWR2m3lXhg=;
        b=s5iCWpJi60E2L9tU4hXJZnyMs3pzqCnaXb6GK4FOOodGnhb3HD9z2SYlHcND7DzUSh
         wRlvR1oIMDZBZyWroAXpGQAPaQifnoVUw4CXINKmJtZgL1mHEzr0zKZh0ZD7TkHBqqon
         aAUATz5kYhQPBEUzOeHRYRHsyXz2VeBCejEju18eFC0cK9KJWNtE3Wl4LCszqpwjxhMM
         hW4hj6SeaveBAsW8dJy38feVB7iXJoreBbOX/U172vLpn3ksCQzQVXtfllh16S5MiCVO
         k06FpHF5vGGt6Z3WzwOOklWM8EYyb2MjLMeCGqYmjM8YPQfukuz1s4rV8IhABGI6h+wJ
         hiHQ==
X-Gm-Message-State: AOAM533L8tkaQHoX9R3pfuWJF9M+0Hw2MggzPjcpxGibYoYewVTpisdN
        5CAhbfm7B9qKH5Mf6gLv87D9+eXRsbMKWg==
X-Google-Smtp-Source: ABdhPJziDDMHpr5oUf/D/xkcjMojVNGHXnHaNEqdEFTFRIU8EAOwBYR/SsJUs+vVuYus3DZjsPbT6A==
X-Received: by 2002:adf:f486:: with SMTP id l6mr4012813wro.375.1633600906670;
        Thu, 07 Oct 2021 03:01:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] tests: fix a memory leak in test-parse-options.c
Date:   Thu,  7 Oct 2021 12:01:32 +0200
Message-Id: <patch-v2-2.7-53b0da60804-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in t/helper/test-parse-options.c, we were not
freeing the allocated "struct string_list" or its items. Let's move
the declaration of the "list" variable into the cmd__parse_options()
and release it at the end.

In c8ba1639165 (parse-options: add OPT_STRING_LIST helper, 2011-06-09)
the "list" variable was added, and later on in
c8ba1639165 (parse-options: add OPT_STRING_LIST helper, 2011-06-09)
the "expect" was added.

The "list" variable was last touched in 2721ce21e43 (use string_list
initializer consistently, 2016-06-13), but it was still left at the
static scope, it's better to move it to the function for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-parse-options.c | 7 ++++++-
 t/t0040-parse-options.sh      | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index a282b6ff13e..48d3cf6692d 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -14,7 +14,6 @@ static int dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
-static struct string_list list = STRING_LIST_INIT_NODUP;
 
 static struct {
 	int called;
@@ -107,6 +106,8 @@ int cmd__parse_options(int argc, const char **argv)
 		NULL
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
 		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
@@ -185,5 +186,9 @@ int cmd__parse_options(int argc, const char **argv)
 	for (i = 0; i < argc; i++)
 		show(&expect, &ret, "arg %02d: %s", i, argv[i]);
 
+	expect.strdup_strings = 1;
+	string_list_clear(&expect, 0);
+	string_list_clear(&list, 0);
+
 	return ret;
 }
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index da310ed29b1..ed422a1a616 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -5,6 +5,7 @@
 
 test_description='our own option parser'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<\EOF
-- 
2.33.0.1446.g6af949f83bd

