Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6169DC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD66206DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDwZOtjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLTo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLToY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:44:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF556C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:44:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so1646900pjb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBZglFFSf02qtWUl+ct3vdPNpDjMNvbwAl4CJ3eay8Y=;
        b=SDwZOtjzAzjmTYZ6yCS0LIkc9gmzOtURORPZwRFJzb3XoWzuGtyTpurnWQxC+fcEdy
         fRfHrFHBspCRqgj5DGm+/Bzuy9GuQPK8nVArvMx4IibFAPJA97ibGHANVZEGK3StRhJe
         e/xVdEQ1VGDO2sLUZtDlusKKiX/6p0dJ7gQslrz+WClQhFDoeZLxBgoeR0x3dnY5PhUu
         01K66Qy172UFeND65Nm9aIHm4IypXyR1QGyQaxjXbEei15fRkSDPUzJYW2jcuIjxYT75
         F68EX8g+AcY7V/QNWpqxLFSpGyLwoz7ZFIIF5uxhHuXLdXFa/UGqB1mOjpdq7xBCt/La
         UnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBZglFFSf02qtWUl+ct3vdPNpDjMNvbwAl4CJ3eay8Y=;
        b=f9q53tETFRcpTB7F54argf90Y0rGwp8H0iS2Omlo5NRQFZIAoVqPoj5bOszEMsv3Iu
         A1tZYww0fhFSCupH7mN9mbYSfATMttViVLZYAhjPeagLSBdsXGsrfHpDL8SYvd4DONHS
         MzVcL/0q8doH2bUJNQ++sNrDyDD0vbwNY2Rv349AEHeWXs5Z1wpN5xoO46o+twtga+bq
         ocui7MuAnSc0cGQsvrAofWmNYloXRjHp88is4Oq2SxuVTwo8QHsKUOYLvVaiw9ua73zy
         x2VkDnLIlRf8KnBNgrP/Ji35AOuQOmKCX8BWgdwhpvrOauCOVhUXb0pLqSj04aN+H8oD
         Lg7w==
X-Gm-Message-State: AOAM530b+uZoF7Uvoo/fe7T1fCLslcs98vybUI5Jqg2JQDeTgPXw8JVf
        M1l7HC+Zss1p401iVNCzlV2PlPoM9N0=
X-Google-Smtp-Source: ABdhPJwp9VwqI0b2hDq4sp0z0slyTzcNUyJL+hYXW5i2hYj4ai4hTdl8Qcdid8s6tO7G4qXnpDV+8w==
X-Received: by 2002:a17:902:d346:: with SMTP id l6mr807264plk.77.1597261464288;
        Wed, 12 Aug 2020 12:44:24 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id q17sm3183965pfh.32.2020.08.12.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:44:23 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v3 1/4] submodule: remove extra line feeds between callback struct and macro
Date:   Thu, 13 Aug 2020 01:14:01 +0530
Message-Id: <20200812194404.17028-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812194404.17028-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
 <20200812194404.17028-1-shouryashukla.oo@gmail.com>
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
index df135abbf1..a03dc84ea4 100644
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

