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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22D6C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A746761102
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbhHELBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbhHELBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 07:01:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260EC0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 04:01:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h14so5947200wrx.10
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dq/vmWOGxOAiqL5gwv53q6nJU9KG/pwZTgCd7RR647I=;
        b=ca6BzeCtMfhn6q6L+8Cpc90vcflYh9N9F0yt3ktneM5HLBYpxB/wMweNRyaSA/YAbU
         +qumOLzlSWmepck8dBWN97nxMmtQo5M7y56jPHFzFVyR2Q+pzuVZjGK23kxw6ZS3chw9
         v9EQggF4q+52m/LXa9Q8WqEBzOurBL7mdtYFF8lYk/JWjkOWKDVKc5DwsDWCLoQCHFgy
         dZL+zSMmWg2KxO18sFsWyFvWFt5ltH9NlsAVpcnbTaLCIvf27iIfoFr4D7al7H4ogXU2
         gMEj213dAlVgtxO24LyDqCigjKcno6WXLYB75Sv73HjHl2cZDFfrYf1yfmm6S6yZrJOL
         ZD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dq/vmWOGxOAiqL5gwv53q6nJU9KG/pwZTgCd7RR647I=;
        b=ZXRlKw1bccmF6URJHOz7CaXt4IEyfrlt1Kwz182aP1JFjqg2DDWrs01mHTelt+5VDp
         BeupA2f7/y1XF/y5CHRyZsA5/WCF8AVbdSWBpXl/jl0D2LxxtcrAhBKDPzlbcVLEAEqP
         M4c9EA1W7hSqtzaMnMyIj8R5RbXGXYnEzGFC1SGqWggIUptEltlGk11Fhnptl8BCn8VN
         lBbt3zT5gL8tJfbEMwCyYLyHTtprIjC3c9sFXut1td3kOfzZYDYQHjYjHcP/6Z+lBaCN
         0xqAR2TpLzQIVl7IoT8qeTnhTkBsfI+EEvqpVYyIzjKhgjad5xwaUDVsm6V8tt19+U0q
         UCKA==
X-Gm-Message-State: AOAM533GQ+uUP8XNW+11W2Ly/7eL6vvw+UUV1eEiE1vQTxo6kZALELtG
        lZG2Q5lHGvHa+Ury9m//kEzxP5ffjZII6Q==
X-Google-Smtp-Source: ABdhPJz/vdPYBhAO0qoQdvV69pvJtzsP+Q9/7x70OEuTUwRlzynHVd/axOSH7sLiv6T5oZNZobXewg==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr4564190wrw.166.1628161279235;
        Thu, 05 Aug 2021 04:01:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i10sm8836641wmq.21.2021.08.05.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:01:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] entry: show finer-grained counter in "Filtering content" progress line
Date:   Thu,  5 Aug 2021 13:01:13 +0200
Message-Id: <patch-v2-3.3-c70e554e46-20210805T105720Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com> <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
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
2.33.0.rc0.635.g0ab9d6d3b5a

