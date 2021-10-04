Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1563AC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CCF6124F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhJDAsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhJDAsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833EC061787
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r7so12014177wrc.10
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2gDr1/7/NG70W4XTmct3idmTdsijB5o0xLFQ3c8ch3w=;
        b=VjjOtLBavnMgoQjUqjmEmQFU0Yick2oTtBXtna4Mz75dasPpVYpNlSE2E9NeStlA/t
         r4RpnUY0TtEr9VpMTd5WrZgdfyZTAXLEh+OKea9snuPEjNJO3pw6yALPKrEbEms6wQP2
         yLzAYjc3q6STTNGry7tI4rx0Ys9dHEYxUzFTCwGGeAA+AgnMHrJ5RS9Bys5qIQGt7YBm
         hbCE3N/GR/6Hyf10DrzjKfmvHPrF/EbY/+DWMWbUzLblRcNPZhFKtodzlAqxnMTOUFvu
         WC+qWeI20hIxRzaBA4sbbFsEcyCaRLJsupxF+cfdcWnJorVvJ+gkZh8fK2H3Mf8OI7Hb
         cJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gDr1/7/NG70W4XTmct3idmTdsijB5o0xLFQ3c8ch3w=;
        b=vH3ajgYbkzjbAPo4ZIjILwaY0Ew1nj1hnrkfORzZDHwmecdhbzjgAptr4LgPcmEZBd
         Q6gGO7qNH2doa6j0hgqjyFzf5qZ63YJVF2VGFXmEHBUwBFIJfpNcg7xY6eKc+2Ij+DMH
         qh1WyHME803l5fTL6fotmG9qBKvQeL84XAzFDFJVU4+WcClSjdfPmXsrQVR48r/6iyMQ
         fP3rs9AGgN3lW7OK7YQza6VVzgTiJcJ7sjO+TDCIkLK7HyU6u8cvFJqTwPHbQJxeeTi+
         cXk7U2ZvIWVJJQgcS3+1u5eb6Tb/EY+o/JtV7UeHSrJs6sDXW2xBaIqfw/FcSNmjvcog
         B5RA==
X-Gm-Message-State: AOAM530Maa09D1u1x1D/HdPV8cOAETC/RFp1rNubSLJbNP3qSNo0TBOP
        8HODUGGkO55LK2gCBtPlfu8fJlXEcG+hMg==
X-Google-Smtp-Source: ABdhPJxZZ+JS0OwoFloKg/VmaPmerYEO+Mysvkgm80ZNqpUFb1fKwy+OFokMxsmy6Rx5jQWGEv/Ufw==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr10864824wry.19.1633308382445;
        Sun, 03 Oct 2021 17:46:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] unpack-trees: don't leak memory in verify_clean_subdirectory()
Date:   Mon,  4 Oct 2021 02:46:09 +0200
Message-Id: <patch-08.10-32acc5e5c9e-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two different but related memory leaks in
verify_clean_subdirectory(). We leaked both the "pathbuf" if
read_directory() returned non-zero, and we never cleaned up our own
"struct dir_struct" either.

 * "pathbuf": When the read_directory() call followed by the
   free(pathbuf) was added in c81935348be (Fix switching to a branch
   with D/F when current branch has file D., 2007-03-15) we didn't
   bother to free() before we called die().

   But when this code was later libified in 203a2fe1170 (Allow callers
   of unpack_trees() to handle failure, 2008-02-07) we started to leak
   as we returned data to the caller. This fixes that memory leak,
   which can be observed under SANITIZE=leak with e.g. the
   "t1001-read-tree-m-2way.sh" test.

 * "struct dir_struct": We've leaked the dir_struct ever since this
   code was added back in c81935348be.

   When that commit was written there wasn't an equivalent of
   dir_clear(). Since it was added in 270be816049 (dir.c: provide
   clear_directory() for reclaiming dir_struct memory, 2013-01-06)
   we've omitted freeing the memory allocated here.

   This memory leak could also be observed under SANITIZE=leak and the
   "t1001-read-tree-m-2way.sh" test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 unpack-trees.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index bea598c9ece..260e7ec5bb4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2138,9 +2138,10 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 
 	d.exclude_per_dir = o->dir.exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
+	dir_clear(&d);
+	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
-	free(pathbuf);
 	return cnt;
 }
 
-- 
2.33.0.1404.g83021034c5d

