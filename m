Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E5C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiCYTfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiCYTfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:35:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1216A231AC4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:09:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q5so11501607ljb.11
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOmRPIoh0QvnSIQVV75Wshxu5ApUlilQrb3bf5DQRro=;
        b=F8XKmYwYd9dLNd/T9+OnXKaVJEJHaMh+eikHGRIFbzHPxXWtvDuk5d8gbeGX3RxBPL
         OYi4wfkDQKvs0QQisijpYx5u7WfBKnnPP2rXPGOAsPXZdG+W8tBlY/1flXje0asBduhj
         +P3kXYekQwfEElTfcqlHzaidfBeedQRzgKEkZsZ8dXY1owkErsAOiSImVmKweoZpRluk
         DHyA2+WXq+GHkk/TNeUHken5bGWj5hZ5+kJTNdyiCRR3WAGnAMmpUgivNsomaEkxeKOe
         8Z4YdilFO94DCUIuegf3lUUyZxsq1uXVYosnu+uawSxhaibGsxxWTno5rNBOEMWhOTIb
         +XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOmRPIoh0QvnSIQVV75Wshxu5ApUlilQrb3bf5DQRro=;
        b=mqUokoriaCaI0yEdsQSoNvS8Qq69uIN3Lrq+i467ASim48emtM/PyMit7Q1oJGTkoM
         TmTYMtaAttpRBKAfJBG3/9Epk9aTuUW6RwEIhEGLEAgpHKZlbOTu4lUlYLbHs89BhZy/
         cPajrcSsCOIJcPWZp6vv0vCn5DRTvYvSJGP0ss+RcMV4ssMIDKfa+8l7B6y7NIXgp2/6
         8tTjjvJfvKLHQuEBjd1yxvwx0zGbtEpFTe3mZJccH+YijP09gE4Sm1ApziDNmnuXULVR
         VL2suQk8LX+ESBrgI/yQjLSj5NMkDkm7qaXfiHXgJbGRDFEs8N91rUSwsw4Aei3rnmMZ
         qyMA==
X-Gm-Message-State: AOAM530qYaOjOhn6IaD/XGnNaIYBTGE/pVZeekc5T1lxZFItjynAY5wa
        dZF5u8Kzp+haesvOzEcZNWPZ4ma008FRkA==
X-Google-Smtp-Source: ABdhPJyKKOKBDPVN5LrhSUVm7ZhQBz/pAah4BQxjJEyNrs4xtNioRjR05SeILO3EST8NrFlV8YbjVQ==
X-Received: by 2002:adf:eed0:0:b0:203:f2e2:197b with SMTP id a16-20020adfeed0000000b00203f2e2197bmr10815929wrp.604.1648233499808;
        Fri, 25 Mar 2022 11:38:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:19 -0700 (PDT)
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
Subject: [PATCH v2 01/25] CI: run "set -ex" early in ci/lib.sh
Date:   Fri, 25 Mar 2022 19:37:52 +0100
Message-Id: <patch-v2-01.25-4addbd70213-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
2.35.1.1517.g20a06c426a7

