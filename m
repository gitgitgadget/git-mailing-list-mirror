Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E2EC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA0261A05
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352877AbhJAJSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJAJSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26560C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:16:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h15so12775549wrc.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNNXZyEtMTn4Sa4VhSiVBdaDav9z7CYU2+Z8q7oygsc=;
        b=bnyp4rncfs6I7bVZ1D+MpfD30LRgh+FV/sX4IMrn9SJWdjKSB0PaW+TQMd7gKGH8rJ
         zr6lFm5o9ZTWmruTVweFFJuy35jrGgYHUEUWX7wYwirL0FmFPYW4peCSwMtEJRDkDpwZ
         bw6EEsuj8SQ23KQrb6cNV2gjJq4p9wuRL6iljnyp8s9JW1Rck2puoj4PpF0DNBxEvuzJ
         /+Cmw7BnUPStgO/QgvrwD6gsxSjm2Ty8FI/2ZRCaoQzTqHPeH8/oZ4GXxlLG6IbACbzV
         7MsmZfmoKet2dwVBIPFL4aEyIddTS8fVd52iYuc7ONl027ZEZ7iTXGCZHRJV35UrwKxZ
         yobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNNXZyEtMTn4Sa4VhSiVBdaDav9z7CYU2+Z8q7oygsc=;
        b=3q+LdQsOwPMPTngvbvkH442rdDT7wongZN5NE+pC7yznjroY3XJiXqkfOnk3gkY0C8
         eZLaVjk8fcHiCqF6fMEu2HxLvUqnGQagNG6Ql1qtVUiEohSnZhZT7adiOA6L7l0WFhUy
         xu9xbw8fByFHGuIwdtZBVZgWeHBrxALESbfnO2WveMESZJrDd2wXgGJBuISIbU8+5qob
         llkC0w5RevWqbv+nR5bffq0PMZ0sL6mk2z4iAeh3KMe8AB0Ky1aufawhOpEFam6C/2QW
         dhnKMcc+TBgBiA5enVkWz4cm1bvgAkF7/NEuVbOHAXPX6Lk3Bl9deDhXwtWTWI1lL1bf
         9nPg==
X-Gm-Message-State: AOAM533rsYaRSnXAGvYS4FVSqm3mjN6F0yWJ18t/NJVzKQvxUsVBQ8qF
        tpSY3iZwtEbtcISzTtuqHPOx7FO6udwkGA==
X-Google-Smtp-Source: ABdhPJz87V8wQtAW5JDpZQSkpbKGVi9C0tv6+vOOglFC9FM89S1QfaS5H6aw2f5kO8CwXc0aOJ2Q1Q==
X-Received: by 2002:a5d:44c9:: with SMTP id z9mr10792821wrr.272.1633079817305;
        Fri, 01 Oct 2021 02:16:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:16:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 00/17] fsck: lib-ify object-file.c & better fsck "invalid object" error reporting
Date:   Fri,  1 Oct 2021 11:16:36 +0200
Message-Id: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves fsck error reporting, see the examples in the commit
messages of 16/17 and 17/17. To get there I've lib-ified more things
in object-file.c and the general object APIs, i.e. now we'll return
error codes instead of calling die() in these cases.

This should fix the issues noted about v9[1]. I.e.:

 A. Junio's right in [2] that the "type" can't be trusted after a
    failed read_loose_object(). I.e. if we'll fail before we can parse
    it out it'll be uninitialized. It's now initialized to OBJ_NONE,
    we can trust it if it's set to something else.

 B. I re-arranged much of 16/17 and 17/17 to make the diff (but not
    the range-diff) smaller.

 C. We now share a single "strbuf" across the whole fsck_loose() walk
    for saving away the type name, instead of allocating a new one
    each time. This is both a better memory usage pattern, and makes
    fsck_loose() itself simpler.

    It also allows for using much of the pre-image as-is, i.e. the
    whole "goto cleanup" is gone. Likewise instead of "ret" and "err"
    we just have the "err" variable now.

 D. I fixed the redundant/left-over test setup noted by Andrei
    Rybak[3].

1. http://lore.kernel.org/git/cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com
2. https://lore.kernel.org/git/xmqqsfxlaicg.fsf@gitster.g/
3. https://lore.kernel.org/git/78bab348-ba3a-7a27-e32e-6b75f91178db@gmail.com/

Ævar Arnfjörð Bjarmason (17):
  fsck tests: add test for fsck-ing an unknown type
  fsck tests: refactor one test to use a sub-repo
  fsck tests: test current hash/type mismatch behavior
  fsck tests: test for garbage appended to a loose object
  cat-file tests: move bogus_* variable declarations earlier
  cat-file tests: test for missing/bogus object with -t, -s and -p
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  object-file.c: don't set "typep" when returning non-zero
  object-file.c: return -1, not "status" from unpack_loose_header()
  object-file.c: make parse_loose_header_extended() public
  object-file.c: simplify unpack_loose_short_header()
  object-file.c: use "enum" return type for unpack_loose_header()
  object-file.c: return ULHR_TOO_LONG on "header too long"
  object-file.c: stop dying in parse_loose_header()
  fsck: don't hard die on invalid object types
  fsck: report invalid object type-path combinations

 builtin/fast-export.c |   2 +-
 builtin/fsck.c        |  44 +++++++--
 builtin/index-pack.c  |   2 +-
 builtin/mktag.c       |   3 +-
 cache.h               |  45 ++++++++-
 object-file.c         | 176 +++++++++++++++------------------
 object-store.h        |   7 +-
 object.c              |   4 +-
 pack-check.c          |   3 +-
 streaming.c           |  27 +++--
 t/oid-info/oid        |   2 +
 t/t1006-cat-file.sh   | 223 +++++++++++++++++++++++++++++++++++++++---
 t/t1450-fsck.sh       |  97 ++++++++++++++----
 13 files changed, 476 insertions(+), 159 deletions(-)

Range-diff against v9:
 1:  520732612f7 !  1:  00936435423 fsck tests: add test for fsck-ing an unknown type
    @@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
     +	(
     +		cd garbage-type &&
     +
    -+		empty=$(git hash-object --stdin -w -t blob </dev/null) &&
    -+		garbage=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
    ++		git hash-object --stdin -w -t garbage --literally </dev/null &&
     +
     +		cat >err.expect <<-\EOF &&
     +		fatal: invalid object type
 2:  af7086623fe =  2:  32a2f9cc0c9 fsck tests: refactor one test to use a sub-repo
 3:  102bc4f0176 =  3:  00d661a6032 fsck tests: test current hash/type mismatch behavior
 4:  ff7fc09d5a1 =  4:  a527e3b262c fsck tests: test for garbage appended to a loose object
 5:  278df093239 =  5:  7a63d30aef3 cat-file tests: move bogus_* variable declarations earlier
 6:  290bf983590 =  6:  a563c7efe1c cat-file tests: test for missing/bogus object with -t, -s and -p
 7:  a41b2c571e5 =  7:  c5affb65b7e cat-file tests: add corrupt loose object test
 8:  cedeb117330 =  8:  76f9888a6f7 cat-file tests: test for current --allow-unknown-type behavior
 9:  6f0673d38c8 =  9:  85a91f43634 object-file.c: don't set "typep" when returning non-zero
10:  6637e8fd2ca = 10:  51eaa2e8479 object-file.c: return -1, not "status" from unpack_loose_header()
11:  51db08ebbae = 11:  5cd2ba830e9 object-file.c: make parse_loose_header_extended() public
12:  dffe5581f6f = 12:  6899c6ec17a object-file.c: simplify unpack_loose_short_header()
13:  eb7c949c8b7 = 13:  a3bdd53d296 object-file.c: use "enum" return type for unpack_loose_header()
14:  f4cc7271df7 = 14:  5a7c2855b50 object-file.c: return ULHR_TOO_LONG on "header too long"
15:  25d6ec668d4 = 15:  3ec9fee7ee9 object-file.c: stop dying in parse_loose_header()
16:  6ce0414b2b7 ! 16:  9b75ac7c8ed fsck: don't hard die on invalid object types
    @@ Commit message
         f6371f92104 (sha1_file: add read_loose_object() function, 2017-01-13)
         for the introduction of read_loose_object().
     
    -    Since we're now passing in a "oi.type_name" we'll have to clean up the
    -    allocated "strbuf sb". That we're doing it right is asserted by
    -    e.g. the "fsck notices broken commit" test added in 03818a4a94c
    -    (split_ident: parse timestamp from end of line, 2013-10-14). To do
    -    that switch to a "goto cleanup" pattern, and while we're at it factor
    -    out the already duplicated free(content) to use that pattern.
    +    Since we'll need a "struct strbuf" to hold the "type_name" let's pass
    +    it to the for_each_loose_file_in_objdir() callback to avoid allocating
    +    a new one for each loose object in the iteration. It also makes the
    +    memory management simpler than sticking it in fsck_loose() itself, as
    +    we'll only need to strbuf_reset() it, with no need to do a
    +    strbuf_release() before each "return".
    +
    +    Before this commit we'd never check the "type" if read_loose_object()
    +    failed, but now we do. We therefore need to initialize it to OBJ_NONE
    +    to be able to tell the difference between e.g. its
    +    unpack_loose_header() having failed, and us getting past that and into
    +    parse_loose_header().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    +@@ builtin/fsck.c: static void get_default_heads(void)
    + 	}
    + }
    + 
    ++struct for_each_loose_cb
    ++{
    ++	struct progress *progress;
    ++	struct strbuf obj_type;
    ++};
    ++
    + static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    + {
    ++	struct for_each_loose_cb *cb_data = data;
    + 	struct object *obj;
    +-	enum object_type type;
    ++	enum object_type type = OBJ_NONE;
      	unsigned long size;
      	void *contents;
      	int eaten;
    -+	struct strbuf sb = STRBUF_INIT;
     +	struct object_info oi = OBJECT_INFO_INIT;
     +	int err = 0;
      
     -	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
    -+	oi.type_name = &sb;
    ++	strbuf_reset(&cb_data->obj_type);
    ++	oi.type_name = &cb_data->obj_type;
     +	oi.sizep = &size;
     +	oi.typep = &type;
     +
     +	if (read_loose_object(path, oid, &contents, &oi) < 0)
     +		err = error(_("%s: object corrupt or missing: %s"),
     +			    oid_to_hex(oid), path);
    -+	if (type < 0)
    ++	if (type != OBJ_NONE && type < 0)
     +		err = error(_("%s: object is of unknown type '%s': %s"),
    -+			    oid_to_hex(oid), sb.buf, path);
    -+	if (err) {
    ++			    oid_to_hex(oid), cb_data->obj_type.buf, path);
    ++	if (err < 0) {
      		errors_found |= ERROR_OBJECT;
     -		error(_("%s: object corrupt or missing: %s"),
     -		      oid_to_hex(oid), path);
    --		return 0; /* keep checking other objects */
    -+		goto cleanup;
    - 	}
    - 
    - 	if (!contents && type != OBJ_BLOB)
    -@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    - 		errors_found |= ERROR_OBJECT;
    - 		error(_("%s: object could not be parsed: %s"),
    - 		      oid_to_hex(oid), path);
    --		if (!eaten)
    --			free(contents);
    --		return 0; /* keep checking other objects */
    -+		goto cleanup_eaten;
    + 		return 0; /* keep checking other objects */
      	}
      
    - 	obj->flags &= ~(REACHABLE | SEEN);
    -@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    - 	if (fsck_obj(obj, contents, size))
    - 		errors_found |= ERROR_OBJECT;
    +@@ builtin/fsck.c: static int fsck_cruft(const char *basename, const char *path, void *data)
    + 	return 0;
    + }
      
    -+cleanup_eaten:
    - 	if (!eaten)
    - 		free(contents);
    -+cleanup:
    -+	strbuf_release(&sb);
    - 	return 0; /* keep checking other objects, even if we saw an error */
    +-static int fsck_subdir(unsigned int nr, const char *path, void *progress)
    ++static int fsck_subdir(unsigned int nr, const char *path, void *data)
    + {
    ++	struct for_each_loose_cb *cb_data = data;
    ++	struct progress *progress = cb_data->progress;
    + 	display_progress(progress, nr + 1);
    + 	return 0;
    + }
    +@@ builtin/fsck.c: static int fsck_subdir(unsigned int nr, const char *path, void *progress)
    + static void fsck_object_dir(const char *path)
    + {
    + 	struct progress *progress = NULL;
    ++	struct for_each_loose_cb cb_data = {
    ++		.obj_type = STRBUF_INIT,
    ++		.progress = progress,
    ++	};
    + 
    + 	if (verbose)
    + 		fprintf_ln(stderr, _("Checking object directory"));
    +@@ builtin/fsck.c: static void fsck_object_dir(const char *path)
    + 		progress = start_progress(_("Checking object directories"), 256);
    + 
    + 	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
    +-				      progress);
    ++				      &cb_data);
    + 	display_progress(progress, 256);
    + 	stop_progress(&progress);
    ++	strbuf_release(&cb_data.obj_type);
      }
      
    + static int fsck_head_link(const char *head_ref_name,
     
      ## object-file.c ##
     @@ object-file.c: static int check_stream_oid(git_zstream *stream,
    @@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
      	git init --bare garbage-type &&
      	(
      		cd garbage-type &&
    -@@ t/t1450-fsck.sh: test_expect_success 'fsck hard errors on an invalid object type' '
    + 
    +-		git hash-object --stdin -w -t garbage --literally </dev/null &&
    ++		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
    + 
    + 		cat >err.expect <<-\EOF &&
      		fatal: invalid object type
      		EOF
      		test_must_fail git fsck >out 2>err &&
    @@ t/t1450-fsck.sh: test_expect_success 'fsck hard errors on an invalid object type
     -		test_must_be_empty out
     +		grep -e "^error" -e "^fatal" err >errors &&
     +		test_line_count = 1 errors &&
    -+		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err &&
    -+		grep "dangling blob $empty_blob" out
    ++		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err
      	)
      '
      
17:  8d926e41fc3 ! 17:  838df0a979b fsck: report invalid object type-path combinations
    @@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
     
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    - 	struct object *obj;
    - 	enum object_type type;
    - 	unsigned long size;
    --	void *contents;
    -+	unsigned char *contents = NULL;
    + 	void *contents;
      	int eaten;
    - 	struct strbuf sb = STRBUF_INIT;
      	struct object_info oi = OBJECT_INFO_INIT;
    --	int err = 0;
     +	struct object_id real_oid = *null_oid();
    -+	int ret;
    + 	int err = 0;
      
    - 	oi.type_name = &sb;
    + 	strbuf_reset(&cb_data->obj_type);
    +@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
      	oi.sizep = &size;
      	oi.typep = &type;
      
     -	if (read_loose_object(path, oid, &contents, &oi) < 0)
     -		err = error(_("%s: object corrupt or missing: %s"),
     -			    oid_to_hex(oid), path);
    -+	ret = read_loose_object(path, oid, &real_oid, (void **)&contents, &oi);
    -+	if (ret < 0) {
    ++	if (read_loose_object(path, oid, &real_oid, &contents, &oi) < 0) {
     +		if (contents && !oideq(&real_oid, oid))
    -+			error(_("%s: hash-path mismatch, found at: %s"),
    -+			      oid_to_hex(&real_oid), path);
    ++			err = error(_("%s: hash-path mismatch, found at: %s"),
    ++				    oid_to_hex(&real_oid), path);
     +		else
    -+			error(_("%s: object corrupt or missing: %s"),
    -+			      oid_to_hex(oid), path);
    ++			err = error(_("%s: object corrupt or missing: %s"),
    ++				    oid_to_hex(oid), path);
     +	}
    - 	if (type < 0)
    --		err = error(_("%s: object is of unknown type '%s': %s"),
    --			    oid_to_hex(oid), sb.buf, path);
    --	if (err) {
    -+		ret = error(_("%s: object is of unknown type '%s': %s"),
    -+			    oid_to_hex(&real_oid), sb.buf, path);
    -+	if (ret < 0) {
    + 	if (type != OBJ_NONE && type < 0)
    + 		err = error(_("%s: object is of unknown type '%s': %s"),
    +-			    oid_to_hex(oid), cb_data->obj_type.buf, path);
    ++			    oid_to_hex(&real_oid), cb_data->obj_type.buf,
    ++			    path);
    + 	if (err < 0) {
      		errors_found |= ERROR_OBJECT;
    - 		goto cleanup;
    - 	}
    + 		return 0; /* keep checking other objects */
     
      ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
-- 
2.33.0.1375.g5eed55aa1b5

