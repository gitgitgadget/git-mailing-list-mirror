Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2BDC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiKCRHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiKCRHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E71CFFD
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v27so4066430eda.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYiyJDZtrEjekuGrketobMhGZKznXSG+b90DVlnEYZw=;
        b=BF1fwCjNj9DYgAlFM8hvVfCxMH4o0K/ZC/X5KVgRf+mbM6rM6gjQLIFap9I4ZjbKPR
         KSiFwoh9f234pK6mNs/KYLDXvoNuETjRydG6nJKiCoQNpwM2H+p705vcSu6L6XKj5IDt
         njBAsc29rtp82dNkyJH8fMz/sr12GmW77l1QgKgjMRngJP5pF8ZN4Sszce2vvND+fEA2
         2GSY1oZvtoDodnKF+UOmHD08BhKL85A9PCDwObdPD7qs85Y1AiWzZyEJLsqTjs/p6PDi
         M8HBXN7dRHEI+ZKn/SBW1YycupRMdACshgfDMncp9ROZyqEI7fJ8xjcyuMysGoK56MI3
         wdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYiyJDZtrEjekuGrketobMhGZKznXSG+b90DVlnEYZw=;
        b=cBydhKtiiqoX+O17m3gUlZRqlYtCpgxN04VSSaZhLwSXTeFHexnWTy0HKuSARjlOIr
         4TOwXqCjHQce0PL33tfCCGPiqOyxEz3Xa/7pKKyrfjROhHdU1oIV06Xgty04dqnVR4wS
         0KYz6FiAuAlefIVP/eanzyuSEVSUJMDkwOzhSHbE9Uhs8bMgdp77K9DS7lJtN4fKYgB/
         Tse6KFfwR1nWfiyPEc9SLtWLaWKt8qraztIz3Ey3MehJhGGVTh6FzmjImmNJ7WF5qVVi
         ScT/w4gA0tdXotrPFJ5F2xdRCoUiAXBd9nnOdbiDpWtDA8SByCMbx7YwlJbBX6cm5qwq
         DVfg==
X-Gm-Message-State: ACrzQf1LQf3kHgrBQ9u9LYC7w8qg8lNoVcCYpIJ7H0GzltSk4d7AwnDy
        xkwlrUmGlDDMGmisaj5Id+u9TpDid1aATw==
X-Google-Smtp-Source: AMsMyM49opuSx8gS9s1EjHkPePMR/DbRbLbu/vdMNe17vvvf3mIUwRiGRGV0gNQswOvnsYjEbnqAFA==
X-Received: by 2002:aa7:d889:0:b0:460:62ef:2695 with SMTP id u9-20020aa7d889000000b0046062ef2695mr30044068edq.273.1667495184254;
        Thu, 03 Nov 2022 10:06:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/17] dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
Date:   Thu,  3 Nov 2022 18:06:04 +0100
Message-Id: <patch-05.17-29123e62391-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "ident" member of the structure was added in
1e8fef609e7 (untracked cache: guard and disable on system changes,
2015-03-08) this function wasn't updated to free it. Let's do so.

Let's also free the "exclude_per_dir" memory we've been leaking
since[1], while making sure not to free() the constant ".gitignore"
string we add by default[2].

As we now have three struct members we're freeing let's change
free_untracked_cache() to return early if "uc" isn't defined. We won't
hand it to free() now, but that was just for convenience, once we're
dealing with >=2 struct members this pattern is more convenient.

1. f9e6c649589 (untracked cache: load from UNTR index extension,
   2015-03-08)
2. 039bc64e886 (core.excludesfile clean-up, 2007-11-14)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 dir.c | 10 +++++++---
 dir.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d604d1bab98..fbdb24fc819 100644
--- a/dir.c
+++ b/dir.c
@@ -3581,8 +3581,12 @@ static void free_untracked(struct untracked_cache_dir *ucd)
 
 void free_untracked_cache(struct untracked_cache *uc)
 {
-	if (uc)
-		free_untracked(uc->root);
+	if (!uc)
+		return;
+
+	free(uc->exclude_per_dir_to_free);
+	strbuf_release(&uc->ident);
+	free_untracked(uc->root);
 	free(uc);
 }
 
@@ -3739,7 +3743,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 		      next + offset + hashsz);
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
 	exclude_per_dir = (const char *)next + exclude_per_dir_offset;
-	uc->exclude_per_dir = xstrdup(exclude_per_dir);
+	uc->exclude_per_dir = uc->exclude_per_dir_to_free = xstrdup(exclude_per_dir);
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
 	next += exclude_per_dir_offset + strlen(exclude_per_dir) + 1;
 	if (next >= end)
diff --git a/dir.h b/dir.h
index 674747d93af..8acfc044181 100644
--- a/dir.h
+++ b/dir.h
@@ -188,6 +188,7 @@ struct untracked_cache {
 	struct oid_stat ss_info_exclude;
 	struct oid_stat ss_excludes_file;
 	const char *exclude_per_dir;
+	char *exclude_per_dir_to_free;
 	struct strbuf ident;
 	/*
 	 * dir_struct#flags must match dir_flags or the untracked
-- 
2.38.0.1451.g86b35f4140a

