Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A85C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43E864E26
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBNHxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBNHwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:52:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD0C061794
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v1so4876835wrd.6
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uZny5BrtX8p6GHeuR5iGv/SGoLZFSHGKt/f8MpnJiZo=;
        b=Ly3bJ1nXRMB6+sgFq9HpGuMKdYo/Y6oJJMoLuYY+E9kQJnJT41xlapp3zwyf801WiQ
         79Ackf9VYCwjNk1M4N/UwHXPlHgq1axdkBJbkTf73Cv1MpouWYNwTzDirRdwETu2uMP/
         hfe39jIZE3j5by2WTp363ErRBYmbkG66JVzWSlFVXVwTdC8xquMbwJ7sTZ1Mh6BHhT/W
         LVUo1ADEnf3lEwBVyPEXc0X8oQ8w1+SJmuISz58nv9+nxmLIY3T34kZR4rH2IRsvqm1b
         UXiGrmnqRh4sPFLBUaBpX9NyUlFIBzHLF/Wriudst0gr4c0QFIgFHjB9oqh7W49ox1Mz
         D3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uZny5BrtX8p6GHeuR5iGv/SGoLZFSHGKt/f8MpnJiZo=;
        b=gFofsCdGAcz2ZeCMo5gHSaZ+pU08bZ6vcECkv5H67T7qmweZFRpvFN+lD4akAEjrRu
         LRCFS5zu/xpvPpP80bc8BmVcuQAb71tu9YD96kmMwAHCTwwB5j66zkK86sP7w2AAyqfK
         BVLH6CGPaM0zB9GBbtFUD/sm7hHsQG9yd1s5Kdj1k+Ch3uTbgRPNbpslvQOyDhz8w2nH
         wNjC11R3sQda+KMjJqNgwHgGiBgw9nAC9DhAdbEzzLGYPrNM8/hpIrxKdMOa2cHuE4OC
         BSer+LulS27Zipc1DRko17GdW+tp/nOJ2u8AnmpZMO11eNcAKr6VeBfdqOdyc6NjdhS/
         R5UQ==
X-Gm-Message-State: AOAM533SG6DhOsJ3rw8OiYnwq6UVXyOhqfq2iW0bs6T5Y9Wbh0J9xT4m
        rJ91M3FPhrDFOKQDseUq2Ur0kxbbiM8=
X-Google-Smtp-Source: ABdhPJyWYZFb048gUib/B9B/N93v4ERcrq5G9+GKKalIFMv1TQxNHEBFlVTlHWp2R/Qjg8l1yQ01UQ==
X-Received: by 2002:adf:dd81:: with SMTP id x1mr12431008wrl.233.1613289114221;
        Sat, 13 Feb 2021 23:51:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm16595197wrn.60.2021.02.13.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:51:53 -0800 (PST)
Message-Id: <73baae2535d0d2d50f1d05d81f575c29f9776c97.1613289112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
References: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
        <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:51:47 +0000
Subject: [PATCH v5 2/6] diffcore-rename: compute basenames of source and dest
 candidates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to make use of unique basenames among remaining source and
destination files to help inform rename detection, so that more likely
pairings can be checked first.  (src/moduleA/foo.txt and
source/module/A/foo.txt are likely related if there are no other
'foo.txt' files among the remaining deleted and added files.)  Add a new
function, not yet used, which creates a map of the unique basenames
within rename_src and another within rename_dst, together with the
indices within rename_src/rename_dst where those basenames show up.
Non-unique basenames still show up in the map, but have an invalid index
(-1).

This function was inspired by the fact that in real world repositories,
files are often moved across directories without changing names.  Here
are some sample repositories and the percentage of their historical
renames (as of early 2020) that preserved basenames:
  * linux: 76%
  * gcc: 64%
  * gecko: 79%
  * webkit: 89%
These statistics alone don't prove that an optimization in this area
will help or how much it will help, since there are also unpaired adds
and deletes, restrictions on which basenames we consider, etc., but it
certainly motivated the idea to try something in this area.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6fd0c4a2f485..e51f33a2184a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,6 +367,69 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
+static const char *get_basename(const char *filename)
+{
+	/*
+	 * gitbasename() has to worry about special drives, multiple
+	 * directory separator characters, trailing slashes, NULL or
+	 * empty strings, etc.  We only work on filenames as stored in
+	 * git, and thus get to ignore all those complications.
+	 */
+	const char *base = strrchr(filename, '/');
+	return base ? base + 1 : filename;
+}
+
+MAYBE_UNUSED
+static int find_basename_matches(struct diff_options *options,
+				 int minimum_score)
+{
+	int i;
+	struct strintmap sources;
+	struct strintmap dests;
+
+	/*
+	 * Create maps of basename -> fullname(s) for remaining sources and
+	 * dests.
+	 */
+	strintmap_init_with_options(&sources, -1, NULL, 0);
+	strintmap_init_with_options(&dests, -1, NULL, 0);
+	for (i = 0; i < rename_src_nr; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		const char *base;
+
+		/* exact renames removed in remove_unneeded_paths_from_src() */
+		assert(!rename_src[i].p->one->rename_used);
+
+		/* Record index within rename_src (i) if basename is unique */
+		base = get_basename(filename);
+		if (strintmap_contains(&sources, base))
+			strintmap_set(&sources, base, -1);
+		else
+			strintmap_set(&sources, base, i);
+	}
+	for (i = 0; i < rename_dst_nr; ++i) {
+		char *filename = rename_dst[i].p->two->path;
+		const char *base;
+
+		if (rename_dst[i].is_rename)
+			continue; /* involved in exact match already. */
+
+		/* Record index within rename_dst (i) if basename is unique */
+		base = get_basename(filename);
+		if (strintmap_contains(&dests, base))
+			strintmap_set(&dests, base, -1);
+		else
+			strintmap_set(&dests, base, i);
+	}
+
+	/* TODO: Make use of basenames source and destination basenames */
+
+	strintmap_clear(&sources);
+	strintmap_clear(&dests);
+
+	return 0;
+}
+
 #define NUM_CANDIDATE_PER_DST 4
 static void record_if_better(struct diff_score m[], struct diff_score *o)
 {
-- 
gitgitgadget

