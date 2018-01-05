Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99A71F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeAEU3G (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:06 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43374 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbeAEU3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:29:00 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so2885887ita.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fp+ZfWC/CREhHP8m4bMs0P/+PUku9R8IDYxXqIGx0Kw=;
        b=Sx6HOif9R01HYkupQ99F0tqWfXLqdJxhbyIAGGS2r7+t3sxtBJV83/hnWyWbUPv4+n
         Ix+HE5kFeXvfSvSHcF49gPp2/Bo2LJ/YSVtMPtCvq3CNHGxYNeF1Uo/0cqfjdDA8rzBd
         Of/qWuQZJPGbcaxktdXXn5AC9E0mKGSZfF9FLWxLQHVTetaLVdUVTXjf7UqXHlvDcW6H
         Htnw/ZgDRt0uRIm08KGhu6pajiQgmAOY6CEY6hs2bMubUa1zsTGiNbHcM0tQSVngwABn
         ygjEV2CNAEtOjrVnribytQh27ahoaqz2unerEuA4J0i7KfObE6ZMO8m93aOY8ycX5jXK
         aJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fp+ZfWC/CREhHP8m4bMs0P/+PUku9R8IDYxXqIGx0Kw=;
        b=pk7ofjro6ESQl5rn9fSxXP9q/2vpRF622R1XaVc29pYIATGocAWFIOrmuedmaroneH
         yipuiGd7CLb6XfBJZtovKg9Fhf9jPfQr0i1mu3hruIG+d7YgrVeFS5uZuzSh1JvfQH/h
         WuUd1A2GI7oBJx6nVMHjpGmiN2/yKQa3ng26zkQhb7fpLCT4bLsxHVrtcLiHxYSm3/ry
         axatDn0TabXyMY/66Nc7sMCeGKm4Wub7MHTiDm58mCizK73zAdiPvoHg/avDfiCbBck2
         6ZaOSYZwhe2PWNVdmSGKVJ5j3R/PFfG7aVO7Vr/dYyz5N96QYl7W0wnvcX+PITl7IDtf
         41qw==
X-Gm-Message-State: AKGB3mLd+6pw/idcO9BkNRpd5qY1jVkrGaDdVOsS05SSvMNBVZR3BeKM
        oE2ru+3ZrIdiOwZeAFP48v99P5sw
X-Google-Smtp-Source: ACJfBosuhNKKGcfB21AkY//9G2oy/0Xx6uuBAhxbDG5l/yUs6eLS9zZjcUUg2Dgr5FQlnzJHPvK1Jw==
X-Received: by 10.36.79.201 with SMTP id c192mr4198108itb.7.1515184139924;
        Fri, 05 Jan 2018 12:28:59 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 31/31] merge-recursive: ensure we write updates for directory-renamed file
Date:   Fri,  5 Jan 2018 12:27:11 -0800
Message-Id: <20180105202711.24311-32-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a file is present in HEAD before the merge and the other side of the
merge does not modify that file, we try to avoid re-writing the file and
making it stat-dirty.  However, when a file is present in HEAD before the
merge and was in a directory that was renamed by the other side of the
merge, we have to move the file to a new location and re-write it.
Update the code that checks whether we can skip the update to also work in
the presence of directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 4 +---
 t/t6043-merge-rename-directories.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d00786f71..16c52a434 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2732,7 +2732,6 @@ static int merge_content(struct merge_options *o,
 
 	if (mfi.clean && !df_conflict_remains &&
 	    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
-		int path_renamed_outside_HEAD;
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
 		 * The content merge resulted in the same file contents we
@@ -2740,8 +2739,7 @@ static int merge_content(struct merge_options *o,
 		 * are recorded at the correct path (which may not be true
 		 * if the merge involves a rename).
 		 */
-		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
-		if (!path_renamed_outside_HEAD) {
+		if (was_tracked(path)) {
 			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 99dca4ff0..b36551662 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3854,7 +3854,7 @@ test_expect_success '12b-setup: Moving one directory hierarchy into another' '
 	)
 '
 
-test_expect_failure '12b-check: Moving one directory hierarchy into another' '
+test_expect_success '12b-check: Moving one directory hierarchy into another' '
 	(
 		cd 12b &&
 
-- 
2.14.2

