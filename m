Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ECCC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2475611AE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhJGJsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhJGJsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 05:48:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0464AC061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 02:46:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t8so17303640wri.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFCN7Aazo/ILNKg4fcrkalc+Ra/lGQ7IkaLgmAVCWs0=;
        b=ER/E9WX4jr9qNEWuEmPY3PeZQdHY/DX6uprFcQybassoHyiuGPgj4kuWborsDOWY6y
         Swfet1w5XVOo1fwyq+fw8bWoyWgen6+8cnSYqzjAYKLTyvymYgjgtSWrYJjwJapy7WPS
         jxUUf+Cm7GhIZBFQocv+Gfqm8JapnlMe+DsT8cy7joeA6WhCOzE4KFhDxuISe7jrhIzb
         cfZyeivqi7Ba6OcY1KPE+jRVorrsJTAbJgL5eWHwqMXWUkN3nEb2j1VvrTRpZhYr5cP2
         xKHuokNZZQqhK47aGtuW1vN0YbF6V+ffPtwg9p/JQL/IefCiOh3DIh3TBwS3a/r043kE
         fAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFCN7Aazo/ILNKg4fcrkalc+Ra/lGQ7IkaLgmAVCWs0=;
        b=1IwdZVeez2intunoUv6LAI4V47LRvA4zq06qV4M1baFFTVY3r7ByYEytuH+wllV5VI
         z5DhZBjcQnzxoVwoseUAblIwwf0wBO9K08c7tnWpyQ2BqE5KDurcTz+dMLEpwtaIqy1z
         r3B1CcnSaJhqEfz5kNm5Bg8cUyZl2+hfcHNSLX/epEDwCN9QNAbYws7M2oUuGznOyoj2
         geceOhA3hb9INGhMaEVAwgdcTqBmjf4EqqdYTsRgj8KSVMlb0xHZSnLpfXvgAG5qSups
         bUL+lRfGU+5DfzbesXOiQ90mdh0mapGI07YHDAxObKxRGjDNvxHnvTvFk39XfyZk+52H
         GO5w==
X-Gm-Message-State: AOAM533VQacEiFHFRRwa7otxwmf9mFlbF1Vio8FQvZ7EM+nhSwxFlS6u
        urfasBN5o21vnsEPdfHMK4rAuYtUHU+Bgg==
X-Google-Smtp-Source: ABdhPJwWYjTHgxt6eg0rjqpGfYDKCn4uABGixbZYWlb4eVCFhulHcOBU/cEsKKNZtYJWpr4dp9IxfA==
X-Received: by 2002:a05:6000:44:: with SMTP id k4mr4060959wrx.68.1633599974345;
        Thu, 07 Oct 2021 02:46:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l13sm7720489wme.38.2021.10.07.02.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 02:46:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] unpack-trees: don't leak memory in verify_clean_subdirectory()
Date:   Thu,  7 Oct 2021 11:46:09 +0200
Message-Id: <patch-v2-1.3-e5ef1be2aa9-20211007T094019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
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

This makes all the test in "t1001-read-tree-m-2way.sh" pass under
"GIT_TEST_PASSING_SANITIZE_LEAK=true", we'd previously die in tests
25, 26 & 28.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1001-read-tree-m-2way.sh | 2 ++
 unpack-trees.c              | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 1057a96b249..d1115528cb9 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -20,6 +20,8 @@ In the test, these paths are used:
 	rezrov  - in H, deleted in M
 	yomin   - not in H or M
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/unpack-trees.c b/unpack-trees.c
index a7e1712d236..89ca95ce90b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2156,9 +2156,10 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
+	dir_clear(&d);
+	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
-	free(pathbuf);
 	return cnt;
 }
 
-- 
2.33.0.1446.g6af949f83bd

