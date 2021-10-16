Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EEEC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A42260E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbhJPJnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244019AbhJPJlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8BC061773
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g25so30589256wrb.2
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0jdE3rAtOsRNXSpEG0dZSOUDxM8h+0jyvekDqckdMQ=;
        b=odfe8maRtm37ngUOUJE1UJrmeQbDWVQ+5GcvZrEPvFLCt/re99UTfwSLA1GKbsUYIu
         ASE4VmHQA/RLgQRiBbj1+Qk8/Fg7X1OuLckp4cV/OMdHxvtVn4+ObRF/tVNn+8SO1rYE
         ZSqITrmzOPgJw2OwiJvvNZO7WprLaDBKz+4ZJ/jQh1diLebS3C2ehzgyEJpdnq1aaxYw
         FZ5ij/o8EHbCxWmDJ+iuAvFuEZVacTePUje+tCJMrPYAH73RQ+/ZVDUf/lv2jrHJltSO
         MYwC0l9eGpMg0a+XP7sa5ykqfwkdMo7zzknmiFB29/DP0iVT5aS5niaMHw4RdTCtv2wc
         tujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0jdE3rAtOsRNXSpEG0dZSOUDxM8h+0jyvekDqckdMQ=;
        b=uuUALVRg1zeFcbm9jTAsBcGFXViF44ELh48Oo54jZbzDBns6Ejc1X2wt22jBXwnuEu
         3wZxFfE9gBR4FETl6V7b14R0OJdR2UyUg+BQ+CIkw51fQiy94GSG2eVIFLjwNJnzBXp/
         s9xvSQUUHqAYPv4STpANz9RGUNj1Lc4n17a4wmB3bf9t4p85Dk8zoY8jQ/aeV603JiPZ
         XpkL2t1PDv1Y/nyHEQLFAPYsdfK8rZPLL9KnZ5uo6HxBHdzMorIasI6JSLhit6hizTYS
         pOIuNbqQUuTBCuzjRlSrwL6XhYMHwDiKeVKooq74HYgCZjIcFWKbfxjsSWZclahJJixv
         8adw==
X-Gm-Message-State: AOAM5336CXh7op1+BI6M6DMCltD0OgNIXC7+3EDda3vDu+Jy6iFgwan0
        vb29b3gyH7CzLS0caUjXk62ewnfc+NnKXQ==
X-Google-Smtp-Source: ABdhPJx+OeHNzRqBlM9IOTIGc9bzRRZ3T0/bmTfqUTuil3wBA4xvk3o4cJty0AwyEWLKNTCpAwHj0Q==
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr20213433wrc.257.1634377179810;
        Sat, 16 Oct 2021 02:39:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/21] refs API: ignore errno in worktree.c's find_shared_symref()
Date:   Sat, 16 Oct 2021 11:39:19 +0200
Message-Id: <patch-v2-13.21-38f5f54938f-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
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
2.33.1.1338.g20da966911a

