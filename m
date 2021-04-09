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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6ACC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2FB611AD
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhDIIdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhDIIdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:33:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D7C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:33:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so7328126ejz.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDotJrZZgFC4YPU7PpreSU1ik8kDICD7N9fk6bSgolc=;
        b=gTWaEX3Nskfh2+xKYD0LTVg21e2oCMBg5no2ozQxOc2XUvNDETICOrBdQynebn7Qpm
         Q3a0P7M4uXzz4lddF1vpFCFa0hAez4kKPF0JBIglCnhGo2/nthW+ldcLeYmv/bl/OdBl
         b+A5hBurJEjrfWHJm8AQwYuOxu7PtxoINdbnBAgQEnYjHShxYA0hQHbOMi/lCT9ixDWh
         gp+S9BWk7zP994bJWKncoCvJk7VEKyR0eSAtfSJx57saUMfYgrMMwiSj0tIdB5InpS8Z
         Lqov3FCb8z18SNW/uFhTYgCBoE/fQoEtJTkuuIM765W8BXjcbgB6gddcy5ru2JfIcRf1
         W4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDotJrZZgFC4YPU7PpreSU1ik8kDICD7N9fk6bSgolc=;
        b=FeXhPh+r10GDHUMaoNQtrzCFPNYjj9Mm6iaGfePeILiZJnKhopCy3Z4VGhgzJMZcSF
         D30f1w+5YsaELGBplnuh9aufDx5JsWuhXibDeLsM7UVHMy2em6Rn4GNkR+FtwcFRH34E
         6E77xKWqtWKPwlXKXrY6zHjAoDkM04uXEswZVi732Y4LmJL9OAkpvYPmHx7kfQzwTAVt
         Sdser8GVlFXMXO9xxe9bkBmW2TvzGeFUZBo169Od8/3Yn5oC+fDH74S0ibc0B+WzYXLs
         5niJktLBUNNN5ofLdrtiffUOmLzvMaY1npj7979Z8cLPWL5jWmIgBK7ChotPufJtx3MY
         MMKg==
X-Gm-Message-State: AOAM530W75lE1HxiX5EvgOSmsoKSy6EO7APqiqYQjt7EJ1iAp2Hwxp1S
        1JPT0SxVzLQGzmEjicltJFJ0wyYxJIoNnQ==
X-Google-Smtp-Source: ABdhPJycDXLdkqYeZO4fYAdh9cnIIbigWX+jBgNTCCpMM4UNrWpZLNCvL9IA9nZD3IVdlGdHmOkfKA==
X-Received: by 2002:a17:907:c28:: with SMTP id ga40mr14982053ejc.444.1617957184837;
        Fri, 09 Apr 2021 01:33:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n17sm1016707edq.32.2021.04.09.01.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:33:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] object.c: remove "gently" argument to type_from_string_gently()
Date:   Fri,  9 Apr 2021 10:32:50 +0200
Message-Id: <patch-2.6-daed40c479-20210409T082935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of the "gently" argument to type_from_string_gently() to make
it consistent with most other *_gently() functions. It's already a
"gentle" function, it shouldn't need a boolean argument telling it to
be gentle.

The reason it had a "gentle" parameter was because until the preceding
commit "type_from_string()" was a macro resolving to
"type_from_string_gently()", it's now a function.

This refactoring of adding a third parameter was done in
fe8e3b71805 (Refactor type_from_string() to allow continuing after
detecting an error, 2014-09-10) in preparation for its use in
fsck.c.

Simplifying this means we can move the die() into the simpler
type_from_string() function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c        |  2 +-
 object-file.c |  2 +-
 object.c      | 12 +++++-------
 object.h      |  2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fsck.c b/fsck.c
index f5ed6a2635..8dda548c38 100644
--- a/fsck.c
+++ b/fsck.c
@@ -875,7 +875,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
-	*tagged_type = type_from_string_gently(buffer, eol - buffer, 1);
+	*tagged_type = type_from_string_gently(buffer, eol - buffer);
 	if (*tagged_type < 0)
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
diff --git a/object-file.c b/object-file.c
index 624af408cd..b7c26b6735 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1314,7 +1314,7 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 		type_len++;
 	}
 
-	type = type_from_string_gently(type_buf, type_len, 1);
+	type = type_from_string_gently(type_buf, type_len);
 	if (oi->type_name)
 		strbuf_add(oi->type_name, type_buf, type_len);
 	/*
diff --git a/object.c b/object.c
index 88de01e5ac..5477abc97c 100644
--- a/object.c
+++ b/object.c
@@ -35,7 +35,7 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, ssize_t len, int gentle)
+int type_from_string_gently(const char *str, ssize_t len)
 {
 	int i;
 
@@ -43,17 +43,15 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 		if (!strncmp(str, object_type_strings[i], len) &&
 		    object_type_strings[i][len] == '\0')
 			return i;
-
-	if (gentle)
-		return -1;
-
-	die(_("invalid object type \"%s\""), str);
+	return -1;
 }
 
 int type_from_string(const char *str)
 {
 	size_t len = strlen(str);
-	int ret = type_from_string_gently(str, len, 0);
+	int ret = type_from_string_gently(str, len);
+	if (ret < 0)
+		die(_("invalid object type \"%s\""), str);
 	return ret;
 }
 
diff --git a/object.h b/object.h
index 3ab3eb193d..ffdc129830 100644
--- a/object.h
+++ b/object.h
@@ -93,7 +93,7 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, ssize_t, int gentle);
+int type_from_string_gently(const char *str, ssize_t len);
 int type_from_string(const char *str);
 
 /*
-- 
2.31.1.592.gdf54ba9003

