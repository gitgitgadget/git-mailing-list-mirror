Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECFFC43445
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C281206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u07JaHYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgGWR5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgGWR47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C81C0619E4
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so2443523wrm.12
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LU+CNrX9yNQ3ZBh5dcZ/D4gj9kwibseehJxjrOFtaPA=;
        b=u07JaHYa1c+hKO5qwoNNrZJdn5YqB+8u/YTDtZO2/VN302nijAvklwuIO+tjU4csRn
         fgMkwgLyKrelXdXJ3RjMAYT5AcdueuaMmS+WEg78RHoYdqT8jDwWWBZTbhTz9Drfr3XQ
         7UVOmrwhh5DJ4A+84tNo7hkftOrXQWeQGwZ8eBkFV7+Y3gnNDvf7pnN4YBNsHnqRCWsN
         QlWtwx+XfoZzH4NKSxV/XlMc6PuYEHzu6WhHCfr0bq/LaZ9j8jBI/9D/7DhCphYhD7US
         uCMDitU0xVuhd5YE5lisjtEahipXWPFoHF7QZEQOzpNQSvERyvh4tuieJWrVQArvm0ol
         WUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LU+CNrX9yNQ3ZBh5dcZ/D4gj9kwibseehJxjrOFtaPA=;
        b=hr2iEHfeDDxMZEMN6ON4iJRNA7A29q4gm1H9R6Cli9iTpjPmZUh0V04JjQyfjH5E43
         rSYevoyk62iQH7cyvifs7ms5owJdNqAmuFIEzyfe1jTlmR9/9NBrweGTf2p3y+jO9B0/
         QNEMMOD5/zYM1idSt+GWJdN/SYVxE7Qw/g9KgV5CpseneaY0qt9S4MG+KRe72vTAseDb
         mi15cJAS/hJ7+xeaZRoW/7PnrGqaYsNnmo/qcml+lDRhKEOSxTH5lFQrP2l6/RVaYTT1
         KlVN8detdkl5Xjc4nFzFgI4ZrcoXpYY7RWtSK0IHPjAEoe6xDiaO5C2bhwXGi2qMYzLy
         YFAQ==
X-Gm-Message-State: AOAM532E2675aSQGHrEdctbn0vBcTQrf8V0/ziESNPj/Y2n8qiSRXDfb
        6LZt/7vQOme+MKlejJl6fH19DTdy
X-Google-Smtp-Source: ABdhPJxvkKr5CE56IfSBL6D+KnZ4FVnqvfSX+ZxAO9Qo14pQe19h2/OAOH6XDqsuA4f9SkS4yEjAHQ==
X-Received: by 2002:adf:e486:: with SMTP id i6mr4986644wrm.258.1595527017569;
        Thu, 23 Jul 2020 10:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm4236090wmf.21.2020.07.23.10.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:57 -0700 (PDT)
Message-Id: <a0f00f8ab89469907b1304e09bd298a0236286bd.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:39 +0000
Subject: [PATCH v2 17/18] midx: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that the multi-pack-index may be written as part of auto maintenance
at the end of a command, reduce the progress output when the operations
are quick. Use start_delayed_progress() instead of start_progress().

Update t5319-multi-pack-index.sh to use GIT_PROGRESS_DELAY=0 now that
the progress indicators are conditional.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 10 +++++-----
 t/t5319-multi-pack-index.sh | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/midx.c b/midx.c
index 57a8a00082..d4022e4aef 100644
--- a/midx.c
+++ b/midx.c
@@ -837,7 +837,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	packs.pack_paths_checked = 0;
 	if (flags & MIDX_PROGRESS)
-		packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0);
+		packs.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
 	else
 		packs.progress = NULL;
 
@@ -974,7 +974,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Writing chunks to multi-pack-index"),
+		progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),
 					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (written != chunk_offsets[i])
@@ -1109,7 +1109,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		return 0;
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Looking for referenced packfiles"),
+		progress = start_delayed_progress(_("Looking for referenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(r, m, i))
@@ -1230,7 +1230,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	count = xcalloc(m->num_packs, sizeof(uint32_t));
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Counting referenced objects"),
+		progress = start_delayed_progress(_("Counting referenced objects"),
 					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
@@ -1240,7 +1240,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	stop_progress(&progress);
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Finding and deleting unreferenced packfiles"),
+		progress = start_delayed_progress(_("Finding and deleting unreferenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		char *pack_name;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 7214cab36c..12f41dfc18 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -172,12 +172,12 @@ test_expect_success 'write progress off for redirected stderr' '
 '
 
 test_expect_success 'write force progress on for stderr' '
-	git multi-pack-index --object-dir=$objdir --progress write 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress write 2>err &&
 	test_file_not_empty err
 '
 
 test_expect_success 'write with the --no-progress option' '
-	git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
 	test_line_count = 0 err
 '
 
@@ -334,17 +334,17 @@ test_expect_success 'git-fsck incorrect offset' '
 '
 
 test_expect_success 'repack progress off for redirected stderr' '
-	git multi-pack-index --object-dir=$objdir repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&
 	test_line_count = 0 err
 '
 
 test_expect_success 'repack force progress on for stderr' '
-	git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
 	test_file_not_empty err
 '
 
 test_expect_success 'repack with the --no-progress option' '
-	git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
+	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
 	test_line_count = 0 err
 '
 
@@ -488,7 +488,7 @@ test_expect_success 'expire progress off for redirected stderr' '
 test_expect_success 'expire force progress on for stderr' '
 	(
 		cd dup &&
-		git multi-pack-index --progress expire 2>err &&
+		GIT_PROGRESS_DELAY=0 git multi-pack-index --progress expire 2>err &&
 		test_file_not_empty err
 	)
 '
@@ -496,7 +496,7 @@ test_expect_success 'expire force progress on for stderr' '
 test_expect_success 'expire with the --no-progress option' '
 	(
 		cd dup &&
-		git multi-pack-index --no-progress expire 2>err &&
+		GIT_PROGRESS_DELAY=0 git multi-pack-index --no-progress expire 2>err &&
 		test_line_count = 0 err
 	)
 '
-- 
gitgitgadget

