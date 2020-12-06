Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F8C1B0D9
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABB622D2A
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgLFEK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFEKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:10:55 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256BC0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 20:10:14 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id f190so10533022wme.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n+lCYr38cjGZeNek8Jedf/mHe2Rr+VXfsvOu5CzjCuk=;
        b=P+lsdoBA/DwVfC8+kTOoJhlk8x0Os1+1xlfeFu/V8BioB024kR3S7s41f0WUbPDTFd
         Xm8iDPXwNPUvnIeTPWxyQ+Y3alAmmP+v6PUtYaf7+c6/FjU7BpnuiZ6qPsJkU1zQb1b2
         g9+fO+yNRSG3/X4sf5o2W7mCh1KO+S4mzFk9Ey+UGUqynxdupnn5lBZ3pF45Iajn0xYw
         JOOc6nC8M+N/yXnBCrFNLMhoiDEYvDulUzzc6PsQGKteY2txiGeKvYE0FfohJtgMJTeF
         nQ69F4QLiw/V3Rj+m/jZgEVImLAQs7zfEh3+cYNA6mCICOlCLxJ4fs2Vo/V0MgbtEOZ8
         JdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n+lCYr38cjGZeNek8Jedf/mHe2Rr+VXfsvOu5CzjCuk=;
        b=F9Othrs1QR6b00mvRkSgoAwEYdqXT2ximtdm6Gb/ZZbGET1rDKvy29uTrxzpiy74za
         aeyYZHRi/XIb92FbOW5U3aVjVa6ZiM1Jgp1WMoEV4xSWEQ7cGJcx+zs+eqOUHAwN9Ueh
         hoHLTWkZfmJBY6fQJpmwJD5fxZonul1AO/xiiJJyn6+yngKUFLc3caDuafXQPql05xot
         yIIkOzXW3DV9G+xireflPC25hXYIYhXNqHW0l2bo+1Y322ThNA/zVJXleYUlGDNTm/hd
         qyVUGGLsJUws7sGufB9BA8aTBNj5+nRMTMyecMjQWrpuIXpPML73exCKsURocOXCEqVm
         SuKQ==
X-Gm-Message-State: AOAM532EbJGtWke2T2zvQmKX2EPuum4VlZyQuVQmllDNJSxEaVKiqVZe
        npKOcoeaKPRyBgCytWGIaUVDJXusR1Q=
X-Google-Smtp-Source: ABdhPJzwnnTaNeDuV9l1lYrSYMKHQE2VmFP61mAXUEulIrVsPFDvsHhS5BoUYxoN4ucVxXxskIZBNA==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr11502723wmd.20.1607223283229;
        Sat, 05 Dec 2020 18:54:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 90sm9442804wrl.60.2020.12.05.18.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 18:54:42 -0800 (PST)
Message-Id: <e8257516c1f983d590b8a81fb32ecd5cb91dc737.1607223276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 02:54:34 +0000
Subject: [PATCH 5/7] diffcore-rename: reduce jumpiness in progress counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
index 7270eb6af48..3d637ba4645 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -587,7 +587,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
+				(uint64_t)num_targets * (uint64_t)rename_src_nr);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_targets), sizeof(*mx));
@@ -626,7 +626,8 @@ void diffcore_rename(struct diff_options *options)
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

