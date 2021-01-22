Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7781DC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4383623AC0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbhAVSlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbhAVSRA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:17:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D399C06178B
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v184so5157111wma.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a0l+HITz6SzitgtYi+GV15d+1DsaJwoOm5MRDPNWvgg=;
        b=bG6+sBHOhvQNafPWorYM7WxJD3l+FFlbAK7IJycxiYpvh+14OH93jRsqtxBOT7vi8x
         5A4DZ/2QN1mxmO2cctjMxg/p9Fd81FWkZtgG+zfQ7FnNbXtWf+l0+AtMbHOeRO5TuMUS
         Bo6wnNAfNOt+4r51NYsDQ9ozmXmwt7nBrvx0/3KWICD7WVV1sow+NSWoSGPKdb3e58Zb
         B/kjUhLXBlNa6uZf1VDG6J6RsJ9yk6AKiiwrQM9cySsjswfJHq6xBEK6YbU1ev9YTnQJ
         kJ4/NQbaG3GcNJJtcLTzE2U8tlBEET855x9Sogeoj3saTyrphg5/b4ndyJ907w1K3jHe
         F8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a0l+HITz6SzitgtYi+GV15d+1DsaJwoOm5MRDPNWvgg=;
        b=FVtrWYRd7nSmVnbT1BuZm9UnUC386+qSeBs1UWCtO7tjf1r/v3Fj+dy5lAv56Gchr4
         5cE2AmGGCZgf+D4Z34WUnIA+CvCaafTjhHOfyTPYIuYAU6fj9HR2FL4KVPZFS/9Rpb3j
         Ara4rdmMA0jDnHXp89T447OkEbyMP2WY/fL/BQmV811xwE3i79+q1EJ/Hn6TZc+jMQOE
         l6L36zUfh42z74YNnUwVtDOhtNptvTwkoQHDnviXXJJeB3OgPVfjM628rJZ8RFz420bA
         oQQFNtxAA0eV4AgXHoW33s1uN/KQHU0gXcLPR3Kza2istT1Gf6GfZD+B1K+579oJnL0L
         AGhA==
X-Gm-Message-State: AOAM530tntvSvkS2YbDEJ7ofxeH2T8NePSbCvlx+cOKGwLv/0Ns80adi
        hWSvLEWnuBY40MmJFAARPuyp7V2Yvuc=
X-Google-Smtp-Source: ABdhPJy43Enj67kobA1nrZSS6rmTDgIh1eX6d/WUVFb2J0m0Q3oVW4aePRce+ahWysmJBn1K160cvw==
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr5088264wmq.126.1611339377016;
        Fri, 22 Jan 2021 10:16:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm5284826wmc.15.2021.01.22.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:16:16 -0800 (PST)
Message-Id: <4f5e5acd954d933df741b57f3877954d02199fe8.1611339373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 18:16:12 +0000
Subject: [PATCH v2 3/3] range-diff(docs): explain how to specify commit ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are three forms, depending whether the user specifies one, two or
three non-option arguments. We've never actually explained how this
works in the manual, so let's explain it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 9701c1e5fdd..76359baf26d 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -28,6 +28,19 @@ Finally, the list of matching commits is shown in the order of the
 second commit range, with unmatched commits being inserted just after
 all of their ancestors have been shown.
 
+There are three ways to specify the commit ranges:
+
+- `<range1> <range2>`: Either commit range can be of the form
+  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
+  in linkgit:gitrevisions[7] for more details.
+
+- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
+  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
+  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
+  merge base as obtained via `git merge-base <rev1> <rev2>`.
+
+- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
+  <base>..<rev2>`.
 
 OPTIONS
 -------
-- 
gitgitgadget
