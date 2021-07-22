Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5BBC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C3461353
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhGVLjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhGVLjt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:39:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02FC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 14-20020a05600c028eb0290228f19cb433so1461426wmk.0
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNc22YgJyX2pJYVaDSTtZ/nwPnKUlbYXxQxz6lHMFrM=;
        b=cH9ynwJj+dVfq74GiQKHMpFf+GyVUzwMHR6zv3cw0K1IXcAcP/lgPARmvhCD3mGXq0
         ejAPpbjwZqVstlVfndlETHe2R0l1lcUopbWAugwLoFfF3zEdMYi+DRTtggsyzsiz5xS2
         hbpMrbHbwBVt9nI8Xy0xB4KgYSGUzYyp0zfdykTpl6YgcBHw/qG5YngjwCvUYQJt8hJW
         hSpgI5KkF1qBqlYsPJu2BFjuElHWSgA3FiVWHDfdh2MdkNw6Z7XfVUrn4qkpo4vmRQ41
         Mss8J/tRSywM/rbk3tjunwW3cykfsmTz1sxJ3SdZJ9mHQT57LVZMsIgjbU7tgkrNi339
         nEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNc22YgJyX2pJYVaDSTtZ/nwPnKUlbYXxQxz6lHMFrM=;
        b=PIjVBU4kzwFX9VP0Ndg+//SBBFBPQv1PVjr4bpIzhjt8jWGfLtUZYE5IfF9brPHvSG
         2V1/G/6mLxoroGnVfiGRyVBVybqw4i9QqQpgtLBZpkBg+vakX45QruP1I5LNXjWni/91
         lBImGT2wcBLF4aQTCPwv9jg5DE7AZOe1VjyanDEXIB//+T5fUHg+i7EVpnjgZYm5uRLE
         PF4doWCvPmK4dr2SYPERQdvzLRie3vttBdyurSWQOE5OWVJSiTBhLQFZ6qp5I11MC+On
         hsNzsrj5nFRD5OSAGzQ8jnMtQp6OZPK6oeE0UtAs2p79loyo8bs1X9zxjojVVS9fBVyX
         DXew==
X-Gm-Message-State: AOAM531HAp9EHAkWVq1FDL7PSe+F/94omiC06J5fIxvcPpHyFnEFWmjU
        cIB1FcaLNOncdc70IpKPM+xwlg+Sre97dg==
X-Google-Smtp-Source: ABdhPJxGRGRAdKXKESzLu5SGLyDJRZEIGvkZq3eZnMPWoyi5Pe6JHYRNTjKfEZp5QWTPgmqKTXh2Vg==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr8741443wmb.156.1626956422180;
        Thu, 22 Jul 2021 05:20:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n23sm23506991wms.4.2021.07.22.05.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:20:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] entry: show finer-grained counter in "Filtering content" progress line
Date:   Thu, 22 Jul 2021 14:20:17 +0200
Message-Id: <patch-3.3-f65001627a-20210722T121801Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

The "Filtering content" progress in entry.c:finish_delayed_checkout()
is unusual because of how it calculates the progress count and because
it shows the progress of a nested loop.  It works basically like this:

  start_delayed_progress(p, nr_of_paths_to_filter)
  for_each_filter {
      display_progress(p, nr_of_paths_to_filter - nr_of_paths_still_left_to_filter)
      for_each_path_handled_by_the_current_filter {
          checkout_entry()
      }
  }
  stop_progress(p)

There are two issues with this approach:

  - The work done by the last filter (or the only filter if there is
    only one) is never counted, so if the last filter still has some
    paths to process, then the counter shown in the "done" progress
    line will not match the expected total.

    This would cause a BUG() in an upcoming change that adds an
    assertion checking if the "total" at the end matches the last
    progress bar update..

    This is because both use only one filter.  (The test 'delayed
    checkout in process filter' uses two filters but the first one
    does all the work, so that test already happens to succeed even
    with such an assertion.)

  - The progress counter is updated only once per filter, not once per
    processed path, so if a filter has a lot of paths to process, then
    the counter might stay unchanged for a long while and then make a
    big jump (though the user still gets a sense of progress, because
    we call display_throughput() after each processed path to show the
    amount of processed data).

Move the display_progress() call to the inner loop, right next to that
checkout_entry() call that does the hard work for each path, and use a
dedicated counter variable that is incremented upon processing each
path.

After this change the 'invalid file in delayed checkout' in
't0021-conversion.sh' would succeed with the future BUG() assertion
discussed above but the 'missing file in delayed checkout' test would
still fail, because its purposefully buggy filter doesn't process any
paths, so we won't execute that inner loop at all (this will be fixed
in a subsequent commit).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 entry.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index 125fabdbd5..d92dd020b3 100644
--- a/entry.c
+++ b/entry.c
@@ -162,7 +162,7 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
 int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 {
 	int errs = 0;
-	unsigned delayed_object_count;
+	unsigned processed_paths = 0;
 	off_t filtered_bytes = 0;
 	struct string_list_item *filter, *path;
 	struct progress *progress;
@@ -172,12 +172,10 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 		return errs;
 
 	dco->state = CE_RETRY;
-	delayed_object_count = dco->paths.nr;
-	progress = start_delayed_progress(_("Filtering content"), delayed_object_count);
+	progress = start_delayed_progress(_("Filtering content"), dco->paths.nr);
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths = STRING_LIST_INIT_NODUP;
-			display_progress(progress, delayed_object_count - dco->paths.nr);
 
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
@@ -224,6 +222,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 				ce = index_file_exists(state->istate, path->string,
 						       strlen(path->string), 0);
 				if (ce) {
+					display_progress(progress, ++processed_paths);
 					errs |= checkout_entry(ce, state, NULL, nr_checkouts);
 					filtered_bytes += ce->ce_stat_data.sd_size;
 					display_throughput(progress, filtered_bytes);
-- 
2.32.0.957.gd9e39d72fe6

