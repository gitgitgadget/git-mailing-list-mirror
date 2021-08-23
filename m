Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CDC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF816137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhHWKab (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhHWKaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:30:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA2C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:29:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so10373348wmi.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAgIeqK7OeA0Fz4dqRtb96Fh5Np3BLWic5J6o3Dppf4=;
        b=GS74mOAjvOnv/JtIYc7QNMcxsWKlkrVInBFUYf1E4MLwm8fN869NPi6via8ySeeqZa
         S6c4k4+hVHi000oMV5N1WWnNA/OErwwx38siggnz/wJpNiuNRWuiw1+wsNBonBDte+/e
         mw1J45ZGZgoeW7MEBYz+brt9UPcu5AUV4I66+x9zQTKd4BrMGqbhDtY+eoq5N/TIO0Yd
         QKc80u1T6JRO2HNnz//GItKpTBnKmSXpEOQnjGFKov4VB94tf82Djcqvx3qBYPXICPAG
         /2BmGCb0zmuqMJxiI1i8XcpzQdRpEohmY6m61x4c4X8kmI97YkM3D+6ABYWHWTAGC2D1
         poaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAgIeqK7OeA0Fz4dqRtb96Fh5Np3BLWic5J6o3Dppf4=;
        b=OV/AivIIKyJMlE8t+6V4P0wJI6i4KKA5t8d/8Yp21lPqJ93q5ukFLr38boAW/7bI3Q
         is6W3oOfY30717BJXrLSnH2Y8CcgOektzCS2/EuDJb9Hv67gcJuXqTxg4HTgWtit5a90
         4NQhlSZu1ZrJvsOB3Jg9l9mXPzIJ6/8tuKAfF6VYNp6zuwqIp5zKhwkuVmaH03MMOa7Q
         J6xD3Lg9ikLQO+6PUxo/+CWGaVH8TgmyQeIzAnHDWB4DUAgwBHvaTojNHdtH0eIC7aYd
         wnXqFtczXAprOr9sYgvX44UfQj+HKJ+WjYHfwgKasqwHct6ADtgXGRQm6xfGYeu66IcN
         0kuA==
X-Gm-Message-State: AOAM532ccXFbDAFlCvHBMLZrCAlNJvS3K2B1WkFslvOEuFTTRwIWXDvv
        lSFopDh4SLgp69ZR4vP+Vdna9Y9zsM2I13dX
X-Google-Smtp-Source: ABdhPJzecsonUAJkaD9QTVcf61geMDnp3RItbjhqtxfA961qhEkFU2rFWisiNtOww4++T4cg+QBzUA==
X-Received: by 2002:a05:600c:4e8b:: with SMTP id f11mr9269433wmq.165.1629714586232;
        Mon, 23 Aug 2021 03:29:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y14sm14814383wrs.29.2021.08.23.03.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:29:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] entry: show finer-grained counter in "Filtering content" progress line
Date:   Mon, 23 Aug 2021 12:29:41 +0200
Message-Id: <patch-v3-2.2-71c93f624ec-20210823T102722Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
References: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
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

    The partially-RFC series to add a GIT_TEST_CHECK_PROGRESS=1
    mode[1] helps spot this issue. Under it the 'missing file in
    delayed checkout' and 'invalid file in delayed checkout' tests in
    't0021-conversion.sh' fail, because both use only one
    filter.  (The test 'delayed checkout in process filter' uses two
    filters but the first one does all the work, so that test already
    happens to succeed even with GIT_TEST_CHECK_PROGRESS=1.)

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
't0021-conversion.sh' would succeed with the GIT_TEST_CHECK_PROGRESS=1
assertion discussed above, but the 'missing file in delayed checkout'
test would still fail.

It'll fail because its purposefully buggy filter doesn't process any
paths, so we won't execute that inner loop at all, see [2] for how to
spot that issue without GIT_TEST_CHECK_PROGRESS=1. It's not
straightforward to fix it with the current progress.c library (see [3]
for an attempt), so let's leave it for now.

1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/
2. http://lore.kernel.org/git/20210802214827.GE23408@szeder.dev
3. https://lore.kernel.org/git/20210620200303.2328957-7-szeder.dev@gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 entry.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index 125fabdbd52..d92dd020b3d 100644
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
2.33.0.632.g78310755cd0

