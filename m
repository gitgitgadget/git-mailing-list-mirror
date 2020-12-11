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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1677C2BBCD
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AD123F5B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437417AbgLKJKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437381AbgLKJJg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:09:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C504C061794
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:55 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m5so8218585wrx.9
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WELx0XYYnbrJkWi3WvWrkOd+L7awiwNOh9Yvmq0axuw=;
        b=Q7GLG8iYCYd7+YxmmVCGhUgApafhNDXAC/M2sg6skfNj03HbYeJbv2E7wkQNblIxPS
         AAY0YbX/wPxp5NtANwP0SybkeqtB2vMUAhGNWWcQoIyaZAAQBHFjI0WBQ7JMa/ySvUoh
         ++cpYrKJLKtXCtea7QIn1rkTLxuUOTOesrt2uRk9Km/fjaXlyGWY4StB+1ZLeyP+i3yj
         UqWrvOO9Dy39ooXKfI4ulvDCAxDzvdP3ActgcafjbODjzIqxoTw+aijVxsAnF4YrGaBz
         Aygcuj/EPAnX0BUg47mkms4ypv3pkLYkrZkYZPWRpt+cygsi7Db6I/eFQRt2nBjjnA0g
         E+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WELx0XYYnbrJkWi3WvWrkOd+L7awiwNOh9Yvmq0axuw=;
        b=Xqf9x46Pg4zgwNYf+/ZiZLiyTreErh9eRrCZXej//B1vIDsyV5WZrHF+s9kOjnkvy5
         dCM2vY7/dLO1U4yWK46ZrPaE8lmnWk5v10tm5QtwDV3Q2vgVuCzwmNZC6GMiEqqtIJcb
         ELsfCDHy7E2Xx1jnuuJtuFpls4gXeHB+chrayAwsWqg/4OEPDXRZFfdJWr3f8UlCs4aE
         VUgS98WTVck93E2++Ma9uccWCQELqYFXSWQIyjMs2kUszAOnAAl6ZUWpuVSL2xhKTVC4
         JxqE0HOrIosKlFOB4+8h7gRmNIY2wgPzilBAij97jTSvFkFczF5JEFoWszP6Pdk5zVD9
         v1Kg==
X-Gm-Message-State: AOAM5331wivkF/b3JpuLeotb8yivojdodTz/x2KeGPBc/3S5qS+qgULE
        BAumE3ykdR/MsKh2/EE31uII2kLzxhk=
X-Google-Smtp-Source: ABdhPJzkpDXm3sVuMoPnrL4YqUTh+lP6kbY+RdRIq4vERGtpF0Qy3EbVcDQJlQOXtLsnjlxdBQLw6Q==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr9498036wrp.401.1607677733913;
        Fri, 11 Dec 2020 01:08:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm10404164wrx.86.2020.12.11.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:53 -0800 (PST)
Message-Id: <bf3581b1ac12bd616518f8093365d38eee4f01b7.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:43 +0000
Subject: [PATCH v2 4/9] diffcore-rename: reduce jumpiness in progress counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
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

