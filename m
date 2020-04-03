Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAFDC2BA15
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961B9206E9
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL1Zmqyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbgDCQIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:08:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41569 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403869AbgDCQIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 12:08:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so3700191pgm.8
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGvLkk246auosDrPRn0dYSsWQagyTgI1TevQXc0qtCw=;
        b=OL1ZmqyycZtaHi/NsQa65iX5FnYx9RfJpfhBoEGQOUHPIuRzu7IJj2MqkyDbgTaufi
         LI80hIJrFqMgnfAJX9IB1hOd0EySm8i1nvA1QRZpdVdKe+GPBDel636FLc7mZ0b5cICl
         0cJV1i4LqC3E/3QnxVJMix1TISh3Tq9TpblVNCO7YZxcU3EVj1l+3CFMJXJyUp2KGoxW
         cSEQbKiInbUoQXBN0GC+lWeth1RhqqUYPVpC43fM2ADHJDPPwdfN+eDwlOMEAuGWV5eL
         hRIvxr3sZvVECDi8syp1ywEahvEzgXDe8V4qd8wT8r3NCX38TIfY+lL8GmRe2+aI39Mr
         IWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGvLkk246auosDrPRn0dYSsWQagyTgI1TevQXc0qtCw=;
        b=jIP0VXH6QUFZZpA0eBj+UNvNYN3Uj/2DjGAxy8YCyiDSgh9WZZQK0VQMiI75WCZ4C6
         QfoeC1t45i+Cw+4S0/0i7RMkitIJ7P4/yL7YNln5AOaw5lbmBxdbg1L2AkU9i97TdG0D
         yKqnMbzR8Fk1+IUdiuM40R9HYVUYnPTqpdQMRY0IPwO0Kq5aUpeylq5fXeK3KreBt/h2
         ViEUwLs8ONqUa6UYhz0dQZjBpTDL4R9cFStPb2LC63VDxnYtn0uMPqO+9+hHjbVDXIDv
         iyCRLvL1GVbRjOAcPckZuTGm0ctozijc0wWAwxxMsnt1JSY5d8/zH3ti17R+GRlt6IJI
         QUMg==
X-Gm-Message-State: AGi0PuaV8KkNdQkI6ygJ4JPfMHmUJAkOu1sdwSowk/qedMjlJz2S1jfF
        wCC2IcsfVzGFxR1N2CLRRxA=
X-Google-Smtp-Source: APiQypKbZkUvk0M4MxIRiBrzOUPhlO/PlNAAR2zfxjL35qmOgMMy4WRFuxgy9V7vYxgRWTfsyZ7t+A==
X-Received: by 2002:aa7:85c4:: with SMTP id z4mr9250520pfn.121.1585930123970;
        Fri, 03 Apr 2020 09:08:43 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 21sm5670420pgf.41.2020.04.03.09.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:08:43 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v7 0/7] New proc-receive hook for centralized workflow
Date:   Fri,  3 Apr 2020 12:08:31 -0400
Message-Id: <20200403160838.6252-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqftdl3fss.fsf@gitster.c.googlers.com>
References: <xmqqftdl3fss.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v6

* Test breaks because of the conflict between `copy_to_sideband()` and
  `rp_error()`.  Store error messages in `errmsg` and output the errmsg
  after sideband muxer closed.

* Use test_i18ncmp instead of mark the whole test case using
  C_LOCALE_OUTPUT.

* Depends on topic `jx/atomic-push`.  One test case will fail without
  it.

## Range-diff v6...v7

1:  ed8d2c0e82 ! 1:  4259d31426 receive-pack: add new proc-receive hook
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +}
     +
     +static int read_proc_receive_result(struct packet_reader *reader,
    -+				    struct command *commands)
    ++				    struct command *commands,
    ++				    struct strbuf *errmsg)
     +{
     +	struct command *hint;
     +	struct command *cmd;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		    *p++ != ' ' ||
     +		    parse_oid_hex(p, &new_oid, &p) ||
     +		    *p++ != ' ') {
    -+			rp_error("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
    -+				 reader->line);
    ++			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
    ++				    reader->line);
     +			return -1;
     +		}
     +
     +		refname = p;
     +		status = strchr(p, ' ');
     +		if (!status) {
    -+			rp_error("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
    -+				 reader->line);
    ++			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
    ++				    reader->line);
     +			return -1;
     +		}
     +		*status++ = '\0';
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			*msg++ = '\0';
     +		}
     +		if (strlen(status) != 2) {
    -+			rp_error("protocol error: proc-receive has bad status '%s' for '%s'",
    -+				 status, reader->line);
    ++			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    ++				    status, reader->line);
     +			return -1;
     +		}
     +
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		if (!hint)
     +			hint = find_command_by_refname(commands, refname);
     +		if (!hint) {
    -+			warning("proc-receive reported status on unknown ref: %s",
    -+				refname);
    ++			strbuf_addf(errmsg, "proc-receive reported status on unknown ref: %s\n",
    ++				    refname);
     +			continue;
     +		}
     +		if (!hint->run_proc_receive) {
    -+			warning("proc-receive reported status on ref of builtin command: %s",
    -+				refname);
    ++			strbuf_addf(errmsg, "proc-receive reported status on ref of builtin command: %s\n",
    ++				    refname);
     +			continue;
     +		}
     +		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +				hint->error_string = "failed";
     +			code = 1;
     +		} else if (strcmp("ok", status)) {
    -+			rp_error("protocol error: proc-receive has bad status '%s' for '%s'",
    -+				 status, reader->line);
    ++			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    ++				    status, reader->line);
     +			return -1;
     +		}
     +	}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	const char *argv[2];
     +	struct packet_reader reader;
     +	struct strbuf cap = STRBUF_INIT;
    ++	struct strbuf errmsg = STRBUF_INIT;
     +	int pr_use_push_options = 0;
     +	int version = 0;
     +	int code;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	}
     +
     +	if (version != 1) {
    -+		rp_error("protocol error: unknown proc-receive version '%d'",
    -+			 version);
    ++		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported\n",
    ++			    version);
     +		code = -1;
     +		goto cleanup;
     +	}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	}
     +
     +	/* Read result from proc-receive */
    -+	code = read_proc_receive_result(&reader, commands);
    ++	code = read_proc_receive_result(&reader, commands, &errmsg);
     +
     +cleanup:
     +	close(proc.in);
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	if (use_sideband)
     +		finish_async(&muxer);
     +	if (finish_command(&proc)) {
    -+		rp_error("proc-receive did not exit properly");
    ++		strbuf_addstr(&errmsg, "proc-receive did not exit properly\n");
     +		code = -1;
     +	}
    ++	if (errmsg.len >0) {
    ++		char *p = errmsg.buf;
    ++
    ++		p += errmsg.len - 1;
    ++		if (*p == '\n')
    ++			*p = '\0';
    ++		rp_error("%s", errmsg.buf);
    ++		strbuf_release(&errmsg);
    ++	}
     +	sigchain_pop(SIGPIPE);
    ++
     +	return code;
     +}
     +
    @@ t/t5411-proc-receive-hook.sh: make_user_friendly_and_stable_output () {
     +		-e "s/[0-9a-f]\{7,\}/<OID>/g" \
     +		-e "s#To ../upstream.git#To <URL/of/upstream.git>#" \
     +		-e "/^error: / d"
    -+}
    -+
    -+# Asynchronous sideband may generate inconsistent output messages,
    -+# sort before comparison.
    -+test_sorted_cmp () {
    -+	if ! $GIT_TEST_CMP "$@" >/dev/null 2>&1
    -+	then
    -+		cmd=$GIT_TEST_CMP
    -+		for f in "$@"
    -+		do
    -+			sort "$f" >"$f.sorted"
    -+			cmd="$cmd \"$f.sorted\""
    -+		done
    -+		if ! eval $cmd >/dev/null 2>&1
    -+		then
    -+			$GIT_TEST_CMP "$@"
    -+		fi
    -+	fi
      }
      
      # Refs of upstream : master(B)  next(A)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	 * [new branch] HEAD -> next
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push --atomic:                       next(A)  refs/for/master/topic(A)
    -+test_expect_failure "no proc-receive hook, fail all for atomic push" '
    ++test_expect_success "no proc-receive hook, fail all for atomic push" '
     +	test_must_fail git -C workbench push --atomic origin \
     +		HEAD:next \
     +		HEAD:refs/for/master/topic >out 2>&1 &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success C_LOCALE_OUTPUT "proc-receive bad protocol: unknown version" '
    ++test_expect_success "proc-receive bad protocol: unknown version" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
    -+	remote: error: protocol error: unknown proc-receive version "2"
     +	remote: fatal: the remote end hung up unexpectedly
    -+	remote: error: proc-receive did not exit properly
    ++	remote: error: proc-receive version "2" is not supported
    ++	remote: proc-receive did not exit properly
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_i18ncmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> bad-id new-id ref ok
    -+	remote: error: protocol error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
    ++	remote: error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: error: protocol error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic xx msg
    -+	remote: error: protocol error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic bad status
    -+	remote: error: protocol error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/heads/master ok
    -+	warning: proc-receive reported status on ref of builtin command: refs/heads/master
    ++	remote: error: proc-receive reported status on ref of builtin command: refs/heads/master
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	To <URL/of/upstream.git>
     +	 <OID>..<OID> <COMMIT-B> -> master
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    -+	warning: proc-receive reported status on unknown ref: refs/for/master/topic
    ++	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (no report from proc-receive)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -o ...  :                       refs/for/master/topic
    -+test_expect_success C_LOCALE_OUTPUT "not support push options" '
    ++test_expect_success "not support push options" '
     +	test_must_fail git -C workbench push \
     +		-o issue=123 \
     +		-o reviewer=user1 \
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	fatal: the receiving end does not support push options
     +	fatal: the remote end hung up unexpectedly
     +	EOF
    -+	test_cmp expect actual &&
    ++	test_i18ncmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
2:  1aa84fdf6f = 2:  b47379a7fe refs.c: refactor to reuse ref_is_hidden()
3:  a301edb86c = 3:  461f3a4141 receive-pack: new config receive.procReceiveRefs
4:  538fa71f48 ! 4:  82e6d94b0b receive-pack: refactor report for proc-receive
    @@ builtin/receive-pack.c: static int read_proc_receive_result(struct packet_reader
     +			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
     +			hint->run_proc_receive = 0;
     +		} else {
    - 			rp_error("protocol error: proc-receive has bad status '%s' for '%s'",
    - 				 status, reader->line);
    + 			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    + 				    status, reader->line);
      			return -1;
     @@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
      	packet_buf_write(&buf, "unpack %s\n",
5:  20289547f3 ! 5:  f90bacec1d t5412: test proc-receive hook on HTTP protocol
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +		-e "/^remote: fatal: /d"
     +}
     +
    -+# Asynchronous sideband may generate inconsistent output messages,
    -+# sort before comparison.
    -+test_sorted_cmp () {
    -+	if ! $GIT_TEST_CMP "$@" >/dev/null 2>&1
    -+	then
    -+		cmd=$GIT_TEST_CMP
    -+		for f in "$@"
    -+		do
    -+			sort "$f" >"$f.sorted"
    -+			cmd="$cmd \"$f.sorted\""
    -+		done
    -+		if ! eval $cmd >/dev/null 2>&1
    -+		then
    -+			$GIT_TEST_CMP "$@"
    -+		fi
    -+	fi
    -+}
    -+
     +# Refs of upstream : master(B)  next(A)
     +# Refs of workbench: master(A)           tags/v123
     +test_expect_success "setup" '
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	 * [new branch] HEAD -> next
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push --atomic:                       next(A)  refs/for/master/topic(A)
    -+test_expect_failure "no proc-receive hook, fail all for atomic push" '
    ++test_expect_success "no proc-receive hook, fail all for atomic push" '
     +	test_must_fail git -C workbench push --atomic origin \
     +		HEAD:next \
     +		HEAD:refs/for/master/topic >out 2>&1 &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
    -+	remote: error: protocol error: unknown proc-receive version "2"
    -+	remote: error: proc-receive did not exit properly
    ++	remote: error: proc-receive version "2" is not supported
    ++	remote: proc-receive did not exit properly
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> bad-id new-id ref ok
    -+	remote: error: protocol error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
    ++	remote: error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: error: protocol error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic xx msg
    -+	remote: error: protocol error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic bad status
    -+	remote: error: protocol error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/heads/master ok
    ++	remote: error: proc-receive reported status on ref of builtin command: refs/heads/master
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	To <URL/of/upstream.git>
     +	 <OID>..<OID> <COMMIT-B> -> master
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    ++	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (no report from proc-receive)
     +	EOF
    -+	test_sorted_cmp expect actual &&
    ++	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -o ...  :                       refs/for/master/topic
    -+test_expect_success C_LOCALE_OUTPUT "not support push options" '
    ++test_expect_success "not support push options" '
     +	test_must_fail git -C workbench push \
     +		-o issue=123 \
     +		-o reviewer=user1 \
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	fatal: the receiving end does not support push options
     +	fatal: the remote end hung up unexpectedly
     +	EOF
    -+	test_cmp expect actual &&
    ++	test_i18ncmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
6:  da9106a42d = 6:  5338d358c3 doc: add documentation for the proc-receive hook

---

Jiang Xin (7):
  transport: not report a non-head push as a branch
  receive-pack: add new proc-receive hook
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  receive-pack: refactor report for proc-receive
  t5412: test proc-receive hook on HTTP protocol
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt           |  14 +
 Documentation/githooks.txt                 |  70 ++
 Makefile                                   |   1 +
 builtin/receive-pack.c                     | 312 ++++++-
 refs.c                                     |  11 +-
 refs.h                                     |   1 +
 t/helper/test-proc-receive.c               | 172 ++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t5411-proc-receive-hook.sh               | 932 ++++++++++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh | 944 +++++++++++++++++++++
 t/t5516-fetch-push.sh                      |   2 +-
 transport-helper.c                         |  64 +-
 transport.c                                |  62 +-
 14 files changed, 2521 insertions(+), 66 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

