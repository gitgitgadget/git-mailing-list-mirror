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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF79C433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A724261158
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349018AbhIIBL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhIIBLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:11:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FEC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:10:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n5so5853320wro.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufllTAVUWjOkaIdXGf/jGHTqL8USx303QyicMMrIdZM=;
        b=G+qp50cjQXoX+/EyG3yC4Uk74AMYiJth58aB73p8tIyn4dTeq4ac3CGan0iLsnfiJx
         o48UQqCcNyDjvJ6O78eGiOvv9ywlVuQuybw8o7cWZPtLbkTGCF21eKcCCY3exRuiVr8x
         BeGicmCidugMBksxNyLPQUFo9Neec6V8j6pULJIqD8RgUnlMmLCM3a/Zo0a0uIwWhSwK
         HqfzUDV9caWejhaiN9e9gag7nhFv3pcxWU2/3muLCqPD/nqyEGFRyBrOJEQX3oAwcZit
         lmU/bLJQlk3rsYIbGJkQvopV/QfTgL3WfLoUCHl5zQWJbhwyMFd6JZrKeYH120SkmO/C
         GDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufllTAVUWjOkaIdXGf/jGHTqL8USx303QyicMMrIdZM=;
        b=ybKhAxtKor6vX0qGyWlJpKGSSdCEN1k+ezhd92pxlRlqgFoD2wlmtP7rfPa70y1nxM
         fTyPY+5zQm2kJNTGwUyitATf2cjKdDfpUH9xcz/BajE9OiGi45+n9qQUrVMA25Fs1RY0
         EHaz7M2g9f96JzEj2jatwQyQNJZ17aJgUIEKTZH3CjEQwWrh3btU0QYJLOzxSl3l6th/
         Dhx54V2Wpr/K31RJxn6SxczqXK1UOwhgJncfpNXVho8Tw52mxIwLnqkWDgeK1tu/0QTT
         mSc6yRx45YuuFHtdyFTGbPIOHhEJarHd9/DEgrUFuLDgOL6VhUafsESd+QmxiioM6OGV
         ebVA==
X-Gm-Message-State: AOAM531bydB3hCUjtYWkQepg0MVtk0mRylF7ppw0IukWCiIBsa0ngVkF
        lRfi4d+mkWbZWoRLCZbxk9iLXOk/5iINTw==
X-Google-Smtp-Source: ABdhPJzhdB7RyYJbEs6vg2LZ6iXUy8P96dKfhjBxCCot0VACfVZLBJ1TPq8L7kbhKmKB1f1z/4tJQA==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr453812wra.216.1631149814521;
        Wed, 08 Sep 2021 18:10:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm187422wrm.74.2021.09.08.18.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:10:13 -0700 (PDT)
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
Subject: [PATCH v4 0/2] progress.c API users: fix bogus counting
Date:   Thu,  9 Sep 2021 03:10:10 +0200
Message-Id: <cover-v4-0.2-00000000000-20210909T010722Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.gdc3f7a2a6c7
In-Reply-To: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix bad uses of the progress.c API. See
https://lore.kernel.org/git/cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com
for the v3.

This re-roll is on top of a merge conflict in v3 with 7a132c628e5
(checkout: make delayed checkout respect --quiet and --no-progress,
2021-08-26), i.e. the mt/quiet-with-delayed-checkout topic.

SZEDER Gábor (2):
  commit-graph: fix bogus counter in "Scanning merged commits" progress
    line
  entry: show finer-grained counter in "Filtering content" progress line

 commit-graph.c |  2 +-
 entry.c        | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

Range-diff against v3:
1:  443374551ad = 1:  4cc3923089d commit-graph: fix bogus counter in "Scanning merged commits" progress line
2:  71c93f624ec ! 2:  54a09b5b883 entry: show finer-grained counter in "Filtering content" progress line
    @@ Commit message
         straightforward to fix it with the current progress.c library (see [3]
         for an attempt), so let's leave it for now.
     
    +    Let's also initialize the *progress to "NULL" while we're at it. Since
    +    7a132c628e5 (checkout: make delayed checkout respect --quiet and
    +    --no-progress, 2021-08-26) we have had progress conditional on
    +    "show_progress", usually we use the idiom of a "NULL" initialization
    +    of the "*progress", rather than the more verbose ternary added in
    +    7a132c628e5.
    +
         1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/
         2. http://lore.kernel.org/git/20210802214827.GE23408@szeder.dev
         3. https://lore.kernel.org/git/20210620200303.2328957-7-szeder.dev@gmail.com/
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## entry.c ##
    -@@ entry.c: static int remove_available_paths(struct string_list_item *item, void *cb_data)
    - int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
    +@@ entry.c: int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
    + 			    int show_progress)
      {
      	int errs = 0;
     -	unsigned delayed_object_count;
     +	unsigned processed_paths = 0;
      	off_t filtered_bytes = 0;
      	struct string_list_item *filter, *path;
    - 	struct progress *progress;
    -@@ entry.c: int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
    +-	struct progress *progress;
    ++	struct progress *progress = NULL;
    + 	struct delayed_checkout *dco = state->delayed_checkout;
    + 
    + 	if (!state->delayed_checkout)
      		return errs;
      
      	dco->state = CE_RETRY;
     -	delayed_object_count = dco->paths.nr;
    --	progress = start_delayed_progress(_("Filtering content"), delayed_object_count);
    -+	progress = start_delayed_progress(_("Filtering content"), dco->paths.nr);
    +-	progress = show_progress
    +-		? start_delayed_progress(_("Filtering content"), delayed_object_count)
    +-		: NULL;
    ++	if (show_progress)
    ++		progress = start_delayed_progress(_("Filtering content"), dco->paths.nr);
      	while (dco->filters.nr > 0) {
      		for_each_string_list_item(filter, &dco->filters) {
      			struct string_list available_paths = STRING_LIST_INIT_NODUP;
    @@ entry.c: int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
      
      			if (!async_query_available_blobs(filter->string, &available_paths)) {
      				/* Filter reported an error */
    -@@ entry.c: int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
    +@@ entry.c: int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
      				ce = index_file_exists(state->istate, path->string,
      						       strlen(path->string), 0);
      				if (ce) {
-- 
2.33.0.825.gdc3f7a2a6c7

