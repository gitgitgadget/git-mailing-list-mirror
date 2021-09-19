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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85866C433FE
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FEB610A8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhISUkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 16:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbhISUkH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 16:40:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF7C061760
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 13:38:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w19so14240131pfn.12
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFDb/BP+3/q+0WP3dWQCJ/UF8FZA9JYJ5URPYvu11eM=;
        b=RrAlp4Yl9H4nf8jScXw6Bc0XR6RTWMQxUtpJcn2dR+PFupmZFKahswqkYIKNvD7AXV
         iccwQe3WBqWbYGxG/AjhHvv3hLXjABHInTTPE1f3YPSCTNKnLHcpHtzkRB6oB+2RpWJ4
         ZjCmjCYnI1pztlZIK2+CxPl5Z0n6y4Q4D+T4eZ7QiygMaG0TQULSIQ2tdLHX7XoFmkXS
         R4Z+nh3+1976Mzrm9psyNc1/3Zd1Wk6awXuKCevuyM0eHWAzrVqr/pXzqcZifSwHTN/G
         J36dQGUjg6SIsUVN8Fh5Y76XBbXjeqVahYrJMnztvXgiZgpSw5Oq44rMlrIN22/opWdo
         cVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFDb/BP+3/q+0WP3dWQCJ/UF8FZA9JYJ5URPYvu11eM=;
        b=MfWfsXI8T5qLAzGA/cM6hRFt7YMRO7tI0aCZ6nubcr+XNMjJUpgLZ4lrw9uM44L3wr
         UXpem9/0WgyZDAOAtCrPbtyRnuwO1CRUazBHuUp/8UX5lJN+wBHiVwgrnB7EufJqFo+X
         jkmnrJ/h1YPHW7WUEVNMhzbf/LYtAdLkI0c/S2CWwDfWmshj5NJgMJM2xunyBwEZ3qsc
         fM/sFhA/PwpFy698wIJTBhpou4tmz/wYw56p8tRiiUI3J7ez7sIn8xEM5rBhjCNXq1nD
         F8+wLuchEHkNfMs6QBtGrXhj5mLnaX6KKHl4KniZdh7IdYF0iPCZC6jDPMCo1+MXAtmb
         55lA==
X-Gm-Message-State: AOAM530FAOpLlsCDa7CZhh2vA4RXX/yUrTqEWxfWVfHICvL4cY6Gnax5
        Mi9b82Z+O50UU6JEH9qOkyM=
X-Google-Smtp-Source: ABdhPJx/gdg2zNEtPdFyp3akajYDdUcP1jATAD9pq6ZHhaGOGDFWbCnBz0ZX3biZVLZUUXDaq847Wg==
X-Received: by 2002:aa7:9467:0:b0:43e:10a2:5409 with SMTP id t7-20020aa79467000000b0043e10a25409mr21760108pfq.12.1632083921574;
        Sun, 19 Sep 2021 13:38:41 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id v4sm12132073pff.11.2021.09.19.13.38.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Sep 2021 13:38:41 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 3/3] difftool: add a missing space to the run_dir_diff() comments
Date:   Sun, 19 Sep 2021 13:38:32 -0700
Message-Id: <20210919203832.91207-4-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.720.g5b0b3ce580
In-Reply-To: <20210919203832.91207-1-davvid@gmail.com>
References: <20210919203832.91207-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index daa438be09..e225974a2b 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -549,7 +549,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	/*
-	 * Symbolic links require special treatment.The standard "git diff"
+	 * Symbolic links require special treatment. The standard "git diff"
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
-- 
2.33.0.720.g5b0b3ce580

