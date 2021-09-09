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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92DC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B403B61164
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349078AbhIIBL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349038AbhIIBL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:11:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742AC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:10:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g74so128148wmg.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESWwjuP9OSuARbsl4G+DhqgQ8qirIzsw+RtGFa7kih0=;
        b=XWxjJMWapHTOdH+bnJRZWaSURtSMJsufa3FveFh/MGTZt3FJRlH2YYyrptTOjvFPeu
         3DAkdaGd9L5dkUtGhUGx9Q9w4jzzHTolSfnRUyQstXkP/7SDjr6tT2jEaYVk0tK0+wIz
         AohM9UJ0w122eXNQ+9JZuOLbTDdwh7U86VMPR2W06Ea44bLljs8Sw70OTeM9w9RSnwqh
         ff9VypmMiNNTU6K4FZxgwPHseqVzv8EzwiTXUfhgF6k8K5W6+xtGGpnuMNQj06EMtqk3
         0eTwRVzbRVlsZzioy6TyTTLcqTbuU6HeEbScT58rBzdlSg28CjmKMMdQdZeYgR0f37O1
         80Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESWwjuP9OSuARbsl4G+DhqgQ8qirIzsw+RtGFa7kih0=;
        b=J7tkcnPLBqlI8Wh5rcg4UW0tO6ylFGU/8crEFyX+PCTgNR6vKKlrvJHWOEOzFsR09H
         H0klM2l//WP7BrijXAVMF4no/22N1WV2oY/Q0zbnqNVj0fprrv01gog5ezULRoo3AsQe
         vbREWD/KdBEpBn/g8eLFPT9C5ELU/K+q3hgQCsE6iDuBwn5WDmS1wJLH7rN3PDbkbmkV
         WV8JCHxtzquaVWeLEmWtPBf9RVIAPhznahDPDKyquAk7zifKMmuDjAvtsVktrWLn4Cl/
         kqYACGFg4jWMN1TOvPribbDU5Q42/ej8GRnTjVXXjnPPLHa528eBitlmkdpAOagYelVn
         rpiA==
X-Gm-Message-State: AOAM5312Xs1SDmILa+0bRhkNXF2lrh1QJDkCP9F0m2mBThXJ0trQZDYb
        hKPSvivhXg+GBbgx/06vj/wE3Qyk1vybDg==
X-Google-Smtp-Source: ABdhPJz9zScAOcvaf3ujHMYgidbVj4H2a+7np/Vhz7UW+Q7456FO4DRXQvpJi5YNcow3axUnSq3ljA==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr239462wme.137.1631149816285;
        Wed, 08 Sep 2021 18:10:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm187422wrm.74.2021.09.08.18.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:10:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/2] entry: show finer-grained counter in "Filtering content" progress line
Date:   Thu,  9 Sep 2021 03:10:12 +0200
Message-Id: <patch-v4-2.2-54a09b5b883-20210909T010722Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.gdc3f7a2a6c7
In-Reply-To: <cover-v4-0.2-00000000000-20210909T010722Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com> <cover-v4-0.2-00000000000-20210909T010722Z-avarab@gmail.com>
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

Let's also initialize the *progress to "NULL" while we're at it. Since
7a132c628e5 (checkout: make delayed checkout respect --quiet and
--no-progress, 2021-08-26) we have had progress conditional on
"show_progress", usually we use the idiom of a "NULL" initialization
of the "*progress", rather than the more verbose ternary added in
7a132c628e5.

1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/
2. http://lore.kernel.org/git/20210802214827.GE23408@szeder.dev
3. https://lore.kernel.org/git/20210620200303.2328957-7-szeder.dev@gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 entry.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/entry.c b/entry.c
index 044e8ec92c6..9b0f968a70c 100644
--- a/entry.c
+++ b/entry.c
@@ -163,24 +163,21 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
 			    int show_progress)
 {
 	int errs = 0;
-	unsigned delayed_object_count;
+	unsigned processed_paths = 0;
 	off_t filtered_bytes = 0;
 	struct string_list_item *filter, *path;
-	struct progress *progress;
+	struct progress *progress = NULL;
 	struct delayed_checkout *dco = state->delayed_checkout;
 
 	if (!state->delayed_checkout)
 		return errs;
 
 	dco->state = CE_RETRY;
-	delayed_object_count = dco->paths.nr;
-	progress = show_progress
-		? start_delayed_progress(_("Filtering content"), delayed_object_count)
-		: NULL;
+	if (show_progress)
+		progress = start_delayed_progress(_("Filtering content"), dco->paths.nr);
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths = STRING_LIST_INIT_NODUP;
-			display_progress(progress, delayed_object_count - dco->paths.nr);
 
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
@@ -227,6 +224,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
 				ce = index_file_exists(state->istate, path->string,
 						       strlen(path->string), 0);
 				if (ce) {
+					display_progress(progress, ++processed_paths);
 					errs |= checkout_entry(ce, state, NULL, nr_checkouts);
 					filtered_bytes += ce->ce_stat_data.sd_size;
 					display_throughput(progress, filtered_bytes);
-- 
2.33.0.825.gdc3f7a2a6c7

