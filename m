Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE414C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827486501A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhCFLEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCFLEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3EC06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e10so5194061wro.12
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsMUuSNK2TqdkhqFwsi+Yzkd37DoKJrAHz3w7kTwEpM=;
        b=hx4JvlBFWaYUdYhZ4X+kXSV0H9kZDnPyZE1cujFndgH6Rop5QEit1EP1efb1D6ySsv
         TnPOT4xzbzKZZlfOfMO8//yUHB3gRSwo0pH9yxnUPkTiDRf/EGSCIbcjcIE0Zqwh/k6v
         mgLCaKpBLZxCprgNCEEDUK7BTbj+sR00JzmXD8kn0nKtZCgYa9Nzf2QrBH/ruiGnmOcS
         L1Sqnc72z4OtNGe1GuYk51onB4zN+YBieE1Rcu0ruUM9yJc6hDNczRYW4wZmty2zcbZE
         K18Pq9U3jjJwqoHYW1dA6ySmZn5rs7Pc568s91AsmWZQGdNnCI09RdzF9AJJ75T8+jcd
         SS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsMUuSNK2TqdkhqFwsi+Yzkd37DoKJrAHz3w7kTwEpM=;
        b=IoBlhPGhHgXJpBIRGRPH50rpQM7fCYB/mSLb1BREgsALKU92tnKwN5gAuvBneB1urc
         f6dYTQgPwQ10n75NwXejYxLQ3e0nIt/cXQ3zwCYTDrHTkvDU2gmFobDgLIbcGSz0q21u
         hnkNg8Cq6+zCo8ipDgZ/RIwWA06c+2nQ4X1TzIan2qRICC/yorgP+rC347OmAPtuuyep
         A+AX+/cGrpb+5KId2v4ES/zQSwqPcMSH3D7BtYKHoyh2YZ+JHzMvMea8cz/Fs5+zlCGl
         w3NSs4ne2ZvknB1rxC9tc9KFMhHyxh95v0kM059SAQDE26H0Eqbo76YQXXhb7Hnz107V
         kJxQ==
X-Gm-Message-State: AOAM530/kTfashfsbakmQstGKXLaJ34PV7jdOOsMbSN3mA386SRwmdUr
        Zw//7r9kNEaQ6TTfAg2OWiM2zDk9vKQxRw==
X-Google-Smtp-Source: ABdhPJxjt5ewLmoBUIQNoIKOB80A2oANq9myks+8I2YuexgEXNA7FtC7ydfE0uIpME4Iz9A694gKbw==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr13849054wru.214.1615028691895;
        Sat, 06 Mar 2021 03:04:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/22] fsck: API improvements
Date:   Sat,  6 Mar 2021 12:04:17 +0100
Message-Id: <20210306110439.27694-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that jt/transfer-fsck-across-packs has been merged to master
here's a re-roll of v1[1]+v2[2] of this series. v2 was slimmed-down +
had a trivial typo fix, so I've done the range-diff against v1.

This makes the recent fetch-pack work use the fsck_msg_id API to
distinguish messages, and has other various cleanups and improvements
to make the fsck API easier to use in the future.

There's a an easy merge conflict here with other in-flight changes to
fsck. I figured it was better to send this now than wait for those to
land.

1. https://lore.kernel.org/git/20210217194246.25342-1-avarab@gmail.com/
2. https://lore.kernel.org/git/20210218105840.11989-1-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (22):
  fsck.h: update FSCK_OPTIONS_* for object_name
  fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
  fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
  fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
  fsck.h: indent arguments to of fsck_set_msg_type
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

 Makefile                 |   1 +
 builtin/fsck.c           |   7 +-
 builtin/index-pack.c     |  30 ++-----
 builtin/mktag.c          |   7 +-
 builtin/unpack-objects.c |   3 +-
 fetch-pack.c             |   6 +-
 fsck-cb.c                |  16 ++++
 fsck.c                   | 175 ++++++++++++---------------------------
 fsck.h                   | 132 ++++++++++++++++++++++++++---
 9 files changed, 211 insertions(+), 166 deletions(-)
 create mode 100644 fsck-cb.c

Range-diff:
13:  8de91fac068 =  1:  9d809466bd1 fsck.h: update FSCK_OPTIONS_* for object_name
 -:  ----------- >  2:  33e8b6d6545 fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
 -:  ----------- >  3:  c23f7ce9e4a fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
 -:  ----------- >  4:  5dde68df6c3 fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
 1:  88b347b74ed =  5:  7ae35a6e9d2 fsck.h: indent arguments to of fsck_set_msg_type
 2:  1a60d65d2ca !  6:  dfb5f754b37 fsck.h: use use "enum object_type" instead of "int"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fsck.h: use use "enum object_type" instead of "int"
    +    fsck.h: use "enum object_type" instead of "int"
     
         Change the fsck_walk_func to use an "enum object_type" instead of an
         "int" type. The types are compatible, and ever since this was added in
 3:  24761f269b7 !  7:  fd58ec73c6b fsck.c: rename variables in fsck_set_msg_type() for less confusion
    @@ Commit message
         It was needlessly confusing that it took a "msg_type" argument, but
         then later declared another "msg_type" of a different type.
     
    -    Let's rename that to "tmp", and rename "id" to "msg_id" and "msg_id"
    -    to "msg_id_str" etc. This will make a follow-up change smaller.
    +    Let's rename that to "severity", and rename "id" to "msg_id" and
    +    "msg_id" to "msg_id_str" etc. This will make a follow-up change
    +    smaller.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ fsck.c: int is_valid_msg_type(const char *msg_id, const char *msg_type)
      		int i;
     -		int *msg_type;
     -		ALLOC_ARRAY(msg_type, FSCK_MSG_MAX);
    -+		int *tmp;
    -+		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
    ++		int *severity;
    ++		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
      		for (i = 0; i < FSCK_MSG_MAX; i++)
     -			msg_type[i] = fsck_msg_type(i, options);
     -		options->msg_type = msg_type;
    -+			tmp[i] = fsck_msg_type(i, options);
    -+		options->msg_type = tmp;
    ++			severity[i] = fsck_msg_type(i, options);
    ++		options->msg_type = severity;
      	}
      
     -	options->msg_type[id] = type;
 4:  fb4c66f9305 =  8:  48cb4d3bb70 fsck.c: move definition of msg_id into append_msg_id()
 5:  a129dbd9964 !  9:  2c80ad32038 fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
    @@ Commit message
         "msg_id". This change is relatively small, and is worth the churn for
         a later change where we have different id's in the "report" function.
     
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
      ## fsck.c ##
     @@ fsck.c: void fsck_set_msg_types(struct fsck_options *options, const char *values)
      	free(to_free);
 -:  ----------- > 10:  92dfbdfb624 fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
 6:  d9bee41072e ! 11:  c1c476af69b fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
    @@ Commit message
          - f27d05b1704 (fsck: allow upgrading fsck warnings to errors,
            2015-06-22)
     
    +    The reason these were defined in two different places is because we
    +    use FSCK_{IGNORE,INFO,FATAL} only in fsck.c, but FSCK_{ERROR,WARN} are
    +    used by external callbacks.
    +
    +    Untangling that would take some more work, since we expose the new
    +    "enum fsck_msg_type" to both. Similar to "enum object_type" it's not
    +    worth structuring the API in such a way that only those who need
    +    FSCK_{ERROR,WARN} pass around a different type.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/fsck.c ##
    @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
      	switch (msg_type) {
      	case FSCK_WARN:
     
    + ## builtin/index-pack.c ##
    +@@ builtin/index-pack.c: static void show_pack_info(int stat_only)
    + static int print_dangling_gitmodules(struct fsck_options *o,
    + 				     const struct object_id *oid,
    + 				     enum object_type object_type,
    +-				     int msg_type, const char *message)
    ++				     enum fsck_msg_type msg_type,
    ++				     const char *message)
    + {
    + 	/*
    + 	 * NEEDSWORK: Plumb the MSG_ID (from fsck.c) here and use it
    +
      ## builtin/mktag.c ##
     @@ builtin/mktag.c: static int mktag_config(const char *var, const char *value, void *cb)
      static int mktag_fsck_error_func(struct fsck_options *o,
    @@ fsck.c: void list_config_fsck_msg_ids(struct string_list *list, const char *pref
     +static enum fsck_msg_type fsck_msg_type(enum fsck_msg_id msg_id,
      	struct fsck_options *options)
      {
    --	int msg_type;
    -+	enum fsck_msg_type msg_type;
    - 
      	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
      
    + 	if (!options->msg_type) {
    +-		int msg_type = msg_id_info[msg_id].msg_type;
    ++		enum fsck_msg_type msg_type = msg_id_info[msg_id].msg_type;
    + 
    + 		if (options->strict && msg_type == FSCK_WARN)
    + 			msg_type = FSCK_ERROR;
     @@ fsck.c: static int fsck_msg_type(enum fsck_msg_id msg_id,
    - 	return msg_type;
    + 	return options->msg_type[msg_id];
      }
      
     -static int parse_msg_type(const char *str)
    @@ fsck.c: void fsck_set_msg_type(struct fsck_options *options,
      
      	if (!options->msg_type) {
      		int i;
    --		int *tmp;
    -+		enum fsck_msg_type *tmp;
    - 		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
    +-		int *severity;
    ++		enum fsck_msg_type *severity;
    + 		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
      		for (i = 0; i < FSCK_MSG_MAX; i++)
    - 			tmp[i] = fsck_msg_type(i, options);
    + 			severity[i] = fsck_msg_type(i, options);
     @@ fsck.c: static int report(struct fsck_options *options,
      {
      	va_list ap;
    @@ fsck.h
     -#define FSCK_ERROR 1
     -#define FSCK_WARN 2
     -#define FSCK_IGNORE 3
    --
     +enum fsck_msg_type {
    -+	FSCK_INFO = -2,
    ++	FSCK_INFO  = -2,
     +	FSCK_FATAL = -1,
     +	FSCK_ERROR = 1,
     +	FSCK_WARN,
     +	FSCK_IGNORE
     +};
    + 
      struct fsck_options;
      struct object;
    - 
     @@ fsck.h: typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
      /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
      typedef int (*fsck_error)(struct fsck_options *o,
 -:  ----------- > 12:  d55587719a5 fsck.h: re-order and re-assign "enum fsck_msg_type"
 7:  423568026c3 = 13:  32828d1c78c fsck.c: call parse_msg_type() early in fsck_set_msg_type()
 8:  cb43e832738 = 14:  5c62066235c fsck.c: undefine temporary STR macro after use
 9:  2cd14cb4e2a = 15:  f8e50fbf7d3 fsck.c: give "FOREACH_MSG_ID" a more specific name
10:  1ada154ef23 ! 16:  cd74dee8769 fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
    @@ fsck.c
      ## fsck.h ##
     @@ fsck.h: enum fsck_msg_type {
      	FSCK_WARN,
    - 	FSCK_IGNORE
      };
    -+
    + 
     +#define FOREACH_FSCK_MSG_ID(FUNC) \
     +	/* fatal errors */ \
     +	FUNC(NUL_IN_HEADER, FATAL) \
11:  c4179445f22 ! 17:  234e287d081 fsck.c: pass along the fsck_msg_id in the fsck_error callback
    @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
      	switch (msg_type) {
      	case FSCK_WARN:
     
    + ## builtin/index-pack.c ##
    +@@ builtin/index-pack.c: static int print_dangling_gitmodules(struct fsck_options *o,
    + 				     const struct object_id *oid,
    + 				     enum object_type object_type,
    + 				     enum fsck_msg_type msg_type,
    ++				     enum fsck_msg_id msg_id,
    + 				     const char *message)
    + {
    + 	/*
    +@@ builtin/index-pack.c: static int print_dangling_gitmodules(struct fsck_options *o,
    + 		printf("%s\n", oid_to_hex(oid));
    + 		return 0;
    + 	}
    +-	return fsck_error_function(o, oid, object_type, msg_type, message);
    ++	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
    + }
    + 
    + int cmd_index_pack(int argc, const char **argv, const char *prefix)
    +
      ## builtin/mktag.c ##
     @@ builtin/mktag.c: static int mktag_fsck_error_func(struct fsck_options *o,
      				 const struct object_id *oid,
12:  c1fc724f0e8 ! 18:  8049dc07391 fsck.c: add an fsck_set_msg_type() API that takes enums
    @@ fsck.c: int is_valid_msg_type(const char *msg_id, const char *msg_type)
     +{
     +	if (!options->msg_type) {
     +		int i;
    -+		enum fsck_msg_type *tmp;
    -+		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
    ++		enum fsck_msg_type *severity;
    ++		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
     +		for (i = 0; i < FSCK_MSG_MAX; i++)
    -+			tmp[i] = fsck_msg_type(i, options);
    -+		options->msg_type = tmp;
    ++			severity[i] = fsck_msg_type(i, options);
    ++		options->msg_type = severity;
     +	}
     +
     +	options->msg_type[msg_id] = msg_type;
    @@ fsck.c: void fsck_set_msg_type(struct fsck_options *options,
      
     -	if (!options->msg_type) {
     -		int i;
    --		enum fsck_msg_type *tmp;
    --		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
    +-		enum fsck_msg_type *severity;
    +-		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
     -		for (i = 0; i < FSCK_MSG_MAX; i++)
    --			tmp[i] = fsck_msg_type(i, options);
    --		options->msg_type = tmp;
    +-			severity[i] = fsck_msg_type(i, options);
    +-		options->msg_type = severity;
     -	}
     -
     -	options->msg_type[msg_id] = msg_type;
14:  29ff97856ff ! 19:  4224a29d15c fsck.c: move gitmodules_{found,done} into fsck_options
    @@ Commit message
         fsck_options struct. It makes sense to keep all the context in the
         same place.
     
    +    This requires changing the recently added register_found_gitmodules()
    +    function added in 5476e1efde (fetch-pack: print and use dangling
    +    .gitmodules, 2021-02-22) to take fsck_options. That function will be
    +    removed in a subsequent commit, but as it'll require the new
    +    gitmodules_found attribute of "fsck_options" we need this intermediate
    +    step first.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## fetch-pack.c ##
    +@@ fetch-pack.c: static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
    + 
    + 	oidset_iter_init(gitmodules_oids, &iter);
    + 	while ((oid = oidset_iter_next(&iter)))
    +-		register_found_gitmodules(oid);
    ++		register_found_gitmodules(&fo, oid);
    + 	if (fsck_finish(&fo))
    + 		die("fsck failed");
    + }
    +
      ## fsck.c ##
     @@
      #include "credential.h"
    @@ fsck.c: static int fsck_blob(const struct object_id *oid, const char *buf,
      
      	if (object_on_skiplist(options, oid))
      		return 0;
    +@@ fsck.c: int fsck_error_function(struct fsck_options *o,
    + 	return 1;
    + }
    + 
    +-void register_found_gitmodules(const struct object_id *oid)
    ++void register_found_gitmodules(struct fsck_options *options, const struct object_id *oid)
    + {
    +-	oidset_insert(&gitmodules_found, oid);
    ++	oidset_insert(&options->gitmodules_found, oid);
    + }
    + 
    + int fsck_finish(struct fsck_options *options)
     @@ fsck.c: int fsck_finish(struct fsck_options *options)
      	struct oidset_iter iter;
      	const struct object_id *oid;
    @@ fsck.h: struct fsck_options {
      	kh_oid_map_t *object_names;
      };
      
    --#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
    --#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
    -+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, OIDSET_INIT, OIDSET_INIT, NULL }
    -+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, OIDSET_INIT, OIDSET_INIT, NULL }
    +@@ fsck.h: struct fsck_options {
    + 	.walk = NULL, \
    + 	.msg_type = NULL, \
    + 	.skiplist = OIDSET_INIT, \
    ++	.gitmodules_found = OIDSET_INIT, \
    ++	.gitmodules_done = OIDSET_INIT, \
    + 	.object_names = NULL,
    + #define FSCK_OPTIONS_COMMON_ERROR_FUNC \
    + 	FSCK_OPTIONS_COMMON \
    +@@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
    + int fsck_object(struct object *obj, void *data, unsigned long size,
    + 	struct fsck_options *options);
    + 
    +-void register_found_gitmodules(const struct object_id *oid);
    ++void register_found_gitmodules(struct fsck_options *options,
    ++			       const struct object_id *oid);
      
    - /* descend in all linked child objects
    -  * the return value is:
    + /*
    +  * fsck a tag, and pass info about it back to the caller. This is
 -:  ----------- > 20:  40b13468129 fetch-pack: don't needlessly copy fsck_options
 -:  ----------- > 21:  8e418abfbd7 fetch-pack: use file-scope static struct for fsck_options
 -:  ----------- > 22:  113de190f7d fetch-pack: use new fsck API to printing dangling submodules
-- 
2.31.0.rc0.126.g04f22c5b82

