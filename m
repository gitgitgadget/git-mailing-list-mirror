Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61BBC2BA18
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6492074D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goZk+NN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389748AbgDBQfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:35:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45290 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388778AbgDBQff (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:35:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id o26so2064572pgc.12
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jxb+fsMuB9cO2joOYiKa//RhnSIeKcT8efNPEq+uOk=;
        b=goZk+NN2NTIYc/9+Xh10tk14gi9I2k5I1aAquK7HqJRnHaulNIYbOjlSlCX41HtHDv
         73QuCqoGhaLcfgEMCxojSMw5iaAuXd2011Q6iM9gxoNCV9Ac5fCijB83cfVrg7JBRcYG
         EcXka4UhHEU+fRnXTBkvkuw67ASBWkMXLnBxFFRlOExhxdKIFws0onj8dpcXhqsxD/hV
         ruOhbSw2BQPg3p39GceGfLUlBMw+FWDnnAavYKu2KLjgyDLkklb8OWZMxOQEFgFmvH/U
         M4MW4uxTIvsMAr0TI++ELrsGBUcVAI24Djx3MZ1/nyiH9YfULknmz3YBQqR3PfgBVH5L
         k7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jxb+fsMuB9cO2joOYiKa//RhnSIeKcT8efNPEq+uOk=;
        b=kE52fHrhW4YpQ68T6ppwP5yK74GLblwEcrHOdcgEfi/M3VyU7ahYRENrVhrTgYnems
         kbGAzW64W775NJIwys2MKdsg1SfUxHNu+gFHR+G1z56XaRSo2eEXZTULh1rHYbPY+YAH
         DrbGiILu+LVIR9Xni4l6k2gnccscU8xsSEakif/RR10dZyC9dVJF+tdiN3m3XBwlOsDd
         cicp1s2sb1nzGQBBAbw76nn1c4WjtQ3enRZoErEcKiBHp0Dn6YYlgQmOv2Clegv+wHB+
         J8dcYiLzOKac7bB3dSuL/Nv1LL0ygc7WM9b0JRY0jr61Qi0ub1CgcgtjbLhBhTi7ILSo
         Ct6Q==
X-Gm-Message-State: AGi0Pua8fnsmPA/vUEo24eIF8Obv9ZmON0fUkWhrqTitLa0k5dh56kvR
        aK6mFkwrQPcsdthAL+eMCMA=
X-Google-Smtp-Source: APiQypKE16bF4/HlZQjjw2NahQxg24kbjU5tEsfycNl4rl/Phf/dzYkRWH/zDThVzW22noMgxz6uEg==
X-Received: by 2002:a63:2014:: with SMTP id g20mr3504879pgg.180.1585845329653;
        Thu, 02 Apr 2020 09:35:29 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 1sm4178140pjc.32.2020.04.02.09.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 09:35:28 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 0/7] New proc-receive hook for centralized workflow
Date:   Thu,  2 Apr 2020 12:35:13 -0400
Message-Id: <20200402163520.1338-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v5

+ Fixed code review issues on v5.

  * s/cannot to/cannot/

  * s/FLEX_ALLOC_MEM/FLEX_ALLOC_STR/

  * Add flag `C_LOCALE_OUTPUT` on test cases which may break
    gettext-poison test.

  * Note: `rp_errors()` in "receive-pack" is executed on the
    server side, I think leave them unmarked for i18n is better.

+ Add t5412 for "proc-receive" hook test on HTTP protocol.

+ Some test cases of t5412 will hang because of "receive-pack" die
  earlier.  Replace `die()` with `rp_error()`.


## Range-diff v5...v6

1:  a8bcc20439 = 1:  1647024dfe transport: not report a non-head push as a branch
2:  14641ec57e ! 2:  ed8d2c0e82 receive-pack: add new proc-receive hook
    @@ builtin/receive-pack.c: static void write_head_info(void)
      	packet_flush(1);
      }
      
    -+#define RUN_PROC_RECEIVE_SCHEDULE	1
    ++#define RUN_PROC_RECEIVE_SCHEDULED	1
     +#define RUN_PROC_RECEIVE_RETURNED	2
      struct command {
      	struct command *next;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		if (parse_oid_hex(reader->line, &old_oid, &p) ||
     +		    *p++ != ' ' ||
     +		    parse_oid_hex(p, &new_oid, &p) ||
    -+		    *p++ != ' ')
    -+			die("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
    -+			    reader->line);
    ++		    *p++ != ' ') {
    ++			rp_error("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
    ++				 reader->line);
    ++			return -1;
    ++		}
     +
     +		refname = p;
     +		status = strchr(p, ' ');
    -+		if (!status)
    -+			die("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
    -+			    reader->line);
    ++		if (!status) {
    ++			rp_error("protocol error: proc-receive expected 'old new ref status [msg]', got '%s'",
    ++				 reader->line);
    ++			return -1;
    ++		}
     +		*status++ = '\0';
     +		if (strlen(status) > 2 && *(status + 2) == ' ') {
     +			msg = status + 2;
     +			*msg++ = '\0';
     +		}
    -+		if (strlen(status) != 2)
    -+			die("protocol error: proc-receive has bad status '%s' for '%s'",
    -+			    status, reader->line);
    ++		if (strlen(status) != 2) {
    ++			rp_error("protocol error: proc-receive has bad status '%s' for '%s'",
    ++				 status, reader->line);
    ++			return -1;
    ++		}
     +
     +		/* first try searching at our hint, falling back to all refs */
     +		if (hint)
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +				hint->error_string = "failed";
     +			code = 1;
     +		} else if (strcmp("ok", status)) {
    -+			die("protocol error: proc-receive has bad status '%s' for '%s'",
    -+			    status, reader->line);
    ++			rp_error("protocol error: proc-receive has bad status '%s' for '%s'",
    ++				 status, reader->line);
    ++			return -1;
     +		}
     +	}
     +
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +	argv[0] = find_hook("proc-receive");
     +	if (!argv[0]) {
    -+		rp_error("cannot to find hook 'proc-receive'");
    -+		return 1;
    ++		rp_error("cannot find hook 'proc-receive'");
    ++		return -1;
     +	}
     +	argv[1] = NULL;
     +
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		}
     +	}
     +
    -+	if (version != 1)
    -+		die("protocol error: unknown proc-receive version '%d'", version);
    ++	if (version != 1) {
    ++		rp_error("protocol error: unknown proc-receive version '%d'",
    ++			 version);
    ++		code = -1;
    ++		goto cleanup;
    ++	}
     +
     +	/* Send commands */
     +	for (cmd = commands; cmd; cmd = cmd->next) {
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
     +			continue;
    -+
     +		old_hex = oid_to_hex(&cmd->old_oid);
     +		new_hex = oid_to_hex(&cmd->new_oid);
    -+
     +		packet_write_fmt(proc.in, "%s %s %s",
     +				 old_hex, new_hex, cmd->ref_name);
     +	}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +		for_each_string_list_item(item, push_options)
     +			packet_write_fmt(proc.in, "%s", item->string);
    -+
     +		packet_flush(proc.in);
     +	}
     +
     +	/* Read result from proc-receive */
     +	code = read_proc_receive_result(&reader, commands);
    ++
    ++cleanup:
     +	close(proc.in);
     +	close(proc.out);
     +	if (use_sideband)
     +		finish_async(&muxer);
    -+	if (finish_command(&proc))
    -+		die("proc-receive did not exit properly");
    -+
    ++	if (finish_command(&proc)) {
    ++		rp_error("proc-receive did not exit properly");
    ++		code = -1;
    ++	}
     +	sigchain_pop(SIGPIPE);
    -+
     +	return code;
     +}
     +
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +
     +		/* TODO: replace the fixed prefix by looking up git config variables. */
     +		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
    -+			cmd->run_proc_receive = 1;
    ++			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
     +			run_proc_receive = 1;
     +		}
     +	}
    @@ t/helper/test-proc-receive.c (new)
     +			die("protocol error: expected 'old new ref', got '%s'",
     +			    reader->line);
     +		refname = p;
    -+		FLEX_ALLOC_MEM(cmd, ref_name, refname, strlen(refname));
    ++		FLEX_ALLOC_STR(cmd, ref_name, refname);
     +		oidcpy(&cmd->old_oid, &old_oid);
     +		oidcpy(&cmd->new_oid, &new_oid);
     +
    @@ t/helper/test-tool.h: int cmd__parse_pathspec_file(int argc, const char** argv);
      int cmd__read_cache(int argc, const char **argv);
     
      ## t/t5411-proc-receive-hook.sh ##
    +@@ t/t5411-proc-receive-hook.sh: create_commits_in () {
    + # Format the output of git-push, git-show-ref and other commands to make a
    + # user-friendly and stable text.  We can easily prepare the expect text
    + # without having to worry about future changes of the commit ID and spaces
    +-# of the output.  We also replce single quotes with double quotes, because
    +-# it is boring to prepare unquoted single quotes in expect txt.
    ++# of the output.  Single quotes are replaced with double quotes, because
    ++# it is boring to prepare unquoted single quotes in expect txt.  We also
    ++# remove some locale error messages, which break test if we turn on
    ++# `GIT_TEST_GETTEXT_POISON=true` in order to test unintentional translations
    ++# on plumbing commands.
    + make_user_friendly_and_stable_output () {
    + 	sed \
    + 		-e "s/  *\$//" \
     @@ t/t5411-proc-receive-hook.sh: make_user_friendly_and_stable_output () {
    - 		-e "s/[0-9a-f]\{7,\}/<OID>/g"
    - }
    - 
    + 		-e "s/$B/<COMMIT-B>/g" \
    + 		-e "s/$TAG/<TAG-v123>/g" \
    + 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
    +-		-e "s/[0-9a-f]\{7,\}/<OID>/g"
    ++		-e "s/[0-9a-f]\{7,\}/<OID>/g" \
    ++		-e "s#To ../upstream.git#To <URL/of/upstream.git>#" \
    ++		-e "/^error: / d"
    ++}
    ++
     +# Asynchronous sideband may generate inconsistent output messages,
     +# sort before comparison.
     +test_sorted_cmp () {
    @@ t/t5411-proc-receive-hook.sh: make_user_friendly_and_stable_output () {
     +			$GIT_TEST_CMP "$@"
     +		fi
     +	fi
    -+}
    -+
    + }
    + 
      # Refs of upstream : master(B)  next(A)
      # Refs of workbench: master(A)           tags/v123
      test_expect_success "setup" '
    +-	git init --bare upstream &&
    ++	upstream=upstream.git &&
    ++	git init --bare "$upstream" &&
    + 	git init workbench &&
    + 	create_commits_in workbench A B &&
    + 	(
    +@@ t/t5411-proc-receive-hook.sh: test_expect_success "setup" '
    + 		# Try to make a stable fixed width for abbreviated commit ID,
    + 		# this fixed-width oid will be replaced with "<OID>".
    + 		git config core.abbrev 7 &&
    +-		git remote add origin ../upstream &&
    ++		git remote add origin ../$upstream &&
    + 		git update-ref refs/heads/master $A &&
    + 		git tag -m "v123" v123 $A &&
    + 		git push origin \
    +@@ t/t5411-proc-receive-hook.sh: test_expect_success "setup" '
    + 	TAG=$(git -C workbench rev-parse v123) &&
    + 
    + 	# setup pre-receive hook
    +-	cat >upstream/hooks/pre-receive <<-\EOF &&
    ++	cat >"$upstream/hooks/pre-receive" <<-\EOF &&
    + 	#!/bin/sh
    + 
    + 	echo >&2 "# pre-receive hook"
    +@@ t/t5411-proc-receive-hook.sh: test_expect_success "setup" '
    + 	EOF
    + 
    + 	# setup post-receive hook
    +-	cat >upstream/hooks/post-receive <<-\EOF &&
    ++	cat >"$upstream/hooks/post-receive" <<-\EOF &&
    + 	#!/bin/sh
    + 
    + 	echo >&2 "# post-receive hook"
    +@@ t/t5411-proc-receive-hook.sh: test_expect_success "setup" '
    + 	EOF
    + 
    + 	chmod a+x \
    +-		upstream/hooks/pre-receive \
    +-		upstream/hooks/post-receive
    ++		"$upstream/hooks/pre-receive" \
    ++		"$upstream/hooks/post-receive"
    + '
    + 
    + # Refs of upstream : master(B)  next(A)
    +@@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
    + 	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
    +-	To ../upstream
    ++	To <URL/of/upstream.git>
    + 	 + <OID>...<OID> HEAD -> master (forced update)
    + 	 - [deleted] next
    + 	 * [new tag] v123 -> v123
    +@@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
    + 	 * [new branch] HEAD -> a/b/c
    + 	EOF
    + 	test_cmp expect actual &&
    +-	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
    + 	make_user_friendly_and_stable_output <out >actual &&
    + 	cat >expect <<-EOF &&
    + 	<COMMIT-A> refs/heads/a/b/c
     @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
      	test_cmp expect actual
      '
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
     +	(
    -+		cd upstream &&
    ++		cd "$upstream" &&
     +		git update-ref -d refs/review/master/topic &&
     +		git update-ref -d refs/tags/v123 &&
     +		git update-ref -d refs/heads/a/b/c
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: error: cannot to find hook "proc-receive"
    ++	remote: error: cannot find hook "proc-receive"
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 * [new branch] HEAD -> next
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
    -+	error: failed to push some refs to "../upstream"
     +	EOF
    -+	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)             next(A)
     +# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
    -+	git -C upstream update-ref -d refs/heads/next
    ++	git -C "$upstream" update-ref -d refs/heads/next
     +'
     +
     +# Refs of upstream : master(A)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: error: cannot to find hook "proc-receive"
    -+	To ../upstream
    ++	remote: error: cannot find hook "proc-receive"
    ++	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
    -+	error: failed to push some refs to "../upstream"
     +	EOF
    -+	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (bad version)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF &&
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF &&
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
     +
     +	test-tool proc-receive -v --version 2
     +	EOF
    -+	chmod a+x upstream/hooks/proc-receive
    ++	chmod a+x "$upstream/hooks/proc-receive"
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive bad protocol: unknown version" '
    ++test_expect_success C_LOCALE_OUTPUT "proc-receive bad protocol: unknown version" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	fatal: protocol error: unknown proc-receive version "2"
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: error: protocol error: unknown proc-receive version "2"
    ++	remote: fatal: the remote end hung up unexpectedly
    ++	remote: error: proc-receive did not exit properly
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (no report)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 * [new branch] HEAD -> next
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    -+	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)             next(A)
     +# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
    -+	git -C upstream update-ref -d refs/heads/next
    ++	git -C "$upstream" update-ref -d refs/heads/next
     +
     +'
     +
     +test_expect_success "setup proc-receive hook (bad oid)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic\
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	fatal: protocol error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> bad-id new-id ref ok
    ++	remote: error: protocol error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (no status)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	fatal: protocol error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: error: protocol error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (unknown status)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	test_must_fail git -C workbench push origin \
     +			HEAD:refs/for/master/topic \
     +			>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	fatal: protocol error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic xx msg
    ++	remote: error: protocol error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (bad status)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    -+	fatal: protocol error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic bad status
    ++	remote: error: protocol error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	To <URL/of/upstream.git>
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
    -+	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (ng)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (failed)
    -+	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (ng message)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng error msg
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (error msg)
    -+	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "setup proc-receive hook (report status on builtin command)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	warning: proc-receive reported status on ref of builtin command: refs/heads/master
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 <OID>..<OID> <COMMIT-B> -> master
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    -+	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_sorted_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-B> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "cleanup" '
    -+	git -C upstream update-ref refs/heads/master $A
    ++	git -C "$upstream" update-ref refs/heads/master $A
     +'
     +
     +test_expect_success "setup proc-receive hook (ok)" '
    -+	cat >upstream/hooks/proc-receive <<-EOF
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
     +	warning: proc-receive reported status on unknown ref: refs/for/master/topic
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (no report from proc-receive)
    -+	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_sorted_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -o ...  :                       refs/for/master/topic
    -+test_expect_success "not support push options" '
    ++test_expect_success C_LOCALE_OUTPUT "not support push options" '
     +	test_must_fail git -C workbench push \
     +		-o issue=123 \
     +		-o reviewer=user1 \
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	fatal: the remote end hung up unexpectedly
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "enable push options" '
    -+	git -C upstream config receive.advertisePushOptions true
    ++	git -C "$upstream" config receive.advertisePushOptions true
     +'
     +
     +# Refs of upstream : master(A)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 * [new branch] HEAD -> next
     +	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
3:  2440a474bd = 3:  1aa84fdf6f refs.c: refactor to reuse ref_is_hidden()
4:  e041582643 ! 4:  a301edb86c receive-pack: new config receive.procReceiveRefs
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      
     -		/* TODO: replace the fixed prefix by looking up git config variables. */
     -		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
    --			cmd->run_proc_receive = 1;
    +-			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
     -			run_proc_receive = 1;
     +		for (cmd = commands; cmd; cmd = cmd->next) {
     +			if (!should_process_cmd(cmd))
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +			strbuf_setlen(&refname_full, prefix_len);
     +			strbuf_addstr(&refname_full, cmd->ref_name);
     +			if (ref_is_matched(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
    -+				cmd->run_proc_receive = 1;
    ++				cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
     +				run_proc_receive = 1;
     +			}
      		}
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "cleanup" '
      
     +test_expect_success "add two receive.procReceiveRefs settings" '
     +	(
    -+		cd upstream &&
    ++		cd "$upstream" &&
     +		git config --add receive.procReceiveRefs refs/for/ &&
     +		git config --add receive.procReceiveRefs refs/review/
     +	)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +# Refs of upstream : master(A)             next(A)
     +# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
    -+	git -C upstream update-ref -d refs/heads/next
    ++	git -C "$upstream" update-ref -d refs/heads/next
     +'
     +
     +test_expect_success "setup proc-receive hook" '
    -+	cat >upstream/hooks/proc-receive <<-EOF &&
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF &&
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
     +
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/next/topic ok" \
     +		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
    ++		-r "$ZERO_OID $A refs/for/next/topic ok" \
     +		-r "$ZERO_OID $A refs/for/master/topic ok"
     +	EOF
    -+	chmod a+x upstream/hooks/proc-receive
    ++	chmod a+x "$upstream/hooks/proc-receive"
     +'
     +
     +# Refs of upstream : master(A)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 * [new reference] HEAD -> refs/for/next/topic
     +	 * [new reference] HEAD -> refs/review/a/b/c/topic
     +	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +'
     +
     +test_expect_success "setup proc-receive hook" '
    -+	cat >upstream/hooks/proc-receive <<-EOF &&
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF &&
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +		-r "$ZERO_OID $A refs/for/next/topic ok" \
     +		-r "$ZERO_OID $A refs/for/master/topic ok"
     +	EOF
    -+	chmod a+x upstream/hooks/proc-receive
    ++	chmod a+x "$upstream/hooks/proc-receive"
     +'
     +
     +# Refs of upstream : master(A)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 * [new branch] HEAD -> bar
     +	 * [new branch] HEAD -> baz
     +	 * [new reference] HEAD -> refs/for/next/topic
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/bar
5:  439acbdb62 ! 5:  538fa71f48 receive-pack: refactor report for proc-receive
    @@ builtin/receive-pack.c: static int read_proc_receive_result(struct packet_reader
     +			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
     +			hint->run_proc_receive = 0;
     +		} else {
    - 			die("protocol error: proc-receive has bad status '%s' for '%s'",
    - 			    status, reader->line);
    - 		}
    + 			rp_error("protocol error: proc-receive has bad status '%s' for '%s'",
    + 				 status, reader->line);
    + 			return -1;
     @@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
      	packet_buf_write(&buf, "unpack %s\n",
      			 unpack_status ? unpack_status : "ok");
    @@ builtin/receive-pack.c: static void report(struct command *commands, const char
     
      ## t/t5411-proc-receive-hook.sh ##
     @@ t/t5411-proc-receive-hook.sh: test_expect_success "setup proc-receive hook" '
    - 	printf >&2 "# proc-receive hook\n"
      
      	test-tool proc-receive -v \
    --		-r "$ZERO_OID $A refs/for/next/topic ok" \
    -+		-r "$ZERO_OID $A refs/for/next/topic ok ref:refs/pull/123/head" \
      		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
    +-		-r "$ZERO_OID $A refs/for/next/topic ok" \
     -		-r "$ZERO_OID $A refs/for/master/topic ok"
    ++		-r "$ZERO_OID $A refs/for/next/topic ok ref:refs/pull/123/head" \
     +		-r "$ZERO_OID $A refs/for/master/topic ok ref:refs/pull/124/head"
      	EOF
    - 	chmod a+x upstream/hooks/proc-receive
    + 	chmod a+x "$upstream/hooks/proc-receive"
      '
     @@ t/t5411-proc-receive-hook.sh: test_expect_success "report update of all special refs" '
    - 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
      	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
      	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    --	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok ref:refs/pull/123/head
      	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
    +-	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
     -	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok ref:refs/pull/123/head
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok ref:refs/pull/124/head
      	remote: # post-receive hook
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    - 	To ../upstream
    + 	To <URL/of/upstream.git>
     -	 * [new reference] HEAD -> refs/for/next/topic
     +	 * [new reference] HEAD -> refs/pull/123/head
      	 * [new reference] HEAD -> refs/review/a/b/c/topic
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "report update of all special
     +	 * [new reference] HEAD -> refs/pull/124/head
      	EOF
      	test_cmp expect actual &&
    - 	git -C upstream show-ref >out &&
    + 	git -C "$upstream" show-ref >out &&
     @@ t/t5411-proc-receive-hook.sh: test_expect_success "setup proc-receive hook" '
      # git push         :                       bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
      test_expect_success "report mixed refs update" '
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "report mixed refs update" '
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    - 	To ../upstream
    + 	To <URL/of/upstream.git>
     +	 <OID>..<OID> <COMMIT-B> -> master
      	 * [new branch] HEAD -> bar
      	 * [new branch] HEAD -> baz
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "report mixed refs update" '
     +'
     +
     +test_expect_success "config receive.procReceiveRefs for all ref/" '
    -+	git -C upstream config --add receive.procReceiveRefs refs/
    ++	git -C "$upstream" config --add receive.procReceiveRefs refs/
     +'
     +
     +test_expect_success "setup proc-receive hook" '
    -+	cat >upstream/hooks/proc-receive <<-EOF &&
    ++	cat >"$upstream/hooks/proc-receive" <<-EOF &&
     +	#!/bin/sh
     +
     +	printf >&2 "# proc-receive hook\n"
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "report mixed refs update" '
     +		-r "$A $B refs/for/master/topic ok ref:refs/pull/123/head" \
     +		-r "$B $A refs/for/next/topic ok ref:refs/pull/124/head"
     +	EOF
    -+	chmod a+x upstream/hooks/proc-receive
    ++	chmod a+x "$upstream/hooks/proc-receive"
     +'
     +
     +# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "report mixed refs update" '
     +	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
     +	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/next/topic
    -+	To ../upstream
    ++	To <URL/of/upstream.git>
     +	 <OID>..<OID> <COMMIT-B> -> bar
     +	 - [deleted] foo
     +	 + <OID>...<OID> HEAD -> master (forced update)
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "report mixed refs update" '
     +	 * [new reference] HEAD -> refs/pull/124/head
     +	EOF
     +	test_cmp expect actual &&
    -+	git -C upstream show-ref >out &&
    ++	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-B> refs/heads/bar
-:  ---------- > 6:  20289547f3 t5412: test proc-receive hook on HTTP protocol
6:  24e5cddee0 = 7:  da9106a42d doc: add documentation for the proc-receive hook


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
 builtin/receive-pack.c                     | 300 ++++++-
 refs.c                                     |  11 +-
 refs.h                                     |   1 +
 t/helper/test-proc-receive.c               | 172 ++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t5411-proc-receive-hook.sh               | 950 ++++++++++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh | 960 +++++++++++++++++++++
 t/t5516-fetch-push.sh                      |   2 +-
 transport-helper.c                         |  64 +-
 transport.c                                |  62 +-
 14 files changed, 2543 insertions(+), 66 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

