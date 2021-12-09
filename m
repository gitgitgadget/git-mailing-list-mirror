Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F9C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhLIFMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhLIFMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A252CC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q3so7673922wru.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3TpFKVLE9+RrEixN+FYqrRqoEu7PQPDUlR90rpjFzp4=;
        b=LKFB7+PY3HRtyMTt8xGwsXNL2lCMhfnwG5kL51IjvBHC91WEur0fBRTUCV9tZVAKNv
         9kImY8qfCab/q0nted238EUqjkH0AhQqkgd7qX2u3WuXnp02P3tAEBZuA9eie3sN3VIw
         eMNr/P+s/DfG5d4vqbfXautoAFBAUVsIzbFIhXQUm49wB34fPh3YwAkcfALAfVjXOZuh
         fYbRug0LjJwEFLC/xKLV6jXb8FK7U0fGXghOnrEIcVLZCqnyKuZlyY1s/YBvc8iij147
         As5oA+gPKGbTB4Nep5WuB8ClvGtGFXo0jx/QS+q3CpEe0pA0fI4+n0hrpfQgD4rN3nh+
         tKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3TpFKVLE9+RrEixN+FYqrRqoEu7PQPDUlR90rpjFzp4=;
        b=UDOrDm5G51ZS9SAGtg9/kDv88zz4oXiO61irGIB7HyQxHksRp7TJ0344StpL516ape
         elfuTYcd83+KOGiff2H99DWoqQ3qXbQku90jTArqsKGHnQAlXJz2RLFJThkmIrwiFuuo
         EF3rvRYEOqutbhG812nl8+3uGpVejAGkalokgLE0cRVsd5hfwZrcOA74hxdoNuM4G0aA
         geBnwddAnb4JGthiK+aXEm1ZOJUu2c8cTDUnDVUIQGa9BZ+Ne1xibA3+dlWH+EKcsnbf
         8yH5lnJ7obngvXrJ0Gd4KRvSoyXGe3CcpPdC1Keynid8UXyjkdOez+gGfcLBaojpnjRM
         u4yw==
X-Gm-Message-State: AOAM531c0xZd6r/dbieRsu/Nm66PR35N3xdwSOPvKnOx7tiqXW0Dh+LL
        FB0f80JbPIZMOtqtrbJyT0c21x6DnsI=
X-Google-Smtp-Source: ABdhPJyXPerkMQuocqDAduB8nt5uDetGzkYmXB/HaDLIb34J84DwwK08+t+lR1KWaA60yClMe6XcJg==
X-Received: by 2002:adf:fe8e:: with SMTP id l14mr3848371wrr.177.1639026521116;
        Wed, 08 Dec 2021 21:08:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm6014992wri.89.2021.12.08.21.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:40 -0800 (PST)
Message-Id: <03f2b0b8fb77c1003da5d4f40bdc467c311e0dce.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:28 +0000
Subject: [PATCH v6 04/11] unpack-trees: add special cwd handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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

