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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27593C4321A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032E66522F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhCHPHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhCHPHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13AC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so4006811wmd.5
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwskF67xloNuhMklsYoycBl3qw5F4keeyG+IkH/K5r8=;
        b=iLoupZSY/tQWbXuj9/NmDTatV90BYUygHTD1oP/xB/hstthPYPGKs7muWPWlEtBE3G
         H7hexc0FbbB1NGYGTh+xgmHel41OyBGwGiKDUTNR6ZlXADNojuT1mys86yDNTL6zd7WX
         6moYke65kHD57/ccTkhljUhkWLhdWt9d3H8PZc8w+sdIyus6SznzKAt6emqIAhoruC0+
         Od3l/gMcpVQUnSkhb2bo6S9xVGojpU1s1wxw6wuFdny/BxTBvJLIUkhBGXUirq0n5C5l
         YnBZLNxZcCV9amj2Q7vcLnO2Kf1PEhMlLJLELsdezCERQ9LBiCzyqU46zACymnXpHZyF
         n+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwskF67xloNuhMklsYoycBl3qw5F4keeyG+IkH/K5r8=;
        b=tcJ1LzW97YvNnfB0PkK9Ryj/N+oUvRQ/FTEh+TGVUTtvSukLT+prCfVw8T5YoMbELn
         ZS8nhbuHkOjsK5Qfqu/ncMCrsIE1B1iYnaPKBlA9PBUYR9MpQxs3ihAlTOy7L/3zZ/Vl
         xtldDrVY3j31pi3eA/clzlwlOV/gcE5HrwDgIx7Pk3zGBeSz/6DkU5gSYcVEJ9e+Yqmq
         jwNZYwrpdo/S60DOoRLNdl8qO/+iBR/mfAhTzvnRMGerCT5vuA8m5R01QeyS3WE5SXoX
         63ME6WfL5BJD4fR73QfuM8IKkntuFceHRJsTw2kR2fO3xkUGXhv3Lf6Bj/aLRph6DBm1
         shIg==
X-Gm-Message-State: AOAM532wInoCu7et3WwPIubmQQSrlCaBioU6JTPHmRDTt68ZEXM68It1
        DXC9uwXJwl7nN0R5kt+A0B0Ogn10S5qDHA==
X-Google-Smtp-Source: ABdhPJzmLXRrIEyXRPAyzT6amdD5Hvaso1wDCI3CpfZ3wBVKbRaxmbWz+KxZ5sKbz1x1p2jHoQ9+hQ==
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr23178865wmd.129.1615216036416;
        Mon, 08 Mar 2021 07:07:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:15 -0800 (PST)
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
Subject: [PATCH 09/30] tree.h users: format argument lists in archive.c
Date:   Mon,  8 Mar 2021 16:06:29 +0100
Message-Id: <20210308150650.18626-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
 archive.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/archive.c b/archive.c
index db69a8acadb..e245c0d5a54 100644
--- a/archive.c
+++ b/archive.c
@@ -140,7 +140,8 @@ static int check_attr_export_subst(const struct attr_check *check)
 static int write_archive_entry(const struct object_id *oid, const char *base,
 			       int baselen, const char *filename,
 			       unsigned mode,
-			       int stage, void *context)
+			       int stage,
+			       void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct archiver_context *c = context;
@@ -197,8 +198,10 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
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
@@ -224,8 +227,10 @@ static int write_directory(struct archiver_context *c)
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
@@ -259,14 +264,18 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
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
2.31.0.rc0.126.g04f22c5b82

