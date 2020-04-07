Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB66C2BB1D
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3163A206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFsiHql5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgDGMIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:08:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46242 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 08:08:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so710679pff.13
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCbbYkTHoVwknmPIJ+hUXKKxZrenPMe8l2vowBJRFEo=;
        b=ZFsiHql5gINlU+koIJOI2VwySuiEHLeUX1Qm8VcmiHhzElBhCg811vUd/K7BLiEQOW
         bXNahTb/82h1ha6b1EI96XXJIsXi5hwQHRmwyiMFtP/L1d0JnOvQIk6Ef0t7ITJq7WZO
         qhYUwBILynwwQocpYrpZYY/6pwDmJRHBGpAC99KJkfCMI2DWlvHKexm6Yrr9Xn1Qx57Q
         dXr+MNcTNOJofACcQIPj0ZadwpoAOlaDES4M0+sg/g0vy8Hemqawd7m/TJOqoHJynlZB
         vwVOTElCHXLSixDeNlbA+/5Sq2Na7Hm8bXr2C+W01sNz/hV0/uNV+v1K3Sob97NAK8I0
         VQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCbbYkTHoVwknmPIJ+hUXKKxZrenPMe8l2vowBJRFEo=;
        b=cOTTPGyJWtz1vUnki+tloZKYEywF6DK50wkuCPJp4D9lSlAMsh/XRpulUNSfzNGDgT
         IBgI7rmv+6Z7pk1WMq8EkLIuYzFMM2A4LvZhwGeZP29h0p4fQoc/M+oAzFHHRmXzJn1D
         PslzCzcTp4mefKeILAj1kkEB4kEqz1cOsRN4+gwDYcTWGmfRV3t3Pxab/FrnKo1ju1U/
         jvqDk1aJvsIs/ZDNtoOVaJFCHsUe+JI95LQhTqH7ZG1GG+t1hYjvcmWaPJQmthLTt5YX
         K6a1jN/OvQ/GZe+3/DNok1faVXoH2fXb9sIYwNfq5OALaNQeQgv97qdKEGMxJuHGvIKl
         1kMg==
X-Gm-Message-State: AGi0PubTBZ54enHssDB7l6Eyu2JA5gb2UhECepljQ2dKGMRVj+rHkDz0
        AkazPzxpE/G6KHzI5KYcEl0=
X-Google-Smtp-Source: APiQypImLKo7u2xw8E1Q6bfoEejmex4nKpiM5nb4+cT2Fu+CU9Z8r1kh6xqm2EMMpT9D2lV3ZEV9yw==
X-Received: by 2002:a62:15cc:: with SMTP id 195mr2375235pfv.276.1586261298484;
        Tue, 07 Apr 2020 05:08:18 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e26sm14061833pfj.61.2020.04.07.05.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:08:17 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v9 0/6] New proc-receive hook for centralized workflow
Date:   Tue,  7 Apr 2020 08:08:07 -0400
Message-Id: <20200407120813.25025-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200404134345.10655-1-worldhello.net@gmail.com>
References: <20200404134345.10655-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v8

* One test case failed in CI for `pu` branch (see:
  https://github.com/git/git/runs/565992235) with the following error:

        --- expect	2020-04-06 23:41:27.552286900 +0000
        +++ actual	2020-04-06 23:41:27.458511100 +0000
        @@ -3,6 +3,7 @@
         remote: # proc-receive hook
         remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
         remote: proc-receive> <ZERO-OID> <COMMIT-A> refs/for/master/topic
        +remote: fatal: unable to write flush packet: Broken pipe
         remote: error: proc-receive expected "old new ref status [msg]", got "<ZERO-OID> <COMMIT-A> refs/for/master/topic"
         To <URL/of/upstream.git>
          ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
        error: last command exited with $?=1
        not ok 16 - proc-receive bad protocol: no status

  This can be reproduced with the following changes on "t/helper/test-proc-receive.c":

        +++ b/t/helper/test-proc-receive.c
        @@ -2,6 +2,7 @@
         #include "connect.h"
         #include "parse-options.h"
         #include "pkt-line.h"
        +#include "sigchain.h"
         #include "string-list.h"
         #include "test-tool.h"
         
        @@ -130,6 +131,7 @@ int cmd__proc_receive(int argc, const char **argv)
                                   PACKET_READ_CHOMP_NEWLINE |
                                   PACKET_READ_DIE_ON_ERR_PACKET);
         
        +       sigchain_push(SIGPIPE, SIG_IGN);
                proc_receive_verison(&reader);
                proc_receive_read_commands(&reader, &commands);
                proc_receive_read_push_options(&reader, &push_options);
        @@ -163,10 +165,14 @@ int cmd__proc_receive(int argc, const char **argv)
                }
         
                if (returns.nr) {
        -               for_each_string_list_item(item, &returns)
        +               for_each_string_list_item(item, &returns) {
                                packet_write_fmt(1, "%s\n", item->string);
        +                       sleep(1);
        +               }
                }
                packet_flush(1);
        +       sigchain_pop(SIGPIPE);
         
                return 0;
         }

  "test-proc-receive" send results one by one to "receive-pack" and send a 
  flush-pkt to end the communication.  But "receive-pack" will close the pipe,
  if a syntax error is found in the result sent from "test-proc-receive".
  The closed pipe makes "test-proc-receive" complain.

  Make modifications in patch 2/6 of this reroll, so we don't have to adjust
  test cases. E.g.,
  
         /* receive-pack */
         static int read_proc_receive_result(...)
         {
             ... ...
             for (;;) {
                 ... ...
         
                 if (packet_reader_read(reader) != PACKET_READ_NORMAL)
                         break;
                 if (parse_oid_hex(reader->line, &old_oid, &p) ||
                     *p++ != ' ' ||
                     parse_oid_hex(p, &new_oid, &p) ||
                     *p++ != ' ') {
                         strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
                                     reader->line);
        -                return -1;
        +                code = -1;
        +                continue;
                 }


* Patch 1/6: Add `t/t5411/common-functions.sh` and `t/t5411/common-test-cases.sh` to
  reuse test cases between t5411 and t5412.

* Refactor for a smaller patch 5/6 (receive-pack: refactor report for proc-receive).


## Range-diff v8...v9

1:  19c66785d1 ! 1:  ba6222899b transport: not report a non-head push as a branch

    t/t5411-proc-receive-hook.sh               | 75 ++++++++++++++++++++++++++
    t/t5411/common-functions.sh                | 49 +++++++++++++++++
    t/t5411/common-test-cases.sh               | 43 +++++++++++++++
    t/t5412-proc-receive-hook-http-protocol.sh | 86 ++++++++++++++++++++++++++++++

2:  085ded61f5 ! 2:  195c5b0a0c receive-pack: add new proc-receive hook
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		    *p++ != ' ' ||
     +		    parse_oid_hex(p, &new_oid, &p) ||
     +		    *p++ != ' ') {
    -+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'",
    ++			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
     +				    reader->line);
    -+			return -1;
    ++			code = -1;
    ++			continue;
     +		}
     +
     +		refname = p;
     +		status = strchr(p, ' ');
     +		if (!status) {
    -+			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'",
    ++			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
     +				    reader->line);
    -+			return -1;
    ++			code = -1;
    ++			continue;
     +		}
     +		*status++ = '\0';
     +		if (strlen(status) > 2 && *(status + 2) == ' ') {
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			*msg++ = '\0';
     +		}
     +		if (strlen(status) != 2) {
    -+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
    ++			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
     +				    status, reader->line);
    -+			return -1;
    ++			code = -1;
    ++			continue;
     +		}
     +
     +		/* first try searching at our hint, falling back to all refs */
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +				    refname);
     +			continue;
     +		}
    -+		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
    -+		oidcpy(&hint->old_oid, &old_oid);
    -+		oidcpy(&hint->new_oid, &new_oid);
     +		if (!strcmp(status, "ng")) {
     +			if (msg)
     +				hint->error_string = xstrdup(msg);
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +				hint->error_string = "failed";
     +			code = -1;
     +		} else if (strcmp("ok", status)) {
    -+			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
    ++			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
     +				    status, reader->line);
    -+			return -1;
    ++			code = -1;
    ++			/* Skip marking it as RUN_PROC_RECEIVE_RETURNED */
    ++			continue;
     +		}
    ++		oidcpy(&hint->old_oid, &old_oid);
    ++		oidcpy(&hint->new_oid, &new_oid);
    ++		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
     +	}
     +
     +	for (cmd = commands; cmd; cmd = cmd->next)
    @@ t/helper/test-proc-receive.c (new)
     +#include "connect.h"
     +#include "parse-options.h"
     +#include "pkt-line.h"
    ++#include "sigchain.h"
     +#include "string-list.h"
     +#include "test-tool.h"
     +
    @@ t/helper/test-proc-receive.c (new)
     +			   PACKET_READ_CHOMP_NEWLINE |
     +			   PACKET_READ_DIE_ON_ERR_PACKET);
     +
    ++	sigchain_push(SIGPIPE, SIG_IGN);
     +	proc_receive_verison(&reader);
     +	proc_receive_read_commands(&reader, &commands);
     +	proc_receive_read_push_options(&reader, &push_options);
    @@ t/helper/test-proc-receive.c (new)
     +			packet_write_fmt(1, "%s\n", item->string);
     +	}
     +	packet_flush(1);
    ++	sigchain_pop(SIGPIPE);
     +
     +	return 0;
     +}

3:  230f28198f = 3:  cde556e9c7 refs.c: refactor to reuse ref_is_hidden()

4:  e6a7608a84 ! 4:  3200327695 receive-pack: new config receive.procReceiveRefs
    @@ Documentation/config/receive.txt: receive.hideRefs::
     +	used, and all commands will be executed by the internal
     +	`execute_commands` function.
     +
    -+	For example, if this variable is set to "refs/for/", pushing to
    ++	For example, if this variable is set to "refs/for", pushing to
     +	reference such as "refs/for/master" will not create or update a
     +	reference named "refs/for/master", but may create or update a
     +	pull request directly by running an external hook.
     
5:  e426775925 ! 5:  5f2ab02b01 receive-pack: refactor report for proc-receive
    @@ builtin/receive-pack.c: static int read_proc_receive_result(struct packet_reader
     +			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
     +			hint->run_proc_receive = 0;
     +		} else {
    - 			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'",
    + 			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
      				    status, reader->line);
    - 			return -1;
    + 			code = -1;
    @@ builtin/receive-pack.c: static int read_proc_receive_result(struct packet_reader *reader,
    + 		}
    + 		oidcpy(&hint->old_oid, &old_oid);
    + 		oidcpy(&hint->new_oid, &new_oid);
    +-		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
    ++		if (hint->run_proc_receive)
    ++			hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
    + 	}
    + 
    + 	for (cmd = commands; cmd; cmd = cmd->next)
    @@ transport.c: void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
    - 	}
    - }
    - 
    --static void print_ref_status(char flag, const char *summary,
    -+static void print_ref_status(char flag, const char *summary, char *target_refname,
    +@@ transport.c: static void print_ref_status(char flag, const char *summary,
      			     struct ref *to, struct ref *from, const char *msg,
      			     int porcelain, int summary_width)
      {
    -+	if (!target_refname)
    -+		target_refname = to->name;
    ++	char *from_name = NULL;
    ++	char *to_name = NULL;
    ++
    ++	if (from) {
    ++		if (from->remote_status && !strncmp(from->remote_status, "ref:", 4))
    ++			from_name = from->remote_status + 4;
    ++		else
    ++			from_name = from->name;
    ++	}
    ++
    ++	if (to) {
    ++		if (to->remote_status && !strncmp(to->remote_status, "ref:", 4))
    ++			to_name = to->remote_status + 4;
    ++		else
    ++			to_name = to->name;
    ++	}
     +
      	if (porcelain) {
      		if (from)
     -			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
    -+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, target_refname);
    ++			fprintf(stdout, "%c\t%s:%s\t", flag, from_name, to_name);
      		else
     -			fprintf(stdout, "%c\t:%s\t", flag, to->name);
    -+			fprintf(stdout, "%c\t:%s\t", flag, target_refname);
    ++			fprintf(stdout, "%c\t:%s\t", flag, to_name);
      		if (msg)
      			fprintf(stdout, "%s (%s)\n", summary, msg);
      		else
    @@ transport.c: static void print_ref_status(char flag, const char *summary,
      			summary, reset);
      		if (from)
     -			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
    -+			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(target_refname));
    ++			fprintf(stderr, "%s -> %s", prettify_refname(from_name), prettify_refname(to_name));
      		else
     -			fputs(prettify_refname(to->name), stderr);
    -+			fputs(prettify_refname(target_refname), stderr);
    ++			fputs(prettify_refname(to_name), stderr);
      		if (msg) {
      			fputs(" (", stderr);
      			fputs(msg, stderr);
    -@@ transport.c: static void print_ref_status(char flag, const char *summary,
    - 
    - static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
    - {
    -+	char *refname;
    -+
    -+	if (ref->remote_status && !strncmp(ref->remote_status, "ref:", 4))
    -+		refname = ref->remote_status + 4;
    -+	else
    -+		refname = ref->name;
    -+
    - 	if (ref->deletion)
    --		print_ref_status('-', "[deleted]", ref, NULL, NULL,
    -+		print_ref_status('-', "[deleted]", refname, ref, NULL, NULL,
    - 				 porcelain, summary_width);
    --	else if (is_null_oid(&ref->old_oid))
    -+	else if (is_null_oid(&ref->old_oid)) {
    -+
    - 		print_ref_status('*',
    --				 (starts_with(ref->name, "refs/tags/")
    -+				 (starts_with(refname, "refs/tags/")
    - 				  ? "[new tag]"
    --				  : (starts_with(ref->name, "refs/heads/")
    -+				  : (starts_with(refname, "refs/heads/")
    - 				     ? "[new branch]"
    - 				     : "[new reference]")),
    --				 ref, ref->peer_ref, NULL, porcelain, summary_width);
    --	else {
    -+				 refname, ref, ref->peer_ref, NULL, porcelain, summary_width);
    -+	} else {
    - 		struct strbuf quickref = STRBUF_INIT;
    - 		char type;
    - 		const char *msg;
    -@@ transport.c: static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
    - 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid,
    - 					 DEFAULT_ABBREV);
    - 
    --		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg,
    -+		print_ref_status(type, quickref.buf, refname, ref, ref->peer_ref, msg,
    - 				 porcelain, summary_width);
    - 		strbuf_release(&quickref);
    - 	}
    -@@ transport.c: static int print_one_push_status(struct ref *ref, const char *dest, int count,
    - 
    - 	switch(ref->status) {
    - 	case REF_STATUS_NONE:
    --		print_ref_status('X', "[no match]", ref, NULL, NULL,
    -+		print_ref_status('X', "[no match]", NULL, ref, NULL, NULL,
    - 				 porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REJECT_NODELETE:
    --		print_ref_status('!', "[rejected]", ref, NULL,
    -+		print_ref_status('!', "[rejected]", NULL, ref, NULL,
    - 				 "remote does not support deleting refs",
    - 				 porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_UPTODATE:
    --		print_ref_status('=', "[up to date]", ref,
    -+		print_ref_status('=', "[up to date]", NULL, ref,
    - 				 ref->peer_ref, NULL, porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REJECT_NONFASTFORWARD:
    --		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
    -+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
    - 				 "non-fast-forward", porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REJECT_ALREADY_EXISTS:
    --		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
    -+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
    - 				 "already exists", porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REJECT_FETCH_FIRST:
    --		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
    -+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
    - 				 "fetch first", porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REJECT_NEEDS_FORCE:
    --		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
    -+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
    - 				 "needs force", porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REJECT_STALE:
    --		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
    -+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
    - 				 "stale info", porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REJECT_SHALLOW:
    --		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
    -+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
    - 				 "new shallow roots not allowed",
    - 				 porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_REMOTE_REJECT:
    --		print_ref_status('!', "[remote rejected]", ref,
    -+		print_ref_status('!', "[remote rejected]", NULL, ref,
    - 				 ref->deletion ? NULL : ref->peer_ref,
    - 				 ref->remote_status, porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_EXPECTING_REPORT:
    --		print_ref_status('!', "[remote failure]", ref,
    -+		print_ref_status('!', "[remote failure]", NULL, ref,
    - 				 ref->deletion ? NULL : ref->peer_ref,
    - 				 "remote failed to report status",
    - 				 porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_ATOMIC_PUSH_FAILED:
    --		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
    -+		print_ref_status('!', "[rejected]", NULL, ref, ref->peer_ref,
    - 				 "atomic push failed", porcelain, summary_width);
    - 		break;
    - 	case REF_STATUS_OK:

6:  c5982067be < -:  ---------- t5412: test the proc-receive hook on HTTP protocol

7:  823b7f2ea6 = 6:  b7d7175d89 doc: add documentation for the proc-receive hook

---

Jiang Xin (6):
  transport: not report a non-head push as a branch
  receive-pack: add new proc-receive hook
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  receive-pack: refactor report for proc-receive
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt           |  14 +
 Documentation/githooks.txt                 |  70 ++
 Makefile                                   |   1 +
 builtin/receive-pack.c                     | 318 +++++++-
 refs.c                                     |  11 +-
 refs.h                                     |   1 +
 t/helper/test-proc-receive.c               | 175 +++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t5411-proc-receive-hook.sh               |  75 ++
 t/t5411/common-functions.sh                |  53 ++
 t/t5411/common-test-cases.sh               | 827 +++++++++++++++++++++
 t/t5412-proc-receive-hook-http-protocol.sh |  86 +++
 t/t5516-fetch-push.sh                      |   2 +-
 transport-helper.c                         |  64 +-
 transport.c                                |  34 +-
 16 files changed, 1684 insertions(+), 49 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/common-test-cases.sh
 create mode 100755 t/t5412-proc-receive-hook-http-protocol.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

