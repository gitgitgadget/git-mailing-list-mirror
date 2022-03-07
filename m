Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC5C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiCGMfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiCGMfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:35:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0988B19
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:33:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j26so12653083wrb.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kreINs5wyhHX8S6GbmK0qosqMQu4h7jm9wNYxXM/c8=;
        b=n6GwjimJDHtJTuWQyNoctTdjMCAZurUwgKtH/2Z6PgDeFLP8TVPEigd3b9YRNftOHG
         8BM/t55m0UMVx5M91Pbfu032xl4v9k8zuVAa1/NjoKv1TVDJyvvbn8pDUcTWDXcPZRw1
         5P3fTNiZMHk+dGc6LEh7xMBGC85mhPDZNX1qVcizurX14VNZigxcJGOKTAfuRsMv+2aa
         g1cfP8YuCrFgAks11OWaj8TiyzW5ioWhtgvB3eSSA0HSXFKcz9DOz+dwKuH6P4tHwTk/
         S9iqa3m7vKef8eAu/EdyeUL310uAKkOioHr/pfQacKoJflICdYFHMQ1tLVowVREqQiFt
         K7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kreINs5wyhHX8S6GbmK0qosqMQu4h7jm9wNYxXM/c8=;
        b=YUTvYHp4vvkmjTKJqMq3CIMqlkHZLyh4U09mbZpBR5FKKs76Q9XDnKjep9gG7kwtzN
         Nq3ghPcA4FyUj9dahf09D6jC4E0mtmYEeDVnZgWzvSZJQmd+ELA+0l83ic1am/rEkTFB
         MIVGJ+eOFxlsuBZN43ih0+LvaXjmNh3hzqhWHge1Od2Pd8I/shJ7YcDqjbfeT2pMIEN0
         hOA+1yLfivW+idUNgdFB8VryBKrB7WLlyV8oMZvR+dBsUChLMcIbwDwCyoHqTml+RPrP
         wJXK2KIhhxgTJI/zO920i604nmTSroVVBBKWMrAxLk7VZ6LNMm5x6L4nWk7LZ55YpPkg
         5Sgw==
X-Gm-Message-State: AOAM5321zWg49RLTx4vqfWKium2WJGXLDnNHwet0s2QvR+3d+KF1I9hK
        DIha55ASYgQiNuX8LxqmXf2M01TBA6K0Hg==
X-Google-Smtp-Source: ABdhPJw3I/EvFybY4j4PmA1f2G9rssOwngH79eD4pPEpnp0vBxR3ffoTz/XaTn2S81lzoGyhbP9hAA==
X-Received: by 2002:a5d:6d83:0:b0:1ef:d78a:41fb with SMTP id l3-20020a5d6d83000000b001efd78a41fbmr8344532wrs.355.1646656429933;
        Mon, 07 Mar 2022 04:33:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm13657012wmq.8.2022.03.07.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:33:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] merge: don't run post-hook logic on --no-verify
Date:   Mon,  7 Mar 2022 13:33:45 +0100
Message-Id: <patch-v2-1.2-8f7b01ed758-20220307T123244Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-0.2-00000000000-20220307T123244Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220307T123244Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a minor bug introduced in bc40ce4de61 (merge: --no-verify to
bypass pre-merge-commit hook, 2019-08-07), when that change made the
--no-verify option bypass the "pre-merge-commit" hook it didn't update
the corresponding find_hook() (later hook_exists()) condition.

As can be seen in the preceding commit in 6098817fd7f (git-merge:
honor pre-merge-commit hook, 2019-08-07) the two should go hand in
hand. There's no point in invoking discard_cache() here if the hook
couldn't have possibly updated the index.

It's buggy that we use "hook_exist()" here, and as discussed in the
subsequent commit it's subject to obscure race conditions that we're
about to fix, but for now this change is a strict improvement that
retains any caveats to do with the use of "hooks_exist()" as-is.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a94a03384ae..b26b4c45157 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -845,15 +845,18 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
-		abort_commit(remoteheads, NULL);
-	/*
-	 * Re-read the index as pre-merge-commit hook could have updated it,
-	 * and write it out as a tree.  We must do this before we invoke
-	 * the editor and after we invoke run_status above.
-	 */
-	if (hook_exists("pre-merge-commit"))
-		discard_cache();
+	if (!no_verify) {
+		if (run_commit_hook(0 < option_edit, index_file,
+				    "pre-merge-commit", NULL))
+			abort_commit(remoteheads, NULL);
+		/*
+		 * Re-read the index as pre-merge-commit hook could have updated it,
+		 * and write it out as a tree.  We must do this before we invoke
+		 * the editor and after we invoke run_status above.
+		 */
+		if (hook_exists("pre-merge-commit"))
+			discard_cache();
+	}
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
-- 
2.35.1.1242.gfeba0eae32b

