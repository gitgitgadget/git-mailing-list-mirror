Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52581C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhK2XNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A669C0800C9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so40046251wrd.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6VQRinRHMyNLuB+NCg8/1lm9bYRKE9ahUGPbuQ7FqqU=;
        b=O95A3kzOWjR7IytQuA+ratKvs7Uwi/1nIt74+qJ3Xrp6yJDxK1WFzTlY6H3Bqqf8XD
         wpmb5hOrNykP5ho8k5d5/Rbq9K2BzJ9aE+0I+FUXtfbcLKlepxQA16tr662G8kGimQ7j
         coiCOtdeuChN2GoVJhvoSBvDJFmIKHFcaVx/owLa5VSM8pD66esmQHn9PqNw9t5XX/w4
         1fnjWMlokRb5pgBPCeAduKY4NV0T1VYBwk0yoLdEJ6ZgY8+IX0tKp/1NSaJpbIgUwzaM
         Et0HC5tTuRKWJHKdku0lgUPpYfPugt+pERuWhMpvurKgyVByc7hgmQEdutyD/qde0H1s
         u9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6VQRinRHMyNLuB+NCg8/1lm9bYRKE9ahUGPbuQ7FqqU=;
        b=h0coROy30gAx5puZEI87vDl1wmIK8dVqgZkx1eeIgdEmebB6QNMb3qZTmXfQ23bby7
         c5PGzubn1GFI9+Ky8B7rhxZmDhwutVTQ7lLRaXh4w6JBeAc7dbWwGOl3oSIFnfwS2B/R
         NNKV0uYYVacpguGNN1pV/Tih8UZxzvGuu8ITpCyc7eiZ5B9lfQJjdqiEli43Q31V0XKo
         vdzHVD7Gp9pINVoscpiUaZl/PRQxDK56kykD5QXZS3NcHN+idNhp5LfMhmxcauKEVHaF
         TcHF60NTqc6DcI68XZAw6uWth9YXY+0y6aNctJG2ZcyJGG9DhHSbxhQsEXlMSyimUY8t
         ob1w==
X-Gm-Message-State: AOAM533OVKdjV7fkBJ775OKepi95rjT6dJAVV4WUy7YJUhPAORznWeyi
        0sm/m94l4VCiZRiVsJ4rFpukCHfEgDw=
X-Google-Smtp-Source: ABdhPJy2hs3DjpDiCsCI7EDQUAZNXNi8XpVVFAm7pbolv6n8SKbUFqp30G8H6yuPnm3L4OBUY6sRaA==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr37409202wri.308.1638225439023;
        Mon, 29 Nov 2021 14:37:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm14715857wrw.5.2021.11.29.14.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:18 -0800 (PST)
Message-Id: <2e2ea02f97b1093fcf89cb05e54e21fdb45273d0.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:07 +0000
Subject: [PATCH v4 04/11] unpack-trees: add special cwd handling
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
        Derrick Stolee <stolee@gmail.com>,
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
index 55081f5c980..10e4654042c 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -121,7 +121,7 @@ test_expect_success 'reset --hard does not clean cwd incidentally' '
 '
 
 test_expect_success 'reset --hard fails if cwd needs to be removed' '
-	test_required_dir_removal failure git reset --hard fd_conflict
+	test_required_dir_removal success git reset --hard fd_conflict
 '
 
 test_expect_success 'merge does not clean cwd incidentally' '
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

