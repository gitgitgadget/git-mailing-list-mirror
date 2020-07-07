Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B0BC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0D72073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlO73mtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgGGOWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgGGOVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29891C08C5EE
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so46664238wmo.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xjoz+JZMCRO0zjHyWxa1/LgDFgrZGK6X/9VbnBQrS4g=;
        b=WlO73mtX2V/PrZwrCxXmdNI13jwO3Vq1reaTa8mI5EpBk72/L+pJUJmmYOeqvcsOIk
         NcJdjb2HhEArap8KVLVUVECdk2qqxeYall/ZlWtiPODkukNbEUCzigHBzqDS9hFORHwY
         vVNs3cxbD05KwkfsXVUUX/NIKWeV04pVFJKQnsEvjG+QMQ9ER6OUIglIQDEODyD6sHbq
         zAFwGKoUDdo9GSU4Sf1kyGondleiafh0/blKE6T0wbGffeejBWviq6G4aCuUsch1W6sw
         HxQUarXG4TBjeYa7SIShCoXGGbjik5ZDDhkSgRI2+VlUruI741jWezt2EgJRk6qpzl2w
         pkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xjoz+JZMCRO0zjHyWxa1/LgDFgrZGK6X/9VbnBQrS4g=;
        b=c4GjnvRLI32RlkkrPdeHNlqhI5kXcQZu/5RgCEeeLYhUEs5w9eJV59nkd+ZbEYs3Ap
         OPsc3z4LZ64XI2QY/yBZSO6uFSXoVeGRCoWOQf2owJFMPRNXuzLZDAQ5ohDeVajhs4Kg
         whn1KufmrQLcwGRh+HS6BUBXC2uKdjY4ctv1a/0qir80YM/7nL4Op0hBJjkz/83zrait
         1IyRcCrbsxjPeGXz/Q6xtng0Ur8xEqBgDSEj6a6XJzNjaNA+V5dcoHEKMP3pbIGImj//
         nOhsNvjwiMTu1FZ2r6Q/5XtvuLQhsEtjAGjdovLOz0IcglaXbBtFcnBjFh9szI/s3Th1
         Jlkg==
X-Gm-Message-State: AOAM533s+jtWftKtzBcRUilGUtXM+8351h08BB44Rw3ObYAKOMxTsUEH
        tjRJFMbYS0j3SlWwUKmsS8qVFyQI
X-Google-Smtp-Source: ABdhPJwzdSpAF4+7yP/lbjmXiMJ88yXVunVJyLV5MHh9JlmFDOIo7DvKB1TzNMcEKdcKd3xRYklgTw==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr4706810wml.95.1594131708677;
        Tue, 07 Jul 2020 07:21:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm1269330wml.29.2020.07.07.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:48 -0700 (PDT)
Message-Id: <8be89707d2d5a8b527e104a2aeadb5ea7f65d476.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:29 +0000
Subject: [PATCH 15/21] maintenance: auto-size pack-files batch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When repacking during the 'pack-files' job, we use the --batch-size
option in 'git multi-pack-index repack'. The initial setting used
--batch-size=0 to repack everything into a single pack-file. This is not
sustaintable for a large repository. The amount of work required is also
likely to use too many system resources for a background job.

Update the 'pack-files' maintenance task by dynamically computing a
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

Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 47 +++++++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh |  5 +++--
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 259b0475c0..582219156a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1032,20 +1032,65 @@ static int multi_pack_index_expire(struct repository *r)
 	return result;
 }
 
+#define TWO_GIGABYTES (2147483647)
+#define UNSET_BATCH_SIZE ((unsigned long)-1)
+
+static off_t get_auto_pack_size(struct repository *r)
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
 static int multi_pack_index_repack(struct repository *r)
 {
 	int result;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
+	struct strbuf batch_arg = STRBUF_INIT;
+
 	argv_array_pushl(&cmd, "-C", r->worktree,
 			 "multi-pack-index", "repack", NULL);
 
 	if (opts.quiet)
 		argv_array_push(&cmd, "--no-progress");
 
-	argv_array_push(&cmd, "--batch-size=0");
+	strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
+			    (uintmax_t)get_auto_pack_size(r));
+	argv_array_push(&cmd, batch_arg.buf);
 
 	close_object_store(r->objects);
 	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	strbuf_release(&batch_arg);
 
 	if (result && multi_pack_index_verify(r)) {
 		warning(_("multi-pack-index verify failed after repack"));
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a6be8456aa..43d32c131b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -134,10 +134,11 @@ test_expect_success 'pack-files task' '
 	test_line_count = 4 packs-between &&
 
 	# the job deletes the two old packs, and does not write
-	# a new one because only one pack remains.
+	# a new one because the batch size is not high enough to
+	# pack the largest pack-file.
 	git maintenance run --task=pack-files &&
 	ls .git/objects/pack/*.pack >packs-after &&
-	test_line_count = 1 packs-after
+	test_line_count = 2 packs-after
 '
 
 test_done
-- 
gitgitgadget

