Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C300C3DA7D
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiL1SAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiL1SAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4EE183A4
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w1so3414833wrt.8
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkt+Ewn/CwKksgG92QRo1+qNvbPT205QpPEYAwwn+2o=;
        b=Xhl1nHi2MxwDINagZ7OMdIRwtEZZOZ0UUEUKChHuYatZyXUUa8snmxr4EuKLBh7zY/
         v3RRFmg3v68nIIeczUP3mzAFFSj4Jafoeed++RThKKAUVsNkczwuSA1NEraay+MrbXfU
         rhfLx/cJuGRnaTS2K/v2MN5SfYpZcVGYvYVoxdkeEFU3XwOfnY9PN2828rOguUQKOTx4
         7epRiMRzhkGQLxHAd1KaXGORHHw/vE+V/uZE+3E8bxLVMpGjuGJjXSv3kYBhuloczCfh
         mwFF+Hy9uv0SHzTud/MhQLb1T0yFZcnC5DIBbUyPYFtZLb7LFPW+yXmxFS1vaOnPn8sT
         fv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkt+Ewn/CwKksgG92QRo1+qNvbPT205QpPEYAwwn+2o=;
        b=XWTLy1x2JqmurjbI8HgtLvT2nh7My843nqrNWuVHeBS5IoUvTHXRMKUrXtn7mJxkmY
         QEG0Sn/NEwVNwLiZO8BSCpB3i/oUI2ZDodal6kUXrGENurD8snWUXvdlEs1MaM2Zgv0T
         fBWFDFYaZBrzyQMbOWJWiYykVmRNgYRp28wy2FfNuJz+drWj5CzIGE5Wixnyl8vlGLzf
         rNs1J6annRwHnoaqe/3tRIqQawxx0Bo9/sCByrSM+6ZLthAN2IT4EUdZ635JO54zhPOS
         iKnS/GX4WjcK466jl7d5nkIROr0NUF7kghaXYjR//JqpF+rtQ3YRpltbfd/bg/LpfR1Q
         Cryg==
X-Gm-Message-State: AFqh2kqy8eCenBuLERjA9ijBnCHm/pl0UqI7laVrqYecoSl0IuQ7uCQn
        zKr77dDRXlxvQ0ueXr2hqGsHcuZUUcF2QQ==
X-Google-Smtp-Source: AMrXdXu1WbxYX3EdXiCTYNI5shCkwlje2xsvp8jNNywuD/IAYeKHvJOagg5132Pp7N31XeP3joFXSw==
X-Received: by 2002:a05:6000:181:b0:276:c52a:e3a0 with SMTP id p1-20020a056000018100b00276c52ae3a0mr9525913wrx.65.1672250433101;
        Wed, 28 Dec 2022 10:00:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/20] stash: fix a "struct pathspec" leak
Date:   Wed, 28 Dec 2022 19:00:07 +0100
Message-Id: <patch-07.20-e5a0134d1bb-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call clear_pathspec() on the pathspec initialized in
push_stash(). Initializing that structure in this way is already done
by a few other callers, and now we have:

	$ git grep -e 'struct pathspec.* = { 0 }' -e memset.pathspec
	add-interactive.c:              struct pathspec ps_selected = { 0 };
	builtin/sparse-checkout.c:              struct pathspec p = { 0 };
	builtin/stash.c:        struct pathspec ps = { 0 };
	pathspec.c:     memset(pathspec, 0, sizeof(*pathspec));
	wt-status.c:                    struct pathspec ps = { 0 };

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index bb0fd861434..e82fb69c2b3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1708,7 +1708,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int pathspec_file_nul = 0;
 	const char *stash_msg = NULL;
 	const char *pathspec_from_file = NULL;
-	struct pathspec ps;
+	struct pathspec ps = { 0 };
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
@@ -1727,6 +1727,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		OPT_END()
 	};
+	int ret;
 
 	if (argc) {
 		force_assume = !strcmp(argv[0], "-p");
@@ -1766,8 +1767,10 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
-	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			     include_untracked, only_staged);
+	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
+			    include_untracked, only_staged);
+	clear_pathspec(&ps);
+	return ret;
 }
 
 static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
-- 
2.39.0.1153.gb0033028ca9

