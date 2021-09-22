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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DECBC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783D86120E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhIVSfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhIVSfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:35:19 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD5C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 11:33:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q81so9365052qke.5
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKNtK3kAxa6/CrRmbd7Lt7mInt1KyaoDjZOp0dHbBzs=;
        b=bZM1Bp5GGoPPCy0x1RTOxzRSAX75BykxnsS/+IJD4ppIypGit7Z5gsh6sEB76zu2el
         nFpUotugiQmIlagmeSZIP1YQ6w3XFl68jXuiNNamxbOXN7MlwpAZu3goZRSCNRuZ8mBy
         I4iURz0XQcqTNugw/NtSIIf2S7bmgBtkCc6qB2qYu0biGIEMpXv+7Vpj1NF5GB6dQpu+
         9LeL79VAk+kXDUe3kstofIg0d9yssjDAwso/ID2h3aASuuFkuk8Gf+kkTZiLhANYSjEL
         8Cppy5HojzodV3dUftG3Lr1dbCzJwGKUyt8xhBHgRwKy2oS0cWkCYNTWrh2tIYYv1jzY
         qDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKNtK3kAxa6/CrRmbd7Lt7mInt1KyaoDjZOp0dHbBzs=;
        b=ljJsGI/DTF87vbGlX/ERAfYoAXAzX0QtGDsphURZJa8oO/ASMdnOPHcYlRLxJ77Gbb
         3DGFylrMPYOkZXqNaLz2fVmXQyoX+aWIKvROrlY4yfrlfeL10mp6XOwhaDA7lP63td2H
         +dxL4K6D+Ga2vyPutcTEWhbvRsrkzCN2399UtxMS6nT9yiVn2EDIL1AgNZ8CP1Ut/FiZ
         ne78aZQbGKCPIOFr0V520j13AlvcqfpTuGKmry3HWNeCwc1nXWt7VFSWfBMbTK7QINv3
         knYIukQWdml6By0hiq56xe7LpkamWKCt3XQ4AhxmhxV/WMYGFRztTH5VddBIa/rpavFN
         THTg==
X-Gm-Message-State: AOAM5306YGEa5pwpk0XKyT6eRaEFb6WI12Q/zlbMlS/Hk5iSfVM//07d
        a41/pA1fXkpR+4m3YE4fBZrETNRZBUM=
X-Google-Smtp-Source: ABdhPJwFWPBWMYxBwtddgKop1oui/frWZYTKqAhjtgfUFfhR5e7K0N/JnAxaksTKxSHUtrMNr73sLA==
X-Received: by 2002:a05:620a:675:: with SMTP id a21mr684383qkh.421.1632335628535;
        Wed, 22 Sep 2021 11:33:48 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o4sm2022544qti.24.2021.09.22.11.33.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:33:48 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, levraiphilippeblain@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] Makefile: avoid breaking compilation database generation with DEPELOPER
Date:   Wed, 22 Sep 2021 11:33:11 -0700
Message-Id: <20210922183311.3766-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.911.gbe391d4e11
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

3821c38068 (Makefile: add support for generating JSON compilation
database, 2020-09-03), adds a feature to be used with clang to generate
a compilation database by copying most of what was done before with the
header dependency, but by doing so includes on its availability check
the CFLAGS which became specially problematic once DEVELOPER=1 implied
-pedantic as pointed out by Ævar[1].

Remove the unnecessary flags in the availability test, so it will work
regardless of which other warnings are enabled or if the compilers has
been told to error on them.

[1] https://lore.kernel.org/git/patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9df565f27b..d5c6d0ea3b 100644
--- a/Makefile
+++ b/Makefile
@@ -1302,7 +1302,7 @@ GENERATE_COMPILATION_DATABASE = no
 endif
 
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
-compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
+compdb_check = $(shell $(CC) \
 	-c -MJ /dev/null \
 	-x c /dev/null -o /dev/null 2>&1; \
 	echo $$?)
-- 
2.33.0.911.gbe391d4e11

