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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDF7C4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7399E6501D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhCPCOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhCPCNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B99C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so6653218wrp.13
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=023LCVo440r+oBtTrpvVpIk/Ut6mbcsPsu/PyioFqIw=;
        b=Q5NRToYf3nXBil+oEnHyC4ctnVKcGBdjytnj1HzR3W/S9CtZS3Dtu0vhvB6JhA30oD
         ySWykXTR4Lf2xR7MDuNTbolNJ8vOPLAoHkU981rwQo4KrHtEhWoByejABPSwse0STwOz
         HLx2AFBLa4QWq+DqO1yKK49GzTJ/WgBKtWaC6FTMNuBvoWgCIHLkJXEG/tzdCdMeSt2S
         ZI1xQStqXxSfSEghO6GHGdHVm/WJNH4a4GbKAq11HLWf+9owuga4rCyApPjpPMHshMBg
         l8+YNt6QAPiSv2H1C92YLd2hILt84uv4EpkgSJ7fGz29JHlaDmIDizoHcS116vPyVZDk
         y/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=023LCVo440r+oBtTrpvVpIk/Ut6mbcsPsu/PyioFqIw=;
        b=HtpCCTBR5Lh2zOA1kAE2u+XaWkE8Bk5mPSmEyHd0iSYkavjziCwvKNqwCw2Twf+2YL
         k6VteJIDLsD1BtUd4FSulW9QjZQjBUm6a5UNQs+sU2hhhEOd5XyGLwz47ePvah7Zdbi/
         8iXrHBC0kB05sjK8+886UdA8WMWCayVdUvuDZGSfc169NTIwhPzPHfo07WWF6gDthGYO
         wpkkCGX5PbB2sxPjy0UocQmwMX+HZ4rCdZRXLSHtUaAePuB885fEfu1BEEKSfaUIuF+f
         lW+pWZVoSv7F5qMALp0NR/co1LJ+asW+XNaj/EBtfJkXWPFLYOIV0GcGtOvKC0To8Sqo
         N8Lw==
X-Gm-Message-State: AOAM5332tCEjJenok8eu53P2acSkK2XSfGwiqFGDkjvOXcRK7ZI7UsPI
        MuKsIF1N/o1NTkvl5SAGKWRe9z/QERs8Pg==
X-Google-Smtp-Source: ABdhPJzQajAXis2euuPJkVlM2oXL1wBfIk1glz2r5kNNPQ3OiyN58oonqj9osNz/QTKR2xkXNjNrDQ==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr2256804wrn.55.1615860818839;
        Mon, 15 Mar 2021 19:13:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:38 -0700 (PDT)
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
Subject: [PATCH v2 09/29] tree.h users: format argument lists in archive.c
Date:   Tue, 16 Mar 2021 03:12:52 +0100
Message-Id: <20210316021312.13927-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
index 77d1238df98..8ff97751c23 100644
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
2.31.0.rc2.211.g1d0b8788b3

