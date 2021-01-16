Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B6CC43219
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619BB22573
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbhAPRGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbhAPQbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:08 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE5C061347
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so12194035wrc.13
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmRCPiPnaVdAjzPU4CdmV+YOd26DV9Ng5f6enRvp4U8=;
        b=gepyG5fK+W6LAYkRmxUDMCBlw4ak1vxVQk8FTpkMiyIN48NDix7hld5fV3aS8pMTet
         GVJgECKVfmPPlLMs0U/uNIJO9YC38fqJKjD2azmVKyOiy8Exy/h017DTwCxah5/X4AAA
         0+XWPklb2etCAFWf9m9u+gya4vznKrq0V7qiLqIfa/dlkyzz3Xlx3Zyy9GqaVTy7Sxqd
         G3FCyKOcobEzCUD2tw14jUqKtc+oM+c9JJDfCZTsCUcSU75U4jhvkJNWXFs9Kz+2348i
         kCdv5NP4qoPqbgk14U1KrbMy737Ih69rFx2d+/+zjfPHk3VeKjYoVToTC8ERSbyDy7An
         s8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmRCPiPnaVdAjzPU4CdmV+YOd26DV9Ng5f6enRvp4U8=;
        b=d7mx9XL0Z2Jz9g63z1Y+kuXZdZr4zkIwpvQJEI11YaHqMj04CMwNvcqQXUxcWvLzky
         iqhNir7S849XOfNNroFUHI5GmLayCQj9yzOKaIxTwtSvJfYgjS7Doiz3LNhQ3gQ5n8HI
         geDDPp4xBN/PYUl0wYmENE6g/aF0zDzAMdUeWj7RaGFF20h2NkTWQ49nRTYgrsZeGorB
         LCn3Gj+5IzrUO8qTEZPL8jTXok/qWly0QowHbKx6n+7Gc4vgRvIeXJlr1eFF0Hlzrjo8
         2Zu/2FRuTC1dcWHmqInAH1qTeRBWZ8dZmpS1f4GuUbcNa7uDh3KayzjFvN8+bDTBUTCI
         w3jg==
X-Gm-Message-State: AOAM531CwVpP73JyNTIsg+FQKe1ciF38OilcjZfY4V0zdPHOMZrEl3tj
        +PxmRX9PioHGy/mAVe7HAE5xyp9FJDzk4Q==
X-Google-Smtp-Source: ABdhPJzNg4/Nc00Z0gPU7u8NFWusJwkkbROXFvpnxqR6iDOzaOVnZoaCR6o1dQAk+kHtzn/JVkrxVQ==
X-Received: by 2002:adf:ba49:: with SMTP id t9mr18515146wrg.183.1610811360559;
        Sat, 16 Jan 2021 07:36:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:35:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/11] cache-tree tests: remove unused $2 parameter
Date:   Sat, 16 Jan 2021 16:35:44 +0100
Message-Id: <20210116153554.12604-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $2 paramater. This appears to have been some
work-in-progress code from an earlier version of
9c4d6c0297 (cache-tree: Write updated cache-tree after commit,
2014-07-13) which was left in the final version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 5a633690bf..354b7f15f7 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -18,7 +18,6 @@ cmp_cache_tree () {
 # correct.
 generate_expected_cache_tree_rec () {
 	dir="$1${1:+/}" &&
-	parent="$2" &&
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
 	git ls-files >files &&
@@ -29,10 +28,9 @@ generate_expected_cache_tree_rec () {
 	for subtree in $subtrees
 	do
 		cd "$subtree"
-		generate_expected_cache_tree_rec "$dir$subtree" "$dir" || return 1
+		generate_expected_cache_tree_rec "$dir$subtree" || return 1
 		cd ..
-	done &&
-	dir=$parent
+	done
 }
 
 generate_expected_cache_tree () {
-- 
2.29.2.222.g5d2a92d10f8

