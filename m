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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E90C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A0661941
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhF1TWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhF1TWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE02C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so22608532wrs.12
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rXvX+A17c9f3pGnOBWjMniJr4XbnpS+9f5vAo8P43w=;
        b=L5sgy+lNo0/Iab686uPXj10f7sUrmWBibe6I2gGsBwzE3YcIU9D/c6XXNTdddCqKey
         +WrukMvqMZbzAmPKGau0V21N+55WF6YQCcpyD+zu+xqHs1JNQMpgFQCbHh5iBK0lifr1
         CKX7+DC0YJJ4YHYA9XJIa5fX96wRWAMjHnd0soPPQmQjRnWRTWO+9eZYqV2No+7Z8Azv
         MpzkBSQ1lb+ESCZxTfYBGoEMmO5PvjqnU5y3UXZzDJw5NaI94uqLo4iBBqmSqrAKzorG
         0ZJp1PMSFXNMB92ZobkItSpdDPQ52UpBmhU7dlLLUnIXV2TnssBL+Kwa8UEP3f/61WmU
         nSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rXvX+A17c9f3pGnOBWjMniJr4XbnpS+9f5vAo8P43w=;
        b=t6/CUVU8QAcBIm4oQsVFn63gRgoKzzZ9BD2Hz4snqocdi3j5EXVbAijY+ZddWseh5V
         qpfZNheaj7DknT5N5kBnq900/8tbho6A6RAPmX1UOlP395OjmawwKNNnfsIO2Q+WTMXX
         Anpznn870Rm7St50D2JmNSSJ5KQ+Q1K6xwhaAmCnW92fEy4v7o9zLXdF5rTFdQxc1Tyi
         jlqSnunoZuUoXdxscPyLsFYXVRMziS/OhNO0egddxh7hOdLqAOWYAN/mj1mJG+Dh0v+7
         Y22zekmmNGMJHypAalY0hv6kxlRd3IRhNx1HfrFcv+Xo1ydFMNzqYFNC4BfKuQasU6NK
         nYsw==
X-Gm-Message-State: AOAM533C0jL2UVH7+MBspAa9b/ENCxektmT0c6cTgDekG6GHn799zbIO
        SbLr5Tk2lgj+6k/rODmVsj4DtLQ8BUCJqQ==
X-Google-Smtp-Source: ABdhPJzCbV8cdJpm6v9JpDOpKEpDVckhTS8Uc35TfojQJB1vebXLcQAHfS68sBa8uwPovvOAAAkESg==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr27948626wrw.89.1624907971590;
        Mon, 28 Jun 2021 12:19:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] serve: add "startup_config" callback
Date:   Mon, 28 Jun 2021 21:19:17 +0200
Message-Id: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Jeff pointed out on v1 the control flow around serve.c was more
subtle than I expected, i.e. we might process N requests:
http://lore.kernel.org/git/YMolS8iJAMgbbg9D@coredump.intra.peff.net

This v2 has a 1-4/8 that's a trivially improved version of what Junio
picked up for "seen", the only change is addressing Eric's feedback
that the "struct strvec;" could also be removed.

Then 5-6/8 is a new trivial refactoring of the various callback
invocations into a rapper function, allowing us to add a trace2 region
for the advertisements & command we run.

After that 7-8/8 is a new approach of doing this "configure" callback,
I was on the fence about whether it should be another series on top,
but decided to submit it as one thing.

Now instead of there being a "configure" we explicitly have a
"startup_config" where we expect to stick all our config that doesn't
change, won't be different depending on what "mode" or "command" we
operate as, and in the case of upload-pack doesn't depend on anything
in "upload_pack_data".

As the diffstat shows it doesn't make the code shorter, but I think it
makes it easier to read and maintain, as we now clearly separate the
types of config we're reading.

Ævar Arnfjörð Bjarmason (8):
  serve: mark has_capability() as static
  transport: rename "fetch" in transport_vtable to "fetch_refs"
  transport: use designated initializers
  serve: use designated initializers
  serve.c: add call_{advertise,command}() indirection
  serve.c: add trace2 regions for advertise & command
  serve: add support for a "startup" git_config() callback
  upload-pack.c: convert to new serve.c "startup" config cb

 ls-refs.c                             |  42 +++-----
 ls-refs.h                             |   1 +
 serve.c                               | 138 +++++++++++++++++++++----
 serve.h                               |   4 -
 t/t5705-session-id-in-capabilities.sh |  16 ++-
 transport-helper.c                    |  18 ++--
 transport-internal.h                  |   2 +-
 transport.c                           |  32 +++---
 upload-pack.c                         | 139 +++++++++++++++-----------
 upload-pack.h                         |   2 +
 10 files changed, 255 insertions(+), 139 deletions(-)

Range-diff against v1:
1:  4f74d7d34c4 ! 1:  fdb0c5f4df1 serve: mark has_capability() as static
    @@ serve.c: static int is_command(const char *key, struct protocol_capability **com
     
      ## serve.h ##
     @@
    + #ifndef SERVE_H
      #define SERVE_H
      
    - struct strvec;
    +-struct strvec;
     -int has_capability(const struct strvec *keys, const char *capability,
     -		   const char **value);
     -
2:  c6720d1bf33 = 2:  7b8101dca71 transport: rename "fetch" in transport_vtable to "fetch_refs"
3:  369efe0eed5 = 3:  766045e5f1d transport: use designated initializers
4:  8e97412d584 = 4:  bd920de1629 serve: use designated initializers
-:  ----------- > 5:  d0b02aa0c7d serve.c: add call_{advertise,command}() indirection
-:  ----------- > 6:  baeee6539ad serve.c: add trace2 regions for advertise & command
5:  c8625025125 ! 7:  0a4fb01ae38 serve: add support for a git_config() callback
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    serve: add support for a git_config() callback
    +    serve: add support for a "startup" git_config() callback
     
         Since the introduction of serve.c we've added git_config() callbacks
         and other config reading for capabilities in the following commits:
     
         - e20b4192a37 (upload-pack: support hidden refs with protocol v2, 2018-12-18)
    -    - 59e1205d167 (ls-refs: report unborn targets of symrefs, 2021-02-05)
    +    - 08450ef7918 (upload-pack: clear filter_options for each v2 fetch command, 2020-05-08)
         - 6b5b6e422ee (serve: advertise session ID in v2 capabilities, 2020-11-11)
    +    - 59e1205d167 (ls-refs: report unborn targets of symrefs, 2021-02-05)
     
    -    This code can be simplified by simply adding support to serve.c itself
    -    for reading config at the right time before the capability is
    -    called. In particular the ensure_config_read() function being gone
    -    makes this whole thing much simpler.
    +    Of these 08450ef7918 fixed code that needed to read config on a
    +    per-request basis, whereas most of the config reading just wants to
    +    check if we've enabled one semi-static config variable or other. We'd
    +    like to re-read that value eventually, but from request-to-request
    +    it's OK if we retain the old one, and it isn't impacted by other
    +    request data.
     
    -    A behavior change here is that we're eagerly doing the configuration
    -    for all our capabilities regardless of which one we end up serving,
    -    whereas before we'd defer it until the point where we were processing
    -    the specific command.
    +    So let's support this common pattern as a "startup_config" callback,
    +    making use of our recently added "call_{advertise,command}()"
    +    functions. This allows us to simplify e.g. the "ensure_config_read()"
    +    function added in 59e1205d167 (ls-refs: report unborn targets of
    +    symrefs, 2021-02-05).
     
    -    We could try to be more lazy here and only read the config if we find
    -    out that we're serving "ls-refs" or "session-id", but it's just a fast
    -    git_config() callback, I think in this case simplicity trumps a
    -    premature optimization.
    +    We could read all the config for all the protocol capabilities, but
    +    let's do it one callback at a time in anticipation that some won't be
    +    called at all, and that some might be more expensive than others in
    +    the future.
    +
    +    I'm not migrating over the code in the upload_pack_v2 function in
    +    upload-pack.c yet, that case is more complex since it deals with both
    +    v1 and v2. It will be dealt with in a code a subsequent commit.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ ls-refs.c
     -static int config_read;
     -static int advertise_unborn;
     -static int allow_unborn;
    --
    ++/* "unborn" is on by default if there's no lsrefs.unborn config */
    ++static int advertise_unborn = 1;
    ++static int allow_unborn = 1;
    + 
     -static void ensure_config_read(void)
    --{
    ++int ls_refs_startup_config(const char *var, const char *value, void *data)
    + {
     -	const char *str = NULL;
     -
     -	if (config_read)
    @@ ls-refs.c
     -	} else {
     -		if (!strcmp(str, "advertise")) {
     -			advertise_unborn = 1;
    --			allow_unborn = 1;
    --		} else if (!strcmp(str, "allow")) {
    --			allow_unborn = 1;
    --		} else if (!strcmp(str, "ignore")) {
    --			/* do nothing */
    --		} else {
    --			die(_("invalid value '%s' for lsrefs.unborn"), str);
    --		}
    --	}
    --	config_read = 1;
    --}
    -+/* "unborn" is on by default if there's no lsrefs.unborn config */
    -+static int advertise_unborn = 1;
    -+static int allow_unborn = 1;
    - 
    - /*
    -  * Check if one of the prefixes is a prefix of the ref.
    -@@ ls-refs.c: static void send_possibly_unborn_head(struct ls_refs_data *data)
    - 	strbuf_release(&namespaced);
    - }
    - 
    --static int ls_refs_config(const char *var, const char *value, void *data)
    -+int ls_refs_configure(const char *var, const char *value, void *data)
    - {
     +	if (!strcmp(var, "lsrefs.unborn")) {
     +		if (!strcmp(value, "advertise")) {
     +			/* Allowed and advertised by default */
     +		} else if (!strcmp(value, "allow")) {
     +			advertise_unborn = 0;
    -+			allow_unborn = 1;
    + 			allow_unborn = 1;
    +-		} else if (!strcmp(str, "allow")) {
    +-			allow_unborn = 1;
    +-		} else if (!strcmp(str, "ignore")) {
    +-			/* do nothing */
     +		} else if (!strcmp(value, "ignore")) {
     +			advertise_unborn = 0;
     +			allow_unborn = 0;
    -+		} else {
    + 		} else {
    +-			die(_("invalid value '%s' for lsrefs.unborn"), str);
     +			die(_("invalid value '%s' for lsrefs.unborn"), value);
    -+		}
    -+	}
    -+
    - 	/*
    - 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
    - 	 * config. This may need to eventually be expanded to "receive", but we
    + 		}
    + 	}
    +-	config_read = 1;
    ++	return 0;
    + }
    + 
    + /*
     @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
    + 
      	memset(&data, 0, sizeof(data));
      	strvec_init(&data.prefixes);
    - 
    --	ensure_config_read();
    --	git_config(ls_refs_config, NULL);
     -
    +-	ensure_config_read();
    + 	git_config(ls_refs_config, NULL);
    + 
      	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
    - 		const char *arg = request->line;
    - 		const char *out;
     @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
      int ls_refs_advertise(struct repository *r, struct strbuf *value)
      {
    @@ ls-refs.h: struct strvec;
      struct packet_reader;
      int ls_refs(struct repository *r, struct strvec *keys,
      	    struct packet_reader *request);
    -+int ls_refs_configure(const char *var, const char *value, void *data);
    ++int ls_refs_startup_config(const char *var, const char *value, void *data);
      int ls_refs_advertise(struct repository *r, struct strbuf *value);
      
      #endif /* LS_REFS_H */
    @@ serve.c: static int object_format_advertise(struct repository *r,
      	return 1;
      }
      
    -+static int session_id_configure(const char *var, const char *value, void *data)
    ++static int session_id_startup_config(const char *var, const char *value, void *data)
     +{
     +	if (!strcmp(var, "transfer.advertisesid"))
     +		advertise_sid = git_config_bool(var, value);
    @@ serve.c: struct protocol_capability {
      	const char *name;
      
     +	/*
    -+	 * A git_config() callback. If defined it'll be dispatched too
    -+	 * sometime before the other functions are called, giving the
    -+	 * capability a chance to configure itself.
    ++	 * A git_config() callback that'll be called only once for the
    ++	 * lifetime of the process, possibly over many different
    ++	 * requests. Used for reading config that's expected to be
    ++	 * static.
    ++	 *
    ++	 * The "command" or "advertise" callbacks themselves are
    ++	 * expected to read config that needs to be more current than
    ++	 * that, or which is dependent on request data.
     +	 */
    -+	int (*configure)(const char *var, const char *value, void *data);
    ++	int (*startup_config)(const char *var, const char *value, void *data);
    ++
    ++	/*
    ++	 * A boolean to check if we've called our "startup_config"
    ++	 * callback.
    ++	 */
    ++	int have_startup_config;
     +
      	/*
      	 * Function queried to see if a capability should be advertised.
    @@ serve.c: static struct protocol_capability capabilities[] = {
      	},
      	{
      		.name = "ls-refs",
    -+		.configure = ls_refs_configure,
    ++		.startup_config = ls_refs_startup_config,
      		.advertise = ls_refs_advertise,
      		.command = ls_refs,
      	},
    @@ serve.c: static struct protocol_capability capabilities[] = {
      	},
      	{
      		.name = "session-id",
    -+		.configure = session_id_configure,
    ++		.startup_config = session_id_startup_config,
      		.advertise = session_id_advertise,
      	},
      	{
    @@ serve.c: static struct protocol_capability capabilities[] = {
      	},
      };
      
    -+static int git_serve_config(const char *var, const char *value, void *data)
    ++static void read_startup_config(struct protocol_capability *command)
     +{
    -+	int i;
    -+	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
    -+		struct protocol_capability *c = &capabilities[i];
    -+		config_fn_t fn = c->configure;
    -+		int ret;
    -+		if (!fn)
    -+			continue;
    -+		ret = fn(var, value, data);
    -+		if (ret)
    -+			return ret;
    -+	}
    -+	return 0;
    ++	if (!command->startup_config)
    ++		return;
    ++	if (command->have_startup_config++)
    ++		return;
    ++	git_config(command->startup_config, NULL);
     +}
     +
    - static void advertise_capabilities(void)
    + static int call_advertise(struct protocol_capability *command,
    + 			  struct repository *r, struct strbuf *value)
      {
    - 	struct strbuf capability = STRBUF_INIT;
    +@@ serve.c: static int call_advertise(struct protocol_capability *command,
    + 	struct strbuf sb = STRBUF_INIT;
    + 	const char *msg;
    + 
    ++	read_startup_config(command);
    ++
    + 	strbuf_addf(&sb, "advertise/%s", command->name);
    + 	trace2_region_enter("serve", sb.buf, r);
    + 	ret = command->advertise(r, value);
    +@@ serve.c: static int call_command(struct protocol_capability *command,
    + 	int ret;
    + 	struct strbuf sb = STRBUF_INIT;
    + 
    ++	read_startup_config(command);
    ++
    + 	strbuf_addf(&sb, "command/%s", command->name);
    + 	trace2_region_enter("serve", sb.buf, r);
    + 	ret = command->command(r, keys, request);
     @@ serve.c: static int process_request(void)
      /* Main serve loop for protocol version 2 */
      void serve(struct serve_options *options)
      {
     -	git_config_get_bool("transfer.advertisesid", &advertise_sid);
    -+	git_config(git_serve_config, NULL);
    - 
    +-
      	if (options->advertise_capabilities || !options->stateless_rpc) {
      		/* serve by default supports v2 */
    + 		packet_write_fmt(1, "version 2\n");
-:  ----------- > 8:  9fd6138aa62 upload-pack.c: convert to new serve.c "startup" config cb
-- 
2.32.0.611.gd4a17395dfa

