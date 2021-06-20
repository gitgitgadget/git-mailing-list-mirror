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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A450DC49EA2
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0C66117A
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFTUFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFTUFg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35DDC061767
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hz1so2563110ejc.1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRbxFCBj2EGP+jex1hp3XyVDA+zM1W9FtD+p6DiEfUY=;
        b=jishtJfUdvz+vukvupTJYb7WZ20X0b4LJPqrBJ1omHd6jfWT+AlmPviO1Vq+peNgCr
         0u/xOqTYiuDGe6wc0Be9b4HrlWNbcH5aGMlIrbVCnMgaGbEcyYWZIAr/Y2BW4m5GOB64
         S6+Z9Bja2LcESRYhXOLf4JpHr7kaMj9MUcGxDyXpj3iB0t2hoPRprQyXbLC7q3jw46k1
         Q5HV9TJW2235EsyQ6Qc4fUgZxwcFXtoX+z7mBKNbmbAxQu+0mrbB9AiLXJN+ie0vk1fD
         3xqcNc8YwNbTqKV2aY77y88qlTR71n4+jeWYJ+41hX6aDkOMNWl48zlQyRdCuZCip2uw
         WpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRbxFCBj2EGP+jex1hp3XyVDA+zM1W9FtD+p6DiEfUY=;
        b=ZFiXomlUsDpLjcCGUbDgTPzzrZ3EGXB5t32qIOSi5of6W1EqGiXysWjGLfXnYGJuQP
         JhS1VqbdLm/cUPRAudq0FXmwYxQxBGSjpwmFnIbYaEdOMTaoTNYLarGh2ol7+9+wux9F
         JM0tKHULCm4UGjy+yc/L5rXp7SgiePAEbfVkMv3D1Q/HtgsXBa7vFLr7jnPnabJbl3p2
         yDNLVzab+xlpujmwwBi2F1kTY8I0OQAng2E5MfhDTI8c2Tv21sSefMu73y6bIj1ZyByA
         HF2L/yQOeIkY06xAKvT9yXmP5CEOaGqWNZnjWLOtjwryKR7Bs9LT92mOz4h7KQMH/gUA
         g28Q==
X-Gm-Message-State: AOAM533TQHE/2v1dPDtIxsB030GN9Sx8HW/FjQ666srtUpypOuaXaTwI
        xohrF864QEdYZoV3mmYNxZvMRpXK/s4=
X-Google-Smtp-Source: ABdhPJxoAx/FLWC5rwZLB94SoDsWKbDZuPSk1FCAHc8mnXfI08sKdnE1NnNsQ5bq53NhRpmSeTk6mA==
X-Received: by 2002:a17:907:2648:: with SMTP id ar8mr1654713ejc.77.1624219401356;
        Sun, 20 Jun 2021 13:03:21 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/7] entry: show finer-grained counter in "Filtering content" progress line
Date:   Sun, 20 Jun 2021 22:03:01 +0200
Message-Id: <20210620200303.2328957-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

    This is, in part, responsible for the failures of the tests
    'missing file in delayed checkout' and 'invalid file in delayed
    checkout' in 't0021-conversion.sh' when run with
    GIT_TEST_CHECK_PROGRESS=1, because both use only one filter.  (The
    test 'delayed checkout in process filter' uses two filters but the
    first one does all the work, so that test already happens to
    succeed even with GIT_TEST_CHECK_PROGRESS=1.)

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
't0021-conversion.sh' will succeed with GIT_TEST_CHECK_PROGRESS=1, but
the 'missing file in delayed checkout' test will still fail, because
its purposefully buggy filter doesn't process any paths, so we won't
execute that inner loop at all (this will be fixed in the next patch).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 entry.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index 711ee0693c..bc4b8fcc98 100644
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
2.32.0.289.g44fbea0957

