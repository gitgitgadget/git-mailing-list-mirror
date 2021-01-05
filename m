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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4764C4332B
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7455F22D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbhAETpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbhAETp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264D3C0617AB
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:47 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e25so641007wme.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUPzq8AQxqHKZgHa3BfUS7f/v2bVXFzpXyULxhZFQ6Q=;
        b=TgnwUmOMH0leMncVr2/RBXqUaq+JW8p6J22NT4tj6fXtm30FFnwzbbJukKnJzSFPdH
         76i5q3s+pmdN0KvusBZdi5HY031LZWYcNK3CHBPbtsgHqLIClUepR1Gx6vmL5Iwxv+1e
         /rlc15mDWhwkZMQJ/Oq+qrnm98s/aedn71UEccWfsWpZHU1Q4gpdUs8+cNS5ZxziuRcX
         RJf8BbEvyiQeXmmUniT0ME33sKQQldOTY6NImPlT5UVC5/Cl4vCEKXvQGALtd/4xIBmM
         kHYRdwjnIzEqr5VhIjWeiI2RxubZ4zWyJ5rsh1PS0UTgdw7QKVcDGEDQDiI3UjGeEDp8
         9Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUPzq8AQxqHKZgHa3BfUS7f/v2bVXFzpXyULxhZFQ6Q=;
        b=sEpplKVWbdK/QcKeat74pSBv/oH+P+9OXbcQw1p1TJkcCD6bb+8ndyqEmIvSUml9v5
         Yk+bUTI27eNhpG8QDvHTiRqero6EidLalXcsTLjzV+XDDoey5Nw7KDhEfrsGSBwulNnc
         Ou6mwHSzSF3XQdCIiuhwu3xTsgBW+z7FIfd42SqUXWfm+DGcxU9+E+5jvrbp8cfU+6rU
         Tafp3yG0bSUKcA+5IF+kgVokKln4sWNHg+04wUBvVI8l179nBNk2VL8MhoiHYsJLCIxp
         UvViBw0TvqN3y0GMNiZd27Am+95jRg5i+BPu4WRfSodoUkckJi9wLyhXW6WHrxj6lybl
         wf8g==
X-Gm-Message-State: AOAM531CJWiNi0xN2g+yunXPzDX3sBRe3LKCfmWVM5zjC6afssjFx8aA
        DMnfTiBmIt+qpR+WCChVCk4Cg5lZAmnxGw==
X-Google-Smtp-Source: ABdhPJz3TmT7KZo63izalSgIrH5dOUdcDmFcYIdGup1caU/vfgVGEHG36s+Nh0SONJIcFeKSvNEfyw==
X-Received: by 2002:a05:600c:1483:: with SMTP id c3mr606204wmh.87.1609875825183;
        Tue, 05 Jan 2021 11:43:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 17/23] mktag: use fsck instead of custom verify_tag()
Date:   Tue,  5 Jan 2021 20:42:46 +0100
Message-Id: <20210105194252.627-18-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the validation logic in "mktag" to use fsck's fsck_tag()
instead of its own custom parser. Curiously the logic for both dates
back to the same commit[1]. Let's unify them so we're not maintaining
two sets functions to verify that a tag is OK.

The behavior of fsck_tag() and the old "mktag" code being removed here
is different in few aspects.

I think it makes sense to remove some of those checks, namely:

 A. fsck only cares that the timezone matches [-+][0-9]{4}. The mktag
    code disallowed values larger than 1400.

    Yes there's currently no timezone with a greater offset[2], but
    since we allow any number of non-offical timezones (e.g. +1234)
    passing this through seems fine. Git also won't break in the
    future if e.g. French Polynesia decides it needs to outdo the Line
    Islands when it comes to timezone extravagance.

 B. fsck allows missing author names such as "tagger <email>", mktag
    wouldn't, but would allow e.g. "tagger [2 spaces] <email>" (but
    not "tagger [1 space] <email>"). Now we allow all of these.

 C. Like B, but "mktag" disallowed spaces in the <email> part, fsck
    allows it.

In some ways fsck_tag() is stricter than "mktag" was, namely:

 D. fsck disallows zero-padded dates, but mktag didn't care. So
    e.g. the timestamp "0000000000 +0000" produces an error now. A
    test in "t1006-cat-file.sh" relied on this, it's been changed to
    use "hash-object" (without fsck) instead.

There was one check I deemed worth keeping by porting it over to
fsck_tag():

 E. "mktag" did not allow any custom headers, and by extension (as an
    empty commit is allowed) also forbade an extra stray trailing
    newline after the headers it knew about.

    Add a new check in the "ignore" category to fsck and use it. This
    somewhat abuses the facility added in efaba7cc77f (fsck:
    optionally ignore specific fsck issues completely, 2015-06-22).

    This is somewhat of hack, but probably the least invasive change
    we can make here. The fsck command will shuffle these categories
    around, e.g. under --strict the "info" becomes a "warn" and "warn"
    becomes "error". Existing users of fsck's (and others,
    e.g. index-pack) --strict option rely on this.

    So we need to put something into a category that'll be ignored by
    all existing users of the API. Pretending that
    fsck.extraHeaderEntry=error ("ignore" by default) was set serves
    to do this for us.

1. ec4465adb38 (Add "tag" objects that can be used to sign other
   objects., 2005-04-25)

2. https://en.wikipedia.org/wiki/List_of_UTC_time_offsets

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt |   9 +-
 builtin/mktag.c             | 196 +++++++++---------------------------
 fsck.c                      |  32 +++++-
 fsck.h                      |   9 ++
 t/t1006-cat-file.sh         |   2 +-
 t/t3800-mktag.sh            |  63 ++++++------
 6 files changed, 127 insertions(+), 184 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 20af1915e9e..fa070e21a0b 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -25,7 +25,14 @@ write a tag found in `my-tag`:
     git hash-object -t tag -w --stdin <my-tag
 
 The difference is that mktag will die before writing the tag if the
-tag doesn't pass a sanity check.
+tag doesn't pass a linkgit:git-fsck[1] check.
+
+The "fsck" check done mktag is stricter than what linkgit:git-fsck[1]
+would run by default in that all `fsck.<msg-id>` messages are promoted
+from warnings to errors (so e.g. a missing "tagger" line is an error).
+
+Extra headers in the object are also an error under mktag, but ignored
+by linkgit:git-fsck[1]
 
 Tag Format
 ----------
diff --git a/builtin/mktag.c b/builtin/mktag.c
index d89a3c201de..4dd35bc79e2 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -2,160 +2,60 @@
 #include "tag.h"
 #include "replace-object.h"
 #include "object-store.h"
+#include "fsck.h"
 
-/*
- * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
- * "tagger <committer>", followed by a blank line, a free-form tag
- * message and a signature block that git itself doesn't care about,
- * but that can be verified with gpg or similar.
- *
- * The first four lines are guaranteed to be at least 83 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
- * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
- * single-character-tag line, and "tagger . <> 0 +0000\n" at 20 bytes is
- * the shortest possible tagger-line.
- */
-
-/*
- * We refuse to tag something we can't verify. Just because.
- */
-static int verify_object(const struct object_id *oid, const char *expected_type)
+static int mktag_fsck_error_func(struct fsck_options *o,
+				 const struct object_id *oid,
+				 enum object_type object_type,
+				 int msg_type, const char *message)
 {
-	int ret = -1;
-	enum object_type type;
-	unsigned long size;
-	void *buffer = read_object_file(oid, &type, &size);
-	const struct object_id *repl = lookup_replace_object(the_repository, oid);
-
-	if (buffer) {
-		if (type == type_from_string(expected_type)) {
-			ret = check_object_signature(the_repository, repl,
-						     buffer, size,
-						     expected_type);
-		}
-		free(buffer);
+	switch (msg_type) {
+	case FSCK_WARN:
+	case FSCK_ERROR:
+		/*
+		 * We treat both warnings and errors as errors, things
+		 * like missing "tagger" lines are "only" warnings
+		 * under fsck, we've always considered them an error.
+		 */
+		fprintf_ln(stderr, "error: tag input does not pass fsck: %s", message);
+		return 1;
+	default:
+		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
+		    msg_type);
 	}
-	return ret;
 }
 
-static int verify_tag(char *buffer, unsigned long size)
+static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 {
-	int typelen;
-	char type[20];
-	struct object_id oid;
-	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
-	size_t len;
-
-	if (size < 84)
-		return error("wanna fool me ? you obviously got the size wrong !");
-
-	buffer[size] = 0;
-
-	/* Verify object line */
-	object = buffer;
-	if (memcmp(object, "object ", 7))
-		return error("char%d: does not start with \"object \"", 0);
-
-	if (parse_oid_hex(object + 7, &oid, &p))
-		return error("char%d: could not get SHA1 hash", 7);
-
-	/* Verify type line */
-	type_line = p + 1;
-	if (memcmp(type_line - 1, "\ntype ", 6))
-		return error("char%d: could not find \"\\ntype \"", 47);
-
-	/* Verify tag-line */
-	tag_line = strchr(type_line, '\n');
-	if (!tag_line)
-		return error("char%"PRIuMAX": could not find next \"\\n\"",
-				(uintmax_t) (type_line - buffer));
-	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char%"PRIuMAX": no \"tag \" found",
-				(uintmax_t) (tag_line - buffer));
-
-	/* Get the actual type */
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= sizeof(type))
-		return error("char%"PRIuMAX": type too long",
-				(uintmax_t) (type_line+5 - buffer));
-
-	memcpy(type, type_line+5, typelen);
-	type[typelen] = 0;
-
-	/* Verify that the object matches */
-	if (verify_object(&oid, type))
-		return error("char%d: could not verify object %s", 7, oid_to_hex(&oid));
-
-	/* Verify the tag-name: we don't allow control characters or spaces in it */
-	tag_line += 4;
-	for (;;) {
-		unsigned char c = *tag_line++;
-		if (c == '\n')
-			break;
-		if (c > ' ')
-			continue;
-		return error("char%"PRIuMAX": could not verify tag name",
-				(uintmax_t) (tag_line - buffer));
-	}
-
-	/* Verify the tagger line */
-	tagger_line = tag_line;
-
-	if (memcmp(tagger_line, "tagger ", 7))
-		return error("char%"PRIuMAX": could not find \"tagger \"",
-			(uintmax_t) (tagger_line - buffer));
-
-	/*
-	 * Check for correct form for name and email
-	 * i.e. " <" followed by "> " on _this_ line
-	 * No angle brackets within the name or email address fields.
-	 * No spaces within the email address field.
-	 */
-	tagger_line += 7;
-	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
-		strpbrk(tagger_line, "<>\n") != lb+1 ||
-		strpbrk(lb+2, "><\n ") != rb)
-		return error("char%"PRIuMAX": malformed tagger field",
-			(uintmax_t) (tagger_line - buffer));
-
-	/* Check for author name, at least one character, space is acceptable */
-	if (lb == tagger_line)
-		return error("char%"PRIuMAX": missing tagger name",
-			(uintmax_t) (tagger_line - buffer));
-
-	/* timestamp, 1 or more digits followed by space */
-	tagger_line = rb + 2;
-	if (!(len = strspn(tagger_line, "0123456789")))
-		return error("char%"PRIuMAX": missing tag timestamp",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line += len;
-	if (*tagger_line != ' ')
-		return error("char%"PRIuMAX": malformed tag timestamp",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line++;
-
-	/* timezone, 5 digits [+-]hhmm, max. 1400 */
-	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
-	      strspn(tagger_line+1, "0123456789") == 4 &&
-	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
-		return error("char%"PRIuMAX": malformed tag timezone",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line += 6;
-
-	/* Verify the blank line separating the header from the body */
-	if (*tagger_line != '\n')
-		return error("char%"PRIuMAX": trailing garbage in tag header",
-			(uintmax_t) (tagger_line - buffer));
+	int ret;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	const struct object_id *repl;
+
+	buffer = read_object_file(tagged_oid, &type, &size);
+	if (!buffer)
+		die("could not read tagged object '%s'",
+		    oid_to_hex(tagged_oid));
+	if (type != *tagged_type)
+		die("object '%s' tagged as '%s', but is a '%s' type",
+		    oid_to_hex(tagged_oid),
+		    type_name(*tagged_type), type_name(type));
+
+	repl = lookup_replace_object(the_repository, tagged_oid);
+	ret = check_object_signature(the_repository, repl,
+				     buffer, size, type_name(*tagged_type));
+	free(buffer);
 
-	/* The actual stuff afterwards we don't care about.. */
-	return 0;
+	return ret;
 }
 
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+	struct object_id tagged_oid;
+	int tagged_type;
 	struct object_id result;
 
 	if (argc != 1)
@@ -164,10 +64,14 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno("could not read from stdin");
 
-	/* Verify it for some basic sanity: it needs to start with
-	   "object <sha1>\ntype\ntagger " */
-	if (verify_tag(buf.buf, buf.len) < 0)
-		die("invalid tag signature file");
+	fsck_options.error_func = mktag_fsck_error_func;
+	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
+	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
+				&tagged_oid, &tagged_type))
+		die("tag on stdin did not pass our strict fsck check");
+
+	if (verify_object_in_tag(&tagged_oid, &tagged_type))
+		die("tag on stdin did not refer to a valid object");
 
 	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
 		die("unable to write tag file");
diff --git a/fsck.c b/fsck.c
index f82e2fe9e30..bed5e20e03b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -80,7 +80,9 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
-	FUNC(MISSING_TAGGER_ENTRY, INFO)
+	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	/* ignored (elevated when requested) */ \
+	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
@@ -911,6 +913,16 @@ static int fsck_tag(const struct object_id *oid, const char *buffer,
 		    unsigned long size, struct fsck_options *options)
 {
 	struct object_id tagged_oid;
+	int tagged_type;
+	return fsck_tag_standalone(oid, buffer, size, options, &tagged_oid,
+				   &tagged_type);
+}
+
+int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
+			unsigned long size, struct fsck_options *options,
+			struct object_id *tagged_oid,
+			int *tagged_type)
+{
 	int ret = 0;
 	char *eol;
 	struct strbuf sb = STRBUF_INIT;
@@ -924,7 +936,7 @@ static int fsck_tag(const struct object_id *oid, const char *buffer,
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
-	if (parse_oid_hex(buffer, &tagged_oid, &p) || *p != '\n') {
+	if (parse_oid_hex(buffer, tagged_oid, &p) || *p != '\n') {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
@@ -940,7 +952,8 @@ static int fsck_tag(const struct object_id *oid, const char *buffer,
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
-	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
+	*tagged_type = type_from_string_gently(buffer, eol - buffer, 1);
+	if (*tagged_type < 0)
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
 		goto done;
@@ -975,6 +988,19 @@ static int fsck_tag(const struct object_id *oid, const char *buffer,
 	else
 		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
 
+	if (!starts_with(buffer, "\n")) {
+		/*
+		 * The verify_headers() check will allow
+		 * e.g. "[...]tagger <tagger>\nsome
+		 * garbage\n\nmessage" to pass, thinking "some
+		 * garbage" could be a custom header. E.g. "mktag"
+		 * doesn't want any unknown headers.
+		 */
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_EXTRA_HEADER_ENTRY, "invalid format - extra header(s) after 'tagger'");
+		if (ret)
+			goto done;
+	}
+
 done:
 	strbuf_release(&sb);
 	return ret;
diff --git a/fsck.h b/fsck.h
index 69cf715e798..29ee4c45e87 100644
--- a/fsck.h
+++ b/fsck.h
@@ -62,6 +62,15 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
+/*
+ * fsck a tag, and pass info about it back to the caller. This is
+ * exposed fsck_object() internals for git-mktag(1).
+ */
+int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
+			unsigned long size, struct fsck_options *options,
+			struct object_id *tagged_oid,
+			int *tag_type);
+
 /*
  * Some fsck checks are context-dependent, and may end up queued; run this
  * after completing all fsck_object() calls in order to resolve any remaining
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2f501d2dc94..5d2dc99b74a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -166,7 +166,7 @@ tag_content="$tag_header_without_timestamp 0000000000 +0000
 
 $tag_description"
 
-tag_sha1=$(echo_without_newline "$tag_content" | git mktag)
+tag_sha1=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
 
 run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index fbaf648491f..0e2a9a883ba 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -53,7 +53,7 @@ too short for a tag
 EOF
 
 check_verify_failure 'Tag object length check' \
-	'^error: .*size wrong.*$'
+	'^error:.* missingObject:'
 
 ############################################################
 #  2. object line label check
@@ -66,7 +66,7 @@ tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
+check_verify_failure '"object" line label check' '^error:.* missingObject:'
 
 ############################################################
 #  3. object line hash check
@@ -79,7 +79,7 @@ tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1 hash$'
+check_verify_failure '"object" line check' '^error:.* badObjectSha1:'
 
 ############################################################
 #  4. type line label check
@@ -92,7 +92,7 @@ tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure '"type" line label check' '^error: char.*: .*"\\ntype "$'
+check_verify_failure '"type" line label check' '^error:.* missingTypeEntry:'
 
 ############################################################
 #  5. type line eol check
@@ -100,7 +100,7 @@ check_verify_failure '"type" line label check' '^error: char.*: .*"\\ntype "$'
 echo "object $head" >tag.sig
 printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
 
-check_verify_failure '"type" line eol check' '^error: char.*: .*"\\n"$'
+check_verify_failure '"type" line eol check' '^error:.* unterminatedHeader:'
 
 ############################################################
 #  6. tag line label check #1
@@ -114,7 +114,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure '"tag" line label check #1' \
-	'^error: char.*: no "tag " found$'
+	'^error:.* missingTagEntry:'
 
 ############################################################
 #  7. tag line label check #2
@@ -126,7 +126,7 @@ tag
 EOF
 
 check_verify_failure '"tag" line label check #2' \
-	'^error: char.*: no "tag " found$'
+	'^error:.* badType:'
 
 ############################################################
 #  8. type line type-name length check
@@ -138,7 +138,7 @@ tag mytag
 EOF
 
 check_verify_failure '"type" line type-name length check' \
-	'^error: char.*: type too long$'
+	'^error:.* badType:'
 
 ############################################################
 #  9. verify object (hash/type) check
@@ -152,7 +152,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
-	'^error: char7: could not verify object.*$'
+	'^fatal: could not read tagged object'
 
 cat >tag.sig <<EOF
 object $head
@@ -163,7 +163,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- made-up type, valid object' \
-	'^fatal: invalid object type'
+	'^error:.* badType:'
 
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
@@ -174,7 +174,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
-	'^error: char7: could not verify object.*$'
+	'^error:.* badType:'
 
 cat >tag.sig <<EOF
 object $head
@@ -185,7 +185,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
-	'^error: char7: could not verify object'
+	'^fatal: object.*tagged as.*tree.*but is.*commit'
 
 ############################################################
 #  9.5. verify object (hash/type) check -- replacement
@@ -214,7 +214,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
-	'^error: char7: could not verify object'
+	'^fatal: object.*tagged as.*tree.*but is.*blob'
 
 ############################################################
 # 10. verify tag-name check
@@ -228,7 +228,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify tag-name check' \
-	'^error: char.*: could not verify tag name$'
+	'^error:.* badTagName:'
 
 ############################################################
 # 11. tagger line label check #1
@@ -242,7 +242,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #1' \
-	'^error: char.*: could not find "tagger "$'
+	'^error:.* missingTaggerEntry:'
 
 ############################################################
 # 12. tagger line label check #2
@@ -257,10 +257,10 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #2' \
-	'^error: char.*: could not find "tagger "$'
+	'^error:.* missingTaggerEntry:'
 
 ############################################################
-# 13. disallow missing tag author name
+# 13. allow missing tag author name like fsck
 
 cat >tag.sig <<EOF
 object $head
@@ -271,8 +271,7 @@ tagger  <> 0 +0000
 This is filler
 EOF
 
-check_verify_failure 'disallow missing tag author name' \
-	'^error: char.*: missing tagger name$'
+test_expect_mktag_success 'allow missing tag author name'
 
 ############################################################
 # 14. disallow missing tag author name
@@ -287,7 +286,7 @@ tagger T A Gger <
 EOF
 
 check_verify_failure 'disallow malformed tagger' \
-	'^error: char.*: malformed tagger field$'
+	'^error:.* badEmail:'
 
 ############################################################
 # 15. allow empty tag email
@@ -303,7 +302,7 @@ EOF
 test_expect_mktag_success 'allow empty tag email'
 
 ############################################################
-# 16. disallow spaces in tag email
+# 16. allow spaces in tag email like fsck
 
 cat >tag.sig <<EOF
 object $head
@@ -313,8 +312,7 @@ tagger T A Gger <tag ger@example.com> 0 +0000
 
 EOF
 
-check_verify_failure 'disallow spaces in tag email' \
-	'^error: char.*: malformed tagger field$'
+test_expect_mktag_success 'allow spaces in tag email like fsck'
 
 ############################################################
 # 17. disallow missing tag timestamp
@@ -328,7 +326,7 @@ tagger T A Gger <tagger@example.com>__
 EOF
 
 check_verify_failure 'disallow missing tag timestamp' \
-	'^error: char.*: missing tag timestamp$'
+	'^error:.* badDate:'
 
 ############################################################
 # 18. detect invalid tag timestamp1
@@ -342,7 +340,7 @@ tagger T A Gger <tagger@example.com> Tue Mar 25 15:47:44 2008
 EOF
 
 check_verify_failure 'detect invalid tag timestamp1' \
-	'^error: char.*: missing tag timestamp$'
+	'^error:.* badDate:'
 
 ############################################################
 # 19. detect invalid tag timestamp2
@@ -356,7 +354,7 @@ tagger T A Gger <tagger@example.com> 2008-03-31T12:20:15-0500
 EOF
 
 check_verify_failure 'detect invalid tag timestamp2' \
-	'^error: char.*: malformed tag timestamp$'
+	'^error:.* badDate:'
 
 ############################################################
 # 20. detect invalid tag timezone1
@@ -370,7 +368,7 @@ tagger T A Gger <tagger@example.com> 1206478233 GMT
 EOF
 
 check_verify_failure 'detect invalid tag timezone1' \
-	'^error: char.*: malformed tag timezone$'
+	'^error:.* badTimezone:'
 
 ############################################################
 # 21. detect invalid tag timezone2
@@ -384,10 +382,10 @@ tagger T A Gger <tagger@example.com> 1206478233 +  30
 EOF
 
 check_verify_failure 'detect invalid tag timezone2' \
-	'^error: char.*: malformed tag timezone$'
+	'^error:.* badTimezone:'
 
 ############################################################
-# 22. detect invalid tag timezone3
+# 22. allow invalid tag timezone3 (the maximum is -1200/+1400)
 
 cat >tag.sig <<EOF
 object $head
@@ -397,8 +395,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -1430
 
 EOF
 
-check_verify_failure 'detect invalid tag timezone3' \
-	'^error: char.*: malformed tag timezone$'
+test_expect_mktag_success 'allow invalid tag timezone'
 
 ############################################################
 # 23. detect invalid header entry
@@ -413,7 +410,7 @@ this line should not be here
 EOF
 
 check_verify_failure 'detect invalid header entry' \
-	'^error: char.*: trailing garbage in tag header$'
+	'^error:.* extraHeaderEntry:'
 
 cat >tag.sig <<EOF
 object $head
@@ -445,7 +442,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 EOF
 
 check_verify_failure 'require a blank line before an empty body (2)' \
-	'^error: char.*: trailing garbage in tag header$'
+	'^error:.* extraHeaderEntry:'
 
 ############################################################
 # 24. create valid tag
-- 
2.29.2.222.g5d2a92d10f8

