Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B7C10F1B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiLSKTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiLSKTi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:19:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60870B856
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i7so8098571wrv.8
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCPcvTZF8WQH4MZySTvdoXU7GLXz4SsMe3JzoZuH89E=;
        b=HFhAk4X0A4A1ytKqQCzNiumoKttXsvaHw13EVh+Rj0oScusomOR29H/JVOnKbrxnF1
         B8B+FXIlsAd0nzgqRpWvGBjFHg0j+xJsdtrYOMq4QQ7qSDk7aoJKKlpoz5eOytsZnTf1
         OMULOCvlrKi5ccNWSi5e9W7uu0QCcw/SYvDyu5UXkXN9xoZTFIYmzIgh6KeMvy/5t+uW
         C5MGtWkrbQGsV+3il5JCaqY8OleD0H2IKkevrgAtd4U4z3Zm+LZl4lwPpOW4muqcBahJ
         bcUsIhvjal2HFDWdiSyLvdedEEKzDeprGcc17qbFySsZ78pzJ8VdRoJWVO6mwc4AnCnd
         owdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCPcvTZF8WQH4MZySTvdoXU7GLXz4SsMe3JzoZuH89E=;
        b=WYTgMlb+iHXFcftjZ1oTE1l3kHV8/cTXgjhu8zZJM/Z3LkJIlETE2tZHOK4v+cFV59
         8Rjjk6htE2zF61WjSwM6V6vSxfT1HxdliTy+T+QjOcqbWljibvzj+5BVHdQ3/jLRw5Y8
         k9WFRr8QkYn6k+hJvg/bR/XlrK7I/w/xMLbrOxt/hcaVBxcmhGBkz8JbXADz3GvCNjqs
         bDuMSDOuP9lX69dlq9epKM3f3LmrGD6i3u7yk1qud3kyEkhtboubHeM9aBuUsWwI2RYv
         FvQ9tVFmgN4bRahnHCqUiFTd24IDs8ycKPqiye33kfDaLLTx9kpQjuPv1VrWEU4Rd2l5
         UbSg==
X-Gm-Message-State: ANoB5pmee/6HwEkCTaGiWVWfkaDPQAArzQgg5RSj84WPRoacXlruD7Jt
        NPHTbXhQ4X4V5uwkVYn9yytHIDiXErTV8g==
X-Google-Smtp-Source: AA0mqf5RHeyVgdezcF+C4ZKRFSXlaB1X9dO4/LLfBI5G0qyroPuods88hFnDgQDlS91WoZ0nejkRUA==
X-Received: by 2002:adf:a459:0:b0:242:798:53d9 with SMTP id e25-20020adfa459000000b00242079853d9mr36098007wra.40.1671445175557;
        Mon, 19 Dec 2022 02:19:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bx25-20020a5d5b19000000b00225307f43fbsm9632672wrb.44.2022.12.19.02.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:19:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/6] t/lib-patch-mode.sh: fix ignored exit codes
Date:   Mon, 19 Dec 2022 11:19:25 +0100
Message-Id: <patch-v4-2.6-d351075f0ab-20221219T101240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in b319ef70a94 (Add a small patch-mode testing library,
2009-08-13) to use &&-chaining.

This avoids losing both the exit code of a "git" and the "cat"
processes.

This fixes cases where we'd have e.g. missed memory leaks under
SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
discovered it while looking at leaks in related code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-patch-mode.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index cfd76bf987b..89ca1f78055 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -29,8 +29,12 @@ set_and_save_state () {
 
 # verify_state <path> <expected-worktree-content> <expected-index-content>
 verify_state () {
-	test "$(cat "$1")" = "$2" &&
-	test "$(git show :"$1")" = "$3"
+	echo "$2" >expect &&
+	test_cmp expect "$1" &&
+
+	echo "$3" >expect &&
+	git show :"$1" >actual &&
+	test_cmp expect actual
 }
 
 # verify_saved_state <path>
@@ -46,5 +50,6 @@ save_head () {
 }
 
 verify_saved_head () {
-	test "$(cat _head)" = "$(git rev-parse HEAD)"
+	git rev-parse HEAD >actual &&
+	test_cmp _head actual
 }
-- 
2.39.0.1071.g97ce8966538

