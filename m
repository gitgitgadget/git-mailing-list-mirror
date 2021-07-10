Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03648C07E9C
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82F9613BE
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhGJNkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhGJNkU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA50C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d12so15872096wre.13
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTnt6aosZv4I1xd0MnkZClCVAvdXvk6HnGgTKFePhko=;
        b=fUijFGNFcWTpKZu4IoNgHlJJzb/mvxe2QV5Ku2RtEPXDWSdfJSbxfSwFYCJRypSGj7
         /Ua9pSUQ4P2ULTIZ5GlICwVpNG/zx+kZsnNZsNLJ/DrxaEmrbSrty9s497AICSez9Kuk
         t975wFS1M44fRM6dO6bfy9LyJmQQ5CRnCtZJzPpCiz1DP4L8rdAaKhzh0Izt0DIvizZj
         n7tviM+k0mL1eJjr+v39LoBuTen0RN0oswFiDPbp6L1SrMyvyhhLhwO8Ce0yM9lgM2kS
         inVnHVti1dgmcRPn/4vZ4REbQmAWyPUaXj0tiAcVApt2sKeNH/0ym0TayrGAYhakX6jg
         m1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTnt6aosZv4I1xd0MnkZClCVAvdXvk6HnGgTKFePhko=;
        b=iMZLPGJBAScp/7tCG+9WDQnSOlrfur6oFDAfqlBz7upR7VPlSZ0op3iS+NvgnGOGla
         DlwOmiH/fWnqh5F8WylUj961EnnNbjKflgqtE0XDvQT+IgItoJAGrL+3ZuENjFINX0qK
         GVJV+kHjkyG1cd7Z8VGqM+qZfwhP2QqZDL5AGhabjoCA4605nUjDpZhQnCFaW8Vj43nY
         RUb+fkXLeK282vx2dmAyfDmWBUtG+cJQNd4HSHVI+wEcAli8NMB7o/+jq2oMMY8F4E6B
         m11LDqbBhWykpKNcqym1uxlCBUK9Odd94nHNl+wST7TfXf+ZUvEWuX4yrcUM9ECCh1zX
         3/qQ==
X-Gm-Message-State: AOAM533Xz61avutqHAvaSUlt0t98wSwoNWxQ895T/qspLqT0T+rKsbj/
        tsZcmEW7BGraYxYFXbRfoPyxQmfJ4mM4Gw==
X-Google-Smtp-Source: ABdhPJyUZAV/43CZ84K4/YJ3RqYgbjZw4SzhoPxji7RVV0o/+aDNJIkat8eSs/CYiNhuFW8AS/9Zpw==
X-Received: by 2002:adf:f90d:: with SMTP id b13mr38364099wrr.336.1625924252393;
        Sat, 10 Jul 2021 06:37:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/21] cat-file tests: test for missing object with -t and -s
Date:   Sat, 10 Jul 2021 15:37:06 +0200
Message-Id: <patch-03.21-ce9dcc423e9-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
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
index 5d2dc99b74a..b71ef94329e 100755
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
2.32.0.636.g43e71d69cff

