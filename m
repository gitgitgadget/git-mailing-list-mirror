Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B08EC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJDN0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJDN0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:26:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F81276C
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so9042763wrt.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kCcuz/mmx8LGhkDD+YkP+/Mz0j4n8ic46mgCI2seW8=;
        b=boZo9PeExbOGog2VWKBgdsKHp+ZW0Gmy8vVmpdBGyf6SOOxOBoZNbR3K4TaCpisWdm
         LkC8mTN4zU2q8qEoiTI3HrEsr+8ODqrp8N5ujTTJMceF+q4pzvbu2AFrza6UvlFERhGQ
         tNr5oH6LJTsn3JcpvDg2titKa+IlHCiurDusN7wmaZU1//5iRBGF5wtYjfXaYbPqGlLg
         8UFhX8r2mPfhgTORsHWMA7givvFQdOdUVeC2pC0UBZDOhkSP7BgWxjdEQa5govGuR0zR
         4qHRDcjxJLy6NW1ewe+vogHJXEg9bgDgMzNRWQTYnFy9Wxo6B/91C/iTH+gsHkNFqZ5x
         rPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kCcuz/mmx8LGhkDD+YkP+/Mz0j4n8ic46mgCI2seW8=;
        b=c8Gu+DxIa4g7YI1KwL8cmXRXbsJmS718g+uaKdoN1OcwDuPrfKf6nnKzZ7yTPuI+fD
         cWN3fJFMN5JQVXTszreDdwtGYQJpLa/XrJwBxf9xNKptOm9k/gpqdhAc117zrgglTkM8
         EfKKuCoOyqQUV0a7+XHiLXIIwQ095hcBHljj+YLqOc1q9Wo/HCr4c5+c/r2Yshfqk179
         8mjXZYSOqDu8HRfr8K10imLNx39CVkriC4bu6cNYexoGM6cXLSqk7S6csOnQRdCDlg+b
         o1kunq435gSYKxjnzHy8Zv1XVNnYREUc1iSCpee+8UQckq0/s/TO+xMQs4kdH142dU8F
         ydPw==
X-Gm-Message-State: ACrzQf3Uby9E/qAjbifFNdIY+fZ4rQ/MUCw1oIrhQ+r5cWTFdDp26f24
        k22h0NgOeczGhBKlXHmRgU8yxiHA2ZWyoQ==
X-Google-Smtp-Source: AMsMyM6AC4WinTM5TiJTcgRqD0sHppvSnfYEhxKMMMS1NR1cK5Ha6OwIcJPaUZvNftlaJecCoc/9Hw==
X-Received: by 2002:adf:fe0f:0:b0:22e:482b:b63a with SMTP id n15-20020adffe0f000000b0022e482bb63amr3724135wrr.586.1664889871952;
        Tue, 04 Oct 2022 06:24:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 32/34] doc txt & -h consistency: make "worktree" consistent
Date:   Tue,  4 Oct 2022 15:23:46 +0200
Message-Id: <patch-v4-32.34-ea82721b057-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "worktree" -h output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index ba6846c3788..4a24d53be15 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -16,17 +16,18 @@
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
-	N_("git worktree add [<options>] <path> [<commit-ish>]")
+	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
+	   "                 [-b <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
-	N_("git worktree list [<options>]")
+	N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
-	N_("git worktree lock [<options>] <path>")
+	N_("git worktree lock [--reason <string>] <worktree>")
 #define BUILTIN_WORKTREE_MOVE_USAGE \
 	N_("git worktree move <worktree> <new-path>")
 #define BUILTIN_WORKTREE_PRUNE_USAGE \
-	N_("git worktree prune [<options>]")
+	N_("git worktree prune [-n] [-v] [--expire <expire>]")
 #define BUILTIN_WORKTREE_REMOVE_USAGE \
-	N_("git worktree remove [<options>] <worktree>")
+	N_("git worktree remove [-f] <worktree>")
 #define BUILTIN_WORKTREE_REPAIR_USAGE \
 	N_("git worktree repair [<path>...]")
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
-- 
2.38.0.rc2.935.g6b421ae1592

