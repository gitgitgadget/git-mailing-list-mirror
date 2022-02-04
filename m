Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE507C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbiBDNvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359078AbiBDNvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F048C06173D
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r19so666934wrg.10
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9jOgGfM/6CFA9A6Cut/L1r0KvoPt0TdOaLn93KzcHg=;
        b=nNcczvBjotPF2HbopSpDA/HD3G9xKJSfyMueDLttdxiKKuITosKqOnai0AlhaIsKjE
         dPQKpDr3B3xnHRQK+xCLfnZkXjK2+OXN2fCepqWgW6Pdx9aeoUI8l5o7N44GsbAbupf7
         x0YkxyjVghCxYlwbpp2Nmly9yB9PnALWez6GlwBFPJxHZLq6TIiPp59xJ1zBpqbSRQAK
         9Hy0jzorgOIJ4qZ6UkZcSo7egqGm+oQVe1cKTTxbkyxKuXF/vDy2PBbQuGW6pplvQVA5
         loIR18v3CGhhNaGJq68fPfWJDRVfx9DElbjION834O3DV7mo0XjVy6r5Wzw4vQSAb+8d
         FrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9jOgGfM/6CFA9A6Cut/L1r0KvoPt0TdOaLn93KzcHg=;
        b=Q4lGxa/6wUoiqE8/9Ux5kS/WTjKoQ9NmQhl4Y5pA1glG1gHTZgpEKk7qE0bj2vyYcW
         htLqTKmLUmSA26jqbqJmzuF5Y9/ZG91uDnJL70Bc3GV3zF0HX65/VhQVNzzCVGbnu0qu
         aGcjrYo3i3TQyHG5CU4mq8kDiJF1VQ483H9n3/2juqObkWiaBGSGifS2wxEwygYh0evP
         X2iVNNOY7fR9egHBilp/5C/DSgqkI2sWaAxSdp6AUFCnK4e1ESEvViwq8MfWqbAhxaxn
         78lIJtPFlR5aWDXcHZlgVXR2vKEOMCsw87JMxn0O5gCkoQto9a5SOtxL4Kk71MN73iM4
         FwvQ==
X-Gm-Message-State: AOAM533nW0XQxfJxSqJ1ebAS7zTB8MfAaFLAYbQ9oKoG8Nj7Pv3g5p4E
        dcKRszB7hfaY/v/80ZBoWoIzP9Clu6wT7Q==
X-Google-Smtp-Source: ABdhPJyrhivl2jXL6lO6DqmmzKz1OUncQYjuNACcB3acrp15FYTSZLmbia2/UnTzKHT5FBG/WvQsWQ==
X-Received: by 2002:a05:6000:1a87:: with SMTP id f7mr2478754wry.445.1643982689916;
        Fri, 04 Feb 2022 05:51:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] object-file API: pass object enums, tidy up streaming interface
Date:   Fri,  4 Feb 2022 14:51:14 +0100
Message-Id: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a topic to prepare APIs for Han Xin's streaming "git
unpack-objects" topic, which I'll be re-rolling on top of this with
his approval[1].

Since v1 of this topic[2] I've thoroughly addressed the feedback Junio
had on it. I was introducing some new object-name.c APIs for reasons
that turned out to be that I was making things too complex, by doing
the "enum" step in-between several incremental updates to
check_object_signature() and its callers.

That's now a much simpler 05-07/11, with the changing of the API users
being one atomic change.

I also made some other amendmends to reduce the diff size, e.g. not
moving the check_object_signature() prototype from cache.h to
object-store.h (a sensible change, but can be done in some other
cleanup).

1. https://lore.kernel.org/git/CAO0brD2Pe0aKSiBphZS861gC=nZk+q2GtXDN4pPjAQnPdns3TA@mail.gmail.com/
2. https://lore.kernel.org/git/cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (11):
  object-file.c: split up declaration of unrelated variables
  object-file API: return "void", not "int" from hash_object_file()
  object-file API: add a format_object_header() function
  object-file API: have write_object_file() take "enum object_type"
  object API: correct "buf" v.s. "map" mismatch in *.c and *.h
  object API: make check_object_signature() oideq()-like, move docs
  object-file API: split up and simplify check_object_signature()
  object API: rename hash_object_file_literally() to write_*()
  object-file API: have hash_object_file() take "enum object_type"
  object-file.c: add a literal version of write_object_file_prepare()
  object-file API: pass an enum to read_object_with_reference()

 apply.c                  |  12 ++--
 builtin/cat-file.c       |  11 +--
 builtin/checkout.c       |   2 +-
 builtin/fast-export.c    |   4 +-
 builtin/fast-import.c    |  12 ++--
 builtin/grep.c           |   4 +-
 builtin/hash-object.c    |   2 +-
 builtin/index-pack.c     |  10 ++-
 builtin/mktag.c          |   7 +-
 builtin/mktree.c         |   2 +-
 builtin/notes.c          |   3 +-
 builtin/pack-objects.c   |   2 +-
 builtin/receive-pack.c   |   2 +-
 builtin/replace.c        |   4 +-
 builtin/tag.c            |   2 +-
 builtin/unpack-objects.c |   8 +--
 bulk-checkin.c           |   4 +-
 cache-tree.c             |   8 +--
 cache.h                  |  20 +++++-
 commit.c                 |   2 +-
 convert.c                |   2 +-
 diffcore-rename.c        |   2 +-
 dir.c                    |   2 +-
 http-push.c              |   2 +-
 log-tree.c               |   2 +-
 match-trees.c            |   2 +-
 merge-ort.c              |   4 +-
 merge-recursive.c        |   2 +-
 notes-cache.c            |   2 +-
 notes.c                  |   8 +--
 object-file.c            | 146 +++++++++++++++++++++++++--------------
 object-store.h           |  24 ++++---
 object.c                 |   5 +-
 pack-check.c             |   9 ++-
 read-cache.c             |   2 +-
 tree-walk.c              |   6 +-
 36 files changed, 203 insertions(+), 138 deletions(-)

Range-diff against v1:
 1:  53334bc970a =  1:  53334bc970a object-file.c: split up declaration of unrelated variables
 2:  ab1d204f49b =  2:  5ba49778ac1 object-file API: return "void", not "int" from hash_object_file()
 3:  64484e046ea =  3:  92fd020d199 object-file API: add a format_object_header() function
 4:  d6231ac68fe =  4:  d259f901114 object-file API: have write_object_file() take "enum object_type"
 -:  ----------- >  5:  207aec4eb64 object API: correct "buf" v.s. "map" mismatch in *.c and *.h
 5:  719fcfbe13c !  6:  636a647ac51 object-file API: provide a hash_object_file_oideq()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-file API: provide a hash_object_file_oideq()
    +    object API: make check_object_signature() oideq()-like, move docs
     
    -    Provide a new hash_object_file_oideq() for those callers of
    -    check_object_signature() that don't care about its streaming
    -    interface. I.e. at the start of that function we do:
    +    Make the return value of check_object_signature() behave like oideq()
    +    and memcmp() instead of returning negative values on failure.
     
    -            if (map) {
    -                    hash_object_file(r->hash_algo, map, size, type, real_oid);
    -                    return !oideq(oid, real_oid) ? -1 : 0;
    -            }
    +    This reduces the boilerplate required when calling the function, and
    +    makes the calling code behave the same is if though we'd called
    +    oideq(), which is basically what we're doing here. We already had some
    +    callers using "f() < 0", with others using "!f()". Instead of
    +    declaring the latter a bug let's convert all callers to it.
     
    -    These callers always provide a "map" (or "buf[fer]"). Let's have them
    -    call this simpler hash_object_file_oideq() function instead.
    +    It is unfortunate that there's also cases where we "return -1" on
    +    various errors, and we can't tell those apart from the expected OID
    +    being less than the real OID, but this was the case already.
     
    -    None of them use a non-NULL "real_oid" argument, but let's provide it
    -    like check_object_signature() did. This'll make it easy to have these
    -    emit better error messages in the future as was done in
    -    96e41f58fe1 (fsck: report invalid object type-path combinations,
    -    2021-10-01), i.e. the die() calls here can emit not only the OID we
    -    expected, but also what we got.
    +    This change is rather dangerous stand-alone as we're changing the
    +    return semantics, but not changing the prototype. Therefore any
    +    out-of-tree code rebased on this change would start doing the opposite
    +    of what it was meant to do. In a subsequent commit we'll make that a
    +    non-issue by changing the signature of the function, ensuring that the
    +    compiler will catch any such misuse.
    +
    +    While we're at it let's re-flow some of the callers to wrap at 79
    +    characters, and move the API documentation to cache.h, where the
    +    prototype of this function lives.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
      			die("could not read blob %s", oid_to_hex(oid));
     -		if (check_object_signature(the_repository, oid, buf, size,
     -					   type_name(type), NULL) < 0)
    -+		if (!hash_object_file_oideq(the_repository->hash_algo, buf,
    -+					    size, type, oid, NULL))
    ++		if (!check_object_signature(the_repository, oid, buf, size,
    ++					    type_name(type), NULL))
      			die("oid mismatch in blob %s", oid_to_hex(oid));
      		object = parse_object_buffer(the_repository, oid, type,
      					     size, buf, &eaten);
    @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
     -		if (check_object_signature(the_repository, &d->oid,
     -					   data, size,
     -					   type_name(type), NULL))
    -+		if (!hash_object_file_oideq(the_repository->hash_algo, data,
    -+					    size, type, &d->oid, NULL))
    ++		if (!check_object_signature(the_repository, &d->oid, data,
    ++					    size, type_name(type), NULL))
      			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
      
      		/*
    @@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, i
     -	ret = check_object_signature(the_repository, repl,
     -				     buffer, size, type_name(*tagged_type),
     -				     NULL);
    -+	ret = !hash_object_file_oideq(the_repository->hash_algo, buffer, size,
    -+				      *tagged_type, repl, NULL);
    ++	ret = !check_object_signature(the_repository, repl, buffer, size,
    ++				      type_name(*tagged_type), NULL);
      	free(buffer);
      
      	return ret;
     
    + ## cache.h ##
    +@@ cache.h: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
    + struct object_info;
    + int parse_loose_header(const char *hdr, struct object_info *oi);
    + 
    ++/**
    ++ * With in-core object data in "buf", rehash it to make sure the
    ++ * object name actually matches "oid" to detect object corruption.
    ++ * With "buf" == NULL, try reading the object named with "oid" using
    ++ * the streaming interface and rehash it to do the same.
    ++ *
    ++ * Treat the return value like oideq() (which is like memcmp()),
    ++ * except that negative values might also indicate a generic error.
    ++ */
    + int check_object_signature(struct repository *r, const struct object_id *oid,
    + 			   void *buf, unsigned long size, const char *type,
    + 			   struct object_id *real_oidp);
    +
      ## object-file.c ##
    -@@ object-file.c: void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    - 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
    +@@ object-file.c: int format_object_header(char *str, size_t size, enum object_type type,
    + 	return format_object_header_literally(str, size, name, objsize);
      }
      
    -+int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
    -+			   unsigned long len, enum object_type type,
    -+			   const struct object_id *oid,
    -+			   struct object_id *real_oidp)
    -+{
    -+	struct object_id tmp;
    -+	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
    -+
    -+	hash_object_file(algo, buf, len, type_name(type), real_oid);
    -+
    +-/*
    +- * With in-core object data in "buf", rehash it to make sure the
    +- * object name actually matches "oid" to detect object corruption.
    +- * With "buf" == NULL, try reading the object named with "oid" using
    +- * the streaming interface and rehash it to do the same.
    +- */
    + int check_object_signature(struct repository *r, const struct object_id *oid,
    + 			   void *buf, unsigned long size, const char *type,
    + 			   struct object_id *real_oidp)
    +@@ object-file.c: int check_object_signature(struct repository *r, const struct object_id *oid,
    + 
    + 	if (buf) {
    + 		hash_object_file(r->hash_algo, buf, size, type, real_oid);
    +-		return !oideq(oid, real_oid) ? -1 : 0;
    ++		return oideq(oid, real_oid);
    + 	}
    + 
    + 	st = open_istream(r, oid, &obj_type, &size, NULL);
    +@@ object-file.c: int check_object_signature(struct repository *r, const struct object_id *oid,
    + 	}
    + 	r->hash_algo->final_oid_fn(real_oid, &c);
    + 	close_istream(st);
    +-	return !oideq(oid, real_oid) ? -1 : 0;
     +	return oideq(oid, real_oid);
    -+}
    -+
    - /* Finalize a file on disk, and close it. */
    - static void close_loose_object(int fd)
    - {
    -
    - ## object-store.h ##
    -@@ object-store.h: void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    - 		      unsigned long len, const char *type,
    - 		      struct object_id *oid);
    + }
    + 
    + int git_open_cloexec(const char *name, int flags)
    +@@ object-file.c: int read_loose_object(const char *path,
    + 			git_inflate_end(&stream);
    + 			goto out;
    + 		}
    +-		if (check_object_signature(the_repository, expected_oid,
    +-					   *contents, *size,
    +-					   oi->type_name->buf, real_oid))
    ++		if (!check_object_signature(the_repository, expected_oid,
    ++					    *contents, *size,
    ++					    oi->type_name->buf, real_oid))
    + 			goto out;
    + 	}
      
    -+/**
    -+ * hash_object_file_oideq() is like hash_object_file() except that
    -+ * asserts that "real_oid" is equivalent to an input "oid", and the
    -+ * return value is that of oideq(oid, real_oid).
    -+ *
    -+ * The "real_oid" can be NULL, when non-NULL the caller provides a
    -+ * "struct object_id *" that can be used to print what the real OID
    -+ * was.
    -+ */
    -+int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
    -+			   unsigned long len, enum object_type type,
    -+			   const struct object_id *oid,
    -+			   struct object_id *real_oidp);
    -+
    - int write_object_file_flags(const void *buf, unsigned long len,
    - 			    enum object_type type, struct object_id *oid,
    - 			    unsigned flags);
     
      ## object.c ##
     @@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
    + 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
    + 	    (!obj && repo_has_object_file(r, oid) &&
    + 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
    +-		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
    ++		if (!check_object_signature(r, repl, NULL, 0, NULL, NULL)) {
    + 			error(_("hash mismatch %s"), oid_to_hex(oid));
    + 			return NULL;
    + 		}
    +@@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
      
      	buffer = repo_read_object_file(r, oid, &type, &size);
      	if (buffer) {
     -		if (check_object_signature(r, repl, buffer, size,
     -					   type_name(type), NULL) < 0) {
    -+		if (!hash_object_file_oideq(r->hash_algo, buffer, size,
    -+					    type, repl, NULL)) {
    ++		if (!check_object_signature(r, repl, buffer, size,
    ++					    type_name(type), NULL)) {
      			free(buffer);
      			error(_("hash mismatch %s"), oid_to_hex(repl));
      			return NULL;
    +
    + ## pack-check.c ##
    +@@ pack-check.c: static int verify_packfile(struct repository *r,
    + 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
    + 				    oid_to_hex(&oid), p->pack_name,
    + 				    (uintmax_t)entries[i].offset);
    +-		else if (check_object_signature(r, &oid, data, size,
    +-						type_name(type), NULL))
    ++		else if (!check_object_signature(r, &oid, data, size,
    ++						 type_name(type), NULL))
    + 			err = error("packed %s from %s is corrupt",
    + 				    oid_to_hex(&oid), p->pack_name);
    + 		else if (fn) {
 8:  70c3e84dd0d !  7:  c38af53e889 object-file API: replace check_object_signature() with stream_*
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-file API: replace check_object_signature() with stream_*
    +    object-file API: split up and simplify check_object_signature()
     
    -    Change the task of the the check_object_signature() function so that
    -    it no longer confusingly does two unrelated things.
    +    Split up the check_object_signature() function into that non-streaming
    +    version (it accepts an already filled "buf"), and a new
    +    stream_object_signature() which will retrieve the object from storage,
    +    and hash it on-the-fly.
     
    -    Now the "!map" branch of it is exposed as a renamed
    -    stream_object_signature(). In preceding commits we migrated all of the
    -    "if (map)" callers over to "hash_object_file_oideq()" or
    -    "hash_object_file_literally()" followed by "!oideq(...)".
    +    All of the callers of check_object_signature() were effectively
    +    calling two different functions, if we go by cyclomatic
    +    complexity. I.e. they'd either take the early "if (map)" branch and
    +    return early, or not. This has been the case since the "if (map)"
    +    condition was added in 090ea12671b (parse_object: avoid putting whole
    +    blob in core, 2012-03-07).
     
    -    This makes the caller in parse_object() less confusing, as we'll now
    -    no longer need to pass NULL for "map" and "OBJ_BAD" for the unused
    -    "type" argument. The "verify_packfile()" caller is arguably a bit
    -    worse off than before, but as we're only using this function in a
    -    couple of places now a bit more verbosity there is acceptable.
    +    We can then further simplify the resulting check_object_signature()
    +    function since only one caller wanted to pass a non-NULL "buf" and a
    +    non-NULL "real_oidp". That "read_loose_object()" codepath used by "git
    +    fsck" can instead use hash_object_file() followed by oideq().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## cache.h ##
    -@@ cache.h: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
    - struct object_info;
    - int parse_loose_header(const char *hdr, struct object_info *oi);
    + ## builtin/fast-export.c ##
    +@@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
    + 		if (!buf)
    + 			die("could not read blob %s", oid_to_hex(oid));
    + 		if (!check_object_signature(the_repository, oid, buf, size,
    +-					    type_name(type), NULL))
    ++					    type_name(type)))
    + 			die("oid mismatch in blob %s", oid_to_hex(oid));
    + 		object = parse_object_buffer(the_repository, oid, type,
    + 					     size, buf, &eaten);
    +
    + ## builtin/index-pack.c ##
    +@@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
    + 			continue;
    + 
    + 		if (!check_object_signature(the_repository, &d->oid, data,
    +-					    size, type_name(type), NULL))
    ++					    size, type_name(type)))
    + 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
    + 
    + 		/*
    +
    + ## builtin/mktag.c ##
    +@@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
    + 
    + 	repl = lookup_replace_object(the_repository, tagged_oid);
    + 	ret = !check_object_signature(the_repository, repl, buffer, size,
    +-				      type_name(*tagged_type), NULL);
    ++				      type_name(*tagged_type));
    + 	free(buffer);
      
    --int check_object_signature(struct repository *r, const struct object_id *oid,
    --			   void *buf, unsigned long size, enum object_type type,
    + 	return ret;
    +
    + ## cache.h ##
    +@@ cache.h: int parse_loose_header(const char *hdr, struct object_info *oi);
    + /**
    +  * With in-core object data in "buf", rehash it to make sure the
    +  * object name actually matches "oid" to detect object corruption.
    +- * With "buf" == NULL, try reading the object named with "oid" using
    +- * the streaming interface and rehash it to do the same.
    +  *
    +  * Treat the return value like oideq() (which is like memcmp()),
    +  * except that negative values might also indicate a generic error.
    +  */
    + int check_object_signature(struct repository *r, const struct object_id *oid,
    +-			   void *buf, unsigned long size, const char *type,
     -			   struct object_id *real_oidp);
    ++			   void *buf, unsigned long size, const char *type);
     +
     +/**
    -+ * stream_object_signature() tries to read the object named with "oid"
    -+ * using the streaming interface and rehash it to make sure the object
    -+ * name actually matches "oid" to detect object corruption.
    ++ * A streaming version of check_object_signature().
    ++ * Try reading the object named with "oid" using
    ++ * the streaming interface and rehash it to do the same.
     + */
    -+int stream_object_signature(struct repository *r, const struct object_id *oid,
    -+			    struct object_id *real_oidp);
    ++int stream_object_signature(struct repository *r, const struct object_id *oid);
      
      int finalize_object_file(const char *tmpfile, const char *filename);
      
     
      ## object-file.c ##
     @@ object-file.c: int format_object_header(char *str, size_t size, enum object_type type,
    - 	return format_object_header_literally(str, size, name, objsize);
      }
      
    --/*
    -- * With an in-core object data in "map", rehash it to make sure the
    -- * object name actually matches "oid" to detect object corruption.
    -- * With "map" == NULL, try reading the object named with "oid" using
    -- * the streaming interface and rehash it to do the same.
    -- */
    --int check_object_signature(struct repository *r, const struct object_id *oid,
    --			   void *map, unsigned long size, enum object_type type,
    + int check_object_signature(struct repository *r, const struct object_id *oid,
    +-			   void *buf, unsigned long size, const char *type,
     -			   struct object_id *real_oidp)
    -+int stream_object_signature(struct repository *r, const struct object_id *oid,
    -+			    struct object_id *real_oidp)
    ++			   void *buf, unsigned long size, const char *type)
      {
    - 	struct object_id tmp;
    - 	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
    +-	struct object_id tmp;
    +-	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
    ++	struct object_id real_oid;
    ++
    ++	hash_object_file(r->hash_algo, buf, size, type, &real_oid);
    ++
    ++	return oideq(oid, &real_oid);
    ++}
    ++
    ++int stream_object_signature(struct repository *r, const struct object_id *oid)
    ++{
    ++	struct object_id real_oid;
     +	unsigned long size;
      	enum object_type obj_type;
      	struct git_istream *st;
    @@ object-file.c: int format_object_header(char *str, size_t size, enum object_type
      	char hdr[MAX_HEADER_LEN];
      	int hdrlen;
      
    --	if (map) {
    --		hash_object_file(r->hash_algo, map, size, type, real_oid);
    --		return !oideq(oid, real_oid) ? -1 : 0;
    +-	if (buf) {
    +-		hash_object_file(r->hash_algo, buf, size, type, real_oid);
    +-		return oideq(oid, real_oid);
     -	}
     -
      	st = open_istream(r, oid, &obj_type, &size, NULL);
      	if (!st)
      		return -1;
    +@@ object-file.c: int check_object_signature(struct repository *r, const struct object_id *oid,
    + 			break;
    + 		r->hash_algo->update_fn(&c, buf, readlen);
    + 	}
    +-	r->hash_algo->final_oid_fn(real_oid, &c);
    ++	r->hash_algo->final_oid_fn(&real_oid, &c);
    + 	close_istream(st);
    +-	return oideq(oid, real_oid);
    ++	return oideq(oid, &real_oid);
    + }
    + 
    + int git_open_cloexec(const char *name, int flags)
    +@@ object-file.c: int read_loose_object(const char *path,
    + 			git_inflate_end(&stream);
    + 			goto out;
    + 		}
    +-		if (!check_object_signature(the_repository, expected_oid,
    +-					    *contents, *size,
    +-					    oi->type_name->buf, real_oid))
    ++
    ++		hash_object_file(the_repository->hash_algo,
    ++				 *contents, *size, oi->type_name->buf,
    ++				 real_oid);
    ++		if (!oideq(expected_oid, real_oid))
    + 			goto out;
    + 	}
    + 
     
      ## object.c ##
     @@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
      	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
      	    (!obj && repo_has_object_file(r, oid) &&
      	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
    --		if (check_object_signature(r, repl, NULL, 0, OBJ_BAD, NULL) < 0) {
    -+		if (stream_object_signature(r, repl, NULL) < 0) {
    +-		if (!check_object_signature(r, repl, NULL, 0, NULL, NULL)) {
    ++		if (!stream_object_signature(r, repl)) {
      			error(_("hash mismatch %s"), oid_to_hex(oid));
      			return NULL;
      		}
    +@@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
    + 	buffer = repo_read_object_file(r, oid, &type, &size);
    + 	if (buffer) {
    + 		if (!check_object_signature(r, repl, buffer, size,
    +-					    type_name(type), NULL)) {
    ++					    type_name(type))) {
    + 			free(buffer);
    + 			error(_("hash mismatch %s"), oid_to_hex(repl));
    + 			return NULL;
     
      ## pack-check.c ##
     @@ pack-check.c: static int verify_packfile(struct repository *r,
    + 
    + 		if (type == OBJ_BLOB && big_file_threshold <= size) {
    + 			/*
    +-			 * Let check_object_signature() check it with
    ++			 * Let stream_object_signature() check it with
    + 			 * the streaming interface; no point slurping
    + 			 * the data in-core only to discard.
    + 			 */
    +@@ pack-check.c: static int verify_packfile(struct repository *r,
      			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
      				    oid_to_hex(&oid), p->pack_name,
      				    (uintmax_t)entries[i].offset);
    --		else if (check_object_signature(r, &oid, data, size,
    --						type, NULL))
    -+		else if (data && !hash_object_file_oideq(r->hash_algo, data,
    -+							 size, type, &oid,
    -+							 NULL))
    +-		else if (!check_object_signature(r, &oid, data, size,
    +-						 type_name(type), NULL))
    ++		else if (data && !check_object_signature(r, &oid, data, size,
    ++							 type_name(type)))
     +			err = error("packed %s from %s is corrupt",
     +				    oid_to_hex(&oid), p->pack_name);
    -+		else if (!data && stream_object_signature(r, &oid, NULL))
    ++		else if (!data && !stream_object_signature(r, &oid))
      			err = error("packed %s from %s is corrupt",
      				    oid_to_hex(&oid), p->pack_name);
      		else if (fn) {
 6:  2a065bf23da !  8:  a5ebd04d462 object-file API: replace some use of check_object_signature()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-file API: replace some use of check_object_signature()
    +    object API: rename hash_object_file_literally() to write_*()
     
    -    Add a "hash_object_file_literally()" function to go with the existing
    -    "hash_object_file()" function. This is currently a wrapper for its
    -    sibling, but this change will allow us to change it to take an "enum
    -    object_type" in a subsequent commit.
    +    Before 0c3db67cc81 (hash-object --literally: fix buffer overrun with
    +    extra-long object type, 2015-05-04) the hash-object code being changed
    +    here called write_sha1_file() to both hash and write a loose
    +    object. Before that we'd use hash_sha1_file() to if "-w" wasn't
    +    provided, and otherwise call write_sha1_file().
     
    -    The only caller that wanted to pass a custom type to
    -    "check_object_signature()" was the "git fsck" via its
    -    "read_loose_object()", which is being changed here.
    -
    -    There was an existing hash_object_file_literally() which I'm renaming
    -    to "hash_write_object_file_literally()", that function is only used
    -    for "hash-object --literally". That renaming is being done because it
    -    would be confusing to have a "hash_object_file_literally()" and a
    -    "hash_object_file()" that do very different things.
    +    Now we'll always call the same function for both writing. Let's rename
    +    it from hash_*_literally() to write_*_literally(). Even though the
    +    write_*() might not actually write if HASH_WRITE_OBJECT isn't in
    +    "flags", having it be more similar to write_object_file_flags() than
    +    hash_object_file(), but carrying a name that would suggest that it's a
    +    variant of the latter is confusing.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/hash-object.c: static int hash_literally(struct object_id *oid, int fd,
      		ret = -1;
      	else
     -		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
    --						 flags);
    -+		ret = hash_write_object_file_literally(buf.buf, buf.len, type, oid,
    -+						       flags);
    ++		ret = write_object_file_literally(buf.buf, buf.len, type, oid,
    + 						 flags);
      	strbuf_release(&buf);
      	return ret;
    - }
     
      ## object-file.c ##
    -@@ object-file.c: void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    - 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
    - }
    - 
    -+static void hash_object_file_literally(const struct git_hash_algo *algo, const void *buf,
    -+				       unsigned long len, const char *type,
    -+				       struct object_id *oid)
    -+{
    -+	hash_object_file(algo, buf, len, type, oid);
    -+}
    -+
    - int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
    - 			   unsigned long len, enum object_type type,
    - 			   const struct object_id *oid,
     @@ object-file.c: int write_object_file_flags(const void *buf, unsigned long len,
      	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
      }
    @@ object-file.c: int write_object_file_flags(const void *buf, unsigned long len,
     -int hash_object_file_literally(const void *buf, unsigned long len,
     -			       const char *type, struct object_id *oid,
     -			       unsigned flags)
    -+int hash_write_object_file_literally(const void *buf, unsigned long len,
    -+				     const char *type, struct object_id *oid,
    -+				     unsigned flags)
    ++int write_object_file_literally(const void *buf, unsigned long len,
    ++				const char *type, struct object_id *oid,
    ++				unsigned flags)
      {
      	char *header;
      	int hdrlen, status = 0;
    -@@ object-file.c: int read_loose_object(const char *path,
    - 			git_inflate_end(&stream);
    - 			goto out;
    - 		}
    --		if (check_object_signature(the_repository, expected_oid,
    -+		hash_object_file_literally(the_repository->hash_algo,
    - 					   *contents, *size,
    --					   oi->type_name->buf, real_oid))
    -+					   oi->type_name->buf, real_oid);
    -+		if (!oideq(expected_oid, real_oid))
    - 			goto out;
    - 	}
    - 
     
      ## object-store.h ##
     @@ object-store.h: static inline int write_object_file(const void *buf, unsigned long len,
    @@ object-store.h: static inline int write_object_file(const void *buf, unsigned lo
     -int hash_object_file_literally(const void *buf, unsigned long len,
     -			       const char *type, struct object_id *oid,
     -			       unsigned flags);
    -+int hash_write_object_file_literally(const void *buf, unsigned long len,
    -+				     const char *type, struct object_id *oid,
    -+				     unsigned flags);
    ++int write_object_file_literally(const void *buf, unsigned long len,
    ++				const char *type, struct object_id *oid,
    ++				unsigned flags);
      
      /*
       * Add an object file to the in-memory object store, without writing it
 7:  ad5d94714cc !  9:  40647be525b object-file API: have hash_object_file() take "enum object_type"
    @@ Commit message
         Change the hash_object_file() function to take an "enum
         object_type".
     
    -    Almost all of its callers were passing either
    -    "{commit,tree,blob,tag}_type", or the result of a call to
    -    type_name(). Let's instead benefit from type checking and use the enum
    -    directly.
    -
    -    "Almost" because one caller here will now pass OBJ_BAD. The previous
    -    "NULL" value was not used, as "check_object_signature()" will never
    -    use its "type" argument when given a NULL "map" argument, which that
    -    caller in "parse_object()" also does. We'll deal with it in a
    -    subsequent commit, but for now it'll pass an "OBJ_BAD" placeholder.
    +    Since a preceding commit all of its callers are passing either
    +    "{commit,tree,blob,tag}_type", or the result of a call to type_name(),
    +    the parse_object() caller that would pass NULL is now using
    +    stream_object_signature().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ apply.c: static int apply_binary(struct apply_state *state,
      		if (strcmp(oid_to_hex(&oid), patch->new_oid_prefix))
      			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
     
    + ## builtin/fast-export.c ##
    +@@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
    + 		if (!buf)
    + 			die("could not read blob %s", oid_to_hex(oid));
    + 		if (!check_object_signature(the_repository, oid, buf, size,
    +-					    type_name(type)))
    ++					    type))
    + 			die("oid mismatch in blob %s", oid_to_hex(oid));
    + 		object = parse_object_buffer(the_repository, oid, type,
    + 					     size, buf, &eaten);
    +
      ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static struct base_data *resolve_delta(struct object_entry *delta_obj,
      	if (!result_data)
    @@ builtin/index-pack.c: static struct base_data *resolve_delta(struct object_entry
      	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
      		    &delta_obj->idx.oid);
      
    +@@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
    + 			continue;
    + 
    + 		if (!check_object_signature(the_repository, &d->oid, data,
    +-					    size, type_name(type)))
    ++					    size, type))
    + 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
    + 
    + 		/*
    +
    + ## builtin/mktag.c ##
    +@@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
    + 
    + 	repl = lookup_replace_object(the_repository, tagged_oid);
    + 	ret = !check_object_signature(the_repository, repl, buffer, size,
    +-				      type_name(*tagged_type));
    ++				     *tagged_type);
    + 	free(buffer);
    + 
    + 	return ret;
     
      ## builtin/replace.c ##
     @@ builtin/replace.c: static int check_one_mergetag(struct commit *commit,
    @@ cache-tree.c: static int verify_one(struct repository *r,
      		BUG("cache-tree for path %.*s does not match. "
     
      ## cache.h ##
    -@@ cache.h: struct object_info;
    - int parse_loose_header(const char *hdr, struct object_info *oi);
    - 
    +@@ cache.h: int parse_loose_header(const char *hdr, struct object_info *oi);
    +  * except that negative values might also indicate a generic error.
    +  */
      int check_object_signature(struct repository *r, const struct object_id *oid,
    --			   void *buf, unsigned long size, const char *type,
    -+			   void *buf, unsigned long size, enum object_type type,
    - 			   struct object_id *real_oidp);
    +-			   void *buf, unsigned long size, const char *type);
    ++			   void *map, unsigned long size,
    ++			   enum object_type type);
      
    - int finalize_object_file(const char *tmpfile, const char *filename);
    + /**
    +  * A streaming version of check_object_signature().
     
      ## convert.c ##
     @@ convert.c: static int ident_to_worktree(const char *src, size_t len,
    @@ log-tree.c: static int show_one_mergetag(struct commit *commit,
     
      ## object-file.c ##
     @@ object-file.c: int format_object_header(char *str, size_t size, enum object_type type,
    -  * the streaming interface and rehash it to do the same.
    -  */
    + }
    + 
      int check_object_signature(struct repository *r, const struct object_id *oid,
    --			   void *map, unsigned long size, const char *type,
    -+			   void *map, unsigned long size, enum object_type type,
    - 			   struct object_id *real_oidp)
    +-			   void *buf, unsigned long size, const char *type)
    ++			   void *buf, unsigned long size,
    ++			   enum object_type type)
      {
    - 	struct object_id tmp;
    + 	struct object_id real_oid;
    + 
     @@ object-file.c: int pretend_object_file(void *buf, unsigned long len, enum object_type type,
      {
      	struct cached_object *co;
    @@ object-file.c: int pretend_object_file(void *buf, unsigned long len, enum object
      	    find_cached_object(oid))
      		return 0;
     @@ object-file.c: static int write_buffer(int fd, const void *buf, size_t len)
    + 	return 0;
      }
      
    - void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    +-void hash_object_file(const struct git_hash_algo *algo, const void *buf,
     -		     unsigned long len, const char *type,
    -+		     unsigned long len, enum object_type type,
    - 		     struct object_id *oid)
    +-		     struct object_id *oid)
    ++static void hash_object_file_literally(const struct git_hash_algo *algo,
    ++				       const void *buf, unsigned long len,
    ++				       const char *type, struct object_id *oid)
      {
      	char hdr[MAX_HEADER_LEN];
      	int hdrlen = sizeof(hdr);
    --	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
     +
    -+	write_object_file_prepare(algo, buf, len, type_name(type), oid, hdr, &hdrlen);
    + 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
      }
      
    - static void hash_object_file_literally(const struct git_hash_algo *algo, const void *buf,
    - 				       unsigned long len, const char *type,
    - 				       struct object_id *oid)
    - {
    --	hash_object_file(algo, buf, len, type, oid);
    -+	char hdr[MAX_HEADER_LEN];
    -+	int hdrlen = sizeof(hdr);
    ++void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    ++		      unsigned long len, enum object_type type,
    ++		      struct object_id *oid)
    ++{
    ++	hash_object_file_literally(algo, buf, len, type_name(type), oid);
    ++}
     +
    -+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
    - }
    - 
    - int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
    -@@ object-file.c: int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
    - 	struct object_id tmp;
    - 	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
    - 
    --	hash_object_file(algo, buf, len, type_name(type), real_oid);
    -+	hash_object_file(algo, buf, len, type, real_oid);
    - 
    - 	return oideq(oid, real_oid);
    - }
    + /* Finalize a file on disk, and close it. */
    + static void close_loose_object(int fd)
    + {
     @@ object-file.c: static int index_mem(struct index_state *istate,
      	if (write_object)
      		ret = write_object_file(buf, size, type, oid);
    @@ object-file.c: int index_path(struct index_state *istate, struct object_id *oid,
      		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
      			rc = error(_("%s: failed to insert into database"), path);
      		strbuf_release(&sb);
    +@@ object-file.c: int read_loose_object(const char *path,
    + 			goto out;
    + 		}
    + 
    +-		hash_object_file(the_repository->hash_algo,
    +-				 *contents, *size, oi->type_name->buf,
    +-				 real_oid);
    ++		hash_object_file_literally(the_repository->hash_algo,
    ++					   *contents, *size,
    ++					   oi->type_name->buf, real_oid);
    + 		if (!oideq(expected_oid, real_oid))
    + 			goto out;
    + 	}
     
      ## object-store.h ##
     @@ object-store.h: static inline void *repo_read_object_file(struct repository *r,
    - /* Read and unpack an object file into memory, write memory to an object file */
      int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
      
    -+
      void hash_object_file(const struct git_hash_algo *algo, const void *buf,
     -		      unsigned long len, const char *type,
     +		      unsigned long len, enum object_type type,
      		      struct object_id *oid);
      
    - /**
    + int write_object_file_flags(const void *buf, unsigned long len,
     
      ## object.c ##
     @@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
    - 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
    - 	    (!obj && repo_has_object_file(r, oid) &&
    - 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
    --		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
    -+		if (check_object_signature(r, repl, NULL, 0, OBJ_BAD, NULL) < 0) {
    - 			error(_("hash mismatch %s"), oid_to_hex(oid));
    + 
    + 	buffer = repo_read_object_file(r, oid, &type, &size);
    + 	if (buffer) {
    +-		if (!check_object_signature(r, repl, buffer, size,
    +-					    type_name(type))) {
    ++		if (!check_object_signature(r, repl, buffer, size, type)) {
    + 			free(buffer);
    + 			error(_("hash mismatch %s"), oid_to_hex(repl));
      			return NULL;
    - 		}
     
      ## pack-check.c ##
     @@ pack-check.c: static int verify_packfile(struct repository *r,
      				    oid_to_hex(&oid), p->pack_name,
      				    (uintmax_t)entries[i].offset);
    - 		else if (check_object_signature(r, &oid, data, size,
    --						type_name(type), NULL))
    -+						type, NULL))
    + 		else if (data && !check_object_signature(r, &oid, data, size,
    +-							 type_name(type)))
    ++							 type))
      			err = error("packed %s from %s is corrupt",
      				    oid_to_hex(&oid), p->pack_name);
    - 		else if (fn) {
    + 		else if (!data && !stream_object_signature(r, &oid))
 9:  009b6604d6f ! 10:  e39edfbce05 object-file.c: add a literal version of write_object_file_prepare()
    @@ object-file.c: void *read_object_with_reference(struct repository *r,
      }
      
      /*
    -@@ object-file.c: void hash_object_file(const struct git_hash_algo *algo, const void *buf,
    - 	char hdr[MAX_HEADER_LEN];
    - 	int hdrlen = sizeof(hdr);
    - 
    --	write_object_file_prepare(algo, buf, len, type_name(type), oid, hdr, &hdrlen);
    -+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
    - }
    - 
    - static void hash_object_file_literally(const struct git_hash_algo *algo, const void *buf,
    -@@ object-file.c: static void hash_object_file_literally(const struct git_hash_algo *algo, const v
    +@@ object-file.c: static void hash_object_file_literally(const struct git_hash_algo *algo,
      	char hdr[MAX_HEADER_LEN];
      	int hdrlen = sizeof(hdr);
      
    @@ object-file.c: static void hash_object_file_literally(const struct git_hash_algo
     +	write_object_file_prepare_literally(algo, buf, len, type, oid, hdr, &hdrlen);
      }
      
    - int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
    + void hash_object_file(const struct git_hash_algo *algo, const void *buf,
     @@ object-file.c: int write_object_file_flags(const void *buf, unsigned long len,
      	/* Normally if we have it in the pack then we do not bother writing
      	 * it out into .git/objects/??/?{38} file.
    @@ object-file.c: int write_object_file_flags(const void *buf, unsigned long len,
      				  &hdrlen);
      	if (freshen_packed_object(oid) || freshen_loose_object(oid))
      		return 0;
    -@@ object-file.c: int hash_write_object_file_literally(const void *buf, unsigned long len,
    +@@ object-file.c: int write_object_file_literally(const void *buf, unsigned long len,
      	/* type string, SP, %lu of the length plus NUL must fit this */
      	hdrlen = strlen(type) + MAX_HEADER_LEN;
      	header = xmalloc(hdrlen);
10:  d89fe344c70 = 11:  f2b1cb861a0 object-file API: pass an enum to read_object_with_reference()
-- 
2.35.1.940.ge7a5b4b05f2

