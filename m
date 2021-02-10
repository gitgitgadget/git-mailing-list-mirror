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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66503C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5E464E7C
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhBJPQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBJPQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D0C061756
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:47 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i9so2146318wmq.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qRSc+dm1tQkHMASnWY40JsX73g/hNfM0nZohRVo2Sjo=;
        b=OMYcdrScWPDyUHysByqML9oZLmklcel/k/z4QbTZC8jpxm49i1X3TS0WG3DXo2ujA2
         /oYqrBs7TNYx6eMVx0b5/Lk7Qav5YkGU2H/J3TtwekcphQOYAF+w8//m7Fmwtz3NqVCc
         eF8Fbr7LSj1GQjxR/0HIOMZWgm16BcPejzBCP2+XwCZ3L5y6MRwyLUjR1nhQDExLBVSX
         xiVFJ/EuScjqPHRd0azXfiKA6jEoTaj0bwyzS4EBrLBqIpzuDM+u+HxK8CbQDqMH0B05
         HdPPyyCxJE4ig/GhmLkTl0ibOBCuVuUH0mxck0T2mMVFf+aHvfFvRbFphA3q4keeml2A
         dB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qRSc+dm1tQkHMASnWY40JsX73g/hNfM0nZohRVo2Sjo=;
        b=Tx56HV9T5yEAOn85Z4Z2ZhP/lFILUZSIzvgANqJy48ZRFhfHTmja0GQB3wHVmhyi3O
         0lSj9uzl5G4LYUaj3Nrd23IyKnelveqA9/GEo8wjDckHjNENWZHbg4WKzaatbulGQM7J
         lAWM0lxTCt78QpwO+S2lpAbLy/K14WF/cF/0nfhu7Bw9lVSR8C73n/0CWAPoFfKqAm+K
         v9vxoCyRi0D+Il9AFawICfuq/KLYMknRTk23kQ/w9dE0gFpP2iku1c4vts4/ExW8jj9w
         6fz3QaEdU42Z8tF1LKxc67Uo6nWFR2sThKL8bXjBmc+Y5ykZFgXJ4dl3nTFWCjLeZSYF
         E9/g==
X-Gm-Message-State: AOAM5333kU25UT7/p5Zw+uW9TQ9xiupiUNRtkJZSEJrn+tetouAkYAIv
        el+EhYPjezSoGhcKJWhSQOYD55a6IKE=
X-Google-Smtp-Source: ABdhPJy0e90EWw1sjB2nrLGHdpU5sLDjC2MLmffxtNCqYRpuFdl6K11IJK9hurIFIv6uljSI4vOuuQ==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr3251831wmi.15.1612970146658;
        Wed, 10 Feb 2021 07:15:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12sm3769377wru.18.2021.02.10.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:15:45 -0800 (PST)
Message-Id: <4fff9b1ff57b62587b1cbec2031f96199a214702.1612970140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 15:15:37 +0000
Subject: [PATCH v3 2/5] diffcore-rename: compute basenames of all source and
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
 diffcore-rename.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 74930716e70d..3eb49a098adf 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,6 +367,67 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
+static const char *get_basename(const char *filename)
+{
+	/*
+	 * gitbasename() has to worry about special drivers, multiple
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

