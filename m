Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D63C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378294AbiBUOrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378288AbiBUOrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D073538A5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so1529542wms.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+u1fGve9Kxhe6eFVjZJn/mvFAwvpubdq0fiKHmt+o+w=;
        b=FQ3Vsj1QIbpvH0fMOi91Zfv2JHvjCE+XwgDuStFKL1gdPB5ycJT8ygnDhLzFN2U4tU
         em2qXw0htwjPRJjqR84CVQb+297PC1gxt0VjtdZCrn88UF3iKeLG0tiBXrVcfTwy5kyK
         +55hBL/kZfs8MAFaA71vZAxoAEQGSgbBcNFmkhLt0wAMm74TyuC07g7yrRYmiZdUPc6c
         wGelJP6u3Fyb2mD1ecL0iE8+tSYqs46laQnmV/Kfwz1XaL64jnniF43r6jwsZULFW9E1
         FgIAjBjSx+yl5urqxd/tof5Ythod29r6Q1tAcRAzTkbwAOoaV4FkDtpAjLVRouEsPFP1
         +KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+u1fGve9Kxhe6eFVjZJn/mvFAwvpubdq0fiKHmt+o+w=;
        b=FyAzmW1x37Wz1FZPzraXbUKwGL+OJgl1tKYgrl634lrHd13yXY59euKMzVN5qaR2lN
         jQQWB73H8N04MzlW5wJyDxlPH/8EH3sqSz3eQyK5ufMKWa2mSk59p74Iwx5Dl9soanJw
         m94xM3g5vY7ZUJEzBMS9RS7O+DsJ9IoV4lMxU3lWHovXUd1qCji2aq8EJoZzH5OyTtbs
         I+FF8EgqZOFF9Y5DP9QN3ZQU2olYsREB+pjmDc6OmkvpW9MekRMdmHXxANszFpg1AOJ7
         R6I1N+pb744neah7puPxC+cCJDytug3VGbpsIEm68YOJX5V1DRbGroYRmuSfLDRjk2rZ
         1U4g==
X-Gm-Message-State: AOAM531wSMS9B7ZAoqHkppO7BzUDQJFlyU4RQ9ge8yO9LWCim2B1xrnb
        0FD3/8/oPXLbOY5x0M0zij52wjFydpE0Qg==
X-Google-Smtp-Source: ABdhPJx1lppag57f6S0GJyqId14rKtw1Z1KGuHlLLkYXyOB6PrYnV2riNORKkqBQJ9M9OnefubfOcw==
X-Received: by 2002:a05:600c:4c27:b0:37b:fa17:899a with SMTP id d39-20020a05600c4c2700b0037bfa17899amr17907951wmp.126.1645454808171;
        Mon, 21 Feb 2022 06:46:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/25] CI: run "set -ex" early in ci/lib.sh
Date:   Mon, 21 Feb 2022 15:46:13 +0100
Message-Id: <patch-01.25-970849a227f-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change ci/lib.sh to run "set -ex" before it does anything else, before
this we were omitting a few "export" commands in our trace output that
happened before we enabled tracing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index cbc2f8f1caa..57141d38a85 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,11 @@
 # Library of functions shared by all CI scripts
 
+# Set 'exit on error' for all CI scripts to let the caller know that
+# something went wrong.
+# Set tracing executed commands, primarily setting environment variables
+# and installing dependencies.
+set -ex
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -85,12 +91,6 @@ export TERM=${TERM:-dumb}
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-# Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong.
-# Set tracing executed commands, primarily setting environment variables
-# and installing dependencies.
-set -ex
-
 if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
-- 
2.35.1.1132.ga1fe46f8690

