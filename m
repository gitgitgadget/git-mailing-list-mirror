Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11ADC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhLIKd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbhLIKdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771BAC061D5F
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so8813825wrd.9
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/21tYvfclPNJep2HNK27H7vRi4XW03mypSl62mMt2g=;
        b=pq4dmQ4k5cyB56ULn6T6R3UXO3iQsB9s+6BZyYNycW80AsaJ+dy6dqnogq47dmkxCa
         d4zcxYCUe75f+GS7lXVNx8+VTU6F3KvCDIMg4u0/BdrV6oTpwtoY4MCeOClBVFzwI0sI
         0BD8nPvOM/ashdpSj3tOWiYsCmtrdYKp20FNLA55eEN4n2b2k8fHfbQjTyI6274N+Xnj
         yx2Dv67ql/uqqLZ4uDw4qV1eQCWAguGCODYh4zkFm2LWIwggt4KESD9sVIhEtFoOobcP
         +/avNZLGIjSGgqixOlX76DTzpL3VgWgkWQw2L7/UTenDNMZIjLBKUyhBpHJ6d93fd1iW
         BPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/21tYvfclPNJep2HNK27H7vRi4XW03mypSl62mMt2g=;
        b=cqudpZTk/eCDpeaA9xPBgfdse8niTypxRIh8EyM2HRuWK/xdaMPPZkawKSXB+iuZcb
         fRvZr/GEMtcFP2AOVgGtk4m8tUQ5NLGhRnaM4Ag3J1RYvgc14Jg+bM4EiHnb7j2usfGy
         noVmJnxY0TXokqT+EkZe3j+W0J1p6ZWpWbeFNb6vjhaXjtPCisoFU4jK+TVjGdNwLGVa
         UhMVrjsI8JLEVVemmg+p9fB6GW8iWvy+JaMGPLRSeI0n0Q/e/oeUS6S9KzDlmOO80q7w
         2VyteyIAsJLhXL5Jh4yb3GQzGjHvNItMqWDu1p7BpPRWeuFbuJism8PjYhlYGV/vvlY1
         D9PA==
X-Gm-Message-State: AOAM533Ptmw8203lEHJBxrGh/r9pW4xHNdjPsoohoPbuVrahEcLJhUrq
        EVwd03ioNbMOKjXBfXxuSus3u+KhT30=
X-Google-Smtp-Source: ABdhPJyKaXYgAh0bi0RvkcudASq5ue8Rma4cM+rn2wQ/db+OjCNO7viThTSnlKmZz6Qi7T50bw7hWQ==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr5577901wrn.257.1639045815717;
        Thu, 09 Dec 2021 02:30:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p62sm5297069wmp.10.2021.12.09.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:15 -0800 (PST)
Message-Id: <56bb69af36e5e3180d53586d30048d5033a01d14.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:29:59 +0000
Subject: [PATCH v5 05/15] diff --color-moved=zebra: fix alternate coloring
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

b0a2ba4776 ("diff --color-moved=zebra: be stricter with color
alternation", 2018-11-23) sought to avoid using the alternate colors
unless there are two adjacent moved blocks of the same
sign. Unfortunately it contains two bugs that prevented it from fixing
the problem properly. Firstly `last_symbol` is reset at the start of
each iteration of the loop losing the symbol of the last line and
secondly when deciding whether to use the alternate color it should be
checking if the current line is the same sign of the last line, not a
different sign. The combination of the two errors means that we still
use the alternate color when we should do but we also use it when we
shouldn't. This is most noticable when using
--color-moved-ws=allow-indentation-change with hunks like

-this line gets indented
+    this line gets indented

where the post image is colored with newMovedAlternate rather than
newMoved. While this does not matter much, the next commit will change
the coloring to be correct in this case, so lets fix the bug here to
make it clear why the output is changing and add a regression test.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     |  4 +--
 t/t4015-diff-whitespace.sh | 72 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 1e1b5127d15..53f0df75329 100644
--- a/diff.c
+++ b/diff.c
@@ -1176,6 +1176,7 @@ static void mark_color_as_moved(struct diff_options *o,
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
 	int n, flipped_block = 0, block_length = 0;
+	enum diff_symbol last_symbol = 0;
 
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
@@ -1183,7 +1184,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-		enum diff_symbol last_symbol = 0;
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
@@ -1251,7 +1251,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb, &pmb_alloc,
 							    &pmb_nr);
 
-			if (contiguous && pmb_nr && last_symbol != l->s)
+			if (contiguous && pmb_nr && last_symbol == l->s)
 				flipped_block = (flipped_block + 1) % 2;
 			else
 				flipped_block = 0;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 308dc136596..4e0fd76c6c5 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1442,6 +1442,78 @@ test_expect_success 'detect permutations inside moved code -- dimmed-zebra' '
 	test_cmp expected actual
 '
 
+test_expect_success 'zebra alternate color is only used when necessary' '
+	cat >old.txt <<-\EOF &&
+	line 1A should be marked as oldMoved newMovedAlternate
+	line 1B should be marked as oldMoved newMovedAlternate
+	unchanged
+	line 2A should be marked as oldMoved newMovedAlternate
+	line 2B should be marked as oldMoved newMovedAlternate
+	line 3A should be marked as oldMovedAlternate newMoved
+	line 3B should be marked as oldMovedAlternate newMoved
+	unchanged
+	line 4A should be marked as oldMoved newMovedAlternate
+	line 4B should be marked as oldMoved newMovedAlternate
+	line 5A should be marked as oldMovedAlternate newMoved
+	line 5B should be marked as oldMovedAlternate newMoved
+	line 6A should be marked as oldMoved newMoved
+	line 6B should be marked as oldMoved newMoved
+	EOF
+	cat >new.txt <<-\EOF &&
+	  line 1A should be marked as oldMoved newMovedAlternate
+	  line 1B should be marked as oldMoved newMovedAlternate
+	unchanged
+	  line 3A should be marked as oldMovedAlternate newMoved
+	  line 3B should be marked as oldMovedAlternate newMoved
+	  line 2A should be marked as oldMoved newMovedAlternate
+	  line 2B should be marked as oldMoved newMovedAlternate
+	unchanged
+	  line 6A should be marked as oldMoved newMoved
+	  line 6B should be marked as oldMoved newMoved
+	    line 4A should be marked as oldMoved newMovedAlternate
+	    line 4B should be marked as oldMoved newMovedAlternate
+	  line 5A should be marked as oldMovedAlternate newMoved
+	  line 5B should be marked as oldMovedAlternate newMoved
+	EOF
+	test_expect_code 1 git diff --no-index --color --color-moved=zebra \
+		 --color-moved-ws=allow-indentation-change \
+		 old.txt new.txt >output &&
+	grep -v index output | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/old.txt b/new.txt<RESET>
+	<BOLD>--- a/old.txt<RESET>
+	<BOLD>+++ b/new.txt<RESET>
+	<CYAN>@@ -1,14 +1,14 @@<RESET>
+	<BOLD;MAGENTA>-line 1A should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;MAGENTA>-line 1B should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1A should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1B should be marked as oldMoved newMovedAlternate<RESET>
+	 unchanged<RESET>
+	<BOLD;MAGENTA>-line 2A should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;MAGENTA>-line 2B should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;BLUE>-line 3A should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;BLUE>-line 3B should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3A should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3B should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2A should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2B should be marked as oldMoved newMovedAlternate<RESET>
+	 unchanged<RESET>
+	<BOLD;MAGENTA>-line 4A should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;MAGENTA>-line 4B should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;BLUE>-line 5A should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;BLUE>-line 5B should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;MAGENTA>-line 6A should be marked as oldMoved newMoved<RESET>
+	<BOLD;MAGENTA>-line 6B should be marked as oldMoved newMoved<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6A should be marked as oldMoved newMoved<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6B should be marked as oldMoved newMoved<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4A should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4B should be marked as oldMoved newMovedAlternate<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5A should be marked as oldMovedAlternate newMoved<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5B should be marked as oldMovedAlternate newMoved<RESET>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMoved "magenta" &&
 	test_config color.diff.newMoved "cyan" &&
-- 
gitgitgadget

