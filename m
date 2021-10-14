Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD6C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B2161152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhJNAJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJNAIw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A4C06176C
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so13820063wrc.10
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GA+RHp46ay6iCXjwSgGrKy9Rll3MkBt+CEWq4husYJg=;
        b=BlvH1GCYtDtfMjMBP+bmwrpFr7siu/kJb5IW0vPMIp8eLRPb0iYyeytZEFVtbKPWCu
         QpzNLHwsf6xuTJioH9IB4Rg5D2wYrBdl5GEejJNd8wrbau522Co5IXUSGIrPF63ThZAz
         qCF+LMAZEbxA0vFLCLURNOeI/bZIrLZ1TbqWOTOkrzdpEOqUF4RagNwcEqHxoNq/xD2P
         m/u6a/AjMtH2cR+OQMfGfJqzzQVYYoBUKtUVfh60bRo1K27tNju5N5wFBbmL9PFRivgQ
         Z/UzRAlcCiL29vK+/tdpLjMAbDKOzgP8r+TiFTH+VSsracR2hrL/HMEBzBSdxr7Vepua
         ewgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GA+RHp46ay6iCXjwSgGrKy9Rll3MkBt+CEWq4husYJg=;
        b=Di0T6M9Ic6EI/M2ZEfroR1mF9SQq9lsBh06uTamzUHpXVmEcnTS9eIa9xtBeL8C3Xu
         tuEbUCB5LGdRWA5H0qyaDaep8tYc/EBemW5nbb3ILK9em46AZImpO3xbv54MQVpgg4ed
         3IiMHexbs7UXjThBW/0e/B7lVYFCuJFZJb1d6gNmm3s0qUwYmKw1/jUddNk/YAUD86a7
         Dul1IBUc49BGo4CKj+zgvMBeckNG6USm1IWn6j0dbdSIljJB5+jp4568GdBL3bI0YoAS
         fUOV2HPmkU6tyZM71jzl4LX2w1LwG6hhnS+WTu8jP2YjHM4h6PFMelRpNLPuekhbnk1k
         JmBQ==
X-Gm-Message-State: AOAM530tyLHvlEAj6kHHPsH8SWNPE5J9Uw2kDzKhap/crcI2PaTBpJ2B
        Ap3r9ZCZTVhBzQYNTVlqRGNHKnUVXrgvTw==
X-Google-Smtp-Source: ABdhPJwdmh7C5SbZ/MOM/zepZI5lgM9uBTOGmRzMcRKVFIJ4Xe7IstWwQkaeP8PeZZ/W0G32TKXWsA==
X-Received: by 2002:adf:a347:: with SMTP id d7mr2724174wrb.139.1634170003685;
        Wed, 13 Oct 2021 17:06:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/20] refs API: ignore errno in worktree.c's find_shared_symref()
Date:   Thu, 14 Oct 2021 02:06:24 +0200
Message-Id: <patch-12.20-8d87db98041-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are only handful of callers of find_shared_symref(), none of
whom care about errno, so let's migrate to the non-errno-propagating
version of refs_resolve_ref_unsafe() and explicitly ignore errno here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index fa988ee978f..7d7cf058154 100644
--- a/worktree.c
+++ b/worktree.c
@@ -420,6 +420,7 @@ const struct worktree *find_shared_symref(const char *symref,
 		const char *symref_target;
 		struct ref_store *refs;
 		int flags;
+		int ignore_errno;
 
 		if (wt->is_bare)
 			continue;
@@ -436,8 +437,9 @@ const struct worktree *find_shared_symref(const char *symref,
 		}
 
 		refs = get_worktree_ref_store(wt);
-		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
-							NULL, &flags);
+		symref_target = refs_werrres_ref_unsafe(refs, symref, 0,
+							NULL, &flags,
+							&ignore_errno);
 		if ((flags & REF_ISSYMREF) &&
 		    symref_target && !strcmp(symref_target, target)) {
 			existing = wt;
-- 
2.33.1.1346.g48288c3c089

