Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D39BC433E9
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AE8650DA
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhCFTfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhCFTfS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:35:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B21C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:35:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h98so6557693wrh.11
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmAkSq8IagvE7+NAwHoAE0V4jW/rRsqaPepw1V8Hrfk=;
        b=rogK9AoTnpsGlNnDBJNm5tf+R8o7LH+8oAlV2poqdXwK48b0fG7iXZoEE4M/vJ+aam
         DVQ3eYNZSfrYSPKinwQSGG8nUR+0KNbT6Ub7AYJYw5YggheTjkCZYlGT9BaGEWnsnl9l
         Bnxucb31wVZb38+LOjPYLZHu6Sxdsrytwzz31aqgakpRliHqp9V3M0mf/Ue0CxnKIzVg
         9I/Q7lR1RWPHpvW/pELCUIquvdDZWcnEVISUbdK6SdOIu400TPoaCLIum0YpOBwaEpxP
         DxrSTcdLRVv20j5smFhCXxG7xborSe3rwH2mtb88E+ucprYBC4eOAqUe5NicndvfHjxp
         Jajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmAkSq8IagvE7+NAwHoAE0V4jW/rRsqaPepw1V8Hrfk=;
        b=C66fjfUNEQ3O1DegUP8god3f0dUXN0hCZWNAMZ012Q4Df22G52lQ9HQY5XkMc5hdxB
         T0XSnYkMn24D4xHpP3bkjBIwOXHTaXD1LhrPIen8QRbinWBV8TgqhEpOHH5MMa3bNaTa
         PuaK2PeVCq6FtkWt1srqBcNxNIUS5e6pJhjiMBaqmKHzZ/OPV6OoAtxU1YbqV89sAkFm
         a1TUTl4QJhfZdzGHz4f8+Dz+lLbypF+qhVm+UeX0xjeplooac0c7JxZav3JFr0AcNUBQ
         MrwhQJX9eLZHc/mVQZ8+UMvBROpm0YzhFnuLm5S6XfdARTl8T6xFE3hSfi7xkGUe667o
         K1Jw==
X-Gm-Message-State: AOAM532PD4MjcQ8b0rVcp3JLnnSdfvTohHhaFVU/XB8Pv1dwdtbgUCgC
        4hsB2bs9jQ3SQ78bWKbksJo6oQeD/Y/5cA==
X-Google-Smtp-Source: ABdhPJwQolVj6ts8agfeTJ/U9yQt8TRp58IhN8qrNqgVTGR42O1A+6Ji9yQ26WH00V5kUF2dA/Ki5Q==
X-Received: by 2002:adf:f411:: with SMTP id g17mr15024386wro.22.1615059316970;
        Sat, 06 Mar 2021 11:35:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a5sm9951578wrs.35.2021.03.06.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:35:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] ls-files: refactor read_one_entry_quick() to use a strbuf
Date:   Sat,  6 Mar 2021 20:34:56 +0100
Message-Id: <20210306193458.20633-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the code in read_one_entry_quick() that used "base" and
"baselen" to just use the "buf" and "len" fields in the "base" strbuf
directly. Having the "basebuf" variable was a transitory step in
moving away from the old read_tree() in tree.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f5239437809..c0349a7b206 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -421,14 +421,12 @@ static int get_common_prefix_len(const char *common_prefix)
 }
 
 static int read_one_entry_quick(const struct object_id *oid,
-				struct strbuf *basebuf,
+				struct strbuf *base,
 				const char *pathname,
 				unsigned mode,
 				int stage, void *context)
 {
 	struct index_state *istate = context;
-	const char *base = basebuf->buf;
-	const int baselen = basebuf->len;
 	int len;
 	struct cache_entry *ce;
 
@@ -436,13 +434,13 @@ static int read_one_entry_quick(const struct object_id *oid,
 		return READ_TREE_RECURSIVE;
 
 	len = strlen(pathname);
-	ce = make_empty_cache_entry(istate, baselen + len);
+	ce = make_empty_cache_entry(istate, base->len + len);
 
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(stage);
-	ce->ce_namelen = baselen + len;
-	memcpy(ce->name, base, baselen);
-	memcpy(ce->name + baselen, pathname, len+1);
+	ce->ce_namelen = base->len + len;
+	memcpy(ce->name, base->buf, base->len);
+	memcpy(ce->name + base->len, pathname, len+1);
 	oidcpy(&ce->oid, oid);
 	return add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
 }
-- 
2.31.0.rc0.126.g04f22c5b82

