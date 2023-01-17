Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338AC6379F
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjAQRMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjAQRMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:12:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527D74521C
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vw16so13785482ejc.12
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNAdvILvYHVHQZagSiHg7GRtC8IV2ThQrGptssEb6H4=;
        b=H8ap4IPjuu/EfgBzZGnpUABOc8AGhr8hXPFJzKzj0y361rBS7B734E2sM7Twb6KF2l
         dgPgQqi/dI3IefwnQI1ZyvhUmo6306x8yAovVMR8xxJjyzEfD0FF9cBh99kgf235LVLr
         eFFJWhuUjeqOJPhi5O0qfBHkLzWr9/d1oNmta/ThF+EjLn49QqhnXc6RxJOQvonBjbSR
         dvpngCGX+LyfU4JvF79oviQcvLivClVahbyxciumKoRJdFJjKhazKX6oVYfk72j7vP8Y
         Fv3RONyZgBUz91IDOLee0t/rlROU9fTDd0lt1qmPMTTSa9DnYft+zCabIiy7JB4d6qnq
         Wuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNAdvILvYHVHQZagSiHg7GRtC8IV2ThQrGptssEb6H4=;
        b=1/tW5l9mHl0o8JeBzATn5br0h+z2WVNKv+Ab6dQ2MRiFUX9qnu2V7XV1QGmeBLDj7r
         lz/XpFSFKXMcJ8tkrRQDF2iI0FkndXes2oec90a1BEBBEeAZXodHwRHNrmC/ItlO/BSW
         zPNDam5rvY12FvobhEyIo+bBqsfANhM/761pfHZxsZV8+pAaOcbDcwwEFiuowS8/bPSs
         UbOb7yku4p42HKVtPc7ffw3HG+NdGXrWVAUcsSvRzKNp6wFsgjoFK9PN1Ggh9iyPuzjn
         zusSo7DYNriMz7Vd3Hn1+HMc/6t6EoRVW/bY10SEQumYvx6mEeFPlgSF+yiUUVvRmlyz
         KSVQ==
X-Gm-Message-State: AFqh2krUjWuWafhKj9XlKo27U/+QEzKcUOLxEsOGH55bl8eYSP9YvDy/
        DKm+4dxAynFgBylQdwKdSqsqeec3AzJ+HA==
X-Google-Smtp-Source: AMrXdXv7tDPjC78sS5JnanGVcX8sZTHUqox3+NvQ+yh8CU0iyQbk+V0KoDXNU+kPdejcBNiqzuDjZA==
X-Received: by 2002:a17:906:4e09:b0:86f:2cc2:7029 with SMTP id z9-20020a1709064e0900b0086f2cc27029mr3808801eju.38.1673975498403;
        Tue, 17 Jan 2023 09:11:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/19] object-file.c: release the "tag" in check_tag()
Date:   Tue, 17 Jan 2023 18:11:20 +0100
Message-Id: <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

