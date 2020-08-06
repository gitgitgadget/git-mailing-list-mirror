Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47190C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912F1204FD
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skMN61G2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgHFQoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgHFQmr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31107C0A893A
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:41:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so15576218pgc.8
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDtlGdfbZa+4BbrprtZLywdNnB9QGvhHQOpinvsJ+jo=;
        b=skMN61G2e/4YID8IbQyjgRSSQw06WyHcZ4G0sPRMRoK22e0tstUXKkr5HdU2YkdBZY
         i1gFD4Tr3B/mSquWiziDfNFXijvH9sgKL9W9iI/G9FHM9+PKvbkkMAn9BIjTbM2WYAf0
         N4gB9FX6BI5xOq/ts8ZvwZnJA+UgO++doySrWXT3lvuTkWKXfzrxjBp37kzFbVOGAdPE
         Dv/NQYZ9oNKMw0IVD+LH5LvtFdpxne20YykNF3+2SzIUn1MJkGy/q1qfwxGxen7xJ2M2
         /n1aHD5WxAkuKcnNw8gN93c1x0lwrhaEtUmwvcUdKceWA3fxGtOCveYVJEwvoWorN3/V
         2zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDtlGdfbZa+4BbrprtZLywdNnB9QGvhHQOpinvsJ+jo=;
        b=OP95u9RZLLwU+iUryw50suZ3xYee3Zu0U4+ZqK5joVmcP0J5wUQ1YVc6WYM1OPS8TK
         4iy9cTvx/dpv+b1N+w5H5gys4jAik+0StEg/8fABum1lY5mnPoIVzygKF0JB4tCrC8R8
         h/WjgkqZAFXEjxIDsih5jepZ3HgJlnNZ8FDhbxGsLzHXrCy6c1gTwjN4MCPeZ7BdendQ
         ZBzP3orEV9KqsgAo5jcS5rooa4UynU/BiBp6NK//Zxac4r7DegRHLXJ2GKBASMiQ7T4w
         YdRXWdodUpoWE05UF8t90QuKMaqETRfBo7EXpoiuJoUBpf3fUoa1qlak5rXmnGU9jF43
         Hwbg==
X-Gm-Message-State: AOAM532ouwQft0vWa3Ib21Jgf/lw2/NZHT3V+T67EfjxeOh+1pS7pBaY
        hUNtW1GqdYWzF8vA/lujGfEyk3uwIXs=
X-Google-Smtp-Source: ABdhPJz+k+foNkEBsgX3Haht7OYz9yMhlGYxSTwknD2/sqyp2ZfmqYwhEZrz0PmGeix5uOi/S33waA==
X-Received: by 2002:aa7:9613:: with SMTP id q19mr9671317pfg.9.1596732081208;
        Thu, 06 Aug 2020 09:41:21 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id w16sm8008381pjd.50.2020.08.06.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:41:20 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 2/5] submodule: remove extra line feeds between callback struct and macro
Date:   Thu,  6 Aug 2020 22:10:59 +0530
Message-Id: <20200806164102.6707-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many `submodule--helper` subcommands follow the convention that a struct
defines their callback data, and the declaration of that struct is
followed immediately by a macro to use in static initializers, without
any separating empty line.

Let's align the `init`, `status` and `sync` subcommands with that convention.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a1c75607c7..3641718d0a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -612,7 +612,6 @@ struct init_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-
 #define INIT_CB_INIT { NULL, 0 }
 
 static void init_submodule(const char *path, const char *prefix,
@@ -742,7 +741,6 @@ struct status_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-
 #define STATUS_CB_INIT { NULL, 0 }
 
 static void print_status(unsigned int flags, char state, const char *path,
@@ -933,7 +931,6 @@ struct sync_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-
 #define SYNC_CB_INIT { NULL, 0 }
 
 static void sync_submodule(const char *path, const char *prefix,
-- 
2.28.0

