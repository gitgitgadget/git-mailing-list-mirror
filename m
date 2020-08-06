Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA73DC433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFA2206C3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml7VPATG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgHFRwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHFQbn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C2C0F26C6
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:30:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so6910739wmd.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Uv5L8ZO4SIiYZuPxYS424mOf6Tt1woqeOSXLimKpxw=;
        b=ml7VPATG2yb5U82SA8tKf1dAH6kXou1NJe+L3eOh/FJv8EpNVHuKEyMUb2H3jXwsYG
         gW3dlyBw8EvIILeZFMoDpcIZHLi7X3DY+gY6G730jfaYsBBwUfnFReU2jPwEKHAaHRLO
         JYgvvzvC+D2Yo+rzAEIT91C/dWKcp5X6kChCses06yppqGsaNotRY5zzpr/wxqyup7Sv
         pfRZy21FAODqrg4QfNICyeC+nMcuc+1gVinlF0eAiBTst4EPiwyJuiDr/XR4SQhp3P93
         xCMrCSXQLPlVgV7hyDruObJwPxj/HeVmDNFqqOVWCEYYOWMwX+6pFQa8T+FN2t9Nzwnh
         qzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Uv5L8ZO4SIiYZuPxYS424mOf6Tt1woqeOSXLimKpxw=;
        b=JwopNJfEKHaJ9U48unB2Tf7wX+QzHK+IDqRIkcbPHKNpeFEVO44hlsfgPvPP4zERIC
         8XPLtkgTobBA0USYU89dBmsCHYHvnlmh5bZkAIbMtOUoUiPYMeirNrmI/sglvbSQ1POy
         NtxiaZMmQbrqnYWqLKK0O5l7xbQSoNpmpvQzm8GPpZlSpO7VcpUTT/mMv4Gc+ltrEr0M
         cJAmoTLtmYzDMfXcaWa1e3gxcfnYlYvTsyXs/0hoQEcVaoPxCit6qJ5RsZY3mvWnJ/wS
         ociYt2pSowZO8II5zq9C0b/gyiQygpr+9Cu9zGDp9/ty9+OJVW24WmVkl7AZSou3cxTv
         gniw==
X-Gm-Message-State: AOAM53286X5s3rQmgIjDNdUVhnRQUIic+hG2lzDc08lOyZoSlbsKEsYr
        joYA3cZibsFLtDZUEUJ4bTmJvY4e
X-Google-Smtp-Source: ABdhPJx4wNtbzPPzp+s0SYVPdH44qhC8BUsvdtI7uKhgFF5o9AMlIjX76m47QPhd7661paGtNXKp/g==
X-Received: by 2002:a7b:c105:: with SMTP id w5mr8556341wmi.146.1596731432439;
        Thu, 06 Aug 2020 09:30:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm6712505wru.33.2020.08.06.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:30:32 -0700 (PDT)
Message-Id: <c3487fb8e3e72949080f51f341655f37b5f2f03f.1596731425.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.git.1596731424.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 16:30:23 +0000
Subject: [PATCH 8/9] maintenance: auto-size incremental-repack batch
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
index 35c6d7ce82..c09bc1381c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1094,6 +1094,46 @@ static int multi_pack_index_expire(struct maintenance_opts *opts)
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
@@ -1104,7 +1144,8 @@ static int multi_pack_index_repack(struct maintenance_opts *opts)
 	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
-	strvec_push(&child.args, "--batch-size=0");
+	strvec_pushf(&child.args, "--batch-size=%"PRIuMAX,
+				  (uintmax_t)get_auto_pack_size());
 
 	close_object_store(the_repository->objects);
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index be19ac7623..1c5f44f2b3 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -179,10 +179,42 @@ test_expect_success 'incremental-repack task' '
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

