Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3540E82CCE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjI0T4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjI0T4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:07 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F651A8
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so345792439f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844561; x=1696449361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkazeKVM1RtP9Z70mx3eJTcTbac/plstEPcnoAezcv4=;
        b=CqNlzW8ZWz3V+7uyb9MjjtFfIUIBy8gVyc5QIofae8VHUNVS+MN8lJzyZFj8yCkoT2
         iDdz8Zd5dZUAMNhKKiuuM+lG5YkC/deIcpEZIZzNrSl+ElksIYBmjsS1LRh0Fugofrtn
         OeQ54NtYAG5Dpa01wIeOMxqnNP30TEO2xAvq2tMlWKwAW1BQ0qwXyv/E5+lSQCeWTVET
         NekitbqY6zGI1wPaBF+taE3NbkCRVQ5E2QxazNG+/lXy1o/T9kcmKKdwBUEGHSnrdJEp
         ci6XWy6wN26yBKWuy6UZwkxNcMAGrx8DbqM4lNvGVkyiqKREcP2emuY4DP+Xa8elf2Fm
         317A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844561; x=1696449361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkazeKVM1RtP9Z70mx3eJTcTbac/plstEPcnoAezcv4=;
        b=fd5eEB7knNo/clvZcArIkTOAFq5WMTXZ7HXcmn6Z34GwHl72z0S9XI2NR1+U73gvWy
         m+72u3wIvRjW1NvR5fg6BBPitM+Mgc8PCr9z9rcqP3h5F4JZuSbewhDrRTtk33COM4he
         AQ/N+wLwTGN85/ty9c0Z3bgRvkRdc9Mptugbgs6gBGWILa2GsFFGgW1qT6TsP7EM7m5I
         ltcgqz5/4nIs77X3iviRamXdRwVaRvCZPITykoqgV80mIpbv688SqPHjYUeSEdHxyGXY
         8kmTfiM+SlOzI/HIMt3ZDli88ksBfJAh5GWRM2BDas9KAvef2NQNHR7OZwMHSgZW7wbQ
         nArg==
X-Gm-Message-State: AOJu0YyOVVkyHyRmShSgYs46p5H6QG2WPZR2ymSGPtNF0CUcBAFNj2FQ
        S1MteQm5dOluWpWknk6mmYY=
X-Google-Smtp-Source: AGHT+IE7J/P/XkNeI/Xa6OOD8qbn/3pl5ygyfNPL9ZNV1vDBKQKOyd4MygSxmB4mY0uFSEiBZb6NtQ==
X-Received: by 2002:a6b:fe14:0:b0:787:4b5f:b6cf with SMTP id x20-20020a6bfe14000000b007874b5fb6cfmr3115763ioh.5.1695844561172;
        Wed, 27 Sep 2023 12:56:01 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:00 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 14/30] object: Factor out parse_mode out of fast-import and tree-walk into in object.h
Date:   Wed, 27 Sep 2023 14:55:21 -0500
Message-Id: <20230927195537.1682-14-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

builtin/fast-import.c and tree-walk.c have almost identical version of
get_mode.  The two functions started out the same but have diverged
slightly.  The version in fast-import changed mode to a uint16_t to
save memory.  The version in tree-walk started erroring if no mode was
present.

As far as I can tell both of these changes are valid for both of the
callers, so add the both changes and place the common parsing helper
in object.h

Rename the helper from get_mode to parse_mode so it does not
conflict with another helper named get_mode in diff-no-index.c

This will be used shortly in a new helper decode_tree_entry_raw
which is used to compute cmpatibility objects as part of
the sha256 transition.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/fast-import.c | 18 ++----------------
 object.h              | 18 ++++++++++++++++++
 tree-walk.c           | 22 +++-------------------
 3 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 4dbb10aff3da..2c645fcfbe3f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1235,20 +1235,6 @@ static void *gfi_unpack_entry(
 	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep);
 }
 
-static const char *get_mode(const char *str, uint16_t *modep)
-{
-	unsigned char c;
-	uint16_t mode = 0;
-
-	while ((c = *str++) != ' ') {
-		if (c < '0' || c > '7')
-			return NULL;
-		mode = (mode << 3) + (c - '0');
-	}
-	*modep = mode;
-	return str;
-}
-
 static void load_tree(struct tree_entry *root)
 {
 	struct object_id *oid = &root->versions[1].oid;
@@ -1286,7 +1272,7 @@ static void load_tree(struct tree_entry *root)
 		t->entries[t->entry_count++] = e;
 
 		e->tree = NULL;
-		c = get_mode(c, &e->versions[1].mode);
+		c = parse_mode(c, &e->versions[1].mode);
 		if (!c)
 			die("Corrupt mode in %s", oid_to_hex(oid));
 		e->versions[0].mode = e->versions[1].mode;
@@ -2275,7 +2261,7 @@ static void file_change_m(const char *p, struct branch *b)
 	struct object_id oid;
 	uint16_t mode, inline_data = 0;
 
-	p = get_mode(p, &mode);
+	p = parse_mode(p, &mode);
 	if (!p)
 		die("Corrupt mode: %s", command_buf.buf);
 	switch (mode) {
diff --git a/object.h b/object.h
index 114d45954d08..70c8d4ae63dc 100644
--- a/object.h
+++ b/object.h
@@ -190,6 +190,24 @@ void *create_object(struct repository *r, const struct object_id *oid, void *obj
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
+
+static inline const char *parse_mode(const char *str, uint16_t *modep)
+{
+	unsigned char c;
+	unsigned int mode = 0;
+
+	if (*str == ' ')
+		return NULL;
+
+	while ((c = *str++) != ' ') {
+		if (c < '0' || c > '7')
+			return NULL;
+		mode = (mode << 3) + (c - '0');
+	}
+	*modep = mode;
+	return str;
+}
+
 /*
  * Returns the object, having parsed it to find out what it is.
  *
diff --git a/tree-walk.c b/tree-walk.c
index 29ead71be173..3af50a01c2c7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -10,27 +10,11 @@
 #include "pathspec.h"
 #include "json-writer.h"
 
-static const char *get_mode(const char *str, unsigned int *modep)
-{
-	unsigned char c;
-	unsigned int mode = 0;
-
-	if (*str == ' ')
-		return NULL;
-
-	while ((c = *str++) != ' ') {
-		if (c < '0' || c > '7')
-			return NULL;
-		mode = (mode << 3) + (c - '0');
-	}
-	*modep = mode;
-	return str;
-}
-
 static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
 {
 	const char *path;
-	unsigned int mode, len;
+	unsigned int len;
+	uint16_t mode;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
@@ -38,7 +22,7 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 		return -1;
 	}
 
-	path = get_mode(buf, &mode);
+	path = parse_mode(buf, &mode);
 	if (!path) {
 		strbuf_addstr(err, _("malformed mode in tree entry"));
 		return -1;
-- 
2.41.0

