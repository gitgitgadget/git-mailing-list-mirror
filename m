Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B4C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3242D206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OualUOp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgEEOln (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 10:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729060AbgEEOlm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 10:41:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC06C061A10
        for <git@vger.kernel.org>; Tue,  5 May 2020 07:41:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id a4so1171546pgc.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcmkS1pQOMRchREBjKnyHpDFomFEeCKZRRUH5MsaD5M=;
        b=OualUOp+NfRgvvta+QyJUGYK1dwg+MG6iePOTYuE+ObBdY0DdMUx5SZ0klwlF4kpBz
         G2EdVLkXhzgbULEWwBDJG6P65uNZEGru1lYiw7dLjSZ4HeB7I28Smnk+wGsgM2738win
         pVPirq9QeWVoZ6yr5KefbQSfGCdkOWGET+WSJD6RWwYE/0cSkolHux+yuP5qWUK99J15
         +yXov1bd6HwkE57WDQmYPyaTHG6puMOvNuXAgkSkGz0FNjuurWG8YhcH8AFyMGH4/S4Y
         CKApy8AQB3+FdNzoX5QbUtQ5A1n+DD15QHo3aqvErfC1AI07dMe0vUmRQ0axHi2qrxSf
         l+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcmkS1pQOMRchREBjKnyHpDFomFEeCKZRRUH5MsaD5M=;
        b=Q/4X5DeEYV6vZWOzHNyb7KN01ykE5ZpBQDwFurFmmVaI12/cYnWbzHxdVSABV/X1SE
         ta9T5tOx/7tzFK6X44Cc5O/3J5hiNrkyh19gcsR29fybPSMiaeUHKj+XTyPRFvA3hqk8
         OkCD01NxYJpygvd60Yss4RGcuoDue98gIHY6p8RwlT9e3iyHeuKUkrzTz956tdE9/8fX
         1Ijw2nrQmSnhy7rMEbwq6LSPa5oz9CnyUtuVsqE65lwaPZ3z3cw6JtFMQM/OKJJfeUjW
         anSOdLbKkiYe5Mk0BvqYXtUC8PyfNtUeHZaUN80qH8Qxad1w6uQp7l/01gvfsqiHrWPf
         x/1w==
X-Gm-Message-State: AGi0PuY/Cun+agtxPwuuJCln89ZKCu5fYI/OJ47d76AWC/xRxfzMaPvX
        HpiJJN3cm94lUmS2/i6jENQ=
X-Google-Smtp-Source: APiQypLTChplgHNTh/JJ7hEr85MW9GLP7/nfxYF4eIt9dmNGQLM2U4m4jToYwOLl4T/zO4DcC2YKRw==
X-Received: by 2002:a63:dc56:: with SMTP id f22mr3186151pgj.284.1588689700123;
        Tue, 05 May 2020 07:41:40 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f99sm2431012pjg.22.2020.05.05.07.41.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:41:39 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 0/7] New proc-receive hook for centralized workflow
Date:   Tue,  5 May 2020 10:41:24 -0400
Message-Id: <20200505144131.30048-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
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

## Changes since v13

1. Patch 3/7 introduced a new capability "report-status-v2" for git-push 

   Add new capability "report-status-v2" and new report protocol which is
   not backward compatible for report of git-push.
   
   If a user pushes to a pseudo-reference "refs/for/master/topic", and
   "receive-pack" creates two new references "refs/changes/23/123/1" and
   "refs/changes/24/124/1", for client without the knowledge of
   "report-status-v2", "receive-pack" will only send "ok/ng" directives in
   the report, such as:
   
       ok ref/for/master/topic
   
   But for client which has the knowledge of "report-status-v2",
   "receive-pack" will use "option" directives to report more attributes
   for the reference given by the above "ok/ng" directive.
   
       ok refs/for/master/topic
       option refname refs/changes/23/123/1
       option new-oid <new-oid>
       ok refs/for/master/topic
       option refname refs/changes/24/124/1
       option new-oid <new-oid>
   
   The client will report two new created references to the end user.

2. Patch 2/7: the "proc-receive" reports status using the same way like
   "report-status-v2" to "receive-pack".


## Range-diff v13...v14

1:  dc7f1d044d ! 1:  9a19919552 transport: not report a non-head push as a branch
    @@ t/t5411-proc-receive-hook.sh (new)
     +	git -C upstream.git config http.receivepack true &&
     +	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
     +	mv upstream.git "$upstream" &&
    ++	set_askpass user@host pass@host &&
     +	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
     +'
     +
    @@ t/t5411/test-0000-standard-git-push.sh (new)
     +# Refs of upstream : master(A)  
     +# Refs of workbench: master(A)  tags/v123
     +# git-push         : master(B)             next(A)
    -+test_expect_success "non-force git-push ($PROTOCOL)" '
    ++test_expect_success "git-push ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/heads/next \
    @@ t/t5411/test-0000-standard-git-push.sh (new)
     +# Refs of upstream : master(B)  next(A)
     +# Refs of workbench: master(A)           tags/v123
     +# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
    -+test_expect_success "force git-push ($PROTOCOL)" '
    ++test_expect_success "git-push -f ($PROTOCOL)" '
     +	git -C workbench push -f origin \
     +		refs/tags/v123 \
     +		:refs/heads/next \
    @@ t/t5411/test-0001-standard-git-push--porcelain.sh (new)
     +# Refs of upstream : master(A)  
     +# Refs of workbench: master(A)  tags/v123
     +# git-push         : master(B)             next(A)
    -+test_expect_success "non-force git-push (--porcelain, $PROTOCOL)" '
    ++test_expect_success "git-push ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/heads/next \
    @@ t/t5411/test-0001-standard-git-push--porcelain.sh (new)
     +# Refs of upstream : master(B)  next(A)
     +# Refs of workbench: master(A)           tags/v123
     +# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
    -+test_expect_success "force git-push (--porcelain, $PROTOCOL)" '
    ++test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain -f origin \
     +		refs/tags/v123 \
     +		:refs/heads/next \
    @@ t/t5411/test-0001-standard-git-push--porcelain.sh (new)
     +		git update-ref -d refs/heads/a/b/c
     +	)
     +'
    -+
     
      ## t/t5411/test-0002-pre-receive-declined.sh (new) ##
     @@
    -+test_expect_success "setup pre-receive hook (declined, $PROTOCOL)" '
    ++test_expect_success "setup pre-receive hook ($PROTOCOL)" '
     +	mv "$upstream/hooks/pre-receive" "$upstream/hooks/pre-receive.ok" &&
     +	write_script "$upstream/hooks/pre-receive" <<-EOF
     +	exit 1
    @@ t/t5411/test-0002-pre-receive-declined.sh (new)
     
      ## t/t5411/test-0003-pre-receive-declined--porcelain.sh (new) ##
     @@
    -+test_expect_success "setup pre-receive hook (declined, $PROTOCOL)" '
    ++test_expect_success "setup pre-receive hook ($PROTOCOL)" '
     +	mv "$upstream/hooks/pre-receive" "$upstream/hooks/pre-receive.ok" &&
     +	write_script "$upstream/hooks/pre-receive" <<-EOF
     +	exit 1
    @@ t/t5411/test-0003-pre-receive-declined--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git-push         : master(B)             next(A)
    -+test_expect_success "git-push is declined (--porcelain, $PROTOCOL)" '
    ++test_expect_success "git-push is declined ($PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/heads/next \
2:  673f44599f < -:  ---------- connect: export parse_feature_value()
3:  43647b379a ! 2:  f1a3ca9cda receive-pack: add new proc-receive hook
    @@ Commit message
             # NO, I reject it.
             H: PKT-LINE(ng <ref> <reason>)
             # Fall through, let 'receive-pack' to execute it.
    -        H: PKT-LINE(ft <ref>)
    +        H: PKT-LINE(ok <ref>)
    +        H: PKT-LINE(option fall-through)
             # OK, but has an alternate reference.  The alternate reference name
    -        # is given in the third parameter, and other status can be given in
    -        # key-value pairs.
    -        H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
    -                    forced-update)
    +        # and other status can be given in options
    +        H: PKT-LINE(ok <ref>)
    +        H: PKT-LINE(option refname <refname>)
    +        H: PKT-LINE(option old-oid <old-oid>)
    +        H: PKT-LINE(option new-oid <new-oid>)
    +        H: PKT-LINE(option forced-update)
             H: ... ...
             H: flush-pkt
     
    @@ Commit message
         create/update different reference.  For example, a command for a pseudo
         reference "refs/for/master/topic" may create/update different reference
         such as "refs/pull/123/head".  The alternate reference name and other
    -    status are given in key-value pairs as extended status of the report
    -    line.
    +    status are given in option lines.
     
         The list of commands returned from "proc-receive" will replace the
         relevant commands that are sent from user to "receive-pack", and
    @@ Commit message
         other routines.  Finally, the result of the execution of these commands
         will be reported to end user.
     
    -    The reporting function from "receive-pack" to "send-pack" is extended
    -    using a backward compatible way by adding key-value pairs after an null
    -    character, like:
    -
    -        # OK, run this command successfully with optional extended-status.
    -        ok <reference>\0ref=refs/pull/123/head old-oid=...
    -
    -        # NO, I reject it.
    -        ng <reference> <error message>
    -
    -    Parsing the extended status of the report lines for "send-pack" is not
    -    implemented in this commit, so we can make a compatible test on old
    -    version of a Git client.
    +    The reporting function from "receive-pack" to "send-pack" will be
    +    extended in latter commit just like what the "proc-receive" hook reports
    +    to "receive-pack".
     
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    @@ builtin/receive-pack.c: static void write_head_info(void)
     +#define RUN_PROC_RECEIVE_RETURNED	2
      struct command {
      	struct command *next;
    - 	const char *error_string;
    -+	const char *extended_status;
    +-	const char *error_string;
    ++	struct ref_push_report report;
      	unsigned int skip_update:1,
     -		     did_not_exist:1;
     +		     did_not_exist:1,
    @@ builtin/receive-pack.c: static void write_head_info(void)
      	int index;
      	struct object_id old_oid;
      	struct object_id new_oid;
    +@@ builtin/receive-pack.c: static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
    + 	struct command *cmd = state->cmd;
    + 
    + 	while (cmd &&
    +-	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
    ++	       state->skip_broken && (cmd->report.error_message || cmd->did_not_exist))
    + 		cmd = cmd->next;
    + 	if (!cmd)
    + 		return -1; /* EOF */
     @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
      	return finish_command(&proc);
      }
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +{
     +	struct command *cmd;
     +	struct command *hint = NULL;
    -+	struct strbuf extended_status = STRBUF_INIT;
     +	int code = 0;
    ++	int new_options = 1;
     +
     +	for (;;) {
     +		struct object_id old_oid, new_oid;
    -+		const char *status;
    -+		char *refname;
    -+		char *remains = NULL;
    ++		const char *head;
    ++		const char *refname;
    ++		char *p;
     +
     +		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     +			break;
    -+		status = reader->line;
    -+		refname = strchr(status, ' ');
    -+		if (refname) {
    -+			*refname++ = '\0';
    -+			remains = strchr(refname, ' ');
    -+			if (remains)
    -+				*remains++ = '\0';
    ++
    ++		head = reader->line;
    ++		p = strchr(head, ' ');
    ++		if (!p) {
    ++			strbuf_addf(errmsg, "proc-receive reported incomplete status line: '%s'\n", head);
    ++			code = -1;
    ++			continue;
     +		}
    -+		if (!refname || strlen(refname) == 0) {
    -+			strbuf_addf(errmsg, "proc-receive expected '<status> <ref> ...', got '%s'\n",
    -+				    reader->line);
    ++		*p++ = '\0';
    ++		if (!strcmp(head, "option")) {
    ++			struct ref_push_report_options *options;
    ++			const char *key, *val;
    ++
    ++			if (!hint) {
    ++			       if (new_options) {
    ++					strbuf_addstr(errmsg, "proc-receive reported 'option' without a matching 'ok/ng' directive\n");
    ++					new_options = 0;
    ++				}
    ++				code = -1;
    ++				continue;
    ++			}
    ++			options = hint->report.options;
    ++			while (options && options->next)
    ++				options = options->next;
    ++			if (new_options) {
    ++				if (!options) {
    ++					hint->report.options = xcalloc(1, sizeof(struct ref_push_report_options));
    ++					options = hint->report.options;
    ++				} else {
    ++					options->next = xcalloc(1, sizeof(struct ref_push_report_options));
    ++					options = options->next;
    ++				}
    ++				new_options = 0;
    ++			}
    ++			assert(options);
    ++			key = p;
    ++			p = strchr(key, ' ');
    ++			if (p)
    ++				*p++ = '\0';
    ++			val = p;
    ++			if (!strcmp(key, "refname"))
    ++				options->ref_name = xstrdup_or_null(val);
    ++			else if (!strcmp(key, "old-oid") && val &&
    ++				 !parse_oid_hex(val, &old_oid, &val))
    ++				options->old_oid = oiddup(&old_oid);
    ++			else if (!strcmp(key, "new-oid") && val &&
    ++				 !parse_oid_hex(val, &new_oid, &val))
    ++				options->new_oid = oiddup(&new_oid);
    ++			else if (!strcmp(key, "forced-update"))
    ++				options->forced_update = 1;
    ++			else if (!strcmp(key, "fall-through"))
    ++				/* Fall through, let 'receive-pack' to execute it. */
    ++				hint->run_proc_receive = 0;
    ++			continue;
    ++		}
    ++
    ++		refname = p;
    ++		p = strchr(refname, ' ');
    ++		if (p)
    ++			*p++ = '\0';
    ++		if (strcmp(head, "ok") && strcmp(head, "ng")) {
    ++			strbuf_addf(errmsg, "proc-receive reported bad status '%s' on ref '%s'\n",
    ++				    head, refname);
     +			code = -1;
     +			continue;
     +		}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		if (!hint) {
     +			strbuf_addf(errmsg, "proc-receive reported status on unknown ref: %s\n",
     +				    refname);
    ++			code = -1;
     +			continue;
     +		}
     +		if (!hint->run_proc_receive) {
     +			strbuf_addf(errmsg, "proc-receive reported status on unexpected ref: %s\n",
     +				    refname);
    ++			code = -1;
     +			continue;
     +		}
    -+		if (!strcmp(status, "ng")) {
    -+			if (remains)
    -+				hint->error_string = xstrdup(remains);
    ++		if (!strcmp(head, "ng")) {
    ++			if (p)
    ++				hint->report.error_message = xstrdup(p);
     +			else
    -+				hint->error_string = "failed";
    ++				hint->report.error_message = "failed";
     +			code = -1;
    -+		} else if (!strcmp("ft", status)) {
    -+			/* Reset "run_proc_receive" field, and continue to run in "receive-pack" */
    -+			hint->run_proc_receive = 0;
    -+		} else if (!strcmp("alt", status)) {
    -+			char *alt_ref = NULL;
    -+			char *p1, *p2;
    -+
    -+			if (!remains) {
    -+				strbuf_addf(errmsg, "proc-receive expected 'alt <ref> <alt-ref> ...', got 'alt %s'\n",
    -+					    refname);
    -+				continue;
    -+			}
    -+			p1 = strchr(remains, '=');
    -+			p2 = strchr(remains, ' ');
    -+			if (!p1) {
    -+				/*
    -+				 * "alt <ref> <alt-ref>", or
    -+				 * "alt <ref> <alt-ref> forced-update"
    -+				 */
    -+				alt_ref = remains;
    -+				remains = p2;
    -+				if (remains)
    -+					*remains++ = '\0';
    -+			} else if (!p2) {
    -+				/* "alt <ref> old-oid=<oid>" */
    -+				alt_ref = NULL;
    -+			} else if (p1 > p2) {
    -+				/* "alt <ref> <alt-ref> old-oid=<oid>" */
    -+				alt_ref = remains;
    -+				remains = p2;
    -+				if (remains)
    -+					*remains++ = '\0';
    -+			} else {
    -+				/* "alt <ref> old-oid=<oid1> new-oid=<oid2>" */
    -+				alt_ref = NULL;
    -+			}
    -+
    -+			if (hint->extended_status)
    -+				strbuf_addstr(&extended_status, hint->extended_status);
    -+
    -+			/*
    -+			 * Already received an "ok <ref>" response, add an
    -+			 * additional "ref=<ref>" field.
    -+			 */
    -+			if (extended_status.len == 0 &&
    -+			    hint->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)
    -+				strbuf_addf(&extended_status, "ref=%s", refname);
    -+
    -+			if (alt_ref)
    -+				strbuf_addf(&extended_status, "%sref=%s",
    -+					    extended_status.len > 0 ? " ": "",
    -+					    alt_ref);
    -+			else if (extended_status.len > 0)
    -+				/*
    -+				 * Start new extended status for refname, if it
    -+				 * is not the first report for this reference.
    -+				 */
    -+				strbuf_addf(&extended_status, " ref=%s", refname);
    -+
    -+			if (remains) {
    -+				const char *val;
    -+				int len;
    -+
    -+				val = parse_feature_value(remains, "old-oid", &len);
    -+				if (val && len > 0)
    -+					if (!parse_oid_hex(val, &old_oid, &val))
    -+						strbuf_addf(&extended_status, "%sold-oid=%s",
    -+							   extended_status.len > 0 ? " ": "",
    -+							   oid_to_hex(&old_oid));
    -+
    -+				val = parse_feature_value(remains, "new-oid", &len);
    -+				if (val && len > 0)
    -+					if (!parse_oid_hex(val, &new_oid, &val))
    -+						strbuf_addf(&extended_status, "%snew-oid=%s",
    -+							   extended_status.len > 0 ? " ": "",
    -+							   oid_to_hex(&new_oid));
    -+
    -+				if (parse_feature_request(remains, "forced-update"))
    -+					strbuf_addf(&extended_status, "%sforced-update",
    -+						    extended_status.len > 0 ? " ": "");
    -+			}
    -+
    -+			if (extended_status.len > 0) {
    -+				free((void *)hint->extended_status);
    -+				hint->extended_status = strbuf_detach(&extended_status, NULL);
    -+			}
    -+		} else if (strcmp("ok", status)) {
    -+			strbuf_addf(errmsg, "proc-receive reported bad status '%s' on ref '%s'\n",
    -+				    status, refname);
    -+			code = -1;
    -+			/* Skip marking it as RUN_PROC_RECEIVE_RETURNED */
    -+			continue;
     +		}
    -+
     +		if (hint->run_proc_receive)
     +			hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;
    ++		new_options = 1;
     +	}
     +
     +	for (cmd = commands; cmd; cmd = cmd->next)
    -+		if (cmd->run_proc_receive && !cmd->error_string &&
    ++		if (cmd->run_proc_receive && !cmd->report.error_message &&
     +		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
    -+		    cmd->error_string = "proc-receive failed to report status";
    ++		    cmd->report.error_message = "proc-receive failed to report status";
     +		    code = -1;
     +		}
    -+
     +	return code;
     +}
     +
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	struct packet_reader reader;
     +	struct strbuf cap = STRBUF_INIT;
     +	struct strbuf errmsg = STRBUF_INIT;
    -+	int pr_use_push_options = 0;
    ++	int hook_use_push_options = 0;
     +	int version = 0;
     +	int code;
     +
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +			if (linelen < reader.pktlen) {
     +				const char *feature_list = reader.line + linelen + 1;
     +				if (parse_feature_request(feature_list, "push-options"))
    -+					pr_use_push_options = 1;
    ++					hook_use_push_options = 1;
     +			}
     +		}
     +	}
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +
     +	/* Send commands */
     +	for (cmd = commands; cmd; cmd = cmd->next) {
    -+		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
    ++		if (!cmd->run_proc_receive || cmd->skip_update || cmd->report.error_message)
     +			continue;
     +		packet_write_fmt(proc.in, "%s %s %s",
     +				 oid_to_hex(&cmd->old_oid),
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	packet_flush(proc.in);
     +
     +	/* Send push options */
    -+	if (pr_use_push_options) {
    ++	if (hook_use_push_options) {
     +		struct string_list_item *item;
     +
     +		for_each_string_list_item(item, push_options)
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
      static char *refuse_unconfigured_deny_msg =
      	N_("By default, updating the current branch in a non-bare repository\n"
      	   "is denied, because it will make the index and work tree inconsistent\n"
    +@@ builtin/receive-pack.c: static void run_update_post_hook(struct command *commands)
    + 		return;
    + 
    + 	for (cmd = commands; cmd; cmd = cmd->next) {
    +-		if (cmd->error_string || cmd->did_not_exist)
    ++		if (cmd->report.error_message || cmd->did_not_exist)
    + 			continue;
    + 		if (!proc.args.argc)
    + 			argv_array_push(&proc.args, hook);
    +@@ builtin/receive-pack.c: static void check_aliased_update_internal(struct command *cmd,
    + 	if (!dst_name) {
    + 		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
    + 		cmd->skip_update = 1;
    +-		cmd->error_string = "broken symref";
    ++		cmd->report.error_message = "broken symref";
    + 		return;
    + 	}
    + 	dst_name = strip_namespace(dst_name);
    +@@ builtin/receive-pack.c: static void check_aliased_update_internal(struct command *cmd,
    + 		 find_unique_abbrev(&dst_cmd->old_oid, DEFAULT_ABBREV),
    + 		 find_unique_abbrev(&dst_cmd->new_oid, DEFAULT_ABBREV));
    + 
    +-	cmd->error_string = dst_cmd->error_string =
    ++	cmd->report.error_message = dst_cmd->report.error_message =
    + 		"inconsistent aliased update";
    + }
    + 
    +@@ builtin/receive-pack.c: static void check_aliased_updates(struct command *commands)
    + 	string_list_sort(&ref_list);
    + 
    + 	for (cmd = commands; cmd; cmd = cmd->next) {
    +-		if (!cmd->error_string)
    ++		if (!cmd->report.error_message)
    + 			check_aliased_update(cmd, &ref_list);
    + 	}
    + 
    +@@ builtin/receive-pack.c: static void set_connectivity_errors(struct command *commands,
    + 				     &opt))
    + 			continue;
    + 
    +-		cmd->error_string = "missing necessary objects";
    ++		cmd->report.error_message = "missing necessary objects";
    + 	}
    + }
    + 
    +@@ builtin/receive-pack.c: static void reject_updates_to_hidden(struct command *commands)
    + 	prefix_len = refname_full.len;
    + 
    + 	for (cmd = commands; cmd; cmd = cmd->next) {
    +-		if (cmd->error_string)
    ++		if (cmd->report.error_message)
    + 			continue;
    + 
    + 		strbuf_setlen(&refname_full, prefix_len);
    +@@ builtin/receive-pack.c: static void reject_updates_to_hidden(struct command *commands)
    + 		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
    + 			continue;
    + 		if (is_null_oid(&cmd->new_oid))
    +-			cmd->error_string = "deny deleting a hidden ref";
    ++			cmd->report.error_message = "deny deleting a hidden ref";
    + 		else
    +-			cmd->error_string = "deny updating a hidden ref";
    ++			cmd->report.error_message = "deny updating a hidden ref";
    + 	}
    + 
    + 	strbuf_release(&refname_full);
    +@@ builtin/receive-pack.c: static void reject_updates_to_hidden(struct command *commands)
    + 
    + static int should_process_cmd(struct command *cmd)
    + {
    +-	return !cmd->error_string && !cmd->skip_update;
    ++	return !cmd->report.error_message && !cmd->skip_update;
    + }
    + 
    + static void warn_if_skipped_connectivity_check(struct command *commands,
     @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *commands,
      	struct strbuf err = STRBUF_INIT;
      
    @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *
      			continue;
      
      		transaction = ref_transaction_begin(&err);
    + 		if (!transaction) {
    + 			rp_error("%s", err.buf);
    + 			strbuf_reset(&err);
    +-			cmd->error_string = "transaction failed to start";
    ++			cmd->report.error_message = "transaction failed to start";
    + 			continue;
    + 		}
    + 
    +-		cmd->error_string = update(cmd, si);
    ++		cmd->report.error_message = update(cmd, si);
    + 
    +-		if (!cmd->error_string
    ++		if (!cmd->report.error_message
    + 		    && ref_transaction_commit(transaction, &err)) {
    + 			rp_error("%s", err.buf);
    + 			strbuf_reset(&err);
    +-			cmd->error_string = "failed to update ref";
    ++			cmd->report.error_message = "failed to update ref";
    + 		}
    + 		ref_transaction_free(transaction);
    + 	}
     @@ builtin/receive-pack.c: static void execute_commands_atomic(struct command *commands,
      	}
      
    @@ builtin/receive-pack.c: static void execute_commands_atomic(struct command *comm
     +		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
      			continue;
      
    - 		cmd->error_string = update(cmd, si);
    +-		cmd->error_string = update(cmd, si);
    ++		cmd->report.error_message = update(cmd, si);
    + 
    +-		if (cmd->error_string)
    ++		if (cmd->report.error_message)
    + 			goto failure;
    + 	}
    + 
    +@@ builtin/receive-pack.c: static void execute_commands_atomic(struct command *commands,
    + 
    + failure:
    + 	for (cmd = commands; cmd; cmd = cmd->next)
    +-		if (!cmd->error_string)
    +-			cmd->error_string = reported_error;
    ++		if (!cmd->report.error_message)
    ++			cmd->report.error_message = reported_error;
    + 
    + cleanup:
    + 	ref_transaction_free(transaction);
     @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	struct iterate_data data;
      	struct async muxer;
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      
      	if (unpacker_error) {
      		for (cmd = commands; cmd; cmd = cmd->next)
    +-			cmd->error_string = "unpacker error";
    ++			cmd->report.error_message = "unpacker error";
    + 		return;
    + 	}
    + 
     @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      
      	reject_updates_to_hidden(commands);
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +
      	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
      		for (cmd = commands; cmd; cmd = cmd->next) {
    - 			if (!cmd->error_string)
    +-			if (!cmd->error_string)
    +-				cmd->error_string = "pre-receive hook declined";
    ++			if (!cmd->report.error_message)
    ++				cmd->report.error_message = "pre-receive hook declined";
    + 		}
    + 		return;
    + 	}
    +@@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
    + 	 */
    + 	if (tmp_objdir_migrate(tmp_objdir) < 0) {
    + 		for (cmd = commands; cmd; cmd = cmd->next) {
    +-			if (!cmd->error_string)
    +-				cmd->error_string = "unable to migrate objects to permanent storage";
    ++			if (!cmd->report.error_message)
    ++				cmd->report.error_message = "unable to migrate objects to permanent storage";
    + 		}
    + 		return;
    + 	}
     @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
      	free(head_name_to_free);
      	head_name = head_name_to_free = resolve_refdup("HEAD", 0, NULL, NULL);
    @@ builtin/receive-pack.c: static void execute_commands(struct command *commands,
     +	if (run_proc_receive &&
     +	    run_proc_receive_hook(commands, push_options))
     +		for (cmd = commands; cmd; cmd = cmd->next)
    -+			if (!cmd->error_string  && (cmd->run_proc_receive || use_atomic))
    -+				cmd->error_string = "fail to run proc-receive hook";
    ++			if (!cmd->report.error_message  && (cmd->run_proc_receive || use_atomic))
    ++				cmd->report.error_message = "fail to run proc-receive hook";
     +
      	if (use_atomic)
      		execute_commands_atomic(commands, si);
      	else
    +@@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands,
    + 		if (is_null_oid(&cmd->new_oid))
    + 			continue;
    + 		if (ref_status[cmd->index]) {
    +-			cmd->error_string = "shallow update not allowed";
    ++			cmd->report.error_message = "shallow update not allowed";
    + 			cmd->skip_update = 1;
    + 		}
    + 	}
     @@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
      	packet_buf_write(&buf, "unpack %s\n",
      			 unpack_status ? unpack_status : "ok");
      	for (cmd = commands; cmd; cmd = cmd->next) {
     -		if (!cmd->error_string)
    --			packet_buf_write(&buf, "ok %s\n",
    ++		if (!cmd->report.error_message)
    + 			packet_buf_write(&buf, "ok %s\n",
     -					 cmd->ref_name);
    --		else
    --			packet_buf_write(&buf, "ng %s %s\n",
    --					 cmd->ref_name, cmd->error_string);
    -+		if (!cmd->error_string) {
    -+			if (cmd->extended_status)
    -+				packet_buf_write(&buf, "ok %s%c%s\n",
    -+						 cmd->ref_name, '\0',
    -+						 cmd->extended_status);
    -+			else
    -+				packet_buf_write(&buf, "ok %s\n",
     +						 cmd->ref_name);
    -+		} else {
    -+			if (cmd->extended_status)
    -+				packet_buf_write(&buf, "ng %s %s%c%s\n",
    -+						 cmd->ref_name, cmd->error_string,
    -+						 '\0', cmd->extended_status);
    -+			else
    -+				packet_buf_write(&buf, "ng %s %s\n",
    -+						 cmd->ref_name, cmd->error_string);
    -+		}
    + 		else
    + 			packet_buf_write(&buf, "ng %s %s\n",
    +-					 cmd->ref_name, cmd->error_string);
    ++					 cmd->ref_name, cmd->report.error_message);
      	}
      	packet_buf_flush(&buf);
      
    +@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
    + 		if (!check_cert_push_options(&push_options)) {
    + 			struct command *cmd;
    + 			for (cmd = commands; cmd; cmd = cmd->next)
    +-				cmd->error_string = "inconsistent push options";
    ++				cmd->report.error_message = "inconsistent push options";
    + 		}
    + 
    + 		prepare_shallow_info(&si, &shallow);
    +
    + ## remote.h ##
    +@@ remote.h: int for_each_remote(each_remote_fn fn, void *priv);
    + 
    + int remote_has_url(struct remote *remote, const char *url);
    + 
    ++struct ref_push_report_options {
    ++	char *ref_name;
    ++	struct object_id *old_oid;
    ++	struct object_id *new_oid;
    ++	unsigned int forced_update:1;
    ++	struct ref_push_report_options *next;
    ++};
    ++
    ++struct ref_push_report {
    ++	const char *message;
    ++	const char *error_message;
    ++	struct ref_push_report_options *options;
    ++};
    ++
    + struct ref {
    + 	struct ref *next;
    + 	struct object_id old_oid;
     
      ## t/helper/test-proc-receive.c (new) ##
     @@
    @@ t/t5411/test-0012-no-hook-error--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       next(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: no hook, fail to push special ref (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: no hook, fail to push special ref ($PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:next \
     +		HEAD:refs/for/master/topic \
    @@ t/t5411/test-0012-no-hook-error--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push --atomic: (B)                   next(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: no hook, all failed for atomic push (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: no hook, all failed for atomic push ($PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain --atomic origin \
     +		$B:master \
     +		HEAD:next \
    @@ t/t5411/test-0013-bad-protocol.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok
    -+	remote: error: proc-receive expected "<status> <ref> ...", got "ok"
    ++	remote: error: proc-receive reported incomplete status line: "ok"
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: bad protocol (unknown version, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       next(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: bad protocol (no report, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/heads/next \
     +		HEAD:refs/for/master/topic >out 2>&1 &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: bad protocol (no ref, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic\
     +		>out 2>&1 &&
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok
    -+	remote: error: proc-receive expected "<status> <ref> ...", got "ok"
    ++	remote: error: proc-receive reported incomplete status line: "ok"
     +	To <URL/of/upstream.git>
     +	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
     +	Done
    @@ t/t5411/test-0014-bad-protocol--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: bad protocol (unknown status, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +			HEAD:refs/for/master/topic \
     +			>out 2>&1 &&
    @@ t/t5411/test-0021-report-ng--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: fail to update (ng, no message, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0021-report-ng--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: fail to update (ng, with message, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: fail to update (ng, with message, $PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0023-report-unexpect-ref--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         : (B)                   refs/for/master/topic
    -+test_expect_success "proc-receive: report unexpected ref (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/for/master/topic \
    @@ t/t5411/test-0025-report-unknown-ref--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/a/b/c/my/topic
    -+test_expect_success "proc-receive: report unknown reference (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report unknown reference ($PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/a/b/c/my/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0027-push-options--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -o ...  :                       refs/for/master/topic
    -+test_expect_success "proc-receive: not support push options (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push \
     +		--porcelain \
     +		-o issue=123 \
    @@ t/t5411/test-0027-push-options--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -o ...  :                       next(A)  refs/for/master/topic
    -+test_expect_success "proc-receive: push with options (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: push with options ($PROTOCOL/porcelain)" '
     +	git -C workbench push \
     +		--porcelain \
     +		--atomic \
    @@ t/t5411/test-0031-report-ok--porcelain.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic
    -+test_expect_success "proc-receive: ok (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: ok ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0031-report-ok--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     
    - ## t/t5411/test-0032-report-alt.sh (new) ##
    + ## t/t5411/test-0032-report-with-options.sh (new) ##
     @@
    -+test_expect_success "setup proc-receive hook (alt <ref>, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option without matching ok, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic"
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option old-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref>, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)" '
     +	test_must_fail git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic
    -+	remote: error: proc-receive expected "alt <ref> <alt-ref> ...", got "alt refs/for/master/topic"
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
     +	To <URL/of/upstream.git>
     +	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
     +	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref>, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option refname, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/pull/123/head"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> forced-update, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option refname and forced-update, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/pull/123/head forced-update"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option forced-update"
     +	EOF
     +'
    -+
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option refname and forced-update ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option forced-update
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> old-oid=X, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option old-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic old-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X new-oid=Y, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (with multiple alt reports, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (report with multiple rewrites, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
     +		-r "ok refs/for/a/b/c/topic" \
    -+		-r "alt refs/for/next/topic refs/pull/123/head" \
    -+		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
    ++		-r "ok refs/for/next/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/124/head" \
    ++		-r "option old-oid $B" \
    ++		-r "option forced-update" \
    ++		-r "option new-oid $A"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: with multiple alt reports ($PROTOCOL)" '
    ++test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/next/topic \
     +		HEAD:refs/for/a/b/c/topic \
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok refs/for/a/b/c/topic
    -+	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
    ++	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/124/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: proc-receive> option forced-update
    ++	remote: proc-receive> option new-oid <COMMIT-A>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    @@ t/t5411/test-0032-report-alt.sh (new)
     +	test_cmp expect actual
     +'
     
    - ## t/t5411/test-0033-report-alt--porcelain.sh (new) ##
    + ## t/t5411/test-0033-report-with-options--porcelain.sh (new) ##
     @@
    -+test_expect_success "setup proc-receive hook (alt <ref>, --porcelain, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option without matching ok, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic"
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option old-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref>, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/porcelain)" '
     +	test_must_fail git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic
    -+	remote: error: proc-receive expected "alt <ref> <alt-ref> ...", got "alt refs/for/master/topic"
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: error: proc-receive reported "option" without a matching "ok/ng" directive
     +	To <URL/of/upstream.git>
     +	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
     +	Done
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref>, --porcelain, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option refname, $PROTOCOL/porcelain)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/pull/123/head"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref>, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> forced-update, --porcelain, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option refname and forced-update, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/pull/123/head forced-update"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option forced-update"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> forced-update, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option refname and forced-update ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head forced-update
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option forced-update
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> <alt-ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option old-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> <alt-ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic old-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (alt <ref> old-oid=X new-oid=Y, --porcelain, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTOCOL/porcelain)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report alt (alt <ref> old-oid=X new-oid=Y, --porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (with multiple alt reports, --porcelain, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (report with multiple rewrites, $PROTOCOL/porcelain)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
     +		-r "ok refs/for/a/b/c/topic" \
    -+		-r "alt refs/for/next/topic refs/pull/123/head" \
    -+		-r "alt refs/for/master/topic refs/pull/124/head old-oid=$B forced-update new-oid=$A"
    ++		-r "ok refs/for/next/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/124/head" \
    ++		-r "option old-oid $B" \
    ++		-r "option forced-update" \
    ++		-r "option new-oid $A"
    ++
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/next/topic(A)  refs/for/a/b/c/topic(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: with multiple alt reports (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/next/topic \
     +		HEAD:refs/for/a/b/c/topic \
    @@ t/t5411/test-0033-report-alt--porcelain.sh (new)
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok refs/for/a/b/c/topic
    -+	remote: proc-receive> alt refs/for/next/topic refs/pull/123/head
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/124/head old-oid=<COMMIT-B> forced-update new-oid=<COMMIT-A>
    ++	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/124/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: proc-receive> option forced-update
    ++	remote: proc-receive> option new-oid <COMMIT-A>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
    @@ t/t5411/test-0034-report-ft.sh (new)
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ft refs/for/master/topic"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option fall-through"
     +	EOF
     +'
     +
    @@ t/t5411/test-0034-report-ft.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    -+	remote: proc-receive> ft refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option fall-through
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0034-report-ft.sh (new)
     
      ## t/t5411/test-0035-report-ft--porcelain.sh (new) ##
     @@
    -+test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (fall-through, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ft refs/for/master/topic"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option fall-through"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(B)
    -+test_expect_success "proc-receive: fall throught, let receive-pack to execute (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		$B:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0035-report-ft--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
    -+	remote: proc-receive> ft refs/for/master/topic
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option fall-through
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-B> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0035-report-ft--porcelain.sh (new)
     +	git -C "$upstream" update-ref -d refs/for/master/topic
     +'
     
    - ## t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new) ##
    + ## t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh (new) ##
     @@
    -+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 1st resp, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    -+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$A new-oid=$B"
    -+	EOF
    -+'
    -+
    -+# Refs of upstream : master(A)
    -+# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st resp ($PROTOCOL)" '
    -+	git -C workbench push origin \
    -+		HEAD:refs/for/master/topic \
    -+		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	To <URL/of/upstream.git>
    -+	 * [new reference] HEAD -> refs/for/master/topic
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
    -+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 2nd resp, $PROTOCOL)" '
    -+	write_script "$upstream/hooks/proc-receive" <<-EOF
    -+	printf >&2 "# proc-receive hook\n"
    -+	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    -+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    -+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$B new-oid=$A forced-update"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/24/124/1" \
    ++		-r "option old-oid $ZERO_OID" \
    ++		-r "option new-oid $A" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/25/125/1" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd resp ($PROTOCOL)" '
    ++test_expect_success "proc-receive: multiple rewrite for one ref, no refname for the 1st rewrite ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/24/124/1
    ++	remote: proc-receive> option old-oid <ZERO-OID>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/25/125/1
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (ok and alt for the same ref, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
     +		-r "ok refs/for/master/topic" \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/1 new-oid=$B old-oid=$A"
    ++		-r "option refname refs/changes/24/124/1" \
    ++		-r "option old-oid $ZERO_OID" \
    ++		-r "option new-oid $A" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/25/125/1" \
    ++		-r "option old-oid $B" \
    ++		-r "option new-oid $A" \
    ++		-r "option forced-update"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report ok and alt for the same ref ($PROTOCOL)" '
    ++test_expect_success "proc-receive: multiple rewrites for one ref, no refname for the 2nd rewrite ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
    ++	remote: proc-receive> option refname refs/changes/24/124/1
    ++	remote: proc-receive> option old-oid <ZERO-OID>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/25/125/1
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> option forced-update
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (multiple responses, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/changes/23/123/1" \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/2 old-oid=$A new-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/23/123/1" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/24/124/2" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report multiple response ($PROTOCOL)" '
    ++test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/23/123/1
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/24/124/2
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0036-report-multi-alt-for-one-ref.sh (new)
     +	test_cmp expect actual
     +'
     
    - ## t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh (new) ##
    + ## t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh (new) ##
     @@
    -+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 1st resp, $PROTOCOL)" '
    -+	write_script "$upstream/hooks/proc-receive" <<-EOF
    -+	printf >&2 "# proc-receive hook\n"
    -+	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    -+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$A new-oid=$B"
    -+	EOF
    -+'
    -+
    -+# Refs of upstream : master(A)
    -+# Refs of workbench: master(A)  tags/v123
    -+# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 1st resp (--porcelain, $PROTOCOL)" '
    -+	git -C workbench push --porcelain origin \
    -+		HEAD:refs/for/master/topic \
    -+		>out 2>&1 &&
    -+	make_user_friendly_and_stable_output <out >actual &&
    -+	cat >expect <<-EOF &&
    -+	remote: # pre-receive hook
    -+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: # proc-receive hook
    -+	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: # post-receive hook
    -+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	To <URL/of/upstream.git>
    -+	*    HEAD:refs/for/master/topic    [new reference]
    -+	Done
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
    -+test_expect_success "setup proc-receive hook (multiple alt, no alt-ref for the 2nd resp, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/1 old-oid=$ZERO_OID new-oid=$A" \
    -+		-r "alt refs/for/master/topic old-oid=$A new-oid=$B" \
    -+		-r "alt refs/for/master/topic refs/changes/25/125/1 old-oid=$B new-oid=$A forced-update"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/24/124/1" \
    ++		-r "option old-oid $ZERO_OID" \
    ++		-r "option new-oid $A" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/25/125/1" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report multiple alt, no alt-ref for the 2nd resp (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: multiple rewrite for one ref, no refname for the 1st rewrite ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 old-oid=<ZERO-OID> new-oid=<COMMIT-A>
    -+	remote: proc-receive> alt refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/25/125/1 old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/24/124/1
    ++	remote: proc-receive> option old-oid <ZERO-OID>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/25/125/1
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (ok and alt for the same ref, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
     +		-r "ok refs/for/master/topic" \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/1 new-oid=$B old-oid=$A"
    ++		-r "option refname refs/changes/24/124/1" \
    ++		-r "option old-oid $ZERO_OID" \
    ++		-r "option new-oid $A" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/25/125/1" \
    ++		-r "option old-oid $B" \
    ++		-r "option new-oid $A" \
    ++		-r "option forced-update"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report ok and alt for the same ref (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: multiple rewrites for one ref, no refname for the 2nd rewrite ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh (new)
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/1 new-oid=<COMMIT-B> old-oid=<COMMIT-A>
    ++	remote: proc-receive> option refname refs/changes/24/124/1
    ++	remote: proc-receive> option old-oid <ZERO-OID>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/25/125/1
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> option forced-update
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "setup proc-receive hook (multiple responses, $PROTOCOL)" '
    ++test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "alt refs/for/master/topic refs/changes/23/123/1" \
    -+		-r "alt refs/for/master/topic refs/changes/24/124/2 old-oid=$A new-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/23/123/1" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/changes/24/124/2" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         :                       refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report multiple response (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		HEAD:refs/for/master/topic \
     +		>out 2>&1 &&
    @@ t/t5411/test-0037-report-multi-alt-for-one-ref--porcelain.sh (new)
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: # proc-receive hook
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/23/123/1
    -+	remote: proc-receive> alt refs/for/master/topic refs/changes/24/124/2 old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/23/123/1
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/changes/24/124/2
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	To <URL/of/upstream.git>
    @@ t/t5411/test-0038-report-mixed-refs.sh (new)
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
     +		-r "ok refs/for/next/topic" \
    -+		-r "alt refs/for/master/topic refs/for/master/topic old-oid=$A new-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
    @@ t/t5411/test-0038-report-mixed-refs.sh (new)
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok refs/for/next/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
    @@ t/t5411/test-0038-report-mixed-refs.sh (new)
     +		git update-ref -d refs/heads/bar &&
     +		git update-ref -d refs/heads/baz
     +	)
    -+
     +'
     
      ## t/t5411/test-0039-report-mixed-refs--porcelain.sh (new) ##
    @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh (new)
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
     +		-r "ok refs/for/next/topic" \
    -+		-r "alt refs/for/master/topic refs/for/master/topic old-oid=$A new-oid=$B"
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/for/master/topic" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B"
     +	EOF
     +'
     +
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push         : (B)                   bar(A)  baz(A)  refs/for/next/topic(A)  foo(A)  refs/for/master/topic(A)
    -+test_expect_success "proc-receive: report update of mixed refs (--porcelain, $PROTOCOL)" '
    ++test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain origin \
     +		$B:refs/heads/master \
     +		HEAD:refs/heads/bar \
    @@ t/t5411/test-0039-report-mixed-refs--porcelain.sh (new)
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive> ok refs/for/next/topic
    -+	remote: proc-receive> alt refs/for/master/topic refs/for/master/topic old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/for/master/topic
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/bar
4:  d01004ff52 < -:  ---------- send-pack: extension for client-side status report
5:  583b5bdfcd < -:  ---------- receive-pack: feed extended_status to post-receive
-:  ---------- > 3:  267da25afd New capability "report-status-v2" for git-push
-:  ---------- > 4:  2cc92d9383 receive-pack: feed report options to post-receive
6:  860be91506 = 5:  47c5e59c9a refs.c: refactor to reuse ref_is_hidden()
7:  9489db75e6 ! 6:  37e041156f receive-pack: new config receive.procReceiveRefs
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
    @@ t/t5411/test-0040-process-all-refs.sh (new)
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ft refs/heads/master" \
    -+		-r "ft refs/heads/foo" \
    -+		-r "ft refs/heads/bar" \
    -+		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$A new-oid=$B " \
    -+		-r "alt refs/for/next/topic refs/pull/124/head old-oid=$B new-oid=$A forced-update"
    ++		-r "ok refs/heads/master" \
    ++		-r "option fall-through" \
    ++		-r "ok refs/heads/foo" \
    ++		-r "option fall-through" \
    ++		-r "ok refs/heads/bar" \
    ++		-r "option fall-through" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B" \
    ++		-r "ok refs/for/next/topic" \
    ++		-r "option refname refs/pull/124/head" \
    ++		-r "option old-oid $B" \
    ++		-r "option new-oid $A" \
    ++		-r "option forced-update"
     +	EOF
     +'
     +
    @@ t/t5411/test-0040-process-all-refs.sh (new)
     +	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: proc-receive> ft refs/heads/master
    -+	remote: proc-receive> ft refs/heads/foo
    -+	remote: proc-receive> ft refs/heads/bar
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: proc-receive> alt refs/for/next/topic refs/pull/124/head old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
    ++	remote: proc-receive> ok refs/heads/master
    ++	remote: proc-receive> option fall-through
    ++	remote: proc-receive> ok refs/heads/foo
    ++	remote: proc-receive> option fall-through
    ++	remote: proc-receive> ok refs/heads/bar
    ++	remote: proc-receive> option fall-through
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
    ++	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive> option refname refs/pull/124/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> option forced-update
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
     +	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
    @@ t/t5411/test-0041-process-all-refs--porcelain.sh (new)
     +	write_script "$upstream/hooks/proc-receive" <<-EOF
     +	printf >&2 "# proc-receive hook\n"
     +	test-tool proc-receive -v \
    -+		-r "ft refs/heads/master" \
    -+		-r "ft refs/heads/foo" \
    -+		-r "ft refs/heads/bar" \
    -+		-r "alt refs/for/master/topic refs/pull/123/head old-oid=$A new-oid=$B " \
    -+		-r "alt refs/for/next/topic refs/pull/124/head old-oid=$B new-oid=$A forced-update"
    ++		-r "ok refs/heads/master" \
    ++		-r "option fall-through" \
    ++		-r "ok refs/heads/foo" \
    ++		-r "option fall-through" \
    ++		-r "ok refs/heads/bar" \
    ++		-r "option fall-through" \
    ++		-r "ok refs/for/master/topic" \
    ++		-r "option refname refs/pull/123/head" \
    ++		-r "option old-oid $A" \
    ++		-r "option new-oid $B" \
    ++		-r "ok refs/for/next/topic" \
    ++		-r "option refname refs/pull/124/head" \
    ++		-r "option old-oid $B" \
    ++		-r "option new-oid $A" \
    ++		-r "option forced-update"
     +	EOF
     +'
     +
     +# Refs of upstream : master(B)             foo(A)  bar(A))  baz(A)
     +# Refs of workbench: master(A)  tags/v123
     +# git push -f      : master(A)             (NULL)  (B)              refs/for/master/topic(A)  refs/for/next/topic(A)
    -+test_expect_success "proc-receive: process all refs (--porcelain) ($PROTOCOL)" '
    ++test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
     +	git -C workbench push --porcelain -f origin \
     +		HEAD:refs/heads/master \
     +		:refs/heads/foo \
    @@ t/t5411/test-0041-process-all-refs--porcelain.sh (new)
     +	remote: proc-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
     +	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
    -+	remote: proc-receive> ft refs/heads/master
    -+	remote: proc-receive> ft refs/heads/foo
    -+	remote: proc-receive> ft refs/heads/bar
    -+	remote: proc-receive> alt refs/for/master/topic refs/pull/123/head old-oid=<COMMIT-A> new-oid=<COMMIT-B>
    -+	remote: proc-receive> alt refs/for/next/topic refs/pull/124/head old-oid=<COMMIT-B> new-oid=<COMMIT-A> forced-update
    ++	remote: proc-receive> ok refs/heads/master
    ++	remote: proc-receive> option fall-through
    ++	remote: proc-receive> ok refs/heads/foo
    ++	remote: proc-receive> option fall-through
    ++	remote: proc-receive> ok refs/heads/bar
    ++	remote: proc-receive> option fall-through
    ++	remote: proc-receive> ok refs/for/master/topic
    ++	remote: proc-receive> option refname refs/pull/123/head
    ++	remote: proc-receive> option old-oid <COMMIT-A>
    ++	remote: proc-receive> option new-oid <COMMIT-B>
    ++	remote: proc-receive> ok refs/for/next/topic
    ++	remote: proc-receive> option refname refs/pull/124/head
    ++	remote: proc-receive> option old-oid <COMMIT-B>
    ++	remote: proc-receive> option new-oid <COMMIT-A>
    ++	remote: proc-receive> option forced-update
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/bar
     +	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/foo
8:  187a723d71 ! 7:  5e08df63d2 doc: add documentation for the proc-receive hook
    @@ Documentation/githooks.txt: The default 'update' hook, when enabled--and with
      `hooks.allowunannotated` config option unset or set to false--prevents
      unannotated tags to be pushed.
      
    ++[[proc-receive]]
     +proc-receive
     +~~~~~~~~~~~~
     +
    @@ Documentation/githooks.txt: The default 'update' hook, when enabled--and with
     +    # NO, I reject it.
     +    H: PKT-LINE(ng <ref> <reason>)
     +    # Fall through, let 'receive-pack' to execute it.
    -+    H: PKT-LINE(ft <ref>)
    ++    H: PKT-LINE(ok <ref>)
    ++    H: PKT-LINE(option fall-through)
     +    # OK, but has an alternate reference.  The alternate reference name
    -+    # is given in the third parameter, and other status can be given in
    -+    # key-value pairs.
    -+    H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
    -+                forced-update)
    ++    # and other status can be given in options
    ++    H: PKT-LINE(ok <ref>)
    ++    H: PKT-LINE(option refname <refname>)
    ++    H: PKT-LINE(option old-oid <old-oid>)
    ++    H: PKT-LINE(option new-oid <new-oid>)
    ++    H: PKT-LINE(option forced-update)
     +    H: ... ...
     +    H: flush-pkt
     +
     +Each command for the 'proc-receive' hook may point to a pseudo-reference
     +and always has a zero-old as its old-oid, while the 'proc-receive' hook
     +may update an alternate reference and the alternate reference may exist
    -+already with a non-zero old-oid.  For this case, this hook may return
    -+different OID and different reference name as extended status of the
    -+report line.
    ++already with a non-zero old-oid.  For this case, this hook will use
    ++"option" directives to report extended attributes for the reference given
    ++by the above "ok/ng" directive.
     +
     +The report of the commands of this hook should have the same order as
     +the input.  The exit status of the 'proc-receive' hook only determines

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
 builtin/receive-pack.c                        | 459 ++++++++++++++++--
 builtin/send-pack.c                           |  21 +-
 refs.c                                        |  13 +-
 refs.h                                        |   1 +
 remote.c                                      |   7 +-
 remote.h                                      |  16 +-
 send-pack.c                                   |  96 +++-
 t/helper/test-proc-receive.c                  | 175 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411-proc-receive-hook.sh                  | 106 ++++
 t/t5411/common-functions.sh                   |  56 +++
 t/t5411/test-0000-standard-git-push.sh        |  84 ++++
 .../test-0001-standard-git-push--porcelain.sh |  86 ++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0011-no-hook-error.sh            |  64 +++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 +++
 t/t5411/test-0013-bad-protocol.sh             | 225 +++++++++
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
 t/t5411/test-0038-report-mixed-refs.sh        |  79 +++
 .../test-0039-report-mixed-refs--porcelain.sh |  81 ++++
 t/t5411/test-0040-process-all-refs.sh         | 113 +++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 +++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport-helper.c                            |  53 +-
 transport.c                                   | 121 +++--
 47 files changed, 3737 insertions(+), 93 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
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

