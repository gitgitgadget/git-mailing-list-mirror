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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2BC433E9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8A564E9C
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhBKIQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 03:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBKIQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 03:16:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105AC061788
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 00:15:55 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j11so4420985wmi.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 00:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0JDczPChfdRdhwca7LvDeEZ24EDYjAvYQgunfeHMrI0=;
        b=d3I06eaY2zrXe/F8gShiMjIvul6xJ0myoUxjmNR1NPDvWDTVh+2NhW7zlwsbdiTJiL
         B39CAgXZUStRxKzFHTuPhHRefLXh7hwZ8Vg3iOLWJCPoIdyEbumyTXIhvAeL+zBu3c7v
         5at/JIZUKG66b9qI1HsshImFwDZNKISh1EVtvIts3mL2k3TM+S1EUCKqOyKW1tP8JYC+
         Pc3bOz+FnmZvJNzjLocb6VRB/HYNNPmHTSOG75MYoUPbcXRvfntGC5q0Rcw89ITuIIDD
         T4ablHBd2NRRAW/hB7l9hzew8AuLUnDDbb6Z/EbxR3ER3lo5gvAGEuwGElvGOpMk5txt
         BhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0JDczPChfdRdhwca7LvDeEZ24EDYjAvYQgunfeHMrI0=;
        b=l/pefGBRYNPf8lhdn9pzc8t72z1eQTla+dnOkKqjPqiBjLox8/patEzZ7TRcb5w+aR
         6oUZD7M9/LQH29LgZo/3GD6e58CM3LqxCdqMNARqLPYHhxm0Cn7XbQZHc8AdQ3WROkko
         l/gR5d+MAZ5VazfuJvuMIRuMyyCXu4dqeeVT32z9toTjz+AmH3het0CXVWCbKrLqpGFq
         m4KzIbEV7LKjMZl1u3ni9JIqWsIAx4nRNwczw5I6U/FkxYKvKluvu1eRcoVwGDny2fwY
         vYSyL8jMXpqdAH2Lj8U/G4nYNQ5HuNlhff6fQB96XZMjjRRMZfzWvMFvh5uhl0AMDh0O
         ltOA==
X-Gm-Message-State: AOAM532LJ00Mhppc6zIZaMJjvdxPkShTh7iKP2C2f4pApY4XEaTMYGtK
        T/6tVxDEpzoFIpw/KDbJ2Z5O1Nh0sr4=
X-Google-Smtp-Source: ABdhPJyJxxOfG+SkjBQp3XzZIrvge+HJ10VVO2vcK/T8shqjlk+EFgDjCl69owteB9CvvuctFjEfzg==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr3821633wmm.170.1613031354550;
        Thu, 11 Feb 2021 00:15:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm8107607wmi.20.2021.02.11.00.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 00:15:54 -0800 (PST)
Message-Id: <4e86ed3f29d46add81d5a17046e2c6a574a2fff3.1613031350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
References: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Feb 2021 08:15:48 +0000
Subject: [PATCH v4 5/6] gitdiffcore doc: mention new preliminary step for
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
index c970d9fe438a..edf92d988c8f 100644
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
+preliminary pass; so if there are several ext.txt files throughout the
+directory hierarchy that were added and deleted, this preliminary step
+will be skipped for those files.
+
 Note.  When the "-C" option is used with `--find-copies-harder`
 option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
-- 
gitgitgadget

