Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D656DECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiHaXPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiHaXPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:15:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0209920F4E
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso429725wmb.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Mwib3DNjDZg7XvybHwUOZcR9r4G7HN5s+CcQsOj+xxY=;
        b=P4V24/LJrRtwEFovzkA+YLQcfvVjHDJok0C/dWf5Rpxz7Yj2hNPbm1IzLENFwbJmRD
         3AD31HaJjBwtmk7wsSW0AN2NZNrUBffWYkn7156QRmBxyrDrMa3bj1fzievmEZpdOj9j
         9r4osWJy9XYOUiLt239eEoEE6mrqQejN5baE3Cod53VXLYZzdMY8ab1tA+uC16MMuyHu
         FSeWiLy+DOtbAYj+lh50p10q1/uTeFX6RAEuO9j7jKJp1o7W72Jfq9d1NoTMnlzBhm1M
         J9P9foJsC04UBQu3rN3oSYaUmcUJP69MF/mdt2hs2ddt+bFzpGPT/xHgvwtH7RdvZ+QA
         bW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Mwib3DNjDZg7XvybHwUOZcR9r4G7HN5s+CcQsOj+xxY=;
        b=SnXXE1v+EW5dN9YzVVDsiKn5myrrLRE1kzLZQ0ez87gBlkFgj6DZi0+m6GtMvCDtvM
         01ZfqP2plQYya8Z8lucQ0ZZxD3q25pIWd66SElowMVJmI4MFkj2y7aLdBBzLmgFCSNKW
         59AFCgNUPkWNBXFIpBpyrGaoHM0FVazhc9vnMRtGyMCYVhR4oqwhz0uyk2SfaDokWtAS
         3y7F0jZmN+9hTkagz4wjqEWpBUJ/aLmc4YwrU3Xrb1bjwDnqVbpdORCGmoNoh7xYdOvp
         5J2LfXaUD2QAWi+oPqyKshRcQUL5HbaaOAUmPtVJqdFPiZAZfoWJGnU8gR9WqcJWNOgc
         Q5mg==
X-Gm-Message-State: ACgBeo2wm8Dro5b4oEJwumXcPlpG0A7aqJ9cg6zxBY+zEh6FTBC2F6+G
        6DZ75L64J6do1zYBima7roFHH0MftNozlQ==
X-Google-Smtp-Source: AA6agR5iJraMH1THcuCDofuX7UN3vHFuwPvd2Km0NQizDiB0NxoJAyLFJ1NWzjTR0f6ZO2qeHuhE2Q==
X-Received: by 2002:a05:600c:2853:b0:3a8:3d66:2653 with SMTP id r19-20020a05600c285300b003a83d662653mr3375456wmb.156.1661987697240;
        Wed, 31 Aug 2022 16:14:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 13/17] submodule--helper: fix a leak in module_add()
Date:   Thu,  1 Sep 2022 01:14:20 +0200
Message-Id: <patch-v7-13.17-c922e04f3d1-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in module_path(), since a6226fd772b (submodule--helper:
convert the bulk of cmd_add() to C, 2021-08-10), we've been freeing
add_data.sm_path, but in this case we clobbered it, and didn't free
the value we clobbered.

This makes test 28 of "t/t7400-submodule-basic.sh" ("submodule add in
subdirectory") pass when we're compiled with SANITIZE=leak..

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 675dc3f16a3..7c62916da3c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3317,8 +3317,12 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	else
 		add_data.sm_path = xstrdup(argv[1]);
 
-	if (prefix && *prefix && !is_absolute_path(add_data.sm_path))
-		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
+	if (prefix && *prefix && !is_absolute_path(add_data.sm_path)) {
+		char *sm_path = add_data.sm_path;
+
+		add_data.sm_path = xstrfmt("%s%s", prefix, sm_path);
+		free(sm_path);
+	}
 
 	if (starts_with_dot_dot_slash(add_data.repo) ||
 	    starts_with_dot_slash(add_data.repo)) {
-- 
2.37.3.1420.g76f8a3d556c

