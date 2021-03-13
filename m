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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B976C433E9
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326E164EC9
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhCMWWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhCMWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBDC061763
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l11so6740354wrp.7
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8C4NU9XuO3kkFqDLgcnC/yVC45WVPTrbfch2ha3o0n4=;
        b=ewQNZzxN7FEw4wjjUhXXG951R+qAbFaYh67AjulworMXQTLgMhxrZqdsfYj90VUuO/
         Q+FQs8lyvmDSYuP1BmKQeIhK1ZHfkyNDAb1sxMh1h8UOgkjI91q+9I3aLdeQZ2HyrTtY
         jyDE9WS9qRBK1quuY0/0AtCgQ15W63nwQN6lEU4AAmg1+g1GP5KO5A06d/X5lmuKYTlG
         nfwqR4U6gDPcv7JfugvZcUb9lwmWPCWTq7KhkXkrqRXENkSrzvXNICbf1Tjnzf51NH4Z
         P3368YRISiwMDMm433meeOo+y+NEswMPD+hWSO1fZClsg2JATmPXX80PKqPrhcEQH919
         nr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8C4NU9XuO3kkFqDLgcnC/yVC45WVPTrbfch2ha3o0n4=;
        b=ExKHhsIZ0l9P9iPPMJ1p0Hm0bGeROsw9FMTL0PLglYkeXD55943LhnpJRrDc8lzrLC
         Y+jcxzIXtuKvTgMpf5K6W1mo+dkpKk8457ONGDQqLiObJc5i9Z12k/3aqHYeHRwO78NJ
         DkGhb3iBm2c777qESEhyrFK08BE6AQ9ahcqaTS1yfJrojMbUHD6vl8pwKRbJRWZX+2JJ
         upM/U0kKSpi+CJEEyK0IfwwnpygtPSUaVVlLf70zmeTb2Hcpd+GBrJzbrhJ/PGoNr/Ca
         sywy7m6jz1hvhL1QGHGDZ2EuhoCOsjI1RkF1iV6GX0wo2D58JmZI5Yz6Q/DEvRHZ6T1X
         B/mQ==
X-Gm-Message-State: AOAM533t7DWkTAmH0yidSfWDkUO5wkrPHx+AG+2vmTblirDGdZyESj8/
        1SOC1pXFHESf0OgAfEDILO5b1y21G3c=
X-Google-Smtp-Source: ABdhPJxv0pUPrNnmH4XyCWFuT1wYARWHJ3ik0gqsQT8gCmLORkXjHLrVcYKdv3qZxKO805hYy2bGJA==
X-Received: by 2002:a05:6000:186f:: with SMTP id d15mr20756087wri.237.1615674130468;
        Sat, 13 Mar 2021 14:22:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u63sm7719685wmg.24.2021.03.13.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:10 -0800 (PST)
Message-Id: <960dcf365b350ef7166bd4f92d48ed016502f101.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:01 +0000
Subject: [PATCH 1/8] diffcore-rename: take advantage of "majority rules" to
 skip more renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In directory rename detection (when a directory is removed on one side
of history and the other side adds new files to that directory), we work
to find where the greatest number of files within that directory were
renamed to so that the new files can be moved with the majority of the
files.

Naively, we can just do this by detecting renames for *all* files within
the removed/renamed directory, looking at all the destination
directories where files within that directory were moved, and if there
is more than one such directory then taking the one with the greatest
number of files as the directory where the old directory was renamed to.

However, sometimes there are enough renames from exact rename detection
or basename-guided rename detection that we have enough information to
determine the majority winner already.  Add a function meant to compute
whether particular renames are still needed based on this majority rules
check.  The next several commits will then add the necessary
infrastructure to get the information we need to compute which
additional rename sources we can skip.

An important side note for future further optimization:

There is a possible improvement to this optimization that I have not yet
attempted and will not be included in this series of patches: we could
first check whether exact renames provide enough information for us to
determine directory renames, and avoid doing basename-guided rename
detection on some or all of the RELEVANT_LOCATION files within those
directories.  In effect, this variant would mean doing the
handle_early_known_dir_renames() both after exact rename detection and
again after basename-guided rename detection, though it would also mean
decrementing the number of "unknown" renames for each rename we found
from basename-guided rename detection.  Adding this additional check for
skippable renames right after exact rename detection might turn out to
be valuable, especially for partial clones where it might allow us to
download certain source files entirely.  However, this particular
optimization was actually the last one I did in original implementation
order, and by the time I implemented this idea, every testcase I had was
sufficiently fast that further optimization was unwarranted.  If future
testcases arise that tax rename detection more heavily (or perhaps
partial clones can benefit from avoiding loading more objects), it may
be worth implementing this more involved variant.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e8508541be14..a5d10afa221a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1073,6 +1073,24 @@ static void remove_unneeded_paths_from_src(int detecting_copies,
 	rename_src_nr = new_num_src;
 }
 
+static void handle_early_known_dir_renames(struct dir_rename_info *info,
+					   struct strset *relevant_sources,
+					   struct strset *dirs_removed)
+{
+	/*
+	 * Not yet implemented; directory renames are determined via an
+	 * aggregate of all renames under them and using a "majority wins"
+	 * rule.  The fact that "majority wins", though, means we don't need
+	 * all the renames under the given directory, we only need enough to
+	 * ensure we have a majority.
+	 *
+	 * For now, we don't have enough information to know if we have a
+	 * majority after exact renames and basename-guided rename detection,
+	 * so just return early without doing any extra filtering.
+	 */
+	return;
+}
+
 void diffcore_rename_extended(struct diff_options *options,
 			      struct strset *relevant_sources,
 			      struct strset *dirs_removed,
@@ -1208,9 +1226,16 @@ void diffcore_rename_extended(struct diff_options *options,
 		 * Cull sources, again:
 		 *   - remove ones involved in renames (found via basenames)
 		 *   - remove ones not found in relevant_sources
+		 * and
+		 *   - remove ones in relevant_sources which are needed only
+		 *     for directory renames IF no ancestory directory
+		 *     actually needs to know any more individual path
+		 *     renames under them
 		 */
 		trace2_region_enter("diff", "cull basename", options->repo);
 		remove_unneeded_paths_from_src(want_copies, relevant_sources);
+		handle_early_known_dir_renames(&info, relevant_sources,
+					       dirs_removed);
 		trace2_region_leave("diff", "cull basename", options->repo);
 	}
 
-- 
gitgitgadget

