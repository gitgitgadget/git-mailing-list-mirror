Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F98BC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217320776
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvgLHTDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgC3Q6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:58:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41487 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgC3Q6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:58:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id a24so2044896pfc.8
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugixjhVyLULNF6kVhX1L6OSrMZx5T9of4CFRn1xq5sM=;
        b=EvgLHTDA3INEALbkrCzkihzaQQWrIOz93YUP6t2SB8qMGBiSq7wQ36zukANbWV+YuX
         MYx8yc8ZodGTdtARyrn5L4zQW01HdtMJ2tT7ZlIECE3YxhvwWaZxVHwWI3ByNnoTyVQR
         DA3aQIlj8Bmtxkk5MQo3C9WP6HdkFi+OJe0GhtZRXMllYGpGU2YQ9NOGDvMDQYr7SpGK
         I6KKHJJvALTKVbEvi4gXUwJKQcpBitq07gxJA70I/zfyYzMNRH9PBGjWXihOKXakhK5I
         5Vd1D2Clnz+C6PImjMWYYAD99+LxgU4cEtipeh4asli+bALt6BygFDpXFn6cMxei1o4z
         qfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugixjhVyLULNF6kVhX1L6OSrMZx5T9of4CFRn1xq5sM=;
        b=ldCPxtGWPfnb+iDw26NgM5WaejAK0ecZCOqqcApFc7Pv/blzYftLcqAnAwU8NLLwDj
         oxKjf3caxX6MtcWgoBn0M6hqU0xqlomF32R9y3w7F4J+c9zmyknu/cmwHzJL2sjQu7u+
         cEg3nxM9nreuI6bgLzLOersAv3ADLkwSlNWoj2QipiKjsUTiG5Jpt7/kQBiNrnLu7TJ0
         SOZqvwMthH/Ll7Bzq9utHX1MnYWIi6FdeV/WoyUcSYgneGlTtiTD+QNga0Ub2BT+1H9r
         Lr9WCw61PSvqKneHR1v/+rfpMjb8EKGy1CTlRuB0BQw+cmGHKUFo++CMnAmvtkr8KO5I
         V5eA==
X-Gm-Message-State: AGi0PubozjLXMH5Q6wzPadu2ewakF4Ioc7D24mh23wF9ayZdlDOpbJlZ
        CdAUnNDFzD2nS6OOP1z1bRo=
X-Google-Smtp-Source: APiQypLMBLYg91Hsmsmgqinr855gvZAPb/wuKGOBQxynv+jONrcCbOBt6sajR8HuPLgwyfcTjzCklg==
X-Received: by 2002:a62:1d1:: with SMTP id 200mr222630pfb.8.1585587482971;
        Mon, 30 Mar 2020 09:58:02 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a24sm10589604pfl.115.2020.03.30.09.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 09:58:02 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 0/6] New proc-receive hook for centralized workflow
Date:   Mon, 30 Mar 2020 12:57:48 -0400
Message-Id: <20200330165754.19195-1-worldhello.net@gmail.com>
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

## Changes since v4

* Fixed code review issues.
* Reimplement `read_proc_receive_result()` of patch 2/6.
* Add new parameter for function `print_ref_status()` of patch 5/6.
* Documentation in patch 6/6.


## Range-diff v4...v5

1:  7c08735833 ! 1:  a8bcc20439 transport: not report a non-head push as a branch
    @@ t/t5411-proc-receive-hook.sh (new)
     +#
     +#     create_commits_in <repo> A B C
     +#
    -+# NOTE: Avoid calling this function from a subshell since variable
    ++# NOTE: Never calling this function from a subshell since variable
     +# assignments will disappear when subshell exits.
     +create_commits_in () {
     +	repo="$1" &&
    -+	if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)
    ++	if ! parent=$(git -C "$repo" rev-parse HEAD^{})
     +	then
     +		parent=
     +	fi &&
    @@ t/t5411-proc-receive-hook.sh (new)
     +	git -C "$repo" update-ref refs/heads/master $oid
     +}
     +
    -+format_git_output () {
    ++# Format the output of git-push, git-show-ref and other commands to make a
    ++# user-friendly and stable text.  We can easily prepare the expect text
    ++# without having to worry about future changes of the commit ID and spaces
    ++# of the output.  We also replce single quotes with double quotes, because
    ++# it is boring to prepare unquoted single quotes in expect txt.
    ++make_user_friendly_and_stable_output () {
     +	sed \
    -+		-e "s/  *\$//g" \
    ++		-e "s/  *\$//" \
    ++		-e "s/   */ /g" \
    ++		-e "s/'/\"/g" \
     +		-e "s/$A/<COMMIT-A>/g" \
     +		-e "s/$B/<COMMIT-B>/g" \
    -+		-e "s/$TAG/<COMMIT-T>/g" \
    ++		-e "s/$TAG/<TAG-v123>/g" \
     +		-e "s/$ZERO_OID/<ZERO-OID>/g" \
    -+		-e "s/'/\"/g"
    ++		-e "s/[0-9a-f]\{7,\}/<OID>/g"
     +}
     +
    ++# Refs of upstream : master(B)  next(A)
    ++# Refs of workbench: master(A)           tags/v123
     +test_expect_success "setup" '
     +	git init --bare upstream &&
     +	git init workbench &&
     +	create_commits_in workbench A B &&
     +	(
     +		cd workbench &&
    -+		git remote add origin ../upstream &&
    ++		# Try to make a stable fixed width for abbreviated commit ID,
    ++		# this fixed-width oid will be replaced with "<OID>".
     +		git config core.abbrev 7 &&
    ++		git remote add origin ../upstream &&
     +		git update-ref refs/heads/master $A &&
    -+		git tag -m "v1.0.0" v1.0.0 $A &&
    ++		git tag -m "v123" v123 $A &&
     +		git push origin \
     +			$B:refs/heads/master \
     +			$A:refs/heads/next
     +	) &&
    -+	TAG=$(cd workbench; git rev-parse v1.0.0) &&
    ++	TAG=$(git -C workbench rev-parse v123) &&
     +
     +	# setup pre-receive hook
    -+	cat >upstream/hooks/pre-receive <<-EOF &&
    ++	cat >upstream/hooks/pre-receive <<-\EOF &&
     +	#!/bin/sh
     +
    -+	printf >&2 "# pre-receive hook\n"
    ++	echo >&2 "# pre-receive hook"
     +
     +	while read old new ref
     +	do
    -+		printf >&2 "pre-receive< \$old \$new \$ref\n"
    ++		echo >&2 "pre-receive< $old $new $ref"
     +	done
     +	EOF
     +
     +	# setup post-receive hook
    -+	cat >upstream/hooks/post-receive <<-EOF &&
    ++	cat >upstream/hooks/post-receive <<-\EOF &&
     +	#!/bin/sh
     +
    -+	printf >&2 "# post-receive hook\n"
    ++	echo >&2 "# post-receive hook"
     +
     +	while read old new ref
     +	do
    -+		printf >&2 "post-receive< \$old \$new \$ref\n"
    ++		echo >&2 "post-receive< $old $new $ref"
     +	done
     +	EOF
     +
    @@ t/t5411-proc-receive-hook.sh (new)
     +		upstream/hooks/post-receive
     +'
     +
    ++# Refs of upstream : master(B)  next(A)
    ++# Refs of workbench: master(A)           tags/v123
    ++# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
     +test_expect_success "normal git-push command" '
    -+	(
    -+		cd workbench &&
    -+		git push -f origin \
    -+			refs/tags/v1.0.0 \
    -+			:refs/heads/next \
    -+			HEAD:refs/heads/master \
    -+			HEAD:refs/review/master/topic \
    -+			HEAD:refs/heads/a/b/c
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	git -C workbench push -f origin \
    ++		refs/tags/v123 \
    ++		:refs/heads/next \
    ++		HEAD:refs/heads/master \
    ++		HEAD:refs/review/master/topic \
    ++		HEAD:refs/heads/a/b/c \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-T> refs/tags/v1.0.0
    ++	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
    -+	remote: post-receive< <ZERO-OID> <COMMIT-T> refs/tags/v1.0.0
    ++	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
     +	To ../upstream
    -+	 + ce858e6...1029397 HEAD -> master (forced update)
    -+	 - [deleted]         next
    -+	 * [new tag]         v1.0.0 -> v1.0.0
    -+	 * [new reference]   HEAD -> refs/review/master/topic
    -+	 * [new branch]      HEAD -> a/b/c
    ++	 + <OID>...<OID> HEAD -> master (forced update)
    ++	 - [deleted] next
    ++	 * [new tag] v123 -> v123
    ++	 * [new reference] HEAD -> refs/review/master/topic
    ++	 * [new branch] HEAD -> a/b/c
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/a/b/c
     +	<COMMIT-A> refs/heads/master
     +	<COMMIT-A> refs/review/master/topic
    -+	<COMMIT-T> refs/tags/v1.0.0
    ++	<TAG-v123> refs/tags/v123
     +	EOF
     +	test_cmp expect actual
     +'
     +
     +test_done
     
    + ## t/t5516-fetch-push.sh ##
    +@@ t/t5516-fetch-push.sh: test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
    + test_expect_success 'push --porcelain' '
    + 	mk_empty testrepo &&
    + 	echo >.git/foo  "To testrepo" &&
    +-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
    ++	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
    + 	echo >>.git/foo "Done" &&
    + 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
    + 	(
    +
      ## transport.c ##
     @@ transport.c: static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
    + 				 porcelain, summary_width);
      	else if (is_null_oid(&ref->old_oid))
      		print_ref_status('*',
    - 			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
    +-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
     -			"[new branch]"),
    -+			(starts_with(ref->name, "refs/heads/") ? "[new branch]" :
    -+			"[new reference]")),
    - 			ref, ref->peer_ref, NULL, porcelain, summary_width);
    +-			ref, ref->peer_ref, NULL, porcelain, summary_width);
    ++				 (starts_with(ref->name, "refs/tags/")
    ++				  ? "[new tag]"
    ++				  : (starts_with(ref->name, "refs/heads/")
    ++				     ? "[new branch]"
    ++				     : "[new reference]")),
    ++				 ref, ref->peer_ref, NULL, porcelain, summary_width);
      	else {
      		struct strbuf quickref = STRBUF_INIT;
    + 		char type;
2:  67dea721b7 ! 2:  14641ec57e receive-pack: add new proc-receive hook
    @@ Commit message
         We can use this "proc-receive" command to create pull requests or send
         emails for code review.
     
    -    This "proc-receive" hook reads commands, push-options (optional), and
    -    send result using a protocol in pkt-line format.  In the following
    -    example, The letter "S" stands for "receive-pack" and letter "H" stands
    -    for the hook.
    +    Suggested by Junio, this "proc-receive" hook reads the commands,
    +    push-options (optional), and send result using a protocol in pkt-line
    +    format.  In the following example, The letter "S" stands for
    +    "receive-pack" and letter "H" stands for the hook.
     
    -        S: PKT-LINE(version=1\0push-options ...)
    +        # Version and capabilities negotiation.
    +        S: PKT-LINE(version=1\0push-options atomic...)
             S: flush-pkt
    -
    -        H: PKT-LINE(version=1\0push-options ...)
    +        H: PKT-LINE(version=1\0push-options...)
             H: flush-pkt
     
    +        # Send commands from server to the hook.
             S: PKT-LINE(old-oid new-oid ref)
             S: ... ...
             S: flush-pkt
    -
    -        # Optional, only if push-options is negotiated.
    +        # Only if push-options have been negotiated.
             S: PKT-LINE(push-option)
             S: ... ...
             S: flush-pkt
     
    +        # Receive result from the hook.
             # OK, run this command successfully.
             H: PKT-LINE(old-oid new-oid ref ok)
    -
             # NO, I reject it.
             H: PKT-LINE(old-oid new-oid ref ng reason)
    -
             # OK, but use an alternate reference. (in latter commit)
             H: PKT-LINE(old-oid new-oid ref ok ref:alt-ref)
    -
             # It will fallthrough to receive-pack to execute. (in latter commit)
             H: PKT-LINE(old-oid new-oid ref ft)
    -
             H: ... ...
             H: flush-pkt
     
    @@ Commit message
         the result to replace the commands that have specific `run_proc_receive`
         field turned on.
     
    +    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Makefile ##
    @@ Makefile: TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
      TEST_BUILTINS_OBJS += test-read-cache.o
     
      ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: struct command {
    +@@ builtin/receive-pack.c: static void write_head_info(void)
    + 	packet_flush(1);
    + }
    + 
    ++#define RUN_PROC_RECEIVE_SCHEDULE	1
    ++#define RUN_PROC_RECEIVE_RETURNED	2
    + struct command {
      	struct command *next;
      	const char *error_string;
      	unsigned int skip_update:1,
     -		     did_not_exist:1;
     +		     did_not_exist:1,
    -+		     run_proc_receive:1;
    ++		     run_proc_receive:2;
      	int index;
      	struct object_id old_oid;
      	struct object_id new_oid;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
      	return finish_command(&proc);
      }
      
    ++static struct command *find_command_by_refname(const struct command *list,
    ++					       const char *refname)
    ++{
    ++	for ( ; list; list = list->next)
    ++		if (!strcmp(list->ref_name, refname))
    ++			return (struct command *)list;
    ++	return NULL;
    ++}
    ++
     +static int read_proc_receive_result(struct packet_reader *reader,
    -+				    struct command **commands)
    ++				    struct command *commands)
     +{
    -+	struct command **tail = commands;
    ++	struct command *hint;
    ++	struct command *cmd;
     +	int code = 0;
     +
    ++	hint = NULL;
     +	for (;;) {
     +		struct object_id old_oid, new_oid;
    -+		struct command *cmd;
     +		const char *refname;
     +		const char *p;
     +		char *status;
     +		char *msg = NULL;
     +
    -+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
    ++		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     +			break;
    -+		}
    -+
     +		if (parse_oid_hex(reader->line, &old_oid, &p) ||
     +		    *p++ != ' ' ||
     +		    parse_oid_hex(p, &new_oid, &p) ||
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			die("protocol error: proc-receive has bad status '%s' for '%s'",
     +			    status, reader->line);
     +
    -+		FLEX_ALLOC_MEM(cmd, ref_name, refname, strlen(refname));
    -+		oidcpy(&cmd->old_oid, &old_oid);
    -+		oidcpy(&cmd->new_oid, &new_oid);
    -+		cmd->run_proc_receive = 1;
    -+
    ++		/* first try searching at our hint, falling back to all refs */
    ++		if (hint)
    ++			hint = find_command_by_refname(hint, refname);
    ++		if (!hint)
    ++			hint = find_command_by_refname(commands, refname);
    ++		if (!hint) {
    ++			warning("proc-receive reported status on unknown ref: %s",
    ++				refname);
    ++			continue;
    ++		}
    ++		if (!hint->run_proc_receive) {
    ++			warning("proc-receive reported status on ref of builtin command: %s",
    ++				refname);
    ++			continue;
    ++		}
    ++		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
    ++		oidcpy(&hint->old_oid, &old_oid);
    ++		oidcpy(&hint->new_oid, &new_oid);
     +		if (!strcmp(status, "ng")) {
     +			if (msg)
    -+				cmd->error_string = xstrdup(msg);
    ++				hint->error_string = xstrdup(msg);
     +			else
    -+				cmd->error_string = "failed";
    ++				hint->error_string = "failed";
     +			code = 1;
     +		} else if (strcmp("ok", status)) {
     +			die("protocol error: proc-receive has bad status '%s' for '%s'",
     +			    status, reader->line);
     +		}
    -+
    -+		*tail = cmd;
    -+		tail = &cmd->next;
     +	}
    ++
    ++	for (cmd = commands; cmd; cmd = cmd->next)
    ++		if (cmd->run_proc_receive &&
    ++		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED))
    ++		    cmd->error_string = "no report from proc-receive";
    ++
     +	return code;
     +}
     +
    -+static int run_proc_receive_hook(struct command **commands,
    ++static int run_proc_receive_hook(struct command *commands,
     +				 const struct string_list *push_options)
     +{
     +	struct child_process proc = CHILD_PROCESS_INIT;
     +	struct async muxer;
    -+	struct command *result_commands = NULL;
     +	struct command *cmd;
     +	const char *argv[2];
     +	struct packet_reader reader;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	packet_reader_init(&reader, proc.out, NULL, 0,
     +			   PACKET_READ_CHOMP_NEWLINE |
     +			   PACKET_READ_DIE_ON_ERR_PACKET);
    -+	if (use_push_options)
    -+		strbuf_addstr(&cap, " push-options");
     +	if (use_atomic)
     +		strbuf_addstr(&cap, " atomic");
    ++	if (use_push_options)
    ++		strbuf_addstr(&cap, " push-options");
     +	if (cap.len) {
     +		packet_write_fmt(proc.in, "version=1%c%s\n", '\0', cap.buf + 1);
     +		strbuf_release(&cap);
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		die("protocol error: unknown proc-receive version '%d'", version);
     +
     +	/* Send commands */
    -+	for (cmd = *commands; cmd; cmd = cmd->next) {
    ++	for (cmd = commands; cmd; cmd = cmd->next) {
     +		char *old_hex, *new_hex;
     +
     +		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	}
     +
     +	/* Read result from proc-receive */
    -+	code = read_proc_receive_result(&reader, &result_commands);
    ++	code = read_proc_receive_result(&reader, commands);
     +	close(proc.in);
     +	close(proc.out);
     +	if (use_sideband)
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +	sigchain_pop(SIGPIPE);
     +
    -+	/* After receiving the result from the "proc-receive" hook,
    -+	 * "receive-pack" will use the result to replace commands that
    -+	 * have specific `run_proc_receive` field.
    -+	 */
    -+	for (cmd = *commands; cmd; cmd = cmd->next)
    -+		if (!cmd->run_proc_receive)
    -+			break;
    -+
    -+	/* Merge commands with result_commands and sort */
    -+	if (!cmd) {
    -+		*commands = result_commands;
    -+	} else {
    -+		struct command *next_cmd = cmd;
    -+		struct command *next_result = result_commands;
    -+		struct command *head = NULL;
    -+		struct command *tail = NULL;
    -+
    -+		if (!next_result ||
    -+		    strcmp(next_cmd->ref_name, next_result->ref_name) < 0) {
    -+			head = next_cmd;
    -+			next_cmd = next_cmd->next;
    -+		} else {
    -+			head = next_result;
    -+			next_result = next_result->next;
    -+		}
    -+		tail = head;
    -+
    -+		for (;;) {
    -+			if (!next_cmd) {
    -+				tail->next = next_result;
    -+				break;
    -+			} else if (next_cmd->run_proc_receive) {
    -+				next_cmd = next_cmd->next;
    -+			} else if (!next_result) {
    -+				tail->next = next_cmd;
    -+				next_cmd = next_cmd->next;
    -+				tail = tail->next;
    -+			} else {
    -+				if (strcmp(next_cmd->ref_name, next_result->ref_name) < 0) {
    -+					tail->next = next_cmd;
    -+					next_cmd = next_cmd->next;
    -+					tail = tail->next;
    -+				} else {
    -+					tail->next = next_result;
    -+					next_result = next_result->next;
    -+					tail = tail->next;
    -+				}
    -+			}
    -+		}
    -+		*commands = head;
    -+	}
    -+
     +	return code;
     +}
     +
    @@ builtin/receive-pack.c: static void execute_commands_atomic(struct command *comm
      			continue;
      
      		cmd->error_string = update(cmd, si);
    -@@ builtin/receive-pack.c: static void execute_commands_atomic(struct command *commands,
    - 	strbuf_release(&err);
    - }
    - 
    --static void execute_commands(struct command *commands,
    -+static void execute_commands(struct command **orig_commands,
    - 			     const char *unpacker_error,
    - 			     struct shallow_info *si,
    - 			     const struct string_list *push_options)
    - {
    -+	struct command *commands = *orig_commands;
    - 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
    - 	struct command *cmd;
    +@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	struct iterate_data data;
      	struct async muxer;
      	int err_fd = 0;
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +	if (run_proc_receive) {
     +		int code;
     +
    -+		code = run_proc_receive_hook(orig_commands, push_options);
    -+		commands = *orig_commands;
    ++		code = run_proc_receive_hook(commands, push_options);
     +		if (code) {
     +			for (cmd = commands; cmd; cmd = cmd->next) {
     +				if (!cmd->error_string  && (cmd->run_proc_receive || use_atomic))
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	if (use_atomic)
      		execute_commands_atomic(commands, si);
      	else
    -@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
    - 			update_shallow_info(commands, &si, &ref);
    - 		}
    - 		use_keepalive = KEEPALIVE_ALWAYS;
    --		execute_commands(commands, unpack_status, &si,
    -+		execute_commands(&commands, unpack_status, &si,
    - 				 &push_options);
    - 		if (pack_lockfile)
    - 			unlink_or_warn(pack_lockfile);
     
      ## t/helper/test-proc-receive.c (new) ##
     @@
    @@ t/helper/test-proc-receive.c (new)
     +static int version = 1;
     +static int verbose = 0;
     +static int no_push_options = 0;
    ++static int use_atomic = 0;
     +static int use_push_options = 0;
     +static struct string_list returns = STRING_LIST_INIT_NODUP;
     +
    @@ t/helper/test-proc-receive.c (new)
     +			linelen = strlen(reader->line);
     +			if (linelen < reader->pktlen) {
     +				const char *feature_list = reader->line + linelen + 1;
    ++				if (parse_feature_request(feature_list, "atomic"))
    ++					use_atomic= 1;
     +				if (parse_feature_request(feature_list, "push-options"))
     +					use_push_options = 1;
     +			}
    @@ t/helper/test-proc-receive.c (new)
     +	if (verbose) {
     +		struct command *cmd;
     +
    ++		if (use_push_options || use_atomic)
    ++			fprintf(stderr, "proc-receive:%s%s\n",
    ++				use_atomic? " atomic": "",
    ++				use_push_options ? " push_options": "");
    ++
     +		for (cmd = commands; cmd; cmd = cmd->next) {
     +			char *old_hex, *new_hex;
     +
    @@ t/helper/test-tool.h: int cmd__parse_pathspec_file(int argc, const char** argv);
      int cmd__read_cache(int argc, const char **argv);
     
      ## t/t5411-proc-receive-hook.sh ##
    -@@ t/t5411-proc-receive-hook.sh: format_git_output () {
    - 		-e "s/'/\"/g"
    +@@ t/t5411-proc-receive-hook.sh: make_user_friendly_and_stable_output () {
    + 		-e "s/[0-9a-f]\{7,\}/<OID>/g"
      }
      
     +# Asynchronous sideband may generate inconsistent output messages,
     +# sort before comparison.
     +test_sorted_cmp () {
    -+	if ! $GIT_TEST_CMP "$@"
    ++	if ! $GIT_TEST_CMP "$@" >/dev/null 2>&1
     +	then
     +		cmd=$GIT_TEST_CMP
     +		for f in "$@"
    @@ t/t5411-proc-receive-hook.sh: format_git_output () {
     +			sort "$f" >"$f.sorted"
     +			cmd="$cmd \"$f.sorted\""
     +		done
    -+		if ! eval $cmd
    ++		if ! eval $cmd >/dev/null 2>&1
     +		then
     +			$GIT_TEST_CMP "$@"
     +		fi
     +	fi
     +}
     +
    + # Refs of upstream : master(B)  next(A)
    + # Refs of workbench: master(A)           tags/v123
      test_expect_success "setup" '
    - 	git init --bare upstream &&
    - 	git init workbench &&
     @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
      	test_cmp expect actual
      '
      
    ++# Refs of upstream : master(A)  tags/v123  refs/review/master/topic(A)  a/b/c(A)
    ++# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
     +	(
     +		cd upstream &&
     +		git update-ref -d refs/review/master/topic &&
    -+		git update-ref -d refs/tags/v1.0.0 &&
    ++		git update-ref -d refs/tags/v123 &&
     +		git update-ref -d refs/heads/a/b/c
     +	)
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       next(A)  refs/for/master/topic(A)
     +test_expect_success "no proc-receive hook, fail to push special ref" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:next \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:next \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	To ../upstream
    -+	 * [new branch]      HEAD -> next
    ++	 * [new branch] HEAD -> next
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	<COMMIT-A> refs/heads/next
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
    -+	(
    -+		cd upstream &&
    -+		git update-ref -d refs/heads/next
    -+	)
    ++	git -C upstream update-ref -d refs/heads/next
     +'
     +
    -+# TODO: report for the failure of master branch is unnecessary.
    -+test_expect_success "no proc-receive hook, fail all for atomic push" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push --atomic origin \
    -+			HEAD:next \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push --atomic:                       next(A)  refs/for/master/topic(A)
    ++test_expect_failure "no proc-receive hook, fail all for atomic push" '
    ++	test_must_fail git -C workbench push --atomic origin \
    ++		HEAD:next \
    ++		HEAD:refs/for/master/topic >out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: error: cannot to find hook "proc-receive"
     +	To ../upstream
    -+	 ! [rejected]        master (atomic push failed)
     +	 ! [remote rejected] HEAD -> next (fail to run proc-receive hook)
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	chmod a+x upstream/hooks/proc-receive
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(A)
     +test_expect_success "proc-receive bad protocol: unknown version" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out | grep "protocol error" >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
     +	cat >expect <<-EOF &&
     +	fatal: protocol error: unknown proc-receive version "2"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       next(A)  refs/for/master/topic(A)
     +test_expect_success "proc-receive bad protocol: no report" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/heads/next \
    ++		HEAD:refs/for/master/topic >out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	To ../upstream
    -+	 ! [remote failure]  HEAD -> refs/for/master/topic (remote failed to report status)
    ++	 * [new branch] HEAD -> next
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
     +	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    ++	<COMMIT-A> refs/heads/next
     +	EOF
     +	test_cmp expect actual
     +'
     +
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup" '
    ++	git -C upstream update-ref -d refs/heads/next
    ++
    ++'
    ++
     +test_expect_success "setup proc-receive hook (bad oid)" '
     +	cat >upstream/hooks/proc-receive <<-EOF
     +	#!/bin/sh
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
     +test_expect_success "proc-receive bad protocol: bad oid" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out | grep "protocol error" >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic\
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
     +	cat >expect <<-EOF &&
     +	fatal: protocol error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
     +test_expect_success "proc-receive bad protocol: no status" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out | grep "protocol error" >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
     +	cat >expect <<-EOF &&
     +	fatal: protocol error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
     +test_expect_success "proc-receive bad protocol: unknown status" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out | grep "protocol error" >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++			HEAD:refs/for/master/topic \
    ++			>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
     +	cat >expect <<-EOF &&
     +	fatal: protocol error: proc-receive has bad status "xx" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
     +test_expect_success "proc-receive bad protocol: bad status" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out | grep "protocol error" >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out | grep "protocol error" >actual &&
     +	cat >expect <<-EOF &&
     +	fatal: protocol error: proc-receive has bad status "bad status" for "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
     +test_expect_success "proc-receive: fail to update (no message)" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
     +test_expect_success "proc-receive: fail to update (has message)" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	error: failed to push some refs to "../upstream"
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success "setup proc-receive hook (report status on builtin command)" '
    ++	cat >upstream/hooks/proc-receive <<-EOF
    ++	#!/bin/sh
    ++
    ++	printf >&2 "# proc-receive hook\n"
    ++
    ++	test-tool proc-receive -v \
    ++		-r "$ZERO_OID $A refs/heads/master ok"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         : (B)                   refs/for/master/topic
    ++test_expect_success "proc-receive: warning on report for builtin command" '
    ++	test_must_fail git -C workbench push origin \
    ++		$B:refs/heads/master \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/heads/master ok
    ++	warning: proc-receive reported status on ref of builtin command: refs/heads/master
    ++	remote: # post-receive hook
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	To ../upstream
    ++	 <OID>..<OID> <COMMIT-B> -> master
    ++	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
    ++	error: failed to push some refs to "../upstream"
    ++	EOF
    ++	test_sorted_cmp expect actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-B> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success "cleanup" '
    ++	git -C upstream update-ref refs/heads/master $A
    ++'
    ++
     +test_expect_success "setup proc-receive hook (ok)" '
     +	cat >upstream/hooks/proc-receive <<-EOF
     +	#!/bin/sh
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	EOF
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic
     +test_expect_success "proc-receive: ok" '
    -+	(
    -+		cd workbench &&
    -+		git push origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To ../upstream
    -+	 * [new reference]   HEAD -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "proc-receive: report unknown ref" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push origin \
    -+			HEAD:refs/for/a/b/c/my/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/a/b/c/my/topic
    ++test_expect_success "proc-receive: no report from proc-receive" '
    ++	test_must_fail git -C workbench push origin \
    ++		HEAD:refs/for/a/b/c/my/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    -+	warning: remote reported status on unknown ref: refs/for/master/topic
    -+	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	warning: proc-receive reported status on unknown ref: refs/for/master/topic
     +	To ../upstream
    -+	 ! [remote failure]  HEAD -> refs/for/a/b/c/my/topic (remote failed to report status)
    ++	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (no report from proc-receive)
     +	error: failed to push some refs to "../upstream"
     +	EOF
    -+	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	test_sorted_cmp expect actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
     +	test_cmp expect actual
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push -o ...  :                       refs/for/master/topic
     +test_expect_success "not support push options" '
    -+	(
    -+		cd workbench &&
    -+		test_must_fail git push \
    -+			-o issue=123 \
    -+			-o reviewer=user1 \
    -+			origin \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	test_must_fail git -C workbench push \
    ++		-o issue=123 \
    ++		-o reviewer=user1 \
    ++		origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	fatal: the receiving end does not support push options
     +	fatal: the remote end hung up unexpectedly
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +'
     +
     +test_expect_success "enable push options" '
    -+	(
    -+		cd upstream &&
    -+		git config receive.advertisePushOptions true
    -+	)
    ++	git -C upstream config receive.advertisePushOptions true
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push -o ...  :                       next(A)  refs/for/master/topic
     +test_expect_success "push with options" '
    -+	(
    -+		cd workbench &&
    -+		git push \
    -+			-o issue=123 \
    -+			-o reviewer=user1 \
    -+			origin \
    -+			HEAD:refs/heads/next \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	git -C workbench push \
    ++		--atomic \
    ++		-o issue=123 \
    ++		-o reviewer=user1 \
    ++		origin \
    ++		HEAD:refs/heads/next \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
    ++	remote: proc-receive: atomic push_options
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive< issue=123
     +	remote: proc-receive< reviewer=user1
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
     +	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To ../upstream
    -+	 * [new branch]      HEAD -> next
    -+	 * [new reference]   HEAD -> refs/for/master/topic
    ++	 * [new branch] HEAD -> next
    ++	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	<COMMIT-A> refs/heads/next
3:  d3d4ee428b = 3:  2440a474bd refs.c: refactor to reuse ref_is_hidden()
4:  5e049d89b1 ! 4:  e041582643 receive-pack: new config receive.procReceiveRefs
    @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
      	return git_default_config(var, value, cb);
      }
      
    -@@ builtin/receive-pack.c: static void execute_commands(struct command **orig_commands,
    +@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	/* Try to find commands that have special prefix in their reference names,
      	 * and mark them to run an external "proc-receive" hook later.
      	 */
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "cleanup" '
     +	)
     +'
     +
    - test_expect_success "no proc-receive hook, fail to push special ref" '
    - 	(
    - 		cd workbench &&
    + # Refs of upstream : master(A)
    + # Refs of workbench: master(A)  tags/v123
    + # git push         :                       next(A)  refs/for/master/topic(A)
     @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
      	test_cmp expect actual
      '
      
    ++# Refs of upstream : master(A)             next(A)
    ++# Refs of workbench: master(A)  tags/v123
     +test_expect_success "cleanup" '
    -+	(
    -+		cd upstream &&
    -+		git update-ref -d refs/heads/next
    -+	)
    ++	git -C upstream update-ref -d refs/heads/next
     +'
     +
     +test_expect_success "setup proc-receive hook" '
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +	chmod a+x upstream/hooks/proc-receive
     +'
     +
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/next/topic(A)  refs/review/a/b/c/topic(A)  refs/for/master/topic(A)
     +test_expect_success "report update of all special refs" '
    -+	(
    -+		cd workbench &&
    -+		git push origin \
    -+			HEAD:refs/for/next/topic \
    -+			HEAD:refs/review/a/b/c/topic \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/next/topic \
    ++		HEAD:refs/review/a/b/c/topic \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To ../upstream
    -+	 * [new reference]   HEAD -> refs/for/next/topic
    -+	 * [new reference]   HEAD -> refs/review/a/b/c/topic
    -+	 * [new reference]   HEAD -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/for/next/topic
    ++	 * [new reference] HEAD -> refs/review/a/b/c/topic
    ++	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
     +	EOF
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +	chmod a+x upstream/hooks/proc-receive
     +'
     +
    -+test_expect_success "report mixed refs update (head first)" '
    -+	(
    -+		cd workbench &&
    -+		git push origin \
    -+			HEAD:refs/heads/zzz \
    -+			HEAD:refs/for/next/topic \
    -+			HEAD:refs/heads/yyy \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
    ++test_expect_success "report mixed refs update" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/heads/bar \
    ++		HEAD:refs/heads/baz \
    ++		HEAD:refs/for/next/topic \
    ++		HEAD:refs/heads/foo \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/zzz
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "push with options" '
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
     +	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/zzz
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
     +	To ../upstream
    -+	 * [new branch]      HEAD -> zzz
    -+	 * [new reference]   HEAD -> refs/for/next/topic
    -+	 * [new branch]      HEAD -> yyy
    -+	 * [new reference]   HEAD -> refs/for/master/topic
    ++	 * [new branch] HEAD -> bar
    ++	 * [new branch] HEAD -> baz
    ++	 * [new reference] HEAD -> refs/for/next/topic
    ++	 * [new branch] HEAD -> foo
    ++	 * [new reference] HEAD -> refs/for/master/topic
     +	EOF
     +	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	<COMMIT-A> refs/heads/master
    -+	<COMMIT-A> refs/heads/yyy
    -+	<COMMIT-A> refs/heads/zzz
    -+	EOF
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success "cleanup" '
    -+	(
    -+		cd upstream &&
    -+		git update-ref -d refs/heads/yyy &&
    -+		git update-ref -d refs/heads/zzz
    -+	)
    -+'
    -+
    -+test_expect_success "setup proc-receive hook" '
    -+	cat >upstream/hooks/proc-receive <<-EOF &&
    -+	#!/bin/sh
    -+
    -+	printf >&2 "# proc-receive hook\n"
    -+
    -+	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/next/topic ok" \
    -+		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
    -+		-r "$ZERO_OID $A refs/for/master/topic ok"
    -+	EOF
    -+	chmod a+x upstream/hooks/proc-receive
    -+'
    -+
    -+test_expect_success "report mixed refs update (special ref first)" '
    -+	(
    -+		cd workbench &&
    -+		git push origin \
    -+			HEAD:refs/for/next/topic \
    -+			$B:refs/heads/zzz \
    -+			HEAD:refs/review/a/b/c/topic \
    -+			HEAD:refs/heads/yyy \
    -+			HEAD:refs/for/master/topic
    -+	) >out 2>&1 &&
    -+	format_git_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/heads/zzz
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    -+	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/heads/zzz
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/yyy
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	To ../upstream
    -+	 * [new reference]   HEAD -> refs/for/next/topic
    -+	 * [new branch]      <COMMIT-B> -> zzz
    -+	 * [new reference]   HEAD -> refs/review/a/b/c/topic
    -+	 * [new branch]      HEAD -> yyy
    -+	 * [new reference]   HEAD -> refs/for/master/topic
    -+	EOF
    -+	test_cmp expect actual &&
    -+	(
    -+		cd upstream &&
    -+		git show-ref
    -+	) >out &&
    -+	format_git_output <out >actual &&
    ++	git -C upstream show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/heads/bar
    ++	<COMMIT-A> refs/heads/baz
    ++	<COMMIT-A> refs/heads/foo
     +	<COMMIT-A> refs/heads/master
    -+	<COMMIT-A> refs/heads/yyy
    -+	<COMMIT-B> refs/heads/zzz
     +	EOF
     +	test_cmp expect actual
     +'
5:  624538c1b7 < -:  ---------- receive-pack: refactor report for proc-receive
-:  ---------- > 5:  439acbdb62 receive-pack: refactor report for proc-receive
6:  56543573cf = 6:  24e5cddee0 doc: add documentation for the proc-receive hook


Jiang Xin (6):
  transport: not report a non-head push as a branch
  receive-pack: add new proc-receive hook
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  receive-pack: refactor report for proc-receive
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt |  14 +
 Documentation/githooks.txt       |  70 +++
 Makefile                         |   1 +
 builtin/receive-pack.c           | 290 +++++++++-
 refs.c                           |  11 +-
 refs.h                           |   1 +
 t/helper/test-proc-receive.c     | 172 ++++++
 t/helper/test-tool.c             |   1 +
 t/helper/test-tool.h             |   1 +
 t/t5411-proc-receive-hook.sh     | 916 +++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh            |   2 +-
 transport-helper.c               |  64 +--
 transport.c                      |  62 ++-
 13 files changed, 1539 insertions(+), 66 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh

-- 
2.26.0.4.g39bcdcb101.dirty

