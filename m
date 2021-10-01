Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B9C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA8261A05
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352873AbhJAJS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352918AbhJAJSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA24C06177D
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m14-20020a05600c3b0e00b0030d4dffd04fso955088wms.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71yTilJ2DAeNlCYObfyVNUHcZ9Bkfy3rE0g6g38iEgY=;
        b=EnfYhaA5ulHnwKyUpg/MS+RImd6uhaWBiQQC87UpipnyjyQP67y7obxD7w4MMO09PS
         omQBTgpJyUO6OoI2b4scQSXwPrilD504Vwe9G4UYDmC0XM3QRkdTxfGTWIr8ANewkvq+
         m4ouVypDxgHJ62NUOOuYWSgEgY3+jbrwfqPuE0PKWP8WgpXCo7hgDcYmYZRp09yEUcvv
         mMiZc9JtajJfxuQsIC3A4VS4ES3mjeEXrD853UhWYcxaRPjiibdvT/menxrVVklLAv3m
         4o9JrZYdbYgrKWkwjWEEBwf+2IiEZXfSZfZt+8qJ1SHmQpNyIF2xqGfd+aFrn/BeUarS
         jr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71yTilJ2DAeNlCYObfyVNUHcZ9Bkfy3rE0g6g38iEgY=;
        b=xYwyQayvhUvsmHdY2UaSZdRkYE8CozMwmVuIJVn/n8znk9UwaJg9Lk/yIiLEYB7trT
         NjAPg4ESDHJeSE1IGdquF5jnxWTsXuTlBJKuqNI3W7+BbcEXHY2LeC1Grkz+wVGtsOsy
         xeZyEHicwvBYOVhp5axJSij2xLBuhe6WjORQi9Du/TRfC6kBLQSzvZjqTB86E/EnCHPe
         j3eU4OjOncE+vdyPSpLNAHY+nlYvJhl+OzZ16vDZ/sg/27JDSx92aspzj4YkNEMEjv5B
         g97CISUhz84USgmPPThG5/0GMl79vEHfc6guykVWqAoLjqWzLDmeLhnNDSZTPS2XY8TK
         WnfQ==
X-Gm-Message-State: AOAM531uKj2Y6QrSluYg9FRowzurJQVkpj3ksN+qfGNXWb4OclS441K3
        +Txp3+Me0SxvlCMOJenDFFAHpj15S4aV3Q==
X-Google-Smtp-Source: ABdhPJxq3rrE/sydya9mlvIEMqewm3fbYzp9u3vxwdEEYF6826Ea51rg2W9BZWz00KRPw/2VK68Oxg==
X-Received: by 2002:a1c:3b86:: with SMTP id i128mr3360349wma.132.1633079821877;
        Fri, 01 Oct 2021 02:17:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 05/17] cat-file tests: move bogus_* variable declarations earlier
Date:   Fri,  1 Oct 2021 11:16:41 +0200
Message-Id: <patch-v10-05.17-7a63d30aef3-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the short/long bogus bogus object type variables into a form
where the two sets can be used concurrently. This'll be used by
subsequently added tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18b3779ccb6..ea6a53d425b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,36 +315,39 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
-bogus_type="bogus"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
+test_expect_success 'setup bogus data' '
+	bogus_short_type="bogus" &&
+	bogus_short_content="bogus" &&
+	bogus_short_size=$(strlen "$bogus_short_content") &&
+	bogus_short_sha1=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
+
+	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
+	bogus_long_content="bogus" &&
+	bogus_long_size=$(strlen "$bogus_long_content") &&
+	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
+'
 
 test_expect_success "Type of broken object is correct" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of broken object is correct" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
-bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
 test_expect_success "Type of broken object is correct when type is large" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of large broken object is correct when type is large" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
-- 
2.33.0.1375.g5eed55aa1b5

