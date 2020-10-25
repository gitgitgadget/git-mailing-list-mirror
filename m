Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1189C55179
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C058B20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNmfgz2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766897AbgJYDOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766882AbgJYDOY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:24 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED47C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:24 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f97so5112781otb.7
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXyycjBspfmxshLrLUjsVAwiWf4gb9tWqshbWGRQKZQ=;
        b=tNmfgz2QBpugzRd6jHtpR5pfIBKe6Ct9ucS7qc/BnFztihogtNL3Lvmiuat9m8WcwG
         09XRE0AtHmqe3VTEb29qKwPSbCqA5S80hspwVgw7W80uiSj+j+R0I/+4n9aY8qqg8oNe
         qDOu+lOnuU7Ayh7+2wZE9ctRnvGl7rMVSIOR97maBLxMdkj4RbiZspO8uG4qFW8P528m
         Y8fe5brwNTMCuydh00AqkcyUty989QqMvI8eQ+YU/FxHs9BvwGRm2jHpcE+fTLRUBYE/
         RmbGzsjH7OQWJFNqEjcK7k8ep6HJMAhjAsZV7GnfDiWbcjDNXofjZG4bS7KBMMj/HnAy
         ELSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXyycjBspfmxshLrLUjsVAwiWf4gb9tWqshbWGRQKZQ=;
        b=H/7HADl5AYo+UMF7NeFEvZy/ozADHFXU6ibhhlFzAfoDzako/0NIyf1keZouHeDa9V
         ZG/3nkwP4/JmxAVQOmkzorRpW55MSLrq73XIFnz3Nhs5/JTbITc7kYs0aw6QecNMJAr2
         Xpwi1S7O7w6WgV0u2PUzY08L4fdvHn+q7DzyG5A2gcUVyBP2tfEGW6wPKX186h8DSAlN
         x704e7aWUg7rlJbIBS351+yiTgbK7YIkqLPiFWwKJBa+mbEI1jzNWna+DlCdhTqGjOrD
         W96ELYrzVMan4qO4BmMRrpE/W2yx6Nh4BqM30qMufCsFkaIaSSPZYiPYtD1aSzRm4INf
         HwqQ==
X-Gm-Message-State: AOAM532TUa0F277WVqiYP4GmwJ0ryZTANCDbgzGob+5UXyG1DoSeWQm5
        2sexhUACI1gEzzxE4N9RQRhmSfFD1VoXEg==
X-Google-Smtp-Source: ABdhPJypLw2OYa+Fs44oV6043VNVIY4lR3iXJisVi9VaFojrQ5whCLwZlVGcjPbaMg1rLaUdLWPmEg==
X-Received: by 2002:a9d:10c:: with SMTP id 12mr1869152otu.95.1603595663440;
        Sat, 24 Oct 2020 20:14:23 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s186sm720059oih.34.2020.10.24.20.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 25/29] completion: zsh: add simple version check
Date:   Sat, 24 Oct 2020 22:13:39 -0500
Message-Id: <20201025031343.346913-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of people are confused about which completion script they are
using; Zsh's Git script, or Git's Zsh script.

Add a simple helper so they can type 'git zsh<tab>' and find out if they
are running the correct one: this.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1b2a43150d..9fc9f2db21 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -127,6 +127,11 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
+_git_zsh ()
+{
+	__gitcomp "v1.0"
+}
+
 __git_complete_command ()
 {
 	emulate -L zsh
-- 
2.29.0

