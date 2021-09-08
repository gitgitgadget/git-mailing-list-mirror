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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0197C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFF561139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbhIHAjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbhIHAjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:39:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BEFC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:38:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i28so609970wrb.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ4JXp0A1fVqKEUVHsqJwZj+jRLtKHWVH5iYiFBxZIc=;
        b=Sk8BHz6f6HytEbPDB2WQkGIACRkEN6OhbE7njPaeRmj/D4zsGW4uXJcrVlsvqkjP8y
         7fuEEYG5iVabNcC7C2EERVa1wvVR1FzuX0KmdM2C/Yw4GtN2wJZNRWu1K+WaaOhhkddi
         QAxlhKU0+44U95r44qhGrxj23iFNy61C0l+lCaPcuUx0T3D2278zaylqMB1nQmn/ocY9
         5BgD/mqNfIF0/zDbgn1WdpPszDMRunaWNZKlvULETetvuh8GBnQBsS/OY8b6/Z58F36k
         8ipySc8G0iS71VpJ1bBOhMA6OJ8mVGQBE64L3LOxnKUoD+WK+asLrcEK51jG0Xwwanmw
         Q8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ4JXp0A1fVqKEUVHsqJwZj+jRLtKHWVH5iYiFBxZIc=;
        b=WxyHTexLfaFc625l9oi0b9+uHTSitH34XQkRLHZH5jqsj2kGAuRbrvD7cDh/1onT3o
         58qtS1M6SoXkm9u/CEX3HXuO9EhXgkKS3JKyCS/kuPQzKmQsd1t7ZLzmyQrYrink9KiI
         jKOXzNceNbe6NLD0FMOc3qvI0w+ZXHDqi/iphMSrljhrjlOWoNRnIBNEYWaPB83CgPUP
         xPeQEDwDi6IinktFsVR+HtTTF0ZrZPpcXUllA0OmLW7l7xuZPB1dJj3xDelNbz2gIDLp
         ijBC5IXHUIrQQ/0vogiP8nXBXPK6U0pcbkGfdDlReMF1+ggIVDP2VDVfxFXZyXtKI7WT
         +Z4w==
X-Gm-Message-State: AOAM5302wfvHftXPdZsPngsGIOUq0PzYSyEJAcrB8mx8XRyYxbw+5K0j
        LQ5y65wdRvXX6GctnPLm/2Rq/RVOWhympA==
X-Google-Smtp-Source: ABdhPJwwqzdafMZSGLbnog0E1KVsDu0iAh2Kyy0ZBfOdm8vaoNCC4LL7Gk06OU0tQlunORPAQW70Kg==
X-Received: by 2002:adf:b745:: with SMTP id n5mr974480wre.338.1631061513270;
        Tue, 07 Sep 2021 17:38:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm548962wmf.4.2021.09.07.17.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 17:38:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] pack-write: rename *.idx file into place last (really!)
Date:   Wed,  8 Sep 2021 02:38:28 +0200
Message-Id: <patch-v2-4.4-70f4a9767d-20210908T003631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.gea1b153a43c
In-Reply-To: <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
References: <cover.1630461918.git.me@ttaylorr.com> <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up a preceding commit (pack-write.c: rename `.idx` file into
place last, 2021-08-16)[1] and rename the *.idx file in-place after we
write the *.bitmap. The preceding commit fixed the issue of *.idx
being written before *.rev files, but did not do so for *.idx files.

See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21)
for commentary at the time when *.bitmap was implemented about how
those files are written out, nothing in that commit contradicts what's
being done here.

Note that the referenced earlier commit[1] is overly optimistic about
"clos[ing the] race", i.e. yes we'll now write the files in the right
order, but we might still race due to our sloppy use of fsync(). See
the thread at [2] for a rabbit hole of various discussions about
filesystem races in the face of doing and not doing fsync() (and if
doing fsync(), not doing it properly).

1. https://lore.kernel.org/git/a6a4d2154e83d41c10986c5f455279ab249a910c.1630461918.git.me@ttaylorr.com/
2. https://lore.kernel.org/git/8735qgkvv1.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 33567aaa74..396240c25a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1249,7 +1249,6 @@ static void write_pack_file(void)
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, hash, &idx_tmp_name);
-			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				struct strbuf sb = STRBUF_INIT;
@@ -1268,6 +1267,8 @@ static void write_pack_file(void)
 				strbuf_release(&sb);
 			}
 
+			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
+
 			free(idx_tmp_name);
 			strbuf_release(&tmpname);
 			free(pack_tmp_name);
-- 
2.33.0.819.gea1b153a43c

