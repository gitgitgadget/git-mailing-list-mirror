Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0074AC2BA16
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16EC206C3
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRKmTH0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDDNnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:43:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42457 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDDNnx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 09:43:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id 22so5074404pfa.9
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=503VQyqwWO4aB4q5KQ54xJ8gWTpZxIiaM/YBIK9aI8k=;
        b=nRKmTH0NnkoeKUKYZwE5ucMwNgAsSGMFJpB7IDDKRTs28pvuJyKAX7yvI13NJOZtEI
         /8VXZQcPv1CknCUD90LqguyPWymEXHuC2TjRErrf3wpjpXoNTRKzfHOtoo7ogypJnARj
         PBlDGx7hWRQ3DiQCCM1yVg2HNRK6CtAetAYKLrcaLlX9VgA2kIfhsDX9tPchjEaDP4JA
         BRjrdnYjy7KdFVmpPeVc8sRISrcM5c9GmJ1D7swxnxWjckgp6DlCTxe3bYDWv3U2GiJO
         uQX/ahxnWU/YO6Eu13SZT12M7Y/uwHyWGswW3H+yfTCYkgrhyEG9387vRB/Cy/Msftc6
         txtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=503VQyqwWO4aB4q5KQ54xJ8gWTpZxIiaM/YBIK9aI8k=;
        b=n+ylzH3xfijADMp1xGYhLbCf45TPp28dVyZKOtDvVvlLubLvqVLGonxrlUghQ395M6
         j6lVWjA7b21f2PRHErWJFN4Lc8yBak/Pq1s5MrHjapT+mOx59O5CRdQIpmS8fpiI0QRA
         sO9Rc72IY8gKzLlg/r1m4NhiESDTFo88GEBc4+5vzVDOW8cDkT+qw1M3DHVRXbkqwjBE
         gPLAziDxxZYnlL01/e8YPxkL5n4GNxjf0zEAH8ZNm3aulYYmIxxjWuYR8bme585PrXl7
         z2FIQHRx66Rl0KKazV0hVQa+90lbrAM4iHFlP/MEeSwmcUfhGCcLulcFtMHabR1aMq6b
         PiFw==
X-Gm-Message-State: AGi0PuYY+iRqVwnH6qyICnE/Ogs083/EJzJGGmBjRwpiydfCsPeUs4Vf
        MRY6sfk/xYjshP3dLToPw7iBtOgT
X-Google-Smtp-Source: APiQypIYRLSQdBxsLZWrTgYfhhJBGtH+Wr8Ux9noPaL0VoilAA69uOnztk4NAjv6GfSl4FRWkQYpUw==
X-Received: by 2002:a63:e350:: with SMTP id o16mr12549301pgj.250.1586007830941;
        Sat, 04 Apr 2020 06:43:50 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15sm7755531pfc.206.2020.04.04.06.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 06:43:50 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v8 0/7] New proc-receive hook for centralized workflow
Date:   Sat,  4 Apr 2020 09:43:38 -0400
Message-Id: <20200404134345.10655-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200403160838.6252-1-worldhello.net@gmail.com>
References: <20200403160838.6252-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>


## Changes since v7

* Parallel test (make -j7 test) failed because of the failure message on
  calling `finish_command()` is not stable for test.  Remove the error
  message in this revision.

    -	if (finish_command(&proc)) {
    -		strbuf_addstr(&errmsg, "proc-receive did not exit properly\n");
    +	if (finish_command(&proc))
     		code = -1;
    -	}


## Changes since v6

* Test failed because two message streams of `copy_to_sideband()` and
  `rp_error()` are mixed together.  Store error messages in `errmsg`
  and output the errmsg after closing the sideband muxer.

* Use test_i18ncmp instead of mark the whole test case using
  C_LOCALE_OUTPUT.

* Please merge this topic after topic `jx/atomic-push`.  One test case
  depends on it.


## Range-diff v6...v7

1:  64c9ca7086 = 1:  19c66785d1 transport: not report a non-head push as a branch
2:  0d27cc5e80 ! 2:  085ded61f5 receive-pack: add new proc-receive hook
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		    *p++ != ' ' ||
     +		    parse_oid_hex(p, &new_oid, &p) ||
     +		    *p++ != ' ') {
    -+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
    ++			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'",
     +				    reader->line);
     +			return -1;
     +		}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		refname = p;
     +		status = strchr(p, ' ');
     +		if (!status) {
    -+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
    ++			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'",
     +				    reader->line);
     +			return -1;
     +		}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			*msg++ = '\0';
     +		}
     +		if (strlen(status) != 2) {
    -+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    ++			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
     +				    status, reader->line);
     +			return -1;
     +		}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +				hint->error_string = xstrdup(msg);
     +			else
     +				hint->error_string = "failed";
    -+			code = 1;
    ++			code = -1;
     +		} else if (strcmp("ok", status)) {
    -+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    ++			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
     +				    status, reader->line);
     +			return -1;
     +		}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +	for (cmd = commands; cmd; cmd = cmd->next)
     +		if (cmd->run_proc_receive &&
    -+		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED))
    ++		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
     +		    cmd->error_string = "no report from proc-receive";
    ++		    code = -1;
    ++		}
     +
     +	return code;
     +}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	}
     +
     +	if (version != 1) {
    -+		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported\n",
    ++		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
     +			    version);
     +		code = -1;
     +		goto cleanup;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	close(proc.out);
     +	if (use_sideband)
     +		finish_async(&muxer);
    -+	if (finish_command(&proc)) {
    -+		strbuf_addstr(&errmsg, "proc-receive did not exit properly\n");
    ++	if (finish_command(&proc))
     +		code = -1;
    -+	}
     +	if (errmsg.len >0) {
     +		char *p = errmsg.buf;
     +
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "normal git-push command" '
     +	remote: # proc-receive hook
     +	remote: fatal: the remote end hung up unexpectedly
     +	remote: error: proc-receive version "2" is not supported
    -+	remote: proc-receive did not exit properly
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
3:  81f086188c = 3:  230f28198f refs.c: refactor to reuse ref_is_hidden()
4:  52675b55a2 ! 4:  e6a7608a84 receive-pack: new config receive.procReceiveRefs
    @@ t/t5411-proc-receive-hook.sh: test_expect_success "cleanup" '
     +test_expect_success "add two receive.procReceiveRefs settings" '
     +	(
     +		cd "$upstream" &&
    -+		git config --add receive.procReceiveRefs refs/for/ &&
    ++		git config --add receive.procReceiveRefs refs/for &&
     +		git config --add receive.procReceiveRefs refs/review/
     +	)
     +'
5:  65876b1e75 ! 5:  e426775925 receive-pack: refactor report for proc-receive
    @@ builtin/receive-pack.c: static void write_head_info(void)
     @@ builtin/receive-pack.c: static int read_proc_receive_result(struct packet_reader *reader,
      			else
      				hint->error_string = "failed";
    - 			code = 1;
    + 			code = -1;
     -		} else if (strcmp("ok", status)) {
     +		} else if (!strcmp("ok", status)) {
     +			hint->extra_string = xstrdup_or_null(msg);
    @@ builtin/receive-pack.c: static int read_proc_receive_result(struct packet_reader
     +			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
     +			hint->run_proc_receive = 0;
     +		} else {
    - 			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
    + 			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
      				    status, reader->line);
      			return -1;
     @@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
6:  04ec372c35 ! 6:  c5982067be t5412: test proc-receive hook on HTTP protocol
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    t5412: test proc-receive hook on HTTP protocol
    +    t5412: test the proc-receive hook on HTTP protocol
     
    -    Copy from t5411 to test "proc-receive" hook on HTTP protocol.
    +    Copy from t5411 to test the "proc-receive" hook on the HTTP protocol.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +		-e "s/$ZERO_OID/<ZERO-OID>/g" \
     +		-e "s/[0-9a-f]\{7,\}/<OID>/g" \
     +		-e "s#To .*/upstream.git#To <URL/of/upstream.git>#" \
    -+		-e "/^error: / d" \
    -+		-e "/^remote: fatal: /d"
    ++		-e "/^error: / d"
     +}
     +
     +# Refs of upstream : master(B)  next(A)
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +test_expect_success "add two receive.procReceiveRefs settings" '
     +	(
     +		cd "$upstream" &&
    -+		git config --add receive.procReceiveRefs refs/for/ &&
    ++		git config --add receive.procReceiveRefs refs/for &&
     +		git config --add receive.procReceiveRefs refs/review/
     +	)
     +'
    @@ t/t5412-proc-receive-hook-http-protocol.sh (new)
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    ++	# Apache calls "receive-pack" with system locale settings, which
    ++	# makes the message "remote: fatal: ..." unstable for test.
    ++	sed -e "/^remote: fatal: / d" out | \
    ++	make_user_friendly_and_stable_output >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: error: proc-receive version "2" is not supported
    -+	remote: proc-receive did not exit properly
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
     +	EOF
7:  4ab8873f12 = 7:  823b7f2ea6 doc: add documentation for the proc-receive hook

---

Jiang Xin (7):
  transport: not report a non-head push as a branch
  receive-pack: add new proc-receive hook
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  receive-pack: refactor report for proc-receive
  t5412: test the proc-receive hook on HTTP protocol
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
 t/t5411-proc-receive-hook.sh               | 931 ++++++++++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh | 945 +++++++++++++++++++++
 t/t5516-fetch-push.sh                      |   2 +-
 transport-helper.c                         |  64 +-
 transport.c                                |  62 +-
 14 files changed, 2521 insertions(+), 66 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

