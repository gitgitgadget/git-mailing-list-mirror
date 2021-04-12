Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF8C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BCBC61278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbhDLRQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbhDLRQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808BCC061349
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so6639779wmg.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+EukVLz4qinhFYuKPec25yX0wl/TKSwx1J6yw2DekE=;
        b=Wq0NcN9EFixNvQy73oIYZt0nmxkJLEM8bP1WluE4XZ4QVb5IUfkaB56lCK7ZxKx/dP
         VGLYGKVS7eQTWA52qxyKqMDF5svFp67DcHbDK4iOv8wBE5oi8Jh1DKeKdbJiYnSgFavH
         zi95euYjewd0lm36yiNaWW/nSo3u5+ZrRimGVCsjCtDRcMgBWnj/GrgvbIah6/t5M8yI
         aXHigzEJHI8ncVR02Er/Jfy0+YwNnlkqg8MbOlbAwr0hkobpSy4e1+fmdFIO0ltTQ8G7
         kka+cFJE1o9Gu9c5A9nQXGM6CyTtLCAIJCgea0mABHp/j14pcZNS5M4hdRb333Cy0YoP
         m2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+EukVLz4qinhFYuKPec25yX0wl/TKSwx1J6yw2DekE=;
        b=i+Xnegw9DSXkehkhF9W/W0RVIigy2h6eC3l04DIhQWw8xFqHgxoYrWuW1CeXa3DvMW
         /E5CDi/+714ZQkItgwJYVSOso+/iYIe/mgan10JSjxjX2sdhBHg8zivMlDJGE7TYmjGP
         bt9uHoTjpWGvoNtzQUOKlY6WiyQPurxua/bxuvGpVYR+Y4gF5B5QEup/J3eiVwERPqYo
         4TIxj2WxMg1KSKDlNG5TdTxLcaPBPXZz8kysFigI/6HXbYwHtLJlmVgHzk2yrGsdOb8j
         5Vb12t8J2sOUJmt1CBok0u7d8fGaqUP+R0F5dzRd7KZBYD0B62glOpCBaCOcTcTC6tIO
         ffkQ==
X-Gm-Message-State: AOAM530xkiykS09wdYOQ9k6S+76UlwfeIz9MAPhrujzryuz9DTP/RU3R
        LtTXo1Ot9oa1lvgIo3z08Caw5G38zwm6zQ==
X-Google-Smtp-Source: ABdhPJzwMWaqRzF3YuWdMv+ntXR3YencQHXm4UcxHMbvFSSNlUXEoQq/81TEjNFR+elZ8QS54BQzgw==
X-Received: by 2002:a1c:dc41:: with SMTP id t62mr184421wmg.14.1618247748796;
        Mon, 12 Apr 2021 10:15:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/22] pickaxe -S: support content with NULs under --pickaxe-regex
Date:   Mon, 12 Apr 2021 19:15:21 +0200
Message-Id: <patch-14.22-a86032792b6-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in the matching routine powering -S<rx> --pickaxe-regex so
that we won't abort early on content that has NULs in it.

We've had a hard requirement on REG_STARTEND since 2f8952250a8 (regex:
add regexec_buf() that can work on a non NUL-terminated string,
2016-09-21), but this sanity check dates back to d01d8c67828 (Support
for pickaxe matching regular expressions, 2006-03-29).

It wasn't needed anymore, and as the now-passing test shows, actively
getting in our way. Since we always require REG_STARTEND support we do
not need to stop at NULs. If we are dealing with a haystack with NUL
in it. The needle may be behind that NUL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c     | 4 ++--
 t/t4209-log-pickaxe.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 88b6ca840f6..be0dd683b63 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -78,12 +78,12 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 		regmatch_t regmatch;
 		int flags = 0;
 
-		while (sz && *data &&
+		while (sz &&
 		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
 			sz -= regmatch.rm_eo;
-			if (sz && *data && regmatch.rm_so == regmatch.rm_eo) {
+			if (sz && regmatch.rm_so == regmatch.rm_eo) {
 				data++;
 				sz--;
 			}
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 3f9aad0fdb0..75795d0b492 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -215,4 +215,12 @@ test_expect_success 'log -S looks into binary files' '
 	test_cmp log full-log
 '
 
+test_expect_success 'log -S --pickaxe-regex looks into binary files' '
+	git -C GS-bin-txt log --pickaxe-regex -Sa >log &&
+	test_cmp log full-log &&
+
+	git -C GS-bin-txt log --pickaxe-regex -S"[a]" >log &&
+	test_cmp log full-log
+'
+
 test_done
-- 
2.31.1.639.g3d04783866f

