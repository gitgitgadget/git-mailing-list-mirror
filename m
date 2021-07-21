Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66038C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466776100C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhGUXNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGUXM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:12:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72AC061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:53:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f9so3907192wrq.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBxfJcHKw2setVP4By4RlQM9dPHcsJ6K/KzH/awlUwE=;
        b=Btf3RYmYBMAdGziBIw6u9+qzK48DAuMSelDDo8omt9/oscjnaRRKzzbvgNcF4vT5G7
         W5BynCh8UI4X3AbqG6R+V9Oj/m9+B4IKa/1rXnpRmBw2rarpRFRYJBN+k89OrRzVjBwS
         qo6KRsFSE2ZBzHNBEwbTf11opoajm8VG482Si/7jNV/UPg6pBmZqZHZptMBcKwzOlwTJ
         xU2ffTbM1NY4AtpNZk3tLI0u5aoCA+e7yTfghSDNobaOgiRzf61CIEaKku4xWXDLpqmh
         eGXFdDgNEkdLoU0NFqFjmoOUzJs3fTGMy5xNlk+nKELHYiLRsAvV7HpO+RqwczBE78th
         d55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBxfJcHKw2setVP4By4RlQM9dPHcsJ6K/KzH/awlUwE=;
        b=dqhkJGtKyjjDcjGOGYcJzi/kbuV+VJrXdEWl1DRiKaujyTD8fW16ephuVKhge2TkTY
         LFzbDZYlP7OoD7LvwQJjPA3XNqzYT593qYehNlxfrveS4NVyQgVF7NbB+DIYjk6Xrt/q
         wmRzRYFOE7vmOuJteWE2ape8NEZcoVe2iK669jUJAy/jkLn6w3ZHiFWIAH4aH5YAEQSu
         zXpQGALXeWYeYlWU6GXekXGKP71yqJ/dvNvilrtJZOW06/DhvH88pFpHpZNC1Hb9coa3
         YsH8Dr1amV+NgzyTQFCISmFJ9XNX2kc6wL+0weLfVAU95fPFR7VCSUMWmleZfPDdSOIR
         8FEw==
X-Gm-Message-State: AOAM5318baLPEvXkR1V7ApzIQ7wEjjwAW+ZhpwldB256J+jH5QcEf15+
        Dvf+9RehFGZYHdfkWwCsnUirvWJD6/WMNg==
X-Google-Smtp-Source: ABdhPJwwsM2ws3iBsvNBCdFdW6zFJV6KjJT/p7sI52mG6Qe/IWT7UAdeOzukwsffBBpGw+WQg7exJw==
X-Received: by 2002:adf:a31d:: with SMTP id c29mr6871556wrb.344.1626911613031;
        Wed, 21 Jul 2021 16:53:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm11342674wmc.12.2021.07.21.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:53:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] bundle tests: use ">file" not ": >file"
Date:   Thu, 22 Jul 2021 01:53:28 +0200
Message-Id: <patch-1.2-2a77f80725d-20210721T235251Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com> <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change uses of ":" on the LHS of a ">" to the more commonly used
">file" pattern in t/t5607-clone-bundle.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5607-clone-bundle.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index f4c383cd5ce..c9323a08fe8 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -54,14 +54,14 @@ test_expect_success 'bundle --stdin <rev-list options>' '
 '
 
 test_expect_success 'empty bundle file is rejected' '
-	: >empty-bundle &&
+	>empty-bundle &&
 	test_must_fail git fetch empty-bundle
 '
 
 # This triggers a bug in older versions where the resulting line (with
 # --pretty=oneline) was longer than a 1024-char buffer.
 test_expect_success 'ridiculously long subject in boundary' '
-	: >file4 &&
+	>file4 &&
 	test_tick &&
 	git add file4 &&
 	printf "%01200d\n" 0 | git commit -F - &&
@@ -75,7 +75,7 @@ test_expect_success 'ridiculously long subject in boundary' '
 '
 
 test_expect_success 'prerequisites with an empty commit message' '
-	: >file1 &&
+	>file1 &&
 	git add file1 &&
 	test_tick &&
 	git commit --allow-empty-message -m "" &&
-- 
2.32.0.955.ge7c5360f7e7

