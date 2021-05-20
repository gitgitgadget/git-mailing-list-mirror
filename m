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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9188DC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6220861353
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhETM1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhETM0m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E83EC0438D7
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h16so18933032edr.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6d+JRjbCFAomMVhmQuATm5iCyYubU/pNH9krNPE3Nw=;
        b=FZNYhgseCPn2jwZ9ijFnj8ensB+fh04Hd5+8k45JBCRZK/6N13AZxD1mlvjaLuhP8s
         GuaowF+kAuA60w1YQjy72B+UoNQVoBND6bJ0WhKq42Qr3u1cMBkRSU25k3ROC5C/UZ3l
         5Mdf8CBj0r1Lf7vWfMndr5RkDw+wfOuOzp75G4pX9OyLZ98OBDJoghR/GhqFwbjgIBmX
         74MH3UoSfUDiQgVFI/+j3lA72YZSiz9Oomwf+T9kpp8iL4MiQqDf5FjbCRs7AnmujHrv
         dZdiUc5JBJUBR0y7GU2Kjggx47REv94tkan6dhYzd7FndC6ysKHW1Gt17uSSmEKidRLr
         ZqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6d+JRjbCFAomMVhmQuATm5iCyYubU/pNH9krNPE3Nw=;
        b=i8Rc7b5duaFirLQoEKlWe8MVA2Kr3a1EZa+qYJr8F2o3CPkDTicKL7h3C4dqoNiHJh
         c83fUalm5o+qzHg0hkKRE1LaqIQBmK9ZZq1PqpB62Ej+ZjE/WBesrlTkiNd7i12SnpgH
         gn27s2aY8DnJyq/9ME3qjS2e3TR/C38tXCRQY8G8VTr1ppk4blJ+6CkZh8SmgSBh0NA+
         /gp89n5IsYrgX/ot1lYwbgSKa1jh3BOCZXW+05AUE1GPTL9aP9hOfy/fb7Iv+clTJjWE
         R9Xs9VGj216ubP5WiTQWTIMQNvYibW8cYMLppo+m3u4uOV9dcOLUxU5Pogilz+fuARmg
         Sq7Q==
X-Gm-Message-State: AOAM531TQb6dJ68o19u67q0Q8Fgl8AegUn0tvUG0F5uSMOt2XyvaHDnM
        FE3996zgmwt5SiZahvtsS3CLaBn2uHUNhQ==
X-Google-Smtp-Source: ABdhPJwD3yCyWwRm8jhHnxxnYEXr1+Nsu9s5Vklb5rD3cNp6GVqU5L/Y7KQkACm8APCT3AiGAbB6PQ==
X-Received: by 2002:a50:ef15:: with SMTP id m21mr4374855eds.226.1621509794686;
        Thu, 20 May 2021 04:23:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/17] fsck: better "invalid object" error reporting
Date:   Thu, 20 May 2021 13:22:54 +0200
Message-Id: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v2's 6 patch series[1], has turned into 17 now. Less
scary than one might think though, it's mostly added test coverage +
splitting existing commits into more incremental chunks, but see the
range-diff. This should address all the feedback on v2 + more.

A brief recap summary of what this is about: We now gracefully recover
instead of dying when fsck encounters types that aren't
blob/commit/tree/tag. Those types don't exist in the wild, but you can
manually create them with "git hash-object -t garbage --literally".

So in some senes this matters to nobody, but I'm doing this as part of
general changes I've been pushing to make fsck/gc error reporting more
graceful, and errors more recoverable. We now have a few more places
in object-file.c where we don't just die(), but properly return
API-like return codes/data to the caller instead.

This does not contain any changes to how --allow-unknown-type
hash-object's --literally etc. work, as I suggested we could do in
[2]. Any such changes will need the API changes here, but these are
just the narrow fsck fixes.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com
2. https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (17):
  fsck tests: refactor one test to use a sub-repo
  fsck tests: add test for fsck-ing an unknown type
  cat-file tests: test for missing object with -t and -s
  cat-file tests: test that --allow-unknown-type isn't on by default
  rev-list tests: test for behavior with invalid object types
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  cache.h: move object functions to object-store.h
  object-file.c: make parse_loose_header_extended() public
  object-file.c: add missing braces to loose_object_info()
  object-file.c: stop dying in parse_loose_header()
  object-file.c: return -2 on "header too long" in unpack_loose_header()
  object-file.c: return -1, not "status" from unpack_loose_header()
  fsck: don't hard die on invalid object types
  object-store.h: move read_loose_object() below 'struct object_info'
  fsck: report invalid types recorded in objects
  fsck: report invalid object type-path combinations

 builtin/fast-export.c  |   2 +-
 builtin/fsck.c         |  28 ++++++-
 builtin/index-pack.c   |   2 +-
 builtin/mktag.c        |   3 +-
 cache.h                |  10 ---
 object-file.c          | 156 ++++++++++++++++++-------------------
 object-store.h         |  60 +++++++++++----
 object.c               |   4 +-
 pack-check.c           |   3 +-
 streaming.c            |  10 ++-
 t/t1006-cat-file.sh    | 169 +++++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh        |  64 +++++++++++-----
 t/t6115-rev-list-du.sh |  11 +++
 13 files changed, 387 insertions(+), 135 deletions(-)

Range-diff against v2:
 2:  5a2cd6cca9 =  1:  aa38b2bf9e fsck tests: refactor one test to use a sub-repo
 -:  ---------- >  2:  82b64abd25 fsck tests: add test for fsck-ing an unknown type
 -:  ---------- >  3:  7c3c2fe25d cat-file tests: test for missing object with -t and -s
 -:  ---------- >  4:  871b820003 cat-file tests: test that --allow-unknown-type isn't on by default
 -:  ---------- >  5:  b98da9cc89 rev-list tests: test for behavior with invalid object types
 -:  ---------- >  6:  04cc1d20f6 cat-file tests: add corrupt loose object test
 -:  ---------- >  7:  9217320888 cat-file tests: test for current --allow-unknown-type behavior
 1:  37c323a241 =  8:  12dd453879 cache.h: move object functions to object-store.h
 3:  d0d9cb3331 !  9:  6a5b78dcad fsck: don't hard die on invalid object types
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fsck: don't hard die on invalid object types
    +    object-file.c: make parse_loose_header_extended() public
     
    -    Change builtin/fsck.c to pass down a
    -    OBJECT_INFO_ALLOW_UNKNOWN_TYPE. This changes this very ungraceful
    -    error:
    +    Make the parse_loose_header_extended() function public and remove the
    +    parse_loose_header() wrapper. The only direct user of it outside of
    +    object-file.c itself was in streaming.c, that caller can simply pass
    +    the required "struct object-info *" instead.
     
    -        $ git hash-object --stdin -w -t garbage --literally </dev/null
    -        <OID>
    -        $ git fsck
    -        fatal: invalid object type
    -        $
    -
    -    Into:
    -
    -        $ git fsck
    -        error: hash mismatch for <OID_PATH> (expected <OID>)
    -        error: <OID>: object corrupt or missing: <OID_PATH>
    -        [ the rest of the fsck output here, i.e. it didn't hard die ]
    -
    -    We'll still exit with non-zero, but now we'll finish the rest of the
    -    traversal. The tests that's being added here asserts that we'll still
    -    complain about other fsck issues (e.g. an unrelated dangling blob).
    -
    -    But why are we complaining about a "hash mismatch" for an object of a
    -    type we don't know about? We shouldn't. This is the bare minimal
    -    change needed to not make fsck hard die on a repository that's been
    -    corrupted in this manner. In subsequent commits we'll teach fsck to
    -    recognize this particular type of corruption and emit a better error
    -    message.
    -
    -    The parse_loose_header() function being changed here is only used in
    -    builtin/fsck.c, see f6371f92104 (sha1_file: add read_loose_object()
    -    function, 2017-01-13) for its introduction.
    +    This change is being done in preparation for teaching
    +    read_loose_object() to accept a flag to pass to
    +    parse_loose_header(). It isn't strictly necessary for that change, we
    +    could simply use parse_loose_header_extended() there, but will leave
    +    the API in a better end state.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    - 	void *contents;
    - 	int eaten;
    - 
    --	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
    -+	if (read_loose_object(path, oid, &type, &size, &contents,
    -+			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
    - 		errors_found |= ERROR_OBJECT;
    - 		error(_("%s: object corrupt or missing: %s"),
    - 		      oid_to_hex(oid), path);
    -
      ## object-file.c ##
     @@ object-file.c: static void *unpack_loose_rest(git_zstream *stream,
       * too permissive for what we want to check. So do an anal
    @@ object-file.c: static int loose_object_info(struct repository *r,
      
      	if (status >= 0 && oi->contentp) {
     @@ object-file.c: int read_loose_object(const char *path,
    - 		      const struct object_id *expected_oid,
    - 		      enum object_type *type,
    - 		      unsigned long *size,
    --		      void **contents)
    -+		      void **contents,
    -+		      unsigned int oi_flags)
    - {
    - 	int ret = -1;
    - 	void *map = NULL;
      	unsigned long mapsize;
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
    @@ object-file.c: int read_loose_object(const char *path,
      	}
      
     -	*type = parse_loose_header(hdr, size);
    -+	*type = parse_loose_header(hdr, &oi, oi_flags);
    ++	*type = parse_loose_header(hdr, &oi, 0);
      	if (*type < 0) {
      		error(_("unable to parse header of %s"), path);
      		git_inflate_end(&stream);
     
      ## object-store.h ##
    -@@ object-store.h: int read_loose_object(const char *path,
    - 		      const struct object_id *expected_oid,
    - 		      enum object_type *type,
    - 		      unsigned long *size,
    --		      void **contents);
    -+		      void **contents,
    -+		      unsigned int oi_flags);
    - 
    - /* Retry packed storage after checking packed and loose storage */
    - #define HAS_OBJECT_RECHECK_PACKED 1
     @@ object-store.h: int for_each_packed_object(each_packed_object_fn, void *,
      int unpack_loose_header(git_zstream *stream, unsigned char *map,
      			unsigned long mapsize, void *buffer,
    @@ object-store.h: int for_each_packed_object(each_packed_object_fn, void *,
      int finalize_object_file(const char *tmpfile, const char *filename);
     
      ## streaming.c ##
    -@@ streaming.c: static struct stream_vtbl loose_vtbl = {
    - 
    - static open_method_decl(loose)
    +@@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
    + 			      const struct object_id *oid,
    + 			      enum object_type *type)
      {
    -+	struct object_info oi2 = OBJECT_INFO_INIT;
    -+	oi2.sizep = &st->size;
    ++	struct object_info oi = OBJECT_INFO_INIT;
    ++	oi.sizep = &st->size;
     +
      	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
      	if (!st->u.loose.mapped)
      		return -1;
    -@@ streaming.c: static open_method_decl(loose)
    +@@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
      				 st->u.loose.mapsize,
      				 st->u.loose.hdr,
      				 sizeof(st->u.loose.hdr)) < 0) ||
     -	    (parse_loose_header(st->u.loose.hdr, &st->size) < 0)) {
    -+	    (parse_loose_header(st->u.loose.hdr, &oi2, 0) < 0)) {
    ++	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
      		git_inflate_end(&st->z);
      		munmap(st->u.loose.mapped, st->u.loose.mapsize);
      		return -1;
    -
    - ## t/t1450-fsck.sh ##
    -@@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
    - 	test_i18ngrep "bad index file" errors
    - '
    - 
    -+test_expect_success 'fsck error and recovery on invalid object type' '
    -+	test_create_repo garbage-type &&
    -+	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
    -+	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
    -+	test_must_fail git -C garbage-type fsck >out 2>err &&
    -+	grep "$garbage_blob: object corrupt or missing:" err &&
    -+	grep "dangling blob $empty_blob" out
    -+'
    -+
    - test_done
 -:  ---------- > 10:  5d31d7e1a5 object-file.c: add missing braces to loose_object_info()
 -:  ---------- > 11:  ee28089219 object-file.c: stop dying in parse_loose_header()
 -:  ---------- > 12:  77f2cd439c object-file.c: return -2 on "header too long" in unpack_loose_header()
 -:  ---------- > 13:  d22d5b8b85 object-file.c: return -1, not "status" from unpack_loose_header()
 -:  ---------- > 14:  260e9888a3 fsck: don't hard die on invalid object types
 4:  81fffefcf9 ! 15:  e2afb813b2 object-store.h: move read_loose_object() below 'struct object_info'
    @@ Metadata
      ## Commit message ##
         object-store.h: move read_loose_object() below 'struct object_info'
     
    -    Move the definition of read_loose_object() below "struct
    +    Move the declaration of read_loose_object() below "struct
         object_info". In the next commit we'll add a "struct object_info *"
         parameter to it, moving it will avoid a forward declaration of the
         struct.
 5:  5fb6ac4fae ! 16:  328f05c51b fsck: report invalid types recorded in objects
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/cat-file.c ##
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    - 	struct strbuf sb = STRBUF_INIT;
    - 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
    - 	const char *path = force_path;
    -+	int ret;
    - 
    - 	if (unknown_type)
    - 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    - 	switch (opt) {
    - 	case 't':
    - 		oi.type_name = &sb;
    --		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
    -+		ret = oid_object_info_extended(the_repository, &oid, &oi, flags);
    -+		if (!unknown_type && ret < 0)
    - 			die("git cat-file: could not get object info");
    - 		if (sb.len) {
    - 			printf("%s\n", sb.buf);
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    - 
    - 	case 's':
    - 		oi.sizep = &size;
    --		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
    -+		ret = oid_object_info_extended(the_repository, &oid, &oi, flags);
    -+		if (!unknown_type && ret < 0)
    - 			die("git cat-file: could not get object info");
    - 		printf("%"PRIuMAX"\n", (uintmax_t)size);
    - 		return 0;
    -
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
      	unsigned long size;
    @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *p
      
     
      ## object-file.c ##
    -@@ object-file.c: int parse_loose_header(const char *hdr,
    - 	 * we're obtaining the type using '--allow-unknown-type'
    - 	 * option.
    - 	 */
    --	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
    --		type = 0;
    --	else if (type < 0)
    -+	if (type < 0 && !(flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE))
    - 		die(_("invalid object type"));
    - 	if (oi->typep)
    - 		*oi->typep = type;
    -@@ object-file.c: static int loose_object_info(struct repository *r,
    - 	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
    - 		status = error(_("unable to unpack %s header"),
    - 			       oid_to_hex(oid));
    --	if (status < 0)
    -+	if (status < 0) {
    - 		; /* Do nothing */
    --	else if (hdrbuf.len) {
    -+	} else if (hdrbuf.len) {
    - 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
    - 			status = error(_("unable to parse %s header with --allow-unknown-type"),
    - 				       oid_to_hex(oid));
    --	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
    --		status = error(_("unable to parse %s header"), oid_to_hex(oid));
    -+	} else {
    -+		status = parse_loose_header(hdr, oi, flags);
    -+		if (status < 0 && !(flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE))
    -+			error(_("unable to parse %s header"), oid_to_hex(oid));
    -+	}
    - 
    - 	if (status >= 0 && oi->contentp) {
    - 		*oi->contentp = unpack_loose_rest(&stream, hdr,
     @@ object-file.c: static int check_stream_oid(git_zstream *stream,
      
      int read_loose_object(const char *path,
    @@ object-file.c: int read_loose_object(const char *path,
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
     -	struct object_info oi = OBJECT_INFO_INIT;
    + 	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
    +-	oi.typep = type;
     -	oi.sizep = size;
     +	enum object_type *type = oi->typep;
     +	unsigned long *size = oi->sizep;
    @@ object-file.c: int read_loose_object(const char *path,
      		goto out;
      	}
      
    --	*type = parse_loose_header(hdr, &oi, oi_flags);
    --	if (*type < 0) {
    --		error(_("unable to parse header of %s"), path);
    -+	*type = parse_loose_header(hdr, oi, oi_flags);
    -+	if (*type < 0 && !(oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
    -+		error(_("unable to parse header %s"), path);
    +-	if (parse_loose_header(hdr, &oi) < 0) {
    ++	if (parse_loose_header(hdr, oi) < 0) {
    + 		error(_("unable to parse header of %s"), path);
      		git_inflate_end(&stream);
      		goto out;
    - 	}
     @@ object-file.c: int read_loose_object(const char *path,
      			goto out;
      		}
    @@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
      	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
      	test_when_finished "git update-ref -d refs/heads/invalid" &&
     @@ t/t1450-fsck.sh: test_expect_success 'fsck error and recovery on invalid object type' '
    - 	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
      	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
      	test_must_fail git -C garbage-type fsck >out 2>err &&
    + 	grep -e "^error" -e "^fatal" err >errors &&
    +-	test_line_count = 2 errors &&
    +-	grep "error: hash mismatch for" err &&
     -	grep "$garbage_blob: object corrupt or missing:" err &&
    ++	test_line_count = 1 errors &&
     +	grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err &&
    -+	grep error: err >err.errors &&
    -+	test_line_count = 1 err.errors &&
      	grep "dangling blob $empty_blob" out
      '
      
 6:  226d2031bc ! 17:  c5e6686765 fsck: report invalid object type-path combinations
    @@ Metadata
      ## Commit message ##
         fsck: report invalid object type-path combinations
     
    -    fsck: improve error on loose object hash mismatch
    -
         Improve the error that's emitted in cases where we find a loose object
         we parse, but which isn't at the location we expect it to be.
     
    @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *p
      	struct strbuf sb = STRBUF_INIT;
      	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
      	struct object_info oi;
    -+	struct object_id real_oid = null_oid;
    ++	struct object_id real_oid = *null_oid();
      	int found = 0;
      	oi.type_name = &sb;
      	oi.sizep = &size;
    @@ object-file.c: int check_object_signature(struct repository *r, const struct obj
      			break;
      		r->hash_algo->update_fn(&c, buf, readlen);
      	}
    --	r->hash_algo->final_fn(real_oid.hash, &c);
    -+	r->hash_algo->final_fn(real_oid->hash, &c);
    +-	r->hash_algo->final_oid_fn(&real_oid, &c);
    ++	r->hash_algo->final_oid_fn(real_oid, &c);
      	close_istream(st);
     -	return !oideq(oid, &real_oid) ? -1 : 0;
     +	return !oideq(oid, real_oid) ? -1 : 0;
    @@ object-file.c: int read_loose_object(const char *path,
     -			error(_("hash mismatch for %s (expected %s)"), path,
     -			      oid_to_hex(expected_oid));
     +					   *contents, *size, oi->type_name->buf, real_oid)) {
    -+			if (oideq(real_oid, &null_oid))
    ++			if (oideq(real_oid, null_oid()))
     +				BUG("should only get OID mismatch errors with mapped contents");
      			free(*contents);
      			goto out;
    @@ object-store.h: int oid_object_info_extended(struct repository *r,
      		      struct object_info *oi,
      		      unsigned int oi_flags);
     @@ object-store.h: int unpack_loose_header(git_zstream *stream, unsigned char *map,
    - int parse_loose_header(const char *hdr, struct object_info *oi,
    - 		       unsigned int flags);
    + int parse_loose_header(const char *hdr, struct object_info *oi);
    + 
      int check_object_signature(struct repository *r, const struct object_id *oid,
     -			   void *buf, unsigned long size, const char *type);
     +			   void *buf, unsigned long size, const char *type,
    @@ pack-check.c: static int verify_packfile(struct repository *r,
      				    oid_to_hex(&oid), p->pack_name);
      		else if (fn) {
     
    + ## t/t1006-cat-file.sh ##
    +@@ t/t1006-cat-file.sh: test_expect_success 'cat-file -t and -s on corrupt loose object' '
    + 		# Swap the two to corrupt the repository
    + 		mv -v "$other_path" "$empty_path" &&
    + 		test_must_fail git fsck 2>err.fsck &&
    +-		grep "hash mismatch" err.fsck &&
    ++		grep "hash-path mismatch" err.fsck &&
    + 
    + 		# confirm that cat-file is reading the new swapped-in
    + 		# blob...
    +
      ## t/t1450-fsck.sh ##
     @@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
      	(
-- 
2.32.0.rc0.406.g73369325f8d

