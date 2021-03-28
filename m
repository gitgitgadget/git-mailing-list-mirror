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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48600C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064826196D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhC1NP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1NP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:15:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14198C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v4so10126079wrp.13
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssaIGggvMKVRFv58Oc4NZ0TOT22W7rZ0unzNMCP10TE=;
        b=WTWyu+3tiM1c+J6RIF7JGglBBGFZuRdkdFifAQ5dhF/VIc3PGozY2VJ0n1nGQrfbrI
         /U3pZhC2f8yBXvpK7ny8EYabrmcgpIe8KhX32mHeAUQfcKTuLFfqR9Xebqn47ZsCnvI+
         380FTFtokMl50pyq7hUrhg0ZrDEqdIKdHVg5QLqeAunPn1GEzyhVubi0h48/y/URgkpw
         yRu1xXhC/SGMwymV7PzdVwfIKUdW5vpAQmfRnco3cYEuzJkeUZzKVfsrXgjkAEPsN6qb
         k1KJ1oCiOY9kyJwWQjuRjBlLumTYiHxFbOUtpXDanxEvmaIkmIDLCJ29eRUq9Zk/fWQ7
         mI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssaIGggvMKVRFv58Oc4NZ0TOT22W7rZ0unzNMCP10TE=;
        b=kHsQz4SF4tFQlzhjhAcKuMFG0PHruSQs03kNHoNcja/LCsuaPcNYDgwJrvvdK7/4KM
         sKoGktkGNcFIeXf2PUZlX3hiJ1/M7BILDZlLm8MGnwtKt2CFETHh39xvLdifRkeltO8/
         6/vhYgvQcDFIF/4vs+/8ukWvHBZN+fajUgUGmx7Bn/xiBJTnorBOoWGAhFkRn1MSnltw
         O32mcYfywOLFXkidm6ahFdjcFIeEEH+BQfXkdft7Vs5hSYAH89doRFlgnGE09jgAwR6I
         8ArHqHaEjK/brHyWZtTIitY62Lc+wCem7Aa1SB9T8WI07z78UlNaWKt0ora2X/G6pzE6
         YFKw==
X-Gm-Message-State: AOAM531ZtX4ruV6PkVjeKtzQhbxnyWTX7yRrjRRQ2pN4aqZ8zXp5S1O1
        sqfQ4A0gOko0Ehd+IqB763iziq6u+Q0SPw==
X-Google-Smtp-Source: ABdhPJxtPE+zHDgpmBNJg/DscfQIz9s4lc1003VPc4gWxdrDX7pYyfwp9s+NeBAly/I8tmSx57C0yQ==
X-Received: by 2002:adf:dc91:: with SMTP id r17mr23979543wrj.293.1616937354383;
        Sun, 28 Mar 2021 06:15:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/19] fsck: API improvements
Date:   Sun, 28 Mar 2021 15:15:32 +0200
Message-Id: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <20210317182054.5986-1-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To recap on the goals in v1[1] this series gets rid of the need to
have the rececently added "print_dangling_gitmodules" function in
favor of a better fsck API to get at that information.

Changes since v5[2]:

 * Addressed all outstanding feedback AFAICT
 * The fields we init to 0/NULL in the new designated initializer are
   gone
 * There were comments on the refactoring of append_msg_id(), It turns
   out that we can entirely remove that function. So a new commit go
   added + one ejected to do that.
 * Clarifications in commit messages.
 * I'd still left behind a remnant of the old
   "print_dangling_gitmodules" code in v5's last commit. I.e. we had
   code that was accumulating its own list of gitmodules OIDs and then
   injecting into the fsck state, now that the fsck state tracks those
   itself we can that list directly instead.

1. https://lore.kernel.org/git/20210217194246.25342-1-avarab@gmail.com/
2. https://lore.kernel.org/git/20210317182054.5986-1-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (19):
  fsck.c: refactor and rename common config callback
  fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
  fsck.h: use "enum object_type" instead of "int"
  fsck.c: rename variables in fsck_set_msg_type() for less confusion
  fsck.c: remove (mostly) redundant append_msg_id() function
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
 fetch-pack.c             |  31 ++----
 fsck.c                   | 207 +++++++++++++--------------------------
 fsck.h                   | 127 +++++++++++++++++++++---
 7 files changed, 210 insertions(+), 216 deletions(-)

Range-diff:
 1:  fe33015e0d9 =  1:  579af32ab3e fsck.c: refactor and rename common config callback
 2:  72f2e53afac !  2:  b17c982293e fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
    @@ Commit message
         fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
     
         Refactor the definitions of FSCK_OPTIONS_{DEFAULT,STRICT} to use
    -    designated initializers.
    -
    -    While I'm at it add the "object_names" member to the
    -    initialization. This was omitted in 7b35efd734e (fsck_walk():
    -    optionally name objects on the go, 2016-07-17) when the field was
    -    added.
    -
    -    I'm using a new FSCK_OPTIONS_COMMON and FSCK_OPTIONS_COMMON_ERROR_FUNC
    -    helper macros to define what FSCK_OPTIONS_{DEFAULT,STRICT} have in
    -    common, and define the two in terms of those macro.
    -
    -    The FSCK_OPTIONS_COMMON macro will be used in a subsequent commit to
    -    define other variants of common fsck initialization that wants to use
    -    a custom error function, but share the rest of the defaults.
    +    designated initializers. This allows us to omit those fields that
    +    aren't initialized to zero or NULL.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ fsck.h: struct fsck_options {
      
     -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
     -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
    -+#define FSCK_OPTIONS_COMMON \
    -+	.walk = NULL, \
    -+	.msg_type = NULL, \
    ++#define FSCK_OPTIONS_DEFAULT { \
     +	.skiplist = OIDSET_INIT, \
    -+	.object_names = NULL,
    -+#define FSCK_OPTIONS_COMMON_ERROR_FUNC \
    -+	FSCK_OPTIONS_COMMON \
    -+	.error_func = fsck_error_function
    -+
    -+#define FSCK_OPTIONS_DEFAULT	{ .strict = 0, FSCK_OPTIONS_COMMON_ERROR_FUNC }
    -+#define FSCK_OPTIONS_STRICT	{ .strict = 1, FSCK_OPTIONS_COMMON_ERROR_FUNC }
    ++	.error_func = fsck_error_function \
    ++}
    ++#define FSCK_OPTIONS_STRICT { \
    ++	.strict = 1, \
    ++	.error_func = fsck_error_function, \
    ++}
      
      /* descend in all linked child objects
       * the return value is:
 3:  237a2806865 =  3:  a721c396c50 fsck.h: use "enum object_type" instead of "int"
 4:  13b76c73dd7 =  4:  fcdba2f8fe8 fsck.c: rename variables in fsck_set_msg_type() for less confusion
 5:  4ae83403b73 !  5:  b07e8e026ac fsck.c: move definition of msg_id into append_msg_id()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fsck.c: move definition of msg_id into append_msg_id()
    +    fsck.c: remove (mostly) redundant append_msg_id() function
     
    -    Refactor code added in 71ab8fa840f (fsck: report the ID of the
    -    error/warning, 2015-06-22) to resolve the msg_id to a string in the
    -    function that wants it, instead of doing it in report().
    +    Remove the append_msg_id() function in favor of calling
    +    prepare_msg_ids(). We already have code to compute the camel-cased
    +    msg_id strings in msg_id_info, let's use it.
    +
    +    When the append_msg_id() function was added in 71ab8fa840f (fsck:
    +    report the ID of the error/warning, 2015-06-22) the prepare_msg_ids()
    +    function didn't exist. When prepare_msg_ids() was added in
    +    a46baac61eb (fsck: factor out msg_id_info[] lazy initialization code,
    +    2018-05-26) this code wasn't moved over to lazy initialization.
    +
    +    This changes the behavior of the code to initialize all the messages
    +    instead of just camel-casing the one we need on the fly. Since the
    +    common case is that we're printing just one message this is mostly
    +    redundant work.
    +
    +    But that's OK in this case, reporting this fsck issue to the user
    +    isn't performance-sensitive. If we were somehow doing so in a tight
    +    loop (in a hopelessly broken repository?) this would help, since we'd
    +    save ourselves from re-doing this work for identical messages, we
    +    could just grab the prepared string from msg_id_info after the first
    +    invocation.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ fsck.c: void fsck_set_msg_types(struct fsck_options *options, const char *values
      }
      
     -static void append_msg_id(struct strbuf *sb, const char *msg_id)
    -+static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
    +-{
    +-	for (;;) {
    +-		char c = *(msg_id)++;
    +-
    +-		if (!c)
    +-			break;
    +-		if (c != '_')
    +-			strbuf_addch(sb, tolower(c));
    +-		else {
    +-			assert(*msg_id);
    +-			strbuf_addch(sb, *(msg_id)++);
    +-		}
    +-	}
    +-
    +-	strbuf_addstr(sb, ": ");
    +-}
    +-
    + static int object_on_skiplist(struct fsck_options *opts,
    + 			      const struct object_id *oid)
      {
    -+	const char *msg_id = msg_id_info[id].id_string;
    - 	for (;;) {
    - 		char c = *(msg_id)++;
    - 
     @@ fsck.c: static int report(struct fsck_options *options,
      	else if (msg_type == FSCK_INFO)
      		msg_type = FSCK_WARN;
      
     -	append_msg_id(&sb, msg_id_info[id].id_string);
    -+	append_msg_id(&sb, id);
    ++	prepare_msg_ids();
    ++	strbuf_addf(&sb, "%s: ", msg_id_info[id].camelcased);
      
      	va_start(ap, fmt);
      	strbuf_vaddf(&sb, fmt, ap);
 6:  82107f1dac0 !  6:  321b0c652de fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## fsck.c ##
    -@@ fsck.c: void fsck_set_msg_types(struct fsck_options *options, const char *values)
    - 	free(to_free);
    - }
    - 
    --static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
    -+static void append_msg_id(struct strbuf *sb, enum fsck_msg_id msg_id)
    - {
    --	const char *msg_id = msg_id_info[id].id_string;
    -+	const char *msg_id_str = msg_id_info[msg_id].id_string;
    - 	for (;;) {
    --		char c = *(msg_id)++;
    -+		char c = *(msg_id_str)++;
    - 
    - 		if (!c)
    - 			break;
    - 		if (c != '_')
    - 			strbuf_addch(sb, tolower(c));
    - 		else {
    --			assert(*msg_id);
    --			strbuf_addch(sb, *(msg_id)++);
    -+			assert(*msg_id_str);
    -+			strbuf_addch(sb, *(msg_id_str)++);
    - 		}
    - 	}
    - 
     @@ fsck.c: static int object_on_skiplist(struct fsck_options *opts,
      __attribute__((format (printf, 5, 6)))
      static int report(struct fsck_options *options,
    @@ fsck.c: static int object_on_skiplist(struct fsck_options *opts,
      	if (msg_type == FSCK_IGNORE)
      		return 0;
     @@ fsck.c: static int report(struct fsck_options *options,
    - 	else if (msg_type == FSCK_INFO)
      		msg_type = FSCK_WARN;
      
    --	append_msg_id(&sb, id);
    -+	append_msg_id(&sb, msg_id);
    + 	prepare_msg_ids();
    +-	strbuf_addf(&sb, "%s: ", msg_id_info[id].camelcased);
    ++	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
      
      	va_start(ap, fmt);
      	strbuf_vaddf(&sb, fmt, ap);
 7:  796096bf73e =  7:  948689ad5c8 fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
 8:  3664abb23de =  8:  8ea468bf4d8 fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
 9:  81e6d7ab450 !  9:  9316b35cd3b fsck.h: re-order and re-assign "enum fsck_msg_type"
    @@ Commit message
         defined as "2".
     
         I'm confident that nothing relies on these values, we always compare
    -    them explicitly. Let's not omit "0" so it won't be assumed that we're
    -    using these as a boolean somewhere.
    +    them for equality. Let's not omit "0" so it won't be assumed that
    +    we're using these as a boolean somewhere.
     
         This also allows us to re-structure the fields to mark which are
         "private" v.s. "public". See the preceding commit for a rationale for
10:  5c2e8e7b842 = 10:  d7f1c5d37de fsck.c: call parse_msg_type() early in fsck_set_msg_type()
11:  7ffbf9af3fa = 11:  ae5efd745cf fsck.c: undefine temporary STR macro after use
12:  12ff0f75ebf = 12:  96995244806 fsck.c: give "FOREACH_MSG_ID" a more specific name
13:  0c49dd5164f = 13:  1b42aea3a64 fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
14:  900263f503a = 14:  563e6a0e5e6 fsck.c: pass along the fsck_msg_id in the fsck_error callback
15:  5f270e88a0a = 15:  5e504f25c51 fsck.c: add an fsck_set_msg_type() API that takes enums
16:  539d0197129 ! 16:  611631dd779 fsck.c: move gitmodules_{found,done} into fsck_options
    @@ Commit message
         gitmodules_found attribute of "fsck_options" we need this intermediate
         step first.
     
    +    An earlier version of this patch removed the small amount of
    +    duplication we now have between FSCK_OPTIONS_{DEFAULT,STRICT} with a
    +    FSCK_OPTIONS_COMMON macro. I don't think such de-duplication is worth
    +    it for this amount of copy/pasting.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## fetch-pack.c ##
    @@ fsck.h: struct fsck_options {
      	kh_oid_map_t *object_names;
      };
      
    -@@ fsck.h: struct fsck_options {
    - 	.walk = NULL, \
    - 	.msg_type = NULL, \
    + #define FSCK_OPTIONS_DEFAULT { \
      	.skiplist = OIDSET_INIT, \
     +	.gitmodules_found = OIDSET_INIT, \
     +	.gitmodules_done = OIDSET_INIT, \
    - 	.object_names = NULL,
    - #define FSCK_OPTIONS_COMMON_ERROR_FUNC \
    - 	FSCK_OPTIONS_COMMON \
    + 	.error_func = fsck_error_function \
    + }
    + #define FSCK_OPTIONS_STRICT { \
    + 	.strict = 1, \
    ++	.gitmodules_found = OIDSET_INIT, \
    ++	.gitmodules_done = OIDSET_INIT, \
    + 	.error_func = fsck_error_function, \
    + }
    + 
     @@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
      int fsck_object(struct object *obj, void *data, unsigned long size,
      	struct fsck_options *options);
17:  1acf7442365 = 17:  03d512c8448 fetch-pack: don't needlessly copy fsck_options
18:  b47c3d5ac6f = 18:  581c87c63c6 fetch-pack: use file-scope static struct for fsck_options
19:  f05fa5c3ec9 ! 19:  6a38cade8c3 fetch-pack: use new fsck API to printing dangling submodules
    @@ fetch-pack.c: static int server_supports_filtering;
      static struct strbuf fsck_msg_types = STRBUF_INIT;
      static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
      
    -@@ fetch-pack.c: static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
    +@@ fetch-pack.c: static int cmp_ref_by_name(const void *a_, const void *b_)
    + 	return strcmp(a->name, b->name);
    + }
      
    - 	oidset_iter_init(gitmodules_oids, &iter);
    - 	while ((oid = oidset_iter_next(&iter)))
    +-static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
    +-{
    +-	struct oidset_iter iter;
    +-	const struct object_id *oid;
    +-
    +-	if (!oidset_size(gitmodules_oids))
    +-		return;
    +-
    +-	oidset_iter_init(gitmodules_oids, &iter);
    +-	while ((oid = oidset_iter_next(&iter)))
     -		register_found_gitmodules(&fsck_options, oid);
    -+		oidset_insert(&fsck_options.gitmodules_found, oid);
    - 	if (fsck_finish(&fsck_options))
    - 		die("fsck failed");
    - }
    +-	if (fsck_finish(&fsck_options))
    +-		die("fsck failed");
    +-}
    +-
    + static struct ref *do_fetch_pack(struct fetch_pack_args *args,
    + 				 int fd[2],
    + 				 const struct ref *orig_ref,
    +@@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
    + 	int agent_len;
    + 	struct fetch_negotiator negotiator_alloc;
    + 	struct fetch_negotiator *negotiator;
    +-	struct oidset gitmodules_oids = OIDSET_INIT;
    + 
    + 	negotiator = &negotiator_alloc;
    + 	fetch_negotiator_init(r, negotiator);
    +@@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
    + 	else
    + 		alternate_shallow_file = NULL;
    + 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
    +-		     &gitmodules_oids))
    ++		     &fsck_options.gitmodules_found))
    + 		die(_("git fetch-pack: fetch failed."));
    +-	fsck_gitmodules_oids(&gitmodules_oids);
    ++	if (fsck_finish(&fsck_options))
    ++		die("fsck failed");
    + 
    +  all_done:
    + 	if (negotiator)
    +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
    + 	int i;
    + 	struct strvec index_pack_args = STRVEC_INIT;
    +-	struct oidset gitmodules_oids = OIDSET_INIT;
    + 
    + 	negotiator = &negotiator_alloc;
    + 	fetch_negotiator_init(r, negotiator);
    +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 			process_section_header(&reader, "packfile", 0);
    + 			if (get_pack(args, fd, pack_lockfiles,
    + 				     packfile_uris.nr ? &index_pack_args : NULL,
    +-				     sought, nr_sought, &gitmodules_oids))
    ++				     sought, nr_sought, &fsck_options.gitmodules_found))
    + 				die(_("git fetch-pack: fetch failed."));
    + 			do_check_stateless_delimiter(args, &reader);
    + 
    +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 
    + 		packname[the_hash_algo->hexsz] = '\0';
    + 
    +-		parse_gitmodules_oids(cmd.out, &gitmodules_oids);
    ++		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
    + 
    + 		close(cmd.out);
    + 
    +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 	string_list_clear(&packfile_uris, 0);
    + 	strvec_clear(&index_pack_args);
    + 
    +-	fsck_gitmodules_oids(&gitmodules_oids);
    ++	if (fsck_finish(&fsck_options))
    ++		die("fsck failed");
    + 
    + 	if (negotiator)
    + 		negotiator->release(negotiator);
     
      ## fsck.c ##
     @@ fsck.c: int fsck_error_function(struct fsck_options *o,
    @@ fsck.c: int git_fsck_config(const char *var, const char *value, void *cb)
     +}
     
      ## fsck.h ##
    +@@ fsck.h: int fsck_error_function(struct fsck_options *o,
    + 			const struct object_id *oid, enum object_type object_type,
    + 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
    + 			const char *message);
    ++int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    ++					   const struct object_id *oid,
    ++					   enum object_type object_type,
    ++					   enum fsck_msg_type msg_type,
    ++					   enum fsck_msg_id msg_id,
    ++					   const char *message);
    + 
    + struct fsck_options {
    + 	fsck_walk_func walk;
    +@@ fsck.h: struct fsck_options {
    + 	.gitmodules_done = OIDSET_INIT, \
    + 	.error_func = fsck_error_function, \
    + }
    ++#define FSCK_OPTIONS_MISSING_GITMODULES { \
    ++	.strict = 1, \
    ++	.gitmodules_found = OIDSET_INIT, \
    ++	.gitmodules_done = OIDSET_INIT, \
    ++	.error_func = fsck_error_cb_print_missing_gitmodules, \
    ++}
    + 
    + /* descend in all linked child objects
    +  * the return value is:
     @@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
      int fsck_object(struct object *obj, void *data, unsigned long size,
      	struct fsck_options *options);
    @@ fsck.h: int fsck_walk(struct object *obj, void *data, struct fsck_options *optio
      /*
       * fsck a tag, and pass info about it back to the caller. This is
       * exposed fsck_object() internals for git-mktag(1).
    -@@ fsck.h: const char *fsck_describe_object(struct fsck_options *options,
    -  */
    - int git_fsck_config(const char *var, const char *value, void *cb);
    - 
    -+/*
    -+ * Custom error callbacks that are used in more than one place.
    -+ */
    -+#define FSCK_OPTIONS_MISSING_GITMODULES { \
    -+	.strict = 1, \
    -+	.error_func = fsck_error_cb_print_missing_gitmodules, \
    -+	FSCK_OPTIONS_COMMON \
    -+}
    -+int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    -+					   const struct object_id *oid,
    -+					   enum object_type object_type,
    -+					   enum fsck_msg_type msg_type,
    -+					   enum fsck_msg_id msg_id,
    -+					   const char *message);
    -+
    - #endif
-- 
2.31.1.445.g087790d4945

