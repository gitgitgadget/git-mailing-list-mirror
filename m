Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7015A1F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937267AbeE3IEf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:04:35 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55947 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936081AbeE3IEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:04:15 -0400
Received: by mail-it0-f67.google.com with SMTP id 144-v6so22013442iti.5
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NHemEYrjwhIv4Rq5zhyvBXu6P/LDAeZusgZjYhp4G9M=;
        b=kZJ5AiYgrGs3BtcP9A7Qy3jZEvQg7jkDo86huEHiHpaDiE7sn6jJ72h7q6bdSMgjRd
         PrmTS0GtLs5ZORagr7Ih6g8jJ9La50CxpT6KQqOtGuEb++TlgRvdujt0R6/Od/2KE06H
         GIA7Lob4/6UExy+e3r/YhmT3gntYlEFqmN5zY/ExQ5lGpcrsWLdet7V4VsLu7ZJ99Y1j
         u8bv1yrHuxc/1CktB7Q6ZherB0fuQg5yWyPHww995iNn0ERA3ev4NxuJrNiCZhvYhetC
         ErVa93Z7Ghj8QEDSQ4n08RGu0A6tIT1WH0mPQUUA6yTLgkWcf0fS3GKE2CGZh/Ophmib
         gFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NHemEYrjwhIv4Rq5zhyvBXu6P/LDAeZusgZjYhp4G9M=;
        b=OXydmWp/EkLa0TfYE/Clj3PqfYY19Ri/wV/+IO2/xOgB0aAFVmgj65GX/Ox0w+hbfc
         3BDXWHlL+ZghgVtw7H65oIiqgTUSgkr2DknzUkkapTKBNlso+yRV0Jrd6CrpivTVkd2t
         0TuuU6W17VecbLN86fkrepgtanioxISF/O0SqGoznYSF5MofL7WY8GI4uoDARRKd4jBk
         RMcRxn84WmxyvD9Dm/vtggGw1WAJ4yIo+quEV7N+KzukrddvuDBGq67Wy4bNd2qe+HVH
         WW83sZ9pnuCKCZ6aRzH2M855wqcnKZ2CYeW3Ov2rxVXuHdIP76zfJrinHOm1trZ4XhLy
         7gdQ==
X-Gm-Message-State: APt69E2l7UGwl7LjAyOj6inluuhdo5KXJ+IzywRgD0C9meN33hhtXb/h
        VOKJ2xFcRZgN7JgDRuc0Cu64iA==
X-Google-Smtp-Source: ADUXVKJr1xNeMWhfUaME7CkT90utMAmRenx+p8YGxfvKgl0NbLNOTgl/OVd8CU+EbzrsIhvbrUXttg==
X-Received: by 2002:a24:7311:: with SMTP id y17-v6mr442956itb.105.1527667454801;
        Wed, 30 May 2018 01:04:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id t9-v6sm17447561ioa.82.2018.05.30.01.04.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 30 May 2018 01:04:14 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH 3/5] format-patch: extend --range-diff to accept revision range
Date:   Wed, 30 May 2018 04:03:23 -0400
Message-Id: <20180530080325.37520-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.1.1235.ge295dfb56e
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting a revised a patch series, the --range-diff option embeds
a range-diff in the cover letter showing changes since the previous
version of the patch series. The argument to --range-diff is a simple
revision naming the tip of the previous series, which works fine if the
previous and current versions of the patch series share a common base.

However, it fails if the revision ranges of the old and new versions of
the series are disjoint. To address this shortcoming, extend
--range-diff to also accept an explicit revision range for the previous
series. For example:

    git format-patch --cover-letter --range-diff=v1~3..v1 -3 v2

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt |  8 +++++---
 builtin/log.c                      | 16 +++++++++++++---
 t/t7910-branch-diff.sh             |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f4c70e6b64..25026ae26e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -233,10 +233,12 @@ feeding the result to `git send-email`.
 	As a reviewer aid, insert a range-diff (see linkgit:git-branch-diff[1])
 	into the cover letter showing the differences between the previous
 	version of the patch series and the series currently being formatted.
-	`previous` is a single revision naming the tip of the previous
-	series which shares a common base with the series being formatted (for
+	`previous` can be a single revision naming the tip of the previous
+	series if it shares a common base with the series being formatted (for
 	example `git format-patch --cover-letter --range-diff=feature/v1 -3
-	feature/v2`).
+	feature/v2`), or a revision range if the two versions of the series are
+	disjoint (for example `git format-patch --cover-letter
+	--range-diff=feature/v1~3..feature/v1 -3 feature/v2`).
 
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index 460c31a293..e38cf06050 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -995,10 +995,20 @@ static char *find_branch_name(struct rev_info *rev)
 
 static void infer_diff_ranges(struct argv_array *args,
 			      const char *prev,
+			      struct commit *origin,
 			      struct commit *head)
 {
-	argv_array_pushf(args, "%s...%s", prev,
-			 oid_to_hex(&head->object.oid));
+	if (strstr(prev, "..")) {
+		if (!origin)
+			die(_("failed to infer range-diff ranges"));
+		argv_array_push(args, prev);
+		argv_array_pushf(args, "%s..%s",
+				 oid_to_hex(&origin->object.oid),
+				 oid_to_hex(&head->object.oid));
+	} else {
+		argv_array_pushf(args, "%s...%s", prev,
+				 oid_to_hex(&head->object.oid));
+	}
 }
 
 static int get_range_diff(struct strbuf *sb,
@@ -1059,7 +1069,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	/* might die from bad user input so try before creating cover letter */
 	if (range_diff) {
 		struct argv_array ranges = ARGV_ARRAY_INIT;
-		infer_diff_ranges(&ranges, range_diff, head);
+		infer_diff_ranges(&ranges, range_diff, origin, head);
 		if (get_range_diff(&diff, &ranges))
 			die(_("failed to generate range-diff"));
 		argv_array_clear(&ranges);
diff --git a/t/t7910-branch-diff.sh b/t/t7910-branch-diff.sh
index edbd69b6f8..c0e8668ed9 100755
--- a/t/t7910-branch-diff.sh
+++ b/t/t7910-branch-diff.sh
@@ -155,5 +155,6 @@ format_patch () {
 }
 
 format_patch 'B...C' topic
+format_patch 'A..B A..C' master..topic
 
 test_done
-- 
2.17.1.1235.ge295dfb56e

