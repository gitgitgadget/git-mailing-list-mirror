Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DFDC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiCYTnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiCYTnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B030DC78
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:14:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h11so11533137ljb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7a+WGWJZbht0q4eFon/7xMhotdJ7rWc2UNBVhooYPww=;
        b=CO0bm084qup60TsUBdqwdruuadl2mla1WHeoghRJgVeeMleGZKC4lU/Q8lssV6BRVo
         v3UFjx5IThNJg8WyO97EisqYLdfd86wNEqFkw3xKIrfEbFdlSEet5xA+JAWW6gM5kqQE
         knzkU9HFi5FwUPeIWstQS3ifNy4Tr9lKLNAZ9JCF9KfewGM3G3GLOTtMGXrAUXTm2pt1
         ztUZBUVvMO3TbKqqPPchUNi9nixi6SKD39llelbQ8sS8tZ3O1vJbWzSVZMhx1+YSd9V7
         DyvodXYv9VNfg02SuHELmbsZrWxEVkoEYdO6UEGaAO3AYnWNy7KR3v1bCjZ1INg4MWZ7
         moEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7a+WGWJZbht0q4eFon/7xMhotdJ7rWc2UNBVhooYPww=;
        b=RZGFYTMqfs23tvbbBSkGo/OLeKzVuglrgpmcxqotnET7bsPIl723u5tb2oWnuyOBdR
         2Q2Qn2SfV/4/xd9gmuCmZncZEj2t1e2cI0/j9R7dEazmvIp4j8RdJmHnfH9aoewGENgf
         Xe5C7s7L11wRtxj24CEecHPQWUn9TPx4NM3xGe9GPrQhumOgh9ru8ltey7PLMgd6UEqy
         wQqqD0Nl8YssYxyOKlll5dGqDN5lhfCtTMuAqV9+mnYGDOWtywcZlpEpxIvqOZB3iZDS
         1ApWwoKFyy6wwBlU1imwIL0/W9MqTn2vLpS6B18TRFm/uQKMMcfXuFZ1ib26Dyh5bewn
         GJTw==
X-Gm-Message-State: AOAM532yspbDJeIVbpac5inaPUxji55ws6fdLhRVDlxXIZn47z3fWdBv
        Q7lobjYQ6+hizYNhTRnNpOIN3xzR0sQSuw==
X-Google-Smtp-Source: ABdhPJzAwWeogRHjJizv75DKkP7fxkPgQm4XkI2YQma1Bn9D/smiGi/IddoXRQTEOODF6iA+cLV79A==
X-Received: by 2002:a05:6000:168e:b0:204:fe5:a55 with SMTP id y14-20020a056000168e00b002040fe50a55mr10103795wrd.453.1648233504156;
        Fri, 25 Mar 2022 11:38:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:23 -0700 (PDT)
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
Subject: [PATCH v2 06/25] CI: don't have "git grep" invoke a pager in tree content check
Date:   Fri, 25 Mar 2022 19:37:57 +0100
Message-Id: <patch-v2-06.25-a4b9febbdca-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the omission of not adding "-P" (a.k.a. "--no-pager") to the "git"
invocation that spaws "git grep", added in 0e7696c64db (ci: disallow
directional formatting, 2021-11-04).

This didn't matter for the GitHub CI, but does when running the check
locally. A subsequent commit will start invoking it via a new check
from the top-level Makefile, and without this we'd visibly spawn a
pager when doing so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-directional-formatting.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
index e6211b141aa..de8e6e486f0 100755
--- a/ci/check-directional-formatting.bash
+++ b/ci/check-directional-formatting.bash
@@ -23,5 +23,5 @@
 # U+2066..U+2069: LRI, RLI, FSI and PDI
 regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
 
-! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
+! LC_CTYPE=C git -P grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
 	-- ':(exclude,attr:binary)' ':(exclude)*.po'
-- 
2.35.1.1517.g20a06c426a7

