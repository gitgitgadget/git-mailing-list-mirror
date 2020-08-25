Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B8EC433E4
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC222071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwVqhiAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHYShD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgHYSgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:36:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C359C0613ED
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t2so3613113wma.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oXBuyWEjP/ytBbhvszrritMFjhG19mvyi5Qo2oXFKkQ=;
        b=jwVqhiAHqytsNdZPj4ljDSaj8rPA9A5tZ/Nfsf+rf9wFx4qC6JXbR+VxbzXG9ZLu7R
         AL7sU1WZWT6LA15EwXrFVjcL+VY8M0OJiKBIzy9gg5TqXfKcRR5ftoz9/rtSA42C7giw
         03M0PMfwVJtvk+Dr77nSaGfWwpte81hOZZaj0cOPMPCsuhSOtfNl/RAhozSKEzsz/X/+
         eMAB2Etwx1bAuqfXYM0SJcZ3ZuBKfroW7Lz/uPrDY4IMcWuuOHowRsigzVL+1mH713Eh
         gN5+4XxaUkZ9otE076B8PA59GtmxC+4LpA1tTnZOMan0VutXrkcxqulQ5e/94e2jwC2H
         hpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oXBuyWEjP/ytBbhvszrritMFjhG19mvyi5Qo2oXFKkQ=;
        b=FmY9DXKuFJH30sqlUagTumFIcEXbprH6pOezgRtNM/6jD0VGqSbCE+g6Vr1IhQAfdy
         t4cNtFqHHLwk+/HMK/2vAGCuUj5aAwYZgLCGXdnM/h+ZDiUZoUfAwqcf2Yx0gZusz/Ln
         Skc8HrM2FdMRlN3t/uWFNR6+IoN4qLbCRRzK6lsddhGJkzekKoaUROhldkDq77KOgvvM
         dAg66vm13P5lzpKBsGV/PWWPzugXmmSLJZ2XeCtWc5PONU4e1H4ZTrwtdz8SnUNZLyt/
         W5LxF2SWPyo2oMVujrhouFgzr/Xy1HcMeqa5ozA4C40oWYU3jRRpsx6Mxr8A+QM3sVMD
         wMIA==
X-Gm-Message-State: AOAM530DwaD2N9I5YpRTyhKVrxAIPhQvEQAKtXyXKwOqi7H5aXuEnUHl
        Px76gNXgWrkNSgkT2arS3qkpFXXYMks=
X-Google-Smtp-Source: ABdhPJw9EGsA5TV9bUWHh9xWrxST7DIrKusd5kGmQkIjaJOtMn8GMUS6ULQgjaadlFpyOkaBYS4/ug==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr3142190wmc.19.1598380606934;
        Tue, 25 Aug 2020 11:36:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s20sm7180689wmh.21.2020.08.25.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:36:46 -0700 (PDT)
Message-Id: <f3b25a9927fe560b764850ea880a71932ec2af32.1598380599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
        <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:36:38 +0000
Subject: [PATCH v3 7/8] maintenance: auto-size incremental-repack batch
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

When repacking during the 'incremental-repack' task, we use the
--batch-size option in 'git multi-pack-index repack'. The initial setting
used --batch-size=0 to repack everything into a single pack-file. This is
not sustainable for a large repository. The amount of work required is
also likely to use too many system resources for a background job.

Update the 'incremental-repack' task by dynamically computing a
--batch-size option based on the current pack-file structure.

The dynamic default size is computed with this idea in mind for a client
repository that was cloned from a very large remote: there is likely one
"big" pack-file that was created at clone time. Thus, do not try
repacking it as it is likely packed efficiently by the server.

Instead, we select the second-largest pack-file, and create a batch size
that is one larger than that pack-file. If there are three or more
pack-files, then this guarantees that at least two will be combined into
a new pack-file.

Of course, this means that the second-largest pack-file size is likely
to grow over time and may eventually surpass the initially-cloned
pack-file. Recall that the pack-file batch is selected in a greedy
manner: the packs are considered from oldest to newest and are selected
if they have size smaller than the batch size until the total selected
size is larger than the batch size. Thus, that oldest "clone" pack will
be first to repack after the new data creates a pack larger than that.

We also want to place some limits on how large these pack-files become,
in order to bound the amount of time spent repacking. A maximum
batch-size of two gigabytes means that large repositories will never be
packed into a single pack-file using this job, but also that repack is
rather expensive. This is a trade-off that is valuable to have if the
maintenance is being run automatically or in the background. Users who
truly want to optimize for space and performance (and are willing to pay
the upfront cost of a full repack) can use the 'gc' task to do so.

Create a test for this two gigabyte limit by creating an EXPENSIVE test
that generates two pack-files of roughly 2.5 gigabytes in size, then
performs an incremental repack. Check that the --batch-size argument in
the subcommand uses the hard-coded maximum.

Helped-by: Chris Torek <chris.torek@gmail.com>
Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 43 +++++++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh | 36 +++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index fbf84996fa..e043403400 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1036,6 +1036,46 @@ static int multi_pack_index_expire(struct maintenance_run_opts *opts)
 	return 0;
 }
 
+#define TWO_GIGABYTES (INT32_MAX)
+
+static off_t get_auto_pack_size(void)
+{
+	/*
+	 * The "auto" value is special: we optimize for
+	 * one large pack-file (i.e. from a clone) and
+	 * expect the rest to be small and they can be
+	 * repacked quickly.
+	 *
+	 * The strategy we select here is to select a
+	 * size that is one more than the second largest
+	 * pack-file. This ensures that we will repack
+	 * at least two packs if there are three or more
+	 * packs.
+	 */
+	off_t max_size = 0;
+	off_t second_largest_size = 0;
+	off_t result_size;
+	struct packed_git *p;
+	struct repository *r = the_repository;
+
+	reprepare_packed_git(r);
+	for (p = get_all_packs(r); p; p = p->next) {
+		if (p->pack_size > max_size) {
+			second_largest_size = max_size;
+			max_size = p->pack_size;
+		} else if (p->pack_size > second_largest_size)
+			second_largest_size = p->pack_size;
+	}
+
+	result_size = second_largest_size + 1;
+
+	/* But limit ourselves to a batch size of 2g */
+	if (result_size > TWO_GIGABYTES)
+		result_size = TWO_GIGABYTES;
+
+	return result_size;
+}
+
 static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1046,7 +1086,8 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
-	strvec_push(&child.args, "--batch-size=0");
+	strvec_pushf(&child.args, "--batch-size=%"PRIuMAX,
+				  (uintmax_t)get_auto_pack_size());
 
 	close_object_store(the_repository->objects);
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index dde28cf837..5c08afc19a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -182,10 +182,42 @@ test_expect_success 'incremental-repack task' '
 	test_line_count = 4 packs-between &&
 
 	# the job deletes the two old packs, and does not write
-	# a new one because only one pack remains.
+	# a new one because the batch size is not high enough to
+	# pack the largest pack-file.
 	git maintenance run --task=incremental-repack &&
 	ls .git/objects/pack/*.pack >packs-after &&
-	test_line_count = 1 packs-after
+	test_line_count = 2 packs-after
+'
+
+test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
+	for i in $(test_seq 1 5)
+	do
+		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+		return 1
+	done &&
+	git add big &&
+	git commit -m "Add big file (1)" &&
+
+	# ensure any possible loose objects are in a pack-file
+	git maintenance run --task=loose-objects &&
+
+	rm big &&
+	for i in $(test_seq 6 10)
+	do
+		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+		return 1
+	done &&
+	git add big &&
+	git commit -m "Add big file (2)" &&
+
+	# ensure any possible loose objects are in a pack-file
+	git maintenance run --task=loose-objects &&
+
+	# Now run the incremental-repack task and check the batch-size
+	GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
+		--task=incremental-repack 2>/dev/null &&
+	test_subcommand git multi-pack-index repack \
+		 --no-progress --batch-size=2147483647 <run-2g.txt
 '
 
 test_done
-- 
gitgitgadget

