Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56677C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D254D2075A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXHbsKPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKKLcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgKKLcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 06:32:09 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CBDC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:32:09 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x15so121004pfm.9
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k8LVBylXMA8s1YwZ9YKGzucTBkh7MD/ivfUUOuryBsM=;
        b=pXHbsKPy/627aI/RDVujEZPsxjiGOZ2rNhreNUSO+DjTYEW+9N9foWuR0vPHLmtq6b
         bYnKcY88aw5iO5ISLVH4r1TuFtIvU/f+VQ3oK/v48d2uIlc4IoTHzZniiOfllY1i8Sqy
         NryAcWcTkiDX4Jtn707lb3IAyEcJOX4be6ADtb0pChME0PCTvgzpcZqBpgWJizBFNp8b
         EWynJOyChhH4FzM5unifdFS0A4/fr9KZmFcxWq0qo4QodX2xyMvIX6pkEDCG+y/LsMGG
         eO7mMmpb2o4DO3ufis1ftMhcv2n/Ywy9vkmbnl6Sm+6gMMiz/SHAQiKjP3kUaiCHun5T
         Ogaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8LVBylXMA8s1YwZ9YKGzucTBkh7MD/ivfUUOuryBsM=;
        b=Z9zSKdo/3gb8/0oRuzfs5dLqlctmrhxQSSOrxzqP1d3LbUaGk8JmsfSspG3e32W1OG
         I7ReY/epuyHW6JfbiU98d8aTLHoqMiObv/cJ05p3VyIRy94QKL6vQj/sNvV54NvrSOrQ
         OBiijQSwOGDcwA0VikPN0tsxHLJ8LM8pSNsHRH2OQD4AE83NZIPdk4F9C7ntaKigkByG
         1FLXJjlqKHMjOWpJ9oMduR5ZC+mpK7iIyO4n4zxGU832Jhie2LBppEPG5FlqP2uv2oEg
         4931S3LsPDm9rbC6f7VdKJ5s7KK0xaaiox/Z/WjghI/TbxBdtMdea4BxwSAvQo1/3oEF
         ZiqA==
X-Gm-Message-State: AOAM532/N3DQG7pyrzFI410D41w25R9OqXwCBnpNQZkipnJVPnoeO6bJ
        YaVY8iqxtH04f0KdAguBDsArYwln5ntqJg==
X-Google-Smtp-Source: ABdhPJwXJguc/I5p3qKbOcDfJ5N3fpVu2HbQwKtcE475bawJV+wd1wc4F2P5hItn4w73WqmLuiVqog==
X-Received: by 2002:a62:fb10:0:b029:18b:823a:535f with SMTP id x16-20020a62fb100000b029018b823a535fmr22864635pfm.42.1605094329320;
        Wed, 11 Nov 2020 03:32:09 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id s19sm2137525pfe.26.2020.11.11.03.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 03:32:08 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 0/3] jx/t5411-flake-fix
Date:   Wed, 11 Nov 2020 19:31:59 +0800
Message-Id: <20201111113202.24911-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.29.0.dirty
In-Reply-To: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exchange between receive-pack and proc-receive hook did not
carefully check for errors.

## Changes since v3

1. Patch 1/3:

   Add new helper function `filter_out_user_friendly_and_stable_output`,
   and use it for 5411-0000, 5411-0001, 5411-0013 and 5411-0014.

2. Patch 2/3:

   Check PACKET_READ_EOF status from reader for broken pipe.

3. Patch 3/3:

   Add a new patch, which uses version 0 for proc-receive by default.


## Range-diff of v3...v4

1:  785b28333f ! 1:  a3bdb5a5d6 t5411: refactor make_user_friendly_and_stable_output
    @@ Metadata
     Author: Jiang Xin <worldhello.net@gmail.com>
     
      ## Commit message ##
    -    t5411: refactor make_user_friendly_and_stable_output
    +    t5411: new helper filter_out_user_friendly_and_stable_output
     
    -    Common function `make_user_friendly_and_stable_output()` can take
    -    additional arguments to format messages for special cases.
    +    New helper `filter_out_user_friendly_and_stable_output` will call
    +    common helpr function `make_user_friendly_and_stable_output` and use
    +    additional arguments to filter out messages for specific test cases.
     
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## t/t5411/common-functions.sh ##
     @@ t/t5411/common-functions.sh: create_commits_in () {
    @@ t/t5411/common-functions.sh: create_commits_in () {
      		-e "s/	/    /g" \
      		-e "s/$A/<COMMIT-A>/g" \
     @@ t/t5411/common-functions.sh: make_user_friendly_and_stable_output () {
    - 		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
    - 		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
      		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
    --		-e "/^error: / d"
    -+		-e "/^error: / d" | \
    -+	if test $# -eq 0
    -+	then
    -+		cat
    -+	else
    -+		sed ${1+"$@"}
    -+	fi
    + 		-e "/^error: / d"
      }
    ++
    ++filter_out_user_friendly_and_stable_output () {
    ++	make_user_friendly_and_stable_output |
    ++		sed -n ${1+"$@"}
    ++}
     
      ## t/t5411/test-0000-standard-git-push.sh ##
     @@ t/t5411/test-0000-standard-git-push.sh: test_expect_success "git-push --atomic ($PROTOCOL)" '
    @@ t/t5411/test-0000-standard-git-push.sh: test_expect_success "git-push --atomic (
     -			-e "/^To / { s/   */ /g; p; }" \
     -			-e "/^ ! / { s/   */ /g; p; }" \
     -			>actual &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; }" \
     +		-e "/^ ! / { p; }" \
     +		<out >actual &&
    @@ t/t5411/test-0001-standard-git-push--porcelain.sh: test_expect_success "git-push
     -			-e "/^To / { s/   */ /g; p; }" \
     -			-e "/^! / { s/   */ /g; p; }" \
     -			>actual &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "s/^# GETTEXT POISON #//" \
     +		-e "/^To / { p; }" \
     +		-e "/^! / { p; }" \
2:  d83d4519db ! 2:  4ca1c6e2bc receive-pack: gently write messages to proc-receive
    @@ Commit message
         Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## builtin/receive-pack.c ##
     @@ builtin/receive-pack.c: static int read_proc_receive_report(struct packet_reader *reader,
    - 	struct command *cmd;
    - 	struct command *hint = NULL;
    - 	struct ref_push_report *report = NULL;
    --	int new_report = 0;
    + 	int new_report = 0;
      	int code = 0;
    -+	int new_report = 0;
      	int once = 0;
     +	int response = 0;
      
      	for (;;) {
      		struct object_id old_oid, new_oid;
    -@@ builtin/receive-pack.c: static int read_proc_receive_report(struct packet_reader *reader,
    + 		const char *head;
      		const char *refname;
      		char *p;
    - 
    +-
     -		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
    -+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
    -+			if (!response) {
    -+				strbuf_addstr(errmsg, "no response from proc-receive hook");
    ++		enum packet_read_status status;
    ++
    ++		status = packet_reader_read(reader);
    ++		if (status != PACKET_READ_NORMAL) {
    ++			/* Check whether proc-receive exited abnormally */
    ++			if (status == PACKET_READ_EOF && !response) {
    ++				strbuf_addstr(errmsg, "proc-receive exited abnormally");
     +				return -1;
     +			}
      			break;
    @@ builtin/receive-pack.c: static int read_proc_receive_report(struct packet_reader
      
      		head = reader->line;
      		p = strchr(head, ' ');
    -@@ builtin/receive-pack.c: static int run_proc_receive_hook(struct command *commands,
    - 	struct strbuf cap = STRBUF_INIT;
    - 	struct strbuf errmsg = STRBUF_INIT;
    - 	int hook_use_push_options = 0;
    --	int version = 0;
    -+	int version = -1;
    - 	int code;
    - 
    - 	argv[0] = find_hook("proc-receive");
     @@ builtin/receive-pack.c: static int run_proc_receive_hook(struct command *commands,
      	if (use_push_options)
      		strbuf_addstr(&cap, " push-options");
    @@ builtin/receive-pack.c: static int run_proc_receive_hook(struct command *command
      	} else {
     -		packet_write_fmt(proc.in, "version=1\n");
     +		code = packet_write_fmt_gently(proc.in, "version=1\n");
    -+	}
    + 	}
    +-	packet_flush(proc.in);
     +	if (!code)
     +		code = packet_flush_gently(proc.in);
    + 
    +-	for (;;) {
    +-		int linelen;
    ++	if (!code)
    ++		for (;;) {
    ++			int linelen;
    ++			enum packet_read_status status;
    + 
    +-		if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
    +-			break;
    ++			status = packet_reader_read(&reader);
    ++			if (status != PACKET_READ_NORMAL) {
    ++				/* Check whether proc-receive exited abnormally */
    ++				if (status == PACKET_READ_EOF)
    ++					code = -1;
    ++				break;
    ++			}
    + 
    +-		if (reader.pktlen > 8 && starts_with(reader.line, "version=")) {
    +-			version = atoi(reader.line + 8);
    +-			linelen = strlen(reader.line);
    +-			if (linelen < reader.pktlen) {
    +-				const char *feature_list = reader.line + linelen + 1;
    +-				if (parse_feature_request(feature_list, "push-options"))
    +-					hook_use_push_options = 1;
    ++			if (reader.pktlen > 8 && starts_with(reader.line, "version=")) {
    ++				version = atoi(reader.line + 8);
    ++				linelen = strlen(reader.line);
    ++				if (linelen < reader.pktlen) {
    ++					const char *feature_list = reader.line + linelen + 1;
    ++					if (parse_feature_request(feature_list, "push-options"))
    ++						hook_use_push_options = 1;
    ++				}
    + 			}
    + 		}
    ++
     +	if (code) {
     +		strbuf_addstr(&errmsg, "fail to negotiate version with proc-receive hook");
     +		goto cleanup;
      	}
    --	packet_flush(proc.in);
      
    - 	for (;;) {
    - 		int linelen;
    -@@ builtin/receive-pack.c: static int run_proc_receive_hook(struct command *commands,
    - 		}
    - 	}
    - 
    --	if (version != 1) {
    -+	if (version == -1) {
    -+		strbuf_addstr(&errmsg, "fail to negotiate version with proc-receive hook");
    -+		code = -1;
    -+		goto cleanup;
    -+	} else if (version != 1) {
    - 		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
    - 			    version);
    - 		code = -1;
    + 	if (version != 1) {
     @@ builtin/receive-pack.c: static int run_proc_receive_hook(struct command *commands,
      	for (cmd = commands; cmd; cmd = cmd->next) {
      		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
      	test_must_fail git -C workbench push origin \
      		HEAD:refs/for/main/topic \
      		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; }" \
     +		-e "/^ ! / { p; }" \
     +		<out >actual &&
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
     +	test-tool proc-receive -v --die-write-version
     +	EOF
     +'
    -+
    + 
     +# Refs of upstream : main(A)
     +# Refs of workbench: main(A)  tags/v123
     +# git push         :                       refs/for/main/topic(A)
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; }" \
     +		-e "/^ ! / { p; }" \
     +		<out >actual &&
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
     +	test_cmp expect actual &&
     +	grep "remote: fatal: die with the --die-write-version option" out &&
     +	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
    - 
    ++
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; }" \
     +		-e "/^ ! / { p; }" \
     +		<out >actual &&
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
     +		-o reviewers=user1,user2 \
      		HEAD:refs/for/main/topic \
      		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; }" \
     +		-e "/^ ! / { p; }" \
     +		<out >actual &&
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
     +	EOF
     +	test_cmp expect actual
     +'
    - 
    --	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\"" actual &&
    ++
     +test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v --die-write-report
     +	EOF
     +'
    -+
    + 
    +-	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\"" actual &&
     +# Refs of upstream : main(A)
     +# Refs of workbench: main(A)  tags/v123
     +# git push         :                       refs/for/main/topic(A)
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; }" \
     +		-e "/^ ! / { p; }" \
     +		<out >actual &&
    @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protoc
      	git -C "$upstream" show-ref >out &&
      	make_user_friendly_and_stable_output <out >actual &&
     @@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
    - 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
    - 	remote: # proc-receive hook
    - 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
    -+	remote: error: no response from proc-receive hook
    - 	remote: # post-receive hook
    - 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    - 	To <URL/of/upstream.git>
    - 	 * [new branch] HEAD -> next
    --	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
    -+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
    + 	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
      	EOF
      	test_cmp expect actual &&
     +
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive:
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; n; p; n; p; }" \
     +		<out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive:
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; n; p; n; p; }" \
     +		<out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive:
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; n; p; n; p; }" \
     +		<out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive:
     +		-o reviewers=user1,user2 \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; n; p; n; p; }" \
     +		<out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive:
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/main/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output -n \
    ++	filter_out_user_friendly_and_stable_output \
     +		-e "/^To / { p; n; p; n; p; }" \
     +		<out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive:
      	write_script "$upstream/hooks/proc-receive" <<-EOF
      	printf >&2 "# proc-receive hook\n"
     @@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
    - 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
    - 	remote: # proc-receive hook
    - 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
    -+	remote: error: no response from proc-receive hook
    - 	remote: # post-receive hook
    - 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    - 	To <URL/of/upstream.git>
    - 	*    HEAD:refs/heads/next    [new branch]
    --	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
    -+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
      	Done
      	EOF
      	test_cmp expect actual &&
-:  ---------- > 3:  82d03e6508 receive-pack: use default version 0 for proc-receive

---

Jiang Xin (3):
  t5411: new helper filter_out_user_friendly_and_stable_output
  receive-pack: gently write messages to proc-receive
  receive-pack: use default version 0 for proc-receive

 builtin/receive-pack.c                        |  94 +++++++---
 t/helper/test-proc-receive.c                  |  54 ++++--
 t/t5411/common-functions.sh                   |   7 +-
 t/t5411/test-0000-standard-git-push.sh        |   9 +-
 .../test-0001-standard-git-push--porcelain.sh |  15 +-
 t/t5411/test-0013-bad-protocol.sh             | 138 ++++++++++++--
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 173 +++++++++++++++++-
 t/t5411/test-0026-push-options.sh             |  60 ++++++
 t/t5411/test-0027-push-options--porcelain.sh  |  62 +++++++
 9 files changed, 545 insertions(+), 67 deletions(-)

-- 
2.29.0.dirty

