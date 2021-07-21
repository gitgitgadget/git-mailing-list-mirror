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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410D3C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1551A6121F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhGUW7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhGUW7n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACDC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d2so3952352wrn.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2JU0to0I9RBNXjTlK48+nuleoeu9X73pcHtGlgFY60=;
        b=H/elemJV8myUaz/+1EnJ0G8OxDbuOb3LwVxmaGbFmgHQJZflFrDwuUOAQ5NpU46wWz
         BFfcqQOB2Fmsd5dpeBRL1lTDlsuqsPL42iYsT1aPcdudZ/2/e+TXk2mOeScqQWDTzvyY
         uP5F5XWnd8t++UyRTyMgZQIYqVp2aPr4xitmiHbqpKWSmsOa5jtE8X2kaJVGagwyQZDj
         iFFDgOlUsJxZ3qqfVjpYael0bQjXfHMEY/FIaVK+oKzG9TNQ13rgjbZNmQJYxyl3ZFKu
         FMusEFOSjWVZS45eddHLxWMBz610w1sz18zxTedD2tyF5XDfn52F7FAi8O3DufQbbqSs
         u99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2JU0to0I9RBNXjTlK48+nuleoeu9X73pcHtGlgFY60=;
        b=jY0ydvm8joFsWQLKPZwPWu/xQmwh8JmsAOaZ4dXaHlAOFT/T7kDNeuHCKfj33Wbgbc
         9Gz1OKhHEeUJBLFnB5htjxtsik3INGMI1s5CT7k421+A3svlhvUVAvp2IQZUCN5mY1aw
         +BAtcJ7P+/rIjo1erhfQX5vUD/bhpPxvjFXHI2mli9gNx+rOzswTfq3UO2Y2cfjBxJwC
         aWGNq27bTN0HvghNfAB/htEKmoN/qT3XdMGaro2SU1qe1RcdIpp+8j7vWU32DrlxjEuH
         2FRVnZazAFXhF090XxFVhxvs7w8R97W6xnMk8UUvhcaNHtqzUlq84y247VnBnSFO0++Y
         /r1A==
X-Gm-Message-State: AOAM532shvjPng5XFKZqMiOUcCqJKrfDd/oXpNCP+zJxXy5MP7/eaGwY
        E/jpyDIvqOf6zwn0A4LDZfvEkdGrG1GxuA==
X-Google-Smtp-Source: ABdhPJypS3FLHydvmy9Z+LQo2WAjomUQDf8s8F7YTpcVSMCPb7eBIyaqkkFBBpX6Wa/b6oZpjfc2PA==
X-Received: by 2002:adf:de8f:: with SMTP id w15mr40055414wrl.230.1626910816716;
        Wed, 21 Jul 2021 16:40:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/12] serve.[ch]: general API cleanup
Date:   Thu, 22 Jul 2021 01:40:01 +0200
Message-Id: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For v2, see:
https://lore.kernel.org/git/cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com/

Junio: Sorry about the late update, re:
http://lore.kernel.org/git/xmqqsg07cz4g.fsf@gitster.g

I think most people were on the fence about the need for this
"startup_config" callback in v2. I think we could still do without it,
but as the new 08/12 shows a big part of the API complexity was due to
serve() supporting the --advertise-refs mode directly. 08-10/12 is a
new late-series cleanup of that, which makes serve.[ch] a lot simpler.

Ævar Arnfjörð Bjarmason (12):
  serve: mark has_capability() as static
  transport: rename "fetch" in transport_vtable to "fetch_refs"
  transport: use designated initializers
  serve: use designated initializers
  serve.c: add call_{advertise,command}() indirection
  serve: add support for a "startup" git_config() callback
  serve.c: move version line to advertise_capabilities()
  serve.[ch]: remove "serve_options", split up --advertise-refs code
  {upload,receive}-pack tests: add --advertise-refs tests
  upload-pack: document and rename --advertise-refs
  upload-pack.c: convert to new serve.c "startup" config cb
  serve.[ch]: don't pass "struct strvec *keys" to commands

 Documentation/git-receive-pack.txt        |   5 +
 Documentation/git-upload-pack.txt         |  12 +-
 Documentation/technical/http-protocol.txt |   3 +
 Documentation/technical/protocol-v2.txt   |   3 +
 builtin/receive-pack.c                    |   3 +-
 builtin/upload-pack.c                     |  28 ++--
 http-backend.c                            |   2 +-
 ls-refs.c                                 |  45 ++----
 ls-refs.h                                 |   5 +-
 protocol-caps.c                           |   3 +-
 protocol-caps.h                           |   4 +-
 serve.c                                   | 146 ++++++++++++++------
 serve.h                                   |  12 +-
 t/helper/test-serve-v2.c                  |  14 +-
 t/t5555-http-smart-common.sh              | 159 ++++++++++++++++++++++
 transport-helper.c                        |  18 +--
 transport-internal.h                      |   2 +-
 transport.c                               |  32 ++---
 upload-pack.c                             | 154 ++++++++++++---------
 upload-pack.h                             |  16 +--
 20 files changed, 450 insertions(+), 216 deletions(-)
 create mode 100755 t/t5555-http-smart-common.sh

Range-diff against v2:
 1:  fdb0c5f4df1 =  1:  192fb64ef82 serve: mark has_capability() as static
 2:  7b8101dca71 =  2:  d716bd3c537 transport: rename "fetch" in transport_vtable to "fetch_refs"
 3:  766045e5f1d =  3:  d31690614af transport: use designated initializers
 4:  bd920de1629 =  4:  13f1a8d8325 serve: use designated initializers
 5:  d0b02aa0c7d =  5:  99eeff6f890 serve.c: add call_{advertise,command}() indirection
 7:  0a4fb01ae38 !  6:  be719dc3dc1 serve: add support for a "startup" git_config() callback
    @@ Commit message
         upload-pack.c yet, that case is more complex since it deals with both
         v1 and v2. It will be dealt with in a code a subsequent commit.
     
    +    As we'll see in subsequent commits, by moving the
    +    transfer.advertisesid config reading out of serve() we can simplify
    +    the codepath around advertising-only requests. See 6b5b6e422ee (serve:
    +    advertise session ID in v2 capabilities, 2020-11-11)) for the commit
    +    that added transfer.advertisesid.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ls-refs.c ##
    @@ serve.c: static struct protocol_capability capabilities[] = {
      static int call_advertise(struct protocol_capability *command,
      			  struct repository *r, struct strbuf *value)
      {
    -@@ serve.c: static int call_advertise(struct protocol_capability *command,
    - 	struct strbuf sb = STRBUF_INIT;
    - 	const char *msg;
    - 
     +	read_startup_config(command);
     +
    - 	strbuf_addf(&sb, "advertise/%s", command->name);
    - 	trace2_region_enter("serve", sb.buf, r);
    - 	ret = command->advertise(r, value);
    -@@ serve.c: static int call_command(struct protocol_capability *command,
    - 	int ret;
    - 	struct strbuf sb = STRBUF_INIT;
    + 	return command->advertise(r, value);
    + }
      
    +@@ serve.c: static int call_command(struct protocol_capability *command,
    + 			struct repository *r, struct strvec *keys,
    + 			struct packet_reader *request)
    + {
    ++
     +	read_startup_config(command);
     +
    - 	strbuf_addf(&sb, "command/%s", command->name);
    - 	trace2_region_enter("serve", sb.buf, r);
    - 	ret = command->command(r, keys, request);
    + 	return command->command(r, keys, request);
    + }
    + 
     @@ serve.c: static int process_request(void)
      /* Main serve loop for protocol version 2 */
      void serve(struct serve_options *options)
 -:  ----------- >  7:  b7928ddbe9b serve.c: move version line to advertise_capabilities()
 6:  baeee6539ad !  8:  fb80f152713 serve.c: add trace2 regions for advertise & command
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    serve.c: add trace2 regions for advertise & command
    +    serve.[ch]: remove "serve_options", split up --advertise-refs code
     
    -    Now that we've factored out "call_{advertise,command}()" in a
    -    preceding commit it becomes easy to trace all these callbacks with
    -    trace2. Let's do that. As the tests demonstrate there's no v2 push
    -    protocol, which the tests assert.
    +    The "advertise capabilities" mode of serve.c added in
    +    ed10cb952d3 (serve: introduce git-serve, 2018-03-15) is only used by
    +    the http-backend.c to call {upload,receive}-pack with the
    +    --advertise-refs parameter. See 42526b478e3 (Add stateless RPC options
    +    to upload-pack, receive-pack, 2009-10-30).
    +
    +    Let's just make cmd_upload_pack() take the two (v2) or three (v2)
    +    parameters the the v2/v1 servicing functions need directly, and pass
    +    those in via the function signature. The logic of whether daemon mode
    +    is implied by the timeout belongs in the v1 function (only used
    +    there).
    +
    +    Once we split up the "advertise v2 refs" from "serve v2 request" it
    +    becomes clear that v2 never cared about those in combination. The only
    +    time it mattered was for v1 to emit its ref advertisement, in that
    +    case we wanted to emit the smart-http-only "no-done" capability.
    +
    +    Since we only do that in the --advertise-refs codepath let's just have
    +    it set "do_done" itself in v1's upload_pack() just before send_ref(),
    +    at that point --advertise-refs and --stateless-rpc in combination are
    +    redundant (the only user is get_info_refs() in http-backend.c), so we
    +    can just pass in --advertise-refs only.
    +
    +    Since we need to touch all the serve() and advertise_capabilities()
    +    codepaths let's rename them to less clever and obvious names, it's
    +    been suggested numerous times, the latest of which is [1]'s suggestion
    +    for protocol_v2_serve_loop(). Let's go with that.
    +
    +    1. https://lore.kernel.org/git/CAFQ2z_NyGb8rju5CKzmo6KhZXD0Dp21u-BbyCb2aNxLEoSPRJw@mail.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## builtin/upload-pack.c ##
    +@@ builtin/upload-pack.c: int cmd_upload_pack(int argc, const char **argv, const char *prefix)
    + {
    + 	const char *dir;
    + 	int strict = 0;
    +-	struct upload_pack_options opts = { 0 };
    +-	struct serve_options serve_opts = SERVE_OPTIONS_INIT;
    ++	int advertise_refs = 0;
    ++	int stateless_rpc = 0;
    ++	int timeout = 0;
    + 	struct option options[] = {
    +-		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
    ++		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
    + 			 N_("quit after a single request/response exchange")),
    +-		OPT_BOOL(0, "advertise-refs", &opts.advertise_refs,
    ++		OPT_BOOL(0, "advertise-refs", &advertise_refs,
    + 			 N_("exit immediately after initial ref advertisement")),
    + 		OPT_BOOL(0, "strict", &strict,
    + 			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
    +-		OPT_INTEGER(0, "timeout", &opts.timeout,
    ++		OPT_INTEGER(0, "timeout", &timeout,
    + 			    N_("interrupt transfer after <n> seconds of inactivity")),
    + 		OPT_END()
    + 	};
    +@@ builtin/upload-pack.c: int cmd_upload_pack(int argc, const char **argv, const char *prefix)
    + 	if (argc != 1)
    + 		usage_with_options(upload_pack_usage, options);
    + 
    +-	if (opts.timeout)
    +-		opts.daemon_mode = 1;
    +-
    + 	setup_path();
    + 
    + 	dir = argv[0];
    +@@ builtin/upload-pack.c: int cmd_upload_pack(int argc, const char **argv, const char *prefix)
    + 
    + 	switch (determine_protocol_version_server()) {
    + 	case protocol_v2:
    +-		serve_opts.advertise_capabilities = opts.advertise_refs;
    +-		serve_opts.stateless_rpc = opts.stateless_rpc;
    +-		serve(&serve_opts);
    ++		if (advertise_refs)
    ++			protocol_v2_advertise_capabilities();
    ++		else
    ++			protocol_v2_serve_loop(stateless_rpc);
    + 		break;
    + 	case protocol_v1:
    + 		/*
    + 		 * v1 is just the original protocol with a version string,
    + 		 * so just fall through after writing the version string.
    + 		 */
    +-		if (opts.advertise_refs || !opts.stateless_rpc)
    ++		if (advertise_refs || !stateless_rpc)
    + 			packet_write_fmt(1, "version 1\n");
    + 
    + 		/* fallthrough */
    + 	case protocol_v0:
    +-		upload_pack(&opts);
    ++		upload_pack(advertise_refs, stateless_rpc, timeout);
    + 		break;
    + 	case protocol_unknown_version:
    + 		BUG("unknown protocol version");
    +
    + ## http-backend.c ##
    +@@ http-backend.c: static void get_info_refs(struct strbuf *hdr, char *arg)
    + 
    + 	if (service_name) {
    + 		const char *argv[] = {NULL /* service name */,
    +-			"--stateless-rpc", "--advertise-refs",
    ++			"--advertise-refs",
    + 			".", NULL};
    + 		struct rpc_service *svc = select_service(hdr, service_name);
    + 
    +
      ## serve.c ##
    -@@ serve.c: static struct protocol_capability capabilities[] = {
    - static int call_advertise(struct protocol_capability *command,
    - 			  struct repository *r, struct strbuf *value)
    +@@ serve.c: static int call_command(struct protocol_capability *command,
    + 	return command->command(r, keys, request);
    + }
    + 
    +-static void advertise_capabilities(void)
    ++void protocol_v2_advertise_capabilities(void)
      {
    --	return command->advertise(r, value);
    -+	int ret;
    -+	struct strbuf sb = STRBUF_INIT;
    -+	const char *msg;
    -+
    -+	strbuf_addf(&sb, "advertise/%s", command->name);
    -+	trace2_region_enter("serve", sb.buf, r);
    -+	ret = command->advertise(r, value);
    -+	msg = ret ? "advertised" : "hidden";
    -+	trace2_region_leave_printf("serve", sb.buf, r, "%s", msg);
    -+	strbuf_release(&sb);
    -+
    -+	return ret;
    + 	struct strbuf capability = STRBUF_INIT;
    + 	struct strbuf value = STRBUF_INIT;
    +@@ serve.c: static int process_request(void)
    + 	return 0;
      }
      
    - static int call_command(struct protocol_capability *command,
    - 			struct repository *r, struct strvec *keys,
    - 			struct packet_reader *request)
    +-/* Main serve loop for protocol version 2 */
    +-void serve(struct serve_options *options)
    ++void protocol_v2_serve_loop(int stateless_rpc)
      {
    --	return command->command(r, keys, request);
    -+	int ret;
    -+	struct strbuf sb = STRBUF_INIT;
    -+
    -+	strbuf_addf(&sb, "command/%s", command->name);
    -+	trace2_region_enter("serve", sb.buf, r);
    -+	ret = command->command(r, keys, request);
    -+	trace2_region_leave("serve", sb.buf, r);
    -+	strbuf_release(&sb);
    +-	if (options->advertise_capabilities || !options->stateless_rpc) {
    +-		advertise_capabilities();
    +-		/*
    +-		 * If only the list of capabilities was requested exit
    +-		 * immediately after advertising capabilities
    +-		 */
    +-		if (options->advertise_capabilities)
    +-			return;
    +-	}
    ++	if (!stateless_rpc)
    ++		protocol_v2_advertise_capabilities();
    + 
    + 	/*
    + 	 * If stateless-rpc was requested then exit after
    + 	 * a single request/response exchange
    + 	 */
    +-	if (options->stateless_rpc) {
    ++	if (stateless_rpc) {
    + 		process_request();
    + 	} else {
    + 		for (;;)
    +
    + ## serve.h ##
    +@@
    + #ifndef SERVE_H
    + #define SERVE_H
    + 
    +-struct serve_options {
    +-	unsigned advertise_capabilities;
    +-	unsigned stateless_rpc;
    +-};
    +-#define SERVE_OPTIONS_INIT { 0 }
    +-void serve(struct serve_options *options);
    ++void protocol_v2_advertise_capabilities(void);
    ++void protocol_v2_serve_loop(int stateless_rpc);
    + 
    + #endif /* SERVE_H */
    +
    + ## t/helper/test-serve-v2.c ##
    +@@ t/helper/test-serve-v2.c: static char const * const serve_usage[] = {
    + 
    + int cmd__serve_v2(int argc, const char **argv)
    + {
    +-	struct serve_options opts = SERVE_OPTIONS_INIT;
    +-
    ++	int stateless_rpc = 0;
    ++	int advertise_capabilities = 0;
    + 	struct option options[] = {
    +-		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
    ++		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
    + 			 N_("quit after a single request/response exchange")),
    +-		OPT_BOOL(0, "advertise-capabilities", &opts.advertise_capabilities,
    ++		OPT_BOOL(0, "advertise-capabilities", &advertise_capabilities,
    + 			 N_("exit immediately after advertising capabilities")),
    + 		OPT_END()
    + 	};
    +@@ t/helper/test-serve-v2.c: int cmd__serve_v2(int argc, const char **argv)
    + 	argc = parse_options(argc, argv, prefix, options, serve_usage,
    + 			     PARSE_OPT_KEEP_DASHDASH |
    + 			     PARSE_OPT_KEEP_UNKNOWN);
    +-	serve(&opts);
     +
    -+	return ret;
    ++	if (advertise_capabilities)
    ++		protocol_v2_advertise_capabilities();
    ++	else
    ++		protocol_v2_serve_loop(stateless_rpc);
    + 
    + 	return 0;
    + }
    +
    + ## upload-pack.c ##
    +@@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *oid,
    + 				     " allow-tip-sha1-in-want" : "",
    + 			     (data->allow_uor & ALLOW_REACHABLE_SHA1) ?
    + 				     " allow-reachable-sha1-in-want" : "",
    +-			     data->stateless_rpc ? " no-done" : "",
    ++			     data->no_done ? " no-done" : "",
    + 			     symref_info.buf,
    + 			     data->allow_filter ? " filter" : "",
    + 			     session_id.buf,
    +@@ upload-pack.c: static int upload_pack_config(const char *var, const char *value, void *cb_data)
    + 	return parse_hide_refs_config(var, value, "uploadpack");
      }
      
    - static void advertise_capabilities(void)
    +-void upload_pack(struct upload_pack_options *options)
    ++void upload_pack(const int advertise_refs, const int stateless_rpc,
    ++		 const int timeout)
    + {
    + 	struct packet_reader reader;
    + 	struct upload_pack_data data;
    +@@ upload-pack.c: void upload_pack(struct upload_pack_options *options)
    + 
    + 	git_config(upload_pack_config, &data);
    + 
    +-	data.stateless_rpc = options->stateless_rpc;
    +-	data.daemon_mode = options->daemon_mode;
    +-	data.timeout = options->timeout;
    ++	data.stateless_rpc = stateless_rpc;
    ++	data.timeout = timeout;
    ++	if (data.timeout)
    ++		data.daemon_mode = 1;
    + 
    + 	head_ref_namespaced(find_symref, &data.symref);
    + 
    +-	if (options->advertise_refs || !data.stateless_rpc) {
    ++	if (advertise_refs || !data.stateless_rpc) {
    + 		reset_timeout(data.timeout);
    ++		if (advertise_refs)
    ++			data.no_done = 1;
    + 		head_ref_namespaced(send_ref, &data);
    + 		for_each_namespaced_ref(send_ref, &data);
    + 		advertise_shallow_grafts(1);
    +@@ upload-pack.c: void upload_pack(struct upload_pack_options *options)
    + 		for_each_namespaced_ref(check_ref, NULL);
    + 	}
    + 
    +-	if (!options->advertise_refs) {
    ++	if (!advertise_refs) {
    + 		packet_reader_init(&reader, 0, NULL, 0,
    + 				   PACKET_READ_CHOMP_NEWLINE |
    + 				   PACKET_READ_DIE_ON_ERR_PACKET);
     
    - ## t/t5705-session-id-in-capabilities.sh ##
    -@@ t/t5705-session-id-in-capabilities.sh: do
    - 			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
    - 			origin &&
    - 		grep \"key\":\"server-sid\" tr2-client-events &&
    --		grep \"key\":\"client-sid\" tr2-server-events
    -+		grep \"key\":\"client-sid\" tr2-server-events &&
    -+
    -+		if test "$PROTO" = 2
    -+		then
    -+			grep \"event\":\"region_enter\".*\"category\":\"serve\" tr2-server-events &&
    -+			grep \"event\":\"region_leave\".*\"category\":\"serve\" tr2-server-events
    -+		fi
    - 	'
    - 
    - 	test_expect_success "session IDs advertised (push v${PROTO})" '
    -@@ t/t5705-session-id-in-capabilities.sh: do
    - 			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
    - 			origin HEAD:new-branch &&
    - 		grep \"key\":\"server-sid\" tr2-client-events &&
    --		grep \"key\":\"client-sid\" tr2-server-events
    -+		grep \"key\":\"client-sid\" tr2-server-events &&
    -+
    -+		if test "$PROTO" = 2
    -+		then
    -+			! grep \"event\":\"region_enter\".*\"category\":\"serve\" tr2-server-events &&
    -+			! grep \"event\":\"region_leave\".*\"category\":\"serve\" tr2-server-events
    -+		fi
    - 	'
    - done
    + ## upload-pack.h ##
    +@@
    + #ifndef UPLOAD_PACK_H
    + #define UPLOAD_PACK_H
    + 
    +-struct upload_pack_options {
    +-	int stateless_rpc;
    +-	int advertise_refs;
    +-	unsigned int timeout;
    +-	int daemon_mode;
    +-};
    +-
    +-void upload_pack(struct upload_pack_options *options);
    ++void upload_pack(const int advertise_refs, const int stateless_rpc,
    ++		 const int timeout);
      
    + struct repository;
    + struct strvec;
 -:  ----------- >  9:  beafe9811c1 {upload,receive}-pack tests: add --advertise-refs tests
 -:  ----------- > 10:  c6870b5f18a upload-pack: document and rename --advertise-refs
 8:  9fd6138aa62 ! 11:  2d4c3d0d463 upload-pack.c: convert to new serve.c "startup" config cb
    @@ Commit message
         "is_our_ref()" is constant after startup (usually it'll never change
         for a given server's configuration, or change once).
     
    -    This requires a very light compatibly layer with the serve.c callback
    -    mechanism in the form of "upload_pack" for the v0 and v1 protocols.
    +    This requires a very light compatibility layer with the serve.c
    +    callback mechanism in the form of "upload_pack" for the v0 and v1
    +    protocols.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ upload-pack.c: enum allow_uor {
     + * upload_pack_data" below.
     + */
     +static int v1_have_startup_config;
    -+static int config_keepalive = 5;
    ++static int config_keepalive_secs = 5;
     +static enum allow_uor config_allow_uor;
     +static unsigned config_advertise_sid;
     +static const char *config_pack_objects_hook;
    @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data,
      			break;
      
     -		polltimeout = pack_data->keepalive < 0
    -+		polltimeout = config_keepalive < 0
    ++		polltimeout = config_keepalive_secs < 0
      			? -1
     -			: 1000 * pack_data->keepalive;
    -+			: 1000 * config_keepalive;
    ++			: 1000 * config_keepalive_secs;
      
      		ret = poll(pfd, pollsize, polltimeout);
      
    @@ upload-pack.c: static int send_ref(const char *refname, const struct object_id *
     -			     (data->allow_uor & ALLOW_REACHABLE_SHA1) ?
     +			     (config_allow_uor & ALLOW_REACHABLE_SHA1) ?
      				     " allow-reachable-sha1-in-want" : "",
    - 			     data->stateless_rpc ? " no-done" : "",
    + 			     data->no_done ? " no-done" : "",
      			     symref_info.buf,
     @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char *value,
      	return 0;
    @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char
     -		data->allow_ref_in_want = git_config_bool(var, value);
     -	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
     -		data->allow_sideband_all = git_config_bool(var, value);
    -+		config_keepalive = git_config_int(var, value);
    -+		if (!config_keepalive)
    -+			config_keepalive = -1;
    ++		config_keepalive_secs = git_config_int(var, value);
    ++		if (!config_keepalive_secs)
    ++			config_keepalive_secs = -1;
      	} else if (!strcmp("core.precomposeunicode", var)) {
      		precomposed_unicode = git_config_bool(var, value);
      	} else if (!strcmp("transfer.advertisesid", var)) {
    @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char
      		if (!strcmp("uploadpack.packobjectshook", var))
     -			return git_config_string(&data->pack_objects_hook, var, value);
     +			return git_config_string(&config_pack_objects_hook, var, value);
    -+	}
    + 	}
     +	return 0;
     +}
     +
    @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char
     +
     +int serve_upload_pack_startup_config(const char *var, const char *value, void *data)
     +{
    -+	int ret;
    -+	ret = upload_pack_startup_config(var, value, data);
    -+	if (ret)
    -+		return ret;
    -+	ret = upload_pack_startup_config_v2_only(var, value, data);
    -+	if (ret)
    -+		return ret;
    ++	upload_pack_startup_config(var, value, data);
    ++	upload_pack_startup_config_v2_only(var, value, data);
     +	return 0;
     +}
     +
    @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char
     +{
     +	struct upload_pack_data *data = cb_data;
     +
    -+	if (!strcmp("uploadpack.allowfilter", var)) {
    ++	if (!strcmp("uploadpack.allowfilter", var))
     +		data->allow_filter = git_config_bool(var, value);
    - 	}
      
      	if (parse_object_filter_config(var, value, data) < 0)
    -@@ upload-pack.c: void upload_pack(struct upload_pack_options *options)
    + 		return -1;
    +@@ upload-pack.c: void upload_pack(const int advertise_refs, const int stateless_rpc,
      
      	upload_pack_data_init(&data);
      
    @@ upload-pack.c: void upload_pack(struct upload_pack_options *options)
     +		git_config(upload_pack_startup_config, NULL);
      	git_config(upload_pack_config, &data);
      
    - 	data.stateless_rpc = options->stateless_rpc;
    + 	data.stateless_rpc = stateless_rpc;
     @@ upload-pack.c: static void process_args(struct packet_reader *request,
      		/* process want */
      		if (parse_want(&data->writer, arg, &data->want_obj))
 -:  ----------- > 12:  e4eb31b5b8e serve.[ch]: don't pass "struct strvec *keys" to commands
-- 
2.32.0.955.ge7c5360f7e7

