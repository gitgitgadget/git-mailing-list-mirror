Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11899C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFCF207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEjXJyAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHRO0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgHROZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF4C061348
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so18454180wrm.12
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/QuuEXvP6bFprNNpiXgGQ1A85GITt6x5parMpIz5IeY=;
        b=QEjXJyARt0Qhe1rPgaAprikih0KiCovuOVlIG/5TnOiSZJ5g+3hWCgzE98o5AZZYG3
         w00xZMcoyKAFRdoJeOUXB7gwCMP94S4EfiuIuB2gVGojaBWgad1SnykbYgf5GOdvrP1Y
         UrKnGU9Shf5Txy97vzqZTceNjaqIwVtl5S9uoBNLFwTsCfGGdLRlPOPalXAdy7UJ8iNk
         8oJZYaAj7J0iMMnd1sf92w1WIjyCINqyxdMBHw2jfqczf+rZZQAsuLEm3UDMY8SliuJv
         Brt3KMshBQERTRwZPrHVHGMazJXXx2JxhrL85whqpBWNepUKf3ycv8+BNV/R9EU1e2jS
         kboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/QuuEXvP6bFprNNpiXgGQ1A85GITt6x5parMpIz5IeY=;
        b=jdcOFjcQn70MOgWHEncwQeoVETg7ErV0aO7To7SW7eyRv9xs8pbN76o4xxAE3CE7FV
         6zRDUgVWf3kC+6Q/Z0pEJrJj8OfDNBAZjOW7/YzDTvaU+IPcLm0yTIhbyGdgbLAM/UKA
         SB0OA8t4fAZY9MATr9whdesxCYIZ1Y/XT/CHeEhFVmozeYEXnK5fum6+LZRb5r6tEtfH
         LHRDYcSFQVjbqZ5HsEQIMFp9bToLfzz9fMdn8ipTuvc+JZ00Uqf8CQx3OKlIR8GWnT3f
         XducT2s/LP5ZnDv1n6fnLqiArSUDm4xuIpbOJbHdNJlLFWzTEgqFRck6Pv7uydgTGwZY
         9YrA==
X-Gm-Message-State: AOAM530KpQn6wEShTW1TQBSnHRM1vTAY9oZzuj+ILUOoi7sE9avNojmL
        stjiEQ6LJ3t757Um2jzefWdv7TxYXoU=
X-Google-Smtp-Source: ABdhPJzPI/9+IMDibwID6+4YOWU4AhYMnGA5FPzvZlID9pG8gNqV8nXgapfTTV4/WLTTBBNHG7ne9g==
X-Received: by 2002:adf:df91:: with SMTP id z17mr22398394wrl.149.1597760739870;
        Tue, 18 Aug 2020 07:25:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm107193wmi.48.2020.08.18.07.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:39 -0700 (PDT)
Message-Id: <f0e727675584c60046a0fdd7c63a57ec1cbaf150.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:29 +0000
Subject: [PATCH v2 8/9] maintenance: auto-size incremental-repack batch
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
index 9aabef44a8..d2f3e27e54 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1093,6 +1093,46 @@ static int multi_pack_index_expire(struct maintenance_opts *opts)
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
 static int multi_pack_index_repack(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1103,7 +1143,8 @@ static int multi_pack_index_repack(struct maintenance_opts *opts)
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

