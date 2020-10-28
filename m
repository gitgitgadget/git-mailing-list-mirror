Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF314C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAE2207DE
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGFNFNnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgJ1X4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgJ1Xyw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:54:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1F1C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:54:51 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id f7so1450425oib.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mePBrMGRgp0Wh8E/chfjKY6sN4E7a9SZMG/bdRZI1s=;
        b=iGFNFNnvAo0z+hPTHPlGszFvey1RVbjJMuh6NTTUIWeH7Vs4D7BcaEjjMbpZ1AUIuZ
         QTHpcxMwVU+RHS8Ir6MtFm2SOsI1AUvbxBEoytGfyNoNZvYamTCi+bmkGkK9qAParCHo
         QTiJRBRhs2E6wIjSPKE1r+IeVFhz86NSKqDQUCHvh/mPiqD02Lczh5ziX8YRpJ4UBMvT
         Mmoga939u+hJR0JLi7/rXBwXH5+2Mo7LPGlC0KimhZvLrss1tOyG5+WjxRlxHJaxN4+f
         nnfYMxA6LVz4ygKLZEDWEpOS+AQZ66y8utkwnAcTOnyLid/rI0ktzaaqeY3V6E7tKtWX
         zh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mePBrMGRgp0Wh8E/chfjKY6sN4E7a9SZMG/bdRZI1s=;
        b=L+aEOEWn+N3uk/6nLALydSEfiu/HlLXn3OIfQu9qa28G9gFmarL2uA5Z29LOvhk374
         40IeDkpbKLmbdjeT1jgGTrtj0ljGK4wuO5rud4IVLOp0W3T6IuKaze7MsGXgMfGF7FHS
         Lf1NV/3gOevmNEfpi5nHAyGhMSsDORGzJV+X/cK88hiPUYBULvEkFoA2yIYxwZa5emTt
         Th6kiR9+zaSJvRJz+DbhWA7o6xDU5DaawyQ6YP8z1Bhne/irp65JFli9yuDNcu5mn4iE
         9t1ENFgAiPPaEiTT5d0RVf7xQVevSi0GDtX/FQX0PGEKnRChEDo3FnzF6L9XFCoy9g4V
         ZK8g==
X-Gm-Message-State: AOAM533VH+ENlqL8gZTL3wTp/bh62WJuMytHbRtRgHjmDg67jlVanLTA
        Kn52Kpsg+oLEW5H4g7qpQUxSq5UAPYWuYW8C
X-Google-Smtp-Source: ABdhPJyZUFk3SMN7moVAbVodGubClUvByK1JGck19cPc2f/k87NeBD1jqiTRCOwrLtVeA8VEO1iD6w==
X-Received: by 2002:aca:ac06:: with SMTP id v6mr3492687oie.97.1603850867566;
        Tue, 27 Oct 2020 19:07:47 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v123sm2311622oif.29.2020.10.27.19.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 20/29] completion: zsh: shuffle functions around
Date:   Tue, 27 Oct 2020 20:07:03 -0600
Message-Id: <20201028020712.442623-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to have a nice order.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4834ebc889..60efddb4a9 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -104,11 +104,6 @@ __gitcomp_direct ()
 	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
-__gitcomp_direct_append ()
-{
-	__gitcomp_direct "$@"
-}
-
 __gitcomp_nl ()
 {
 	emulate -L zsh
@@ -117,21 +112,26 @@ __gitcomp_nl ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
-__gitcomp_nl_append ()
+__gitcomp_file ()
 {
-	__gitcomp_nl "$@"
+	emulate -L zsh
+
+	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
-__gitcomp_file_direct ()
+__gitcomp_direct_append ()
 {
-	__gitcomp_file "$1" ''
+	__gitcomp_direct "$@"
 }
 
-__gitcomp_file ()
+__gitcomp_nl_append ()
 {
-	emulate -L zsh
+	__gitcomp_nl "$@"
+}
 
-	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
+__gitcomp_file_direct ()
+{
+	__gitcomp_file "$1" ""
 }
 
 __git_zsh_bash_func ()
-- 
2.29.1

