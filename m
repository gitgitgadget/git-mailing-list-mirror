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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7203C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF1E65023
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhCPCNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhCPCNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC8C061756
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so554686wmj.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKBnouamoZKDLxwb26iJhvZwaifN+S5prk789Jolf84=;
        b=rBxXtms1m/3O70fmhiuehzWMeTl+b63TdXT6iD5HXF1jfYYMU19v4wz+8HWiGesicQ
         S5BFeEDsidLctsuDItfU2p3O/nD/zd4P9niSq49UFG6+tdTYyumkHtD6Xv9oGlXg1xaA
         JlD71LpRGklAtGktXB4DAshWjRVWyYJuVrPa9M2OjGnPPWXMLMLF4WoUANNuXqp/H/a/
         l67hRPPbh9jSOVtyiG1xPWyImUfCrbzyKRfX4raf3yujOaxHW7LOVFwhdm2FPAHda+0R
         UNaX3JNdDz7QuzYvLSSV9l7inTvPmowLv/vVYsANBcPl2x2mWtCxW7sndWXX8kO1VhDH
         7GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKBnouamoZKDLxwb26iJhvZwaifN+S5prk789Jolf84=;
        b=ButeNkVi5M65+OZdhpH2KcJnJRrbgCj6gex/TSJi76HvzFfrClpxL81PKaJ7QMsEvx
         1itrQXypf3hEnVipqKf07QVRQBgCt8wgFB4IFdwfwEZ74Jizz7K+VU00OKhmstr790g0
         CXSLxl2YSNIfPSVoo07uuWAKWw1BAjIDYbNlcrao9i+w4TSaspgTN8XXaoQt/Yuar9Xv
         KUO1voMwtHBJa409iJV9igGC/bSvLA748sRR9/K0M9tfAwFB+qoC45xDvdQNx80tJeNR
         w0rlms0kgtPMUCs9gSfplO0cuUjcptfWIh+8c9O26q2Ba8Zx9FpFVtjauh6iIb1Or3qM
         v6lw==
X-Gm-Message-State: AOAM532COVNOoYqGouxAeYUV+Injf1hdwHLEguwZQifQ7R57tBM0xWuk
        YV2SrakAqY53EBWvtiisPAPOi2xd9syJzA==
X-Google-Smtp-Source: ABdhPJxnLUe5sZoEoqLll1vnSN/eQsEjpEdj8lGrBLognqJzcaDqSzxVxWPNFiUPTZNWzfK2F+pPhw==
X-Received: by 2002:a1c:2587:: with SMTP id l129mr2202309wml.135.1615860819619;
        Mon, 15 Mar 2021 19:13:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:39 -0700 (PDT)
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
Subject: [PATCH v2 10/29] archive: get rid of 'stage' parameter
Date:   Tue, 16 Mar 2021 03:12:53 +0100
Message-Id: <20210316021312.13927-11-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop passing the "stage" parameter around in archive.c. This parameter
existed because the read_tree_recursive() function used to provide it,
but no longer does. See my in-flight commit to remove it. (tree.h API:
remove "stage" parameter from read_tree_recursive(), 2021-03-06).

As can be seen in 562e25abea9 (archive: centralize archive entry
writing, 2008-07-14) and ed22b4173bd (archive: support filtering paths
with glob, 2014-09-21) it was never used by this code. We simply added
it as a boilerplate, and then later added it to our own "directory
"struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/archive.c b/archive.c
index 8ff97751c23..529623167c9 100644
--- a/archive.c
+++ b/archive.c
@@ -107,7 +107,6 @@ struct directory {
 	struct object_id oid;
 	int baselen, len;
 	unsigned mode;
-	int stage;
 	char path[FLEX_ARRAY];
 };
 
@@ -140,7 +139,6 @@ static int check_attr_export_subst(const struct attr_check *check)
 static int write_archive_entry(const struct object_id *oid, const char *base,
 			       int baselen, const char *filename,
 			       unsigned mode,
-			       int stage,
 			       void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
@@ -200,7 +198,6 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 static void queue_directory(const unsigned char *sha1,
 			    struct strbuf *base, const char *filename,
 			    unsigned mode,
-			    int stage,
 			    struct archiver_context *c)
 {
 	struct directory *d;
@@ -209,7 +206,6 @@ static void queue_directory(const unsigned char *sha1,
 	d->up	   = c->bottom;
 	d->baselen = base->len;
 	d->mode	   = mode;
-	d->stage   = stage;
 	c->bottom  = d;
 	d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
 	hashcpy(d->oid.hash, sha1);
@@ -229,7 +225,6 @@ static int write_directory(struct archiver_context *c)
 		write_archive_entry(&d->oid, d->path, d->baselen,
 				    d->path + d->baselen,
 				    d->mode,
-				    d->stage,
 				    c) != READ_TREE_RECURSIVE;
 	free(d);
 	return ret ? -1 : 0;
@@ -241,7 +236,6 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 					void *context)
 {
 	struct archiver_context *c = context;
-	int stage = 0;
 
 	while (c->bottom &&
 	       !(base->len >= c->bottom->len &&
@@ -265,7 +259,6 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 			return 0;
 		queue_directory(oid->hash, base, filename,
 				mode,
-				stage,
 				c);
 		return READ_TREE_RECURSIVE;
 	}
@@ -274,7 +267,6 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		return -1;
 	return write_archive_entry(oid, base->buf, base->len, filename,
 				   mode,
-				   stage,
 				   context);
 }
 
-- 
2.31.0.rc2.211.g1d0b8788b3

