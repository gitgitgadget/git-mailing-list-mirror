Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700DCE784A8
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjJBClQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjJBClA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D1FE9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a26fd82847so105004739f.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214451; x=1696819251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkazeKVM1RtP9Z70mx3eJTcTbac/plstEPcnoAezcv4=;
        b=Yq8wFHiq4YgZ54tZM4WEvjxhvZs8wI9D7O4kY4sQ8VZNJQuLHkNgfmqc7ViU4o8LLq
         1cCi+OGCVbACYwq23P9pTMZt8T1eadH0adMGibXs0/NYzC3+P/0GUpr6nBri6qvydYLw
         8xxXuZAsXXRsaMDhB/6fI04nMrYSnOauuC2PKLTV0vV8IEc/UN55Tk8e9af+ICOSdfz1
         eAxDYtNAbAcMnOqpiXMD24u/pdQGezLNh9M+9BFW6WB13ZDEhWRjZgy32IX7ONfMijNK
         Hn2yYs0d8Jw12Q6GnpM2RfbGqlOwQ+aaKluhfUYk3l9KcFK/wwjCxomEshn//8bXO1Fr
         rMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214451; x=1696819251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkazeKVM1RtP9Z70mx3eJTcTbac/plstEPcnoAezcv4=;
        b=RI6qKaXNbu4VrwLyCWkx0NzZAanliby/UCGdFdydjYVKrEIZkA5ZfCYe/HPLYieFNr
         S3vEdJo3rlYd65y0Pxq4S3NEuNVY86g7b488FHONL29s9PhRLhoDZw/7yPxIcgQcCe+Q
         UyQmgFji7Z+YnsLl+IgpW9rItxmgkQ3kq/ccOo+LP4K0lDl+2ZJiEMuppqtxpnH9eDWO
         lQ6qayL7mmS680fHM864MORjF1cwpcdkAL3PQRqB0EcYFwz4PPdPykLR79IsiLX3CbIj
         4i4b9x+zp4r1hV5Hit1EG1JJOW7D9iRMI0GR9HeBnBFr8MufBXQa7JzxVFxsQji/J6vS
         OJyA==
X-Gm-Message-State: AOJu0Yycrc8VRJbrKx8KQnN4ar5gT5GV3PxUaOqksFoUgAsp2MTL6cwc
        Vnsg7NiUL86LyegHN1dweSE=
X-Google-Smtp-Source: AGHT+IHwODp3nH5RRGByNLKK2zKRZqAeWSF2Nbx3539Mm5NOnMsIFl7rvBNWUHsR81fPArbRo0MLpQ==
X-Received: by 2002:a05:6602:420d:b0:798:312a:5403 with SMTP id cb13-20020a056602420d00b00798312a5403mr12903850iob.19.1696214451708;
        Sun, 01 Oct 2023 19:40:51 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:51 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 14/30] object: factor out parse_mode out of fast-import and tree-walk into in object.h
Date:   Sun,  1 Oct 2023 21:40:18 -0500
Message-Id: <20231002024034.2611-14-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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

