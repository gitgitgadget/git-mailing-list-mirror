Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7CC433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6385564DEB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhBOQDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhBOPvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:51:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4599DC061222
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:50:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o10so4462341wmc.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWehV4mXxzX5rQqkLgKeK3M1OZAWlbGKq7lUzT82qJs=;
        b=B1cpa3FsyrjI8stF3bwq2M8IhproPaeZNjXoEUGqqCsFQtwlEwUIoRZZCNZlcLz2YK
         eM1pPUsdXYyopCz7TfgTumdbCRjn5xRGBzclQJXrFbQGWyxxljyXCi99Fpfu6bAwgCZq
         ZwpeBkrxSkb/cKNwfK+zA9TQM7MO5rEV60daK0s89QuRE0mq+mA464YAGQv6vVtpUCtt
         sq3/26dAtr4FwUaTdYc9QOtMwnVi/28lVkxkqWxGvuPUEBsETZO7fBKoZ2dYMkNQNxJk
         wZ6U9XqihJwmiJkNxv/jTkeeicXRgFcLEpVHSaFU5pWW/Ql5XVgwXG27dy86dVAqV9yo
         CTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWehV4mXxzX5rQqkLgKeK3M1OZAWlbGKq7lUzT82qJs=;
        b=HISWZb4LiNukYa9QC1pEPUkZKzyzdG+la9oiL7STah1bPf0Yroqnnl8W6HgQqeUAku
         2HqjAm3GFAZzrC4cURwFGfQhU1v4SEhOHylaX8fe8lk7gN7Dss2f5RxAkFUJd+t695zv
         recwpbMuAaHzd8BDaVe69ac2WzU4fuoQKH83tq1lFYmHDkazmJceRZZfSL/sMY4O/oI0
         JDKKdtNlPDxpcdnt6CmGuaKJsiwWYvY1Ft6KfcaqTF6B1CqwIhjX+yyFQWYJNvEYByb1
         vwwFVC4hHGBc+CfECkrMVQUiV/+N/6AXZT0wFb6E8MLivvH4pomLOfHCLKFvzvtoZsj1
         UYDg==
X-Gm-Message-State: AOAM531HB0defebzX733H/IbPvly2EMK+O4G8qxUakHxZeOxMG96F90F
        oQzHJQzHqo23NvnTOXpbhpO8/vVeVeWD/w==
X-Google-Smtp-Source: ABdhPJxcNppUFVHZM5Xyq4FvHo9zPMwrLDaQ66o7Qj1E1dsGlTCFu2H+G4yjwnJJTlnqS8Ie3wHXoQ==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr14915626wmb.78.1613404234728;
        Mon, 15 Feb 2021 07:50:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 75sm9672617wma.23.2021.02.15.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:50:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] diff: do not display hunk context under -W
Date:   Mon, 15 Feb 2021 16:50:19 +0100
Message-Id: <20210215155020.2804-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix what I believe to be a long-standing bug in how "-W" interacts
with displaying the hunk context on the @@ line: It should not be
displayed at all under -W.

The long-standing semantics of how -W works and interacts with -U<n>
are rather easy to reason about:

 * -W extends the context line up to the start of the function. With
    userdiff this means the language-aware regex rules in userdiff.c,
    or user-supplied rules.

 * -U<n>, which defaults to -U3 shows at least <n> lines of context,
    if that's greater than what we'd extend the context to under -W
    then -U<n> wins.

 * When showing the hunk context we look up from the first line we
   show of the diff, and find whatever looks like useful context above
   that line.

Thus in e.g. the xdiff/xemit.c change being made in this commit we'll
correctly show "xdl_emit_diff()" in the hunk context under default
diff settings.

But if we viewed it with the -W option we'd show "is_empty_rec()",
because we'd first find the "xdl_emit_diff()" context line, extend the
diff to that, and then would go look for context to show again.

I don't think this behavior makes any sense, our context in this case
is what we're guaranteed to show as part of the diff itself.

The user already asked us to find that context line and show it, we
don't need to then start showing the context above that line, which
they didn't ask for.

This new behavior does give us the edge case that if we e.g. view the
diff here with "-U150 -W" we'd previously extend the context to the
middle of the "is_func_rec()" function, and show that function in the
hunk context. Now we'll show nothing.

I think that change also makes sense. We're showing a change in the
"xdl_emit_diff()" function. That's our context for the change. It
doesn't make sense with -W to start fishing around for other
context.

Arguably in that case we could save away the context we found in the
"XDL_EMIT_FUNCCONTEXT" in "xdl_emit_diff()" and show that if we end up
extending the diff past the function, either because of a high -U<n>
value, or because our change was right at the start.

I wouldn't really mind if we did that, perhaps it would be a useful
marker with high -U<n> values to remind the user of what they're
looking at, but I also don't see the usefulness in practice, so let's
punt that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/diff-options.txt | 4 ++++
 t/t4015-diff-whitespace.sh     | 2 +-
 t/t4018-diff-funcname.sh       | 7 +++++++
 xdiff/xemit.c                  | 4 +++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e5733ccb2d..8ca59effa7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -759,6 +759,10 @@ endif::git-format-patch[]
 	The function names are determined in the same way as
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
++
+When showing the whole function for context the "@@" context line
+itself will always be empty, since the context that would otherwise be
+shown there will be the first line of the hunk being shown.
 
 ifndef::git-format-patch[]
 ifndef::git-log[]
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 8c574221b2..0ffc845cdd 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2133,7 +2133,7 @@ test_expect_success 'combine --ignore-blank-lines with --function-context 2' '
 		--ignore-blank-lines --function-context a b >actual.raw &&
 	sed -n "/@@/,\$p" <actual.raw >actual &&
 	cat <<-\EOF >expect &&
-	@@ -5,11 +6,9 @@ c
+	@@ -5,11 +6,9 @@
 	 function
 	 1
 	 2
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 80f35c5e16..f3374abd98 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -91,6 +91,13 @@ test_diff_funcname () {
 		fi
 	' &&
 
+	test_expect_success "$desc -W" '
+		git diff -U0 -W "$what" >W-U0-diff &&
+		echo >W-U0-expected &&
+		last_diff_context_line W-U0-diff >W-U0-actual &&
+		test_cmp W-U0-expected W-U0-actual
+	' &&
+
 	test_expect_success "$desc (accumulated)" '
 		git diff -U1 "$what".acc >diff &&
 		last_diff_context_line diff >actual.lines &&
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 9d7d6c5087..02b5dbcc70 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -274,7 +274,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		 */
 
 		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
-			get_func_line(xe, xecfg, &func_line,
+			get_func_line(xe, xecfg,
+				      xecfg->flags & XDL_EMIT_FUNCCONTEXT
+				      ? NULL : &func_line,
 				      s1 - 1, funclineprev);
 			funclineprev = s1 - 1;
 		}
-- 
2.30.0.284.gd98b1dd5eaa7

