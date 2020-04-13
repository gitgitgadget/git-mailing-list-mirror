Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68DC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D082063A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/peojhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbgDMQse (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731770AbgDMQsd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 12:48:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C63EC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so2452988pfn.5
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUa/zEKau8/tOBmELSsW361A1YWwRtnh7AV3m2/TttA=;
        b=V/peojhvO4OL2s/IhFaoQ8xLwmYhNUhppvP2k3hJQ+13h08nhqogeBdKGL5K7uzFN2
         LzQSoFvqyZNI0dxFe9s/ykJfPlVBzsWzenThLfGAkJPJGCJJnU1TzmVUoe56QVCRMgOs
         R7xm4GIv8DiGMs+qd4JQxQm0hygkZrhWpYN8N+YJncpCMtclFC20odPVhcV0FaMgJKvS
         1B9oYa8K0nXJD2IY5TLJT0a2PTFICoxA/en2dXnEl8FWv4czMlIa7XgJ4NnfqV6sVPPm
         m/07E0rzSAY3DjqscX2DHEJc5DeWJeqSFav1U9LQ6VLFTkU1pMPE5+EYTiN7QTNJqOhe
         RpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUa/zEKau8/tOBmELSsW361A1YWwRtnh7AV3m2/TttA=;
        b=UnndC6oVIMTFzFljHQJb8vP4zSWG6HCHwxlMoPI6qiVeN0wRnPOO2bvDNeRktAnbpu
         b1MMH1W9dt7c84nLSmgn+LOhIEGPTqNLKgqkz3koyXT8/lZrB/96eMsCLhmBPqinTxvT
         WoENyssOHgyABlw7lcYfIP0cMva0/pxqyFHh0CLNbHz++HuyMvxdwKlo+vLDSEWsf3Wu
         +X3LvleyjGQKz6+jyHQdEqtHma7FNrQwv9VUe3ty4Oc0e3AtLzvDVtKJUpbQzsTjjZYm
         +xpXQCzTvupzm/DJpDJWkqyrMO1rXdIrhFMPZ42/43Z4DXNgm+w86pen9bnef/65DVOB
         FLCw==
X-Gm-Message-State: AGi0PuZgw58Vojhk0GwpBHtuXZnU6eiQUSy7ptCvyBOuLuBuL/3ojaB5
        VJKO+x4nJtSTzUqORPLrmvw=
X-Google-Smtp-Source: APiQypIZpZ7jRjyPvWJX5v4kctlinzQC6e25P+SnSQDjVXXRfW4zFnsz1zJvrCch8Yk5ptI+Hkz2aw==
X-Received: by 2002:a62:5cc1:: with SMTP id q184mr18248060pfb.259.1586796511999;
        Mon, 13 Apr 2020 09:48:31 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e11sm9254885pfh.117.2020.04.13.09.48.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:48:31 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v11 0/7] New proc-receive hook for centralized workflow
Date:   Mon, 13 Apr 2020 12:48:20 -0400
Message-Id: <20200413164828.23260-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200412133022.17590-1-worldhello.net@gmail.com>
References: <20200412133022.17590-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v10

* Patch 3/7 of v11 is a squash commit of patch 2/8 and patch 6/8 of v10.

* Fixed issues discovered for code review of v10.

## Range-diff v10...v11

1:  a293077bcf ! 1:  77a731c151 transport: not report a non-head push as a branch
    @@ t/t5411-proc-receive-hook.sh (new)
     +# we also replace the URL of different protocol for the upstream repository
     +# with a fixed pattern.
     +make_user_friendly_and_stable_output () {
    -+	make_user_friendly_and_stable_output_common | sed \
    -+		-e "s#To ../upstream.git#To <URL/of/upstream.git>#"
    ++	make_user_friendly_and_stable_output_common |
    ++		sed -e "s#To ../upstream.git#To <URL/of/upstream.git>#"
     +}
     +
     +# Refs of upstream : master(B)  next(A)
    @@ t/t5411-proc-receive-hook.sh (new)
     +	TAG=$(git -C workbench rev-parse v123) &&
     +
     +	# setup pre-receive hook
    -+	cat >upstream.git/hooks/pre-receive <<-\EOF &&
    -+	#!/bin/sh
    -+
    -+	echo >&2 "# pre-receive hook"
    -+
    ++	write_script upstream.git/hooks/pre-receive <<-\EOF &&
    ++	exec >&2
    ++	echo "# pre-receive hook"
     +	while read old new ref
     +	do
    -+		echo >&2 "pre-receive< $old $new $ref"
    ++		echo "pre-receive< $old $new $ref"
     +	done
     +	EOF
     +
     +	# setup post-receive hook
    -+	cat >upstream.git/hooks/post-receive <<-\EOF &&
    -+	#!/bin/sh
    -+
    -+	echo >&2 "# post-receive hook"
    -+
    ++	write_script upstream.git/hooks/post-receive <<-\EOF &&
    ++	exec >&2
    ++	echo "# post-receive hook"
     +	while read old new ref
     +	do
    -+		echo >&2 "post-receive< $old $new $ref"
    ++		echo "post-receive< $old $new $ref"
     +	done
     +	EOF
     +
    -+	chmod a+x \
    -+		upstream.git/hooks/pre-receive \
    -+		upstream.git/hooks/post-receive &&
    -+
     +	upstream=upstream.git
     +'
     +
    @@ t/t5411/common-functions.sh (new)
     +# user-friendly and stable text.  We can easily prepare the expect text
     +# without having to worry about future changes of the commit ID and spaces
     +# of the output.  We also replce single quotes with double quotes, because
    -+# it is boring to prepare unquoted single quotes in expect txt.
    ++# it is boring to prepare unquoted single quotes in expect text.
     +make_user_friendly_and_stable_output_common () {
     +	sed \
     +		-e "s/  *\$//" \
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +# we also replace the URL of different protocol for the upstream repository
     +# with a fixed pattern.
     +make_user_friendly_and_stable_output () {
    -+	make_user_friendly_and_stable_output_common | sed \
    -+		-e "s#To http:.*/upstream.git#To <URL/of/upstream.git>#"
    ++	make_user_friendly_and_stable_output_common |
    ++		sed -e "s#To http:.*/upstream.git#To <URL/of/upstream.git>#"
     +}
     +
     +# Refs of upstream : master(B)  next(A)
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	TAG=$(git -C workbench rev-parse v123) &&
     +
     +	# setup pre-receive hook
    -+	cat >upstream.git/hooks/pre-receive <<-\EOF &&
    -+	#!/bin/sh
    -+
    -+	echo >&2 "# pre-receive hook"
    -+
    ++	write_script upstream.git/hooks/pre-receive <<-\EOF &&
    ++	exec >&2
    ++	echo "# pre-receive hook"
     +	while read old new ref
     +	do
    -+		echo >&2 "pre-receive< $old $new $ref"
    ++		echo "pre-receive< $old $new $ref"
     +	done
     +	EOF
     +
     +	# setup post-receive hook
    -+	cat >upstream.git/hooks/post-receive <<-\EOF &&
    -+	#!/bin/sh
    -+
    -+	echo >&2 "# post-receive hook"
    -+
    ++	write_script upstream.git/hooks/post-receive <<-\EOF &&
    ++	exec >&2
    ++	echo "# post-receive hook"
     +	while read old new ref
     +	do
    -+		echo >&2 "post-receive< $old $new $ref"
    ++		echo "post-receive< $old $new $ref"
     +	done
     +	EOF
     +
    -+	chmod a+x \
    -+		upstream.git/hooks/pre-receive \
    -+		upstream.git/hooks/post-receive &&
    -+
     +	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
     +	mv upstream.git "$upstream" &&
     +	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
5:  75b178fc19 = 2:  4c4f7cffff connect: export parse_feature_value()
2:  915b9ef616 ! 3:  bef4360e58 receive-pack: add new proc-receive hook
    @@ Commit message
         other routines.  Finally, the result of the execution of these commands
         will be reported to end user.
     
    +    The reporting function from "receive-pack" to "send-pack" is also
    +    extended using a backward compatible way by adding key-value pairs
    +    after an null character, like:
    +
    +        # OK, run this command successfully with optional extended-status.
    +        ok <reference>\0ref=refs/pull/123/head old-oid=...
    +
    +        # NO, I reject it.
    +        ng <reference> <error message>
    +
    +    Parsing the extended status of the report lines for "send-pack" is not
    +    implemented in this commit, so we can make a compatible test on old
    +    version of a Git client.
    +
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
    @@ builtin/receive-pack.c: static void write_head_info(void)
      struct command {
      	struct command *next;
      	const char *error_string;
    ++	const char *extended_status;
      	unsigned int skip_update:1,
     -		     did_not_exist:1;
     +		     did_not_exist:1,
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +{
     +	struct command *cmd;
     +	struct command *hint = NULL;
    ++	struct strbuf extended_status = STRBUF_INIT;
     +	int code = 0;
     +
     +	for (;;) {
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		const char *p;
     +		char *status;
     +		char *msg = NULL;
    ++		int len;
     +
     +		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     +			break;
    ++		len = strlen(reader->line);
     +		if (parse_oid_hex(reader->line, &old_oid, &p) ||
     +		    *p++ != ' ' ||
     +		    parse_oid_hex(p, &new_oid, &p) ||
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			continue;
     +		}
     +		*status++ = '\0';
    -+		if (strlen(status) > 2 && *(status + 2) == ' ') {
    -+			msg = status + 2;
    ++		msg = strchr(status, ' ');
    ++		if (msg)
     +			*msg++ = '\0';
    -+		}
    -+		if (strlen(status) != 2) {
    -+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    -+				    status, reader->line);
    -+			code = -1;
    -+			continue;
    -+		}
     +
     +		/* first try searching at our hint, falling back to all refs */
     +		if (hint)
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			continue;
     +		}
     +		if (!hint->run_proc_receive) {
    -+			strbuf_addf(errmsg, "proc-receive reported status on ref of builtin command: %s\n",
    ++			strbuf_addf(errmsg, "proc-receive reported status on unexpected ref: %s\n",
     +				    refname);
     +			continue;
     +		}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			else
     +				hint->error_string = "failed";
     +			code = -1;
    ++		} else if (!strcmp("ft", status)) {
    ++			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
    ++			hint->run_proc_receive = 0;
     +		} else if (strcmp("ok", status)) {
    -+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    -+				    status, reader->line);
    ++			strbuf_addf(errmsg, "proc-receive reported bad status '%s' on ref '%s'\n",
    ++				    status, refname);
     +			code = -1;
     +			/* Skip marking it as RUN_PROC_RECEIVE_RETURNED */
     +			continue;
     +		}
    -+		oidcpy(&hint->old_oid, &old_oid);
    -+		oidcpy(&hint->new_oid, &new_oid);
    -+		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
    ++		if (reader->pktlen > len)
    ++			strbuf_addstr(&extended_status, (char *)reader->line + len + 1);
    ++		if (oidcmp(&hint->old_oid, &old_oid)) {
    ++			oidcpy(&hint->old_oid, &old_oid);
    ++			strbuf_addf(&extended_status, "%sold-oid=%s",
    ++				    extended_status.len > 0 ? " ": "",
    ++				    oid_to_hex(&old_oid));
    ++		}
    ++		if (oidcmp(&hint->new_oid, &new_oid)) {
    ++			oidcpy(&hint->new_oid, &new_oid);
    ++			strbuf_addf(&extended_status, "%snew-oid=%s",
    ++				    extended_status.len > 0 ? " ": "",
    ++				    oid_to_hex(&new_oid));
    ++		}
    ++		if (extended_status.len > 0)
    ++			hint->extended_status = strbuf_detach(&extended_status, NULL);
    ++		if (hint->run_proc_receive)
    ++			hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
     +	}
     +
     +	for (cmd = commands; cmd; cmd = cmd->next)
     +		if (cmd->run_proc_receive && !cmd->error_string &&
     +		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
    -+		    cmd->error_string = "no report from proc-receive";
    ++		    cmd->error_string = "proc-receive failed to report status";
     +		    code = -1;
     +		}
     +
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      
      	reject_updates_to_hidden(commands);
      
    -+	/* Try to find commands that have special prefix in their reference names,
    ++	/*
    ++	 * Try to find commands that have special prefix in their reference names,
     +	 * and mark them to run an external "proc-receive" hook later.
     +	 */
     +	for (cmd = commands; cmd; cmd = cmd->next) {
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	if (use_atomic)
      		execute_commands_atomic(commands, si);
      	else
    +@@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
    + 	packet_buf_write(&buf, "unpack %s\n",
    + 			 unpack_status ? unpack_status : "ok");
    + 	for (cmd = commands; cmd; cmd = cmd->next) {
    +-		if (!cmd->error_string)
    +-			packet_buf_write(&buf, "ok %s\n",
    +-					 cmd->ref_name);
    +-		else
    +-			packet_buf_write(&buf, "ng %s %s\n",
    +-					 cmd->ref_name, cmd->error_string);
    ++		if (!cmd->error_string) {
    ++			if (cmd->extended_status)
    ++				packet_buf_write(&buf, "ok %s%c%s\n",
    ++						 cmd->ref_name, '\0',
    ++						 cmd->extended_status);
    ++			else
    ++				packet_buf_write(&buf, "ok %s\n",
    ++						 cmd->ref_name);
    ++		} else {
    ++			if (cmd->extended_status)
    ++				packet_buf_write(&buf, "ng %s %s%c%s\n",
    ++						 cmd->ref_name, cmd->error_string,
    ++						 '\0', cmd->extended_status);
    ++			else
    ++				packet_buf_write(&buf, "ng %s %s\n",
    ++						 cmd->ref_name, cmd->error_string);
    ++		}
    + 	}
    + 	packet_buf_flush(&buf);
    + 
     
      ## t/helper/test-proc-receive.c (new) ##
     @@
    @@ t/helper/test-proc-receive.c (new)
     +	}
     +
     +	if (returns.nr)
    -+		for_each_string_list_item(item, &returns)
    -+			packet_write_fmt(1, "%s\n", item->string);
    ++		for_each_string_list_item(item, &returns) {
    ++			char *p;
    ++
    ++			p = strstr(item->string, "\\0");
    ++			if (p) {
    ++				*p = '\0';
    ++				p += 2;
    ++				packet_write_fmt(1, "%s%c%s\n", item->string, '\0', p);
    ++			} else {
    ++				packet_write_fmt(1, "%s\n", item->string);
    ++			}
    ++		}
     +	packet_flush(1);
     +	sigchain_pop(SIGPIPE);
     +
    @@ t/t5411/common-functions.sh: create_commits_in () {
      # user-friendly and stable text.  We can easily prepare the expect text
      # without having to worry about future changes of the commit ID and spaces
     -# of the output.  We also replce single quotes with double quotes, because
    --# it is boring to prepare unquoted single quotes in expect txt.
    +-# it is boring to prepare unquoted single quotes in expect text.
     +# of the output.  Single quotes are replaced with double quotes, because
    -+# it is boring to prepare unquoted single quotes in expect txt.  We also
    ++# it is boring to prepare unquoted single quotes in expect text.  We also
     +# remove some locale error messages, which break test if we turn on
     +# `GIT_TEST_GETTEXT_POISON=true` in order to test unintentional translations
     +# on plumbing commands.
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       next(A)  refs/for/master/topic(A)
    -+test_expect_success "no proc-receive hook, fail to push special ref" '
    ++test_expect_success "proc-receive: no hook, fail to push special ref" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:next \
     +		HEAD:refs/for/master/topic \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
    -+test_expect_success "no proc-receive hook, fail all for atomic push" '
    ++test_expect_success "proc-receive: no hook, fail all for atomic push" '
     +	test_must_fail git -C workbench push --atomic origin \
     +		$B:master \
     +		HEAD:next \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (bad version)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF &&
    -+	#!/bin/sh
    -+
    ++test_expect_success "setup proc-receive hook (unknown version)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v --version 2
     +	EOF
    -+	chmod a+x "$upstream/hooks/proc-receive"
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive bad protocol: unknown version" '
    ++test_expect_success "proc-receive: bad protocol (unknown version)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (no report)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v
     +	EOF
     +'
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       next(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive bad protocol: no report" '
    ++test_expect_success "proc-receive: bad protocol (no report)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/heads/next \
     +		HEAD:refs/for/master/topic >out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	To <URL/of/upstream.git>
     +	 * [new branch] HEAD -> next
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (bad oid)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
     +		-r "bad-id new-id ref ok"
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive bad protocol: bad oid" '
    ++test_expect_success "proc-receive: bad protocol (bad oid)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic\
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive> bad-id new-id ref ok
     +	remote: error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
     +	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (no status)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/for/master/topic"
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive bad protocol: no status" '
    ++test_expect_success "proc-receive: bad protocol (no status)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (unknown status)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/for/master/topic xx msg"
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive bad protocol: unknown status" '
    ++test_expect_success "proc-receive: bad protocol (unknown status)" '
     +	test_must_fail git -C workbench push origin \
     +			HEAD:refs/for/master/topic \
     +			>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic xx msg
    -+	remote: error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: error: proc-receive reported bad status "xx" on ref "refs/for/master/topic"
     +	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    -+	EOF
    -+	test_cmp expect actual &&
    -+	git -C "$upstream" show-ref >out &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	<COMMIT-A> refs/heads/master
    -+	EOF
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success "setup proc-receive hook (bad status)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    -+	printf >&2 "# proc-receive hook\n"
    -+
    -+	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/master/topic bad status"
    -+	EOF
    -+'
    -+
    -+# Refs of upstream : master(A)
    -+# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive bad protocol: bad status" '
    -+	test_must_fail git -C workbench push origin \
    -+		HEAD:refs/for/master/topic \
    -+		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic bad status
    -+	remote: error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    -+	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (ng)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/for/master/topic ng"
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: fail to update (no message)" '
    ++test_expect_success "proc-receive: fail to update (ng)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (ng message)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/for/master/topic ng error msg"
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: fail to update (has message)" '
    ++test_expect_success "proc-receive: fail to update (ng message)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (report status on builtin command)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++test_expect_success "setup proc-receive hook (unexpected ref)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/heads/master ok"
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         : (B)                   refs/for/master/topic
    -+test_expect_success "proc-receive: warning on report for builtin command" '
    ++test_expect_success "proc-receive: report on unexpected ref" '
     +	test_must_fail git -C workbench push origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/for/master/topic \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/heads/master ok
    -+	remote: error: proc-receive reported status on ref of builtin command: refs/heads/master
    ++	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	To <URL/of/upstream.git>
     +	 <OID-A>..<OID-B> <COMMIT-B> -> master
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    ++# Refs of upstream : master(B)
    ++# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
     +	git -C "$upstream" update-ref refs/heads/master $A
     +'
     +
     +test_expect_success "setup proc-receive hook (ok)" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/for/master/topic ok"
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/a/b/c/my/topic
    -+test_expect_success "proc-receive: no report from proc-receive" '
    ++test_expect_success "proc-receive: failed to report status" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/a/b/c/my/topic \
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
     +	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
     +	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (no report from proc-receive)
    ++	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -o ...  :                       refs/for/master/topic
    -+test_expect_success "not support push options" '
    ++test_expect_success "proc-receive: not support push options" '
     +	test_must_fail git -C workbench push \
     +		-o issue=123 \
     +		-o reviewer=user1 \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -o ...  :                       next(A)  refs/for/master/topic
    -+test_expect_success "push with options" '
    ++test_expect_success "proc-receive: push with options" '
     +	git -C workbench push \
     +		--atomic \
     +		-o issue=123 \
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup" '
    ++	git -C "$upstream" update-ref -d refs/heads/next
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (ft)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "$ZERO_OID $B refs/for/master/topic ft"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(B)
    ++test_expect_success "proc-receive: fall throught, let receive-pack to execute" '
    ++	git -C workbench push origin \
    ++		$B:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-B> refs/for/master/topic ft
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] <COMMIT-B> -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-B> refs/for/master/topic
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(A)             refs/for/master/topic(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup" '
    ++	git -C "$upstream" update-ref -d refs/for/master/topic
    ++'
    ++
    ++test_expect_success "setup proc-receive hook (with extended status)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "$ZERO_OID $A refs/for/a/b/c/topic ok" \
    ++		-r "$ZERO_OID $A refs/for/next/topic ok\0ref=refs/pull/123/head" \
    ++		-r "$B $A refs/for/master/topic ok\0ref=refs/pull/124/head forced-update"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report with extended status" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/next/topic \
    ++		HEAD:refs/for/a/b/c/topic \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic ok
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/123/head
    ++	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok\0ref=refs/pull/124/head forced-update
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    ++	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 * [new reference] HEAD -> refs/for/next/topic
    ++	 * [new reference] HEAD -> refs/for/a/b/c/topic
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "setup proc-receive hook" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "$ZERO_OID $A refs/for/next/topic ok" \
    ++		-r "$A $B refs/for/master/topic ok"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report update of mixed refs" '
    ++	git -C workbench push origin \
    ++		$B:refs/heads/master \
    ++		HEAD:refs/heads/bar \
    ++		HEAD:refs/heads/baz \
    ++		HEAD:refs/for/next/topic \
    ++		HEAD:refs/heads/foo \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    ++	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok
    ++	remote: # post-receive hook
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
    ++	To <URL/of/upstream.git>
    ++	 <OID-A>..<OID-B> <COMMIT-B> -> master
    ++	 * [new branch] HEAD -> bar
    ++	 * [new branch] HEAD -> baz
    ++	 * [new reference] HEAD -> refs/for/next/topic
    ++	 * [new branch] HEAD -> foo
    ++	 * [new reference] HEAD -> refs/for/master/topic
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/bar
    ++	<COMMIT-A> refs/heads/baz
    ++	<COMMIT-A> refs/heads/foo
    ++	<COMMIT-B> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
3:  16257616ec < -:  ---------- refs.c: refactor to reuse ref_is_hidden()
7:  d1677b61d1 ! 4:  a4a1cc1d14 send-pack: extension for client-side status report
    @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref
      	}
     
      ## t/t5411/common-test-cases.sh ##
    -@@ t/t5411/common-test-cases.sh: test_expect_success "report update of all special refs" '
    - 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    +@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report with extended status" '
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
      	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
      	To <URL/of/upstream.git>
     -	 * [new reference] HEAD -> refs/for/next/topic
     +	 * [new reference] HEAD -> refs/pull/123/head
    - 	 * [new reference] HEAD -> refs/review/a/b/c/topic
    + 	 * [new reference] HEAD -> refs/for/a/b/c/topic
     -	 * [new reference] HEAD -> refs/for/master/topic
     +	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
      	EOF
      	test_cmp expect actual &&
      	git -C "$upstream" show-ref >out &&
    -@@ t/t5411/common-test-cases.sh: test_expect_success "report mixed refs update" '
    +@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update of mixed refs" '
      	 * [new branch] HEAD -> baz
      	 * [new reference] HEAD -> refs/for/next/topic
      	 * [new branch] HEAD -> foo
    @@ t/t5411/common-test-cases.sh: test_expect_success "report mixed refs update" '
      	EOF
      	test_cmp expect actual &&
      	git -C "$upstream" show-ref >out &&
    -@@ t/t5411/common-test-cases.sh: test_expect_success "report test: fallthrough" '
    - 	 <OID-A>..<OID-B> <COMMIT-B> -> bar
    - 	 - [deleted] foo
    - 	 + <OID-B>...<OID-A> HEAD -> master (forced update)
    --	 * [new reference] HEAD -> refs/for/master/topic
    --	 * [new reference] HEAD -> refs/for/next/topic
    -+	 <OID-A>..<OID-B> HEAD -> refs/pull/123/head
    -+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
    - 	EOF
    - 	test_cmp expect actual &&
    - 	git -C "$upstream" show-ref >out &&
     
      ## transport-helper.c ##
     @@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
-:  ---------- > 5:  4e3c383c12 refs.c: refactor to reuse ref_is_hidden()
4:  cd49b57c17 ! 6:  dd83569c4e receive-pack: new config receive.procReceiveRefs
    @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
     +		len = strlen(prefix);
     +		while (len && prefix[len - 1] == '/')
     +			prefix[--len] = '\0';
    -+		string_list_insert(&proc_receive_refs, prefix);
    ++		string_list_append(&proc_receive_refs, prefix);
     +		return 0;
     +	}
     +
    @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
      }
      
     @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    - 	/* Try to find commands that have special prefix in their reference names,
    + 	 * Try to find commands that have special prefix in their reference names,
      	 * and mark them to run an external "proc-receive" hook later.
      	 */
     -	for (cmd = commands; cmd; cmd = cmd->next) {
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +	if (proc_receive_refs.nr > 0) {
     +		struct strbuf refname_full = STRBUF_INIT;
     +		size_t prefix_len;
    -+
    -+		strbuf_addstr(&refname_full, get_git_namespace());
    -+		prefix_len = refname_full.len;
      
     -		/* TODO: replace the fixed prefix by looking up git config variables. */
     -		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
     -			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
     -			run_proc_receive = 1;
    ++		strbuf_addstr(&refname_full, get_git_namespace());
    ++		prefix_len = refname_full.len;
    ++
     +		for (cmd = commands; cmd; cmd = cmd->next) {
     +			if (!should_process_cmd(cmd))
     +				continue;
     +
     +			strbuf_setlen(&refname_full, prefix_len);
     +			strbuf_addstr(&refname_full, cmd->ref_name);
    -+			if (ref_is_matched(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
    ++			if (ref_matches(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
     +				cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
     +				run_proc_receive = 1;
     +			}
    @@ t/t5411/common-test-cases.sh: test_expect_success "cleanup" '
      # Refs of upstream : master(A)
      # Refs of workbench: master(A)  tags/v123
      # git push         :                       next(A)  refs/for/master/topic(A)
    -@@ t/t5411/common-test-cases.sh: test_expect_success "push with options" '
    - 	EOF
    - 	test_cmp expect actual
    - '
    -+
    -+# Refs of upstream : master(A)             next(A)
    -+# Refs of workbench: master(A)  tags/v123
    -+test_expect_success "cleanup" '
    -+	git -C "$upstream" update-ref -d refs/heads/next
    -+'
    -+
    -+test_expect_success "setup proc-receive hook" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF &&
    -+	#!/bin/sh
    -+
    -+	printf >&2 "# proc-receive hook\n"
    -+
    -+	test-tool proc-receive -v \
    +@@ t/t5411/common-test-cases.sh: test_expect_success "setup proc-receive hook (with extended status)" '
    + 	write_script "$upstream/hooks/proc-receive" <<-EOF
    + 	printf >&2 "# proc-receive hook\n"
    + 	test-tool proc-receive -v \
    +-		-r "$ZERO_OID $A refs/for/a/b/c/topic ok" \
     +		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
    -+		-r "$ZERO_OID $A refs/for/next/topic ok" \
    -+		-r "$B $A refs/for/master/topic ok"
    -+	EOF
    -+	chmod a+x "$upstream/hooks/proc-receive"
    -+'
    -+
    -+# Refs of upstream : master(A)
    -+# Refs of workbench: master(A)  tags/v123
    + 		-r "$ZERO_OID $A refs/for/next/topic ok\0ref=refs/pull/123/head" \
    + 		-r "$B $A refs/for/master/topic ok\0ref=refs/pull/124/head forced-update"
    + 	EOF
    +@@ t/t5411/common-test-cases.sh: test_expect_success "setup proc-receive hook (with extended status)" '
    + 
    + # Refs of upstream : master(A)
    + # Refs of workbench: master(A)  tags/v123
    +-# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
     +# git push         :                       refs/for/next/topic(A)  refs/review/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "report update of all special refs" '
    -+	git -C workbench push origin \
    -+		HEAD:refs/for/next/topic \
    + test_expect_success "proc-receive: report with extended status" '
    + 	git -C workbench push origin \
    + 		HEAD:refs/for/next/topic \
    +-		HEAD:refs/for/a/b/c/topic \
     +		HEAD:refs/review/a/b/c/topic \
    -+		HEAD:refs/for/master/topic \
    -+		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    + 		HEAD:refs/for/master/topic \
    + 		>out 2>&1 &&
    + 	make_user_friendly_and_stable_output <out >actual &&
    + 	cat >expect <<-EOF &&
    + 	remote: # pre-receive hook
    + 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    +-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    + 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	remote: # proc-receive hook
    + 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    +-	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    +-	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic ok
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    -+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok
    -+	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    + 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/123/head
    + 	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok\0ref=refs/pull/124/head forced-update
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    +-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    -+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
    -+	To <URL/of/upstream.git>
    -+	 * [new reference] HEAD -> refs/for/next/topic
    + 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    + 	 * [new reference] HEAD -> refs/pull/123/head
    +-	 * [new reference] HEAD -> refs/for/a/b/c/topic
     +	 * [new reference] HEAD -> refs/review/a/b/c/topic
    -+	 * [new reference] HEAD -> refs/for/master/topic
    -+	EOF
    -+	test_cmp expect actual &&
    -+	git -C "$upstream" show-ref >out &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	<COMMIT-A> refs/heads/master
    -+	EOF
    -+	test_cmp expect actual
    + 	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
    + 	EOF
    + 	test_cmp expect actual &&
    +@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update of mixed refs" '
    + 	EOF
    + 	test_cmp expect actual
    + '
    ++
    ++test_expect_success "config add receive.procReceiveRefs = refs" '
    ++	git -C "$upstream" config --add receive.procReceiveRefs refs
     +'
     +
     +test_expect_success "setup proc-receive hook" '
    -+	cat >"$upstream/hooks/proc-receive" <<-EOF &&
    -+	#!/bin/sh
    -+
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
    -+
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/next/topic ok" \
    -+		-r "$A $B refs/for/master/topic ok"
    ++		-r "$B $A refs/heads/master ft" \
    ++		-r "$A $ZERO_OID refs/heads/foo ft" \
    ++		-r "$A $B refs/heads/bar ft" \
    ++		-r "$A $B refs/for/master/topic ok\0ref=refs/pull/123/head" \
    ++		-r "$B $A refs/for/next/topic ok\0ref=refs/pull/124/head forced-update"
     +	EOF
    -+	chmod a+x "$upstream/hooks/proc-receive"
     +'
     +
    -+# Refs of upstream : master(A)
    ++# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
     +# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
    -+test_expect_success "report mixed refs update" '
    -+	git -C workbench push origin \
    -+		HEAD:refs/heads/bar \
    -+		HEAD:refs/heads/baz \
    -+		HEAD:refs/for/next/topic \
    -+		HEAD:refs/heads/foo \
    ++# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
    ++test_expect_success "proc-receive: process all refs" '
    ++	git -C workbench push -f origin \
    ++		HEAD:refs/heads/master \
    ++		:refs/heads/foo \
    ++		$B:refs/heads/bar \
     +		HEAD:refs/for/master/topic \
    ++		HEAD:refs/for/next/topic \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
    ++	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
    ++	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
    ++	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
    ++	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    -+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/heads/master ft
    ++	remote: proc-receive> <COMMIT-A> <ZERO-OID> refs/heads/foo ft
    ++	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/heads/bar ft
    ++	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok\0ref=refs/pull/123/head
    ++	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/124/head forced-update
     +	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
    ++	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
    ++	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
    ++	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/next/topic
     +	To <URL/of/upstream.git>
    -+	 * [new branch] HEAD -> bar
    -+	 * [new branch] HEAD -> baz
    -+	 * [new reference] HEAD -> refs/for/next/topic
    -+	 * [new branch] HEAD -> foo
    -+	 * [new reference] HEAD -> refs/for/master/topic
    ++	 <OID-A>..<OID-B> <COMMIT-B> -> bar
    ++	 - [deleted] foo
    ++	 + <OID-B>...<OID-A> HEAD -> master (forced update)
    ++	 <OID-A>..<OID-B> HEAD -> refs/pull/123/head
    ++	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	<COMMIT-A> refs/heads/bar
    ++	<COMMIT-B> refs/heads/bar
     +	<COMMIT-A> refs/heads/baz
    -+	<COMMIT-A> refs/heads/foo
     +	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
6:  860860536e < -:  ---------- receive-pack: extension for server-side report
8:  41159c2ef2 = 7:  2d04f495a3 doc: add documentation for the proc-receive hook

---

Jiang Xin (7):
  transport: not report a non-head push as a branch
  connect: export parse_feature_value()
  receive-pack: add new proc-receive hook
  send-pack: extension for client-side status report
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt           |  14 +
 Documentation/githooks.txt                 |  58 ++
 Makefile                                   |   1 +
 builtin/receive-pack.c                     | 328 ++++++++-
 connect.c                                  |   3 +-
 connect.h                                  |   1 +
 refs.c                                     |  13 +-
 refs.h                                     |   1 +
 remote.c                                   |  28 +
 remote.h                                   |   3 +
 send-pack.c                                |  13 +-
 t/helper/test-proc-receive.c               | 178 +++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t5411-proc-receive-hook.sh               |  67 ++
 t/t5411/common-functions.sh                |  54 ++
 t/t5411/common-test-cases.sh               | 794 +++++++++++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh |  78 ++
 t/t5516-fetch-push.sh                      |   2 +-
 transport-helper.c                         |  66 +-
 transport.c                                |  42 +-
 21 files changed, 1691 insertions(+), 55 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/common-test-cases.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

