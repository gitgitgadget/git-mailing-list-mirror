Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4419DC433F8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F4D206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7f0Zl/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgGWR47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgGWR4y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E7C0619E6
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so5760297wme.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sNVSGvF3mvcx9l7i3Lj3EAi8J/egmMgbQkQ+jRiIAWA=;
        b=C7f0Zl/8kr5IcuCFIZ0ltvVNad0JqF1oKR1yEFb/ZB7YVmHt2UFAP0m5FOk3jG5Y5P
         zBdH32DQlFTyhVgLSOPK9AAfAx/MCHr1+vT3TR1FHw9uyc8Ze+wDe4YANdYl0zRNtXmD
         U36EPx+eM7T/Dh7wC7eRrKFkf/fPKaZGxeQ2Ihwst6h6c9osEq1fDxWzesKv0WGlUg7s
         425FZa9PMJf3tad/H8ak+PhNC0x9xo1y6TeXBvAgFZDBUtnr15BemCO4lp0r70qEHy/X
         Gh9ciwKHe3juNNpglVA7p8pxHsGLW/Eo49gABhOhKFSzOgdD3iNIFG6GJWnfZlWXTF3Q
         B/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sNVSGvF3mvcx9l7i3Lj3EAi8J/egmMgbQkQ+jRiIAWA=;
        b=HcKlz1++IbdnnlRCnWEmEzkP5tcvGeOHLb/PtbtJWrVwC59+CW8OiOMXbzOnPLsKu/
         NStRXMD2Nk84P/idYBlaj8PrqT3phfF6fpH7+p3/UAM3usnSHg7egYP6goYyCgWJoiIa
         GZP53oKOFG3IkPYEo9O37C12dIE6FwHiMY6z5GuA6fFq1qCf19d1us2aWMVmbw6tcjtl
         Q3m8ofI/N+qOVkruV0Mt8ZyPPFs83ubTmeMhcE8x1yB4d12PCcYvywg04tXeciRNQB0J
         G7HL15+1B2cdh2bPifP+eJvsPAiJvxQSId37I03omSZTqMpx4d38fqJFjgb9Dv2+Ou8e
         On6w==
X-Gm-Message-State: AOAM531vBRCMIBtJyRK+2DfZpQijkOQF0nyVsFPRYXqYck+9vDzkth1M
        Cml/tS46g+GwDvrNSRV1qP8x04qs
X-Google-Smtp-Source: ABdhPJwwGq1a+BRBu7rZFpGeMn9WwGmfPO6xy6I+e4W8NtGwaiVqUkVaAaEC4E2zRTcPJIT6kKt/WQ==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr5069384wmi.22.1595527012391;
        Thu, 23 Jul 2020 10:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm4677979wrp.10.2020.07.23.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:52 -0700 (PDT)
Message-Id: <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:33 +0000
Subject: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
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

When repacking during the 'incremental-repack' task, we use the
--batch-size option in 'git multi-pack-index repack'. The initial setting
used --batch-size=0 to repack everything into a single pack-file. This is
not sustaintable for a large repository. The amount of work required is
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

Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 48 +++++++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh |  5 +++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eb4b01c104..889d97afe7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1021,19 +1021,65 @@ static int multi_pack_index_expire(void)
 	return result;
 }
 
+#define TWO_GIGABYTES (2147483647)
+#define UNSET_BATCH_SIZE ((unsigned long)-1)
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
 static int multi_pack_index_repack(void)
 {
 	int result;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
+	struct strbuf batch_arg = STRBUF_INIT;
+
 	argv_array_pushl(&cmd, "multi-pack-index", "repack", NULL);
 
 	if (opts.quiet)
 		argv_array_push(&cmd, "--no-progress");
 
-	argv_array_push(&cmd, "--batch-size=0");
+	strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
+		    (uintmax_t)get_auto_pack_size());
+	argv_array_push(&cmd, batch_arg.buf);
 
 	close_object_store(the_repository->objects);
 	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	strbuf_release(&batch_arg);
 
 	if (result && multi_pack_index_verify()) {
 		warning(_("multi-pack-index verify failed after repack"));
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 3ec813979a..ab5c961eb9 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -134,10 +134,11 @@ test_expect_success 'incremental-repack task' '
 	test_line_count = 4 packs-between &&
 
 	# the job deletes the two old packs, and does not write
-	# a new one because only one pack remains.
+	# a new one because the batch size is not high enough to
+	# pack the largest pack-file.
 	git maintenance run --task=incremental-repack &&
 	ls .git/objects/pack/*.pack >packs-after &&
-	test_line_count = 1 packs-after
+	test_line_count = 2 packs-after
 '
 
 test_done
-- 
gitgitgadget

