Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72183C388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C9E20796
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX4VaXoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgJ1WEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbgJ1WCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:02:55 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B6C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:02:55 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id f6so501172ybr.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hwCA3YFTq6TjHiuN65eyHursT5ELlCF6ON6OVTi3NU=;
        b=WX4VaXoNaLEIwXnxlmls8OeFv3rPBvecEhevBcmu762vKNeBaEaYa3MVpUZ00o+50+
         Km97L67EGQGvT7JnkFlejM/PVQA/Xm9E2NqlhalSoQFUtVDKJRkpQXRkoil9FFAwNom3
         c8UDDwSUCamCUvEqSBN8fdyHcg1m6+FU+qJfsmdV3R110eOtu1wVSQNODfDDqaBnlsrI
         lHVHRgTlgoR/WO2wbszKElcdYiCJlE3NuWn8cVLe18c/5MgWcCxY3QZIl1sls1a1n2yf
         fJhr/okrxtlpPDw0Xjah+M2FEsZ/gDNQgZ/6DGiMuuq7DKWbrFxErKVAVjJVCSZWNekf
         QCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hwCA3YFTq6TjHiuN65eyHursT5ELlCF6ON6OVTi3NU=;
        b=kPBngm6omESSbDhaZE0Ncby5O/ntQBw1DQ9YIJIjM73mQujCCRgTreLSmJP0C2Y6hl
         QErsCLzowqafXPc3qEwygXO6w+SErXxrOntkcigPcHa/F9B0S5OMB38O75+UsiILrdcU
         Gn53V6VIaktHpqh7VI8AN1Rps6xipABU0e+45oDEva5hiZJtzCcKtFnLkJgCTfb1MKzM
         lhYfbT+s3s7p6QjL5WwC2/BsQjh4P4Zi8SeYlOaxxouF0AgjArbj4WCykXdmDYZ9Xrf8
         yGSKmmPJRTjHb0XXE7SlkCgpzQ//R4fLUiWncB4+/70EBf/kI5Bj81bQbBNYQn6Ba4lW
         F3zg==
X-Gm-Message-State: AOAM531QZB6i00Fd43YndyR2HiyZUIZTDWs0QknsTid0jCTKs+I09ff9
        r+P3+GwDDOsbimFgn3Su5FzzdJ5CZ5HG/w==
X-Google-Smtp-Source: ABdhPJytG+dlL85hiAOOB6UcMDTWzbDOTM5GfUqeNplHVDFhYeT9w0moh/6U9cYay7hG3SVpAv/PJA==
X-Received: by 2002:a9d:57c3:: with SMTP id q3mr3328575oti.326.1603850859071;
        Tue, 27 Oct 2020 19:07:39 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r8sm1709180otq.43.2020.10.27.19.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 15/29] completion: zsh: simplify compadd functions
Date:   Tue, 27 Oct 2020 20:06:58 -0600
Message-Id: <20201028020712.442623-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to override IFS, zsh has a native way of splitting by new
lines: the expansion flag (f).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d9ce5e1742..1ef02f936c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -100,9 +100,8 @@ __gitcomp_direct ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -- ${${=1}% } && _ret=0
+	compadd -Q -- ${${(f)1}% } && _ret=0
 }
 
 __gitcomp_direct_append ()
@@ -114,34 +113,30 @@ __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_nl_append ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_file_direct ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compadd -f -- ${=1} && _ret=0
+	compadd -f -- ${(f)1} && _ret=0
 }
 
 __gitcomp_file ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compadd -p "${2-}" -f -- ${=1} && _ret=0
+	compadd -p "${2-}" -f -- ${(f)1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.29.1

