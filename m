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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C4C4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8722E60F9C
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbhHCPfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbhHCPfh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A39C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b11so20448010wrx.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3VHVrtVKgyuxPzA588+WumvXXozyv386IvSD4PUP+M=;
        b=KYxZ5E+wGkFvsOmokslLg6wiECEHGOvJbUf2Do1OugXTGyyb8QyPWptoUpoXubbwFX
         THSRzjAfSM1jcMD7I9sp0b1tb0drHnZGDaWiGdFHUnsjGGTw9z7PGHxBYSO0ivJKb2Je
         XkziJ1VTTvCSfGASLkIFlGckW6nZuSHb/SZ90nAgoVX3xf+xSut8jqwBc13OVRAu0Lwp
         vN/VVZg2Q8WTBb1TFdEwy9rMwHcGqEyAeBKs2lVzX7J5o85UIxYBPs2cMRwlOIcCR48H
         MYQ8Nkw0ZldNMKG3e6Lt0xZL1vmOe+ZvjL2AJTyckVGAMj3wx8UWrP3DVoch+Z8mFc8X
         gSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3VHVrtVKgyuxPzA588+WumvXXozyv386IvSD4PUP+M=;
        b=b8xsyttorUCDWosFUbtOA4kb0RLMMXM/a/sNwcymN23vYhcZes70ujPnQhQDi7cgWX
         CErFxcMxPnxEVINxDeXWu7xH4FRf1tn3aSDzfg2UQYX4LHBRmfK8n03mgG70DN9IVPhZ
         b3OU2lW7qYlLyVcyY8zCXIptEVBitC9oQ0AwzsYuhqXw4C4x2YhfRyOorrAi/KcOgxIL
         1CZzWgAHWRZnvluICRgyONQ+hhlnIoR3CKnpqbsD7G+qtPZoakXBtfv7zMb2SomxtcMk
         X+zX3RL1mMZ9Pp9Qx+YZPjVPwd1rDBq99KaT5jOoTHdErfmsmaTrYJZgF4lO4Pf0mkkv
         1D1Q==
X-Gm-Message-State: AOAM531zBYWYhYENFE9Yf1rVwwEYmgK3obw7KSXuyu3QV9J2naFJ1Wr5
        Vml+hiy7LfM/DjRP6HOy40JyqcUjhIc=
X-Google-Smtp-Source: ABdhPJzdJtjHZGmJZV4Dc+IZ51IDwwWqTAXUwUHIy5M+aQRgij+h/jcOc9x0GF61pfPwMtMqXdKUgA==
X-Received: by 2002:adf:db85:: with SMTP id u5mr23820256wri.167.1628004923507;
        Tue, 03 Aug 2021 08:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm17528819wrr.27.2021.08.03.08.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:22 -0700 (PDT)
Message-Id: <ab2367594a3267a5f8d01cdfdcba576f286e3823.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:11 +0000
Subject: [PATCH 01/10] git-rebase.txt: correct antiquated claims about
 --rebase-merges
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

When --rebase-merges was first introduced, it only worked with the
`recursive` strategy.  Some time later, it gained support for merges
using the `octopus` strategy.  The limitation of only supporting these
two strategies was documented in 25cff9f109 ("rebase -i --rebase-merges:
add a section to the man page", 2018-04-25) and lifted in e145d99347
("rebase -r: support merge strategies other than `recursive`",
2019-07-31).  However, when the limitation was lifted, the documentation
was not updated.  Update it now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e2..8a67227846a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -1219,12 +1219,16 @@ successful merge so that the user can edit the message.
 If a `merge` command fails for any reason other than merge conflicts (i.e.
 when the merge operation did not even start), it is rescheduled immediately.
 
-At this time, the `merge` command will *always* use the `recursive`
-merge strategy for regular merges, and `octopus` for octopus merges,
-with no way to choose a different one. To work around
-this, an `exec` command can be used to call `git merge` explicitly,
-using the fact that the labels are worktree-local refs (the ref
-`refs/rewritten/onto` would correspond to the label `onto`, for example).
+By default, the `merge` command will use the `recursive` merge
+strategy for regular merges, and `octopus` for octopus merges.  One
+can specify a default strategy for all merges using the `--strategy`
+argument when invoking rebase, or can override specific merges in the
+interactive list of commands by using an `exec` command to call `git
+merge` explicitly with a `--strategy` argument.  Note that when
+calling `git merge` explicitly like this, you can make use of the fact
+that the labels are worktree-local refs (the ref `refs/rewritten/onto`
+would correspond to the label `onto`, for example) in order to refer
+to the branches you want to merge.
 
 Note: the first command (`label onto`) labels the revision onto which
 the commits are rebased; The name `onto` is just a convention, as a nod
-- 
gitgitgadget

