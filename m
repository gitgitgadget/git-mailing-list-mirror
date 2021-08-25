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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D0EC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97EE610CE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhHYXUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhHYXUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:20:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A3C0613CF
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f5so1809267wrm.13
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHdxbCA+/hsBmu/T36KjN3tcQ7jEN6auW1UJeeywmm8=;
        b=odyciXMAixI6pefjiO08mFapbTgi7qYPvxYj/ACfFw7uWB4BgEkHvqDEptJjspz+eR
         fRQRYd4SbJ5BVLG31F0NkspLhJOWC4aOO6W9Ap8pAoIr/P0N74tfjaWSpdvPj+ed6GVT
         FoNEbRxGONawuHxbSpFeYirC3KcJRAC+GQ1hDg+TUP/aNYbn9MdKoyZKpD5kUdih8r8M
         uFtOBwciq8fBDam7pGzi7O9wCHFf+Fv6aBrrf4Lgwb04sjAotcbuL1ebKX9xaWG67vg2
         qthg8FOL3I5TX1Z3RAVjXnX6hyDlNVg+l8+yhvmif/IGqNfWuqc3Ki2oY21Iy5T/00JZ
         VPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHdxbCA+/hsBmu/T36KjN3tcQ7jEN6auW1UJeeywmm8=;
        b=QOGnYa6rzsGW2pDJ8qwBUtKnxE7QKqUi5pbsWgx1/j6TjlKy6agTDYQf4zyLM55lHJ
         l7e7zW0i40c19zQ+svRLDTrACyW+ZrS1bI9PeE5hdHC76Gsug35Dl27lP4EXB5m2F03c
         aYuvZuBb57fRkERU4e1tsDvY7dimjqro39ZL35PdqCr476dws0+y/M4JLq6rm3qZfOKT
         hb2X3O4fa1QFHUR9jgAurOGdmQIuRp3qmbytZDOifKC0r/l1gbEtEFjBMXucuUnf/4/K
         vIVhjOkNCOBxpkukZwUVPlYA2rdFZnFISy9hEk6ejoNWauizt1l7N0jvxlzflULWpqao
         vFoQ==
X-Gm-Message-State: AOAM530eTg1hJF27a3EfjNVbDDKlEQ6t5yLSiU1Vy5xkFRJXw/y4yT9Y
        9eIjbIRtVmKBcYh55nvIfQxieM8H4y3dYA==
X-Google-Smtp-Source: ABdhPJy5rJw5w0pPyj3+kZ+jvfryV5VDPFUQqS0JitrjOVu1azQxLkzDS5Va2b7LSHcpGmV985wPyw==
X-Received: by 2002:adf:90cc:: with SMTP id i70mr553988wri.408.1629933590764;
        Wed, 25 Aug 2021 16:19:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm6327166wmc.24.2021.08.25.16.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:19:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
Date:   Thu, 26 Aug 2021 01:19:20 +0200
Message-Id: <patch-2.6-0150e3402a7-20210825T231400Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
References: <87o8agp29o.fsf@evledraar.gmail.com> <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite a comment added in 2f732bf15e6 (tr2: log parent process name,
2021-07-21) to describe what we might do under
TRACE2_PROCESS_INFO_EXIT in the future, instead of vaguely referring
to "something extra".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 15a89676c7a..62f8aaed4cc 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -32,8 +32,12 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
 	if (!trace2_is_enabled())
 		return;
 
-	/* someday we may want to write something extra here, but not today */
 	if (reason == TRACE2_PROCESS_INFO_EXIT)
+		/*
+		 * The Windows version of this calls its
+		 * get_peak_memory_info() here. We may want to insert
+		 * similar process-end statistics here in the future.
+		 */
 		return;
 
 	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
-- 
2.33.0.733.ga72a4f1c2e1

