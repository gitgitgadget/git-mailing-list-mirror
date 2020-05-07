Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DEBC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DEF208DB
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLr0un1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEGQLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbgEGQLG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 12:11:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F7C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 09:11:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d184so3222735pfd.4
        for <git@vger.kernel.org>; Thu, 07 May 2020 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqoQxSSu1pbYpLx+Ni3I/NmKCfTV+5yPJ2B6cucQe8Y=;
        b=WLr0un1S18mOmJ+owtJaSaKMIWyTh3jqNhd+Zx0oMLTwi2KoGC06gg3cbpKw6vI98M
         qWgybyBK5i5LWcccBs2gXGLQF4IA1kEFj+o2EeEa4g8rIacuMzvhpLveQUg8DxHpkCe2
         Baw+Pmh9/NFIbGv11WHZLg7pcd3t5cDFcz35S5ChR7DUk3GUV6ZIlNKrSaOUksfigD7m
         m1X+kgoIjAIjsq97H7r0kfohwAJVWc9uNomsjhr59fzXBnsP5+QOCaJKigGCBbED53Hy
         54vgP0iLkdURj/BHpzgp2hdyormF02nSR/wbViKJ/VYALsxRLqsGBotprP5EEjZhPSba
         vWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqoQxSSu1pbYpLx+Ni3I/NmKCfTV+5yPJ2B6cucQe8Y=;
        b=Nr4kX76CX4HdZmWCKrgGDkzsm+vuPAE51TDZ+PBRC+1orXAko6WXDW6Iqd50e2u1hn
         QrAtvAcC6E0thrwmNzqvT1DAZn5+HpVPKLpuy7p/yX2AZkTNyu/AeGciIXmLLmQRrGZY
         z+TpiA5Ki8oMTonzDnLLFgANANzRrMBA3oHsCHrB07WcbCoDqgVWYTE0b9uWE9C2y2+R
         RFMh7UBaaQBDIh8ok1WzeceT0lsyhsaVBxzihH4d4f43+JEk5XikHuCMpXRh/KuOvukZ
         QA0cWi0Fn3N6Zc9n9ER4QzG4YoH9JeI1VcU7Aen7kVP2/aqe21/TghmvNVYIW2iIliIU
         aGqQ==
X-Gm-Message-State: AGi0Pua64frJ2Dr2J+2n6Xc2hWmaPtEX3EysWbushPfKEmvOx6+A0ajn
        TbYM8D9LMCtUg54vGYtKZqs=
X-Google-Smtp-Source: APiQypIQEmRwP6gpcD78KuNIKQjU8NA1Es7LFSwnEq6vYy5drEjdq0G/ScIpwwWV1pmonka0uSOQpA==
X-Received: by 2002:a63:4f0e:: with SMTP id d14mr11918138pgb.445.1588867864619;
        Thu, 07 May 2020 09:11:04 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id gq6sm238800pjb.54.2020.05.07.09.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 09:11:03 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v15 0/7] New proc-receive hook for centralized workflow
Date:   Thu,  7 May 2020 12:10:50 -0400
Message-Id: <20200507161057.12690-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
References: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
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

## Changes since v14

1. Fixed broken test case in patch 2/7, and all test cases passed.
   See: https://github.com/jiangxin/git/runs/653492851

2. Bugfix: if "proc-receive" report a "ng" status, other successfully
   updated references will be reported as failure.  Fixed in patch 2/7.

3. Add test case for report status v1 in "t5411/once-0010" in patch 3/7.

## Range-diff v14...v15

1:  805db643dd ! 1:  06dd984d35 transport: not report a non-head push as a branch
    @@ t/t5411-proc-receive-hook.sh (new)
     +			git remote add origin ../upstream.git &&
     +			git update-ref refs/heads/master $A &&
     +			git tag -m "v123" v123 $A &&
    -+			git push origin $A:refs/heads/master
    ++			git push origin $B:refs/heads/master &&
    ++			git -C ../upstream.git update-ref \
    ++				refs/heads/master $A
     +		) &&
     +		TAG=$(git -C workbench rev-parse v123) &&
     +
    @@ t/t5411-proc-receive-hook.sh (new)
     +		PROTOCOL="HTTP protocol"  +		URL_PREFIX="http://.*"
     +		;;
    -+	file | local)
    ++	local)
     +		PROTOCOL="builtin protocol"
     +		URL_PREFIX="\.\."
     +		;;
2:  d6db85a4e5 ! 2:  1c11a5dcc6 receive-pack: add new proc-receive hook
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +	if (run_proc_receive &&
     +	    run_proc_receive_hook(commands, push_options))
     +		for (cmd = commands; cmd; cmd = cmd->next)
    -+			if (!cmd->report.error_message  && (cmd->run_proc_receive || use_atomic))
    ++			if (!cmd->report.error_message &&
    ++			    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED) &&
    ++			    (cmd->run_proc_receive || use_atomic))
     +				cmd->report.error_message = "fail to run proc-receive hook";
     +
      	if (use_atomic)
    @@ t/t5411/test-0013-bad-protocol.sh (new)
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +
    -+	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: fatal: protocol error: expected "old new ref", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    -+	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
    -+	EOF
    -+	test_cmp expect actual &&
    ++	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
     +
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
    @@ t/t5411/test-0038-report-mixed-refs.sh (new)
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ok refs/for/next/topic" \
    ++		-r "ok refs/for/next/topic2" \
    ++		-r "ng refs/for/next/topic1 fail to call Web API" \
     +		-r "ok refs/for/master/topic" \
     +		-r "option refname refs/for/master/topic" \
     +		-r "option old-oid $A" \
    @@ t/t5411/test-0038-report-mixed-refs.sh (new)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
     +test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
    -+	git -C workbench push origin \
    ++	test_must_fail git -C workbench push origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/heads/bar \
     +		HEAD:refs/heads/baz \
    -+		HEAD:refs/for/next/topic \
    ++		HEAD:refs/for/next/topic2 \
    ++		HEAD:refs/for/next/topic1 \
     +		HEAD:refs/heads/foo \
     +		HEAD:refs/for/master/topic \
    ++		HEAD:refs/for/next/topic3 \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0038-report-mixed-refs.sh (new)
     +	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
     +	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
    ++	remote: proc-receive> ok refs/for/next/topic2
    ++	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
     +	remote: proc-receive> ok refs/for/master/topic
     +	remote: proc-receive> option refname refs/for/master/topic
     +	remote: proc-receive> option old-oid <COMMIT-A>
    @@ t/t5411/test-0038-report-mixed-refs.sh (new)
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 <OID-A>..<OID-B> <COMMIT-B> -> master
     +	 * [new branch] HEAD -> bar
     +	 * [new branch] HEAD -> baz
    -+	 * [new reference] HEAD -> refs/for/next/topic
    ++	 * [new reference] HEAD -> refs/for/next/topic2
     +	 * [new branch] HEAD -> foo
     +	 * [new reference] HEAD -> refs/for/master/topic
    ++	 ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
    ++	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual &&
     +	git -C "$upstream" show-ref >out &&
    @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh (new)
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ok refs/for/next/topic" \
    ++		-r "ok refs/for/next/topic2" \
    ++		-r "ng refs/for/next/topic1 fail to call Web API" \
     +		-r "ok refs/for/master/topic" \
     +		-r "option refname refs/for/master/topic" \
     +		-r "option old-oid $A" \
    @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh (new)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
     +test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcelain)" '
    -+	git -C workbench push --porcelain origin \
    ++	test_must_fail git -C workbench push --porcelain origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/heads/bar \
     +		HEAD:refs/heads/baz \
    -+		HEAD:refs/for/next/topic \
    ++		HEAD:refs/for/next/topic2 \
    ++		HEAD:refs/for/next/topic1 \
     +		HEAD:refs/heads/foo \
     +		HEAD:refs/for/master/topic \
    ++		HEAD:refs/for/next/topic3 \
     +		>out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
    @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh (new)
     +	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
     +	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic1
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic3
    ++	remote: proc-receive> ok refs/for/next/topic2
    ++	remote: proc-receive> ng refs/for/next/topic1 fail to call Web API
     +	remote: proc-receive> ok refs/for/master/topic
     +	remote: proc-receive> option refname refs/for/master/topic
     +	remote: proc-receive> option old-oid <COMMIT-A>
    @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh (new)
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
     +	*    HEAD:refs/heads/bar    [new branch]
     +	*    HEAD:refs/heads/baz    [new branch]
    -+	*    HEAD:refs/for/next/topic    [new reference]
    ++	*    HEAD:refs/for/next/topic2    [new reference]
     +	*    HEAD:refs/heads/foo    [new branch]
     +	*    HEAD:refs/for/master/topic    [new reference]
    ++	!    HEAD:refs/for/next/topic1    [remote rejected] (fail to call Web API)
    ++	!    HEAD:refs/for/next/topic3    [remote rejected] (proc-receive failed to report status)
     +	Done
     +	EOF
     +	test_cmp expect actual &&
3:  342254d81d ! 3:  c7f731b9f6 New capability "report-status-v2" for git-push
    @@ remote.c: void free_one_ref(struct ref *ref)
      	free(ref->symref);
      	free(ref);
      }
    -@@ remote.c: void apply_push_cas(struct push_cas_option *cas,
    - 	struct ref *ref;
    - 	for (ref = remote_refs; ref; ref = ref->next)
    - 		apply_cas(cas, remote, ref);
    --}
    -+}
    - \ No newline at end of file
     
      ## remote.h ##
     @@ remote.h: struct ref {
    @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref
      		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
      			break;
     -		if (!starts_with(reader->line, "ok ") && !starts_with(reader->line, "ng ")) {
    +-			error("invalid ref status from remote: %s", reader->line);
     +		head = reader->line;
     +		p = strchr(head, ' ');
     +		if (!p) {
    - 			error("invalid ref status from remote: %s", reader->line);
    ++			error("invalid status line from remote: %s", reader->line);
      			ret = -1;
      			break;
      		}
    @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref
     -		msg = strchr(refname, ' ');
     -		if (msg)
     -			*msg++ = '\0';
    -+		refname = p;
    -+		p = strchr(refname, ' ');
    -+		if (p)
    -+			*p++ = '\0';
    +-
     +		if (strcmp(head, "ok") && strcmp(head, "ng")) {
    -+			error("invalid ref status from remote: %s", reader->line);
    ++			error("invalid ref status from remote: %s", head);
     +			ret = -1;
     +			break;
     +		}
    - 
    ++		refname = p;
    ++		p = strchr(refname, ' ');
    ++		if (p)
    ++			*p++ = '\0';
      		/* first try searching at our hint, falling back to all refs */
      		if (hint)
    + 			hint = find_ref_by_name(hint, refname);
     @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref *refs)
      					refname);
      			continue;
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      		strbuf_addstr(&cap_buf, " side-band-64k");
      	if (quiet_supported && (args->quiet || !args->progress))
     
    + ## t/t5411-proc-receive-hook.sh ##
    +@@ t/t5411-proc-receive-hook.sh: run_proc_receive_hook_test() {
    + # Initialize the upstream repository and local workbench.
    + setup_upstream_and_workbench
    + 
    ++# Load test cases that only need to be executed once.
    ++for t in  "$TEST_DIRECTORY"/t5411/once-*.sh
    ++do
    ++	. "$t"
    ++done
    ++
    + # Run test cases for 'proc-receive' hook on local file protocol.
    + run_proc_receive_hook_test local
    + 
    +
    + ## t/t5411/once-0010-report-status-v1.sh (new) ##
    +@@
    ++test_expect_success "setup proc-receive hook" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "ok refs/for/master/topic1" \
    ++		-r "option fall-through" \
    ++		-r "ok refs/for/master/topic2" \
    ++		-r "option refname refs/for/changes/23/123/1" \
    ++		-r "option new-oid $A" \
    ++		-r "ok refs/for/master/topic2" \
    ++		-r "option refname refs/for/changes/24/124/2" \
    ++		-r "option old-oid $B" \
    ++		-r "option new-oid $A" \
    ++		-r "option forced-update" \
    ++		-r "ng refs/for/next/topic target branch not exist"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         : (B)                   refs/for/master/topic1(A)  foo(A)  refs/for/next/topic(A)  refs/for/master/topic2(A)
    ++test_expect_success "proc-receive: report status v1" '
    ++	{
    ++		printf "%s %s refs/heads/master\0report-status\n" \
    ++			$A $B | packetize &&
    ++		printf "%s %s refs/for/master/topic1\n" \
    ++			$ZERO_OID $A | packetize &&
    ++		printf "%s %s refs/heads/foo\n" \
    ++			$ZERO_OID $A | packetize &&
    ++		printf "%s %s refs/for/next/topic\n" \
    ++			$ZERO_OID $A | packetize &&
    ++		printf "%s %s refs/for/master/topic2\n" \
    ++			$ZERO_OID $A | packetize &&
    ++		printf 0000 &&
    ++		printf "" | git -C "$upstream" pack-objects --stdout
    ++	} | git receive-pack "$upstream" --stateless-rpc \
    ++	>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	# pre-receive hook
    ++	pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
    ++	pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
    ++	# proc-receive hook
    ++	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
    ++	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    ++	proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
    ++	proc-receive> ok refs/for/master/topic1
    ++	proc-receive> option fall-through
    ++	proc-receive> ok refs/for/master/topic2
    ++	proc-receive> option refname refs/for/changes/23/123/1
    ++	proc-receive> option new-oid <COMMIT-A>
    ++	proc-receive> ok refs/for/master/topic2
    ++	proc-receive> option refname refs/for/changes/24/124/2
    ++	proc-receive> option old-oid <COMMIT-B>
    ++	proc-receive> option new-oid <COMMIT-A>
    ++	proc-receive> option forced-update
    ++	proc-receive> ng refs/for/next/topic target branch not exist
    ++	000eunpack ok
    ++	0019ok refs/heads/master
    ++	001eok refs/for/master/topic1
    ++	0016ok refs/heads/foo
    ++	0033ng refs/for/next/topic target branch not exist
    ++	001eok refs/for/master/topic2
    ++	0000# post-receive hook
    ++	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    ++	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
    ++	post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    ++	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	git -C "$upstream" show-ref >out &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	<COMMIT-A> refs/for/master/topic1
    ++	<COMMIT-A> refs/heads/foo
    ++	<COMMIT-B> refs/heads/master
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++# Refs of upstream : master(B)             foo(A)  refs/for/master/topic1(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++test_expect_success "cleanup" '
    ++	(
    ++		cd "$upstream" &&
    ++		rm -f "hooks/proc-receive" &&
    ++		git update-ref refs/heads/master $A &&
    ++		git update-ref -d refs/for/master/topic1 &&
    ++		git update-ref -d refs/heads/foo
    ++	)
    ++'
    +
      ## t/t5411/test-0032-report-with-options.sh ##
     @@ t/t5411/test-0032-report-with-options.sh: test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
      	remote: # post-receive hook
    @@ t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh: test_expect_su
      ## t/t5411/test-0038-report-mixed-refs.sh ##
     @@ t/t5411/test-0038-report-mixed-refs.sh: test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
      	 * [new branch] HEAD -> baz
    - 	 * [new reference] HEAD -> refs/for/next/topic
    + 	 * [new reference] HEAD -> refs/for/next/topic2
      	 * [new branch] HEAD -> foo
     -	 * [new reference] HEAD -> refs/for/master/topic
     +	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
    + 	 ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
    + 	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
      	EOF
    - 	test_cmp expect actual &&
    - 	git -C "$upstream" show-ref >out &&
     
      ## t/t5411/test-0039-report-mixed-refs--porcelain.sh ##
     @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh: test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
      	*    HEAD:refs/heads/baz    [new branch]
    - 	*    HEAD:refs/for/next/topic    [new reference]
    + 	*    HEAD:refs/for/next/topic2    [new reference]
      	*    HEAD:refs/heads/foo    [new branch]
     -	*    HEAD:refs/for/master/topic    [new reference]
     +	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
    + 	!    HEAD:refs/for/next/topic1    [remote rejected] (fail to call Web API)
    + 	!    HEAD:refs/for/next/topic3    [remote rejected] (proc-receive failed to report status)
      	Done
    - 	EOF
    - 	test_cmp expect actual &&
     
      ## transport-helper.c ##
     @@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
4:  5c9b732a38 ! 4:  11b917121f receive-pack: feed report options to post-receive
    @@ builtin/receive-pack.c: static int feed_receive_hook(void *state_, const char **
      		*bufp = state->buf.buf;
      		*sizep = state->buf.len;
     
    + ## t/t5411/once-0010-report-status-v1.sh ##
    +@@ t/t5411/once-0010-report-status-v1.sh: test_expect_success "proc-receive: report status v1" '
    + 	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    + 	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
    + 	post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    +-	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
    ++	post-receive< <ZERO-OID> <COMMIT-A> refs/for/changes/23/123/1
    ++	post-receive< <COMMIT-B> <COMMIT-A> refs/for/changes/24/124/2
    + 	EOF
    + 	test_cmp expect actual &&
    + 
    +
      ## t/t5411/test-0032-report-with-options.sh ##
     @@ t/t5411/test-0032-report-with-options.sh: test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
      	remote: proc-receive> ok refs/for/master/topic
    @@ t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh: test_expect_su
      ## t/t5411/test-0038-report-mixed-refs.sh ##
     @@ t/t5411/test-0038-report-mixed-refs.sh: test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    - 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     -	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
    @@ t/t5411/test-0038-report-mixed-refs.sh: test_expect_success "proc-receive: repor
      ## t/t5411/test-0039-report-mixed-refs--porcelain.sh ##
     @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh: test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
    - 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
     -	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
5:  cf0774127f = 5:  7b84236103 refs.c: refactor to reuse ref_is_hidden()
6:  8053b06b09 ! 6:  9d9032285b receive-pack: new config receive.procReceiveRefs
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const
      	return 0;
      }
     
    + ## t/t5411/once-0010-report-status-v1.sh ##
    +@@
    ++test_expect_success "setup receive.procReceiveRefs" '
    ++	git -C "$upstream" config --add receive.procReceiveRefs refs/for
    ++'
    ++
    + test_expect_success "setup proc-receive hook" '
    + 	write_script "$upstream/hooks/proc-receive" <<-EOF
    + 	printf >&2 "# proc-receive hook\n"
    +@@ t/t5411/once-0010-report-status-v1.sh: test_expect_success "proc-receive: report status v1" '
    + test_expect_success "cleanup" '
    + 	(
    + 		cd "$upstream" &&
    ++		git config --unset receive.procReceiveRefs &&
    + 		rm -f "hooks/proc-receive" &&
    + 		git update-ref refs/heads/master $A &&
    + 		git update-ref -d refs/for/master/topic1 &&
    +
      ## t/t5411/test-0010-proc-receive-settings.sh (new) ##
     @@
     +test_expect_success "add two receive.procReceiveRefs settings" '
7:  861b21d471 = 7:  1a3f58652d doc: add documentation for the proc-receive hook

----

Jiang Xin (7):
  transport: not report a non-head push as a branch
  receive-pack: add new proc-receive hook
  New capability "report-status-v2" for git-push
  receive-pack: feed report options to post-receive
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt              |  14 +
 Documentation/githooks.txt                    |  62 +++
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 461 ++++++++++++++++--
 builtin/send-pack.c                           |  21 +-
 refs.c                                        |  13 +-
 refs.h                                        |   1 +
 remote.c                                      |   5 +-
 remote.h                                      |  16 +-
 send-pack.c                                   |  98 +++-
 t/helper/test-proc-receive.c                  | 175 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411-proc-receive-hook.sh                  | 114 +++++
 t/t5411/common-functions.sh                   |  56 +++
 t/t5411/once-0010-report-status-v1.sh         | 101 ++++
 t/t5411/test-0000-standard-git-push.sh        |  84 ++++
 .../test-0001-standard-git-push--porcelain.sh |  86 ++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0011-no-hook-error.sh            |  64 +++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 +++
 t/t5411/test-0013-bad-protocol.sh             | 217 +++++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 160 ++++++
 t/t5411/test-0020-report-ng.sh                |  67 +++
 t/t5411/test-0021-report-ng--porcelain.sh     |  69 +++
 t/t5411/test-0022-report-unexpect-ref.sh      |  45 ++
 ...est-0023-report-unexpect-ref--porcelain.sh |  46 ++
 t/t5411/test-0024-report-unknown-ref.sh       |  34 ++
 ...test-0025-report-unknown-ref--porcelain.sh |  35 ++
 t/t5411/test-0026-push-options.sh             |  79 +++
 t/t5411/test-0027-push-options--porcelain.sh  |  82 ++++
 t/t5411/test-0030-report-ok.sh                |  35 ++
 t/t5411/test-0031-report-ok--porcelain.sh     |  36 ++
 t/t5411/test-0032-report-with-options.sh      | 256 ++++++++++
 ...est-0033-report-with-options--porcelain.sh | 265 ++++++++++
 t/t5411/test-0034-report-ft.sh                |  44 ++
 t/t5411/test-0035-report-ft--porcelain.sh     |  45 ++
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 169 +++++++
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 172 +++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  89 ++++
 .../test-0039-report-mixed-refs--porcelain.sh |  91 ++++
 t/t5411/test-0040-process-all-refs.sh         | 113 +++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 +++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport-helper.c                            |  53 +-
 transport.c                                   | 121 +++--
 48 files changed, 3859 insertions(+), 94 deletions(-)
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

-- 
2.26.1.120.g98702cf3e9

