Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2298DC63777
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946442145D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoAHmkvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391784AbgKZWXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbgKZWXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A68C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m6so3684731wrg.7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgWrEduBkxDAzvnKGnIbCyF6ytmnoC5J+QiE+wkxOb4=;
        b=NoAHmkvL+tb7+c2c3aIfvkpdjgkuWlzHiNkccL2Y6P4HoE1rMVRA4dJXs75v6zcBwB
         lUxL0IxrHr0tbW3816sYm8bodJ9XvhPHBUakvULNIH4NekBJ8Zhg/lItM2NMRbCvEzk2
         32ORY/QPhu2cCwHMIhnEzy2RYaPM4h3yTS/qf/NLojZ7m2wwrCB/Yx/ZASWvP5sG3O4B
         k8Df3iwv26Ex0OKoI1vnt28Bv8MyOWZXGnBItHGPFqHVbpiuMUVVL0d9MjtIJN0uH9Vc
         NixfIlCNfZEuCiWLLFvvLYfvfsfMNtNr6eDNwdtkr6yMadJ4tOMQ0oQ9TLwCPx1veJHu
         xygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgWrEduBkxDAzvnKGnIbCyF6ytmnoC5J+QiE+wkxOb4=;
        b=JreIcab4ryyiFIhoiQACjnNZVcm0h71qD5Quk1ybJnKkqzSNhukYeIZ/Y6L+eT8vnX
         y+3e0FtRole07iqsKk9cj+9GTeWTfgXs8bpYPPW0R4fO1FvQQDNs6iAmqdYQBP7kSWnw
         fJh3vW5WRquXr6+8ni3v+T5T910svajxJin1JkZutfuuSzkj74S/J50fR9ifBaD5upIl
         pn4RHxQZay+9zY+yBpORWeCGF97soU44LgmZ7MHYrN9KOZT4DdvgdmtE/W3LRwtfLWps
         O50DE32pMeMMGT3DgD0rBiTOJPnTWAdVYdGbKIrVMaaoy9Y3w+wrQHOgWzVGnXzF8G4g
         6xRg==
X-Gm-Message-State: AOAM531fcpOQufzGMG67Lkn+zO9r+3/z7AB94N3/YJKjK89HgjsH6EOE
        0fecF1ii6W/RksbFgn18GoRr66lzoV2FqA==
X-Google-Smtp-Source: ABdhPJyEwUDOKDi9cdH5UVAXc+1e/0oPEXlJOS6lTa9CqyyR8lHRKPn3pT61hnmW93F7qVmvjkBbrA==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr6391742wre.78.1606429388661;
        Thu, 26 Nov 2020 14:23:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] make "mktag" use fsck_tag()
Date:   Thu, 26 Nov 2020 23:22:47 +0100
Message-Id: <20201126222257.5629-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now a non-RFC. I went for the approach I suggested in
<87r1ognv4b.fsf@evledraar.gmail.com> of just having fsck_tag() able to
optionally tell us about its parsed tag/type, thus avoiding any need
for a custom parser in mktag.c. Hopefully I've addressed the rest of
the feedback, range-diff below.

Ævar Arnfjörð Bjarmason (10):
  mktag doc: say <hash> not <sha1>
  mktag: use default strbuf_read() hint
  mktag: reword write_object_file() error
  mktag: remove redundant braces in one-line body "if"
  mktag tests: don't needlessly use a subshell
  mktag tests: remove needless SHA-1 hardcoding
  mktag tests: improve verify_object() test coverage
  fsck: add new "extra" checks for "mktag"
  mktag: use fsck instead of custom verify_tag()
  mktag doc: update to explain why to use this

 Documentation/git-hash-object.txt |   4 +
 Documentation/git-mktag.txt       |  31 ++++-
 builtin/mktag.c                   | 202 ++++++++----------------------
 fsck.c                            |  47 ++++++-
 fsck.h                            |  11 ++
 t/t1006-cat-file.sh               |   2 +-
 t/t3800-mktag.sh                  | 117 ++++++++++++-----
 7 files changed, 222 insertions(+), 192 deletions(-)

Range-diff:
11:  a7a6524b2a !  1:  f46abb37df mktag docs: say <hash> not <sha1>
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    mktag docs: say <hash> not <sha1>
    +    mktag doc: say <hash> not <sha1>
     
         Change the "mktag" documentation to refer to the input hash as just
         "hash", not "sha1". This command has supported SHA-256 for a while
 1:  f6d9482c5b =  2:  1b4d9a5330 mktag: use default strbuf_read() hint
 2:  49be8dbdd3 =  3:  83f4af6013 mktag: reword write_object_file() error
 3:  868d424e65 =  4:  bca1484ed9 mktag: remove redundant braces in one-line body "if"
 4:  e57969ce5d =  5:  ac7c4097c9 mktag tests: don't needlessly use a subshell
 5:  8cf5d95b1e !  6:  5e076659e4 mktag tests: remove needless SHA-1 hardcoding
    @@ Commit message
     
         Some of these tests were failing for the wrong reasons. The first one
         being modified here would fail because the line starts with "xxxxxx"
    -    instead of "object", the rest of the line doesn't matter. Let's just
    -    put a valid hash on the rest of the line anyway to narrow the test
    -    down for just the s/object/xxxxxx/ case.
    +    instead of "object", the rest of the line doesn't matter.
    +
    +    Let's just put a valid hash on the rest of the line anyway to narrow
    +    the test down for just the s/object/xxxxxx/ case.
     
         The second one being modified here would fail under
         GIT_TEST_DEFAULT_HASH=sha256 because <some sha-1 length garbage> is an
    @@ Commit message
         garbage> when under SHA-256.
     
         This doesn't really matter since we should be able to trust other
    -    parts of the code to validate things in the 0-9a-f range, but let's do
    -    it for good measure.
    +    parts of the code to validate things in the 0-9a-f range, but let's
    +    keep it for good measure.
     
         There's a later test which tests an invalid SHA which looks like a
         valid one, to stress the "We refuse to tag something we can't
         verify[...]" logic in mktag.c.
     
         But here we're testing for a SHA-length string which contains
    -    characters outside of the /[0-9a-f]/i set. Let's just do that with a
    -    ROT13 invocation.
    -
    -    We could get really unlucky and switch to a future hash function that
    -    just happens to produce all [0-9] output for this particular input,
    -    but that's very unlikely.
    +    characters outside of the /[0-9a-f]/i set.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t3800-mktag.sh: EOF
     -#  3. object line SHA1 check
     +#  3. object line SHA check
      
    -+invalid_sha=$(echo $head | tr A-Za-z N-ZA-Mn-za-m)
      cat >tag.sig <<EOF
     -object zz9e9b33986b1c2670fff52c5067603117b3e895
    -+object $invalid_sha
    ++object $(echo $head | tr 0-9a-f z)
      type tag
      tag mytag
      tagger . <> 0 +0000
 6:  2899f9cda5 <  -:  ---------- mktag tests: improve verify_object() test coverage
 -:  ---------- >  7:  a048c3e640 mktag tests: improve verify_object() test coverage
 7:  70d1d877aa =  8:  dab44d3235 fsck: add new "extra" checks for "mktag"
 8:  d37d684135 !  9:  8ff853caee mktag: use fsck instead of custom verify_tag()
    @@ Metadata
      ## Commit message ##
         mktag: use fsck instead of custom verify_tag()
     
    -    TODO: This subtly breaks one check, see the last patch in this series.
    -
         Change the validation logic in "mktag" to use fsck's fsck_tag()
         instead of its own custom parser. Curiously the logic for both dates
         back to the same commit[1]. Let's unify them so we're not maintaining
    @@ Commit message
             Islands when it comes to timezone extravagance.
     
          B. fsck allows missing author names such as "tagger <email>", mktag
    -        wouldn't, but would allow e.g. "tagger <email>" (but not "tagger
    -        <email>"). Now we allow all of these.
    +        wouldn't, but would allow e.g. "tagger [2 spaces] <email>" (but
    +        not "tagger [1 space] <email>"). Now we allow all of these.
     
          C. Like B, but "mktag" disallowed spaces in the <email> part, fsck
             allows it.
    @@ builtin/mktag.c
      #include "object-store.h"
     +#include "fsck.h"
      
    - /*
    -  * A signature file has a very simple fixed format: four lines
    -@@ builtin/mktag.c: static int verify_tag(char *buffer, unsigned long size)
    - 	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
    - 	size_t len;
    - 
    -+	/* verify_tag() will be removed in the next commit */
    -+	return 0;
    -+
    - 	if (size < 84)
    - 		return error("wanna fool me ? you obviously got the size wrong !");
    - 
    -@@ builtin/mktag.c: static int verify_tag(char *buffer, unsigned long size)
    - 	return 0;
    - }
    - 
    +-/*
    +- * A signature file has a very simple fixed format: four lines
    +- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
    +- * "tagger <committer>", followed by a blank line, a free-form tag
    +- * message and a signature block that git itself doesn't care about,
    +- * but that can be verified with gpg or similar.
    +- *
    +- * The first four lines are guaranteed to be at least 83 bytes:
    +- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
    +- * shortest possible type-line, "tag .\n" at 6 bytes is the shortest
    +- * single-character-tag line, and "tagger . <> 0 +0000\n" at 20 bytes is
    +- * the shortest possible tagger-line.
    +- */
    +-
    +-/*
    +- * We refuse to tag something we can't verify. Just because.
    +- */
    +-static int verify_object(const struct object_id *oid, const char *expected_type)
     +static int mktag_fsck_error_func(struct fsck_options *o,
     +				 const struct object_id *oid,
     +				 enum object_type object_type,
     +				 int msg_type, const char *message)
    -+{
    + {
    +-	int ret = -1;
    +-	enum object_type type;
    +-	unsigned long size;
    +-	void *buffer = read_object_file(oid, &type, &size);
    +-	const struct object_id *repl = lookup_replace_object(the_repository, oid);
    +-
    +-	if (buffer) {
    +-		if (type == type_from_string(expected_type)) {
    +-			ret = check_object_signature(the_repository, repl,
    +-						     buffer, size,
    +-						     expected_type);
    +-		}
    +-		free(buffer);
     +	switch (msg_type) {
     +	case FSCK_WARN:
     +	case FSCK_ERROR:
    @@ builtin/mktag.c: static int verify_tag(char *buffer, unsigned long size)
     +		 * like missing "tagger" lines are "only" warnings
     +		 * under fsck, we've always considered them an error.
     +		 */
    -+		fprintf_ln(stderr, "error: %s", message);
    ++		fprintf_ln(stderr, "error: tag input does not pass fsck: %s", message);
     +		return 1;
     +	default:
     +		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
     +		    msg_type);
    -+	}
    -+}
    + 	}
    +-	return ret;
    + }
    + 
    +-static int verify_tag(char *buffer, unsigned long size)
    ++static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
    + {
    +-	int typelen;
    +-	char type[20];
    +-	struct object_id oid;
    +-	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
    +-	size_t len;
    +-
    +-	if (size < 84)
    +-		return error("wanna fool me ? you obviously got the size wrong !");
    +-
    +-	buffer[size] = 0;
    +-
    +-	/* Verify object line */
    +-	object = buffer;
    +-	if (memcmp(object, "object ", 7))
    +-		return error("char%d: does not start with \"object \"", 0);
    +-
    +-	if (parse_oid_hex(object + 7, &oid, &p))
    +-		return error("char%d: could not get SHA1 hash", 7);
    +-
    +-	/* Verify type line */
    +-	type_line = p + 1;
    +-	if (memcmp(type_line - 1, "\ntype ", 6))
    +-		return error("char%d: could not find \"\\ntype \"", 47);
    +-
    +-	/* Verify tag-line */
    +-	tag_line = strchr(type_line, '\n');
    +-	if (!tag_line)
    +-		return error("char%"PRIuMAX": could not find next \"\\n\"",
    +-				(uintmax_t) (type_line - buffer));
    +-	tag_line++;
    +-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
    +-		return error("char%"PRIuMAX": no \"tag \" found",
    +-				(uintmax_t) (tag_line - buffer));
    +-
    +-	/* Get the actual type */
    +-	typelen = tag_line - type_line - strlen("type \n");
    +-	if (typelen >= sizeof(type))
    +-		return error("char%"PRIuMAX": type too long",
    +-				(uintmax_t) (type_line+5 - buffer));
    +-
    +-	memcpy(type, type_line+5, typelen);
    +-	type[typelen] = 0;
    +-
    +-	/* Verify that the object matches */
    +-	if (verify_object(&oid, type))
    +-		return error("char%d: could not verify object %s", 7, oid_to_hex(&oid));
    +-
    +-	/* Verify the tag-name: we don't allow control characters or spaces in it */
    +-	tag_line += 4;
    +-	for (;;) {
    +-		unsigned char c = *tag_line++;
    +-		if (c == '\n')
    +-			break;
    +-		if (c > ' ')
    +-			continue;
    +-		return error("char%"PRIuMAX": could not verify tag name",
    +-				(uintmax_t) (tag_line - buffer));
    +-	}
    +-
    +-	/* Verify the tagger line */
    +-	tagger_line = tag_line;
    +-
    +-	if (memcmp(tagger_line, "tagger ", 7))
    +-		return error("char%"PRIuMAX": could not find \"tagger \"",
    +-			(uintmax_t) (tagger_line - buffer));
    +-
    +-	/*
    +-	 * Check for correct form for name and email
    +-	 * i.e. " <" followed by "> " on _this_ line
    +-	 * No angle brackets within the name or email address fields.
    +-	 * No spaces within the email address field.
    +-	 */
    +-	tagger_line += 7;
    +-	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
    +-		strpbrk(tagger_line, "<>\n") != lb+1 ||
    +-		strpbrk(lb+2, "><\n ") != rb)
    +-		return error("char%"PRIuMAX": malformed tagger field",
    +-			(uintmax_t) (tagger_line - buffer));
    +-
    +-	/* Check for author name, at least one character, space is acceptable */
    +-	if (lb == tagger_line)
    +-		return error("char%"PRIuMAX": missing tagger name",
    +-			(uintmax_t) (tagger_line - buffer));
    +-
    +-	/* timestamp, 1 or more digits followed by space */
    +-	tagger_line = rb + 2;
    +-	if (!(len = strspn(tagger_line, "0123456789")))
    +-		return error("char%"PRIuMAX": missing tag timestamp",
    +-			(uintmax_t) (tagger_line - buffer));
    +-	tagger_line += len;
    +-	if (*tagger_line != ' ')
    +-		return error("char%"PRIuMAX": malformed tag timestamp",
    +-			(uintmax_t) (tagger_line - buffer));
    +-	tagger_line++;
    +-
    +-	/* timezone, 5 digits [+-]hhmm, max. 1400 */
    +-	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
    +-	      strspn(tagger_line+1, "0123456789") == 4 &&
    +-	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
    +-		return error("char%"PRIuMAX": malformed tag timezone",
    +-			(uintmax_t) (tagger_line - buffer));
    +-	tagger_line += 6;
    +-
    +-	/* Verify the blank line separating the header from the body */
    +-	if (*tagger_line != '\n')
    +-		return error("char%"PRIuMAX": trailing garbage in tag header",
    +-			(uintmax_t) (tagger_line - buffer));
    ++	int ret;
    ++	enum object_type type;
    ++	unsigned long size;
    ++	void *buffer;
    ++	const struct object_id *repl;
    ++
    ++	buffer = read_object_file(tagged_oid, &type, &size);
    ++	if (!buffer)
    ++		die("could not read tagged object '%s'\n",
    ++		    oid_to_hex(tagged_oid));
    ++	if (type != *tagged_type)
    ++		die("object '%s' tagged as '%s', but is a '%s' type\n",
    ++		    oid_to_hex(tagged_oid),
    ++		    type_name(*tagged_type), type_name(type));
     +
    ++	repl = lookup_replace_object(the_repository, tagged_oid);
    ++	ret = check_object_signature(the_repository, repl,
    ++				     buffer, size, type_name(*tagged_type));
    ++	free(buffer);
    + 
    +-	/* The actual stuff afterwards we don't care about.. */
    +-	return 0;
    ++	return ret;
    + }
    + 
      int cmd_mktag(int argc, const char **argv, const char *prefix)
      {
    -+	struct object obj;
      	struct strbuf buf = STRBUF_INIT;
    - 	struct object_id result;
     +	struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
    ++	struct object_id tagged_oid;
    ++	int tagged_type;
    + 	struct object_id result;
      
      	if (argc != 1)
    - 		usage("git mktag");
     @@ builtin/mktag.c: int cmd_mktag(int argc, const char **argv, const char *prefix)
      	if (strbuf_read(&buf, 0, 0) < 0)
      		die_errno("could not read from stdin");
    @@ builtin/mktag.c: int cmd_mktag(int argc, const char **argv, const char *prefix)
     -	   "object <sha1>\ntype\ntagger " */
     -	if (verify_tag(buf.buf, buf.len) < 0)
     -		die("invalid tag signature file");
    -+	/* verify_tag() will be removed in the next commit */
    -+	verify_tag("", 0);
    -+
    -+	/*
    -+	 * Fake up an object for fsck_object()
    -+	 */
    -+	obj.parsed = 1;
    -+	obj.type = OBJ_TAG;
    -+
     +	fsck_options.extra = 1;
     +	fsck_options.error_func = mktag_fsck_error_func;
    -+	if (fsck_object(&obj, buf.buf, buf.len, &fsck_options))
    ++	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
    ++				&tagged_oid, &tagged_type))
     +		die("tag on stdin did not pass our strict fsck check");
    ++
    ++	if (verify_object_in_tag(&tagged_oid, &tagged_type))
    ++		die("tag on stdin did not refer to a valid object");
      
      	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
      		die("unable to write annotated tag object");
     
    + ## fsck.c ##
    +@@ fsck.c: static int fsck_tag(const struct object_id *oid, const char *buffer,
    + 		    unsigned long size, struct fsck_options *options)
    + {
    + 	struct object_id tagged_oid;
    ++	int tagged_type;
    ++	return fsck_tag_standalone(oid, buffer, size, options, &tagged_oid,
    ++				   &tagged_type);
    ++}
    ++
    ++int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
    ++			unsigned long size, struct fsck_options *options,
    ++			struct object_id *tagged_oid,
    ++			int *tagged_type)
    ++{
    + 	int ret = 0;
    + 	char *eol;
    + 	struct strbuf sb = STRBUF_INIT;
    +@@ fsck.c: static int fsck_tag(const struct object_id *oid, const char *buffer,
    + 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
    + 		goto done;
    + 	}
    +-	if (parse_oid_hex(buffer, &tagged_oid, &p) || *p != '\n') {
    ++	if (parse_oid_hex(buffer, tagged_oid, &p) || *p != '\n') {
    + 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
    + 		if (ret)
    + 			goto done;
    +@@ fsck.c: static int fsck_tag(const struct object_id *oid, const char *buffer,
    + 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
    + 		goto done;
    + 	}
    +-	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
    ++	*tagged_type = type_from_string_gently(buffer, eol - buffer, 1);
    ++	if (*tagged_type < 0)
    + 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
    + 	if (ret)
    + 		goto done;
    +
    + ## fsck.h ##
    +@@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
    + int fsck_object(struct object *obj, void *data, unsigned long size,
    + 	struct fsck_options *options);
    + 
    ++/*
    ++ * fsck a tag, and pass info about it back to the caller. This is
    ++ * exposed fsck_object() internals for git-mktag(1).
    ++ */
    ++int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
    ++			unsigned long size, struct fsck_options *options,
    ++			struct object_id *tagged_oid,
    ++			int *tag_type);
    ++
    + /*
    +  * Some fsck checks are context-dependent, and may end up queued; run this
    +  * after completing all fsck_object() calls in order to resolve any remaining
    +
      ## t/t1006-cat-file.sh ##
     @@ t/t1006-cat-file.sh: tag_content="$tag_header_without_timestamp 0000000000 +0000
      
    @@ t/t3800-mktag.sh: too short for a tag
      
      check_verify_failure 'Tag object length check' \
     -	'^error: .*size wrong.*$'
    -+	'^error: missingObject:'
    ++	'^error:.* missingObject:'
      
      ############################################################
      #  2. object line label check
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
     -check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
    -+check_verify_failure '"object" line label check' '^error: missingObject:'
    ++check_verify_failure '"object" line label check' '^error:.* missingObject:'
      
      ############################################################
      #  3. object line SHA check
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
     -check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1 hash$'
    -+check_verify_failure '"object" line check' '^error: badObjectSha1:'
    ++check_verify_failure '"object" line check' '^error:.* badObjectSha1:'
      
      ############################################################
      #  4. type line label check
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
     -check_verify_failure '"type" line label check' '^error: char.*: .*"\\ntype "$'
    -+check_verify_failure '"type" line label check' '^error: missingTypeEntry:'
    ++check_verify_failure '"type" line label check' '^error:.* missingTypeEntry:'
      
      ############################################################
      #  5. type line eol check
    @@ t/t3800-mktag.sh: check_verify_failure '"type" line label check' '^error: char.*
      printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
      
     -check_verify_failure '"type" line eol check' '^error: char.*: .*"\\n"$'
    -+check_verify_failure '"type" line eol check' '^error: unterminatedHeader:'
    ++check_verify_failure '"type" line eol check' '^error:.* unterminatedHeader:'
      
      ############################################################
      #  6. tag line label check #1
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      
      check_verify_failure '"tag" line label check #1' \
     -	'^error: char.*: no "tag " found$'
    -+	'^error: missingTagEntry:'
    ++	'^error:.* missingTagEntry:'
      
      ############################################################
      #  7. tag line label check #2
    @@ t/t3800-mktag.sh: tag
      
      check_verify_failure '"tag" line label check #2' \
     -	'^error: char.*: no "tag " found$'
    -+	'^error: badType:'
    ++	'^error:.* badType:'
      
      ############################################################
      #  8. type line type-name length check
    @@ t/t3800-mktag.sh: tag mytag
      
      check_verify_failure '"type" line type-name length check' \
     -	'^error: char.*: type too long$'
    -+	'^error: badType:'
    ++	'^error:.* badType:'
      
      ############################################################
    - #  9. verify object (SHA1/type) check
    + #  9. verify object (SHA/type) check
     @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      EOF
      
    - check_verify_failure 'verify object (SHA1/type) check' \
    + check_verify_failure 'verify object (SHA/type) check -- correct type, nonexisting object' \
     -	'^error: char7: could not verify object.*$'
    -+	'^error: badType:'
    ++	'^fatal: could not read tagged object'
    + 
    + cat >tag.sig <<EOF
    + object $head
    +@@ t/t3800-mktag.sh: tagger . <> 0 +0000
    + EOF
    + 
    + check_verify_failure 'verify object (SHA/type) check -- made-up type, nonexisting object' \
    +-	'^fatal: invalid object type'
    ++	'^error:.* badType:'
    + 
    + cat >tag.sig <<EOF
    + object $(test_oid deadbeef)
    +@@ t/t3800-mktag.sh: tagger . <> 0 +0000
    + EOF
    + 
    + check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
    +-	'^error: char7: could not verify object.*$'
    ++	'^error:.* badType:'
    + 
    + cat >tag.sig <<EOF
    + object $head
    +@@ t/t3800-mktag.sh: tagger . <> 0 +0000
    + EOF
    + 
    + check_verify_failure 'verify object (SHA/type) check -- incorrect type, valid object' \
    +-	'^error: char7: could not verify object'
    ++	'^fatal: object.*tagged as.*tree.*but is.*commit'
      
      ############################################################
      # 10. verify tag-name check
    @@ t/t3800-mktag.sh: tagger . <> 0 +0000
      
      check_verify_failure 'verify tag-name check' \
     -	'^error: char.*: could not verify tag name$'
    -+	'^error: badTagName:'
    ++	'^error:.* badTagName:'
      
      ############################################################
      # 11. tagger line label check #1
    @@ t/t3800-mktag.sh: This is filler
      
      check_verify_failure '"tagger" line label check #1' \
     -	'^error: char.*: could not find "tagger "$'
    -+	'^error: missingTaggerEntry:'
    ++	'^error:.* missingTaggerEntry:'
      
      ############################################################
      # 12. tagger line label check #2
    @@ t/t3800-mktag.sh: This is filler
      
      check_verify_failure '"tagger" line label check #2' \
     -	'^error: char.*: could not find "tagger "$'
    -+	'^error: missingTaggerEntry:'
    ++	'^error:.* missingTaggerEntry:'
      
      ############################################################
     -# 13. disallow missing tag author name
    @@ t/t3800-mktag.sh: tagger T A Gger <
      
      check_verify_failure 'disallow malformed tagger' \
     -	'^error: char.*: malformed tagger field$'
    -+	'^error: badEmail:'
    ++	'^error:.* badEmail:'
      
      ############################################################
      # 15. allow empty tag email
    @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com>__
      
      check_verify_failure 'disallow missing tag timestamp' \
     -	'^error: char.*: missing tag timestamp$'
    -+	'^error: badDate:'
    ++	'^error:.* badDate:'
      
      ############################################################
      # 18. detect invalid tag timestamp1
    @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> Tue Mar 25 15:47:44 2008
      
      check_verify_failure 'detect invalid tag timestamp1' \
     -	'^error: char.*: missing tag timestamp$'
    -+	'^error: badDate:'
    ++	'^error:.* badDate:'
      
      ############################################################
      # 19. detect invalid tag timestamp2
    @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 2008-03-31T12:20:15-0500
      
      check_verify_failure 'detect invalid tag timestamp2' \
     -	'^error: char.*: malformed tag timestamp$'
    -+	'^error: badDate:'
    ++	'^error:.* badDate:'
      
      ############################################################
      # 20. detect invalid tag timezone1
    @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 GMT
      
      check_verify_failure 'detect invalid tag timezone1' \
     -	'^error: char.*: malformed tag timezone$'
    -+	'^error: badTimezone:'
    ++	'^error:.* badTimezone:'
      
      ############################################################
      # 21. detect invalid tag timezone2
    @@ t/t3800-mktag.sh: tagger T A Gger <tagger@example.com> 1206478233 +  30
      
      check_verify_failure 'detect invalid tag timezone2' \
     -	'^error: char.*: malformed tag timezone$'
    -+	'^error: badTimezone:'
    ++	'^error:.* badTimezone:'
      
      ############################################################
     -# 22. detect invalid tag timezone3
    @@ t/t3800-mktag.sh: this line should not be here
      
      check_verify_failure 'detect invalid header entry' \
     -	'^error: char.*: trailing garbage in tag header$'
    -+	'^error: extraHeaderEntry:'
    ++	'^error:.* extraHeaderEntry:'
     +
     +cat >tag.sig <<EOF
     +object $head
    @@ t/t3800-mktag.sh: this line should not be here
     +EOF
     +
     +check_verify_failure 'detect invalid header entry' \
    -+	'^error: extraHeaderBodyNewline:'
    ++	'^error:.* extraHeaderBodyNewline:'
      
      ############################################################
      # 24. create valid tag
 9:  403820698b <  -:  ---------- mktag: remove now-unused verify_tag() code
10:  78a4877450 = 10:  e38feefd3f mktag doc: update to explain why to use this
12:  0e840246a8 <  -:  ---------- mktag: bring back some of the verify_object() logic
-- 
2.29.2.222.g5d2a92d10f8

