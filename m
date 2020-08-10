Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D48C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19FB2073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBWZFwtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHJW3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgHJW33 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782AC06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c80so921857wme.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R5WjzEx3d6LDRLe3qK/6OQvPeGsDYxYmhtGaQrPi7Ww=;
        b=IBWZFwtzS7Nj1P+x4INktG1vwoTSx6zyQGsH2LGdJ6fethfSJijgoxYUjw96X5G9+I
         5n1pESsT3XcZWv3C9mg66Scc1IdB6kcOy3D5CYc1KP+j4W/lmXhJH01JNO+g3+Ag9Syk
         gcoKj1N5CkO0lGCtYxCH1DZEPQDfnMAPTGXcimXR5Z+nhmZY39lOKeJtVdp/M0144Lu8
         e1Jmb9maqB5xZxVsmKbXPVTpEQqK6mQfAT4hXU8GBX3aYtffXlzsYasX4XKarVsdyqHC
         Wx4H42whSc0zjhxLuEMm98eKiwEInyent9V3o3IfWDwdo1QM6zIkalyeukCATYFx2j4N
         6m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R5WjzEx3d6LDRLe3qK/6OQvPeGsDYxYmhtGaQrPi7Ww=;
        b=AIogLz0gEHnaTDxsRmzeCpvS40tH9mOxrrt1HangbvPOFcnkUchLkBSV6C9cFwSO/X
         IrTGtH+GEbsoZ8S9gKRtNnAeCfiNYyAxHsqJNQXEC1G3CPZzQ9pUJD5I+A/8keq3884e
         Zy/kjrsdtlpegX3teeNOi4WQ9Oa9PtIWZ+OrbAlwhXmsBdAIF1QX15afHM2qW7UQAK5n
         IBx00WL5bZbaMCpP8PkhhtiQ8ycDO8z57rBo+YXPrjAIWEJKQreqIDah81fB6ZjHdEm/
         7lOCWE+43THQ4kmdCaQ9WJdrHvXKnuQ4YOGPkzSPV1Ss5Da/qT4FrUpCzd+ROKWwCRQV
         wTvw==
X-Gm-Message-State: AOAM531B4Z4d5GjTpbP+kPMT88R2KkP6PtVbFYPv5IlFIEtzByhn8JAF
        vKYhMNJM+iueY5fjbEVv+m0b46S7
X-Google-Smtp-Source: ABdhPJwbMoe6JtFy1IGw45NPL7X3NUXYAbO1hoDsNkQXgbdNKqi6AJo9oop/Sx4G9G8/ue3omxiE0Q==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr1183340wmh.89.1597098567006;
        Mon, 10 Aug 2020 15:29:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm22817884wrv.4.2020.08.10.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:26 -0700 (PDT)
Message-Id: <783ebb65768b2ca810bb11ae1845d1e1db346ff8.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:15 +0000
Subject: [PATCH v3 07/11] t6416, t6423: clarify some comments and fix some
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

