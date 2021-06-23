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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E5C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A633B611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFWRvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFWRvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEAFC0611C3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f15so3571454wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ya+pUVx8JiV8Td10UldqXrkfuq841zNJDYc++C2Upto=;
        b=FR1pKQFwX8zOMhD1G9fl7DkDeAT4gCdSYkhY5GFwU6xVLIReNVzyo0eeBBrFkUdmph
         Smh9tOxP/qJhNHQmQzaKihNLvfqBcpD4L2Gf2bF5orZ1WQjXmRU1jOqnhAebNOfs9tcT
         V6ySRp9K0X70FqvpDwxpRLjrijHvDN3f08SsvC1MUMIK7pQo+IsFlz0rf/MqPTIay3OR
         S6Gh7pT/ibWcNEt13o7G/4VCgzKu6baP2k59tSBPGchqli3qn2AbuzL32FWm2tUldFqE
         f2pHZM5SODtUoQYFukzeOx2aZirlLxsX5FGSsushqe259jeN4ufrwGl3/cJD7vUs8eSn
         PIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ya+pUVx8JiV8Td10UldqXrkfuq841zNJDYc++C2Upto=;
        b=g3QG2Gfk3WlUzuxopxAu/CDFsdzKoU8eUE9k58+gwRA51BbausbVhSWs9UShSyxWpR
         nqeKXN5lEGuk6Lo/VjXH0ZAc7PP4jgwi3pLhKZgNF4YI79ggjhyBAcBDv8WSBt5WtKnZ
         bNdvivK4FnhgkggvE2xE+ccI9S8+vdRx9yZtQqwqgsooHgxUNgBIzZuswWQaNE8Kkcwd
         LRZv1wbTlW9IaLXjgc5oUrBwt+PqDnXBWpBx2oOUfPLMZKxazb01vtxJ0XXRnndB03o9
         cBoPi8Si0ktO8Lrechoep+IKFt/74JOPaXZuGkz9fzkeErtLAIcrhOGObD/nHLsO/fs9
         XUoA==
X-Gm-Message-State: AOAM530T47IRLPpoQINmhtL6RWVFprhiJhIVOx27GnyAcTGqNWraMKoe
        emYhSEwEazkxYR9XKO2lifmga055QauQjQ==
X-Google-Smtp-Source: ABdhPJzvW9ZVgz6JRPUdKJ+4Fuk5vX59qoBTfMGI2WQzQE1asohQ6b/YVwYu8lBDkvdA43u56MrSlQ==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr1396744wrt.405.1624470524367;
        Wed, 23 Jun 2021 10:48:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 21/25] entry: show finer-grained counter in "Filtering content" progress line
Date:   Wed, 23 Jun 2021 19:48:21 +0200
Message-Id: <patch-21.25-9ed1d5a39c2-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
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
index 711ee0693c7..bc4b8fcc980 100644
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
2.32.0.599.g3967b4fa4ac

