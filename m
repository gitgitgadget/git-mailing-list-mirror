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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0390C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB5461264
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhDTNhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhDTNhh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C6BC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u187so700905wmb.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1gh6beKO2Ck2HziHBLmeE9kWWBXwRqUNXbmryVtBSc8=;
        b=rrxEmNla83tkovUQq2TVXt+FT9VGC7McS72RZvM4PRBkUbGTIDgtS5qCJt9nPXfrQ5
         7FbvG69pSDO9MLqhihqNGdKHD8IQl5MnxhqqMy4Ekh+B3z4fZS5uWUkLb7vGI6xnWj4L
         EFC3hyWQqI9yau5Ixpqu66mt/Z/ACuGsEZZmt3Tab55vP8z7ul5U4tJvKG/yBRBzmYaP
         YpXrYBGbKFJrq2o4qgx4PXLPbeR7nQSEifK1EOHTFcGge73cOI5209B65KILmZntHoCW
         +Q1KKxb+uz0YihJT09NECLFFBE1VehGXmtXk7zASPVxspeRcsdQ2b4Pl6m7P8Hc71Ad7
         DceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gh6beKO2Ck2HziHBLmeE9kWWBXwRqUNXbmryVtBSc8=;
        b=aG982hrvVf40ppTh4X3fMdD8TmgAZcJ4yUZVXqH1VTZXRPWOm9StT8ak1ZBjHKp9Ny
         jBGemTiplfGOjOP5y8TugBFPu4+MUrydKsfmRdkVGtw+9gqSP1uyVV5KWufAwnipS7gK
         pe8J19ZXXjKzYT6+bdC96hMqF7L6QL6/7fQCr+72GEIANuu9fPIx2CmmARh8Q+5GFB8Z
         Nnf1dOESSR3iEJeneyO22g5sFn7m4Mz+RT9kAB2RaZC342bAIzo7RB4vyAsdRgk0+kKr
         jQJIzkxc5uoMPROs20KuD6xCbiUuhMcJI6FHs5T+g/XT7mKk5To0q89+wNlhepDaxOHm
         sUAg==
X-Gm-Message-State: AOAM531NC+haORGP+XJ+/gcCa5ac0DzSS2FQ8DWnR0HM7DOYZVWTW3gl
        M8hvAZTPUjlUrJ3beETOj6KrQeJMaHyW3Q==
X-Google-Smtp-Source: ABdhPJyAG3bndOv5Dx7ffTBc/jTnywznPG5pOf3GmK/ui+MWBK4N1L38/4CsCcbT3Qcvs3QrpgwiQg==
X-Received: by 2002:a1c:6808:: with SMTP id d8mr4597952wmc.147.1618925824319;
        Tue, 20 Apr 2021 06:37:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] tree.c: fix misindentation in parse_tree_gently()
Date:   Tue, 20 Apr 2021 15:36:53 +0200
Message-Id: <patch-1.8-c39b235035-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables declared in parse_tree_gently() had a single space after
the TAB. This dates back to their introduction in bd2c39f58f9 ([PATCH]
don't load and decompress objects twice with parse_object(),
2005-05-06). Let's fix them to follow the style of the rest of the
file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index 00958c581e..e9d2bd7ffd 100644
--- a/tree.c
+++ b/tree.c
@@ -128,9 +128,9 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 
 int parse_tree_gently(struct tree *item, int quiet_on_missing)
 {
-	 enum object_type type;
-	 void *buffer;
-	 unsigned long size;
+	enum object_type type;
+	void *buffer;
+	unsigned long size;
 
 	if (item->object.parsed)
 		return 0;
-- 
2.31.1.723.ga5d7868e4a

