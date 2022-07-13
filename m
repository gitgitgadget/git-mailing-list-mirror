Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C69C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 08:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiGMIVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiGMIUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7B859272
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so14382343wrq.7
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sk4fOcF43JH5hbwWjOJFUbnsEOZEDC2elmRIa706Tbg=;
        b=CBMs2OAhaL6IcOVPXfqvxIu+x/itLV1RzhZhmyh/ioyOTZ4gUvVck2cEhYebIDz1jH
         ve1GoC/2yzpKMNTKYSdOexg0uZojzwjBhFt6bXwJbWXF/0wMimJETpBlUQCVXjUddG0l
         1+llu5BE4/jWHUnOXuPe2AAzhYTj4Slma2+DOiLi2Ye3z2itM6+i4NKUy6feDExdFu8h
         2KdeqjmNOBwmd/v3Q6uixgaMt2OUL2tfSoRzUKp/sbqv+Qxd0OxT0AvshXVOwbijJHT6
         RyMDxbiZlsVygBMJC79gmklVUuon2rEyReEkKQgGF15CSaHlFi6Za2uQaCSLIMxytRZR
         pLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sk4fOcF43JH5hbwWjOJFUbnsEOZEDC2elmRIa706Tbg=;
        b=LRlb2VeLoJEC+Tl6CJz/Tw+mF7ze/84tAtIaA5vnsVJQyNznmbOgJG55Ol1wdRHHHi
         lTdcDAvrMlW/QemlJG2b9u5Hjk/YGGb31Ki67KvWoszYPSNNRw3SAE8KN3cGcGgR5u2x
         3sHQrontsEleLtxuLJ1YuCQXTeEKkHQRvrggqSSteNx3aNIW+8q3/ihx2B3TbOH6pPvd
         d44TM/Syrm6Zzj5LzGeWGTvYcD5lTtFh+GzyBHy1Z0GSTC4FjVo/kkku6wDSJaW0qYR1
         vOewXrrWCgmSgSt4UNq+JWuYwVlfpY4fOgJ4Huy4W3jV3flf97o5/GAKhzzTaNBqBtnQ
         CMRw==
X-Gm-Message-State: AJIora9GfSn1eLwj8uW4g2GAreLhI8Z+WFI3sIMRG6niHVric0qYf+pg
        PsJu7Tjr/VRkZ3RKpJWP55ImZVnkUDA=
X-Google-Smtp-Source: AGRyM1tTAFmbQ/kv/ykRH2+oCX8VwRZMKMWzULXuEl+zv0wsV2HPDH46J7qxv8oZsSGXXcNMC0+lqA==
X-Received: by 2002:a5d:5608:0:b0:21d:6be8:4944 with SMTP id l8-20020a5d5608000000b0021d6be84944mr1987656wrv.613.1657700241850;
        Wed, 13 Jul 2022 01:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d4f0f000000b0021d8faf57d5sm10192028wru.74.2022.07.13.01.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:17:21 -0700 (PDT)
Message-Id: <be06d711a1349a886cad63f8f2ec6675e6d5055e.1657700238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 08:17:16 +0000
Subject: [PATCH 2/3] mingw: handle a file owned by the Administrators group
 correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When an Administrator creates a file or directory, the created
file/directory is owned not by the Administrator SID, but by the
_Administrators Group_ SID. The reason is that users with administrator
privileges usually run in unprivileged ("non-elevated") mode, and their
user SID does not change when running in elevated mode.

This is is relevant e.g. when running a GitHub workflow on a build
agent, which runs in elevated mode: cloning a Git repository in a script
step will cause the worktree to be owned by the Administrators Group
SID, for example.

Let's handle this case as following: if the current user is an
administrator, Git should consider a worktree owned by the
Administrators Group as if it were owned by said user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 912444fb3ab..e0e020ee574 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2669,6 +2669,7 @@ int is_path_owned_by_current_sid(const char *path)
 	else if (sid && IsValidSid(sid)) {
 		/* Now, verify that the SID matches the current user's */
 		static PSID current_user_sid;
+		BOOL is_member;
 
 		if (!current_user_sid)
 			current_user_sid = get_current_user_sid();
@@ -2677,6 +2678,15 @@ int is_path_owned_by_current_sid(const char *path)
 		    IsValidSid(current_user_sid) &&
 		    EqualSid(sid, current_user_sid))
 			result = 1;
+		else if (IsWellKnownSid(sid, WinBuiltinAdministratorsSid) &&
+			 CheckTokenMembership(NULL, sid, &is_member) &&
+			 is_member)
+			/*
+			 * If owned by the Administrators group, and the
+			 * current user is an administrator, we consider that
+			 * okay, too.
+			 */
+			result = 1;
 		else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
 
-- 
gitgitgadget

