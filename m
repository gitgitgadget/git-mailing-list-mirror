Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0028DC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A2A2053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFlbPxeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgHOWFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgHOVux (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A347C0076D3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y6so5526718plt.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SProWpor+5BEFShV6mftJif4y68bBYu9BsP2ri+58AA=;
        b=mFlbPxeTgEby3W0qCPIYNStBVjFbI0NRTZeGlEDev1I4ngt/qQ8FSy99gn3LMdtj7n
         i7dmVD2rtz/f6ggg5o3aFiq2tDhc5poXt5IpaMBiXJ+U94UcpYMRwYUTB7upa/VgqcjJ
         X0lTyx03mlZiPhEymMkWkVU+U3158uP0uwGoukyVHwYWV8ndynU3ux36IChTVzzGPwuR
         eaKnDIGO6901BSm3kQ3A5uvYZlfiKdqgOsP+tQExrsJi2G605gKMZgT2IvslvTvu+gJV
         Pd/EfMJ65aR97LQWRl0ED2dc/1jcKROM7akWDe95iawy4ABW4Aseprc/Pugf3B4XE1sv
         e2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SProWpor+5BEFShV6mftJif4y68bBYu9BsP2ri+58AA=;
        b=SsnujzlU93ILXWMGtXT+ePe6W/Kc8SApt3AVoajaP7BmDjNKymC8ZXP/4y8eaQ5qjJ
         2TzRcrCb0RwJDknZvZaeQEGi3A0FmkD7A42mxoHrEMwnVl+AQ6ZNhWa/wfbkS9R7Q5P+
         guIJw7pTo0vc+1qPK1VUhtiNEbu4Bb8mMGW2R1qTaW7kzUaEGjZA8bUEWJuW0Ai5kgDf
         KsbtkpoA3ccAGQXe118rsUoCNJ7UC72W0dwQaSaoXiLadbLtwMtsP5e2iq0byjS63K8r
         VSGmxtiNfJ2G0m4QQ710MoFTD7/ZAPBcg6dNDZG3PtncKJ7RZ1O/dlEcmoGBg0xY+LVC
         0WLQ==
X-Gm-Message-State: AOAM533npbn6QIP5FPRs1kjQL6Uuj7BcZJZYX/ZvQEGCyKdwIspD++f1
        n1XU8yuIuA9U8SXVJlFZmuex7HWv81g=
X-Google-Smtp-Source: ABdhPJxyO2DLnnhsfFEq1L4b7By4rASKTalZ+aCQaa2aTcvahhTLDbTZIyiwaxgXWF039kT0tC7MbQ==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr6476328pju.177.1597511868677;
        Sat, 15 Aug 2020 10:17:48 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x13sm11040596pga.30.2020.08.15.10.17.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 10:17:47 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v17 00/10] New proc-receive hook for centralized workflow
Date:   Sat, 15 Aug 2020 13:17:30 -0400
Message-Id: <20200815171740.6257-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200518094039.757-1-worldhello.net@gmail.com>
References: <20200518094039.757-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

This topic introduces a new hook named "proc-receive" for
"receive-pack".  We can use this hook to implement a Gerrit-like
centralized workflow.

## Changes since v16

1. Fixes test helper for proc-receive which is not compatible with sha256.

   Run `setup_git_directory_gently()`  in `t/helper/test-proc-receive.c`,
   so that `the_repository` variable is initialized with proper hash_algo.

   See range-diff:

         3:  6ac2e0f88c !  3:  94d3053662 receive-pack: add new proc-receive hook
            @@ builtin/receive-pack.c: static void run_update_post_hook(struct command *command
             -		if (cmd->error_string || cmd->did_not_exist)
             +		if (cmd->report.error_message || cmd->did_not_exist)
              			continue;
            - 		if (!proc.args.argc)
            - 			argv_array_push(&proc.args, hook);
            + 		if (!proc.args.nr)
            + 			strvec_push(&proc.args, hook);
             @@ builtin/receive-pack.c: static void check_aliased_update_internal(struct command *cmd,
              	if (!dst_name) {
              		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
            @@ t/helper/test-proc-receive.c (new)
             +
             +int cmd__proc_receive(int argc, const char **argv)
             +{
            ++	int nongit_ok = 0;
             +	struct packet_reader reader;
             +	struct command *commands = NULL;
             +	struct string_list push_options = STRING_LIST_INIT_DUP;
            @@ t/helper/test-proc-receive.c (new)
             +		OPT_END()
             +	};
             +
            ++	setup_git_directory_gently(&nongit_ok);
            ++
             +	argc = parse_options(argc, argv, "test-tools", options, proc_receive_usage, 0);
             +	if (argc > 0)
             +		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
            -+
             +	packet_reader_init(&reader, 0, NULL, 0,
             +			   PACKET_READ_CHOMP_NEWLINE |
             +			   PACKET_READ_DIE_ON_ERR_PACKET);

2. Fixed broken test cases which is not compatible with sha256.

   Add capability "object-format=$GIT_DEFAULT_HASH" in
   "t/t5411/once-0010-report-status-v1.sh". See range-diff:

        4:  00c9eee210 !  4:  215d786adc New capability "report-status-v2" for git-push
           @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct obje
             			strbuf_addstr(&cap, " atomic");
             		if (prefer_ofs_delta)
            @@ builtin/receive-pack.c: static struct command *read_head_info(struct packet_reader *reader,
           - 			const char *feature_list = reader->line + linelen + 1;
           + 			int len = 0;
             			if (parse_feature_request(feature_list, "report-status"))
             				report_status = 1;
            +			if (parse_feature_request(feature_list, "report-status-v2"))
           @@ t/t5411/once-0010-report-status-v1.sh (new)
            +# git push         : (B)                   refs/for/master/topic1(A)  foo(A)  refs/for/next/topic(A)  refs/for/master/topic2(A)
            +test_expect_success "proc-receive: report status v1" '
            +	{
           -+		printf "%s %s refs/heads/master\0report-status\n" \
           -+			$A $B | packetize &&
           ++		if test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"
           ++		then
           ++			printf "%s %s refs/heads/master\0report-status\n" \
           ++				$A $B | packetize
           ++		else
           ++			printf "%s %s refs/heads/master\0report-status object-format=$GIT_DEFAULT_HASH\n" \
           ++				$A $B | packetize
           ++		fi &&
            +		printf "%s %s refs/for/master/topic1\n" \
            +			$ZERO_OID $A | packetize &&
            +		printf "%s %s refs/heads/foo\n" \

3. Add optional modifiers for config variable "receive.procReceiveRefs".
   See range-diff:

        7:  97704cbcc6 <  -:  ---------- refs.c: refactor to reuse ref_is_hidden()
        8:  415677f838 !  7:  08b176a61a receive-pack: new config receive.procReceiveRefs
           @@ Commit message
                    git config --system --add receive.procReceiveRefs refs/for
                    git config --system --add receive.procReceiveRefs refs/drafts
            
           -    If the specific prefix strings match the reference names of the commands
           -    which are sent from git client to `receive-pack`, these commands will be
           -    executed by an external hook (named "proc-receive"), instead of the
           -    internal `execute_commands` function.
           +    If the specific prefix strings given by the config variables match the
           +    reference names of the commands which are sent from git client to
           +    `receive-pack`, these commands will be executed by an external hook
           +    (named "proc-receive"), instead of the internal `execute_commands`
           +    function.
            
                For example, if it is set to "refs/for", pushing to a reference such as
                "refs/for/master" will not create or update reference "refs/for/master",
                but may create or update a pull request directly by running the hook
                "proc-receive".
            
           +    Optional modifiers can be provided in the beginning of value of the
           +    config variable to filter commands for specific actions: create (a),
           +    mofify (m), delete (d). E.g.:
           +
           +        git config --system --add receive.procReceiveRefs ad:refs/heads
           +
                Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
            
             ## Documentation/config/receive.txt ##
           @@ Documentation/config/receive.txt: receive.hideRefs::
            +	variable is not defined, the "proc-receive" hook will never be
            +	used, and all commands will be executed by the internal
            +	`execute_commands` function.
           -+
           -+	For example, if this variable is set to "refs/for", pushing to
           -+	reference such as "refs/for/master" will not create or update a
           -+	reference named "refs/for/master", but may create or update a
           -+	pull request directly by running the hook "proc-receive".
           -+
           +++
           ++For example, if this variable is set to "refs/for", pushing to reference
           ++such as "refs/for/master" will not create or update a reference named
           ++"refs/for/master", but may create or update a pull request directly by
           ++running the hook "proc-receive".
           +++
           ++Optional modifiers can be provided in the beginning of the value to filter
           ++commands for specific actions: create (a), mofify (m), delete (d). E.g.:
           +++
           ++	git config --system --add receive.procReceiveRefs ad:refs/heads
           ++ 
             receive.updateServerInfo::
             	If set to true, git-receive-pack will run git-update-server-info
             	after receiving data from git-push and updating refs.
            
             ## builtin/receive-pack.c ##
           -@@ builtin/receive-pack.c: static struct object_id push_cert_oid;
           - static struct signature_check sigcheck;
           - static const char *push_cert_nonce;
           - static const char *cert_nonce_seed;
           -+static struct string_list proc_receive_refs;
           +@@ builtin/receive-pack.c: static int keepalive_in_sec = 5;
             
           - static const char *NONCE_UNSOLICITED = "UNSOLICITED";
           - static const char *NONCE_BAD = "BAD";
           + static struct tmp_objdir *tmp_objdir;
           + 
           ++static struct proc_receive_ref {
           ++	unsigned int want_add:1,
           ++		     want_delete:1,
           ++		     want_modify:1;
           ++	char *ref_prefix;
           ++	struct proc_receive_ref *next;
           ++} *proc_receive_ref = NULL;
           ++
           ++static void proc_receive_ref_append(const char *prefix);
           ++
           + static enum deny_action parse_deny_action(const char *var, const char *value)
           + {
           + 	if (value) {
            @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const char *value, void *cb)
             		return 0;
             	}
             
            +	if (strcmp(var, "receive.procreceiverefs") == 0) {
           -+		char *prefix;
           -+		int len;
           -+
            +		if (!value)
            +			return config_error_nonbool(var);
           -+		prefix = xstrdup(value);
           -+		len = strlen(prefix);
           -+		while (len && prefix[len - 1] == '/')
           -+			prefix[--len] = '\0';
           -+		string_list_append(&proc_receive_refs, prefix);
           ++		proc_receive_ref_append(value);
            +		return 0;
            +	}
            +
             	return git_default_config(var, value, cb);
             }
             
           +@@ builtin/receive-pack.c: struct command {
           + 	char ref_name[FLEX_ARRAY]; /* more */
           + };
           + 
           ++static void proc_receive_ref_append(const char *prefix)
           ++{
           ++	struct proc_receive_ref *ref_pattern;
           ++	char *p;
           ++	int len;
           ++
           ++	ref_pattern = xcalloc(1, sizeof(struct proc_receive_ref));
           ++	p = strchr(prefix, ':');
           ++	if (p) {
           ++		while (prefix < p) {
           ++			if (*prefix == 'a')
           ++				ref_pattern->want_add = 1;
           ++			else if (*prefix == 'd')
           ++				ref_pattern->want_delete = 1;
           ++			else if (*prefix == 'm')
           ++				ref_pattern->want_modify = 1;
           ++			prefix++;
           ++		}
           ++		prefix++;
           ++	} else {
           ++		ref_pattern->want_add = 1;
           ++		ref_pattern->want_delete = 1;
           ++		ref_pattern->want_modify = 1;
           ++	}
           ++	ref_pattern->next = NULL;
           ++	ref_pattern->ref_prefix = xstrdup(prefix);
           ++	len = strlen(ref_pattern->ref_prefix);
           ++	while (len && ref_pattern->ref_prefix[len - 1] == '/')
           ++		ref_pattern->ref_prefix[--len] = '\0';
           ++	if (proc_receive_ref == NULL) {
           ++		proc_receive_ref = ref_pattern;
           ++	} else {
           ++		struct proc_receive_ref *end;
           ++
           ++		end = proc_receive_ref;
           ++		while (end->next)
           ++			end = end->next;
           ++		end->next = ref_pattern;
           ++	}
           ++}
           ++
           ++static int proc_receive_ref_matches(struct command *cmd)
           ++{
           ++	struct proc_receive_ref *p;
           ++
           ++	if (!proc_receive_ref)
           ++		return 0;
           ++
           ++	for (p = proc_receive_ref; p; p = p->next) {
           ++		const char *match = p->ref_prefix;
           ++		int neg = 0;
           ++		const char *remains;
           ++
           ++		if (!p->want_add && is_null_oid(&cmd->old_oid))
           ++			continue;
           ++		else if (!p->want_delete && is_null_oid(&cmd->new_oid))
           ++			continue;
           ++		else if (!p->want_modify &&
           ++			 !is_null_oid(&cmd->old_oid) &&
           ++			 !is_null_oid(&cmd->new_oid))
           ++			continue;
           ++
           ++		if (*match == '!') {
           ++			neg = 1;
           ++			match++;
           ++		}
           ++
           ++		if (skip_prefix(cmd->ref_name, match, &remains) &&
           ++		    (!*remains || *remains == '/')) {
           ++			if (!neg)
           ++				return 1;
           ++		} else if (neg) {
           ++			return 1;
           ++		}
           ++	}
           ++	return 0;
           ++}
           ++
           + static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
           + static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
           + 
            @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
             	 * Try to find commands that have special prefix in their reference names,
             	 * and mark them to run an external "proc-receive" hook later.
           @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
            -	for (cmd = commands; cmd; cmd = cmd->next) {
            -		if (!should_process_cmd(cmd))
            -			continue;
           -+	if (proc_receive_refs.nr > 0) {
           -+		struct strbuf refname_full = STRBUF_INIT;
           -+		size_t prefix_len;
           -+
           -+		strbuf_addstr(&refname_full, get_git_namespace());
           -+		prefix_len = refname_full.len;
           ++	if (proc_receive_ref) {
           ++		for (cmd = commands; cmd; cmd = cmd->next) {
           ++			if (!should_process_cmd(cmd))
           ++				continue;
             
            -		/* TODO: replace the fixed prefix by looking up git config variables. */
            -		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
            -			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
            -			run_proc_receive = 1;
           -+		for (cmd = commands; cmd; cmd = cmd->next) {
           -+			if (!should_process_cmd(cmd))
           -+				continue;
           -+
           -+			strbuf_setlen(&refname_full, prefix_len);
           -+			strbuf_addstr(&refname_full, cmd->ref_name);
           -+			if (ref_matches(&proc_receive_refs, cmd->ref_name, refname_full.buf)) {
           ++			if (proc_receive_ref_matches(cmd)) {
            +				cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
            +				run_proc_receive = 1;
            +			}
             		}
           -+
           -+		strbuf_release(&refname_full);
             	}
             
           - 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
           -@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
           - 		OPT_END()
           - 	};
           - 
           -+	string_list_init(&proc_receive_refs, 0);
           -+
           - 	packet_trace_identity("receive-pack");
           - 
           - 	argc = parse_options(argc, argv, prefix, options, receive_pack_usage, 0);
           -@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
           - 	oid_array_clear(&shallow);
           - 	oid_array_clear(&ref);
           - 	free((void *)push_cert_nonce);
           -+	string_list_clear(&proc_receive_refs, 0);
           - 	return 0;
           - }
            
             ## t/t5411/once-0010-report-status-v1.sh ##
            @@
           @@ t/t5411/test-0041-process-all-refs--porcelain.sh (new)
            +		git update-ref -d refs/heads/baz
            +	)
            +'
           +
           + ## t/t5411/test-0050-proc-receive-refs.sh (new) ##
           +@@
           ++test_expect_success "config receive.procReceiveRefs with modifiers ($PROTOCOL)" '
           ++	(
           ++		cd "$upstream" &&
           ++		git config --unset-all receive.procReceiveRefs &&
           ++		git config --add receive.procReceiveRefs m:refs/heads/master &&
           ++		git config --add receive.procReceiveRefs ad:refs/heads &&
           ++		git config --add receive.procReceiveRefs "a:!refs/heads"
           ++	)
           ++'
           ++
           ++test_expect_success "setup proc-receive hook ($PROTOCOL)" '
           ++	write_script "$upstream/hooks/proc-receive" <<-EOF
           ++	printf >&2 "# proc-receive hook\n"
           ++	test-tool proc-receive -v \
           ++		-r "ok refs/heads/master" \
           ++		-r "option refname refs/pull/123/head" \
           ++		-r "option old-oid $A" \
           ++		-r "option new-oid $B" \
           ++		-r "ok refs/tags/v123 " \
           ++		-r "option refname refs/pull/124/head"
           ++	EOF
           ++'
           ++
           ++# Refs of upstream : master(A)
           ++# Refs of workbench: master(A)  tags/v123
           ++# git push         : master(B)  tags/v123
           ++test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
           ++	git -C workbench push origin \
           ++		$B:refs/heads/master \
           ++		v123 >out 2>&1 &&
           ++	make_user_friendly_and_stable_output <out >actual &&
           ++	cat >expect <<-EOF &&
           ++	remote: # pre-receive hook
           ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
           ++	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
           ++	remote: # proc-receive hook
           ++	remote: proc-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
           ++	remote: proc-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
           ++	remote: proc-receive> ok refs/heads/master
           ++	remote: proc-receive> option refname refs/pull/123/head
           ++	remote: proc-receive> option old-oid <COMMIT-A>
           ++	remote: proc-receive> option new-oid <COMMIT-B>
           ++	remote: proc-receive> ok refs/tags/v123
           ++	remote: proc-receive> option refname refs/pull/124/head
           ++	remote: # post-receive hook
           ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
           ++	remote: post-receive< <ZERO-OID> <TAG-v123> refs/pull/124/head
           ++	To <URL/of/upstream.git>
           ++	 <OID-A>..<OID-B> <COMMIT-B> -> refs/pull/123/head
           ++	 * [new reference] v123 -> refs/pull/124/head
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
           ++# Refs of upstream : master(A)
           ++# Refs of workbench: master(A)  tags/v123
           ++test_expect_success "setup upstream: create tags/v123 ($PROTOCOL)" '
           ++	git -C "$upstream" update-ref refs/tags/v123 $TAG &&
           ++	git -C "$upstream" show-ref >out &&
           ++	make_user_friendly_and_stable_output <out >actual &&
           ++	cat >expect <<-EOF &&
           ++	<COMMIT-A> refs/heads/master
           ++	<TAG-v123> refs/tags/v123
           ++	EOF
           ++	test_cmp expect actual
           ++'
           ++
           ++test_expect_success "setup proc-receive hook ($PROTOCOL)" '
           ++	write_script "$upstream/hooks/proc-receive" <<-EOF
           ++	printf >&2 "# proc-receive hook\n"
           ++	test-tool proc-receive -v \
           ++		-r "ok refs/heads/master" \
           ++		-r "option refname refs/pull/123/head" \
           ++		-r "option old-oid $A" \
           ++		-r "option new-oid $ZERO_OID" \
           ++		-r "ok refs/heads/next" \
           ++		-r "option refname refs/pull/124/head" \
           ++		-r "option new-oid $A"
           ++	EOF
           ++'
           ++
           ++# Refs of upstream : master(A)  tags/v123
           ++# Refs of workbench: master(A)  tags/v123
           ++# git push         : NULL       NULL       next(A)
           ++test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOCOL)" '
           ++	git -C workbench push origin \
           ++		:refs/heads/master \
           ++		$A:refs/heads/next \
           ++		:refs/tags/v123 >out 2>&1 &&
           ++	make_user_friendly_and_stable_output <out >actual &&
           ++	cat >expect <<-EOF &&
           ++	remote: # pre-receive hook
           ++	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
           ++	remote: pre-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
           ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
           ++	remote: # proc-receive hook
           ++	remote: proc-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
           ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
           ++	remote: proc-receive> ok refs/heads/master
           ++	remote: proc-receive> option refname refs/pull/123/head
           ++	remote: proc-receive> option old-oid <COMMIT-A>
           ++	remote: proc-receive> option new-oid <ZERO-OID>
           ++	remote: proc-receive> ok refs/heads/next
           ++	remote: proc-receive> option refname refs/pull/124/head
           ++	remote: proc-receive> option new-oid <COMMIT-A>
           ++	remote: # post-receive hook
           ++	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/pull/123/head
           ++	remote: post-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
           ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head
           ++	To <URL/of/upstream.git>
           ++	 - [deleted] refs/pull/123/head
           ++	 - [deleted] v123
           ++	 * [new reference] <COMMIT-A> -> refs/pull/124/head
           ++	EOF
           ++	test_cmp expect actual &&
           ++	git -C "$upstream" show-ref >out &&
           ++	make_user_friendly_and_stable_output <out >actual &&
           ++	cat >expect <<-EOF &&
           ++	<COMMIT-A> refs/heads/master
           ++	EOF
           ++	test_cmp expect actual
           ++'

---

Jiang Xin (10):
  transport: not report a non-head push as a branch
  t5411: add basic test cases for proc-receive hook
  receive-pack: add new proc-receive hook
  New capability "report-status-v2" for git-push
  doc: add document for capability report-status-v2
  receive-pack: feed report options to post-receive
  receive-pack: new config receive.procReceiveRefs
  t5411: test updates of remote-tracking branches
  transport: parse report options for tracking refs
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt              |  19 +
 Documentation/githooks.txt                    |  62 ++
 Documentation/technical/pack-protocol.txt     |  43 +-
 .../technical/protocol-capabilities.txt       |  17 +-
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 528 ++++++++++++++++--
 builtin/send-pack.c                           |  21 +-
 remote.c                                      |   4 +-
 remote.h                                      |  16 +-
 send-pack.c                                   |  99 +++-
 t/helper/test-proc-receive.c                  | 176 ++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411-proc-receive-hook.sh                  | 117 ++++
 t/t5411/common-functions.sh                   |  56 ++
 t/t5411/once-0010-report-status-v1.sh         |  94 ++++
 t/t5411/test-0000-standard-git-push.sh        | 143 +++++
 .../test-0001-standard-git-push--porcelain.sh | 147 +++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0011-no-hook-error.sh            |  64 +++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 +++
 t/t5411/test-0013-bad-protocol.sh             | 217 +++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 160 ++++++
 t/t5411/test-0020-report-ng.sh                |  67 +++
 t/t5411/test-0021-report-ng--porcelain.sh     |  69 +++
 t/t5411/test-0022-report-unexpect-ref.sh      |  45 ++
 ...est-0023-report-unexpect-ref--porcelain.sh |  46 ++
 t/t5411/test-0024-report-unknown-ref.sh       |  34 ++
 ...test-0025-report-unknown-ref--porcelain.sh |  35 ++
 t/t5411/test-0026-push-options.sh             |  79 +++
 t/t5411/test-0027-push-options--porcelain.sh  |  82 +++
 t/t5411/test-0030-report-ok.sh                |  35 ++
 t/t5411/test-0031-report-ok--porcelain.sh     |  36 ++
 t/t5411/test-0032-report-with-options.sh      | 256 +++++++++
 ...est-0033-report-with-options--porcelain.sh | 265 +++++++++
 t/t5411/test-0034-report-ft.sh                |  44 ++
 t/t5411/test-0035-report-ft--porcelain.sh     |  45 ++
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 227 ++++++++
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 172 ++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  89 +++
 .../test-0039-report-mixed-refs--porcelain.sh |  91 +++
 t/t5411/test-0040-process-all-refs.sh         | 113 ++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 ++++
 t/t5411/test-0050-proc-receive-refs.sh        | 128 +++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport-helper.c                            |  53 +-
 transport.c                                   | 161 ++++--
 49 files changed, 4307 insertions(+), 107 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/once-0010-report-status-v1.sh
 create mode 100644 t/t5411/test-0000-standard-git-push.sh
 create mode 100644 t/t5411/test-0001-standard-git-push--porcelain.sh
 create mode 100644 t/t5411/test-0002-pre-receive-declined.sh
 create mode 100644 t/t5411/test-0003-pre-receive-declined--porcelain.sh
 create mode 100644 t/t5411/test-0010-proc-receive-settings.sh
 create mode 100644 t/t5411/test-0011-no-hook-error.sh
 create mode 100644 t/t5411/test-0012-no-hook-error--porcelain.sh
 create mode 100644 t/t5411/test-0013-bad-protocol.sh
 create mode 100644 t/t5411/test-0014-bad-protocol--porcelain.sh
 create mode 100644 t/t5411/test-0020-report-ng.sh
 create mode 100644 t/t5411/test-0021-report-ng--porcelain.sh
 create mode 100644 t/t5411/test-0022-report-unexpect-ref.sh
 create mode 100644 t/t5411/test-0023-report-unexpect-ref--porcelain.sh
 create mode 100644 t/t5411/test-0024-report-unknown-ref.sh
 create mode 100644 t/t5411/test-0025-report-unknown-ref--porcelain.sh
 create mode 100644 t/t5411/test-0026-push-options.sh
 create mode 100644 t/t5411/test-0027-push-options--porcelain.sh
 create mode 100644 t/t5411/test-0030-report-ok.sh
 create mode 100644 t/t5411/test-0031-report-ok--porcelain.sh
 create mode 100644 t/t5411/test-0032-report-with-options.sh
 create mode 100644 t/t5411/test-0033-report-with-options--porcelain.sh
 create mode 100644 t/t5411/test-0034-report-ft.sh
 create mode 100644 t/t5411/test-0035-report-ft--porcelain.sh
 create mode 100644 t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
 create mode 100644 t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
 create mode 100644 t/t5411/test-0038-report-mixed-refs.sh
 create mode 100644 t/t5411/test-0039-report-mixed-refs--porcelain.sh
 create mode 100644 t/t5411/test-0040-process-all-refs.sh
 create mode 100644 t/t5411/test-0041-process-all-refs--porcelain.sh
 create mode 100644 t/t5411/test-0050-proc-receive-refs.sh

-- 
2.28.0

