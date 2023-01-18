Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D5C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjARMrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjARMqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37838C93D
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z11so49357539ede.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNAdvILvYHVHQZagSiHg7GRtC8IV2ThQrGptssEb6H4=;
        b=TMU5xZl/M1l8ObwHQ6Dm1dStk0wfvKm/ApgQG7n+1aLqGWcymxPadsTJeb5NWEd90t
         UTjYY+amB6NXnvDgsJS51/VCdRO9J9fY9qDYMZpXAeSfP6XkxFTwf6t/N8C315q7kiMp
         wnGzEzoMXsjpBzlo0kh4pdS+lRc2A3mr+wm9lAV84SxYH2dr+bxuZLKqP/XkfOUV9PXL
         3DII2e/q1EZe7V4HzvL1CB7Z7DuxxBvZ//6PTPDX5zHeQ4GWGXOeAqT1jFjg4yZ0ThEz
         YXB5VmUIhiwiKJFtNS+PYFIqz/faCA9FT2TC1uJGEUmj2HdSPHKZQNFD3JM66xR3EFUA
         c+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNAdvILvYHVHQZagSiHg7GRtC8IV2ThQrGptssEb6H4=;
        b=U6SleUUCTZ3EOwNmVileCj7NRM8zGgx/gaAXjvO6/L55F4ojtATu/tZ+zrqFcH6vru
         a42SvKaKGzrWIigB4PxNGVOVKqPHlb8g81TIO7XSZWMBJxM/PUaG6xCceinN6cJaPPNn
         KgTdHnQFjiyGPOtyZyZKOzPlXmmPluzJ9P1m+47hJVedlGp0BneV5F/D6Hrn48bVuLQA
         oD+W6pprDQyIZTYW9JJX3yNn/gS3gTndB3u2Rap10WGvwF65E1LgvLmn3Pw3koMKJu2c
         Ud+ZExtLmY8tyzs37okWkLa/jEmMsId+4utAJeUKRqTYW+2glmUZ7PYSxMRQvy300IBT
         vh8Q==
X-Gm-Message-State: AFqh2koVCbu9/DH9F0lkTPIcbSyP4zG119Oyq2FOMLkc2f8X8eusE3dg
        /P5Ikf10F+YREH277tjeaoZUBtG9iXhkFQ==
X-Google-Smtp-Source: AMrXdXs1PtVuqqRUsR/3nlD3hwSH90YMBLId6wVH7mHUgdDqb3eSWSjjuj24RQCCeylOH/A0DoZ/hQ==
X-Received: by 2002:a05:6402:3894:b0:49e:45a8:1ac9 with SMTP id fd20-20020a056402389400b0049e45a81ac9mr3122177edb.24.1674043727862;
        Wed, 18 Jan 2023 04:08:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/19] object-file.c: release the "tag" in check_tag()
Date:   Wed, 18 Jan 2023 13:08:28 +0100
Message-Id: <patch-v5-15.19-d36ad1f818a-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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

