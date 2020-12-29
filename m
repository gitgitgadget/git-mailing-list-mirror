Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB28C43331
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A830021D1B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL2UGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgL2UGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C5C06179F
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r4so3039215wmh.5
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f0/XtdIyw6iwQJQ5kZT23INEqlES4/JfjcvNloEQ/Fk=;
        b=hr0BEsck5iBRkNmKF48zG/XaB7SMnB4vprjzei0cPvxMkpTcQaN1fCvsQ86G4/k/v9
         0A2E0u/gKaQni1b7s1rirMVtH9rWoxkaRSl4ncifLbwx6058rta8BvI8Ns/6h6slbILS
         5lW/OiYKmewbxujlC1N00xdD7BdjcqGQ4wmWpoVhHnWMXMU5FAHx3Kj8Q1OnCKIsmT+f
         UvDvDt/G7Q/7qYqzm6hk4T45LbRZaLzs09ZBX0sTvrKnVBKvS9q6pWJ4hfbdoR4WY5dg
         9tuPg2CtxDPhuYi7vYIqZRKA0G7A82oldTHrmvSskEJqri1mTUVqOb2Dn2mydbWKLo42
         kA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f0/XtdIyw6iwQJQ5kZT23INEqlES4/JfjcvNloEQ/Fk=;
        b=JswqKeH/tliIfbtqMcPSX5UveqCc4FYIU2rMh5AdTsl0HzVbAdzwfFpG7vSuDrduE5
         /aCPspcwN07ymulJ5OYgc+xJXrPNzCRr5yLhIyulOqztzW+llhf8zVTRYPDJ451SWOE/
         HySjrzwGEHeLbUHl19k5+3rkYe158ottGuN31nxlV9xagA2wjL8CRfXgaUWRzRCSydfB
         kHTPLC5MwUisJEhXYXQ2nzVK25QK3z4/tvng2wi1YsAx6wJKAGDpnTCUqOT7rRhrUQjG
         /sCsNqLUNuODkQ1U3RU+VqtdVqxv+bu3FgoZarjSibTRZVwpg1W9lMXfixeuzWGLAq8p
         g0SQ==
X-Gm-Message-State: AOAM530osmRzOz7T4kgOpPlhmiEBawSyVpfPsFDdeR01ZSDU197+D7nk
        T12HcUaDSfSQCoN0a1rH2MLxbhGlfwg=
X-Google-Smtp-Source: ABdhPJz6q6TPo+oyt+aFqXmd73iWGoX68klCVL3kWx/qe+jYEgLTFHOiP+cMTbFUILJ1AwQl8uHCkw==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr4555810wma.17.1609272337898;
        Tue, 29 Dec 2020 12:05:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm48041153wra.9.2020.12.29.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:37 -0800 (PST)
Message-Id: <723b0e55e75d264f83407c3fb50f3ccc16d35062.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:28 +0000
Subject: [PATCH v3 9/9] diffcore-rename: remove unnecessary duplicate entry
 checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 25d5ea410f ("[PATCH] Redo rename/copy detection logic.",
2005-05-24) added a duplicate entry check on rename_src in order to
avoid segfaults; the code at the time was prone to double free()s and an
easy way to avoid it was just to turn off rename detection for any
duplicate entries.  Note that the form of the check was modified two
commits ago in this series.

Similarly, commit 4d6be03b95 ("diffcore-rename: avoid processing
duplicate destinations", 2015-02-26) added a duplicate entry check
on rename_dst for the exact same reason -- the code was prone to double
free()s, and an easy way to avoid it was just to turn off rename
detection entirely.  Note that the form of the check was modified in the
commit just before this one.

In the original code in both places, the code was dealing with
individual diff_filespecs and trying to match things up, instead of just
keeping the original diff_filepairs around as we do now.  The
intervening change in structure has fixed the accounting problems and
the associated double free()s that used to occur, and thus we already
have a better fix.  As such, we can remove the band-aid checks for
duplicate entries.

Due to the last two patches, the diffcore_rename() setup is no longer a
sizeable chunk of overall runtime.  Thus, in a large rebase of many
commits with lots of renames and several optimizations to inexact rename
detection, this patch only speeds up the overall code by about half a
percent or so and is pretty close to the run-to-run variability making
it hard to get an exact measurement.  However, with some trace2 regions
around the setup code in diffcore_rename() so that I can focus on just
it, I measure that this patch consistently saves almost a third of the
remaining time spent in diffcore_rename() setup.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c          | 23 -----------------------
 t/t4058-diff-duplicates.sh |  2 +-
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2a8fcd52928..90db9ebd6d0 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -34,18 +34,6 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filepair *p)
  */
 static int add_rename_dst(struct diff_filepair *p)
 {
-	/*
-	 * If we have multiple entries at the same path in the destination
-	 * tree (an invalid tree, to be sure), turn off rename detection
-	 * entirely.  Once upon a time, diffcore-rename had double free()
-	 * issues due to such duplicate paths, resulting in segfaults.  See
-	 * commit 4d6be03b95 ("diffcore-rename: avoid processing duplicate
-	 * destinations", 2015-02-26).
-	 */
-	if (rename_dst_nr > 0 &&
-	    !strcmp(rename_dst[rename_dst_nr-1].p->two->path, p->two->path))
-		return -1;
-
 	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
 	rename_dst[rename_dst_nr].p = p;
 	rename_dst[rename_dst_nr].filespec_to_free = NULL;
@@ -63,17 +51,6 @@ static int rename_src_nr, rename_src_alloc;
 
 static void register_rename_src(struct diff_filepair *p)
 {
-	/*
-	 * If we have multiple entries at the same path in the source tree
-	 * (an invalid tree, to be sure), avoid using more more than one
-	 * such entry in rename detection.  Once upon a time, doing so
-	 * caused segfaults; see commit 25d5ea410f ("[PATCH] Redo
-	 * rename/copy detection logic.", 2005-05-24).
-	 */
-	if (rename_src_nr > 0 &&
-	    !strcmp(rename_src[rename_src_nr-1].p->one->path, p->one->path))
-		return;
-
 	if (p->broken_pair) {
 		if (!break_idx) {
 			break_idx = xmalloc(sizeof(*break_idx));
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index ad3f37d388d..54614b814db 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -91,7 +91,7 @@ test_expect_success 'diff-tree between duplicate trees' '
 test_expect_success 'diff-tree with renames' '
 	# See NOTICE at top of file.
 	git diff-tree -M -r --no-abbrev one two >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'diff-tree FROM duplicate tree' '
-- 
gitgitgadget
