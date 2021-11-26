Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B5C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhKZWsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbhKZWqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4EAC061746
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i12so9247586wmq.4
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6SBANfUyp1JQo3gTzcbbrfIaYvZYvbOS1RI9Jzyh1Uw=;
        b=G/MQ3UwFbjFvaiOow6xBempkGEvmTaSHO//HRyei+nFq+7PMOAy/6L5GfbZPeSIN4t
         uqb4jwu9C+nA84bdKNdtRZ6On79hXhxQAlrXdQZprgR0g4zi4le1LIIn1lhNgoLJwS1A
         g3smN4ZzCUKPP66+buLBZxulMens46uU0T1bgXJh2gE8HhmBMeZl0mY9rZeUbbSzeMuW
         bv1dbY5vwk/AvalroeFV7RG9jYddbA4fAPNPg2B6361t2ZJl9/ti08vrw7cT/oQlslNg
         ikC5oXH36WmWOoT+IdmXP8akp1e+k0JuulK1gE9S9V0pZX3oRUAI5t/RibZJF/tQ8+dK
         504g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6SBANfUyp1JQo3gTzcbbrfIaYvZYvbOS1RI9Jzyh1Uw=;
        b=5wA5jcS9IR8Sl55JoyNVpj7Y/Ty1WPaW9+DgSB7yy3RIMMm+3fZGXwc4BXSQkXKctC
         VD7o6dPe4py2l4+Yb0ceWci02grFPBr5SUpP7+yY83o6C0LPaUH0uO8h2A0fLYyU48A2
         yNvJK/T3G60jgdp0nFASbYSKa+/LngsFSuSaiaVl1CQ5pZkeCsKf6YYcPPBTlvVwQ7Jw
         ylnd6G0o2tVonV2YJszy+uFWg9UMLL9dQ0gjdSBOu8j+simHWvAeZHC2f5seQVifebRs
         ZwJCnV0JIajBdz1v1ubM3p3wLgHhdIh7oQzijlGB2revT1NLLWDnWowYaosmLmw/4iSg
         u/5g==
X-Gm-Message-State: AOAM532+2kVs2LsCERQ9GpGDWR5JXomfVBAbJKi5h+JFFggHGdLz4UK+
        tfbaKF/djKOkMZuIHCpGkG6RsKGW3z8=
X-Google-Smtp-Source: ABdhPJzGdGIXT5zW3hNx580aJ8sMHGGfVm+n3dOalQHv2br62kwCUmVu2TyiPz9hHbLRE/8nfcrBTA==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr19400355wmq.47.1637966467404;
        Fri, 26 Nov 2021 14:41:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm6514882wrd.84.2021.11.26.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:07 -0800 (PST)
Message-Id: <1bb8905900ca4170db4d9a9211d56d01b5013eda.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:55 +0000
Subject: [PATCH v3 04/11] unpack-trees: add special cwd handling
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
index 52399d1906f..886a391a63d 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -114,7 +114,7 @@ test_expect_success 'reset --hard does not clean cwd incidentally' '
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

