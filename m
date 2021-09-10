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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BCBC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A4261074
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhIJPj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhIJPj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:39:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B020C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b6so3198393wrh.10
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6WkR4S5ppbcK0cjmDboEU+VUIfjy1zwze+1m0pjX0o=;
        b=IiSSf63Hn2zYpUihTyuCygokT7+j80qREXJYGYlHaCbW+ESoRNOjJ/YJcQH3Yhc24T
         ceOIA4uRzA9gZV0JB3tsy1oA7XCkwUF9A5oJPBRNOkF2CeSs7/aOOMmtJr8ii3LPHMj6
         4fz19zUUg3N5btU0ym9qCkGQBFqFBm7g8hjAP+c9Juyf6ujjjp9PDYAFrZBZ2g+bpG1l
         +Ov1spKg/pJjXSq6yWGeR3eRjLRKjAJ0WF/fzEsl6EPOr/GFailXJ0r3zldRbu54LTQn
         IYMHSfmpbDD+vOCRjTUIXgaSfL5NH4+Xd+PQ/0kJb/7vsBZFsTaOjxykVI0QVuEn2XGJ
         /NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6WkR4S5ppbcK0cjmDboEU+VUIfjy1zwze+1m0pjX0o=;
        b=D0PvNCgoQeBRn/TsK7s8ZD2uLqTsmv3loQgCi/TFbEcYx1DQgJw+mGWDcHD6sqGaPg
         l+e+HiWRBRZwc3HoROawWIl/gc+WRPSJF1ligfcNoJW2F4tcWNrGnQtCj5OnqZLaUoq3
         eU5vlNutzbCNVZ4YFsSKHUr3VKpNsDJ0DhKVrVLOJa1LoBB8UOZe2NyRpD7niMmYhpi9
         m6XC+iWsvRnrM6AxZ+ShzRpgSrl1Tao6z2eH34iSDDIE5TiUee/KXxiKr0Jt9WZ4oLx+
         /EEEWMxF7BhSGax0hFKDk3avjKLfmiLdHiPI60eA5lxl3qjzzjeJAMji3KFiEwXqF/4C
         dElA==
X-Gm-Message-State: AOAM530q6yCsYs2oTu49feMKImk0Tqzc+OC9UY8lvq6LLocD39HQDFK+
        yQqiifj53kpiY2FhYoUXr+FP2K5zsdNFRA==
X-Google-Smtp-Source: ABdhPJxjp6qBS22+rtBITjEQ3EpjKaM9dHuZ0xTzdWVCUSqYsjL87jjM0+akfsqVV8Hu8SNsA80XGw==
X-Received: by 2002:a05:6000:1b02:: with SMTP id f2mr9211595wrz.218.1631288324970;
        Fri, 10 Sep 2021 08:38:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i5sm4181972wmq.17.2021.09.10.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:38:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] test-lib.sh: add a UNIX_SOCKETS prerequisite
Date:   Fri, 10 Sep 2021 17:38:31 +0200
Message-Id: <patch-v2-1.6-9e8facb6f8c-20210910T153147Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.876.g423ac861752
In-Reply-To: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of checking $NO_UNIX_SOCKETS directly in
t/t0301-credential-cache.sh, follow the more common pattern of
creating a test prerequisite in test-lib.sh.

See 6320358e31d (Makefile: unix sockets may not available on some
platforms, 2011-12-12) for the original implementation of
NO_UNIX_SOCKETS.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0301-credential-cache.sh | 5 +++--
 t/test-lib.sh               | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index ebd5fa5249c..002de427984 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -4,10 +4,11 @@ test_description='credential-cache tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
-test -z "$NO_UNIX_SOCKETS" || {
+if ! test_have_prereq UNIX_SOCKETS
+then
 	skip_all='skipping credential-cache tests, unix sockets not available'
 	test_done
-}
+fi
 
 # don't leave a stale daemon running
 test_atexit 'git credential-cache exit'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d61..583f266b1e8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1533,6 +1533,7 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -z "$NO_UNIX_SOCKETS" && test_set_prereq UNIX_SOCKETS
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.33.0.876.g423ac861752

