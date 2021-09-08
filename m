Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B052C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D13C6108B
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbhIHCSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhIHCSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:18:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D515C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:17:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so853523wrb.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mO6XkLHQL3a/TemDdoDtE/8OXCaWboURjrkTebQ11wg=;
        b=mIscAzCTMau1ox7/GhcWXc5la0B9ateW+DF8B0lFklEsMJB+xqkrK3CWznEM1f4vxA
         vLFinNVkfJIQVyeOcYNxQTgRaO8hREuagzsPg3xIi1OD+MIvmna4iO6tkUW5FuJy5wQ2
         W1eer28AmTJs5odYNDhqtyqtL22tFPMicSK2sRqii3ymBU3e8IWMKPH9Tn78AUbMjnZE
         /X1rnPfRKrat7r738un8JOej32G4qBu/qZ+0mFIc4aelWasRN9GlOSAx6o3ehIQEgl6d
         G/TUsWc8SKaLJPeKDRBvxFUTPK5EX/3ou63xwo3nOpTG7bMHZKpqETBY8lk0smZUqiXJ
         SYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mO6XkLHQL3a/TemDdoDtE/8OXCaWboURjrkTebQ11wg=;
        b=L6GgR0xExS2/lluS0+E0iSPBTBAjLcTTzaYdWB6kqrwrgjM5VA5qU4I4bCByxjFHg0
         LCjecPybD7/y2oWKGar9KJSfNgwvCqBQKUruKaVb3MrE+B6joIPaaSOHBI2qr3SBhTy+
         eU4+74ZZliA08gEze++KdE2ijoTvFMP7a2ZgNscwL82IS/NzKXzzETNOx8iIOEpySVYA
         5Czh19XLOE3ac6q9Swlg7IZzsCXGUg7DMFk8bU8eXmLTOe2EfZ7o1mlvKWgZsSlEbpkg
         PQLSAaupljRYezEUqdfS3kGfApt6kP1qrlAz8F6k/aaxmTsXUEx++oRDsZqcl65htwD2
         jqrg==
X-Gm-Message-State: AOAM531zz4ZsM3PviSlchiAYfOyii+I8c1OFTrBuAjvtFxtLYi1fZmUe
        ElfFpeu6wwqp7wCGXNTFjifGBiaQ3Y4=
X-Google-Smtp-Source: ABdhPJxlQL3v8muP3O7IdRtkfy2nhS8gBuc4scu6eBuILWeaoyZJ91+lZX1FOwHzAhIY+CTtmYhpUg==
X-Received: by 2002:adf:8b03:: with SMTP id n3mr1166718wra.439.1631067431308;
        Tue, 07 Sep 2021 19:17:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm649744wra.37.2021.09.07.19.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:17:11 -0700 (PDT)
Message-Id: <5fa7daf264b75fc5419e829683be2e6d83191908.1631067429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 02:17:09 +0000
Subject: [PATCH 2/2] am: fix incorrect exit status on am fail to abort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c        | 3 ++-
 t/t4151-am-abort.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0c2ad96b70e..c79e0167e98 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2106,7 +2106,8 @@ static void am_abort(struct am_state *state)
 	if (!has_orig_head)
 		oidcpy(&orig_head, the_hash_algo->empty_tree);
 
-	clean_index(&curr_head, &orig_head);
+	if (clean_index(&curr_head, &orig_head))
+		die(_("failed to clean index"));
 
 	if (has_orig_head)
 		update_ref("am --abort", "HEAD", &orig_head,
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 501a7a9d211..f889f25a98f 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -195,7 +195,7 @@ test_expect_success 'am --abort leaves index stat info alone' '
 	git diff-files --exit-code --quiet
 '
 
-test_expect_failure 'git am --abort return failed exit status when it fails' '
+test_expect_success 'git am --abort return failed exit status when it fails' '
 	test_when_finished "rm -rf file-2/ && git reset --hard" &&
 	git checkout changes &&
 	git format-patch -1 --stdout conflicting >changes.mbox &&
-- 
gitgitgadget
