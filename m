Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85936C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 10:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379839AbhLCKXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379834AbhLCKXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 05:23:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0637AC06174A
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 02:20:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so4687393wrb.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 02:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPncv3BMznM+hvKH8usSFovfuJhBOj0wWtr+zA2/B0c=;
        b=k4PxE6jVaGfDaYdZnQfDFhi/pr83RxAONaJjVP+hia52biKS3cZuO1U+C7J22XKMz5
         doPmzn0Mg2rF70Y7uAASyhWChTj+Qjb9kTMwS/z87mJvq+UNwWIFnOhrYSl7+qnMwCYE
         1+D0gqky3xTYMw17IPLaCZNZhcDxgeePY9VVnvdRS33LDa4H38r/hteSpOZulgJX9P97
         yzAGdltF5oOGATdp1yqlpORyOWn/XV5uBXjYeN3LTTG3Tvb50Ecih0BTitEICbGFqiVE
         7P24OIo1eyrfEtdGhW8rkvXKq7GtHxdbDFhvEJwcOeehbF5cAyvk+9lL5Yyg69GOYres
         ijjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPncv3BMznM+hvKH8usSFovfuJhBOj0wWtr+zA2/B0c=;
        b=gEPiTgDwdTNY/GpGVRFl3N3/+M0f2sVx+kDVqn+AR1fsklSGO/Jm3S/oUe+eyU8iI6
         xhR0WNMrcqiDmwbYLFoKZuBzGDSVvMD0D0C7aDmj6mPXlKMHgi7fElFq1L7jqMSIDN5y
         AcBS8KX8tnde3woLvPW9cOGVXAp4gNZYCY08qmE9Q9L0FcPTaRfW0uHi6yVYc6UPA3uJ
         pLhqgXTz6siSjEJEDanm/Hpf/fM9xonAQwFhakqZ8YQATv8mS9vYNdGwmymLeXPhg7mL
         1l8faUiB/QDIJKPyl7QqhiielSz9Mww7IZ4zQ3Zs3ucizhFTYlrMxsz9aqHSK8N5CfZq
         ogBg==
X-Gm-Message-State: AOAM531nJsrBE/o1N2oBnYq2atkheQXx2kRA7KGxopvWNMw8cV+M1Fnv
        ijswBgiSQBVogF/mfoVJGwsbF5daTdKS9A==
X-Google-Smtp-Source: ABdhPJwxv1XjGTkZthck+GVZlgIqGcssgscD1ZcAGE2U1+OCCGs5Bdw8WRuXLqgEZNRV16o9XSBo9g==
X-Received: by 2002:adf:c605:: with SMTP id n5mr21101913wrg.564.1638526811225;
        Fri, 03 Dec 2021 02:20:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r8sm2798448wrz.43.2021.12.03.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:20:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/7] grep.c: don't pass along NULL callback value
Date:   Fri,  3 Dec 2021 11:19:52 +0100
Message-Id: <patch-v4-5.7-ab1685f0dad-20211203T101348Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.875.gb925cffed1e
In-Reply-To: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.34.1.875.gb925cffed1e

