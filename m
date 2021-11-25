Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87ECC433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353602AbhKYIoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353366AbhKYIme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:42:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE88C061763
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u18so9898723wrg.5
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OMvVoWV6a4igUhCPJwdvCNYU8tR72Q0wviYGWDVUkTg=;
        b=UiRd/uz1EjQdLQ/By0nqTpaT19/MexBx3y8XYcLL/wF4avhUi77B1LCiwuaz9JTQ31
         ww7KMPg+GPWZZYaTVD4nQIG3eRp2t2IX/LN79JnmR4FVdD8EwNAJZUwI0nfa0hLexo2u
         jKia48rVlIw2n00U24M7XdnUCWYGV9MkoUHjqbTXpug7HPMb0YRm9HUsUwXQqTRj2woD
         gCBZkYgjrhIVN9IL30YTt3+2GZhuebNyLc2suA72vdmJnYXRwwMZx8V86Tp9tR+9Odxv
         njTlMGzeWBVIRT92u9RAp7xqW1fU9mmynpkoj5GDS/dLcivHo9/IecthMNpNsX5LUMCv
         MRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OMvVoWV6a4igUhCPJwdvCNYU8tR72Q0wviYGWDVUkTg=;
        b=eG7PA14B2fMGy7IuxlStUkzu1iCnPPq98D6FTwslC8pWP151R1c6nPXwwbIIfEWfyG
         53xruHuMtzw0PvyKmOGkxO3mgttViIeph/qWJlWjTZJQAFRiglDtQRZIqEHsDt87da6P
         1LHWDEg193EKwhy90bSGAx/kiPBHFoZ4pZOtX8Q2YPL81aBm5ZJSEeD/XUkflE/E9z8o
         2FUagZZIkrlGABqlGs5ugN/ouZ9yhDV2gJ4jdLAnOfDnlNfRSgnKTFdCpDB9ucDpvZ4X
         EBSW9z2AZ64Qbvz4abLWRSJVLWmPFaHbtYFSJkD7/IqladNDp5jApTZSmVY7dYdIk0E6
         iZng==
X-Gm-Message-State: AOAM532di+g4mu/Kl90XhEN5mKbil4/xMyiM+JwPIQBL/6vAGpuo1Cd7
        MRiVktaQhVO9qR3cqj1vGVBVSv9Upt8=
X-Google-Smtp-Source: ABdhPJz4JdvhYSz3ZxrPlFnu/yMgB9noQD72NuzbQl6IECBGGvdgdF8HPOBM5spKHM/PIui77AwuxA==
X-Received: by 2002:adf:8bda:: with SMTP id w26mr4561841wra.440.1637829561518;
        Thu, 25 Nov 2021 00:39:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h204sm2423637wmh.33.2021.11.25.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:21 -0800 (PST)
Message-Id: <e06806e3a3266fa6fdc973fcd7b479bd395c3023.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:11 +0000
Subject: [PATCH v2 4/9] unpack-trees: add special cwd handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When running commands such as `git reset --hard` from a subdirectory, if
that subdirectory is in the way of adding needed files, bail with an
error message.

Note that this change looks kind of like it duplicates the new lines of
code from the previous commit in verify_clean_subdirectory().  However,
when we are preserving untracked files, we would rather any error
messages about untracked files being in the way take precedence over
error messages about a subdirectory that happens to be the_original_cwd
being in the way.  But in the UNPACK_RESET_OVERWRITE_UNTRACKED case,
there is no untracked checking to be done, so we simply add a special
case near the top of verify_absent_1.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh |  2 +-
 unpack-trees.c       | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 212676d71c3..526d8ec2ee3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -67,7 +67,7 @@ test_expect_failure 'reset --hard does not clean cwd incidentally' '
 	test_path_is_dir foo
 '
 
-test_expect_failure 'reset --hard fails if cwd needs to be removed' '
+test_expect_success 'reset --hard fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 6bc16f3a714..5852807d2fb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2261,10 +2261,19 @@ static int verify_absent_1(const struct cache_entry *ce,
 	int len;
 	struct stat st;
 
-	if (o->index_only || !o->update ||
-	    o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
+	if (o->index_only || !o->update)
 		return 0;
 
+	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED) {
+		/* Avoid nuking startup_info->original_cwd... */
+		if (startup_info->original_cwd &&
+		    !strcmp(startup_info->original_cwd, ce->name))
+			return add_rejected_path(o, ERROR_CWD_IN_THE_WAY,
+						 ce->name);
+		/* ...but nuke anything else. */
+		return 0;
+	}
+
 	len = check_leading_path(ce->name, ce_namelen(ce), 0);
 	if (!len)
 		return 0;
-- 
gitgitgadget

