Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F318C2BB86
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92F6206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGr6JTSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501996AbgDNMdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730303AbgDNMdF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 08:33:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B81C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so5982992pfp.8
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ywv3Oq8f4v3qV5BlX6QDkufMJ/Nc93boB/FE8JLFhZw=;
        b=oGr6JTSgpYlq5+7ydRqejdYGaM6mcjV6ZUSCAGuBFV6Ex3/hgU1jQCH6FdwMNWXZPL
         tvU8mHV9IjUCzC1m9hK/uMYbXsGUxzDP0b7v9Mxf6+e9mBMaIvNKBjaJ8QBJeGQP7hOu
         kO5gcXkuG3ltVb14POaumYJMInmF5+taB/Ugcq/ds9ge6Gqhg63ZUijpzS3eTnVAlsdg
         ckOpY8KSfbjmAuCV4EcUlRnWOyKIh02ovcxRjwjxE2MfCW5cXqvlMsJWJe9SSxX8aRBf
         PuVHjSbOn9qnIVMbd5HaM6wt9e4L1es/Awj5vnyF86JnWhpukeMQZuN6W6OEff2hcxyk
         2KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ywv3Oq8f4v3qV5BlX6QDkufMJ/Nc93boB/FE8JLFhZw=;
        b=dbbC8umOKtu8IZ+NX27tqAAcYFRSBBFnAX4S5I0IxEu7upml/6HxOZDymYpg8rsVag
         Dmx1T1zj72oVJV41VlXZrrvddCvwJqRUTx0j02YsrcLH7ll8sTz265vt815ld+pwEhHV
         4pq7vBVkVvaedVzexpSzdM1y3h+XT/AdInOOGuHi+0Cj0BcT7geq2xyKmTy95ZBSGsLL
         SbULdeIx5oQBnvzAvymnIVC4tyxNy8OMkFbvFH4AbLhoiuLxuJiYCcsr7zC/2eQv5Wla
         lWK/2Fjm98oDPJM4iVyS/JKz4ItHR7ghJw1S9wBWUwj6ZPKYo9w5jBQQarWcgolsNNRD
         /Ung==
X-Gm-Message-State: AGi0PuaQOAkQmlKKHdz8cNIRz3twOLeIj8V9whyvuFnHSpdharwo6XWz
        TYGXJLlHSgTFVrXNuf8XgXU=
X-Google-Smtp-Source: APiQypL2ywe1z9NUVmD42wyf86k1ApdCpVS38vi4tFicUSJOfFkV8zIYJ7iPyeMbvJFyPHQGp8JZNA==
X-Received: by 2002:a63:1e0a:: with SMTP id e10mr22332020pge.417.1586867584330;
        Tue, 14 Apr 2020 05:33:04 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c9sm996177pfp.53.2020.04.14.05.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:33:03 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 0/7] New proc-receive hook for centralized workflow
Date:   Tue, 14 Apr 2020 08:32:50 -0400
Message-Id: <20200414123257.27449-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq3697cax0.fsf@gitster.c.googlers.com>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v11

* Change the syntax of status report from "proc-receive" to "receive-pack".

        # Receive result from the hook.
        # OK, run this command successfully.
        H: PKT-LINE(ok <ref>)
        # NO, I reject it.
        H: PKT-LINE(ng <ref> <reason>)
        # Fall through, let 'receive-pack' to execute it.
        H: PKT-LINE(ft <ref>)
        # OK, but has an alternate reference.  The alternate reference name
        # is given in the third parameter, and other status can be given in
        # key-value pairs.
        H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
                    forced-update)
        H: ... ...
        H: flush-pkt

* Support multiple responses from "proc-receive" for one reference.
  Add test case:

        test_expect_success "setup proc-receive hook (multiple responses)" '
        	write_script "$upstream/hooks/proc-receive" <<-EOF
        	printf >&2 "# proc-receive hook\n"
        	test-tool proc-receive -v \
        		-r "alt refs/for/master/topic refs/changes/23/123/1" \
        		-r "alt refs/for/master/topic refs/changes/24/124/2 old-oid=$A new-oid=$B"
        	EOF
        '
        
        # Refs of upstream : master(A)
        # Refs of workbench: master(A)  tags/v123
        # git push         :                       refs/for/master/topic(A)
        test_expect_success "proc-receive: report multiple response" '
        	git -C workbench push origin \
        		HEAD:refs/for/master/topic \
        		>out 2>&1 &&
        	make_user_friendly_and_stable_output <out >actual &&
        	cat >expect <<-EOF &&
        	remote: # pre-receive hook
        	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
        	remote: # proc-receive hook
        	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
        	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
        	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
        	remote: # post-receive hook
        	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
        	To <URL/of/upstream.git>
        	 * [new reference] HEAD -> refs/changes/23/123/1
        	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
        	EOF
        	test_cmp expect actual &&
        	git -C "$upstream" show-ref >out &&
        	make_user_friendly_and_stable_output <out >actual &&
        	cat >expect <<-EOF &&
        	<COMMIT-A> refs/heads/master
        	EOF
        	test_cmp expect actual
        '

* "receive-pack" checks format of the report from "proc-receive", will
  discard unknown status.

* Apply the `SQUASH???` commit.


## Range-diff v11..v12

1:  bef4360e58 ! 1:  b76900cb0f receive-pack: add new proc-receive hook
    @@ Commit message
     
             # Receive result from the hook.
             # OK, run this command successfully.
    -        H: PKT-LINE(<old-oid> <new-oid> <ref> ok)
    +        H: PKT-LINE(ok <ref>)
             # NO, I reject it.
    -        H: PKT-LINE(<old-oid> <new-oid> <ref> ng <reason>)
    +        H: PKT-LINE(ng <ref> <reason>)
             # Fall through, let 'receive-pack' to execute it.
    -        H: PKT-LINE(<old-oid> <new-oid> <ref> ft)
    +        H: PKT-LINE(ft <ref>)
             # OK, but has an alternate reference.  The alternate reference name
    -        # and other status are given in key=value pairs after the null
    -        # character.
    -        H: PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head
    +        # is given in the third parameter, and other status can be given in
    +        # key-value pairs.
    +        H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
                         forced-update)
             H: ... ...
             H: flush-pkt
    @@ Commit message
         other routines.  Finally, the result of the execution of these commands
         will be reported to end user.
     
    -    The reporting function from "receive-pack" to "send-pack" is also
    -    extended using a backward compatible way by adding key-value pairs
    -    after an null character, like:
    +    The reporting function from "receive-pack" to "send-pack" is extended
    +    using a backward compatible way by adding key-value pairs after an null
    +    character, like:
     
             # OK, run this command successfully with optional extended-status.
             ok <reference>\0ref=refs/pull/123/head old-oid=...
    @@ Makefile: TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
      TEST_BUILTINS_OBJS += test-read-cache.o
     
      ## builtin/receive-pack.c ##
    +@@
    + #include "remote.h"
    + #include "connect.h"
    + #include "string-list.h"
    ++#include "string.h"
    + #include "sha1-array.h"
    + #include "connected.h"
    + #include "argv-array.h"
     @@ builtin/receive-pack.c: static void write_head_info(void)
      	packet_flush(1);
      }
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +	for (;;) {
     +		struct object_id old_oid, new_oid;
    -+		const char *refname;
    -+		const char *p;
     +		char *status;
    -+		char *msg = NULL;
    -+		int len;
    ++		char *refname;
    ++		char *remains = NULL;
     +
     +		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     +			break;
    -+		len = strlen(reader->line);
    -+		if (parse_oid_hex(reader->line, &old_oid, &p) ||
    -+		    *p++ != ' ' ||
    -+		    parse_oid_hex(p, &new_oid, &p) ||
    -+		    *p++ != ' ') {
    -+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
    -+				    reader->line);
    -+			code = -1;
    -+			continue;
    ++		status = (char *)reader->line;
    ++		refname = strchr(status, ' ');
    ++		if (refname) {
    ++			*refname++ = '\0';
    ++			remains = strchr(refname, ' ');
    ++			if (remains)
    ++				*remains++ = '\0';
     +		}
    -+
    -+		refname = p;
    -+		status = strchr(p, ' ');
    -+		if (!status) {
    -+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
    ++		if (!refname || strlen(refname) == 0) {
    ++			strbuf_addf(errmsg, "proc-receive expected '<status> <ref> ...', got '%s'\n",
     +				    reader->line);
     +			code = -1;
     +			continue;
     +		}
    -+		*status++ = '\0';
    -+		msg = strchr(status, ' ');
    -+		if (msg)
    -+			*msg++ = '\0';
     +
     +		/* first try searching at our hint, falling back to all refs */
     +		if (hint)
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			continue;
     +		}
     +		if (!strcmp(status, "ng")) {
    -+			if (msg)
    -+				hint->error_string = xstrdup(msg);
    ++			if (remains)
    ++				hint->error_string = xstrdup(remains);
     +			else
     +				hint->error_string = "failed";
     +			code = -1;
     +		} else if (!strcmp("ft", status)) {
     +			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
     +			hint->run_proc_receive = 0;
    ++		} else if (!strcmp("alt", status)) {
    ++			char *alt_ref;
    ++
    ++			alt_ref = remains;
    ++			remains = strchr(alt_ref, ' ');
    ++			if (remains)
    ++				*remains++ = '\0';
    ++
    ++			if (hint->extended_status)
    ++				strbuf_addstr(&extended_status, hint->extended_status);
    ++
    ++			strbuf_addf(&extended_status, "%sref=%s",
    ++				    extended_status.len > 0 ? " ": "",
    ++				    alt_ref);
    ++
    ++			if (remains) {
    ++				const char *val;
    ++				int len;
    ++
    ++				val = parse_feature_value(remains, "old-oid", &len);
    ++				if (val && len > 0)
    ++					if (!parse_oid_hex(val, &old_oid, &val))
    ++						strbuf_addf(&extended_status, "%sold-oid=%s",
    ++							   extended_status.len > 0 ? " ": "",
    ++							   oid_to_hex(&old_oid));
    ++
    ++				val = parse_feature_value(remains, "new-oid", &len);
    ++				if (val && len > 0)
    ++					if (!parse_oid_hex(val, &new_oid, &val))
    ++						strbuf_addf(&extended_status, "%snew-oid=%s",
    ++							   extended_status.len > 0 ? " ": "",
    ++							   oid_to_hex(&new_oid));
    ++
    ++				if (parse_feature_request(remains, "forced-update"))
    ++					strbuf_addf(&extended_status, "%sforced-update",
    ++						    extended_status.len > 0 ? " ": "");
    ++			}
    ++
    ++			if (extended_status.len > 0) {
    ++				free((void *)hint->extended_status);
    ++				hint->extended_status = strbuf_detach(&extended_status, NULL);
    ++			}
     +		} else if (strcmp("ok", status)) {
     +			strbuf_addf(errmsg, "proc-receive reported bad status '%s' on ref '%s'\n",
     +				    status, refname);
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			/* Skip marking it as RUN_PROC_RECEIVE_RETURNED */
     +			continue;
     +		}
    -+		if (reader->pktlen > len)
    -+			strbuf_addstr(&extended_status, (char *)reader->line + len + 1);
    -+		if (oidcmp(&hint->old_oid, &old_oid)) {
    -+			oidcpy(&hint->old_oid, &old_oid);
    -+			strbuf_addf(&extended_status, "%sold-oid=%s",
    -+				    extended_status.len > 0 ? " ": "",
    -+				    oid_to_hex(&old_oid));
    -+		}
    -+		if (oidcmp(&hint->new_oid, &new_oid)) {
    -+			oidcpy(&hint->new_oid, &new_oid);
    -+			strbuf_addf(&extended_status, "%snew-oid=%s",
    -+				    extended_status.len > 0 ? " ": "",
    -+				    oid_to_hex(&new_oid));
    -+		}
    -+		if (extended_status.len > 0)
    -+			hint->extended_status = strbuf_detach(&extended_status, NULL);
    ++
     +		if (hint->run_proc_receive)
     +			hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
     +	}
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +
     +'
     +
    -+test_expect_success "setup proc-receive hook (bad oid)" '
    ++test_expect_success "setup proc-receive hook (no ref)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "bad-id new-id ref ok"
    ++		-r "ok"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: bad protocol (bad oid)" '
    ++test_expect_success "proc-receive: bad protocol (no ref)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic\
     +		>out 2>&1 &&
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> bad-id new-id ref ok
    -+	remote: error: proc-receive expected "old new ref status [msg]", got "bad-id new-id ref ok"
    -+	To <URL/of/upstream.git>
    -+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
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
    -+test_expect_success "setup proc-receive hook (no status)" '
    -+	write_script "$upstream/hooks/proc-receive" <<-EOF
    -+	printf >&2 "# proc-receive hook\n"
    -+	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/master/topic"
    -+	EOF
    -+'
    -+
    -+# Refs of upstream : master(A)
    -+# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: bad protocol (no status)" '
    -+	test_must_fail git -C workbench push origin \
    -+		HEAD:refs/for/master/topic \
    -+		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
    ++	remote: proc-receive> ok
    ++	remote: error: proc-receive expected "<status> <ref> ...", got "ok"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/master/topic xx msg"
    ++		-r "xx refs/for/master/topic"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic xx msg
    ++	remote: proc-receive> xx refs/for/master/topic
     +	remote: error: proc-receive reported bad status "xx" on ref "refs/for/master/topic"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/master/topic ng"
    ++		-r "ng refs/for/master/topic"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng
    ++	remote: proc-receive> ng refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (failed)
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/master/topic ng error msg"
    ++		-r "ng refs/for/master/topic error msg"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ng error msg
    ++	remote: proc-receive> ng refs/for/master/topic error msg
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (error msg)
     +	EOF
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/heads/master ok"
    ++		-r "ok refs/heads/master"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/heads/master ok
    ++	remote: proc-receive> ok refs/heads/master
     +	remote: error: proc-receive reported status on unexpected ref: refs/heads/master
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/master/topic ok"
    ++		-r "ok refs/for/master/topic"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    ++	remote: proc-receive> ok refs/for/master/topic
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/my/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    ++	remote: proc-receive> ok refs/for/master/topic
     +	remote: error: proc-receive reported status on unknown ref: refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/a/b/c/my/topic (proc-receive failed to report status)
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive< issue=123
     +	remote: proc-receive< reviewer=user1
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic ok
    ++	remote: proc-receive> ok refs/for/master/topic
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $B refs/for/master/topic ft"
    ++		-r "ft refs/for/master/topic"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-B> refs/for/master/topic ft
    ++	remote: proc-receive> ft refs/for/master/topic
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/a/b/c/topic ok" \
    -+		-r "$ZERO_OID $A refs/for/next/topic ok\0ref=refs/pull/123/head" \
    -+		-r "$B $A refs/for/master/topic ok\0ref=refs/pull/124/head forced-update"
    ++		-r "ok refs/for/a/b/c/topic" \
    ++		-r "alt refs/for/next/topic refs/pull/123/head" \
    ++		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/123/head
    -+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok\0ref=refs/pull/124/head forced-update
    ++	remote: proc-receive> ok refs/for/a/b/c/topic
    ++	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    -+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 * [new reference] HEAD -> refs/for/next/topic
     +	 * [new reference] HEAD -> refs/for/a/b/c/topic
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success "setup proc-receive hook (multiple responses)" '
    ++	write_script "$upstream/hooks/proc-receive" <<-EOF
    ++	printf >&2 "# proc-receive hook\n"
    ++	test-tool proc-receive -v \
    ++		-r "alt refs/for/master/topic refs/changes/23/123/1" \
    ++		-r "alt refs/for/master/topic refs/changes/24/124/2 old-oid=$A new-oid=$B"
    ++	EOF
    ++'
    ++
    ++# Refs of upstream : master(A)
    ++# Refs of workbench: master(A)  tags/v123
    ++# git push         :                       refs/for/master/topic(A)
    ++test_expect_success "proc-receive: report multiple response" '
    ++	git -C workbench push origin \
    ++		HEAD:refs/for/master/topic \
    ++		>out 2>&1 &&
    ++	make_user_friendly_and_stable_output <out >actual &&
    ++	cat >expect <<-EOF &&
    ++	remote: # pre-receive hook
    ++	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: # proc-receive hook
    ++	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
    ++	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: # post-receive hook
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	To <URL/of/upstream.git>
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
     +test_expect_success "setup proc-receive hook" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$ZERO_OID $A refs/for/next/topic ok" \
    -+		-r "$A $B refs/for/master/topic ok"
    ++		-r "ok refs/for/next/topic" \
    ++		-r "alt refs/for/master/topic refs/for/master/topic old-oid=$A new-oid=$B"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok
    -+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok
    ++	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive> alt refs/for/master/topic refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
    -+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
     +	 <OID-A>..<OID-B> <COMMIT-B> -> master
     +	 * [new branch] HEAD -> bar
2:  a4a1cc1d14 ! 2:  d20702291b send-pack: extension for client-side status report
    @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref
      			ret = -1;
      		}
     -		hint->remote_status = xstrdup_or_null(msg);
    -+		if (msg) {
    ++		if (msg)
     +			hint->remote_status = xstrdup(msg);
    -+		} else if (extended_status) {
    ++		else if (extended_status)
     +			hint->remote_status = xstrdup(extended_status);
    -+			update_ref_from_remote_status(hint);
    -+		}
      		/* start our next search from the next ref */
      		hint = hint->next;
      	}
    @@ send-pack.c: static int receive_status(struct packet_reader *reader, struct ref
      ## t/t5411/common-test-cases.sh ##
     @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report with extended status" '
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    - 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
      	To <URL/of/upstream.git>
     -	 * [new reference] HEAD -> refs/for/next/topic
     +	 * [new reference] HEAD -> refs/pull/123/head
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report with ext
      	EOF
      	test_cmp expect actual &&
      	git -C "$upstream" show-ref >out &&
    +@@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report multiple response" '
    + 	remote: # post-receive hook
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    + 	To <URL/of/upstream.git>
    +-	 * [new reference] HEAD -> refs/for/master/topic
    ++	 * [new reference] HEAD -> refs/changes/23/123/1
    ++	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
    + 	EOF
    + 	test_cmp expect actual &&
    + 	git -C "$upstream" show-ref >out &&
     @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update of mixed refs" '
      	 * [new branch] HEAD -> baz
      	 * [new reference] HEAD -> refs/for/next/topic
    @@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
      		}
      	}
      
    -@@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
    - 	(*ref)->status = status;
    - 	(*ref)->forced_update |= forced;
    - 	(*ref)->remote_status = msg;
    -+	if (status == REF_STATUS_OK && (*ref)->remote_status)
    -+		update_ref_from_remote_status(*ref);
    - 	return !(status == REF_STATUS_OK);
    - }
    - 
     
      ## transport.c ##
     @@ transport.c: static void print_ref_status(char flag, const char *summary,
      			     struct ref *to, struct ref *from, const char *msg,
      			     int porcelain, int summary_width)
      {
    -+	char *from_name = NULL;
     +	char *to_name = NULL;
     +	const char *val;
     +	int len;
     +
    -+	if (from && from->remote_status) {
    -+		val = parse_feature_value(from->remote_status, "ref", &len);
    -+		if (val && len)
    -+			 from_name = xmemdupz(val, len);
    -+	}
     +	if (to && to->remote_status) {
     +		val = parse_feature_value(to->remote_status, "ref", &len);
     +		if (val && len)
    -+			 to_name = xmemdupz(val, len);
    ++		to_name = xmemdupz(val, len);
     +	}
     +
      	if (porcelain) {
      		if (from)
     -			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
    -+			fprintf(stdout, "%c\t%s:%s\t", flag,
    -+				from_name ? from_name : from->name,
    -+				to_name ? to_name: to->name);
    ++			fprintf(stdout, "%c\t%s:%s\t", flag, from->name,
    ++				to_name ? to_name : to->name);
      		else
     -			fprintf(stdout, "%c\t:%s\t", flag, to->name);
     +			fprintf(stdout, "%c\t:%s\t", flag,
    -+				to_name ? to_name: to->name);
    ++				to_name ? to_name : to->name);
      		if (msg)
      			fprintf(stdout, "%s (%s)\n", summary, msg);
      		else
    @@ transport.c: static void print_ref_status(char flag, const char *summary,
      		if (from)
     -			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
     +			fprintf(stderr, "%s -> %s",
    -+				prettify_refname(from_name ? from_name : from->name),
    ++				prettify_refname(from->name),
     +				prettify_refname(to_name ? to_name : to->name));
      		else
     -			fputs(prettify_refname(to->name), stderr);
    @@ transport.c: static void print_ref_status(char flag, const char *summary,
      		}
      		fputc('\n', stderr);
      	}
    -+	if (from_name)
    -+		free(from_name);
    -+	if (to_name)
    -+		free(to_name);
    ++	free(to_name);
      }
      
      static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
    +@@ transport.c: static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
    + 	}
    + }
    + 
    +-static int print_one_push_status(struct ref *ref, const char *dest, int count,
    +-				 int porcelain, int summary_width)
    ++static int _print_one_push_status(struct ref *ref, const char *dest, int count,
    ++				  int porcelain, int summary_width)
    + {
    + 	if (!count) {
    + 		char *url = transport_anonymize_url(dest);
    +@@ transport.c: static int print_one_push_status(struct ref *ref, const char *dest, int count,
    + 	return 1;
    + }
    + 
    ++static int print_one_push_status(struct ref *ref, const char *dest, int count,
    ++				 int porcelain, int summary_width)
    ++{
    ++	char *head;
    ++	char *begin;
    ++	int n = 0;
    ++
    ++	if (!ref->remote_status)
    ++		return _print_one_push_status(ref, dest, count,
    ++					      porcelain, summary_width);
    ++
    ++	head = ref->remote_status;
    ++	begin = strstr(head, "ref=");
    ++	if (!begin)
    ++		begin = ref->remote_status;
    ++	for (;;) {
    ++		char *end;
    ++		struct object_id old_oid;
    ++		struct object_id new_oid;
    ++		int forced_update;
    ++
    ++		end = strstr(begin + 4, "ref=");
    ++		if (end)
    ++			*(end-1) = '\0';
    ++
    ++		oidcpy(&old_oid, &ref->old_oid);
    ++		oidcpy(&new_oid, &ref->new_oid);
    ++		forced_update = ref->forced_update;
    ++
    ++		ref->remote_status = begin;
    ++		update_ref_from_remote_status(ref);
    ++		_print_one_push_status(ref, dest, count + n++,
    ++				       porcelain, summary_width);
    ++
    ++		oidcpy(&ref->old_oid, &old_oid);
    ++		oidcpy(&ref->new_oid, &new_oid);
    ++		ref->forced_update = forced_update;
    ++
    ++		if (end) {
    ++			begin = end;
    ++			*(end-1) = ' ';
    ++		} else {
    ++			break;
    ++		}
    ++	}
    ++	ref->remote_status = head;
    ++	return n;
    ++}
    ++
    + static int measure_abbrev(const struct object_id *oid, int sofar)
    + {
    + 	char hex[GIT_MAX_HEXSZ + 1];
3:  4e3c383c12 = 3:  a8860faa17 refs.c: refactor to reuse ref_is_hidden()
4:  dd83569c4e ! 4:  46a839ddf6 receive-pack: new config receive.procReceiveRefs
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +	if (proc_receive_refs.nr > 0) {
     +		struct strbuf refname_full = STRBUF_INIT;
     +		size_t prefix_len;
    ++
    ++		strbuf_addstr(&refname_full, get_git_namespace());
    ++		prefix_len = refname_full.len;
      
     -		/* TODO: replace the fixed prefix by looking up git config variables. */
     -		if (!strncmp(cmd->ref_name, "refs/for/", 9)) {
     -			cmd->run_proc_receive = RUN_PROC_RECEIVE_SCHEDULED;
     -			run_proc_receive = 1;
    -+		strbuf_addstr(&refname_full, get_git_namespace());
    -+		prefix_len = refname_full.len;
    -+
     +		for (cmd = commands; cmd; cmd = cmd->next) {
     +			if (!should_process_cmd(cmd))
     +				continue;
    @@ t/t5411/common-test-cases.sh: test_expect_success "setup proc-receive hook (with
      	write_script "$upstream/hooks/proc-receive" <<-EOF
      	printf >&2 "# proc-receive hook\n"
      	test-tool proc-receive -v \
    --		-r "$ZERO_OID $A refs/for/a/b/c/topic ok" \
    -+		-r "$ZERO_OID $A refs/review/a/b/c/topic ok" \
    - 		-r "$ZERO_OID $A refs/for/next/topic ok\0ref=refs/pull/123/head" \
    - 		-r "$B $A refs/for/master/topic ok\0ref=refs/pull/124/head forced-update"
    +-		-r "ok refs/for/a/b/c/topic" \
    ++		-r "ok refs/review/a/b/c/topic" \
    + 		-r "alt refs/for/next/topic refs/pull/123/head" \
    + 		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
      	EOF
     @@ t/t5411/common-test-cases.sh: test_expect_success "setup proc-receive hook (with extended status)" '
      
    @@ t/t5411/common-test-cases.sh: test_expect_success "setup proc-receive hook (with
     -	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
      	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    --	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic ok
    -+	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic ok
    - 	remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/123/head
    - 	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/master/topic ok\0ref=refs/pull/124/head forced-update
    +-	remote: proc-receive> ok refs/for/a/b/c/topic
    ++	remote: proc-receive> ok refs/review/a/b/c/topic
    + 	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    + 	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
      	remote: # post-receive hook
      	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     -	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
    - 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
    + 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
      	To <URL/of/upstream.git>
      	 * [new reference] HEAD -> refs/pull/123/head
     -	 * [new reference] HEAD -> refs/for/a/b/c/topic
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update o
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "$B $A refs/heads/master ft" \
    -+		-r "$A $ZERO_OID refs/heads/foo ft" \
    -+		-r "$A $B refs/heads/bar ft" \
    -+		-r "$A $B refs/for/master/topic ok\0ref=refs/pull/123/head" \
    -+		-r "$B $A refs/for/next/topic ok\0ref=refs/pull/124/head forced-update"
    ++		-r "ft refs/heads/master" \
    ++		-r "ft refs/heads/foo" \
    ++		-r "ft refs/heads/bar" \
    ++		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$A new-oid=$B " \
    ++		-r "alt refs/for/next/topic refs/pull/124/head old-oid=$B new-oid=$A forced-update"
     +	EOF
     +'
     +
    @@ t/t5411/common-test-cases.sh: test_expect_success "proc-receive: report update o
     +	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/heads/master ft
    -+	remote: proc-receive> <COMMIT-A> <ZERO-OID> refs/heads/foo ft
    -+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/heads/bar ft
    -+	remote: proc-receive> <COMMIT-A> <COMMIT-B> refs/for/master/topic ok\0ref=refs/pull/123/head
    -+	remote: proc-receive> <COMMIT-B> <COMMIT-A> refs/for/next/topic ok\0ref=refs/pull/124/head forced-update
    ++	remote: proc-receive> ft refs/heads/master
    ++	remote: proc-receive> ft refs/heads/foo
    ++	remote: proc-receive> ft refs/heads/bar
    ++	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> alt refs/for/next/topic refs/pull/124/head old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
     +	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
     +	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
    -+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
    -+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/next/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    ++	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	To <URL/of/upstream.git>
     +	 <OID-A>..<OID-B> <COMMIT-B> -> bar
     +	 - [deleted] foo
5:  2d04f495a3 ! 5:  a357234e97 doc: add documentation for the proc-receive hook
    @@ Documentation/githooks.txt: The default 'update' hook, when enabled--and with
     +
     +    # Receive result from the hook.
     +    # OK, run this command successfully.
    -+    H: PKT-LINE(<old-oid> <new-oid> <ref> ok)
    ++    H: PKT-LINE(ok <ref>)
     +    # NO, I reject it.
    -+    H: PKT-LINE(<old-oid> <new-oid> <ref> ng <reason>)
    ++    H: PKT-LINE(ng <ref> <reason>)
     +    # Fall through, let 'receive-pack' to execute it.
    -+    H: PKT-LINE(<old-oid> <new-oid> <ref> ft)
    ++    H: PKT-LINE(ft <ref>)
     +    # OK, but has an alternate reference.  The alternate reference name
    -+    # and other status are given in key=value pairs after the null
    -+    # character.
    -+    H: PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head
    ++    # is given in the third parameter, and other status can be given in
    ++    # key-value pairs.
    ++    H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
     +                forced-update)
     +    H: ... ...
     +    H: flush-pkt

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
 builtin/receive-pack.c                     | 345 ++++++++-
 connect.c                                  |   3 +-
 connect.h                                  |   1 +
 refs.c                                     |  13 +-
 refs.h                                     |   1 +
 remote.c                                   |  28 +
 remote.h                                   |   3 +
 send-pack.c                                |  11 +-
 t/helper/test-proc-receive.c               | 178 +++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t5411-proc-receive-hook.sh               |  67 ++
 t/t5411/common-functions.sh                |  54 ++
 t/t5411/common-test-cases.sh               | 798 +++++++++++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh |  78 ++
 t/t5516-fetch-push.sh                      |   2 +-
 transport-helper.c                         |  64 +-
 transport.c                                |  85 ++-
 21 files changed, 1749 insertions(+), 57 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/common-test-cases.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

