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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793B7C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1F664E26
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhBNHxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhBNHw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:52:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34758C0617A9
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b3so4884370wrj.5
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U2IMjrPnI4/COLEABAFvc/ezEycB4y1Q32XRlo7ZRwQ=;
        b=RPA0W9JrkWh+67aIp1OwcCdIEOq2GJmwViRJ/rfwPY1MbsDGbKAK4xE/Q3inUsICoS
         /050zcxFJ51cIyDgBRSiUHlG7eEqHerks6ccBXXYD4x8QC0fT1vXqzNkD7mlfEnS4/fW
         AOFwIlFeaWfnog/pQaNKrPBn7e1j7wNlv1U4Jw0ylxIROXJZz6jr5XGcDxb41ScAtqFV
         aWRNactipRqhm5iUMelJAbIGB4SXXEYzkkhBW+bZlLV6du5d3NZiemQUPDdDjliyAN6v
         Pjyr34WaiR2TEsHZ2T3b7Sn+YHnqW1PmI9ZuDaMi+kZM18Rf677P3uoq2j+gz9XbuiCb
         ow3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U2IMjrPnI4/COLEABAFvc/ezEycB4y1Q32XRlo7ZRwQ=;
        b=Bw9UEGoZFoH7KQbwVp5R0UHUHKcpS33kvARKsgpeN/a8xZeHRaklND/ev1OXS3H9y1
         lyrj3Dj1YcIY2CeVZvpH+N/EITt6EEDMKHNT3xjamXkIGhJ4x+s24s/y57GfcJ7PNHvG
         vzax9sWfQ7LP2N51b49BdxUA/rk71XlQF0ljUxhphqt4+kmnN7i2Atg17e/Lq2gVHGZa
         2yj2V0ftWogAKXppWvahHN6Jr+Je/iuPUmy6cbLbiayJFxDMIwtoNZrGpRdbCZ7J3W0M
         WpRnBXKqk9XzrAijwfeXBmgxsg0zDeUhrRzEkMxwuLqu1MCa/gfdg1MoTIyVhtMfO5WD
         ER2A==
X-Gm-Message-State: AOAM531I9rN19Kshd4dv01VwRG5uh4Xcldp+oS4OMnA6d4fCGdsuegHw
        r8oFUBRbWpntmc/Gs36P9ve+ibPD0hs=
X-Google-Smtp-Source: ABdhPJyI62/t11Jd7nI0tzdQiotx9LB037gkQ42naTRzruJLfZTVXaYPvj4DUYcdHJsDmfQ3OCiqSg==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr12521553wrv.132.1613289115994;
        Sat, 13 Feb 2021 23:51:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm14321144wrw.46.2021.02.13.23.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:51:55 -0800 (PST)
Message-Id: <6f5584f613500bd41fb40988dbe014939c0ea814.1613289112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
References: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
        <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:51:50 +0000
Subject: [PATCH v5 5/6] gitdiffcore doc: mention new preliminary step for
 rename detection
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

The last few patches have introduced a new preliminary step when rename
detection is on but both break detection and copy detection are off.
Document this new step.  While we're at it, add a testcase that checks
the new behavior as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/gitdiffcore.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c970d9fe438a..80fcf9542441 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -168,6 +168,26 @@ a similarity score different from the default of 50% by giving a
 number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
 8/10 = 80%).
 
+Note that when rename detection is on but both copy and break
+detection are off, rename detection adds a preliminary step that first
+checks if files are moved across directories while keeping their
+filename the same.  If there is a file added to a directory whose
+contents is sufficiently similar to a file with the same name that got
+deleted from a different directory, it will mark them as renames and
+exclude them from the later quadratic step (the one that pairwise
+compares all unmatched files to find the "best" matches, determined by
+the highest content similarity).  So, for example, if a deleted
+docs/ext.txt and an added docs/config/ext.txt are similar enough, they
+will be marked as a rename and prevent an added docs/ext.md that may
+be even more similar to the deleted docs/ext.txt from being considered
+as the rename destination in the later step.  For this reason, the
+preliminary "match same filename" step uses a bit higher threshold to
+mark a file pair as a rename and stop considering other candidates for
+better matches.  At most, one comparison is done per file in this
+preliminary pass; so if there are several remaining ext.txt files
+throughout the directory hierarchy after exact rename detection, this
+preliminary step will be skipped for those files.
+
 Note.  When the "-C" option is used with `--find-copies-harder`
 option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
-- 
gitgitgadget

