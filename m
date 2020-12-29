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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD0C4332D
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422BF21D1B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgL2UGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL2UGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02813C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so15572632wrb.12
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WELx0XYYnbrJkWi3WvWrkOd+L7awiwNOh9Yvmq0axuw=;
        b=LskyPAUxz8Go86btY6u9ImTO5CBhPWWlp2WUjhHrnJ3esFFeO2llPBC+adJtfGiQNG
         MF18R8R2tYN/vgXWgIUE71SwYGyZywIW1oZaUvjZ2Sywhe+P9MOyAVQao7RWpYnYrgUG
         TU8zQ5Q2Cim5jWANHAgyMN+OsIDYCq0MkYczAYPLP62fvxB8EdWUckDpouzVi0IE29/x
         QVq/4MtkfBCXoIf5HVVLEEiMuIgyeu6UYyqEnTivZnALN1gPuCgX6u4iqlRmyzGn2hXj
         glT6oxKQF5+DBFmJUTYmE6Z9rD4HGHPN6lLiip9IBLfZ4gwhkMIBFK9FVhPPZqb+9139
         zd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WELx0XYYnbrJkWi3WvWrkOd+L7awiwNOh9Yvmq0axuw=;
        b=YpiDGKFB9hlBg888nV6R5TOyd2T0adez8mwYx3oHx2nWIuk7Nq5m41oXfNnyyBg8jD
         w4f9thSkH3eE3A0PD9PTOawWKRLNAEGP58l0Wav7CvMntRWRaD52+IgHJkg+4rzrXUHK
         SIFZx57tAbfpflxxmycN8PT0v2zYYMdVg8n+22b7WejM5mYPtU8bj3WX0k5SsAx+Ke1u
         VmwNoDQShEHzRlKGdSYnRye6hZTXrFuy22Z1Qim3l7i6KLoxwtjtkaL7JhuLUCKnoJQK
         1UcUYwW618PMqgwfIRP/FLbguD+ZQME9jas3igdrVHNhRx9XFlmN7ni6EGX82YsKIppF
         3Dfw==
X-Gm-Message-State: AOAM532XpIqsOaBEKMx/ynOVimD+c1txR4wgB658SKu7KS5+N2/zCzjz
        4FuXZXDEJB2NZytLx6xjNsKfChNiGcY=
X-Google-Smtp-Source: ABdhPJxO/nN5CyZgMjel1+i03WZYblbIyAdPt8aUR3gLs+UvyhfA4HIDYeKX0mYq1wYmxKWpuAfAYA==
X-Received: by 2002:adf:8342:: with SMTP id 60mr57863201wrd.140.1609272333603;
        Tue, 29 Dec 2020 12:05:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm4406604wml.34.2020.12.29.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:33 -0800 (PST)
Message-Id: <bf3581b1ac12bd616518f8093365d38eee4f01b7.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:23 +0000
Subject: [PATCH v3 4/9] diffcore-rename: reduce jumpiness in progress counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Inexact rename detection works by comparing all sources to all
destinations, computing similarities, and then finding the best matches
among those that are sufficiently similar.

However, it is preceded by exact rename detection that works by
checking if there are files with identical hashes.  If exact renames are
found, we can exclude some files from inexact rename detection.

The inexact rename detection loops over the full set of files, but
immediately skips those for which rename_dst[i].is_rename is true and
thus doesn't compare any sources to that destination.  As such, these
paths shouldn't be included in the progress counter.

For the eagle eyed, this change hints at an actual optimization -- the
first one I presented at Git Merge 2020.  I'll be submitting that
optimization later, once the basic merge-ort algorithm has merged.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 16553ab259f..55a188abcc3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -593,7 +593,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
+				(uint64_t)num_destinations * (uint64_t)rename_src_nr);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
@@ -633,7 +633,8 @@ void diffcore_rename(struct diff_options *options)
 			diff_free_filespec_blob(two);
 		}
 		dst_cnt++;
-		display_progress(progress, (uint64_t)(i+1)*(uint64_t)rename_src_nr);
+		display_progress(progress,
+				 (uint64_t)dst_cnt * (uint64_t)rename_src_nr);
 	}
 	stop_progress(&progress);
 
-- 
gitgitgadget

