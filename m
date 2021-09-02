Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA89CC4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7434610E5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbhIBNOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbhIBNNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35208C061796
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1323976wmi.5
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31NTqck4jecsTTDFZgv2PY1Imf9TS1NITPfBxfYfyaM=;
        b=Af+fGvnGpZCXq5nXD4EL0mPt1UJRr58i8LL3c3NaC6uFS+Bf7xq2Utw0Eel2lmSMQ1
         XtfncfBjIWdmmwC/vK/xdSxnVbdssmQLTGySWrs1fZKDIP1V8alAXDy0uDWlfrpzuSTW
         AC5HsIM4iWrmMwaW6gLwuZRdj9yjI1+8G+s349alSRq6gQZTUZz/xg6BZHYtOVNd2d8h
         0tuubSGQfFdoqFk71siSy9XH+Ii5JGRmnv+v8sz3xFyZUb4ZNgR+7XfpRD/IBcL5U47k
         9dXQPr7kM9oRpaKkpwfoXFnYw3z629FuzFr7So5XU4SUPmvdRwxfLXzuaMPBd6Yexzvw
         yIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31NTqck4jecsTTDFZgv2PY1Imf9TS1NITPfBxfYfyaM=;
        b=r5RbbmzTyFltJ4uqQoHxJfIG59RvSZ1Ir7k7w3jxcRpx2a8Xc5QQT6dQJhOHb+4WKv
         KcQ+IAqSAXpYxkV57Wh6PEbi/AqR/htsi2dgPTD+juRo8i6OOmNYM5v/o2NjN0JUTDP+
         huWMbdE/Hs3xHTGIo60H1sqchoBAcRx6Vv4FhISd5iUwWdSSGWAKojBtK/t99q+H0Spv
         AOdSGNgVyhulXeNLmdQ60DB5Ls2UAMG+aXjGD+Rj99z53HdKLMzBIahcwr4XDM6J7US+
         A7PO79CNoWOBJWj/gS2YbFNex0llmKQIhuRvjQj5Yh+Fp0EIHyWXAM1NJz2TzZmmf1ej
         RLQA==
X-Gm-Message-State: AOAM531AYqCeLtyybV8tw6lli25xhBclZB+wJmtPxUyarlK4QC7dSpp5
        ysCRnvub3+doEYDxruLxw0Wr703yuu3tTA==
X-Google-Smtp-Source: ABdhPJyPW4u7e8/ojG89CHS3M2zKxIb4h0QZY6oZDSJj2tAIKfWPstPMmkVkx6aucrniiMGXs9ne4Q==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr3071365wmk.96.1630588335546;
        Thu, 02 Sep 2021 06:12:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 29/36] hook tests: use a modern style for "pre-push" tests
Date:   Thu,  2 Sep 2021 15:11:29 +0200
Message-Id: <patch-v5-29.36-88fe2621549-20210902T125111Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indent the here-docs and use "test_cmp" instead of "diff" in tests
added in ec55559f937 (push: Add support for pre-push hooks,
2013-01-13). Let's also use the more typical "expect" instead of
"expected" to be consistent with the rest of the test file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5571-pre-push-hook.sh | 71 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index d2857a6fbc0..cc1a3e23668 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -61,15 +61,15 @@ echo "$2" >>actual
 cat >>actual
 EOF
 
-cat >expected <<EOF
-parent1
-repo1
-refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
-EOF
-
 test_expect_success 'push with hook' '
+	cat >expect <<-EOF &&
+	parent1
+	repo1
+	refs/heads/main $COMMIT2 refs/heads/foreign $COMMIT1
+	EOF
+
 	git push parent1 main:foreign &&
-	diff expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'add a branch' '
@@ -80,49 +80,48 @@ test_expect_success 'add a branch' '
 COMMIT3="$(git rev-parse HEAD)"
 export COMMIT3
 
-cat >expected <<EOF
-parent1
-repo1
-refs/heads/other $COMMIT3 refs/heads/foreign $COMMIT2
-EOF
-
 test_expect_success 'push to default' '
+	cat >expect <<-EOF &&
+	parent1
+	repo1
+	refs/heads/other $COMMIT3 refs/heads/foreign $COMMIT2
+	EOF
 	git push &&
-	diff expected actual
+	test_cmp expect actual
 '
 
-cat >expected <<EOF
-parent1
-repo1
-refs/tags/one $COMMIT1 refs/tags/tag1 $ZERO_OID
-HEAD~ $COMMIT2 refs/heads/prev $ZERO_OID
-EOF
-
 test_expect_success 'push non-branches' '
+	cat >expect <<-EOF &&
+	parent1
+	repo1
+	refs/tags/one $COMMIT1 refs/tags/tag1 $ZERO_OID
+	HEAD~ $COMMIT2 refs/heads/prev $ZERO_OID
+	EOF
+
 	git push parent1 one:tag1 HEAD~:refs/heads/prev &&
-	diff expected actual
+	test_cmp expect actual
 '
 
-cat >expected <<EOF
-parent1
-repo1
-(delete) $ZERO_OID refs/heads/prev $COMMIT2
-EOF
-
 test_expect_success 'push delete' '
+	cat >expect <<-EOF &&
+	parent1
+	repo1
+	(delete) $ZERO_OID refs/heads/prev $COMMIT2
+	EOF
+
 	git push parent1 :prev &&
-	diff expected actual
+	test_cmp expect actual
 '
 
-cat >expected <<EOF
-repo1
-repo1
-HEAD $COMMIT3 refs/heads/other $ZERO_OID
-EOF
-
 test_expect_success 'push to URL' '
+	cat >expect <<-EOF &&
+	repo1
+	repo1
+	HEAD $COMMIT3 refs/heads/other $ZERO_OID
+	EOF
+
 	git push repo1 HEAD &&
-	diff expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'set up many-ref tests' '
-- 
2.33.0.816.g1ba32acadee

