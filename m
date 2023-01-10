Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15120C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjAJFpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjAJFoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:30 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6A40841
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:06 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id cf18so19457639ejb.5
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JqIp03kxI3hXdFuwS8M3uz/VLJiA94qJQr8Y7PMcoQ=;
        b=d1dBF3JDT6XgEy/QP37VAPlBskYYnEknhLkXgxmE5ee2Lzo2UgsG9TJeL+MhX25MYH
         2l6ooikFxkAjpqrCRj1TlOhXu2ptebEKFr5bjc9HU9ekYAp7eoRmvHsI/kc+suXUSd+k
         j9QokWHlpPDp1hYm8SN0hf3eld4wKQ7CZ1hPeRUUTyQ7KyxFvBZQ7bUbeZrRxHV7Kpem
         pm7RjGoHP//2m3S9GDDQ7oFf7Ift72Rr6v+nRpibxCOuppUmYpMIniWSvjjVaFHgoq7+
         h43dOkXRMi4GAVCj03sYvzd1F+r8ZlBD1o0EAX2MjbA+29m7CxoKzk9yaL4ph/0cHSmA
         7mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JqIp03kxI3hXdFuwS8M3uz/VLJiA94qJQr8Y7PMcoQ=;
        b=jW/mtxHr5VjemFferGtTXIMF34zwf5AWb7WfuRqyCzU1DBgF9EyODQNjW2rbJlWpKu
         v044/f3UXKsa6AEbJXtbfUcVjLxsP3oB7ZvbKgcAzGS2GnJNrCVk3WCsfC5furictYeX
         bO0t4uh/DO5xgcc3Q0H8iCje7ZqBukTO+zAwDzdaoyyGdLiQFURXK+JsVz+XkUuR9xQ3
         GCayGajycOZ+pOJS3pcWobG5gLqxtv+dLYoC8p4MUcS4Q7VX5rFFgF53X2Xp1coFgn51
         OP0FS5HFLEF0hrDgDojbm1KyXTcfZnHJrBcN2m6bKNY62LPBQ+NOHxczbNkT6T7zZrW0
         c3Tg==
X-Gm-Message-State: AFqh2koQXYqAnO3ZJ+9UkVDt9wTwA3JXCu69cR5xP/W92luoyx70LwQG
        1WR8/jrdNWf1yZEF1nvpvZkwwspLkuLeFA==
X-Google-Smtp-Source: AMrXdXta4I2taDUmufscFVSZ2nvDBgG1b8Gdl9gE7admw4DPnzDDf5g2Vob/LGO5KGhv+5nfoZDhJw==
X-Received: by 2002:a17:906:d052:b0:7c1:5098:907a with SMTP id bo18-20020a170906d05200b007c15098907amr60116001ejb.35.1673329444459;
        Mon, 09 Jan 2023 21:44:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/19] object-file.c: release the "tag" in check_tag()
Date:   Tue, 10 Jan 2023 06:43:35 +0100
Message-Id: <patch-v3-15.19-7c70bbdebc8-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since c879daa2372 (Make
hash-object more robust against malformed objects, 2011-02-05). With
"HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
tags into a throwaway variable on the stack, but weren't freeing the
"item->tag" we might malloc() when doing so.

The clearing that release_tag_memory() does for us is redundant here,
but let's use it as-is anyway. It only has one other existing caller,
which does need the tag to be cleared.

Mark the tests that now pass in their entirety as passing under
"SANITIZE=leak", which means we'll test them as part of the
"linux-leaks" CI job.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c         | 1 +
 t/t3800-mktag.sh      | 1 +
 t/t5302-pack-index.sh | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/object-file.c b/object-file.c
index 80a0cd3b351..b554266aff4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2324,6 +2324,7 @@ static void check_tag(const void *buf, size_t size)
 	memset(&t, 0, sizeof(t));
 	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die(_("corrupt tag"));
+	release_tag_memory(&t);
 }
 
 static int index_mem(struct index_state *istate,
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e3cf0ffbe59..d3e428ff46e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -4,6 +4,7 @@
 
 test_description='git mktag: tag object verify test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ###########################################################
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index b0095ab41d3..54b11f81c63 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='pack index with 64-bit offsets and object CRC'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.39.0.1195.gabc92c078c4

