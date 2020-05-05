Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B43C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 13:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6E3206D7
	for <git@archiver.kernel.org>; Tue,  5 May 2020 13:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omo43sKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgEENBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgEENBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 09:01:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5DDC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 06:01:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i7so2064477qkl.12
        for <git@vger.kernel.org>; Tue, 05 May 2020 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQ/2/GN5XXtaAP0MYwgOatL5z7yoG27X3haxd14KjYo=;
        b=omo43sKLG/wtnLOIRigWh8ayC442NeIqZCuy89dNszkWgB6y0LXuMBP4BEY+49LaJ6
         iQeYw0cGfXIqGjudZ81N56PHw344PbFY3gtXBA1mvsOwcyH2nM0vR8/q/RfvyMa0heFg
         //rz26NtaifLpWcUoRPcthxiQHe+QL4og2h1pXwPsP3ezUxm+XMKdR1gWiASrSotI4bt
         IofhHjHF8cF25pYRBYKb4dDPo+5UnFsSWYw1OnBkD8Ko2/p8L1NKdRGk9SaWZ+4FEvps
         hURB4rOQ8mMS6xPCDDqfVqer2qJM2MEUkUKAWBrK3Jnr4Xfdd+euZ8NgfssxzVj7ac5P
         J4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQ/2/GN5XXtaAP0MYwgOatL5z7yoG27X3haxd14KjYo=;
        b=YsNfLwuy5ln0P8PKG/2bU4U70wAmwsc/Gh0CNoYaKA9sDmQXVcntWH+i8CO4xaggUd
         lj3MOjO34XaMI2b7BpEOxmVJSidNMfwMhtKKFhAHAM0ZiQPcdmstorTI1VcSMkD8OUlp
         j1d2IbcpuED+OOFVdY7wgz0dQtk627QvJnZodCiUYuJAuykaFQX+mnkz22/3QT3OSRhE
         vJISlzyRCneUKN5VFpF/Rk49k4xH1ZnUSC0JmBshq6Ydw05uhRZwQyzdSWAwnPOu598x
         55I1vDhdNbH9TKZsACJxqxksOvOAuPyFkxWRrfd1gVuNGxPQ8bKiEUu9JFvkhwRazw9Y
         uhTA==
X-Gm-Message-State: AGi0Puanwu7XvYs5kSkwOGe759ib/C6B4/a46fKmRHrDH28YE7o+Ok3C
        EfmEaxG7H9TcK8/OGDt37LeC1rV7
X-Google-Smtp-Source: APiQypI1U1MNnxh2TRjrMdXiF12FJZh9UP2qG0roEKRQrB+dmlbbOv8XQMoGuJPq2N9B8hNwDPcT7g==
X-Received: by 2002:a05:620a:556:: with SMTP id o22mr600921qko.434.1588683667406;
        Tue, 05 May 2020 06:01:07 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id e24sm1707852qkl.56.2020.05.05.06.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 06:01:06 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] Doc: reference the "stash list" in autostash docs
Date:   Tue,  5 May 2020 09:00:59 -0400
Message-Id: <0b898ca26b0399e9f14b9170f6586014dee80cf5.1588683624.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In documentation pertaining to autostash behavior, we refer to the
"stash reflog". This description is too low-level as the reflog refers
to an implementation detail of how the stash works and, for end-users,
they do not need to be aware of this at all.

Change references of "stash reflog" to "stash list", which should be
provide more accessible terminology for end-users.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    This patch is based on 'dl/merge-autostash-rebase-quit-fix'.

 Documentation/git-merge.txt  | 4 ++--
 Documentation/git-rebase.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index ec06b2f8c2..3819fadac1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -106,12 +106,12 @@ commit or stash your changes before running 'git merge'.
 `MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present in
 which case 'git merge --abort' applies the stash entry to the worktree
 whereas 'git reset --merge' will save the stashed changes in the stash
-reflog.
+list.
 
 --quit::
 	Forget about the current merge in progress. Leave the index
 	and the working tree as-is. If `MERGE_AUTOSTASH` is present, the
-	stash entry will be saved to the stash reflog.
+	stash entry will be saved to the stash list.
 
 --continue::
 	After a 'git merge' stops due to conflicts you can conclude the
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7d0c89a184..fa969d8064 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -257,7 +257,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Abort the rebase operation but HEAD is not reset back to the
 	original branch. The index and working tree are also left
 	unchanged as a result. If a temporary stash entry was created
-	using --autostash, it will be saved to the stash reflog.
+	using --autostash, it will be saved to the stash list.
 
 --apply:
 	Use applying strategies to rebase (calling `git-am`
-- 
2.26.2.548.gbb00c8a0a9

