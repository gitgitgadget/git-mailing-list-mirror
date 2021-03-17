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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD82C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762DF64F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhCQSVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhCQSVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97194C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x13so2838244wrs.9
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FyvlTRY2gYw5H/7/5kq6+beAFyU9nNDTnFfSr/SG/1M=;
        b=CKQA5YG6nWRmC3uZlZVUtAGQJs4UIPKjZ4Rlf/VmBIggI62yku98jItt9IXd1lXN5y
         dqCV3HCpbN3F1aglGr+6+In7zkNu+90rkIvsNngISaTwPuy6z8T50kNgI1l4C2BeVPit
         fx7c+SXMIaBPHsimUWgx8q8yzAr+fndM4yEkuw7Bj75hsym322J2/my938YWZrvZnH8n
         544jneQj+sB6QXORq8Y/4d6t8+r7oOtSK518FnX8ArzUKNzplykkcu87ephELc3ZSzbR
         1pdG4pEP49Dsem2Bf4ZfVobcMNw7UfUt4nrvKQMSwHe+lAUc4VW5Cdi44zoA5l/RwDXl
         tzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FyvlTRY2gYw5H/7/5kq6+beAFyU9nNDTnFfSr/SG/1M=;
        b=eV3OBJUuWIPkH3CKts/HYBko8G7OjOONkPt+75P/Pf0A5DGQqngwmW4w17dWKFIc8F
         X9MN4aK7AjzfFEr0F9ks0cZtBsNpiDDzfZ6ZJ+E8AnNw+BSbLDDtqXRu3lhk67XtxB9Y
         tjqTqNQcsg6cAMV5lnqhFkaDfLnIJTnEVXFX21QZmSWplm3fmZSnOOAxJCf0tvlufRVM
         v1VAzzCkUEwS/t2UKOOt4tAcIvjw93gOvY+0ThwfPshrVzEg9vrvKjfWViPV4lqBnuKK
         mxEzxCENz9Xxy7f2Nqqk56sODmvD4mQnGCIwn/Y5YeKfB4sdf233PVdXCQb3dip7pbnH
         0M7Q==
X-Gm-Message-State: AOAM533OsYFRKJ2TJUlzqjLKu96iaxusVvYBxIrDxmk2NfHVEZOsZng7
        Nq7XC1v7CbAQqcgKEKqTaCPTlIkog689Tw==
X-Google-Smtp-Source: ABdhPJwtKphQuGJf73z1kRjzsXNPICHJUkliw7jWanZjZ5+lMQLJCZxnEIKmzgKxLGZKnFOvfRDZwg==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr5621796wru.357.1616005270793;
        Wed, 17 Mar 2021 11:21:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/19] fsck: API improvements
Date:   Wed, 17 Mar 2021 19:20:35 +0100
Message-Id: <20210317182054.5986-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v5 with changes suggested by Derrick Stolee. Link to v4:
https://lore.kernel.org/git/20210316161738.30254-1-avarab@gmail.com/

Changes:

 * 1/19 is new, it's a simple refactoring of some git_config() code in
   fsck.c code I changed recently.

 * Squashed the first 4x patches of incrementally redefining two
   macros into one.

 * Squashed a whitespace-only change into another patch that changed
   the same code.

 * Got rid of fsck-cb.c, that one function just lives at the bottom of
   fsck.c now.

Ævar Arnfjörð Bjarmason (19):
  fsck.c: refactor and rename common config callback
  fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
  fsck.h: use "enum object_type" instead of "int"
  fsck.c: rename variables in fsck_set_msg_type() for less confusion
  fsck.c: move definition of msg_id into append_msg_id()
  fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
  fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
  fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
  fsck.h: re-order and re-assign "enum fsck_msg_type"
  fsck.c: call parse_msg_type() early in fsck_set_msg_type()
  fsck.c: undefine temporary STR macro after use
  fsck.c: give "FOREACH_MSG_ID" a more specific name
  fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
  fsck.c: pass along the fsck_msg_id in the fsck_error callback
  fsck.c: add an fsck_set_msg_type() API that takes enums
  fsck.c: move gitmodules_{found,done} into fsck_options
  fetch-pack: don't needlessly copy fsck_options
  fetch-pack: use file-scope static struct for fsck_options
  fetch-pack: use new fsck API to printing dangling submodules

 builtin/fsck.c           |  14 ++-
 builtin/index-pack.c     |  30 +-----
 builtin/mktag.c          |  14 ++-
 builtin/unpack-objects.c |   3 +-
 fetch-pack.c             |   6 +-
 fsck.c                   | 197 +++++++++++++++------------------------
 fsck.h                   | 131 +++++++++++++++++++++++---
 7 files changed, 213 insertions(+), 182 deletions(-)

Range-diff:
 1:  9cd942b526 <  -:  ---------- fsck.h: update FSCK_OPTIONS_* for object_name
 2:  d67966b838 <  -:  ---------- fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
 3:  211472e0c5 <  -:  ---------- fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
 4:  70afee988d <  -:  ---------- fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
 5:  1337d53352 <  -:  ---------- fsck.h: indent arguments to of fsck_set_msg_type
 -:  ---------- >  1:  fe33015e0d fsck.c: refactor and rename common config callback
 -:  ---------- >  2:  72f2e53afa fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
 6:  e4ef107bb4 =  3:  237a280686 fsck.h: use "enum object_type" instead of "int"
 7:  20bac3207e !  4:  13b76c73dd fsck.c: rename variables in fsck_set_msg_type() for less confusion
    @@ Commit message
         "msg_id" to "msg_id_str" etc. This will make a follow-up change
         smaller.
     
    +    While I'm at it properly indent the fsck_set_msg_type() argument list.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## fsck.c ##
    @@ fsck.c: int is_valid_msg_type(const char *msg_id, const char *msg_type)
      
      void fsck_set_msg_type(struct fsck_options *options,
     -		const char *msg_id, const char *msg_type)
    -+		const char *msg_id_str, const char *msg_type_str)
    ++		       const char *msg_id_str, const char *msg_type_str)
      {
     -	int id = parse_msg_id(msg_id), type;
     +	int msg_id = parse_msg_id(msg_id_str), msg_type;
    @@ fsck.c: int is_valid_msg_type(const char *msg_id, const char *msg_type)
      }
      
      void fsck_set_msg_types(struct fsck_options *options, const char *values)
    +
    + ## fsck.h ##
    +@@ fsck.h: struct fsck_options;
    + struct object;
    + 
    + void fsck_set_msg_type(struct fsck_options *options,
    +-		const char *msg_id, const char *msg_type);
    ++		       const char *msg_id, const char *msg_type);
    + void fsck_set_msg_types(struct fsck_options *options, const char *values);
    + int is_valid_msg_type(const char *msg_id, const char *msg_type);
    + 
 8:  09c3bba9e9 =  5:  4ae83403b7 fsck.c: move definition of msg_id into append_msg_id()
 9:  8067df53a2 =  6:  82107f1dac fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
10:  bdf5e13f3d =  7:  796096bf73 fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
11:  b03caa237f !  8:  3664abb23d fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
    @@ builtin/index-pack.c: static void show_pack_info(int stat_only)
      	 * NEEDSWORK: Plumb the MSG_ID (from fsck.c) here and use it
     
      ## builtin/mktag.c ##
    -@@ builtin/mktag.c: static int mktag_config(const char *var, const char *value, void *cb)
    +@@ builtin/mktag.c: static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
      static int mktag_fsck_error_func(struct fsck_options *o,
      				 const struct object_id *oid,
      				 enum object_type object_type,
    @@ fsck.c: static int fsck_msg_type(enum fsck_msg_id msg_id,
      		return FSCK_ERROR;
     @@ fsck.c: int is_valid_msg_type(const char *msg_id, const char *msg_type)
      void fsck_set_msg_type(struct fsck_options *options,
    - 		const char *msg_id_str, const char *msg_type_str)
    + 		       const char *msg_id_str, const char *msg_type_str)
      {
     -	int msg_id = parse_msg_id(msg_id_str), msg_type;
     +	int msg_id = parse_msg_id(msg_id_str);
12:  7b1d13b4cc =  9:  81e6d7ab45 fsck.h: re-order and re-assign "enum fsck_msg_type"
13:  a8e4ca7b19 ! 10:  5c2e8e7b84 fsck.c: call parse_msg_type() early in fsck_set_msg_type()
    @@ Commit message
     
      ## fsck.c ##
     @@ fsck.c: void fsck_set_msg_type(struct fsck_options *options,
    - 		const char *msg_id_str, const char *msg_type_str)
    + 		       const char *msg_id_str, const char *msg_type_str)
      {
      	int msg_id = parse_msg_id(msg_id_str);
     -	enum fsck_msg_type msg_type;
14:  214c375a20 = 11:  7ffbf9af3f fsck.c: undefine temporary STR macro after use
15:  19a2499a80 = 12:  12ff0f75eb fsck.c: give "FOREACH_MSG_ID" a more specific name
16:  6e1a7b6274 = 13:  0c49dd5164 fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
17:  42af4e164c = 14:  900263f503 fsck.c: pass along the fsck_msg_id in the fsck_error callback
18:  fa47f473a8 ! 15:  5f270e88a0 fsck.c: add an fsck_set_msg_type() API that takes enums
    @@ builtin/mktag.c: int cmd_mktag(int argc, const char **argv, const char *prefix)
     +	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
     +				   FSCK_WARN);
      	/* config might set fsck.extraHeaderEntry=* again */
    - 	git_config(mktag_config, NULL);
    + 	git_config(git_fsck_config, &fsck_options);
      	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
     
      ## fsck.c ##
    @@ fsck.c: int is_valid_msg_type(const char *msg_id, const char *msg_type)
     +}
     +
      void fsck_set_msg_type(struct fsck_options *options,
    - 		const char *msg_id_str, const char *msg_type_str)
    + 		       const char *msg_id_str, const char *msg_type_str)
      {
     @@ fsck.c: void fsck_set_msg_type(struct fsck_options *options,
      	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
19:  4cc3880cc4 = 16:  539d019712 fsck.c: move gitmodules_{found,done} into fsck_options
20:  fd219d318a = 17:  1acf744236 fetch-pack: don't needlessly copy fsck_options
21:  e4cd8c250e = 18:  b47c3d5ac6 fetch-pack: use file-scope static struct for fsck_options
22:  fdbc3c304c ! 19:  f05fa5c3ec fetch-pack: use new fsck API to printing dangling submodules
    @@ Commit message
         manipulating the "gitmodules_found" member. A recent commit moved it
         into "fsck_options" so we could do this here.
     
    -    Add a fsck-cb.c file similar to parse-options-cb.c, the alternative
    -    would be to either define this directly in fsck.c as a public API, or
    -    to create some library shared by fetch-pack.c ad builtin/index-pack.
    +    I'm sticking this callback in fsck.c. Perhaps in the future we'd like
    +    to accumulate such callbacks into another file (maybe fsck-cb.c,
    +    similar to parse-options-cb.c?), but while we've got just the one
    +    let's just put it into fsck.c.
     
    -    I expect that there won't be many of these fsck utility functions in
    -    the future, so just having a single fsck-cb.c makes sense.
    +    A better alternative in this case would be some library some more
    +    obvious library shared by fetch-pack.c ad builtin/index-pack.c, but
    +    there isn't such a thing.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Makefile ##
    -@@ Makefile: LIB_OBJS += fetch-negotiator.o
    - LIB_OBJS += fetch-pack.o
    - LIB_OBJS += fmt-merge-msg.o
    - LIB_OBJS += fsck.o
    -+LIB_OBJS += fsck-cb.o
    - LIB_OBJS += fsmonitor.o
    - LIB_OBJS += gettext.o
    - LIB_OBJS += gpg-interface.o
    -
      ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static int nr_threads;
      static int from_stdin;
    @@ fetch-pack.c: static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
      		die("fsck failed");
      }
     
    - ## fsck-cb.c (new) ##
    -@@
    -+#include "git-compat-util.h"
    -+#include "fsck.h"
    + ## fsck.c ##
    +@@ fsck.c: int fsck_error_function(struct fsck_options *o,
    + 	return 1;
    + }
    + 
    +-void register_found_gitmodules(struct fsck_options *options, const struct object_id *oid)
    +-{
    +-	oidset_insert(&options->gitmodules_found, oid);
    +-}
    +-
    + int fsck_finish(struct fsck_options *options)
    + {
    + 	int ret = 0;
    +@@ fsck.c: int git_fsck_config(const char *var, const char *value, void *cb)
    + 
    + 	return git_default_config(var, value, cb);
    + }
    ++
    ++/*
    ++ * Custom error callbacks that are used in more than one place.
    ++ */
     +
     +int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +					   const struct object_id *oid,
    @@ fsck-cb.c (new)
     +	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
     +}
     
    - ## fsck.c ##
    -@@ fsck.c: int fsck_error_function(struct fsck_options *o,
    - 	return 1;
    - }
    - 
    --void register_found_gitmodules(struct fsck_options *options, const struct object_id *oid)
    --{
    --	oidset_insert(&options->gitmodules_found, oid);
    --}
    --
    - int fsck_finish(struct fsck_options *options)
    - {
    - 	int ret = 0;
    -
      ## fsck.h ##
     @@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
      int fsck_object(struct object *obj, void *data, unsigned long size,
    @@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *optio
       * fsck a tag, and pass info about it back to the caller. This is
       * exposed fsck_object() internals for git-mktag(1).
     @@ fsck.h: const char *fsck_describe_object(struct fsck_options *options,
    - int fsck_config_internal(const char *var, const char *value, void *cb,
    - 			 struct fsck_options *options);
    +  */
    + int git_fsck_config(const char *var, const char *value, void *cb);
      
     +/*
    -+ * Initializations for callbacks in fsck-cb.c
    ++ * Custom error callbacks that are used in more than one place.
     + */
     +#define FSCK_OPTIONS_MISSING_GITMODULES { \
     +	.strict = 1, \
     +	.error_func = fsck_error_cb_print_missing_gitmodules, \
     +	FSCK_OPTIONS_COMMON \
     +}
    -+
    -+/*
    -+ * Error callbacks in fsck-cb.c
    -+ */
     +int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +					   const struct object_id *oid,
     +					   enum object_type object_type,
-- 
2.31.0.260.g719c683c1d

