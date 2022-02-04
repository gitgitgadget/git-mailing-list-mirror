Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C9EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbiBDXsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBDXsp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:45 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A736E0090AE
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so4115238wml.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/qyiQ1OVMIYN1oWL6ilcoU/qW3rgIs9HZvEmfclVh0=;
        b=N/zp+2oyAMVKLtn/GuMW3DhEmAYZwy2AqLzP9R6doI1/TNnwpw03Jjb8BwId0pR5d8
         AAp/cCtoIVhvi7EMZNobDm5kKGCroRd3hB9EdABKmpETvXhjAFerb+MyPRuDboJf4Yci
         4KCiUBQXgWqc2+hNlMgIcMbonYuIJBIJ7Uev1BVylw6OEcUYP7y89HUx6Q/eYwdX0dph
         DlXQcq+/4kSIFiG0Gjay8DEB+7dUynylFCDh0nTcYrQdA9iyBqbA6JgVPlnjOO7pNmR9
         AXEeP/HUZML78iUlZs9CRQte3qAZWteto14VXTjV29d7YDzNbCmdnKvlUwfMoElVg59r
         5zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/qyiQ1OVMIYN1oWL6ilcoU/qW3rgIs9HZvEmfclVh0=;
        b=m3oUCVirhXPEp1kd5t5vyBXAR/5Ma+wKkgxf46H0P/JaKkyVp3jAtHQN3tPSEkb8WA
         V2KUNHoNyTV6mfXrKhLmTGCupdqMsyvz6q4nx/acjv65TEQCHHVGna4eaNKTh1IjugSD
         fR6PlnwlgBvxCbch5nFRzz7rq9BY6KIHq+4njSNidg7wTIIEbYFlzgmGFKVHeApXBlJR
         7auYT1aAbaVC1EOQCO0RgZn6Aci2IF2pWMzUTKTNDyfU8tcuApm4SKFO9noS6S8GFLB2
         AZheCkqC83hLf/YQwbt0S0rheMaa42fQAp/EpAye+xfIz9s1F4FOXZP9NBZxkGFhiNFN
         U56w==
X-Gm-Message-State: AOAM532LNxwBy95rcB0I5oPof7wtnM7dzChHGqqiQJHncksMfFCcajTZ
        AeEekPfEMV/Vo6XbXA3Wtz8m1MMP3zgvsw==
X-Google-Smtp-Source: ABdhPJz+CXPxzD/Mdx3RUHViD05BO1q0AjojwodT7DLPFo8OTvgz42QkpOcBz3FBO5ohH3WvvnsJ9g==
X-Received: by 2002:a05:600c:20a:: with SMTP id 10mr4309730wmi.19.1644018520234;
        Fri, 04 Feb 2022 15:48:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:39 -0800 (PST)
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
Subject: [PATCH v3 00/12] object-file API: pass object enums, tidy up streaming interface
Date:   Sat,  5 Feb 2022 00:48:22 +0100
Message-Id: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the v2 for a summary and goals:
https://lore.kernel.org/git/cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com/

This early re-roll addresses Junio's comments on it so far, i.e. the
minor whitespace/typos, and then having the interface retain the "if
(f() < 0)" interface.

The reason I'd changed it initially was because the callers used a
mixture of "if (f())" and "if (f() < 0)", but let's just keep it as it
is, with a couple of new patches to fix the existing callers to use
"if (f() < 0)" consistently.

A corresponding re-roll to the topic that depends on this one isn't
needed, as this part of the API wasn't used by it. For that topic see:
https://lore.kernel.org/git/cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (12):
  object-file.c: split up declaration of unrelated variables
  object-file API: return "void", not "int" from hash_object_file()
  object-file API: add a format_object_header() function
  object-file API: have write_object_file() take "enum object_type"
  object API: correct "buf" v.s. "map" mismatch in *.c and *.h
  object API docs: move check_object_signature() docs to cache.h
  object API users + docs: check <0, not !0 with
    check_object_signature()
  object-file API: split up and simplify check_object_signature()
  object API: rename hash_object_file_literally() to write_*()
  object-file API: have hash_object_file() take "enum object_type"
  object-file.c: add a literal version of write_object_file_prepare()
  object-file API: pass an enum to read_object_with_reference()

 apply.c                  |  12 ++--
 builtin/cat-file.c       |  11 +--
 builtin/checkout.c       |   2 +-
 builtin/fast-export.c    |   2 +-
 builtin/fast-import.c    |  12 ++--
 builtin/grep.c           |   4 +-
 builtin/hash-object.c    |   2 +-
 builtin/index-pack.c     |  10 ++-
 builtin/mktag.c          |   9 ++-
 builtin/mktree.c         |   2 +-
 builtin/notes.c          |   2 +-
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
 object-file.c            | 145 +++++++++++++++++++++++++--------------
 object-store.h           |  24 ++++---
 object.c                 |   5 +-
 pack-check.c             |   9 ++-
 read-cache.c             |   2 +-
 tree-walk.c              |   6 +-
 36 files changed, 202 insertions(+), 137 deletions(-)

Range-diff against v2:
 -:  ----------- >  1:  53334bc970a object-file.c: split up declaration of unrelated variables
 -:  ----------- >  2:  5ba49778ac1 object-file API: return "void", not "int" from hash_object_file()
 -:  ----------- >  3:  92fd020d199 object-file API: add a format_object_header() function
 1:  d259f901114 !  4:  795ac3dea2a object-file API: have write_object_file() take "enum object_type"
    @@ builtin/notes.c: static void prepare_note_data(const struct object_id *object, s
     -	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
     +	if (write_object_file(d->buf.buf, d->buf.len, OBJ_BLOB, oid)) {
      		int status = die_message(_("unable to write note object"));
    --
    + 
      		if (d->edit_path)
    - 			die_message(_("the note contents have been left in %s"),
    - 				    d->edit_path);
     
      ## builtin/receive-pack.c ##
     @@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process *proc)
 2:  207aec4eb64 !  5:  6faf46277b5 object API: correct "buf" v.s. "map" mismatch in *.c and *.h
    @@ Commit message
     
         Change the name of the second argument to check_object_signature() to
         be "buf" in object-file.c, making it consistent with the prototype in
    -    cache..h
    +    cache.h
     
         This fixes an inconsistency that's been with us since 2ade9340262 (Add
         "check_sha1_signature()" helper function, 2005-04-08), and makes a
 3:  636a647ac51 !  6:  bdddaa3648f object API: make check_object_signature() oideq()-like, move docs
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object API: make check_object_signature() oideq()-like, move docs
    +    object API docs: move check_object_signature() docs to cache.h
     
    -    Make the return value of check_object_signature() behave like oideq()
    -    and memcmp() instead of returning negative values on failure.
    -
    -    This reduces the boilerplate required when calling the function, and
    -    makes the calling code behave the same is if though we'd called
    -    oideq(), which is basically what we're doing here. We already had some
    -    callers using "f() < 0", with others using "!f()". Instead of
    -    declaring the latter a bug let's convert all callers to it.
    -
    -    It is unfortunate that there's also cases where we "return -1" on
    -    various errors, and we can't tell those apart from the expected OID
    -    being less than the real OID, but this was the case already.
    -
    -    This change is rather dangerous stand-alone as we're changing the
    -    return semantics, but not changing the prototype. Therefore any
    -    out-of-tree code rebased on this change would start doing the opposite
    -    of what it was meant to do. In a subsequent commit we'll make that a
    -    non-issue by changing the signature of the function, ensuring that the
    -    compiler will catch any such misuse.
    -
    -    While we're at it let's re-flow some of the callers to wrap at 79
    -    characters, and move the API documentation to cache.h, where the
    -    prototype of this function lives.
    +    Move the API documentation for check_object_signature() to cache.h,
    +    where its prototype is declared. This is in preparation for adding a
    +    companion function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/fast-export.c ##
    -@@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
    - 		buf = read_object_file(oid, &type, &size);
    - 		if (!buf)
    - 			die("could not read blob %s", oid_to_hex(oid));
    --		if (check_object_signature(the_repository, oid, buf, size,
    --					   type_name(type), NULL) < 0)
    -+		if (!check_object_signature(the_repository, oid, buf, size,
    -+					    type_name(type), NULL))
    - 			die("oid mismatch in blob %s", oid_to_hex(oid));
    - 		object = parse_object_buffer(the_repository, oid, type,
    - 					     size, buf, &eaten);
    -
    - ## builtin/index-pack.c ##
    -@@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
    - 		if (!data)
    - 			continue;
    - 
    --		if (check_object_signature(the_repository, &d->oid,
    --					   data, size,
    --					   type_name(type), NULL))
    -+		if (!check_object_signature(the_repository, &d->oid, data,
    -+					    size, type_name(type), NULL))
    - 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
    - 
    - 		/*
    -
    - ## builtin/mktag.c ##
    -@@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
    - 		    type_name(*tagged_type), type_name(type));
    - 
    - 	repl = lookup_replace_object(the_repository, tagged_oid);
    --	ret = check_object_signature(the_repository, repl,
    --				     buffer, size, type_name(*tagged_type),
    --				     NULL);
    -+	ret = !check_object_signature(the_repository, repl, buffer, size,
    -+				      type_name(*tagged_type), NULL);
    - 	free(buffer);
    - 
    - 	return ret;
    -
      ## cache.h ##
     @@ cache.h: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
      struct object_info;
    @@ cache.h: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream
     + * object name actually matches "oid" to detect object corruption.
     + * With "buf" == NULL, try reading the object named with "oid" using
     + * the streaming interface and rehash it to do the same.
    -+ *
    -+ * Treat the return value like oideq() (which is like memcmp()),
    -+ * except that negative values might also indicate a generic error.
     + */
      int check_object_signature(struct repository *r, const struct object_id *oid,
      			   void *buf, unsigned long size, const char *type,
    @@ object-file.c: int format_object_header(char *str, size_t size, enum object_type
      int check_object_signature(struct repository *r, const struct object_id *oid,
      			   void *buf, unsigned long size, const char *type,
      			   struct object_id *real_oidp)
    -@@ object-file.c: int check_object_signature(struct repository *r, const struct object_id *oid,
    - 
    - 	if (buf) {
    - 		hash_object_file(r->hash_algo, buf, size, type, real_oid);
    --		return !oideq(oid, real_oid) ? -1 : 0;
    -+		return oideq(oid, real_oid);
    - 	}
    - 
    - 	st = open_istream(r, oid, &obj_type, &size, NULL);
    -@@ object-file.c: int check_object_signature(struct repository *r, const struct object_id *oid,
    - 	}
    - 	r->hash_algo->final_oid_fn(real_oid, &c);
    - 	close_istream(st);
    --	return !oideq(oid, real_oid) ? -1 : 0;
    -+	return oideq(oid, real_oid);
    - }
    - 
    - int git_open_cloexec(const char *name, int flags)
    -@@ object-file.c: int read_loose_object(const char *path,
    - 			git_inflate_end(&stream);
    - 			goto out;
    - 		}
    --		if (check_object_signature(the_repository, expected_oid,
    --					   *contents, *size,
    --					   oi->type_name->buf, real_oid))
    -+		if (!check_object_signature(the_repository, expected_oid,
    -+					    *contents, *size,
    -+					    oi->type_name->buf, real_oid))
    - 			goto out;
    - 	}
    - 
    -
    - ## object.c ##
    -@@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
    - 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
    - 	    (!obj && repo_has_object_file(r, oid) &&
    - 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
    --		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
    -+		if (!check_object_signature(r, repl, NULL, 0, NULL, NULL)) {
    - 			error(_("hash mismatch %s"), oid_to_hex(oid));
    - 			return NULL;
    - 		}
    -@@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
    - 
    - 	buffer = repo_read_object_file(r, oid, &type, &size);
    - 	if (buffer) {
    --		if (check_object_signature(r, repl, buffer, size,
    --					   type_name(type), NULL) < 0) {
    -+		if (!check_object_signature(r, repl, buffer, size,
    -+					    type_name(type), NULL)) {
    - 			free(buffer);
    - 			error(_("hash mismatch %s"), oid_to_hex(repl));
    - 			return NULL;
    -
    - ## pack-check.c ##
    -@@ pack-check.c: static int verify_packfile(struct repository *r,
    - 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
    - 				    oid_to_hex(&oid), p->pack_name,
    - 				    (uintmax_t)entries[i].offset);
    --		else if (check_object_signature(r, &oid, data, size,
    --						type_name(type), NULL))
    -+		else if (!check_object_signature(r, &oid, data, size,
    -+						 type_name(type), NULL))
    - 			err = error("packed %s from %s is corrupt",
    - 				    oid_to_hex(&oid), p->pack_name);
    - 		else if (fn) {
 -:  ----------- >  7:  75abf75a437 object API users + docs: check <0, not !0 with check_object_signature()
 4:  c38af53e889 !  8:  478d2915731 object-file API: split up and simplify check_object_signature()
    @@ builtin/fast-export.c
     @@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
      		if (!buf)
      			die("could not read blob %s", oid_to_hex(oid));
    - 		if (!check_object_signature(the_repository, oid, buf, size,
    --					    type_name(type), NULL))
    -+					    type_name(type)))
    + 		if (check_object_signature(the_repository, oid, buf, size,
    +-					   type_name(type), NULL) < 0)
    ++					   type_name(type)) < 0)
      			die("oid mismatch in blob %s", oid_to_hex(oid));
      		object = parse_object_buffer(the_repository, oid, type,
      					     size, buf, &eaten);
    @@ builtin/index-pack.c
     @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
      			continue;
      
    - 		if (!check_object_signature(the_repository, &d->oid, data,
    --					    size, type_name(type), NULL))
    -+					    size, type_name(type)))
    + 		if (check_object_signature(the_repository, &d->oid, data, size,
    +-					   type_name(type), NULL) < 0)
    ++					   type_name(type)) < 0)
      			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
      
      		/*
     
      ## builtin/mktag.c ##
     @@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
    + 		    type_name(*tagged_type), type_name(type));
      
      	repl = lookup_replace_object(the_repository, tagged_oid);
    - 	ret = !check_object_signature(the_repository, repl, buffer, size,
    --				      type_name(*tagged_type), NULL);
    -+				      type_name(*tagged_type));
    +-	ret = check_object_signature(the_repository, repl,
    +-				     buffer, size, type_name(*tagged_type),
    +-				     NULL);
    ++	ret = check_object_signature(the_repository, repl, buffer, size,
    ++				     type_name(*tagged_type));
      	free(buffer);
      
      	return ret;
    @@ cache.h: int parse_loose_header(const char *hdr, struct object_info *oi);
     - * With "buf" == NULL, try reading the object named with "oid" using
     - * the streaming interface and rehash it to do the same.
       *
    -  * Treat the return value like oideq() (which is like memcmp()),
    -  * except that negative values might also indicate a generic error.
    +  * A negative value indicates an error, usually that the OID is not
    +  * what we expected, but it might also indicate another error.
       */
      int check_object_signature(struct repository *r, const struct object_id *oid,
     -			   void *buf, unsigned long size, const char *type,
    @@ object-file.c: int format_object_header(char *str, size_t size, enum object_type
     +
     +	hash_object_file(r->hash_algo, buf, size, type, &real_oid);
     +
    -+	return oideq(oid, &real_oid);
    ++	return !oideq(oid, &real_oid) ? -1 : 0;
     +}
     +
     +int stream_object_signature(struct repository *r, const struct object_id *oid)
    @@ object-file.c: int format_object_header(char *str, size_t size, enum object_type
      
     -	if (buf) {
     -		hash_object_file(r->hash_algo, buf, size, type, real_oid);
    --		return oideq(oid, real_oid);
    +-		return !oideq(oid, real_oid) ? -1 : 0;
     -	}
     -
      	st = open_istream(r, oid, &obj_type, &size, NULL);
    @@ object-file.c: int check_object_signature(struct repository *r, const struct obj
     -	r->hash_algo->final_oid_fn(real_oid, &c);
     +	r->hash_algo->final_oid_fn(&real_oid, &c);
      	close_istream(st);
    --	return oideq(oid, real_oid);
    -+	return oideq(oid, &real_oid);
    +-	return !oideq(oid, real_oid) ? -1 : 0;
    ++	return !oideq(oid, &real_oid) ? -1 : 0;
      }
      
      int git_open_cloexec(const char *name, int flags)
    @@ object-file.c: int read_loose_object(const char *path,
      			git_inflate_end(&stream);
      			goto out;
      		}
    --		if (!check_object_signature(the_repository, expected_oid,
    --					    *contents, *size,
    --					    oi->type_name->buf, real_oid))
    -+
    +-		if (check_object_signature(the_repository, expected_oid,
    +-					   *contents, *size,
    +-					   oi->type_name->buf, real_oid) < 0)
     +		hash_object_file(the_repository->hash_algo,
     +				 *contents, *size, oi->type_name->buf,
     +				 real_oid);
    @@ object.c: struct object *parse_object(struct repository *r, const struct object_
      	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
      	    (!obj && repo_has_object_file(r, oid) &&
      	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
    --		if (!check_object_signature(r, repl, NULL, 0, NULL, NULL)) {
    -+		if (!stream_object_signature(r, repl)) {
    +-		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
    ++		if (stream_object_signature(r, repl) < 0) {
      			error(_("hash mismatch %s"), oid_to_hex(oid));
      			return NULL;
      		}
     @@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
      	buffer = repo_read_object_file(r, oid, &type, &size);
      	if (buffer) {
    - 		if (!check_object_signature(r, repl, buffer, size,
    --					    type_name(type), NULL)) {
    -+					    type_name(type))) {
    + 		if (check_object_signature(r, repl, buffer, size,
    +-					   type_name(type), NULL) < 0) {
    ++					   type_name(type)) < 0) {
      			free(buffer);
      			error(_("hash mismatch %s"), oid_to_hex(repl));
      			return NULL;
    @@ pack-check.c: static int verify_packfile(struct repository *r,
      			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
      				    oid_to_hex(&oid), p->pack_name,
      				    (uintmax_t)entries[i].offset);
    --		else if (!check_object_signature(r, &oid, data, size,
    --						 type_name(type), NULL))
    -+		else if (data && !check_object_signature(r, &oid, data, size,
    -+							 type_name(type)))
    +-		else if (check_object_signature(r, &oid, data, size,
    +-						type_name(type), NULL) < 0)
    ++		else if (data && check_object_signature(r, &oid, data, size,
    ++							type_name(type)) < 0)
     +			err = error("packed %s from %s is corrupt",
     +				    oid_to_hex(&oid), p->pack_name);
    -+		else if (!data && !stream_object_signature(r, &oid))
    ++		else if (!data && stream_object_signature(r, &oid) < 0)
      			err = error("packed %s from %s is corrupt",
      				    oid_to_hex(&oid), p->pack_name);
      		else if (fn) {
 5:  a5ebd04d462 =  9:  1276c2d1ed6 object API: rename hash_object_file_literally() to write_*()
 6:  40647be525b ! 10:  2c936c674d4 object-file API: have hash_object_file() take "enum object_type"
    @@ builtin/fast-export.c
     @@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
      		if (!buf)
      			die("could not read blob %s", oid_to_hex(oid));
    - 		if (!check_object_signature(the_repository, oid, buf, size,
    --					    type_name(type)))
    -+					    type))
    + 		if (check_object_signature(the_repository, oid, buf, size,
    +-					   type_name(type)) < 0)
    ++					   type) < 0)
      			die("oid mismatch in blob %s", oid_to_hex(oid));
      		object = parse_object_buffer(the_repository, oid, type,
      					     size, buf, &eaten);
    @@ builtin/index-pack.c: static struct base_data *resolve_delta(struct object_entry
     @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
      			continue;
      
    - 		if (!check_object_signature(the_repository, &d->oid, data,
    --					    size, type_name(type)))
    -+					    size, type))
    + 		if (check_object_signature(the_repository, &d->oid, data, size,
    +-					   type_name(type)) < 0)
    ++					   type) < 0)
      			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
      
      		/*
    @@ builtin/mktag.c
     @@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
      
      	repl = lookup_replace_object(the_repository, tagged_oid);
    - 	ret = !check_object_signature(the_repository, repl, buffer, size,
    --				      type_name(*tagged_type));
    + 	ret = check_object_signature(the_repository, repl, buffer, size,
    +-				     type_name(*tagged_type));
     +				     *tagged_type);
      	free(buffer);
      
    @@ cache-tree.c: static int verify_one(struct repository *r,
     
      ## cache.h ##
     @@ cache.h: int parse_loose_header(const char *hdr, struct object_info *oi);
    -  * except that negative values might also indicate a generic error.
    +  * what we expected, but it might also indicate another error.
       */
      int check_object_signature(struct repository *r, const struct object_id *oid,
     -			   void *buf, unsigned long size, const char *type);
    @@ object-file.c: int index_path(struct index_state *istate, struct object_id *oid,
      			rc = error(_("%s: failed to insert into database"), path);
      		strbuf_release(&sb);
     @@ object-file.c: int read_loose_object(const char *path,
    + 			git_inflate_end(&stream);
      			goto out;
      		}
    - 
     -		hash_object_file(the_repository->hash_algo,
     -				 *contents, *size, oi->type_name->buf,
     -				 real_oid);
    @@ object.c: struct object *parse_object(struct repository *r, const struct object_
      
      	buffer = repo_read_object_file(r, oid, &type, &size);
      	if (buffer) {
    --		if (!check_object_signature(r, repl, buffer, size,
    --					    type_name(type))) {
    -+		if (!check_object_signature(r, repl, buffer, size, type)) {
    +-		if (check_object_signature(r, repl, buffer, size,
    +-					   type_name(type)) < 0) {
    ++		if (check_object_signature(r, repl, buffer, size, type) < 0) {
      			free(buffer);
      			error(_("hash mismatch %s"), oid_to_hex(repl));
      			return NULL;
    @@ pack-check.c
     @@ pack-check.c: static int verify_packfile(struct repository *r,
      				    oid_to_hex(&oid), p->pack_name,
      				    (uintmax_t)entries[i].offset);
    - 		else if (data && !check_object_signature(r, &oid, data, size,
    --							 type_name(type)))
    -+							 type))
    + 		else if (data && check_object_signature(r, &oid, data, size,
    +-							type_name(type)) < 0)
    ++							type) < 0)
      			err = error("packed %s from %s is corrupt",
      				    oid_to_hex(&oid), p->pack_name);
    - 		else if (!data && !stream_object_signature(r, &oid))
    + 		else if (!data && stream_object_signature(r, &oid) < 0)
 7:  e39edfbce05 = 11:  ad1a777f454 object-file.c: add a literal version of write_object_file_prepare()
 8:  f2b1cb861a0 = 12:  d2d355e6bb8 object-file API: pass an enum to read_object_with_reference()
-- 
2.35.1.940.ge7a5b4b05f2

