Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C337C2BA2B
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CD720673
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLRrPKwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgDLNaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40725 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgDLNaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id c5so3328983pgi.7
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Thg7olpB1cBqJ0WTcvi8zdoXAVEG674Sx56FFfpBtFw=;
        b=RLRrPKwVPXhAsbrlPxjh+bZNC1AwvL0f0+BBi/ldCZ4n84YzW6GRTUZaRNTiaimq1f
         YsSIZYuW2a8h4AXPMNY2tTIlcyD+cSyxw2yRBhLwG6ezVoqDNyOjCu22qd8p1E6t97Pb
         4xoFNq7jpdOW9Jnt6CfCJRE3RP0fRfSmbbhTa//LD6I2wY9VsmTfU0PWSSSWDCTLLwvF
         LyBhCFICS6aNuN8w6Um3M3juq4FJ0JQparHLtvLFSrsc8mapWrF3YEM+/hl3IA7x4BTT
         gNamuQt+jMRbT4GlGSIJx9umB2PWinu765gOPN7TsJ/c7nAAZUlicinIDZFd1RFormiE
         bBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Thg7olpB1cBqJ0WTcvi8zdoXAVEG674Sx56FFfpBtFw=;
        b=S7AGsWFzoNqh1qRYk2Rp0PMoKXtSXEL/AMaPV3cNGN7gTmWO1ubkKjmkW423wyPU1+
         20bpnpcWHfMmzy9wm3Oh//18yzkZjXEJlZBOhr06tD8r8jhPdYtJyyDSy10ZXD1mSXJa
         SFpBLdVANJniIfSRCYj868FBvjYV51ac9yDPdjs1WcYyEv1Y2ftppaiLwVRh1vWOTvC0
         +89ns5WgQPCVP28ijyJqJW/YZXrPCRAMsZD7A3SzNQW9xPQC9HoLszZ/OjlAFAKxtKnr
         x1e3AmU+1B6mI7HoMVKBw41yUz6EthrTX/jAHgBv8176T7SHN9nI/xNBBiwAJZ8JZ51r
         47LA==
X-Gm-Message-State: AGi0PuZQL01Z+xqJVleDBq9iFgYk+rcahF8otKwlC10DMNKtkwXbmRz4
        w3Z8XgzW6AcQwbFzT2tbW/c=
X-Google-Smtp-Source: APiQypKwazPfuVaaHRc42TL4OxlJQ/jqUbO/MV9tmmVlVaCl6wc0SBfhOaWr7LonyNH/19efzehUOg==
X-Received: by 2002:a63:5645:: with SMTP id g5mr13666106pgm.268.1586698228896;
        Sun, 12 Apr 2020 06:30:28 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 139sm6093363pfv.0.2020.04.12.06.30.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:30:28 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 0/8] New proc-receive hook for centralized workflow
Date:   Sun, 12 Apr 2020 09:30:14 -0400
Message-Id: <20200412133022.17590-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200407120813.25025-1-worldhello.net@gmail.com>
References: <20200407120813.25025-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>


## Changes since v9

1. Minor refactors on patch 1/8, 2/8, 4/8, and 8/8.

2. New patch 5/8: export function `parse_feature_value()`.

3. Split patch 5/6 of reroll v9 into two patches (6/8 and 7/8),
   one for the server-side and one for the client-side.
   so can make a compatible test on old version of a Git client.

4. Patch 6/8: Use null character to split extended status of the report
   line, and add other key-value pairs for extension. For example:

   When we push to a pseudo reference using the following command:

       git push origin HEAD:refs/for/master/topic

   Even if the push command updates an existing pull request (such as
   refs/pull/123/head) instead of creating a new one, `git push`
   always give the following report:

       To <URL/of/upstream.git>
         * [new reference]      HEAD -> refs/pull/123/head

   After add more key-value pairs in the extended status, such as:
   'old-oid=<...>', 'forced-update', we get a nicer status report like:

       To upstream.git
        + 1234567...7654321     HEAD -> refs/pull/124/head (forced update)


## Range-diff v9...v10

1:  ba6222899b ! 1:  a293077bcf transport: not report a non-head push as a branch
    @@ t/t5411-proc-receive-hook.sh (new)
     +
     +# Format the output of git-push, git-show-ref and other commands to make a
     +# user-friendly and stable text.  In addition to the common format method,
    -+# we also replace URL of different protocol for the upstream repository to
    -+# a fixed pattern.
    ++# we also replace the URL of different protocol for the upstream repository
    ++# with a fixed pattern.
     +make_user_friendly_and_stable_output () {
     +	make_user_friendly_and_stable_output_common | sed \
     +		-e "s#To ../upstream.git#To <URL/of/upstream.git>#"
    @@ t/t5411/common-functions.sh (new)
     +		-e "s/$B/<COMMIT-B>/g" \
     +		-e "s/$TAG/<TAG-v123>/g" \
     +		-e "s/$ZERO_OID/<ZERO-OID>/g" \
    -+		-e "s/[0-9a-f]\{7,\}/<OID>/g"
    ++		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
    ++		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g"
     +}
     
      ## t/t5411/common-test-cases.sh (new) ##
    @@ t/t5411/common-test-cases.sh (new)
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
     +	To <URL/of/upstream.git>
    -+	 + <OID>...<OID> HEAD -> master (forced update)
    ++	 + <OID-B>...<OID-A> HEAD -> master (forced update)
     +	 - [deleted] next
     +	 * [new tag] v123 -> v123
     +	 * [new reference] HEAD -> refs/review/master/topic
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +
     +# Format the output of git-push, git-show-ref and other commands to make a
     +# user-friendly and stable text.  In addition to the common format method,
    -+# we also replace URL of different protocol for the upstream repository to
    -+# a fixed pattern.
    ++# we also replace the URL of different protocol for the upstream repository
    ++# with a fixed pattern.
     +make_user_friendly_and_stable_output () {
     +	make_user_friendly_and_stable_output_common | sed \
     +		-e "s#To http:.*/upstream.git#To <URL/of/upstream.git>#"
2:  195c5b0a0c ! 2:  915b9ef616 receive-pack: add new proc-receive hook
    @@ Commit message
         format.  In the following example, The letter "S" stands for
         "receive-pack" and letter "H" stands for the hook.
     
    -        # Version and capabilities negotiation.
    +        # Version and features negotiation.
             S: PKT-LINE(version=1\0push-options atomic...)
             S: flush-pkt
             H: PKT-LINE(version=1\0push-options...)
             H: flush-pkt
     
             # Send commands from server to the hook.
    -        S: PKT-LINE(old-oid new-oid ref)
    +        S: PKT-LINE(<old-oid> <new-oid> <ref>)
             S: ... ...
             S: flush-pkt
    -        # Only if push-options have been negotiated.
    +        # Send push-options only if the 'push-options' feature is enabled.
             S: PKT-LINE(push-option)
             S: ... ...
             S: flush-pkt
     
             # Receive result from the hook.
             # OK, run this command successfully.
    -        H: PKT-LINE(old-oid new-oid ref ok)
    +        H: PKT-LINE(<old-oid> <new-oid> <ref> ok)
             # NO, I reject it.
    -        H: PKT-LINE(old-oid new-oid ref ng reason)
    -        # OK, but use an alternate reference. (in latter commit)
    -        H: PKT-LINE(old-oid new-oid ref ok ref:alt-ref)
    -        # It will fallthrough to receive-pack to execute. (in latter commit)
    -        H: PKT-LINE(old-oid new-oid ref ft)
    +        H: PKT-LINE(<old-oid> <new-oid> <ref> ng <reason>)
    +        # Fall through, let 'receive-pack' to execute it.
    +        H: PKT-LINE(<old-oid> <new-oid> <ref> ft)
    +        # OK, but has an alternate reference.  The alternate reference name
    +        # and other status are given in key=value pairs after the null
    +        # character.
    +        H: PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head
    +                    forced-update)
             H: ... ...
             H: flush-pkt
     
    -    After receiving a command, the hook can create/update another alternate
    -    reference.  For example, a command for a reference "refs/for/master" may
    -    create a special reference, such as "refs/pull/123/head".  The alternate
    -    reference can be returned from the result in an extensible format like
    -    "<old-oid> <new-oid> <reference> <status> [<message>]".
    +    After receiving a command, the hook will execute the command, and may
    +    create/update different reference.  For example, a command for a pseudo
    +    reference "refs/for/master/topic" may create/update different reference
    +    such as "refs/pull/123/head".  The alternate reference name and other
    +    status are given in key-value pairs as extended status of the report
    +    line.
     
    -    The result will be stored in a command list, and "receive-pack" will use
    -    the result to replace the commands that have specific `run_proc_receive`
    -    field turned on.
    +    The list of commands returned from "proc-receive" will replace the
    +    relevant commands that are sent from user to "receive-pack", and
    +    "receive-pack" will continue to run the "execute_commands" function and
    +    other routines.  Finally, the result of the execution of these commands
    +    will be reported to end user.
     
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +static struct command *find_command_by_refname(const struct command *list,
     +					       const char *refname)
     +{
    -+	for ( ; list; list = list->next)
    ++	for (; list; list = list->next)
     +		if (!strcmp(list->ref_name, refname))
     +			return (struct command *)list;
     +	return NULL;
     +}
     +
    -+static int read_proc_receive_result(struct packet_reader *reader,
    ++static int read_proc_receive_report(struct packet_reader *reader,
     +				    struct command *commands,
     +				    struct strbuf *errmsg)
     +{
    -+	struct command *hint;
     +	struct command *cmd;
    ++	struct command *hint = NULL;
     +	int code = 0;
     +
    -+	hint = NULL;
     +	for (;;) {
     +		struct object_id old_oid, new_oid;
     +		const char *refname;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	}
     +
     +	for (cmd = commands; cmd; cmd = cmd->next)
    -+		if (cmd->run_proc_receive &&
    ++		if (cmd->run_proc_receive && !cmd->error_string &&
     +		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
     +		    cmd->error_string = "no report from proc-receive";
     +		    code = -1;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +	/* Send commands */
     +	for (cmd = commands; cmd; cmd = cmd->next) {
    -+		char *old_hex, *new_hex;
    -+
     +		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
     +			continue;
    -+		old_hex = oid_to_hex(&cmd->old_oid);
    -+		new_hex = oid_to_hex(&cmd->new_oid);
     +		packet_write_fmt(proc.in, "%s %s %s",
    -+				 old_hex, new_hex, cmd->ref_name);
    ++				 oid_to_hex(&cmd->old_oid),
    ++				 oid_to_hex(&cmd->new_oid),
    ++				 cmd->ref_name);
     +	}
     +	packet_flush(proc.in);
     +
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	}
     +
     +	/* Read result from proc-receive */
    -+	code = read_proc_receive_result(&reader, commands, &errmsg);
    ++	code = read_proc_receive_report(&reader, commands, &errmsg);
     +
     +cleanup:
     +	close(proc.in);
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	free(head_name_to_free);
      	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
      
    -+	if (run_proc_receive) {
    -+		int code;
    -+
    -+		code = run_proc_receive_hook(commands, push_options);
    -+		if (code) {
    -+			for (cmd = commands; cmd; cmd = cmd->next) {
    -+				if (!cmd->error_string  && (cmd->run_proc_receive || use_atomic))
    -+					cmd->error_string = "fail to run proc-receive hook";
    -+			}
    -+		}
    -+	}
    ++	if (run_proc_receive &&
    ++	    run_proc_receive_hook(commands, push_options))
    ++		for (cmd = commands; cmd; cmd = cmd->next)
    ++			if (!cmd->error_string  && (cmd->run_proc_receive || use_atomic))
    ++				cmd->error_string = "fail to run proc-receive hook";
     +
      	if (use_atomic)
      		execute_commands_atomic(commands, si);
    @@ t/helper/test-proc-receive.c (new)
     +		const char *refname;
     +		const char *p;
     +
    -+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
    ++		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     +			break;
    -+		}
     +
     +		if (parse_oid_hex(reader->line, &old_oid, &p) ||
     +		    *p++ != ' ' ||
    @@ t/helper/test-proc-receive.c (new)
     +int cmd__proc_receive(int argc, const char **argv)
     +{
     +	struct packet_reader reader;
    -+	struct command *commands;
    ++	struct command *commands = NULL;
     +	struct string_list push_options = STRING_LIST_INIT_DUP;
     +	struct string_list_item *item;
     +	struct option options[] = {
    @@ t/helper/test-proc-receive.c (new)
     +				use_atomic? " atomic": "",
     +				use_push_options ? " push_options": "");
     +
    -+		for (cmd = commands; cmd; cmd = cmd->next) {
    -+			char *old_hex, *new_hex;
    -+
    -+			old_hex = oid_to_hex(&cmd->old_oid);
    -+			new_hex = oid_to_hex(&cmd->new_oid);
    ++		for (cmd = commands; cmd; cmd = cmd->next)
     +			fprintf(stderr, "proc-receive< %s %s %s\n",
    -+				old_hex, new_hex, cmd->ref_name);
    -+		}
    ++				oid_to_hex(&cmd->old_oid),
    ++				oid_to_hex(&cmd->new_oid),
    ++				cmd->ref_name);
     +
    -+		if (push_options.nr > 0) {
    ++		if (push_options.nr > 0)
     +			for_each_string_list_item(item, &push_options)
     +				fprintf(stderr, "proc-receive< %s\n", item->string);
    -+		}
     +
    -+		if (returns.nr) {
    ++		if (returns.nr)
     +			for_each_string_list_item(item, &returns)
     +				fprintf(stderr, "proc-receive> %s\n", item->string);
    -+		}
     +	}
     +
    -+	if (returns.nr) {
    ++	if (returns.nr)
     +		for_each_string_list_item(item, &returns)
     +			packet_write_fmt(1, "%s\n", item->string);
    -+	}
     +	packet_flush(1);
     +	sigchain_pop(SIGPIPE);
     +
    @@ t/t5411/common-functions.sh: create_commits_in () {
      	sed \
      		-e "s/  *\$//" \
     @@ t/t5411/common-functions.sh: make_user_friendly_and_stable_output_common () {
    - 		-e "s/$B/<COMMIT-B>/g" \
      		-e "s/$TAG/<TAG-v123>/g" \
      		-e "s/$ZERO_OID/<ZERO-OID>/g" \
    --		-e "s/[0-9a-f]\{7,\}/<OID>/g"
    -+		-e "s/[0-9a-f]\{7,\}/<OID>/g" \
    + 		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
    +-		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g"
    ++		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
     +		-e "/^error: / d"
      }
     
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	To <URL/of/upstream.git>
    -+	 <OID>..<OID> <COMMIT-B> -> master
    ++	 <OID-A>..<OID-B> <COMMIT-B> -> master
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (no report from proc-receive)
     +	EOF
     +	test_cmp expect actual &&
3:  cde556e9c7 = 3:  16257616ec refs.c: refactor to reuse ref_is_hidden()
4:  3200327695 ! 4:  cd49b57c17 receive-pack: new config receive.procReceiveRefs
    @@ Commit message
         Add a new multi-valued config variable "receive.procReceiveRefs"
         for `receive-pack` command, like the follows:
     
    -        git config --system --add receive.procReceiveRefs refs/for/
    -        git config --system --add receive.procReceiveRefs refs/drafts/
    +        git config --system --add receive.procReceiveRefs refs/for
    +        git config --system --add receive.procReceiveRefs refs/drafts
     
         If the specific prefix strings match the reference names of the commands
    -    which are sent by git client to `receive-pack`, these commands will be
    +    which are sent from git client to `receive-pack`, these commands will be
         executed by an external hook (named "proc-receive"), instead of the
         internal `execute_commands` function.
     
    -    For example, if it is set to "refs/for/", pushing to a reference such as
    +    For example, if it is set to "refs/for", pushing to a reference such as
         "refs/for/master" will not create or update reference "refs/for/master",
    -    but may create or update a pull request directly by running the external
    -    hook.
    +    but may create or update a pull request directly by running the hook
    +    "proc-receive".
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
    @@ Documentation/config/receive.txt: receive.hideRefs::
     +receive.procReceiveRefs::
     +	This is a multi-valued variable that defines reference prefixes
     +	to match the commands in `receive-pack`.  Commands matching the
    -+	prefixes will be executed by an external hooks "proc-receive",
    ++	prefixes will be executed by an external hook "proc-receive",
     +	instead of the internal `execute_commands` function.  If this
     +	variable is not defined, the "proc-receive" hook will never be
     +	used, and all commands will be executed by the internal
    @@ Documentation/config/receive.txt: receive.hideRefs::
     +	For example, if this variable is set to "refs/for", pushing to
     +	reference such as "refs/for/master" will not create or update a
     +	reference named "refs/for/master", but may create or update a
    -+	pull request directly by running an external hook.
    ++	pull request directly by running the hook "proc-receive".
     +
      receive.updateServerInfo::
      	If set to true, git-receive-pack will run git-update-server-info
    @@ t/t5411/common-test-cases.sh: test_expect_success "push with options" '
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
     +		-r "$ZERO_OID $A refs/for/next/topic ok" \
    -+		-r "$ZERO_OID $A refs/for/master/topic ok"
    ++		-r "$B $A refs/for/master/topic ok"
     +	EOF
     +	chmod a+x "$upstream/hooks/proc-receive"
     +'
    @@ t/t5411/common-test-cases.sh: test_expect_success "push with options" '
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    ++	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 * [new reference] HEAD -> refs/for/next/topic
     +	 * [new reference] HEAD -> refs/review/a/b/c/topic
    @@ t/t5411/common-test-cases.sh: test_expect_success "push with options" '
     +
     +	test-tool proc-receive -v \
     +		-r "$ZERO_OID $A refs/for/next/topic ok" \
    -+		-r "$ZERO_OID $A refs/for/master/topic ok"
    ++		-r "$A $B refs/for/master/topic ok"
     +	EOF
     +	chmod a+x "$upstream/hooks/proc-receive"
     +'
    @@ t/t5411/common-test-cases.sh: test_expect_success "push with options" '
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    ++	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 * [new branch] HEAD -> bar
     +	 * [new branch] HEAD -> baz
5:  5f2ab02b01 < -:  ---------- receive-pack: refactor report for proc-receive
6:  b7d7175d89 < -:  ---------- doc: add documentation for the proc-receive hook
-:  ---------- > 5:  75b178fc19 connect: export parse_feature_value()
-:  ---------- > 6:  860860536e receive-pack: extension for server-side report
-:  ---------- > 7:  d1677b61d1 send-pack: extension for client-side status report
-:  ---------- > 8:  41159c2ef2 doc: add documentation for the proc-receive hook


Jiang Xin (8):
  transport: not report a non-head push as a branch
  receive-pack: add new proc-receive hook
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  connect: export parse_feature_value()
  receive-pack: extension for server-side report
  send-pack: extension for client-side status report
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt           |  14 +
 Documentation/githooks.txt                 |  58 ++
 Makefile                                   |   1 +
 builtin/receive-pack.c                     | 334 ++++++++-
 connect.c                                  |   3 +-
 connect.h                                  |   1 +
 refs.c                                     |  11 +-
 refs.h                                     |   1 +
 remote.c                                   |  28 +
 remote.h                                   |   3 +
 send-pack.c                                |  13 +-
 t/helper/test-proc-receive.c               | 178 +++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t5411-proc-receive-hook.sh               |  75 ++
 t/t5411/common-functions.sh                |  54 ++
 t/t5411/common-test-cases.sh               | 827 +++++++++++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh |  86 +++
 t/t5516-fetch-push.sh                      |   2 +-
 transport-helper.c                         |  66 +-
 transport.c                                |  42 +-
 21 files changed, 1745 insertions(+), 54 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/common-test-cases.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

