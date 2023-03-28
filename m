Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58DC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjC1N7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjC1N7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124510E2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so4239626wmo.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI4Osjd+uHtRJh64rwyVOhjIAebtdHpt8zujQ6ro5Zk=;
        b=pH0ben2EBNllK8w3zbXeApPOn2SmfAM/0ZzyvPbHYsmNHFRHTccSbZEucJ3ZEutJs0
         PPv7s+6gs7auujV1+09LZDHebHf73CmWdVnNqAUKeeoi0hgyKeVRVaQ58ieAR/qL/Mv/
         iCZHxfznq5EmM/UQ7gmenX1/s+LU/qpyF8QyXsKFUc/ED3w0ZMwB/xVeWED21pBOk1mS
         9YY4rlGEAUi2t3QvfJrypMcKYdTpIC3NmYcz/BHpEbBgfZx7JDpyhkLH3QQVQIQDR4jA
         YY32AyFssmUanyMrXn7hnxfG01TjagZLNTigNRFqglpsK3XaypV+tDSrezD4Cto44PAl
         qBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI4Osjd+uHtRJh64rwyVOhjIAebtdHpt8zujQ6ro5Zk=;
        b=4CeiQK0Bq0pho3ZZV7oqd5GKG2f22/IOs5YfIKKHpbtyLS/iD/kZnLXPupjCU5z/XO
         mYe5pcvsVGhXTq2bOfFqwZz44rKxreAn69f7095rtNEi625E6/M5EkHfXwuv3J/4VjoP
         jxBE67EDuU0rlEVGNbR5//ySIxTDSvWEfjOnkNjZiYgsyimKUk97r2PMskrrCUXsar5P
         9o9kB7YAsp6vsBkLfBQaXH/Q3G7yzjk0fplg3FvxiVAjfw08RRJQr/X0LYJVgptxRLq/
         urEKhHvQP3mPuHAekonK6peXdNUxCloM6CkKVPODy0XlhCT4A1+rhHeRvKL+mzVUnpVL
         hWUQ==
X-Gm-Message-State: AO0yUKXC8Q/rEIvIw5W0C5VxKajqIPYsBLcoN31zCEJ3E5woZuU9bqSo
        iMcY4omFQKLz/ZZchjUj3iYjaJzzh4OM6g==
X-Google-Smtp-Source: AK7set/lCgePszbeEbcM6JlqIcM08SLF21clFQ/J33Bfqp2v97+mXfQds9FnJYJHYPxXTk9tI4ClMg==
X-Received: by 2002:a1c:7406:0:b0:3ee:18e:a1ef with SMTP id p6-20020a1c7406000000b003ee018ea1efmr11869554wmc.1.1680011950522;
        Tue, 28 Mar 2023 06:59:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/17] cocci: remove dead rule from "the_repository.pending.cocci"
Date:   Tue, 28 Mar 2023 15:58:42 +0200
Message-Id: <patch-v2-01.17-e1e27490d60-20230328T110946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "parse_commit_gently" macro went away in [1], so we don't need to
carry this for its migration.

1. ea3f7e598c8 (revision: use repository from rev_info when parsing
   commits, 2020-06-23)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 747d382ff5f..23b97536da5 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -34,14 +34,6 @@ expression G;
 + repo_parse_commit_internal(the_repository,
   E, F, G)
 
-@@
-expression E;
-expression F;
-@@
-- parse_commit_gently(
-+ repo_parse_commit_gently(the_repository,
-  E, F)
-
 @@
 expression E;
 @@
-- 
2.40.0.rc1.1034.g5867a1b10c5

