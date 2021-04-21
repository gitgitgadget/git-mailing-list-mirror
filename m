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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A2C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91256144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbhDUO7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbhDUO7S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:59:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EAC06138B
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1405991wmi.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/9xCQ7wJooRRmN/xo95+MIKfVh9rMU7PTFmQBTEBZY=;
        b=tvhBuJVHVtfelTOq6kY4bMMgDYmiZftNzPcHjgTarD9VURMxquHJI0mhQy/RjTbY3w
         7N+Oj1kysPf5uNDgxXDJltl7Dlooea1KTFJ1ZnzqtmiXDF+95qzO+6AUvJCpo7ECDItQ
         1zKKCLDntOwjTvw0N/f3A6LLe9L56fONJIxkHHa+aLi3YUx3UxdEQ2BcNSOvJD5VAv0V
         xmLhfvs/u9YlSufZVklCCz1BwZBDBgRa4P/bJzKTXBoCykovUgcVIqv6zWNS1fdDjv9R
         WnwBFLao5VnZaxQLh+AK0ETyoOiQJeCdnGHAT9GWwrQYnV1SS7Wm/rufr6x7s8i5/vYu
         soGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/9xCQ7wJooRRmN/xo95+MIKfVh9rMU7PTFmQBTEBZY=;
        b=iRDhDsJoVfqBVznN8rmAv5yKayYmWFM6eQq0nECV6QbDXpWSzaGH0PV3s/Y5cBQuWd
         Tsb8gcNU0186U6FLbnBqPnMQkQFs//HGl/mhHMOMvystDm0V2QzxK8OaKFcdbZDPu/mG
         T2Ud6n8GPyQkvEkar+nVBp2Qm1fVyagJzA3jiqy5TeToEHwyPwWXXDAUtB2evtx57I7f
         shKoq6TWFQquAUy0Lz9dIHoSZ1eXwzoGr9fAW8KdBJ36I0E+TPL60c8ov4gQ1dk9Vncx
         bM6k98fMSWDP+qzCOCWrHRgGiKhSO/HDCmgeM+9w0aCS8MPAr7xdFx9iZH8RPl99be6f
         hIjA==
X-Gm-Message-State: AOAM530WvbzSYyQBwej8wemZypMVQqnX9OkJn5Oq80kSYrmNiMNAtQlA
        7BDa5khY2kgvt4s3XPasAmIpsEzmRvAUDQ==
X-Google-Smtp-Source: ABdhPJyg/z4aU9JQ6HD0GP+KsgrM/JYPxwi8qD56IqnA7jcy5cMIqGuk0kWjUnArrn7MpdH1NZ380w==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr10183825wmk.3.1619017123561;
        Wed, 21 Apr 2021 07:58:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm3394316wrd.69.2021.04.21.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:58:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] test helpers: remove unused test-tool path-utils slice-tests
Date:   Wed, 21 Apr 2021 16:58:36 +0200
Message-Id: <patch-3.5-44948c6ace9-20210421T144921Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g9a7f2f961d4
In-Reply-To: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com> <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This utility was last used in the code removed in 4c2c38e800f (ci:
modification of main.yml to use cmake for vs-build job,
2020-06-26). Let's also remove this now-dead code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-path-utils.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 313a153209c..3d7c0f1d19d 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -177,14 +177,6 @@ static int is_dotgitmodules(const char *path)
 	return is_hfs_dotgitmodules(path) || is_ntfs_dotgitmodules(path);
 }
 
-static int cmp_by_st_size(const void *a, const void *b)
-{
-	intptr_t x = (intptr_t)((struct string_list_item *)a)->util;
-	intptr_t y = (intptr_t)((struct string_list_item *)b)->util;
-
-	return x > y ? -1 : (x < y ? +1 : 0);
-}
-
 /*
  * A very simple, reproducible pseudo-random generator. Copied from
  * `test-genrandom.c`.
@@ -428,29 +420,6 @@ int cmd__path_utils(int argc, const char **argv)
 		return 0;
 	}
 
-	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
-		int res = 0;
-		long offset, stride, i;
-		struct string_list list = STRING_LIST_INIT_NODUP;
-		struct stat st;
-
-		offset = strtol(argv[2], NULL, 10);
-		stride = strtol(argv[3], NULL, 10);
-		if (stride < 1)
-			stride = 1;
-		for (i = 4; i < argc; i++)
-			if (stat(argv[i], &st))
-				res = error_errno("Cannot stat '%s'", argv[i]);
-			else
-				string_list_append(&list, argv[i])->util =
-					(void *)(intptr_t)st.st_size;
-		QSORT(list.items, list.nr, cmp_by_st_size);
-		for (i = offset; i < list.nr; i+= stride)
-			printf("%s\n", list.items[i].string);
-
-		return !!res;
-	}
-
 	if (argc > 1 && !strcmp(argv[1], "protect_ntfs_hfs"))
 		return !!protect_ntfs_hfs_benchmark(argc - 1, argv + 1);
 
-- 
2.31.1.721.gbeb6a21927

