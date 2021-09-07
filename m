Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE5C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC07160E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbhIGK7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343804AbhIGK7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C6C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1591179wme.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q00M4AtvtJU2iuLRc/A1xwyi5qwWrl9cgtEiDhBbJBY=;
        b=lDojtrYSSIO4TZQj7Ctfr3ai48Nw6OIEKp4KOe/Ad4Y/ayP5bUvEkFcC0Zalt1Y3g2
         iKvN9OrTQt3bAdZFXPyxeI957WXBFJ+82NEEu7Va4Yn9gdpF/kEx8SGOARLHvxrxp750
         GNTBClj+UAJL2vLzSqQaD0KniNqqK7veu5jBINaThlqZEhfnQAS82pndrNXngxQ5s+ov
         Pyw60CM1XuIzrpl6TAgovLk8saB0SqCsphBoad7MFXKjj0vU3gvY5pysp3ygylBYNoaw
         dx5bucRBV0gEjEWU1kV2Qf7B79qaIXKzd9IEGvPqgeZ5RWisSlmH1P+2hNZAofLDYyZa
         PvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q00M4AtvtJU2iuLRc/A1xwyi5qwWrl9cgtEiDhBbJBY=;
        b=gGC6NLi3dN/Dhoa6K2mcWktlLBRyWnC8xqJ3snqQWPsyIToMxVcqPpPXAZrXIIv/UI
         KBy6vd+q72gLAMe/8kH0nm2fE3hfh6cdukXbNlZFaPxBlVzsKQsOl1+EiXFB5xX9oO7R
         zvJqL2QlXCDO7J80VLOQSl+Jpc3xDYWveXmASfvyX+avj4BzL1T3oTlTkNXQO4oYyieL
         MDs4Q+TOXLvoxbZSUFx+kpbbhA9qw9EXGEV/dwLbMNz8QeOhapU4OP5FpeXxrQ+sr758
         vOEuNuW622Cg3D6p630Gx6IvQ107/tuGO2uzu023LEBs16mAypyT6TSM/l4TM4CSdZKR
         JPSg==
X-Gm-Message-State: AOAM5310r7jhVu5GVwq15ryUhAdgHAB53tc10AAyzeJ81WKJuuLo1PpU
        sVzEVlwWdV17YFgY/ImhsMxtBHFhr/VyOw==
X-Google-Smtp-Source: ABdhPJw+1tVE7UBr7+v6jnnM/D8sdghkNCbkEK4oW+Ti6bZFdl6XQSZiB3DWKsf/ULTscDHM0F8t7Q==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr3265763wmb.190.1631012306414;
        Tue, 07 Sep 2021 03:58:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/22] cat-file tests: test for missing object with -t and -s
Date:   Tue,  7 Sep 2021 12:57:58 +0200
Message-Id: <patch-v6-03.22-d442a309178-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test for what happens when the -t and -s flags are asked to operate on
a missing object, this extends tests added in 3e370f9faf0 (t1006: add
tests for git cat-file --allow-unknown-type, 2015-05-03). The -t and
-s flags are the only ones that can be combined with
--allow-unknown-type, so let's test with and without that flag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18b3779ccb6..3a7b138fe4e 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,6 +315,33 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+missing_oid=$(test_oid deadbeef)
+test_expect_success 'error on type of missing object' '
+	cat >expect.err <<-\EOF &&
+	fatal: git cat-file: could not get object info
+	EOF
+	test_must_fail git cat-file -t $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err &&
+
+	test_must_fail git cat-file -t --allow-unknown-type $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err
+'
+
+test_expect_success 'error on size of missing object' '
+	cat >expect.err <<-\EOF &&
+	fatal: git cat-file: could not get object info
+	EOF
+	test_must_fail git cat-file -s $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err &&
+
+	test_must_fail git cat-file -s --allow-unknown-type $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err
+'
+
 bogus_type="bogus"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
-- 
2.33.0.815.g21c7aaf6073

