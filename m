Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD127C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392259AbiDUURf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392289AbiDUURd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:17:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629A3ED04
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv16so8143822wrb.9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGTBEKBV6o8C90oxiV5WDqxa80vdz5MKTnYUG/Y7cXA=;
        b=YmrmMroWO0fBlpbJWTGpJ3HimzgotBR12YpoIxLhO1qdw4ziJGsS7hUfh5fsMA/Usj
         vhahyTgXdJTZO5L1FQYZhPsnhU5dJS30iIQD1G72tIjqwYhzcEfKnGpiBX240jpccqdL
         oP2qRMgmH7hySu9PwXI5+loiTz8NGWRAf7Q48oA1TRe5KWBWMEVq/eKaSGt3ZTaYyslK
         rrPgbNp9RUK6aa3CF8wnpT6w1f4kvrYOwA3kLH0BGWKq9X7gIOKGYTGB+En1p46PJvCw
         W+drxHj+sEsFz8T/1Ept/bPcI3+QIU2Swo7lMbxF7kmZhzJtsj2Pc93FY35xQAYChO5P
         qUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGTBEKBV6o8C90oxiV5WDqxa80vdz5MKTnYUG/Y7cXA=;
        b=bnKoESwdaC/pmGMWORNytRNiJDw84RyUXESjUg1Uy1LmOVL34ZOn3rZ5Ld6RHlHIpD
         KjxBZU+EJBhEaYEyIzLVSmUBKaPKAVhQRKd4kC4XTCns6FeIeAtj65UfzTegPLO89Wx1
         CoAZE24E7AIZTd5wJjzAwDs/m0ZQzL/7p3GJqjDoxoGHyDDTIgjj23YYzlVhL4tCh7JV
         Xh3MV406WyWd+G15CRDQb0IvG0jEPXWWKlJ57qme2JPalBwtcM/z4BAjWISbphlSHlJR
         8FIgQ8tJWJzR9N3y7pIqaXJLSd7DnXvkPr6n0iWS3bjaNpXNpFWLZAwe4UXcmvgUbfYl
         bVSw==
X-Gm-Message-State: AOAM532cuCjnRRyIFLuo/Pd5od0fg4E4A8k4cf9IsX7yO7BOo2LiOuCA
        00hs4eEABUG2oqtDV1e62ASdhioinrDHVA==
X-Google-Smtp-Source: ABdhPJySm786BKN2o4Ur9iIZnqexdk2yVAPpLuQeMkgyeRWwIe6Ip5b716ODX5VX6fbpEYuooQN7lA==
X-Received: by 2002:a05:6000:1686:b0:20a:96e0:9bbe with SMTP id y6-20020a056000168600b0020a96e09bbemr959185wrd.635.1650572080571;
        Thu, 21 Apr 2022 13:14:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0038eb8171fa5sm1309wme.1.2022.04.21.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:14:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] tests: make RUNTIME_PREFIX compatible with --valgrind
Date:   Thu, 21 Apr 2022 22:14:34 +0200
Message-Id: <patch-1.4-315da7c2df0-20220421T200733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.gd068ac2c328
In-Reply-To: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in b7d11a0f5d2 (tests: exercise the RUNTIME_PREFIX
feature, 2021-07-24) where tests that want to set up and test a "git"
wrapper in $PATH conflicted with the t/bin/valgrind wrapper(s) doing
the same.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0060-path-utils.sh | 4 ++--
 t/test-lib.sh         | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 2fe6ae6a4e5..aa35350b6f3 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -542,7 +542,7 @@ test_lazy_prereq CAN_EXEC_IN_PWD '
 	./git rev-parse
 '
 
-test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
+test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
 	mkdir -p pretend/bin pretend/libexec/git-core &&
 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
 	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
@@ -550,7 +550,7 @@ test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
 	echo HERE >expect &&
 	test_cmp expect actual'
 
-test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
+test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
 	mkdir -p pretend/bin &&
 	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	git config yes.path "%(prefix)/yes" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 531cef097db..7f3d323e937 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1666,6 +1666,7 @@ test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
+test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.36.0.879.gd068ac2c328

