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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C9C43462
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272B1613D2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhDTNBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhDTNBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18571C06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z6so2311190wmg.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/M4i6rhAP9xF7DRqb9aMW4u/EI83wFiKEMdqap/Dsk=;
        b=YMBxQjr0AjE1SIznz8oe/nuBhxeEoBW8Gvkxe1XkFVtA4XZTsQxCODOHgwYXjF1rCq
         TQ1+2P3zt7cFIUm6AtSJ7xjTlE+SOxtL0noUr8C0xS6fi3Foeqwy1dT2L2bFzAWPI+oK
         z0gT0NLBo2X/RSyo2rdgYQoWFTAW5OMfIrGeFDkahefdBM1qntfym904mpAR1An0zwlU
         tOQwvTtGg9ZHaVvA0g8DTZWAbZoeNNumTjOIyXcLP1nvGUjGL4pq2Es0ecKOcOum2WNf
         0HlwGlbr6fO/E3dBg7Pvo+wjD7bZSoTOYp3893Z5WdXnzVSYSUU5H02a8N0h/638gfTW
         ywgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/M4i6rhAP9xF7DRqb9aMW4u/EI83wFiKEMdqap/Dsk=;
        b=L+bXlxz7g/gzLpUToXwTOdXW5UWnUPKEKUpQcPNppljOSE0BxLTmBvnFQTNOlVuUoi
         pUM7WQigZ66hAxtPXJd0A5izU2L4OYjLxlLyPx6v6x9bPauwkpXk9iP/IrVaaC/8I1ON
         69ls2LOO2nA8+3ml3tLje4tSf1yyqCnf80d499aYv4/PwKyM6AhdAaPgKNkalN9B920p
         wqKiAQwPYoDSgoVTPmWOQyv1bs5BixA5j7Z2RBF5Vyjmo25oKn5VJoLFOjZH0sO5FgD5
         izZJPPiMyDuX8glvapFjVPeshe8ul+gmkihTyCSTE8jXscrc6S8PEI6ZEvwB1gdSjzgs
         0s1Q==
X-Gm-Message-State: AOAM5306muD2/qowVlAroW0LOg6zmONuYOAxC+qmK/WPREvbJvVqsuIA
        3EiTTW4cG/wAY7iq1N2z32nXK5ZS5yOD5w==
X-Google-Smtp-Source: ABdhPJyHtulo/J53xuhi0SKS3CxTL/w2fKAG4cn8ameey96127EPmiO5X9xcO8MYHJ7juhv0Qv4Glg==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr4314952wmq.128.1618923629523;
        Tue, 20 Apr 2021 06:00:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] object.c: remove "gently" argument to type_from_string_gently()
Date:   Tue, 20 Apr 2021 15:00:08 +0200
Message-Id: <patch-02.10-5fa3128127-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
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
 builtin/mktree.c |  2 +-
 fsck.c           |  2 +-
 object-file.c    |  2 +-
 object.c         | 12 +++++-------
 object.h         |  2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 67e11d8562..7d3f323209 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -117,7 +117,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	 * These should all agree.
 	 */
 	mode_type = object_type(mode);
-	type_type = type_from_string_gently(ptr, ntr - ptr, 1);
+	type_type = type_from_string_gently(ptr, ntr - ptr);
 	if (type_type < 0)
 		die("entry '%s' object type '%.*s' is invalid (our derived mode type is '%s')",
 			path, (int)(ntr - ptr), ptr, type_name(mode_type));
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
index d2f223dcef..4af4748edd 100644
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
index aae2a27e55..7028243c9a 100644
--- a/object.c
+++ b/object.c
@@ -35,7 +35,7 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, size_t len, int gentle)
+int type_from_string_gently(const char *str, size_t len)
 {
 	int i;
 
@@ -46,17 +46,15 @@ int type_from_string_gently(const char *str, size_t len, int gentle)
 		if (!strncmp(str, object_type_strings[i], len) &&
 		    object_type_strings[i][len] == '\0')
 			return i;
-
-	if (gentle)
-		return -1;
-
-	die(_("invalid object type \"%.*s\""), (int)len, str);
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
index f9d8f4d22b..470b3c1b86 100644
--- a/object.h
+++ b/object.h
@@ -93,7 +93,7 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, size_t, int gentle);
+int type_from_string_gently(const char *str, size_t len);
 int type_from_string(const char *str);
 
 /*
-- 
2.31.1.723.ga5d7868e4a

