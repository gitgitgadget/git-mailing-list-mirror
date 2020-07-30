Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22E9C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5B820829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYfzTiiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgG3WZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgG3WYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61EBC061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so5210485wmc.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iFZtDi+XmH2tLB2MN3s2TsMV6TqojLwZeUex+F1/1v4=;
        b=VYfzTiiy+1NZQXbnTLrY/bUpCylzaucihuSXusjZy1IMuWNbVmy39uKZHFMt6JuYSw
         qf+xJSqSb/FuvEZ7QToVCK1RDMonfs224MnOvWdBzXbY4/I+803/daDZXXx1d27ovfZc
         42kvWzD2aFfdXT9t0DbxDhYSFtqM9NKwAkct88axvDHsuu5tb4Ksjo9EfaQX4ehNfDwY
         qgDmjJARTSeuFbwQJQY6sW6xufqGDuCFZSmQ6/xtYD92PaYs65m4GMOXxDt5Gp9RfJM7
         ih381nZN8WWzOXVAkthfN8ltm2ASXdN0KcM/gycubgW1efiAekchQWtl+asJ9LNdUKc3
         2gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iFZtDi+XmH2tLB2MN3s2TsMV6TqojLwZeUex+F1/1v4=;
        b=BZbZGLNHMtIcxCq/c7awh8vDFJs9pQzgsPBkmZwmYTLOd6tbOnhQOOxYRBPVLqIEna
         aTB8es1G2qSwdmH96jkMjW4PBOAYNdodpaZp0tym4C7U0sW0WkCRA0u+05yXXbED/HQ6
         EuMJVrSsdqHeXbCXFgV9tqAPEeL/M+dFBs63+JcLzc7sJJqXtWnhmEBj6l/lk08Wha7b
         7/wtFfQ6QSRUFICWFyYdZLOc69G6AtP/Dqf6ZPgjEtCpz6c3NUh4JJz4xs6BK3XEMoHm
         euXfMCyg4rFVnhlFjwaBzLbA4BRBNnRz7g5m//LDhX8JHtquqVoKg4qhnuVTAUDrRYdD
         tAxQ==
X-Gm-Message-State: AOAM53152XcWXyC0Vgy5nFhZiQTwyrCj88pKGGns374ll5X6oITeuOUy
        VqDvjJJvDyskg9Okklssau2Ul/os
X-Google-Smtp-Source: ABdhPJxt4HKv4Dxu7F0kj4dEs+0cjKqM9XLmmBAOtQlBUG4SO4nL5TaNXjBhbcCwRa3Qv/SzgaJEMA==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr1044712wmc.179.1596147890289;
        Thu, 30 Jul 2020 15:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm10641091wrw.93.2020.07.30.15.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:49 -0700 (PDT)
Message-Id: <ef2a2319565939bfbdbd2e898a980c61ecc39c6a.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:19 +0000
Subject: [PATCH v3 13/20] maintenance: auto-size incremental-repack batch
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

Reported-by: Son Luong Ngoc <sluongng@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           | 43 +++++++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh |  5 +++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 99ab1f5e9d..d94eb3e6ad 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -988,6 +988,46 @@ static int multi_pack_index_expire(void)
 	return 0;
 }
 
+#define TWO_GIGABYTES (0x7FFF)
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
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -998,7 +1038,8 @@ static int multi_pack_index_repack(void)
 	if (opts.quiet)
 		strvec_push(&child.args, "--no-progress");
 
-	strvec_push(&child.args, "--batch-size=0");
+	strvec_pushf(&child.args, "--batch-size=%"PRIuMAX,
+				  (uintmax_t)get_auto_pack_size());
 
 	close_object_store(the_repository->objects);
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0cc59adb21..4e9c1dfa0f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -138,10 +138,11 @@ test_expect_success 'incremental-repack task' '
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

