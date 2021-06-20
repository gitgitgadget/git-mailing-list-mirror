Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC7C49361
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F01B6117A
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFTUFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUFe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF41C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h17so6160414edw.11
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiDCyyLsu4wFSQhSwYqEMuh/P9WwQ+nah8L/meNdjmY=;
        b=GVRewo7uAx9he02hX67M9qtq4JV6Ge9+a8m7sSzHtgeWE01N1z1P/S9zg9yFmD8kT7
         49e9P0BEDyEdaaNMVB+jpYo9rb8Sa7E5IOmZ6fjknUXNS7DEEENIvjNAUM4juMnwwaWK
         inLJp5dlArJQOAzy/gLQHvZ2W9HV5qo6uoeK5Ewx9jAirl1N19Pm/dL0jbqe9Qbfv8pk
         IKKmnrj2tqsHOnh+VwIrYpSBticqRTfn6nTmkXSYgSGW9mYzYPaAjsE2uG2o8taAm9Za
         C2HtaxkqDJiRgdam9PutMpKLfmAxemFpIf9LhvFj/fRZSwBBDN6YAhl+J9TDgYVcq8Sh
         x/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiDCyyLsu4wFSQhSwYqEMuh/P9WwQ+nah8L/meNdjmY=;
        b=ZCMufjaMxPTOvwgq+X3pKa/SFZTcW8e0BhwY93hdLWHFNiaY85lrs/NXauxDVxQqap
         PK5Yl37dHAL4kvWVNhngdsVyH/4YFqdLtKeyKjvb9Wbj7UzcmJIL4cSW2MQGQ/hwD6sn
         qPzygyua2DYG0kRZBwzyYaNDZ/Yj0UGrRLkkYqckcp709ookb3dOXmsDg7SA1eRKmqrM
         ajL0J6tyHm9ouGmiRK8cBZ/c71+jHjq0KxnjPv+G/MngR5IKN7P/a4XZqK03o9MsWSo3
         i/ix775lUF2LJIUwaxYHssN4Fiv2d+VRKsC0I7LAfMvU2GR87/940TBZmw9dVKrCEfIK
         gj+A==
X-Gm-Message-State: AOAM531KtdYl6Yzkk5YONpk+Cf00aU58GB/GIJQG6RfLmgIzZgvlsxc8
        pZDabY/z/ThVzg66FNVk9irAa6cAAyM=
X-Google-Smtp-Source: ABdhPJzwlOyD58mhPCcNrjLhKNJ4I5/BM7GkSh9ZqVngNKyim1Vu3Tc2V7Sc2R9O5S3GsAGtUQ8KPg==
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr17367341edb.368.1624219396100;
        Sun, 20 Jun 2021 13:03:16 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/7] progress: catch nested/overlapping progresses with GIT_TEST_CHECK_PROGRESS
Date:   Sun, 20 Jun 2021 22:02:58 +0200
Message-Id: <20210620200303.2328957-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had to fix two buggy progress lines in the past, where
stop_progress calls were added at the wrong place [1], resulting in
"done" progress lines appearing in the wrong order.

Extend GIT_TEST_CHECK_PROGRESS to catch these cases as well, i.e.
trigger a BUG() when a progress has already been running when
start_progress() or one of its variants is called to start a new one.

Running the test suite with GIT_TEST_CHECK_PROGRESS enabled doesn't
reveal any new issues [2].

Note that this will trigger even in cases where the output is not
visibly wrong, e.g. consider this simplified sequence of calls:

  progress1 = start_delayed_progress();
  progress2 = start_delayed_progress();
  for (i = 0; ...)
      display_progress(progress2, i + 1);
  stop_progres(&progress2);
  for (j = 0; ...)
      display_progress(progress1, j + 1);
  stop_progres(&progress1);

This doesn't produce bogus output like what is shown in those two
fixes [1], because 'progress2' is already "done" before the first
display_progress(progress1, ...) call.  Btw, this is not just a
pathological example, we do have two progress lines arranged like
this, but they are only shown when standard error is a terminal, and
thus aren't caught by GIT_TEST_CHECK_PROGRESS in its current form.

[1] 6f9d5f2fda (commit-graph: fix progress of reachable commits,
                2020-07-09)
    862aead24e (commit-graph: fix "Collecting commits from input"
                progress line, 2020-07-10)

[2] This patch series applies with a minor conflict on top of
    6f9d5f2fda^, and makes 37 tests fail because of that bug.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/progress.c b/progress.c
index 255995406f..549e8d1fe7 100644
--- a/progress.c
+++ b/progress.c
@@ -48,6 +48,8 @@ struct progress {
 static volatile sig_atomic_t progress_update;
 
 static int test_check_progress;
+/* Used to catch nested/overlapping progresses with GIT_TEST_CHECK_PROGRESS. */
+static struct progress *current_progress = NULL;
 
 /*
  * These are only intended for testing the progress output, i.e. exclusively
@@ -258,8 +260,12 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	struct progress *progress;
 
 	test_check_progress = git_env_bool("GIT_TEST_CHECK_PROGRESS", 0);
+	if (test_check_progress && current_progress)
+		BUG("progress \"%s\" is still active when starting new progress \"%s\"",
+		    current_progress->title, title);
 
 	progress = xmalloc(sizeof(*progress));
+	current_progress = progress;
 	progress->title = title;
 	progress->total = total;
 	progress->last_value = -1;
@@ -383,6 +389,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
+	current_progress = NULL;
 	free(progress->throughput);
 	free(progress);
 }
-- 
2.32.0.289.g44fbea0957

