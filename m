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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DFAC4332F
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7DB6109E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhIVWJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbhIVWJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:09:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3705C06175F
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:08:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so11380738wri.1
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZiCbhjiEPbfalpWZa/Zr+9CXhKACd61B6KdgOvBXwg=;
        b=BdBQlZ580ZbdYuZz9idT/tYl0qjigdfr8rTW+mjXxib+AGUcIHcPf7S0yAVprN/Fwf
         KrApuB8eRzb5r2j27/egz0hmbX+sAz6nQ1qvZfnDzOFL7T8ePkrjptC17kvCz7x69URQ
         6vHWmaGPYl7IYQoyrvE8xusBhPOiDEA6UYNUrY1b74rxGHA5PU1rltgrRMa/6ZcFPTnB
         Ysm07KPZmqer267s7PtkC322rhcu1BOMQTm5Ah/SOC4JLvPGccx6Q7/nN201jVv1qmwq
         Io/z68NGNKgV9/vrRUB+e7TSMUX2MyK4m2ElenE46qbsFqsWkW/nu41gxTbiW1GhgNEi
         hiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZiCbhjiEPbfalpWZa/Zr+9CXhKACd61B6KdgOvBXwg=;
        b=Jp9vOcvO5m52fmJgrY1hVK6QDlg0DrmhO7P1ikXrsRvwRpNUAWTB5Qyp7mFgWfVzoF
         L6E6WluPEo14DG15u4xTGNKHK9wEvagC0bnZr5yItkTPud0bEjzwo1T3W6O4LmD4/v+3
         x+Z5SB4tiIwdfFAqeNuNQ7nHrVMdh3HRdUGHBKMpkyhWgaZgc8za0Gox0bKGIqSu9upO
         Xcn2ekhwKrlVVro9eyXZILyNSTMmOHEhGSSaVtnHyu7L7v59bbfH2zxa6T9mNCwpo8pB
         JYQ2myMbnJ+Xa8uoW5sftehpAomMmsdeq+TCcAGlgmSi2twYcuEp5tj05TfQubSk8NUt
         K2jg==
X-Gm-Message-State: AOAM530E1zh9tOyqygtbWVVJ+HCS35bptndJV+lYQl/qHsOqNY+ZsDUg
        iXMkK1VCIhFmdhHc02HOQi8o6iO2V+MuFw==
X-Google-Smtp-Source: ABdhPJxdwRFWpB/W3Qju4oStESHO+UJqlPaIS+jqmgzrI/HUtNHG/LNHoX1D5yTkchqmU1RdLCWhwQ==
X-Received: by 2002:a5d:53cd:: with SMTP id a13mr1369490wrw.33.1632348485843;
        Wed, 22 Sep 2021 15:08:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm3466336wrb.5.2021.09.22.15.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:08:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] Makefile: pass -Wno-pendantic under GENERATE_COMPILATION_DATABASE=yes
Date:   Thu, 23 Sep 2021 00:08:02 +0200
Message-Id: <patch-v2-2.2-6b18bd08894-20210922T220532Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same bug fixed in the "COMPUTE_HEADER_DEPENDENCIES=auto" mode in
the preceding commit was also present with
"GENERATE_COMPILATION_DATABASE=yes". Let's fix it so it works again
with "DEVOPTS=1".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 10ea12aae21..94b116d4b37 100644
--- a/Makefile
+++ b/Makefile
@@ -1304,6 +1304,7 @@ endif
 
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
 compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
+	-Wno-pedantic \
 	-c -MJ /dev/null \
 	-x c /dev/null -o /dev/null 2>&1; \
 	echo $$?)
-- 
2.33.0.1225.g9f062250122

