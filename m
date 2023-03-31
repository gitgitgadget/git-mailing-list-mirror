Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84127C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjCaOgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjCaOgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 10:36:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C02112
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 07:36:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i5so90649896eda.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680273367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNHsVwxNim+XpsphhYeURsYRwWICi68Fh+dzJntucDw=;
        b=QX3pRUxYVwFMAGTriGaVB96cBkNIwCOV7E3jZAF72QcoJZzn5zRtAYVGwsU18AV1/f
         3S1R3M0kIe3ogSrxOwxJf8Plnb7/enaOUR2H/Nzo/DbXkEBTjoxo6yktMr8Qwt4lfkoM
         QCcHuvZ30sAicuQYeg/WfXI2ue8eeeQr8XfMFOxG1DTWTemAAITWCcjGByfupHuKR6pT
         yN2qU196UFhqNlpoAXNOHq7ee+1a9aQdj1lnxxl0VQ1uQbdlIzXOeY0619UJweekC69z
         wFNLdRhpq8B/V2inx0M/1K3gu+6Fh2ROV7J9uoC6Wwvux9IrFa4/g7VTxtrM+mXBzHtW
         Nu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680273367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNHsVwxNim+XpsphhYeURsYRwWICi68Fh+dzJntucDw=;
        b=mxTGGjGiWFxDpatibwjQiHaEkCGlPONsIHH2JkjKL+S4bnaGKYaAvxlX0vqYg3hAaA
         NZcFQoK9bthwaCJtyt9PfgMajlqZIbneYItQQQO2GjqTpTgKboapxCkwiFZWBZFedsIr
         FZas9Ux1jkGnzXgVo4wRYkY1NH6fu8iIJy4nJmzRk8RCieRKJ5NlTk+Qoj/B+TLlSiLK
         2HXOYgQE47rrlA9p5EF45B/IMl5kg8PpCKDP7VuFkU/nb6GpmP+V/vhTE/AKt/yHMpBz
         fXGtJ/kQXpzM2168efq2HXyBnfEzXGNhDi9E/mADFJZ1qRGWKyAtSJgvBkthUpDlph9T
         Hg1A==
X-Gm-Message-State: AAQBX9cRk5mLRc0oqeE5RmL+3oQnuR96hSMk6byaWVzXeKLB8xXmt8Yp
        57VGHeb1dEfL80QSrNeOZlH395vKZGDiin3N
X-Google-Smtp-Source: AKy350Yp5Yg3Pn/NmrbxbopYIWq/mWlC7edEvTeCpkGzCOyZcm4aNIKmq/p5ORmxp6yXofFK2dn8RA==
X-Received: by 2002:a05:6402:1055:b0:501:d190:b362 with SMTP id e21-20020a056402105500b00501d190b362mr25263919edu.27.1680273366955;
        Fri, 31 Mar 2023 07:36:06 -0700 (PDT)
Received: from titov.fritz.box ([45.88.97.21])
        by smtp.gmail.com with ESMTPSA id h27-20020a50cddb000000b004c19f1891fasm1114353edj.59.2023.03.31.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 07:36:06 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliams.eng@gmail.com>,
        Carl Worth <cworth@cworth.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] t2107: fix mention of the_index.cache_changed
Date:   Fri, 31 Mar 2023 16:36:04 +0200
Message-Id: <20230331143604.82040-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331143604.82040-1-rybak.a.v@gmail.com>
References: <20230331143604.82040-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit [1] added a test to t2107-update-index-basic.sh with a comment
that mentions macro "active_cache_changed".  Later in [2], the macro was
removed and its usage in function cmd_update_index in file
builtin/update-index.c was replaced with "the_index.cache_changed".

Fix the outdated comment in file t2107-update-index-basic.sh.

[1] fa137f67a4 (lockfile.c: store absolute path, 2014-11-02)
[2] dc594180d9 (cocci & cache.h: apply variable section of "pending"
    index-compatibility, 2022-11-19)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t2107-update-index-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Found this by while investigating the root cause for the first patch in this
series.

diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 07e6de84e6..89b285fa3a 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -83,7 +83,7 @@ test_expect_success '.lock files cleaned up' '
 	cd repo &&
 	git config core.worktree ../../worktree &&
 	# --refresh triggers late setup_work_tree,
-	# active_cache_changed is zero, rollback_lock_file fails
+	# the_index.cache_changed is zero, rollback_lock_file fails
 	git update-index --refresh --verbose >out &&
 	test_must_be_empty out &&
 	! test -f .git/index.lock
-- 
2.40.0

