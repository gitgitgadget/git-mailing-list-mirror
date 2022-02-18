Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77249C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiBRUxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:53:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:53:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38964ADFEE
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:53:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so16546796wra.0
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ti/2GYuAnFJypz7iedHncZinJDu9L4SBjXiQeTQLKY4=;
        b=So0RP1kv5rc0xL02Y1X25RuVF9TcOlGkhSyG5SofMeZDKyrQ4UwccE+AWgg/Iug+sp
         D/F5cXtbtXwp2cT+q05pPaLEpAGJAnQqafMTofV5925FtJndAp9WrmKCk0l26TqPeAHC
         Y5MJuEPknxgp4PSNd4eqYPXWqIfLwosmF3zWSbXRTEGJIAjwsOfftDqn64JjQVQ/e8mI
         QYvW3Td0spqcrw9QFTnW1oBFFalMSbJfvYF3fu0O8aXcC/jVnctmETT8J1E7tw+6xFHz
         ZK/ZcqNhBTpce0M8BPQRDj9hmJinpBtlnGccPU4W4EL/sNRmG83mzvzY61HCmTeJWbou
         ZkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ti/2GYuAnFJypz7iedHncZinJDu9L4SBjXiQeTQLKY4=;
        b=cwFDL+/2qMfd5QbzbkQaMlNTh6FnKrsDh2onLdFGWppjtXDp+msC4NW3IjxlO/jy/i
         JzJRjN+tDB3d7azdsOylRpJfMoqLWq+tOQJdg1nUFyKiLg6CD7mBnwMLQ86rs3UTU3re
         30fBKZKfFh3aw5fkVSZGv1oFGYLxiBbq9gBirCnx2orzRU5oLTcjRJY4BD0n6FEd3rWd
         bhiV97hPeons4qt9BqGYaHJ9Pb+TjUV61XeHc3OBiWfCXWsUJk9UxEu/MjNQHCBS0eOy
         uwfsuCa3cKnisTNOo+c5S2xyO1m6vbb1d/QeUjzuuPWzibR92BmiWb81yWkdiBUWkt3w
         H5BQ==
X-Gm-Message-State: AOAM533YaP0wccODKpBcqvqDbf5GxELDxqK3W1M/hmEOYgI6ulw0jauS
        UbUt05+MU7en+gEcNsQ4WFnCjyH5bErD9w==
X-Google-Smtp-Source: ABdhPJx55eXfPWp6fA3GfMxrA6h6+tw7Ux1hgeeU3kYigK5mqb/XqADSjzXHfj6q2LvlhbMzf+uP7A==
X-Received: by 2002:adf:a195:0:b0:1e6:295e:54dc with SMTP id u21-20020adfa195000000b001e6295e54dcmr7223995wru.103.1645217585569;
        Fri, 18 Feb 2022 12:53:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm36076143wrr.94.2022.02.18.12.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:53:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] hook tests: use a modern style for "pre-push" tests
Date:   Fri, 18 Feb 2022 21:52:59 +0100
Message-Id: <patch-2.2-8035594be8b-20220218T204719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
In-Reply-To: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>
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
index 47f6eb509d6..96d6ecc0af7 100755
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
2.35.1.1031.g277d4562d2e

