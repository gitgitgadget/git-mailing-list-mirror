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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D5C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46A661352
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhDLLJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbhDLLJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DCFC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so8740665wrt.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAJszAaQO87MJV7zOk0rTBrz8wCQ47q4yvccsO6MsD8=;
        b=QaTIg4MhBISqFYa6dpD0q7bXl5I3EaztU+iKY9FfvLIv5KYH5vFwOeUhkUpTEeXfYb
         LqPAnSVHU/pY39yI84bsHKwhdpRwGI8QF/6ws98RiO8jx1GPlx6+svHhBMhk3tAm5yi8
         r97/OLBnqr0VK/C5wNQbxsDIhD7YpcOKySyCpi+2KRDpOWjOnLSFMorycTkoeSIwz4x9
         y29zrlvL1+UfweCrPdqMIKoIUlm4p0Y8dnKMlz4QX0yMdQgyjfa4bVTCR7k7YT/E/h7/
         sQm0QM5uP+cQVsqRxTsQ1KYsaPDpv/PK9/PnrzEvkto/9Hbpm1JhWQR85I5CO9CHY1CF
         wO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAJszAaQO87MJV7zOk0rTBrz8wCQ47q4yvccsO6MsD8=;
        b=jXWIFutcgbG9QEh8t1l7VTNrUVnFQPONORyqFuJd51IJtqACxBu9EvNcCzGw6dr6ts
         q9MYKySKgZ4LnDEHhosAh3lmtNkjFOSmGEoCse4Reofh6pHcg2uP6Qk+hx8+oZsSsFLf
         BIKfFlW5/l+if8fxCQT6gk/xDmiCV7GBUh5eN2FbUeDiwvGjS32WtLPDVLPMvEydzehM
         kUqCKuJMkx/EOttzWdhrmUy87p0o8mXqmS8cLkebV/edXCyjd/1sXWg/OlUKiVSxNQhp
         Hr94aMEH9NzB8TCpWbDNozPGAxsRqh4/b1iG7f3vqZi3CGhfItY2Q/ovWDtKUrGukWIA
         l5kA==
X-Gm-Message-State: AOAM5310ZoniFBWEBwUcZb/4qBM1fzsczIPcPQUV7BTdQZD4hC1AzHJu
        7St8HcxglSSzTVZRCb6Md2OO6AnGjYXwmA==
X-Google-Smtp-Source: ABdhPJwoyyqC4q4n4FMfr6vKREqL/HROD9vWnXCvvhwfPGh9EVV1u7RVZRRAgtGgOcmFsLOwj48FdQ==
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr31523867wri.349.1618225757364;
        Mon, 12 Apr 2021 04:09:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/16] submodule tests: use symbolic-ref --short to discover branch name
Date:   Mon, 12 Apr 2021 13:08:58 +0200
Message-Id: <patch-09.16-e7432294215-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a use of $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME added in
704fed9ea22 (tests: start moving to a different default main branch
name, 2020-10-23) to simply discover the initial branch name of a
repository set up in this function with "symbolic-ref --short".

That's something done in another test in 704fed9ea22, so doing it like
this seems like an omission, or rather an overly eager
search/replacement instead of fixing the test logic.

There are only three uses of the GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
variable in the test suite, this gets rid of one of those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 4b714e93083..f7c7df0ca42 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -63,6 +63,7 @@ create_lib_submodule_repo () {
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
+		branch=$(git symbolic-ref --short HEAD) &&
 		echo "expect" >>.gitignore &&
 		echo "actual" >>.gitignore &&
 		echo "x" >file1 &&
@@ -144,7 +145,7 @@ create_lib_submodule_repo () {
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
 
-		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
+		git checkout "$branch"
 	)
 }
 
-- 
2.31.1.634.gb41287a30b0

