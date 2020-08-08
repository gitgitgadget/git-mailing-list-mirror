Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00430C433E1
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A96206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QffX0iUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgHHRBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgHHRBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272CC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q76so4583989wme.4
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R5WjzEx3d6LDRLe3qK/6OQvPeGsDYxYmhtGaQrPi7Ww=;
        b=QffX0iUbSPIVNbYGVbpuUw5GRbA9NziK99r7gecWHiS8sniFDbURyEI9geIYMCZpx3
         DOA4fztvd+qaliHLNrxiguLVTpi5mSm/RQlc7sJP4iXizG2l5bSToW2mP1HNJrK9D/Nz
         51FtCrBxhocb2luFoiey8bGILKlDEuXoNBEmmgPrG3kiRVnk3QYAeGw+6FjKppkUC4Hk
         LooemMYXL23fFREQDAV9EVJPyD0V9W/eyRowFgpG/HcznJ+PIEF4RFN6TA2YoZs3RN/o
         oUX6061IQCXZykX84ycsb2byWedroT6jQjj51IFykcT1Mee+JES8ubS9r1H5Ci8lQtTV
         KCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R5WjzEx3d6LDRLe3qK/6OQvPeGsDYxYmhtGaQrPi7Ww=;
        b=kw0mQrmjyYkhrrn1tMIQRxVf1x0S7pYr6VIc2YXEWq28DHP5Lx2xYYKJ9dNiN/69GB
         8lxNMEtN2eJP/6sADuWtl5PoqYEEVHmk2CykvCXNXB8xsH2T/51Aznae4ps3xSF1oPGM
         rUdzZ6TKFRma+qeEhQ7A4IE9azHTVx0wlIVyxJMw2kUaiHnZSpn43mBXse8fngkmHW8Z
         wnTrTck3PzHI9RsFZREWdeOmyIB4kgIkrd1CyCf5e/dYo9fJfRxJPDvoAbE8hNwDKZrK
         fWXu4ICNJNy/l+w/B6FZJwzXbm3IQlImqUYrQ8JvvLS5usUcuEcnpZAcNpNu3JtixnEp
         tObg==
X-Gm-Message-State: AOAM5307/mwzUbnd8W62StK3W7MUiWDQWgaPRh/4/pjaJbTSuN/nQhmu
        C0WctEhfqkMUGO/o24XmCAUnL3ro
X-Google-Smtp-Source: ABdhPJx+juckofQhLhkrf2karyjnWWT5ZvLtG06W61Xbc0SUYGRu1DJ/YpAFmst9QqCi5HdT4FhfFg==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr17520543wma.176.1596906088890;
        Sat, 08 Aug 2020 10:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm15125840wrs.36.2020.08.08.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:28 -0700 (PDT)
Message-Id: <7b534d123ad77dd4905c0fc9cd5f583f3eb647a7.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:16 +0000
Subject: [PATCH v2 07/11] t6416, t6423: clarify some comments and fix some
 typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6416-recursive-corner-cases.sh   |  2 +-
 t/t6423-merge-rename-directories.sh | 25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index d272b418e4..fd98989b14 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -452,7 +452,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 #
 # So choice 5 at least provides some kind of conflict for the original case,
 # and can merge cleanly as expected with D1 and E3.  It also made things just
-# slightly funny for merging D1 and e$, where E4 is defined as:
+# slightly funny for merging D1 and E4, where E4 is defined as:
 #   Commit E4: Merge B & C, modifying 'a' and renaming to 'a2', and deleting 'a/'
 # in this case, we'll get a rename/rename(1to2) conflict because a~$UNIQUE
 # gets renamed to 'a' in D1 and to 'a2' in E4.  But that's better than having
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index d227e15944..bd0f17a3be 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -2260,24 +2260,23 @@ test_expect_success '8d: rename/delete...or not?' '
 #   Commit B: w/{b,c}, z/d
 #
 # Possible Resolutions:
-#   w/o dir-rename detection: z/d, CONFLICT(z/b -> y/b vs. w/b),
-#                                  CONFLICT(z/c -> y/c vs. w/c)
-#   Currently expected:       y/d, CONFLICT(z/b -> y/b vs. w/b),
-#                                  CONFLICT(z/c -> y/c vs. w/c)
-#   Optimal:                  ??
+#   if z not considered renamed: z/d, CONFLICT(z/b -> y/b vs. w/b),
+#                                     CONFLICT(z/c -> y/c vs. w/c)
+#   if z->y rename considered:   y/d, CONFLICT(z/b -> y/b vs. w/b),
+#                                     CONFLICT(z/c -> y/c vs. w/c)
+#   Optimal:                     ??
 #
 # Notes: In commit A, directory z got renamed to y.  In commit B, directory z
 #        did NOT get renamed; the directory is still present; instead it is
 #        considered to have just renamed a subset of paths in directory z
-#        elsewhere.  Therefore, the directory rename done in commit A to z/
-#        applies to z/d and maps it to y/d.
+#        elsewhere.  However, this is much like testcase 6b (where commit B
+#        moves all the original paths out of z/ but opted to keep d
+#        within z/).  This makes it hard to judge where d should end up.
 #
 #        It's possible that users would get confused about this, but what
-#        should we do instead?  Silently leaving at z/d seems just as bad or
-#        maybe even worse.  Perhaps we could print a big warning about z/d
-#        and how we're moving to y/d in this case, but when I started thinking
-#        about the ramifications of doing that, I didn't know how to rule out
-#        that opening other weird edge and corner cases so I just punted.
+#        should we do instead?  It's not at all clear to me whether z/d or
+#        y/d or something else is a better resolution here, and other cases
+#        start getting really tricky, so I just picked one.
 
 test_setup_8e () {
 	test_create_repo 8e &&
@@ -4405,7 +4404,7 @@ test_expect_success '13b(info): messages for transitive rename with conflicted c
 #   Commit O: z/{b,c},   x/{d,e}
 #   Commit A: y/{b,c,d}, x/e
 #   Commit B: z/{b,c,d}, x/e
-#   Expected: y/{b,c,d}, with info or conflict messages for d (
+#   Expected: y/{b,c,d}, x/e, with info or conflict messages for d
 #             A: renamed x/d -> z/d; B: renamed z/ -> y/ AND renamed x/d to y/d
 #             One could argue A had partial knowledge of what was done with
 #             d and B had full knowledge, but that's a slippery slope as
-- 
gitgitgadget

