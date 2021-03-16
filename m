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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9994C4321A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C422164F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhCPP72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbhCPP6v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3294DC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so1759250wmi.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeGrtTvFCx1XRsD56Em6f/tht0xXub02J+kDYDfwAlU=;
        b=eeYpmSgZ8wR+4+z3U6DK3VZqoz9mgkhcyeaFSU/CKF5rQSYhkOtkY+0Bzw7+cDg+bO
         S2Uir7COGke8Q1m52qd/VkdZ9jycZv0Lr57pibOYS+asBGJqMFR/pmDO6dt5SfPBt6Ul
         JCfeOsHlnOIqm41B/wWkP/uZCuVqw1/Yl7W0Lxw3SaK1CHpEwqeUk4Zp44TIzPp60N/Z
         XOM1U6p17SeUj8PtED/CxR0BUFGyIOYcLPczGSbZMjHk6xEttlgJK/dn4iW1sLEL0n31
         Ftt9F6QsFY3/c2q5UrBf1cZA64WJ+79eD4qtO72e9ZXfd6Rx2+uq0z744iv6mIBvWTAD
         tikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeGrtTvFCx1XRsD56Em6f/tht0xXub02J+kDYDfwAlU=;
        b=s1JtJjWvQ98YyymyDOvuGVUP3lzPE43RXAlervgCxF8y+8tY8ndXDQAckkwzd7vjqe
         95QrtAos4Hb1qfIY/E/mllYlyVGWEiWQ0EQowTOeD6PiR7Gyl2zudjcDPy1nlShna4qQ
         b/KUCrSbKTVymMa/A1/N3I53W/2t+MawC0afA17NloGcQz2tqFQyCccKAQsAnug/RqMQ
         mW/RE+75Woq94SGHq5xNm6MixlBpr2HpIib5jnUygixQaxq78CfKg+oSiwlzn/YgvB8H
         zmrB87scOOCgC02YgtmapiWdmCM6IELYHQdg0gU2sxWzVUlKV3aTcNhtEHdxRwfNY75I
         QH3A==
X-Gm-Message-State: AOAM531T7vnUsiqxoJxz9Ogfo5hjyFs6cMo5Ne2F6IrQSSWgJLmtXtvv
        DhSp3XmfAwFMkroQ9q6l9Gbvi+xvoymIEg==
X-Google-Smtp-Source: ABdhPJxRjieDQCaArXE9EQtiqLbr/BTSUB6+T7RPWZzjBwWuLGtTFNUBsa9LztonaUZ9eyj3WR5TjQ==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr336251wme.20.1615910328674;
        Tue, 16 Mar 2021 08:58:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/32] tree.h users: format argument lists in archive.c
Date:   Tue, 16 Mar 2021 16:58:09 +0100
Message-Id: <20210316155829.31242-13-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-indent and re-flow the argument lists archive.c has downstream of
its read_tree_recursive() call to make subsequent commits easier to
read, as I only expect to be modifying the "stage" and "mode" lines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index 77d1238df9..8ff97751c2 100644
--- a/archive.c
+++ b/archive.c
@@ -198,8 +198,10 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 }
 
 static void queue_directory(const unsigned char *sha1,
-		struct strbuf *base, const char *filename,
-		unsigned mode, int stage, struct archiver_context *c)
+			    struct strbuf *base, const char *filename,
+			    unsigned mode,
+			    int stage,
+			    struct archiver_context *c)
 {
 	struct directory *d;
 	size_t len = st_add4(base->len, 1, strlen(filename), 1);
@@ -225,8 +227,10 @@ static int write_directory(struct archiver_context *c)
 	ret =
 		write_directory(c) ||
 		write_archive_entry(&d->oid, d->path, d->baselen,
-				    d->path + d->baselen, d->mode,
-				    d->stage, c) != READ_TREE_RECURSIVE;
+				    d->path + d->baselen,
+				    d->mode,
+				    d->stage,
+				    c) != READ_TREE_RECURSIVE;
 	free(d);
 	return ret ? -1 : 0;
 }
@@ -260,14 +264,18 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		if (check_attr_export_ignore(check))
 			return 0;
 		queue_directory(oid->hash, base, filename,
-				mode, stage, c);
+				mode,
+				stage,
+				c);
 		return READ_TREE_RECURSIVE;
 	}
 
 	if (write_directory(c))
 		return -1;
-	return write_archive_entry(oid, base->buf, base->len, filename, mode,
-				   stage, context);
+	return write_archive_entry(oid, base->buf, base->len, filename,
+				   mode,
+				   stage,
+				   context);
 }
 
 struct extra_file_info {
-- 
2.31.0.256.gf0ddda3145

