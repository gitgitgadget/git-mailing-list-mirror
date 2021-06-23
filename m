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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F5C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27A160FE9
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFWWAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWWAF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:00:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA41C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f15so4267359wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Fns5i+ciWh/a8IzANDV6s1EhIVndJbs8fNjDAEjn2Q=;
        b=rvjWt17maIQTegIlk5hIgBNjcf7X8ikBDgPJs0eR7Pn47Opa3hlyTYaDlv2aDAg/YP
         07KVDBnSV7AS5co63YZNID9MBudran//1HUTvMSBefaStog0oAiKbEg1K+MTxc020pen
         0NabhGOO1U4oL+1ife1QgxWXkTnNKtY8oBBHSCvQieBjbJ7V9qPzO4Xb6DOlarOB7KEQ
         bIBwMZ63slCbeKa9aFvW1C3N1ZJ/zdu4jQnMDP2vGgLXhdgCd090e8afa+3hMp7jCS+t
         gPtoq2QqI4CFd9NpG4YOFIVYKagpGPOuGNlisCMRJfWBDfKFOd0MZiJNjD60GG/8EI03
         G89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Fns5i+ciWh/a8IzANDV6s1EhIVndJbs8fNjDAEjn2Q=;
        b=p21yD8JA13urBMAWQLFGXK4fils8/vS/lwF85DD4OngNiDG2iOZ385wUqgdtPp9dFq
         n0sJ6SYWqW16oortJHLpCtXNltatR5Alxh04wHXQ0dBpVQvkMeYHbH1vlEHdA5QmR4P0
         czOB5/dmAZp1aqU3rGKx391G5Tad4HkkBBj0oXLe2CguQifEWs51wqcQAkSD139bDT4r
         s3bU9oCPUgE4EqONaWg8+1FPKhtcEr1Q2N2OXEByWKPav4uHbeVZgNaLtLzMu/SpDgSe
         R5LdZSA7Vi1CmTFHganCYlXwR53N2/3MYxu1CzGoqA+AmlVpmrnR2Ef2M13qmwfQvu96
         CqPA==
X-Gm-Message-State: AOAM533l047PK+YVbJi3wfhzdoaI0qaJlldIaAmpxlXDi7/o4qfo4aP3
        dlFqmwFRjClSpPX6JwN1MHIbXvP8Ah8=
X-Google-Smtp-Source: ABdhPJx3UiE8t1FNku0yk3KDQZXiQ7B2EtDZGU3lm6hU0Z11Kv+YdIdxvd+yYjtSMME2AcRNDF6Z+A==
X-Received: by 2002:a5d:4851:: with SMTP id n17mr294740wrs.85.1624485465797;
        Wed, 23 Jun 2021 14:57:45 -0700 (PDT)
Received: from localhost.localdomain (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id q11sm1192348wrx.80.2021.06.23.14.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:57:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] blame: fix progress total with line ranges
Date:   Wed, 23 Jun 2021 23:57:34 +0200
Message-Id: <20210623215736.8279-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210623215736.8279-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210623215736.8279-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When not blaming a whole file but only a subset of its lines using the
'-L<start>,<end>' option, then the "Blaming lines" progress counter
can be way off, because the counter only counts the actually processed
lines in the line range(s) while the expected total wrongly shows the
number of lines in the given file:

  $ wc -l git.c
  932 git.c
  $ GIT_PROGRESS_DELAY=0 git blame -L10,20 git.c
  Blaming lines:   1% (11/932), done.
  <...>

Let's sum up the number of lines in all (sorted and merged) line
ranges and specify the resulting number as expected total.  (Note:
when blaming the whole file, then we (implicitly) have one line range
encompassing all its lines, so this approach works even when no line
range was given as option.)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/blame.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5efb920dd4..7d29f5dc61 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1121,9 +1121,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 	sort_and_merge_range_set(&ranges);
 
+	lno = 0;
 	for (range_i = ranges.nr; range_i > 0; --range_i) {
 		const struct range *r = &ranges.ranges[range_i - 1];
 		ent = blame_entry_prepend(ent, r->start, r->end, o);
+		lno += r->end - r->start;
 	}
 
 	o->suspects = ent;
@@ -1152,7 +1154,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
-	pi.progress = start_delayed_progress_if_tty(_("Blaming lines"), sb.num_lines, show_progress);
+	pi.progress = start_delayed_progress_if_tty(_("Blaming lines"), lno, show_progress);
 
 	assign_blame(&sb, opt);
 
-- 
2.32.0.289.g44fbea0957

