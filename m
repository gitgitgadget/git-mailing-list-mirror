Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27EEC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68A961073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbhJPJms (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243966AbhJPJlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE068C061780
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p21so4272833wmq.1
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3mlntPm6U4KofzYZF0waMu+lGm+1c2nor+dHQiuOgck=;
        b=A8Ec0jlR56FRVk7Z/hofgf12IBCyCrUBoy32xYzAGtJjln44kIMf3EFoKDHBiyoGVq
         fcj7RDPUUQZ+6u3hBiAiOo8TtXIQb7Yn6x1ynxipmP2tFsinCFK+ejog20O1AHdMWeeD
         4sok8uvfbMdXUcheRhswT/eHlBxLyjJH7qOPkaIhACQG52+cb7z8qWez+S3B1gu7S9lK
         FI2FH89yImvaGtYe847844F5NUvjtugEXbkB21EsT4aFyIx6Dk63UcfSoGRImE3PYSRR
         pxbmcTTNrvDYHq2aaP3KXwtb0EnAKFrHX3Q8oWu7ZvjH+2ObrU3ZfyjLADtuU1jzYo6y
         cc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3mlntPm6U4KofzYZF0waMu+lGm+1c2nor+dHQiuOgck=;
        b=oEk9DBGBlnwEGRyX0bOLmpj3fXFuvBgF0OVVcGP10Z2Nr4KrK663CZMKTqaK74c69P
         72SHGnXxwqBQjEH/z9q5n/sSYWlaTwEqBkWU9OfPwKhMU6bipmA+HeOqc0tqA09SUo73
         MdtLg4sekkZwI7iBhBUkdwNQGNMhSjXHJxhaGurR6orItJQHNPT4iXb8uppEmZcgZ1hP
         tzEu415/XnoTaR8dTnQbr4FFcApnZhp4EslyXWkRK30rN1BHcdh0yeNpCRbyoeTmqIry
         6cyQdzvDQt9z0FnO2rXd0EqSC8vFMgfxFd6FIBSNhoGuWvZkKtYbuqtL2DR08q2GJZYf
         fWyQ==
X-Gm-Message-State: AOAM533n8ds9eBUlgr38nPD8YmCGfVsRM+kmh2/RU3SX1mBX4mFDkKf6
        E1zchNBF32G5JT0xxEoSTkopF50OcfqO5A==
X-Google-Smtp-Source: ABdhPJxNRKYmFQoHs2nGGv5jY+3V5KGIPlXMlztUCRfvUu7hTocGIL1nZynNSNm5JeVesQf1TNs8bg==
X-Received: by 2002:a05:600c:3b24:: with SMTP id m36mr17573853wms.176.1634377178304;
        Sat, 16 Oct 2021 02:39:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/21] refs API: make files_copy_or_rename_ref() et al not set errno
Date:   Sat, 16 Oct 2021 11:39:17 +0200
Message-Id: <patch-v2-11.21-22883846a6a-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

None of the callers of rename_ref() and copy_ref() care about errno,
and as seen in the context here we already emit our own non-errno
using error() in the case where we'd use it.

So let's have it explicitly ignore errno, and do the same in
commit_ref_update(), which is only used within other code in
files_copy_or_rename_ref() itself which doesn't care about errno
either.

It might actually be sensible to have the callers use errno if the
failure was filesystem-specific, and with the upcoming reftable
backend we don't want to rely on that sort of thing, so let's keep
ignoring that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 759c21e88ae..6c854dda533 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1410,9 +1410,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
+	if (!refs_werrres_ref_unsafe(&refs->base, oldrefname,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				&orig_oid, &flag)) {
+				     &orig_oid, &flag, &ignore_errno)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
@@ -1823,10 +1823,12 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 */
 		int head_flag;
 		const char *head_ref;
+		int ignore_errno;
 
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
+		head_ref = refs_werrres_ref_unsafe(&refs->base, "HEAD",
 						   RESOLVE_REF_READING,
-						   NULL, &head_flag);
+						   NULL, &head_flag,
+						   &ignore_errno);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-- 
2.33.1.1338.g20da966911a

