Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB88C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7563610F7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhGTJ64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhGTJ4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A928C0613E5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d2so25508252wrn.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t1cGcruRbiUvTwZ0y1BCNXZXKd3TyRpHQO/UtOTBTlE=;
        b=XKM0ugFt9aPDAW6AWBzNBuH9dBjPvZ/BFooNENBUol841rKr8aLrtutqPepsVCk0dx
         3OM00JBfGsjPJnxlJhH6Shths2JPFtuHvPK/RB7osbTHyU0PLihvaGdEVaFlRUmBWJB1
         cKsc8WZIz2ejpvox+3te3RooUmEXon5geiIZ8ZxWt/WHbx246PiYQrPk7NYZrbzUGicw
         PNTYURgK+1fnO2kdfP45kRGidjsISpHBMH063k1Lw0CWXMQYsnGqyE/XS1c67aFXGAfU
         EyVww48E7My83WQKDyfrapa1ywHFJTnntW87lLAEGuUE499kuZhjsD2hk4fEA/FCcbej
         HBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t1cGcruRbiUvTwZ0y1BCNXZXKd3TyRpHQO/UtOTBTlE=;
        b=CiJvC7ZJITbYF3p2DZnByvPFc4/UlFSfHghjIFbQUFMrk3BCJk7LuodmIGd5TNaPry
         VUgXFnYYqFM0HY3XiSvCxh5pGENkRikG35WDKG+6oCrtxM22EMOvxtY85h0QkSnqSZmN
         o94eTbJBS+iszaozfUtSjmmcb5B9P7wo2+t/GDlQr5dcEEvNHkkwJE4OGTeo+8GUGcnV
         mkTwtirPeaKvlyPcsNM4/En0g1iLgfuZadpw9vtPo8gM7UCbnvF4TuqRtqgBHCmJ33g/
         qvbqtkWBq0ropgDsdc5vl2RuwdSIWHR/uYDr2+jkT6kTjbcdN4jF/Mm+vbOiGgRH1dqd
         US2w==
X-Gm-Message-State: AOAM532v0JRRbv9YTbVanolL76wPH4tZ/TMXvdRlodtv183Z2Mnr5VOZ
        McDPoQJHLn/r1Jo5+wVD6h9PrfhDx9o=
X-Google-Smtp-Source: ABdhPJx9Szes+XgsGuV/Si+r0FKn8T5HRNl4aqYg4/ueB4lu1Lu8D+5MNHR3J92B8gL4n2dPv/6t6g==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr35375279wrx.298.1626777396647;
        Tue, 20 Jul 2021 03:36:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm2243340wme.29.2021.07.20.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:36 -0700 (PDT)
Message-Id: <9b4e4d2674a38b6bed793e0f5661edefa6df5d23.1626777393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:23 +0000
Subject: [PATCH v2 02/12] diff --color-moved=zebra: fix alternate coloring
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index 52c791574b7..cb068f8258c 100644
--- a/diff.c
+++ b/diff.c
@@ -1142,6 +1142,7 @@ static void mark_color_as_moved(struct diff_options *o,
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
 	int n, flipped_block = 0, block_length = 0;
+	enum diff_symbol last_symbol = 0;
 
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
@@ -1149,7 +1150,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-		enum diff_symbol last_symbol = 0;
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
@@ -1214,7 +1214,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			}
 
 			if (adjust_last_block(o, n, block_length) &&
-			    pmb_nr && last_symbol != l->s)
+			    pmb_nr && last_symbol == l->s)
 				flipped_block = (flipped_block + 1) % 2;
 			else
 				flipped_block = 0;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 2c13b62d3c6..920114cd795 100755
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

