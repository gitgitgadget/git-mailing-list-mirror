Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9331F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfIQQfS (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39543 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbfIQQfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6so275290plv.6
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQmmABAfAiuMZIQMWO5taYozH7D/H4RiuSLGeQcH5bo=;
        b=dSXk3UrhaeXDOaiP/9HgWi49nOWu3t24nIUxD+6psxNPH5StNv0CQZwrD+y6D2a4Ir
         4+BVZJi5arF4s/G6bPNIRrWcfNKOX+5qdeI3acH7Zhv4vZLq9w4ZUOxLEhP2Y+WuMtk9
         Iq2jUX1T06kSSoxT276fSXZNgS3v0DTw9ZMwGiXa9/kj0ygzRXR0/FAX0/eo3nL9B4jf
         BNdSLHhjEVHyHlGNRQiUs+PDsgXEeeicJI7R01wVX4sKbstawJGjsSd22VRoD93spmZS
         VcTUvOAGZ8tlwcssMmVZizoysZziS9xqAsvHKGP2IzG0KsNdXYUyQBJw9NUQtD4K4xF3
         B+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQmmABAfAiuMZIQMWO5taYozH7D/H4RiuSLGeQcH5bo=;
        b=BMTvyOye2UeVuvHNCVcARfiR2pQvj0jwPaxGy0AeAmupmjCX/ZRzSPqmrquRVg0UvW
         J26fvEq3qunmql798ZoLbR1zscq85BXJf2bB+qm6Bdm/NMnj8lGbpntDc59KzM5iEkio
         3PzZI4TS1ZpE53f/BuC1uVKBD4grT276qsvIahUtcbpGAdzoPC6NLDs8ieQAJqoFlBF9
         qegFdTcIAoIFEyML43c67TNH0T2LYxMRqE7zMARiP11kkCAZBAmJERQSuCGKFZgGiTv9
         P1Um1brYYS/W7bgwA4AM7alqDuvmNGkreeLe8eWKzcyM7fuglT/X9uHcrFJBTXfSGM4i
         4lAQ==
X-Gm-Message-State: APjAAAWYMlvKtnpJb8byKoCzThqI4wSORlPDtAF1vK0/aNzMY9Ldjj6N
        8XBLjip6RQCCQ0An8dvLMdlGG/EM0tE=
X-Google-Smtp-Source: APXvYqzUcsv2mZmxpUgrYN57v1xUtWe/7JUnlGWy05fDjDc9f+dZk3qboQBJ4S/taH7bh8VcVS64XA==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr4564814plr.22.1568738115539;
        Tue, 17 Sep 2019 09:35:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 04/12] dir: also check directories for matching pathspecs
Date:   Tue, 17 Sep 2019 09:34:56 -0700
Message-Id: <20190917163504.14566-5-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if a directory doesn't match a pathspec, it is possible, depending
on the precise pathspecs, that some file underneath it might.  So we
special case and recurse into the directory for such situations.  However,
we previously always added any untracked directory that we recursed into
to the list of untracked paths, regardless of whether the directory
itself matched the pathspec.

For the case of git-clean and a set of pathspecs of "dir/file" and "more",
this caused a problem because we'd end up with dir entries for both of
  "dir"
  "dir/file"
Then correct_untracked_entries() would try to helpfully prune duplicates
for us by removing "dir/file" since it's under "dir", leaving us with
  "dir"
Since the original pathspec only had "dir/file", the only entry left
doesn't match and leaves nothing to be removed.  (Note that if only one
pathspec was specified, e.g. only "dir/file", then the common_prefix_len
optimizations in fill_directory would cause us to bypass this problem,
making it appear in simple tests that we could correctly remove manually
specified pathspecs.)

Fix this by actually checking whether the directory we are about to add
to the list of dir entries actually matches the pathspec; only do this
matching check after we have already returned from recursing into the
directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 5 +++++
 t/t7300-clean.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index bf1a74799e..76a3c3894b 100644
--- a/dir.c
+++ b/dir.c
@@ -1951,6 +1951,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 							 check_only, stop_at_first_file, pathspec);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
+
+			if (!match_pathspec(istate, pathspec, path.buf, path.len,
+					    0 /* prefix */, NULL,
+					    0 /* do NOT special case dirs */))
+				state = path_none;
 		}
 
 		if (check_only) {
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 2c254c773c..12617158db 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -699,7 +699,7 @@ test_expect_failure 'git clean handles being told what to clean' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean handles being told what to clean, with -d' '
+test_expect_success 'git clean handles being told what to clean, with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd */ut &&
@@ -715,7 +715,7 @@ test_expect_failure 'git clean works if a glob is passed without -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean works if a glob is passed with -d' '
+test_expect_success 'git clean works if a glob is passed with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd "*ut" &&
-- 
2.22.1.17.g6e632477f7.dirty

