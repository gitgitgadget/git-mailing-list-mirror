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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1972C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CC9613CE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhDTNBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhDTNBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0170DC06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so33800587wrt.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKcPzAJdXATeX4Kh9GUj7YLvTNNPxOsvNQJRZCks640=;
        b=nkp+UKx0I8jYFWzzs+WrentHh9xycinUkIzt7hjr4t4LGRo4+nVq1GL+lXnPi2Qj4a
         q7tiBpna5/I2gp6UJVy416e6hPUAv22Om/sYPEyTFE5Wflo6wY8rlt4UkEw74wwMVANe
         1Yu/+uyc+HfCfc45q1+AUxexTSu4Y0ZeK6/cQIc3htntQJCD6Gu/1BXyfrGhGzN1sGxk
         NU9gGanNiZHGUFqgNFD0lF0ArpeFs9V3qodQcRvYyg4cqRW1b71faytSPnaiZA0pie9l
         r+18odgJHD5WYN56ndo7oi1cg8VGbtnHq9bY+Dc+AyazOPY0uBZvb//i/5RDiwzlwOQE
         kIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKcPzAJdXATeX4Kh9GUj7YLvTNNPxOsvNQJRZCks640=;
        b=rjrmTgAXIqLwr3lRhoTQNXxcpaaUz/XnSw7p2H+ddjmoTVUEXpNWYPomQRN+sMLC1w
         6eSJpMtiP8qJ5yrjk6+JiDDjTjrjXe+qsK1Ckqnbblcc9mCJHrcoykDlN9INognvaKYG
         JIf7gfMYvQ11GjqQ8YknDkeb8rWpNMfPlNTOdWaf9Fk/XY9xjVa3GBE6db+AQZMRvlji
         mCVe+JQF8LSvuEW/5JVMuxvAAKxfAIZiB5urTUW+Bsl7nL3GFLD5EYyKWkM2kcInHuI5
         Ggz499haDKmR4Y5HnzSNhsViUkinP8VCOcfLH0VAc0FbmDl9l9bVLY/664UDI+7zDKrE
         zq6A==
X-Gm-Message-State: AOAM532A9xSiUjwF6F+7syNFk3prnWiVUOscgpnetH3jpVKaSuoKilcb
        YcpC+7sxVHLKf/E/UNJ4T9FyFpA55vB5Cg==
X-Google-Smtp-Source: ABdhPJxMyHyF3PBt258HIqcCSadnQBVvgiyHkYyv416Mm6IYwcJCqJ/0VrqQOOxnfo18L3OOa+kxLA==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr20159188wrm.427.1618923628038;
        Tue, 20 Apr 2021 06:00:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] {tag,object}*.c: refactorings + prep for a larger change
Date:   Tue, 20 Apr 2021 15:00:06 +0200
Message-Id: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of my just-submitted
https://lore.kernel.org/git/cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com/
for v1 of this see
https://lore.kernel.org/git/cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com/

As noted in the What's Cooking etc. the previous version of this
series's base and this on had a semantic conflict with brian's
hash-object.c work. See
https://lore.kernel.org/git/87mttx121j.fsf@evledraar.gmail.com/

That's now solved by this and the preceding series going through the
codebase and (culminating in this one) removing type_from_string()
entirely. There's still a "BUG" here in case we have any other
in-flight "-1" caller.

This will textually conflict with brian's hash-object.c work. But as
noted in the above-linked thread I've proposed another way forward
with brian's series independent of this one. In any case, the conflict
isn't hard to resolve, and I wanted to re-roll this sooner than later.

Ævar Arnfjörð Bjarmason (10):
  object.c: stop supporting len == -1 in type_from_string_gently()
  object.c: remove "gently" argument to type_from_string_gently()
  object.c: make type_from_string() return "enum object_type"
  object-file.c: make oid_object_info() return "enum object_type"
  object-name.c: make dependency on object_type order more obvious
  tag.c: use type_from_string_gently() when parsing tags
  hash-object: pass along type length to object.c
  hash-object: refactor nested else/if/if into else if/else if
  hash-object: show usage on invalid --type
  object.c: move type_from_string() code to its last user

 builtin/blame.c        |  2 +-
 builtin/cat-file.c     |  4 ++-
 builtin/hash-object.c  | 63 ++++++++++++++++++++++++++----------------
 builtin/index-pack.c   |  2 +-
 builtin/mktree.c       |  2 +-
 fsck.c                 |  2 +-
 object-file.c          | 36 ++++++++++++------------
 object-name.c          | 25 +++++++++--------
 object-store.h         |  8 ++++--
 object.c               | 14 ++++------
 object.h               |  3 +-
 packfile.c             |  2 +-
 t/t1007-hash-object.sh | 10 ++++---
 tag.c                  | 19 +++++++------
 14 files changed, 106 insertions(+), 86 deletions(-)

Range-diff against v1:
 3:  820f3aed21 !  1:  0ff9c653c3 object.c: stop supporting len == -1 in type_from_string_gently()
    @@ Commit message
         2014-09-10), but no callers use that form. Let's drop it to simplify
         this, and in preparation for simplifying these even further.
     
    +    Even though the argument was changed from ssize_t to the unsigned
    +    size_t C is by design forgiving about passing -1 as an unsigned
    +    type (it's just an alias for "set all bits)", let's detect any
    +    outstanding in-flight callers passing a -1.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object.c ##
    -@@ object.c: int type_from_string_gently(const char *str, ssize_t len, int gentle)
    +@@ object.c: const char *type_name(unsigned int type)
    + 	return object_type_strings[type];
    + }
    + 
    +-int type_from_string_gently(const char *str, ssize_t len, int gentle)
    ++int type_from_string_gently(const char *str, size_t len, int gentle)
      {
      	int i;
      
     -	if (len < 0)
     -		len = strlen(str);
    --
    ++	if (len == ~(size_t)0)
    ++		BUG("type-from-string-gently no longer allows unspecified length");
    + 
      	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
      		if (!strncmp(str, object_type_strings[i], len) &&
    - 		    object_type_strings[i][len] == '\0')
     @@ object.c: int type_from_string_gently(const char *str, ssize_t len, int gentle)
    - 	die(_("invalid object type \"%s\""), str);
    + 	die(_("invalid object type \"%.*s\""), (int)len, str);
      }
      
     +int type_from_string(const char *str)
    @@ object.c: int type_from_string_gently(const char *str, ssize_t len, int gentle)
     
      ## object.h ##
     @@ object.h: struct object {
    + };
      
      const char *type_name(unsigned int type);
    - int type_from_string_gently(const char *str, ssize_t, int gentle);
    +-int type_from_string_gently(const char *str, ssize_t, int gentle);
     -#define type_from_string(str) type_from_string_gently(str, -1, 0)
    ++int type_from_string_gently(const char *str, size_t, int gentle);
     +int type_from_string(const char *str);
      
      /*
 4:  daed40c479 !  2:  5fa3128127 object.c: remove "gently" argument to type_from_string_gently()
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## builtin/mktree.c ##
    +@@ builtin/mktree.c: static void mktree_line(char *buf, int nul_term_line, int allow_missing)
    + 	 * These should all agree.
    + 	 */
    + 	mode_type = object_type(mode);
    +-	type_type = type_from_string_gently(ptr, ntr - ptr, 1);
    ++	type_type = type_from_string_gently(ptr, ntr - ptr);
    + 	if (type_type < 0)
    + 		die("entry '%s' object type '%.*s' is invalid (our derived mode type is '%s')",
    + 			path, (int)(ntr - ptr), ptr, type_name(mode_type));
    +
      ## fsck.c ##
     @@ fsck.c: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
      		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
    @@ object.c: const char *type_name(unsigned int type)
      	return object_type_strings[type];
      }
      
    --int type_from_string_gently(const char *str, ssize_t len, int gentle)
    -+int type_from_string_gently(const char *str, ssize_t len)
    +-int type_from_string_gently(const char *str, size_t len, int gentle)
    ++int type_from_string_gently(const char *str, size_t len)
      {
      	int i;
      
    -@@ object.c: int type_from_string_gently(const char *str, ssize_t len, int gentle)
    +@@ object.c: int type_from_string_gently(const char *str, size_t len, int gentle)
      		if (!strncmp(str, object_type_strings[i], len) &&
      		    object_type_strings[i][len] == '\0')
      			return i;
    @@ object.c: int type_from_string_gently(const char *str, ssize_t len, int gentle)
     -	if (gentle)
     -		return -1;
     -
    --	die(_("invalid object type \"%s\""), str);
    +-	die(_("invalid object type \"%.*s\""), (int)len, str);
     +	return -1;
      }
      
    @@ object.h: struct object {
      };
      
      const char *type_name(unsigned int type);
    --int type_from_string_gently(const char *str, ssize_t, int gentle);
    -+int type_from_string_gently(const char *str, ssize_t len);
    +-int type_from_string_gently(const char *str, size_t, int gentle);
    ++int type_from_string_gently(const char *str, size_t len);
      int type_from_string(const char *str);
      
      /*
 5:  7fd86f6699 !  3:  f0ec7d1dbb object.c: make type_from_string() return "enum object_type"
    @@ object.c: const char *type_name(unsigned int type)
      	return object_type_strings[type];
      }
      
    --int type_from_string_gently(const char *str, ssize_t len)
    -+enum object_type type_from_string_gently(const char *str, ssize_t len)
    +-int type_from_string_gently(const char *str, size_t len)
    ++enum object_type type_from_string_gently(const char *str, size_t len)
      {
     -	int i;
     +	enum object_type i;
      
    - 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
    - 		if (!strncmp(str, object_type_strings[i], len) &&
    -@@ object.c: int type_from_string_gently(const char *str, ssize_t len)
    + 	if (len == ~(size_t)0)
    + 		BUG("type-from-string-gently no longer allows unspecified length");
    +@@ object.c: int type_from_string_gently(const char *str, size_t len)
      	return -1;
      }
      
    @@ object.h: struct object {
      };
      
      const char *type_name(unsigned int type);
    --int type_from_string_gently(const char *str, ssize_t len);
    +-int type_from_string_gently(const char *str, size_t len);
     -int type_from_string(const char *str);
    -+enum object_type type_from_string_gently(const char *str, ssize_t len);
    ++enum object_type type_from_string_gently(const char *str, size_t len);
     +enum object_type type_from_string(const char *str);
      
      /*
 6:  ebea1b2b50 =  4:  fa97396517 object-file.c: make oid_object_info() return "enum object_type"
 7:  94e13611f0 =  5:  a607239b56 object-name.c: make dependency on object_type order more obvious
 8:  3279d67d2b =  6:  e6fe7ce064 tag.c: use type_from_string_gently() when parsing tags
 1:  68a7709fe5 !  7:  a5ac9f1dd8 blob.c: remove buffer & size arguments to parse_blob_buffer()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    blob.c: remove buffer & size arguments to parse_blob_buffer()
    +    hash-object: pass along type length to object.c
     
    -    As noted in the comment introduced in 837d395a5c0 (Replace
    -    parse_blob() with an explanatory comment, 2010-01-18) the old
    -    parse_blob() function and the current parse_blob_buffer() exist merely
    -    to provide consistency in the API.
    +    Change the functions to do with passing the type down to
    +    hash_object_file_literally() to pass the length of the type as well as
    +    the "const char *" type name.
     
    -    We're not going to parse blobs like we "parse" commits, trees or
    -    tags. So let's not have the parse_blob_buffer() take arguments that
    -    pretends that we do. Its only use is to set the "parsed" flag.
    +    The immediate motivation for this is to move hash-object.c over to
    +    type_from_string_gently() to emit a better error message, but it will
    +    also allow us in the future to craft an invalid object with a "\0" in
    +    the type name.
     
    -    See bd2c39f58f9 ([PATCH] don't load and decompress objects twice with
    -    parse_object(), 2005-05-06) for the introduction of parse_blob_buffer().
    -
    -    I'm moving the prototype of parse_blob_buffer() below the comment
    -    added in 837d395a5c0 while I'm at it. That comment was originally
    -    meant to be a replacement for the missing parse_blob() function, but
    -    it's much less confusing to have it be above the parse_blob_buffer()
    -    function it refers to.
    +    We'd need to learn a --type-file=* option or similar (we can't of
    +    course, pass a string with "\0" on the command-line). Right now such
    +    an object can be manually crafted, but we can't test for it with
    +    --literally.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## blob.c ##
    -@@ blob.c: struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
    - 	return object_as_type(obj, OBJ_BLOB, 0);
    + ## builtin/hash-object.c ##
    +@@ builtin/hash-object.c: static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
    + 	if (strbuf_read(&buf, fd, 4096) < 0)
    + 		ret = -1;
    + 	else
    +-		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
    +-						 flags);
    ++		ret = hash_object_file_literally(buf.buf, buf.len, type,
    ++						 strlen(type), oid, flags);
    + 	strbuf_release(&buf);
    + 	return ret;
    + }
    + 
    +-static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
    +-		    int literally)
    ++static void hash_fd(int fd, const char *type, size_t type_len,
    ++		    const char *path, unsigned flags, int literally)
    + {
    + 	struct stat st;
    + 	struct object_id oid;
    +@@ builtin/hash-object.c: static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
    + 	maybe_flush_or_die(stdout, "hash to stdout");
    + }
    + 
    +-static void hash_object(const char *path, const char *type, const char *vpath,
    +-			unsigned flags, int literally)
    ++static void hash_object(const char *path, const char *type, size_t type_len,
    ++			const char *vpath, unsigned flags, int literally)
    + {
    + 	int fd;
    + 	fd = open(path, O_RDONLY);
    + 	if (fd < 0)
    + 		die_errno("Cannot open '%s'", path);
    +-	hash_fd(fd, type, vpath, flags, literally);
    ++	hash_fd(fd, type, type_len, vpath, flags, literally);
      }
      
    --int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
    -+int parse_blob_buffer(struct blob *item)
    +-static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
    +-			     int literally)
    ++static void hash_stdin_paths(const char *type, size_t type_len, int no_filters,
    ++			     unsigned flags, int literally)
      {
    - 	item->object.parsed = 1;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct strbuf unquoted = STRBUF_INIT;
    + 
    + 	while (strbuf_getline(&buf, stdin) != EOF) {
    ++		const char *vpath;
    + 		if (buf.buf[0] == '"') {
    + 			strbuf_reset(&unquoted);
    + 			if (unquote_c_style(&unquoted, buf.buf, NULL))
    + 				die("line is badly quoted");
    + 			strbuf_swap(&buf, &unquoted);
    + 		}
    +-		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
    +-			    literally);
    ++		vpath = no_filters ? NULL : buf.buf;
    ++		hash_object(buf.buf, type, type_len, vpath , flags, literally);
    + 	}
    + 	strbuf_release(&buf);
    + 	strbuf_release(&unquoted);
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + 		NULL
    + 	};
    + 	const char *type = blob_type;
    ++	size_t type_len;
    + 	int hashstdin = 0;
    + 	int stdin_paths = 0;
    + 	int no_filters = 0;
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + 		usage_with_options(hash_object_usage, hash_object_options);
    + 	}
    + 
    ++	type_len = strlen(type);
    + 	if (hashstdin)
    +-		hash_fd(0, type, vpath, flags, literally);
    ++		hash_fd(0, type, type_len, vpath, flags, literally);
    + 
    + 	for (i = 0 ; i < argc; i++) {
    + 		const char *arg = argv[i];
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + 
    + 		if (prefix)
    + 			arg = to_free = prefix_filename(prefix, arg);
    +-		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
    ++		hash_object(arg, type, type_len, no_filters ? NULL : vpath ? vpath : arg,
    + 			    flags, literally);
    + 		free(to_free);
    + 	}
    + 
    + 	if (stdin_paths)
    +-		hash_stdin_paths(type, no_filters, flags, literally);
    ++		hash_stdin_paths(type, type_len, no_filters, flags, literally);
    + 
      	return 0;
    + }
     
    - ## blob.h ##
    -@@ blob.h: struct blob {
    - 
    - struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
    - 
    --int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
    --
    - /**
    -  * Blobs do not contain references to other objects and do not have
    -  * structured data that needs parsing. However, code may use the
    -@@ blob.h: int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
    -  * parse_blob_buffer() is used (by object.c) to flag that the object
    -  * has been read successfully from the database.
    -  **/
    -+int parse_blob_buffer(struct blob *item);
    - 
    - #endif /* BLOB_H */
    + ## object-file.c ##
    +@@ object-file.c: void *read_object_with_reference(struct repository *r,
    + 
    + static void write_object_file_prepare(const struct git_hash_algo *algo,
    + 				      const void *buf, unsigned long len,
    +-				      const char *type, struct object_id *oid,
    +-				      char *hdr, int *hdrlen)
    ++				      const char *type, size_t type_len,
    ++				      struct object_id *oid, char *hdr,
    ++				      int *hdrlen)
    + {
    + 	git_hash_ctx c;
    + 
    + 	/* Generate the header */
    +-	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
    ++	*hdrlen = xsnprintf(hdr, *hdrlen, "%.*s %"PRIuMAX,
    ++			    (int)type_len, type, (uintmax_t)len) + 1;
    + 
    + 	/* Sha1.. */
    + 	algo->init_fn(&c);
    +@@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
    + {
    + 	char hdr[MAX_HEADER_LEN];
    + 	int hdrlen = sizeof(hdr);
    +-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
    ++	write_object_file_prepare(algo, buf, len, type, strlen(type), oid, hdr,
    ++				  &hdrlen);
    + 	return 0;
    + }
    + 
    +@@ object-file.c: int write_object_file(const void *buf, unsigned long len, const char *type,
    + {
    + 	char hdr[MAX_HEADER_LEN];
    + 	int hdrlen = sizeof(hdr);
    ++	size_t type_len = strlen(type);
    + 
    + 	/* Normally if we have it in the pack then we do not bother writing
    + 	 * it out into .git/objects/??/?{38} file.
    + 	 */
    +-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
    +-				  &hdrlen);
    ++	write_object_file_prepare(the_hash_algo, buf, len, type, type_len, oid,
    ++				  hdr, &hdrlen);
    + 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
    + 		return 0;
    + 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
    + }
    + 
    + int hash_object_file_literally(const void *buf, unsigned long len,
    +-			       const char *type, struct object_id *oid,
    +-			       unsigned flags)
    ++			       const char *type, size_t type_len,
    ++			       struct object_id *oid, unsigned flags)
    + {
    + 	char *header;
    + 	int hdrlen, status = 0;
    + 
    + 	/* type string, SP, %lu of the length plus NUL must fit this */
    +-	hdrlen = strlen(type) + MAX_HEADER_LEN;
    ++	hdrlen = type_len + MAX_HEADER_LEN;
    + 	header = xmalloc(hdrlen);
    +-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, header,
    +-				  &hdrlen);
    ++	write_object_file_prepare(the_hash_algo, buf, len, type, type_len, oid,
    ++				  header, &hdrlen);
    + 
    + 	if (!(flags & HASH_WRITE_OBJECT))
    + 		goto cleanup;
     
    - ## object.c ##
    -@@ object.c: struct object *parse_object_buffer(struct repository *r, const struct object_id
    - 	if (type == OBJ_BLOB) {
    - 		struct blob *blob = lookup_blob(r, oid);
    - 		if (blob) {
    --			if (parse_blob_buffer(blob, buffer, size))
    -+			if (parse_blob_buffer(blob))
    - 				return NULL;
    - 			obj = &blob->object;
    - 		}
    -@@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
    - 			error(_("hash mismatch %s"), oid_to_hex(oid));
    - 			return NULL;
    - 		}
    --		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
    -+		parse_blob_buffer(lookup_blob(r, oid));
    - 		return lookup_object(r, oid);
    - 	}
    + ## object-store.h ##
    +@@ object-store.h: int write_object_file(const void *buf, unsigned long len,
    + 		      const char *type, struct object_id *oid);
    + 
    + int hash_object_file_literally(const void *buf, unsigned long len,
    +-			       const char *type, struct object_id *oid,
    +-			       unsigned flags);
    ++			       const char *type, size_t type_len,
    ++			       struct object_id *oid, unsigned flags);
      
    + /*
    +  * Add an object file to the in-memory object store, without writing it
 -:  ---------- >  8:  7bf04edc74 hash-object: refactor nested else/if/if into else if/else if
 2:  f1fcc31717 !  9:  eaa1b8f44c object.c: initialize automatic variable in lookup_object()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object.c: initialize automatic variable in lookup_object()
    +    hash-object: show usage on invalid --type
     
    -    Initialize a "struct object obj*" variable to NULL explicitly and
    -    return it instead of leaving it uninitialized until the "while"
    -    loop.
    +    Change the error displayed on "hash-object -t bogus" (without
    +    --literally) to show the usage_with_options(), like we do for the
    +    other usage errors.
     
    -    There was no bug here, it's just less confusing when debugging if the
    -    "obj" is either NULL or a valid object, not some random invalid
    -    pointer.
    -
    -    See 0556a11a0df (git object hash cleanups, 2006-06-30) for the initial
    -    implementation.
    +    As noted in a preceding commit it makes sense to pass the "len" down
    +    to the object.c code, so now that we're using
    +    type_from_string_gently() let's do that.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## object.c ##
    -@@ object.c: static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
    - struct object *lookup_object(struct repository *r, const struct object_id *oid)
    + ## builtin/hash-object.c ##
    +@@ builtin/hash-object.c: static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
    + 	return ret;
    + }
    + 
    +-static void hash_fd(int fd, const char *type, size_t type_len,
    +-		    const char *path, unsigned flags, int literally)
    ++static void hash_fd(int fd, enum object_type otype, const char *type,
    ++		    size_t type_len, const char *path, unsigned flags,
    ++		    int literally)
    + {
    + 	struct stat st;
    + 	struct object_id oid;
    +@@ builtin/hash-object.c: static void hash_fd(int fd, const char *type, size_t type_len,
    + 	if (fstat(fd, &st) < 0 ||
    + 	    (literally
    + 	     ? hash_literally(&oid, fd, type, flags)
    +-	     : index_fd(the_repository->index, &oid, fd, &st,
    +-			type_from_string(type), path, flags)))
    ++	     : index_fd(the_repository->index, &oid, fd, &st, otype, path,
    ++			flags)))
    + 		die((flags & HASH_WRITE_OBJECT)
    + 		    ? "Unable to add %s to database"
    + 		    : "Unable to hash %s", path);
    +@@ builtin/hash-object.c: static void hash_fd(int fd, const char *type, size_t type_len,
    + 	maybe_flush_or_die(stdout, "hash to stdout");
    + }
    + 
    +-static void hash_object(const char *path, const char *type, size_t type_len,
    ++static void hash_object(const char *path, enum object_type otype,
    ++			const char *type, size_t type_len,
    + 			const char *vpath, unsigned flags, int literally)
      {
    - 	unsigned int i, first;
    --	struct object *obj;
    -+	struct object *obj = NULL;
    + 	int fd;
    + 	fd = open(path, O_RDONLY);
    + 	if (fd < 0)
    + 		die_errno("Cannot open '%s'", path);
    +-	hash_fd(fd, type, type_len, vpath, flags, literally);
    ++	hash_fd(fd, otype, type, type_len, vpath, flags, literally);
    + }
    + 
    +-static void hash_stdin_paths(const char *type, size_t type_len, int no_filters,
    ++static void hash_stdin_paths(enum object_type otype, const char *type,
    ++			     size_t type_len, int no_filters,
    + 			     unsigned flags, int literally)
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    +@@ builtin/hash-object.c: static void hash_stdin_paths(const char *type, size_t type_len, int no_filters,
    + 			strbuf_swap(&buf, &unquoted);
    + 		}
    + 		vpath = no_filters ? NULL : buf.buf;
    +-		hash_object(buf.buf, type, type_len, vpath , flags, literally);
    ++		hash_object(buf.buf, otype, type, type_len, vpath , flags, literally);
    + 	}
    + 	strbuf_release(&buf);
    + 	strbuf_release(&unquoted);
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + 	};
    + 	const char *type = blob_type;
    + 	size_t type_len;
    ++	enum object_type otype = OBJ_BAD;
    + 	int hashstdin = 0;
    + 	int stdin_paths = 0;
    + 	int no_filters = 0;
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + 	};
    + 	int i;
    + 	const char *errstr = NULL;
    ++	int errstr_arg_type = 0;
    + 
    + 	argc = parse_options(argc, argv, prefix, hash_object_options,
    + 			     hash_object_usage, 0);
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + 
    + 	git_config(git_default_config, NULL);
    + 
    +-	if (stdin_paths) {
    ++	type_len = strlen(type);
    ++	otype = type_from_string_gently(type, type_len);
    ++	if (otype < 0 && !literally) {
    ++		errstr = "the object type \"%.*s\" is invalid, did you mean to use --literally?";
    ++		errstr_arg_type = 1;
    ++	} else if (stdin_paths) {
    + 		if (hashstdin)
    + 			errstr = "Can't use --stdin-paths with --stdin";
    + 		else if (argc)
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + 	}
    + 
    + 	if (errstr) {
    +-		error("%s", errstr);
    ++		if (errstr_arg_type)
    ++			error(errstr, (int)type_len, type);
    ++		else
    ++			error("%s", errstr);
    + 		usage_with_options(hash_object_usage, hash_object_options);
    + 	}
    + 
    +-	type_len = strlen(type);
    + 	if (hashstdin)
    +-		hash_fd(0, type, type_len, vpath, flags, literally);
    ++		hash_fd(0, otype, type, type_len, vpath, flags, literally);
    + 
    + 	for (i = 0 ; i < argc; i++) {
    + 		const char *arg = argv[i];
    + 		char *to_free = NULL;
    ++		const char *tmp;
    + 
    + 		if (prefix)
    + 			arg = to_free = prefix_filename(prefix, arg);
    +-		hash_object(arg, type, type_len, no_filters ? NULL : vpath ? vpath : arg,
    +-			    flags, literally);
    ++		tmp = no_filters ? NULL : vpath ? vpath : arg;
    ++		hash_object(arg, otype, type, type_len, tmp, flags, literally);
    + 		free(to_free);
    + 	}
    + 
    + 	if (stdin_paths)
    +-		hash_stdin_paths(type, type_len, no_filters, flags, literally);
    ++		hash_stdin_paths(otype, type, type_len, no_filters, flags,
    ++				 literally);
    + 
    + 	return 0;
    + }
    +
    + ## t/t1007-hash-object.sh ##
    +@@ t/t1007-hash-object.sh: test_expect_success 'corrupt tag' '
    + '
      
    - 	if (!r->parsed_objects->obj_hash)
    --		return NULL;
    -+		return obj;
    + test_expect_success 'hash-object complains about bogus type name' '
    +-	test_must_fail git hash-object -t bogus --stdin 2>actual </dev/null &&
    ++	test_expect_code 129 git hash-object -t bogus --stdin 2>err </dev/null &&
    ++	grep ^error err >actual &&
    + 	cat >expect <<-\EOF &&
    +-	fatal: invalid object type "bogus"
    ++	error: the object type "bogus" is invalid, did you mean to use --literally?
    + 	EOF
    + 	test_cmp expect actual
    + '
      
    - 	first = i = hash_obj(oid, r->parsed_objects->obj_hash_size);
    - 	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
    + test_expect_success 'hash-object complains about truncated type name' '
    +-	test_must_fail git hash-object -t bl --stdin 2>actual </dev/null &&
    ++	test_expect_code 129 git hash-object -t bl --stdin 2>err </dev/null &&
    ++	grep ^error err >actual &&
    + 	cat >expect <<-\EOF &&
    +-	fatal: invalid object type "bl"
    ++	error: the object type "bl" is invalid, did you mean to use --literally?
    + 	EOF
    + 	test_cmp expect actual
    + '
 -:  ---------- > 10:  cb0ea49279 object.c: move type_from_string() code to its last user
-- 
2.31.1.723.ga5d7868e4a

