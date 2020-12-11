Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC4C1B0E3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EC623F59
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437424AbgLKJKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437405AbgLKJKO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:10:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5465C06138C
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c5so4597747wrp.6
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f0/XtdIyw6iwQJQ5kZT23INEqlES4/JfjcvNloEQ/Fk=;
        b=Sl7+pOdYsuoAKsMVMdFHd5BvmrkGmHsQadclhJTQwCbi+nlzI47Zt94x4cEG9Zrpkj
         bCPYFTJfVtoSeqOIbVMsTUfzzD8HuVib1zwB8znSkrbmt7jp3sO11T17oCMZs568o9Dk
         I5i3P54hd+T6RB8uJMv4LgMorSSbdLNO98h5RKeV//uabJmwxacpIcAhPVeyOj7SppHS
         bwUloWSwKRQ80TupI30dwt1VPyyWuTBCCYkghpXBS2/ZXIK8tDeOAMNO+F3Y8xhyxaHC
         wcrSa2hXsircGVlgn1FLJEGu20lDr56sxoO+N7DTsZCzxjPuDU81nrxVEzsLl/A5wMS9
         SB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f0/XtdIyw6iwQJQ5kZT23INEqlES4/JfjcvNloEQ/Fk=;
        b=lkWlJc/11ZfEXpwf8qlwBAmhvgWG6nMLz4k6j49nhXF51wv/uDQfsJC9B6p6JUxWDn
         rKcmeLktsDNCgnJCb5hfes1bLrEyR5VAOS1ZZbXQsqNyADHbMD9hfBGzJHXmYD1AQbrN
         codFLnVwGSyccn1yDrls9Z9+bJ4IYGyP9bu+xCl4S49rUWFl7wmO6qN3L5nTveSSza4f
         PBC69oMbSblBOsS0KALkr/oFc5B3pk5f0iPXu+6npeoa4V42WEFG5nRcRXOVLJM3tuLX
         G1o99fMhPWIS22pfkteGjNx+Iz+lN3qraAkytq5RfVuSOIXBG8SmfdHi+O+CIZrUWAKv
         U1eQ==
X-Gm-Message-State: AOAM530RboDjOHTWKWatpAKFnKew0fAlK24ygEgsecYT4DJUr0YlddDN
        jSZ18LN6SGlTpW8035iz4zs57b/OncQ=
X-Google-Smtp-Source: ABdhPJzo3n3sO5RTLnTDPvk+cPykzofAozqSF7kzCx3hopmx30YdeIbS9kjBBUaF12eIHVbPSdgDYQ==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr12559889wrs.317.1607677738238;
        Fri, 11 Dec 2020 01:08:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm14189718wrm.28.2020.12.11.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:57 -0800 (PST)
Message-Id: <af256b1c534e3fe103bb01bd673ac3a2ec467de4.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:48 +0000
Subject: [PATCH v2 9/9] diffcore-rename: remove unneccessary duplicate entry
 checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
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
