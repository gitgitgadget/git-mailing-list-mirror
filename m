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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30021C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF69B64E10
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBILmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhBILhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 06:37:07 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F788C0617A9
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 03:32:10 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id t142so2772118wmt.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 03:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kJC18C9UjNdFU+IHHbkveIfCe/0q0qPAvaWxxOluuho=;
        b=dh7dyT0o9QALfJ/6YXVwlIhlPjUmlLw/2Aoc83o9XHcZt02ca2yFc3YhDgerPBAyE0
         Rwmq38Y7HaUBQKwgAKKcuqhSy2cOKpPo3WVSB3xTuQukxs89CufoO2Mzk0aoEiVPxelL
         eLEwDCWiCwc8UQWXKJp6GpoAQmop0a2669BIVduOrrR8xnsD01GvtcRTPK+XZfb6k7Jf
         uBhOdxS8U/3YB01MLC0DV05sHeckL2fDCoUDWgGW0cO+tJ3+B/b4Q0VWYt6r+LTyG8Ol
         f+hx94z/Mh2qMK6wH6DMn+6m7ymwghiMPZ2fiNibIKyupmQsN2Pb+LgheP3zecbr6jY2
         u5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kJC18C9UjNdFU+IHHbkveIfCe/0q0qPAvaWxxOluuho=;
        b=qFot5CRwwytjiiX5MGHhxALnn24RDgqpKR1uW4EfCoQm7oXa7TR7x51VXHuFh6fcT6
         gKyKyvYNB7xdXOrDX3Ursf6UztONnqpD+G1Z18U4qKvaseEmRLGiHlm+Tjg7sfUsM7Yh
         ExPbvgq3NoDMcyCNpWSzb8Z04TT8Pd+s5Jh21vtjBoS1lPl3j50voVXmT0QfAu9HNHqZ
         YYPXZigVzaXM/v2xZBEMbPnRSJp3rc/sHel6XgwuqYMlHWAT6aLDTQmoY4HeLs3lLNsb
         h8R9Mn19i2AGq6EKiJS6yuqjLtAg0iHaQCxekQAzIBPwzA2HIu6tQ4CCd5szBNuGsgY1
         bgdw==
X-Gm-Message-State: AOAM5311K38j6nM7lNgq5uGXVCRtOD+XgJqD0+q8DIDG7rHRvGYdr7JZ
        nbwAPLaXQxJcb3FEMZAzZ9xi0ozmnKs=
X-Google-Smtp-Source: ABdhPJzl6ObhBwA7ycfztB/+vjIyEEaCH7hVTd/yUt1RSqPZKvwstqcWXTQDlWxrBEvLNGcqgNF2TA==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr2982843wmj.140.1612870329155;
        Tue, 09 Feb 2021 03:32:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm2334909wrt.7.2021.02.09.03.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:32:08 -0800 (PST)
Message-Id: <381a45d239bb52a70373c385d8978005c9cb4800.1612870326.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 11:32:03 +0000
Subject: [PATCH v2 1/4] diffcore-rename: compute basenames of all source and
 dest candidates
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

We want to make use of unique basenames to help inform rename detection,
so that more likely pairings can be checked first.  (src/moduleA/foo.txt
and source/module/A/foo.txt are likely related if there are no other
'foo.txt' files among the deleted and added files.)  Add a new function,
not yet used, which creates a map of the unique basenames within
rename_src and another within rename_dst, together with the indices
within rename_src/rename_dst where those basenames show up.  Non-unique
basenames still show up in the map, but have an invalid index (-1).

This function was inspired by the fact that in real world repositories,
most renames often do not involve a basename change.  Here are some
sample repositories and the percentage of their historical renames (as of
early 2020) that did not involve a basename change:
  * linux: 76%
  * gcc: 64%
  * gecko: 79%
  * webkit: 89%

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 74930716e70d..1c52077b04e5 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,6 +367,59 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
+MAYBE_UNUSED
+static int find_basename_matches(struct diff_options *options,
+				 int minimum_score,
+				 int num_src)
+{
+	int i;
+	struct strintmap sources;
+	struct strintmap dests;
+
+	/* Create maps of basename -> fullname(s) for sources and dests */
+	strintmap_init_with_options(&sources, -1, NULL, 0);
+	strintmap_init_with_options(&dests, -1, NULL, 0);
+	for (i = 0; i < num_src; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		char *base;
+
+		/* exact renames removed in remove_unneeded_paths_from_src() */
+		assert(!rename_src[i].p->one->rename_used);
+
+		base = strrchr(filename, '/');
+		base = (base ? base+1 : filename);
+
+		/* Record index within rename_src (i) if basename is unique */
+		if (strintmap_contains(&sources, base))
+			strintmap_set(&sources, base, -1);
+		else
+			strintmap_set(&sources, base, i);
+	}
+	for (i = 0; i < rename_dst_nr; ++i) {
+		char *filename = rename_dst[i].p->two->path;
+		char *base;
+
+		if (rename_dst[i].is_rename)
+			continue; /* involved in exact match already. */
+
+		base = strrchr(filename, '/');
+		base = (base ? base+1 : filename);
+
+		/* Record index within rename_dst (i) if basename is unique */
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

