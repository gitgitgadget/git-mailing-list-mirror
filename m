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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A120C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7AD610C7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhFXT02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhFXT01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A20C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso1938427wms.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqKkxETVWqGPFXpSdrH9b4niUSuylw3l4QeeGNCM3S0=;
        b=NR15dMR3S94JQ12v5WS9FJYjbUDHbUMOPFUGHhQKY0PJJpjcO4qzRKEHSEs1uMZt9B
         5gAaEY4pSZecTrFLXkwGNDkG6WZmhKm0w73MwB2KWyiighaOf5+vl2vy7Gka+gWFLw4j
         ta3/XKvaSBH+To2CnHaJVts5uPqAz/hiUlW5HZKdS8T9rQppYJ66ZGKfmYCBWu3yMuTB
         xjn+t3M4UnQLDWZD2rNhzayYPSr2scarXQw4kGg+/U5kU4+s0YCTsH1BZntrvfjfFzwk
         WKVVSj654Tgk9FcB3Cob0mNEHaN5NDlBPhbGnwon0/0B6xvF+y0swJ7+siSmHZqq3/dV
         0hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqKkxETVWqGPFXpSdrH9b4niUSuylw3l4QeeGNCM3S0=;
        b=ODthBMcwlaJm33XBRbTKu0/a8SBkoMUoGtZ0dC7QdB18tCUPnWz5livD9iIvw6fueU
         W33occC+IZcTpvMuKZLeW4n4z7JTBR9jmK71Jko3aHLY+5Lu2zO8wFBucriv5gesUyBf
         uso278ymMOUJer8N+E02C1o6EFStuFdEAOCL+f1f107Y7GP3xpstgCcbpqKduOIXXkLY
         1959i/VJUwlKOestHrcwO1PqEhTMaC4+ll48wctYVnjex/Kaf7K5grWgk4jmKLy6Y4Th
         YqtO+Dwb8FcDPgQ33vkx4hS3rbuRXo10Om8aST1MHGEU+/4p0iP60ajX3Q3Rm6TRDsYZ
         MXDA==
X-Gm-Message-State: AOAM530SVjq2vzsxEDno/xXyxmL9IbE+uvwQkDdMCZe3vQQs89rFgZef
        Wf+O5zVRmjDYe3yeJoj7WQ1zp84onvjBzQ==
X-Google-Smtp-Source: ABdhPJziqj1an0ns5l53LhGVRjY6kkrspHxSQ69PT9whRXut3JRyrtpDnRKZERN3MD+9LeVvOS+IXw==
X-Received: by 2002:a05:600c:4e87:: with SMTP id f7mr5242987wmq.100.1624562643849;
        Thu, 24 Jun 2021 12:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/21] fsck: better "invalid object" error reporting
Date:   Thu, 24 Jun 2021 21:23:38 +0200
Message-Id: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A late re-roll of the v3[1] that's in "seen" and causing a couple of
CI errors, both are solved with this version. For a recap of what this
is about see v3's summary[1].

One was a "mv -v" issue on OSX, it asks interactively, and defaults to
no, now moved to "mv -f" (as in other tests that move .git/objects/*
files directly).

The other happened on one of the docker32 Linux boxes, and turned out
to be an uninitialized variable bug, which happened to be initialized
to a negative value there, and zero (or positive) everywhere else.

I also went through all the commentary on the v3 (particularly good
feedback from Jonathan Tan) and hopefully addressed everything in one
way or another. In particular the 12/21 is new here, split off from
what's now 14/21. That change was the most complex one in the previous
series.

1. https://lore.kernel.org/git/cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (21):
  fsck tests: refactor one test to use a sub-repo
  fsck tests: add test for fsck-ing an unknown type
  cat-file tests: test for missing object with -t and -s
  cat-file tests: test that --allow-unknown-type isn't on by default
  rev-list tests: test for behavior with invalid object types
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  cache.h: move object functions to object-store.h
  object-file.c: don't set "typep" when returning non-zero
  object-file.c: make parse_loose_header_extended() public
  object-file.c: add missing braces to loose_object_info()
  object-file.c: simplify unpack_loose_short_header()
  object-file.c: split up ternary in parse_loose_header()
  object-file.c: stop dying in parse_loose_header()
  object-file.c: guard against future bugs in loose_object_info()
  object-file.c: return -1, not "status" from unpack_loose_header()
  object-file.c: return -2 on "header too long" in unpack_loose_header()
  fsck: don't hard die on invalid object types
  object-store.h: move read_loose_object() below 'struct object_info'
  fsck: report invalid types recorded in objects
  fsck: report invalid object type-path combinations

 builtin/fast-export.c  |   2 +-
 builtin/fsck.c         |  28 ++++++-
 builtin/index-pack.c   |   2 +-
 builtin/mktag.c        |   3 +-
 cache.h                |  10 ---
 object-file.c          | 178 +++++++++++++++++++++--------------------
 object-store.h         |  62 +++++++++++---
 object.c               |   4 +-
 pack-check.c           |   3 +-
 streaming.c            |  10 ++-
 t/t1006-cat-file.sh    | 169 ++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh        |  64 +++++++++++----
 t/t6115-rev-list-du.sh |  11 +++
 13 files changed, 407 insertions(+), 139 deletions(-)

Range-diff against v3:
 1:  aa38b2bf9e7 =  1:  2e37971c016 fsck tests: refactor one test to use a sub-repo
 2:  82b64abd250 =  2:  79630a99433 fsck tests: add test for fsck-ing an unknown type
 3:  7c3c2fe25d9 =  3:  2b5366bfb9d cat-file tests: test for missing object with -t and -s
 4:  871b8200035 !  4:  ea9a5ef0920 cat-file tests: test that --allow-unknown-type isn't on by default
    @@ Metadata
      ## Commit message ##
         cat-file tests: test that --allow-unknown-type isn't on by default
     
    -    Fix a blindspot in the tests added in the tests for the
    -    --allow-unknown-type feature, added in 39e4ae38804 (cat-file: teach
    -    cat-file a '--allow-unknown-type' option, 2015-05-03).
    +    Fix a blindspot in the tests for the --allow-unknown-type feature
    +    added in 39e4ae38804 (cat-file: teach cat-file a
    +    '--allow-unknown-type' option, 2015-05-03). We should check that
    +    --allow-unknown-type isn't on by default.
     
         Before this change all the tests would succeed if --allow-unknown-type
         was on by default, let's fix that by asserting that -t and -s die on a
 5:  b98da9cc89e =  5:  8eaf0e6ddda rev-list tests: test for behavior with invalid object types
 6:  04cc1d20f62 !  6:  f0e9d92414e cat-file tests: add corrupt loose object test
    @@ t/t1006-cat-file.sh: test_expect_success "Size of large broken object is correct
     +		test_cmp out.expect out.actual &&
     +
     +		# Swap the two to corrupt the repository
    -+		mv -v "$other_path" "$empty_path" &&
    ++		mv -f "$other_path" "$empty_path" &&
     +		test_must_fail git fsck 2>err.fsck &&
     +		grep "hash mismatch" err.fsck &&
     +
    @@ t/t1006-cat-file.sh: test_expect_success "Size of large broken object is correct
     +
     +		# So far "cat-file" has been happy to spew the found
     +		# content out as-is. Try to make it zlib-invalid.
    -+		mv -v other.blob "$empty_path" &&
    ++		mv -f other.blob "$empty_path" &&
     +		test_must_fail git fsck 2>err.fsck &&
     +		grep "^error: inflate: data stream error (" err.fsck
     +	)
 7:  9217320888f =  7:  d797d2e8e9d cat-file tests: test for current --allow-unknown-type behavior
 8:  12dd4538794 =  8:  96310a0bb59 cache.h: move object functions to object-store.h
 -:  ----------- >  9:  54fb9189408 object-file.c: don't set "typep" when returning non-zero
 9:  6a5b78dcad8 = 10:  9d36fcbc44a object-file.c: make parse_loose_header_extended() public
10:  5d31d7e1a54 ! 11:  74c308adc19 object-file.c: add missing braces to loose_object_info()
    @@ object-file.c: static int loose_object_info(struct repository *r,
     +	}
      
      	munmap(map, mapsize);
    - 	if (status && oi->typep)
    + 	if (oi->sizep == &size_scratch)
11:  ee28089219f ! 12:  3f52149bfde object-file.c: stop dying in parse_loose_header()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-file.c: stop dying in parse_loose_header()
    +    object-file.c: simplify unpack_loose_short_header()
     
    -    Start the libification of parse_loose_header() by making it return
    -    error codes and data instead of invoking die() by itself. For now
    -    we'll move the relevant die() call to loose_object_info() and
    -    read_loose_object() to keep this change smaller, but in subsequent
    -    commits we'll also libify those.
    +    Combine the unpack_loose_short_header(),
    +    unpack_loose_header_to_strbuf() and unpack_loose_header() functions
    +    into one.
     
    -    The reason this makes sense is that with the refactoring of
    -    parse_loose_header_extended() in an earlier commit the public
    -    interface for parse_loose_header() no longer just accepts a "unsigned
    -    long *sizep". Rather it accepts a "struct object_info *", that
    -    structure will be populated with information about the object.
    -
    -    It thus makes sense to further libify the interface so that it stops
    -    calling die() when it encounters OBJ_BAD, and instead rely on its
    -    callers to check the populated "oi->typep".
    -
    -    This also allows us to simplify away the
    -    unpack_loose_header_to_strbuf() function added in
    +    The unpack_loose_header_to_strbuf() function was added in
         46f034483eb (sha1_file: support reading from a loose object of unknown
    -    type, 2015-05-03). Its code was mostly copy/pasted between it and both
    -    of unpack_loose_header() and unpack_loose_short_header(). We now have
    -    a single unpack_loose_header() function which accepts an optional
    +    type, 2015-05-03).
    +
    +    Its code was mostly copy/pasted between it and both of
    +    unpack_loose_header() and unpack_loose_short_header(). We now have a
    +    single unpack_loose_header() function which accepts an optional
         "struct strbuf *" instead.
     
         I think the remaining unpack_loose_header() function could be further
         simplified, we're carrying some complexity just to be able to emit a
         garbage type longer than MAX_HEADER_LEN, we could alternatively just
    -    say "we found a garbage type <first 32 bytes>..." instead, but let's
    -    leave this in place for now.
    +    say "we found a garbage type <first 32 bytes>..." instead. But let's
    +    leave the current behavior in place for now.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ object-file.c: static int unpack_loose_short_header(git_zstream *stream,
      		return 0;
      
     +	/*
    -+	 * We have a header longer than MAX_HEADER_LEN. We abort early
    -+	 * unless under we're running as e.g. "cat-file
    ++	 * We have a header longer than MAX_HEADER_LEN. The "header"
    ++	 * here is only non-NULL when we run "cat-file
     +	 * --allow-unknown-type".
     +	 */
     +	if (!header)
    @@ object-file.c: static int unpack_loose_short_header(git_zstream *stream,
      	/*
      	 * buffer[0..bufsiz] was not large enough.  Copy the partial
      	 * result out to header, and then append the result of further
    -@@ object-file.c: static void *unpack_loose_rest(git_zstream *stream,
    -  * too permissive for what we want to check. So do an anal
    -  * object header parse by hand.
    -  */
    --int parse_loose_header(const char *hdr,
    --		       struct object_info *oi,
    --		       unsigned int flags)
    -+int parse_loose_header(const char *hdr, struct object_info *oi)
    - {
    - 	const char *type_buf = hdr;
    - 	unsigned long size;
    -@@ object-file.c: int parse_loose_header(const char *hdr,
    - 	type = type_from_string_gently(type_buf, type_len, 1);
    - 	if (oi->type_name)
    - 		strbuf_add(oi->type_name, type_buf, type_len);
    --	/*
    --	 * Set type to 0 if its an unknown object and
    --	 * we're obtaining the type using '--allow-unknown-type'
    --	 * option.
    --	 */
    --	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
    --		type = 0;
    --	else if (type < 0)
    --		die(_("invalid object type"));
    - 	if (oi->typep)
    - 		*oi->typep = type;
    - 
    -@@ object-file.c: int parse_loose_header(const char *hdr,
    - 	/*
    - 	 * The length must be followed by a zero byte
    - 	 */
    --	return *hdr ? -1 : type;
    -+	if (*hdr)
    -+		return -1;
    -+
    -+	/*
    -+	 * The format is valid, but the type may still be bogus. The
    -+	 * Caller needs to check its oi->typep.
    -+	 */
    -+	return 0;
    - }
    - 
    - static int loose_object_info(struct repository *r,
     @@ object-file.c: static int loose_object_info(struct repository *r,
      	unsigned long mapsize;
      	void *map;
    @@ object-file.c: static int loose_object_info(struct repository *r,
      	char hdr[MAX_HEADER_LEN];
      	struct strbuf hdrbuf = STRBUF_INIT;
      	unsigned long size_scratch;
    -+	enum object_type type_scratch;
     +	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
      
      	if (oi->delta_base_oid)
      		oidclr(oi->delta_base_oid);
     @@ object-file.c: static int loose_object_info(struct repository *r,
      
    - 	if (!oi->sizep)
    - 		oi->sizep = &size_scratch;
    -+	if (!oi->typep)
    -+		oi->typep = &type_scratch;
    - 
      	if (oi->disk_sizep)
      		*oi->disk_sizep = mapsize;
     -	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
    @@ object-file.c: static int loose_object_info(struct repository *r,
      		status = error(_("unable to unpack %s header"),
      			       oid_to_hex(oid));
      	}
    --
    --	if (status < 0) {
    --		/* Do nothing */
    --	} else if (hdrbuf.len) {
    --		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
    --			status = error(_("unable to parse %s header with --allow-unknown-type"),
    --				       oid_to_hex(oid));
    --	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
    -+	if (!status && parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0) {
    - 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
    - 	}
    -+	if (!allow_unknown && *oi->typep < 0)
    -+		die(_("invalid object type"));
    - 
    - 	if (status >= 0 && oi->contentp) {
    - 		*oi->contentp = unpack_loose_rest(&stream, hdr,
    -@@ object-file.c: static int loose_object_info(struct repository *r,
    - 		*oi->typep = status;
    - 	if (oi->sizep == &size_scratch)
    - 		oi->sizep = NULL;
    --	strbuf_release(&hdrbuf);
    -+	if (oi->typep == &type_scratch)
    -+		oi->typep = NULL;
    - 	oi->whence = OI_LOOSE;
    - 	return (status < 0) ? status : 0;
    - }
    -@@ object-file.c: int read_loose_object(const char *path,
    - 	git_zstream stream;
    - 	char hdr[MAX_HEADER_LEN];
    - 	struct object_info oi = OBJECT_INFO_INIT;
    -+	oi.typep = type;
    - 	oi.sizep = size;
    - 
    - 	*contents = NULL;
     @@ object-file.c: int read_loose_object(const char *path,
      		goto out;
      	}
    @@ object-file.c: int read_loose_object(const char *path,
      		error(_("unable to unpack header of %s"), path);
      		goto out;
      	}
    - 
    --	*type = parse_loose_header(hdr, &oi, 0);
    --	if (*type < 0) {
    -+	if (parse_loose_header(hdr, &oi) < 0) {
    - 		error(_("unable to parse header of %s"), path);
    - 		git_inflate_end(&stream);
    - 		goto out;
    - 	}
    -+	if (*type < 0)
    -+		die(_("invalid object type"));
    - 
    - 	if (*type == OBJ_BLOB && *size > big_file_threshold) {
    - 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
     
      ## object-store.h ##
     @@ object-store.h: int for_each_object_in_pack(struct packed_git *p,
    @@ object-store.h: int for_each_object_in_pack(struct packed_git *p,
      int unpack_loose_header(git_zstream *stream, unsigned char *map,
      			unsigned long mapsize, void *buffer,
     -			unsigned long bufsiz);
    --int parse_loose_header(const char *hdr, struct object_info *oi,
    --		       unsigned int flags);
     +			unsigned long bufsiz, struct strbuf *hdrbuf);
    -+
    -+/**
    -+ * parse_loose_header() parses the starting "<type> <len>\0" of an
    -+ * object. If it doesn't follow that format -1 is returned. To check
    -+ * the validity of the <type> populate the "typep" in the "struct
    -+ * object_info". It will be OBJ_BAD if the object type is unknown.
    -+ */
    -+int parse_loose_header(const char *hdr, struct object_info *oi);
    -+
    + int parse_loose_header(const char *hdr, struct object_info *oi,
    + 		       unsigned int flags);
      int check_object_signature(struct repository *r, const struct object_id *oid,
    - 			   void *buf, unsigned long size, const char *type);
    - int finalize_object_file(const char *tmpfile, const char *filename);
     
      ## streaming.c ##
    -@@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
    - {
    - 	struct object_info oi = OBJECT_INFO_INIT;
    - 	oi.sizep = &st->size;
    -+	oi.typep = type;
    - 
    - 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
    - 	if (!st->u.loose.mapped)
     @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
      				 st->u.loose.mapped,
      				 st->u.loose.mapsize,
      				 st->u.loose.hdr,
     -				 sizeof(st->u.loose.hdr)) < 0) ||
    --	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
     +				 sizeof(st->u.loose.hdr),
     +				 NULL) < 0) ||
    -+	    (parse_loose_header(st->u.loose.hdr, &oi) < 0) ||
    -+	    *type < 0) {
    + 	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
      		git_inflate_end(&st->z);
      		munmap(st->u.loose.mapped, st->u.loose.mapsize);
    - 		return -1;
 -:  ----------- > 13:  ba632be1520 object-file.c: split up ternary in parse_loose_header()
 -:  ----------- > 14:  ea4f446f5b1 object-file.c: stop dying in parse_loose_header()
 -:  ----------- > 15:  aacef784eab object-file.c: guard against future bugs in loose_object_info()
13:  d22d5b8b85e = 16:  050cfc7808c object-file.c: return -1, not "status" from unpack_loose_header()
12:  77f2cd439c6 ! 17:  78e3152fd94 object-file.c: return -2 on "header too long" in unpack_loose_header()
    @@ Commit message
         MAX_HEADER_LEN limit, or other negative values for "unable to unpack
         <OID> header".
     
    +    I tried setting up an enum just for these three return values, but I
    +    think the result was less readable. Let's consider doing that if we
    +    gain even more return values. For now let's do the next best thing and
    +    enumerate our known return values, and BUG() if we encounter one we
    +    don't know about.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
     @@ object-file.c: int unpack_loose_header(git_zstream *stream,
    - 	/*
    - 	 * We have a header longer than MAX_HEADER_LEN. We abort early
    - 	 * unless under we're running as e.g. "cat-file
    --	 * --allow-unknown-type".
    -+	 * --allow-unknown-type". A -2 is "header too long"
    + 	 * --allow-unknown-type".
      	 */
      	if (!header)
     -		return -1;
    @@ object-file.c: int unpack_loose_header(git_zstream *stream,
      
      static void *unpack_loose_rest(git_zstream *stream,
     @@ object-file.c: static int loose_object_info(struct repository *r,
    + 
      	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
      				      allow_unknown ? &hdrbuf : NULL);
    - 	if (hdr_ret < 0) {
    --		status = error(_("unable to unpack %s header"),
    --			       oid_to_hex(oid));
    -+		if (hdr_ret == -2)
    -+			status = error(_("header for %s too long, exceeds %d bytes"),
    -+				       oid_to_hex(oid), MAX_HEADER_LEN);
    -+		else
    -+			status = error(_("unable to unpack %s header"),
    -+				       oid_to_hex(oid));
    - 	}
    -+
    - 	if (!status && parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0) {
    - 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
    +-	if (hdr_ret < 0) {
    ++	switch (hdr_ret) {
    ++	case 0:
    ++		break;
    ++	case -1:
    + 		status = error(_("unable to unpack %s header"),
    + 			       oid_to_hex(oid));
    ++		break;
    ++	case -2:
    ++		status = error(_("header for %s too long, exceeds %d bytes"),
    ++			       oid_to_hex(oid), MAX_HEADER_LEN);
    ++		break;
    ++	default:
    ++		BUG("unknown hdr_ret value %d", hdr_ret);
      	}
    + 	if (!status) {
    + 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
     
      ## object-store.h ##
     @@ object-store.h: int for_each_packed_object(each_packed_object_fn, void *,
14:  260e9888a3e = 18:  f9bb1b799ac fsck: don't hard die on invalid object types
15:  e2afb813b28 = 19:  acbea7e2a2a object-store.h: move read_loose_object() below 'struct object_info'
16:  328f05c51b3 = 20:  edc28de229d fsck: report invalid types recorded in objects
17:  c5e6686765d ! 21:  e588c05f461 fsck: report invalid object type-path combinations
    @@ pack-check.c: static int verify_packfile(struct repository *r,
      ## t/t1006-cat-file.sh ##
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file -t and -s on corrupt loose object' '
      		# Swap the two to corrupt the repository
    - 		mv -v "$other_path" "$empty_path" &&
    + 		mv -f "$other_path" "$empty_path" &&
      		test_must_fail git fsck 2>err.fsck &&
     -		grep "hash mismatch" err.fsck &&
     +		grep "hash-path mismatch" err.fsck &&
-- 
2.32.0.606.g2e440ee2c94

