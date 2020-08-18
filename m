Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE4C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41F2207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXcJ4Sl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHRO0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgHROZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33CFC061346
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so18435139wrx.9
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xhHyMPCS+Bkr8AVPcmA1SDmyfDPL8Ap9sHZ0eLhZcd4=;
        b=DXcJ4Sl4uhCY1Y7mZW7Qavnyy/PmF+4QMi8F0iepkKXcRdp7J1Xvxtgv15jmP3Z9MT
         NT0w8lMwUa9LHXg8NU8if94IEriTaCWIvHASse1DdHnO6JDR7d71ZaOjCl2kE4CccO4e
         jE53TZrlbFYtHZfLLFA0KebsJougVqbrynKi9QYtKqoeH9AMbJlK2Bh3m1MW/IdRujNj
         ibTCCirm6nVUvjDH7Wh5B1PgN5cchYMvHBWNEIFI+xaq8qWt5mVQf46LSt9nU69lPom9
         sx2ZyNxHwO5BvPpnVnkYw/LenLWyhiN7IMa3JFLuoiztcT6h6yS7RMvOxt8pVT0tOQ9N
         H2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xhHyMPCS+Bkr8AVPcmA1SDmyfDPL8Ap9sHZ0eLhZcd4=;
        b=LThDWFoURqEBpa49dxlci+wdLD23hV3NMxVejVwzzm5YrA7ldt5Obo/2EvHg+6PLTm
         vlDoKhBNjcSg6CeoAXTYTwXuO+JM8Ul3QTGxqYgPgRuAwQM7/et8gL/DqAaNlsWVWvWn
         QzjnSjKk2WiN2xyxBoWyD2aqWnXfgXUyn+ecctOMy6zodvt63C2I/wsjFnT8rAgqKI0K
         +gHzligyvXMK8hoCtE3wRdgkWLhJX8Qnllx77W19dakMocr/iqxgJUpb+SahyKiQFtl0
         /Yd1sUe4lntzTLsRa/oK3tJZhw+dIGsUcVzaBtKk9bAO/RJVj6+OPXMM/P4bL8Pn5hip
         5SRQ==
X-Gm-Message-State: AOAM533dJRYZJV8B2Ig7aQe8iJfVrBnvjbcQZ86JK+dVRzMpRhF0XdFu
        coOTqpLbb2g145kHUZAH7dltpgPhyzo=
X-Google-Smtp-Source: ABdhPJyy8INQqWekyuSA3hQ4yTbKpmYSxDJdPzxBUhnez5GSpBmJQyK9W0lKvIDru4/grEtk0T8wOg==
X-Received: by 2002:adf:a4d7:: with SMTP id h23mr22317110wrb.276.1597760738309;
        Tue, 18 Aug 2020 07:25:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm36672517wra.29.2020.08.18.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:37 -0700 (PDT)
Message-Id: <e157ea8dd7f16281d358a080b3424918d3572a36.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:27 +0000
Subject: [PATCH v2 6/9] midx: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
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
index ef499cf504..aa37d5da86 100644
--- a/midx.c
+++ b/midx.c
@@ -832,7 +832,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	packs.pack_paths_checked = 0;
 	if (flags & MIDX_PROGRESS)
-		packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0);
+		packs.progress = start_delayed_progress(_("Adding packfiles to multi-pack-index"), 0);
 	else
 		packs.progress = NULL;
 
@@ -969,7 +969,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Writing chunks to multi-pack-index"),
+		progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),
 					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (written != chunk_offsets[i])
@@ -1104,7 +1104,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		return 0;
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Looking for referenced packfiles"),
+		progress = start_delayed_progress(_("Looking for referenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(r, m, i))
@@ -1225,7 +1225,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	count = xcalloc(m->num_packs, sizeof(uint32_t));
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Counting referenced objects"),
+		progress = start_delayed_progress(_("Counting referenced objects"),
 					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
@@ -1235,7 +1235,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
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

