Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC36C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346969AbhLAGo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346970AbhLAGoV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E1C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so49801994wrb.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xulIetn/yOgeVVFvM5+8KPmrE1EPa4M3Twe3tOhvDgo=;
        b=pPgDG3COHSLPE0bdInWN82uEqIlVrghbNcha1M83M+ugv6sELDgVMeu7wm/TDXs/dH
         HAr7fZgWkqP1GSeQdVD02rxuqyStxT6tY+QwXeHWhdLaBbrl9JkCqWsL3cK2HmM3UPr1
         NsKDMldALmmoq9mVmxkBhIBlIR/bsc3jqzmg/2T2bLtpNRl8hvS8tm5OwaWvgwLp6rDe
         qiUScrIh1Lcx9VXmtJoLoc3yqH2ugaHp6U/SKWMd+HBwrMiSp0Wkfo2fUEyGSOYQNnMy
         w7lk6lgkoN8NP21EyRfIM9DwSMhGQhpBTTBoGo+YBvdUegw6jB9IKC4MP+RJ11gTkBzB
         u+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xulIetn/yOgeVVFvM5+8KPmrE1EPa4M3Twe3tOhvDgo=;
        b=20nrKWT075h4VSQ6rZnkGcY4smmK+TPva9yqnZ+xMvfyxWObbcDEAvZz4G9g0E1GJx
         3qSpNJxDMV43FdbRZyLZByGfY8If7AlG/vVPpgndFeihn/ZVFAkv7dCJMcg0uqx0kY5B
         0L9CpW9iknkBNVhAYKZyHiS8VJnciDY4KmlsaOSRScTZX2r/fGDZd6xj0mkWwmhJzo7a
         f5aTS5d5MhB/eN0W5uudU69BwJtknNWpUCSq0TqLCCMMQ4oBFrihxIEEBEYDo4TdYHVn
         qPZqXEp+GvVxvp1q/uHgHzjYh+ON5ggzWkhLSVXZdrwyBOVeQOZNft5JcyLEM83XKBJC
         bkbA==
X-Gm-Message-State: AOAM533Pn05W2Q328vFxq6/pYI328QZOtWWI5uyzUuDzB2oSWNcenzVu
        jIId9H0mi2pMYX7g40foq61/3bLTEJw=
X-Google-Smtp-Source: ABdhPJzVjbsRXqecYAd7N3h1JIVRUtiynRTF5P4qCqU7cDOKYEvRBka5SJbfEY6nM973qMuJSwSi0Q==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr4319852wrw.401.1638340859624;
        Tue, 30 Nov 2021 22:40:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm7789wmj.18.2021.11.30.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:40:59 -0800 (PST)
Message-Id: <706415a454722fdb4e002104d5929c82d9c6eedb.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:47 +0000
Subject: [PATCH v5 04/11] unpack-trees: add special cwd handling
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
index 398908dfc93..5af1fec6fec 100755
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

