Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E4C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D630820702
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMh0o7Xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHXRmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHXRmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7AC061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w186so2793480pgb.8
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yK1ekV9uqhgmFLbtxLiQKwes0IxRLBfN3IYjy7kSpF8=;
        b=KMh0o7XaRZoJhFoGGPt6NMa8fwnHDvtm1KGtg0MX+yiFe6dcpFUqq8ELaJAHKtrBP5
         QkN6+PmmQqlBCFkUL0MsQwL6owNob+n8uy/BgOBFuZTa54CTwWda+cHa44TzMrSH8cd3
         JzsSsgnR1Q5uu02C+jy1cukZHTiSJxOk2QnWcRzCVd9U+mSuOlv17dRSwJ61J4ov1frV
         v+Wp2vuw2E57D8KEod/6k/HtAqLk54KK22dviAlcUM/ekjEz11Fr0St6sbX8Fexsf+22
         +T2OzNEUU9XaFuRoLR5JngAkVCqe0AmK2m3Stvf1ayTFsvnQuyb3oCATlDaeQKxSsLIW
         fYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yK1ekV9uqhgmFLbtxLiQKwes0IxRLBfN3IYjy7kSpF8=;
        b=H11yOnUxfZTExFYdi3+QLjKgg1CKPQHkkMNXfUPM3uAwLqsH7juAGq3CvZ65IUbizz
         BbmzIpM8xSzZIcQp8GA1/ue779JWfYmqAUohoegGZsqJi7x58t9ER5iaplpq51uNgV/g
         TYk+4ma0eWAMfUdcXorvlBF22pFiOi3aaXNjwSBGoAxBftWt5kU5HjYyTgVCCACMQjo2
         +SPuXLuKbWX21V4VbWMpzZfPKPoC3tMtFaeg3i74PAq99esO7ovwQ1gRAXNTlYLeQ3KH
         mK7HgsuzFYKlguiyJ/JrAZHlyEaphBm+yQvVtedrlDmGIFO+BvyX9u6iu9kjwaVc5d/l
         UeDQ==
X-Gm-Message-State: AOAM531sE3Vkh33xjEdviSKW9K8QTNBqe4IKBQgwxFXywHGkZl/ZerGW
        cDDPHHEIn5GmKay60vE0qfo=
X-Google-Smtp-Source: ABdhPJxolvJsninj+6dSYfO4IF6J1yQR0c9ngHdmMX8lBUHk4Rx0fb6aF9l4FfTL8KLYEMzjHPRM4g==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr2198792pgh.407.1598290932594;
        Mon, 24 Aug 2020 10:42:12 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:11 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 00/10] New proc-receive hook for centralized workflow
Date:   Mon, 24 Aug 2020 13:41:52 -0400
Message-Id: <20200824174202.11710-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200815171740.6257-1-worldhello.net@gmail.com>
References: <20200815171740.6257-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v17

Fixed all issues found in review on v17.

> Did I????  I do not think I deserve any credit here.

    @@ Commit message
         extended in latter commit just like what the "proc-receive" hook reports
         to "receive-pack".
     
    -    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>


> Does the last cast really needed, perhaps the caller is adding
> "const" to its objects where it is not needed, or the variable
> caller uses to receive the returned value of too loose a type?

     @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
      	return finish_command(&proc);
      }
      
    -+static struct command *find_command_by_refname(const struct command *list,
    ++static struct command *find_command_by_refname(struct command *list,
     +					       const char *refname)
     +{
     +	for (; list; list = list->next)
     +		if (!strcmp(list->ref_name, refname))
    -+			return (struct command *)list;
    ++			return list;
     +	return NULL;
     +}
     +

> Let BSS do its job by omitting " = 0;" and " = NULL;" at the end.

    @@ t/helper/test-proc-receive.c (new)
     +	NULL
     +};
     +
    -+static int die_version = 0;
    -+static int die_readline = 0;
    -+static int no_push_options = 0;
    -+static int use_atomic = 0;
    -+static int use_push_options = 0;
    -+static int verbose = 0;
    ++static int die_version;
    ++static int die_readline;
    ++static int no_push_options;
    ++static int use_atomic;
    ++static int use_push_options;
    ++static int verbose;
     +static int version = 1;
     +static struct string_list returns = STRING_LIST_INIT_NODUP;
     +

> This comment applies to all the patches in this series that adds the
> same pattern, but 
> 
>  * "ref->report.options" may be a good name in that it is a (linked)
>    list of options;
> 
>  * The variable that is used to iterate over the list points at one
>    of the elements on the list at any time, and is better called
>    'option' without 's' at the end.

Merge "struct ref_push_report_options" into "struct ref_push_report".

     @@ remote.h: int for_each_remote(each_remote_fn fn, void *priv);
      
      int remote_has_url(struct remote *remote, const char *url);
      
    -+struct ref_push_report_options {
    ++struct ref_push_report {
     +	const char *ref_name;
     +	struct object_id *old_oid;
     +	struct object_id *new_oid;
     +	unsigned int forced_update:1;
    -+	struct ref_push_report_options *next;
    -+};
    -+
    -+struct ref_push_report {
    -+	const char *message;
    -+	const char *error_message;
    -+	struct ref_push_report_options *options;
    ++	struct ref_push_report *next;
     +};
     +
      struct ref {

> If there was an error, the first one gets "ng" but all others say it
> was "ok"?  That smells somewhat strange.

> Would this one ever report a "ng" for an error?

Preserve "error_string" in command, and no "options" for an "ng" error.

    @@ builtin/receive-pack.c: static void write_head_info(void)
     +#define RUN_PROC_RECEIVE_RETURNED	2
      struct command {
      	struct command *next;
    --	const char *error_string;
    -+	struct ref_push_report report;
    + 	const char *error_string;
    ++	struct ref_push_report *report;
      	unsigned int skip_update:1,
     -		     did_not_exist:1;
     +		     did_not_exist:1,


    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +{
     +	struct command *cmd;
     +	struct command *hint = NULL;
    ++	struct ref_push_report *report = NULL;
    ++	int new_report = 0;
     +	int code = 0;
    -+	int new_options = 1;
    ++	int once = 0;
     +
     +	for (;;) {
     +		struct object_id old_oid, new_oid;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +		}
     +		*p++ = '\0';
     +		if (!strcmp(head, "option")) {
    -+			struct ref_push_report_options *options;
     +			const char *key, *val;
     +
    -+			if (!hint) {
    -+			       if (new_options) {
    ++			if (!hint || !(report || new_report)) {
    ++				if (!once++)
     +					strbuf_addstr(errmsg, "proc-receive reported 'option' without a matching 'ok/ng' directive\n");
    -+					new_options = 0;
    -+				}
     +				code = -1;
     +				continue;
     +			}
    -+			options = hint->report.options;
    -+			while (options && options->next)
    -+				options = options->next;
    -+			if (new_options) {
    -+				if (!options) {
    -+					hint->report.options = xcalloc(1, sizeof(struct ref_push_report_options));
    -+					options = hint->report.options;
    ++			if (new_report) {
    ++				if (!hint->report) {
    ++					hint->report = xcalloc(1, sizeof(struct ref_push_report));
    ++					report = hint->report;
     +				} else {
    -+					options->next = xcalloc(1, sizeof(struct ref_push_report_options));
    -+					options = options->next;
    ++					report = hint->report;
    ++					while (report->next)
    ++						report = report->next;
    ++					report->next = xcalloc(1, sizeof(struct ref_push_report));
    ++					report = report->next;
     +				}
    -+				new_options = 0;
    ++				new_report = 0;
     +			}
    -+			assert(options);
     +			key = p;
     +			p = strchr(key, ' ');
     +			if (p)
     +				*p++ = '\0';
     +			val = p;
     +			if (!strcmp(key, "refname"))
    -+				options->ref_name = xstrdup_or_null(val);
    ++				report->ref_name = xstrdup_or_null(val);
     +			else if (!strcmp(key, "old-oid") && val &&
     +				 !parse_oid_hex(val, &old_oid, &val))
    -+				options->old_oid = oiddup(&old_oid);
    ++				report->old_oid = oiddup(&old_oid);
     +			else if (!strcmp(key, "new-oid") && val &&
     +				 !parse_oid_hex(val, &new_oid, &val))
    -+				options->new_oid = oiddup(&new_oid);
    ++				report->new_oid = oiddup(&new_oid);
     +			else if (!strcmp(key, "forced-update"))
    -+				options->forced_update = 1;
    ++				report->forced_update = 1;
     +			else if (!strcmp(key, "fall-through"))
     +				/* Fall through, let 'receive-pack' to execute it. */
     +				hint->run_proc_receive = 0;
     +			continue;
     +		}
     +
    ++		report = NULL;
    ++		new_report = 0;
     +		refname = p;
     +		p = strchr(refname, ' ');
     +		if (p)

> Our naming convention avoids leading underscore (instead we use _1
> suffix, when we cannot come up with a better name).

Rename "_print_one_push_status" to "print_one_push_report".

    @@ transport.c: static void print_ok_ref_status(struct ref *ref, int porcelain, int
      
      		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg,
     -				 porcelain, summary_width);
    -+				 options, porcelain, summary_width);
    ++				 report, porcelain, summary_width);
      		strbuf_release(&quickref);
      	}
      }
      
     -static int print_one_push_status(struct ref *ref, const char *dest, int count,
    --				 int porcelain, int summary_width)
    -+static int _print_one_push_status(struct ref *ref, const char *dest, int count,
    -+				  struct ref_push_report_options *options,
    -+				  int porcelain, int summary_width)
    ++static int print_one_push_report(struct ref *ref, const char *dest, int count,
    ++				 struct ref_push_report *report,
    + 				 int porcelain, int summary_width)
      {
      	if (!count) {
    - 		char *url = transport_anonymize_url(dest);


> I hate to see more helper functions turned into pieces that are
> impossible to reuse by gaining internal state like this.  Does this
> function have so many callers that makes it impractical to update
> its signature to have the pointer to a "state" structure passed by
> the caller?  This is called only from push_update_refs_status(), so
> you should be able to define a new structure that has the two fields
> 
> 	struct {
> 		struct ref *hint;
> 		int new_option;
> 	};
> 
> initialize an instance of it before push_update_refs_status() enters
> its endless loop, and pass a pointer to it to this helper function.

      ## transport-helper.c ##
    -@@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
    +@@ transport-helper.c: static int fetch(struct transport *transport,
    + 	return -1;
    + }
    + 
    ++struct push_update_ref_state {
    ++	struct ref *hint;
    ++	struct ref_push_report *report;
    ++	int new_report;
    ++};
    ++
    + static int push_update_ref_status(struct strbuf *buf,
    +-				   struct ref **ref,
    ++				   struct push_update_ref_state *state,
    + 				   struct ref *remote_refs)
      {
      	char *refname, *msg;
      	int status, forced = 0;
    -+	static struct ref *hint = NULL;
    -+	static int new_options = 1;
    -+
    + 
     +	if (starts_with(buf->buf, "option ")) {
    -+		struct ref_push_report_options *options;
     +		struct object_id old_oid, new_oid;
     +		const char *key, *val;
     +		char *p;
     +
    -+		if (!hint)
    ++		if (!state->hint || !(state->report || state->new_report))
     +			die(_("'option' without a matching 'ok/error' directive"));
    -+		options = hint->report.options;
    -+		while (options && options->next)
    -+			options = options->next;
    -+		if (new_options) {
    -+			if (!options) {
    -+				hint->report.options = xcalloc(1, sizeof(struct ref_push_report_options));
    -+				options = hint->report.options;
    ++		if (state->new_report) {
    ++			if (!state->hint->report) {
    ++				state->hint->report = xcalloc(1, sizeof(struct ref_push_report));
    ++				state->report = state->hint->report;
     +			} else {
    -+				options->next = xcalloc(1, sizeof(struct ref_push_report_options));
    -+				options = options->next;
    ++				state->report = state->hint->report;
    ++				while (state->report->next)
    ++					state->report = state->report->next;
    ++				state->report->next = xcalloc(1, sizeof(struct ref_push_report));
    ++				state->report = state->report->next;
     +			}
    -+			new_options = 0;
    ++			state->new_report = 0;
     +		}
    -+		assert(options);
     +		key = buf->buf + 7;
     +		p = strchr(key, ' ');
     +		if (p)
     +			*p++ = '\0';
     +		val = p;
     +		if (!strcmp(key, "refname"))
    -+			options->ref_name = xstrdup_or_null(val);
    ++			state->report->ref_name = xstrdup_or_null(val);
     +		else if (!strcmp(key, "old-oid") && val &&
     +			 !parse_oid_hex(val, &old_oid, &val))
    -+			options->old_oid = oiddup(&old_oid);
    ++			state->report->old_oid = oiddup(&old_oid);
     +		else if (!strcmp(key, "new-oid") && val &&
     +			 !parse_oid_hex(val, &new_oid, &val))
    -+			options->new_oid = oiddup(&new_oid);
    ++			state->report->new_oid = oiddup(&new_oid);
     +		else if (!strcmp(key, "forced-update"))
    -+			options->forced_update = 1;
    ++			state->report->forced_update = 1;
     +		/* Not update remote namespace again. */
     +		return 1;
     +	}
    - 
    ++
    ++	state->report = NULL;
    ++	state->new_report = 0;
    ++
      	if (starts_with(buf->buf, "ok ")) {
      		status = REF_STATUS_OK;
    + 		refname = buf->buf + 3;
     @@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
    - 		*ref = find_ref_by_name(remote_refs, refname);
    - 	if (!*ref) {
    + 		}
    + 	}
    + 
    +-	if (*ref)
    +-		*ref = find_ref_by_name(*ref, refname);
    +-	if (!*ref)
    +-		*ref = find_ref_by_name(remote_refs, refname);
    +-	if (!*ref) {
    ++	if (state->hint)
    ++		state->hint = find_ref_by_name(state->hint, refname);
    ++	if (!state->hint)
    ++		state->hint = find_ref_by_name(remote_refs, refname);
    ++	if (!state->hint) {
      		warning(_("helper reported unexpected status of %s"), refname);
    -+		hint = NULL;
      		return 1;
      	}
    -+	hint = *ref;
    -+	new_options = 1;
      
    - 	if ((*ref)->status != REF_STATUS_NONE) {
    +-	if ((*ref)->status != REF_STATUS_NONE) {
    ++	if (state->hint->status != REF_STATUS_NONE) {
      		/*
    + 		 * Earlier, the ref was marked not to be pushed, so ignore the ref
    + 		 * status reported by the remote helper if the latter is 'no match'.
     @@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
    + 			return 1;
    + 	}
      
    - 	(*ref)->status = status;
    - 	(*ref)->forced_update |= forced;
    +-	(*ref)->status = status;
    +-	(*ref)->forced_update |= forced;
     -	(*ref)->remote_status = msg;
    -+	if (msg) {
    -+		if (status == REF_STATUS_OK)
    -+			(*ref)->report.message = msg;
    -+		else
    -+			(*ref)->report.error_message = msg;
    -+	}
    ++	if (status == REF_STATUS_OK)
    ++		state->new_report = 1;
    ++	state->hint->status = status;
    ++	state->hint->forced_update |= forced;
    ++	state->hint->remote_status = msg;
      	return !(status == REF_STATUS_OK);
      }
      
    +@@ transport-helper.c: static int push_update_refs_status(struct helper_data *data,
    + 				    struct ref *remote_refs,
    + 				    int flags)
    + {
    ++	struct ref *ref;
    ++	struct ref_push_report *report;
    + 	struct strbuf buf = STRBUF_INIT;
    +-	struct ref *ref = remote_refs;
    +-	int ret = 0;
    ++	struct push_update_ref_state state = { remote_refs, NULL, 0 };
    + 
    + 	for (;;) {
    +-		char *private;
    +-
    + 		if (recvline(data, &buf)) {
    +-			ret = 1;
    +-			break;
    ++			strbuf_release(&buf);
    ++			return 1;
    + 		}
    +-
    + 		if (!buf.len)
    + 			break;
    ++		push_update_ref_status(&buf, &state, remote_refs);
    ++	}
    ++	strbuf_release(&buf);
    + 
    +-		if (push_update_ref_status(&buf, &ref, remote_refs))
    +-			continue;
    ++	if (flags & TRANSPORT_PUSH_DRY_RUN || !data->rs.nr || data->no_private_update)
    ++		return 0;
    + 
    +-		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->rs.nr || data->no_private_update)
    +-			continue;
    ++	/* propagate back the update to the remote namespace */
    ++	for (ref = remote_refs; ref; ref = ref->next) {
    ++		char *private;
    + 
    +-		/* propagate back the update to the remote namespace */
    +-		private = apply_refspecs(&data->rs, ref->name);
    +-		if (!private)
    ++		if (ref->status != REF_STATUS_OK)
    + 			continue;
    +-		update_ref("update by helper", private, &ref->new_oid, NULL,
    +-			   0, 0);
    +-		free(private);
    ++
    ++		if (!ref->report) {
    ++			private = apply_refspecs(&data->rs, ref->name);
    ++			if (!private)
    ++				continue;
    ++			update_ref("update by helper", private, &(ref->new_oid),
    ++				   NULL, 0, 0);
    ++			free(private);
    ++		} else {
    ++			for (report = ref->report; report; report = report->next) {
    ++				private = apply_refspecs(&data->rs,
    ++							 report->ref_name
    ++							 ? report->ref_name
    ++							 : ref->name);
    ++				if (!private)
    ++					continue;
    ++				update_ref("update by helper", private,
    ++					   report->new_oid
    ++					   ? report->new_oid
    ++					   : &(ref->new_oid),
    ++					   NULL, 0, 0);
    ++				free(private);
    ++			}
    ++		}
    + 	}
    +-	strbuf_release(&buf);
    +-	return ret;
    ++	return 0;
    + }
    + 
    + static void set_common_push_options(struct transport *transport,

> Exactly the same comment as "don't turn helper functions that can be
> reused into unreusable ones by adding internal states" as one of the
> previous patches applies here.


 6:  ca4fc6d511 !  4:  60b9157a8e receive-pack: feed report options to post-receive
    @@ Commit message
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
    - {
    - 	struct receive_hook_feed_state *state = state_;
    - 	struct command *cmd = state->cmd;
    -+	static struct ref_push_report_options *options = NULL;
    +@@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process *proc)
      
    - 	while (cmd &&
    - 	       state->skip_broken && (cmd->report.error_message || cmd->did_not_exist))
    + struct receive_hook_feed_state {
    + 	struct command *cmd;
    ++	struct ref_push_report *report;
    + 	int skip_broken;
    + 	struct strbuf buf;
    + 	const struct string_list *push_options;
    +@@ builtin/receive-pack.c: static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
      		cmd = cmd->next;
      	if (!cmd)
      		return -1; /* EOF */
    @@ builtin/receive-pack.c: static int feed_receive_hook(void *state_, const char **
     -		    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
     -		    cmd->ref_name);
     -	state->cmd = cmd->next;
    -+	if (!options)
    -+		options = cmd->report.options;
    -+	if (options) {
    ++	if (!state->report)
    ++		state->report = cmd->report;
    ++	if (state->report) {
     +		struct object_id *old_oid;
     +		struct object_id *new_oid;
     +		const char *ref_name;
     +
    -+		old_oid = options->old_oid ? options->old_oid : &cmd->old_oid;
    -+		new_oid = options->new_oid ? options->new_oid : &cmd->new_oid;
    -+		ref_name = options->ref_name ? options->ref_name : cmd->ref_name;
    ++		old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
    ++		new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
    ++		ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
     +		strbuf_addf(&state->buf, "%s %s %s\n",
     +			    oid_to_hex(old_oid), oid_to_hex(new_oid),
     +			    ref_name);
    -+		options = options->next;
    -+		if (!options)
    ++		state->report = state->report->next;
    ++		if (!state->report)
     +			state->cmd = cmd->next;
     +	} else {
     +		strbuf_addf(&state->buf, "%s %s %s\n",

    +@@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
    + 	strbuf_init(&state.buf, 0);
    + 	state.cmd = commands;
    + 	state.skip_broken = skip_broken;
    ++	state.report = NULL;
    + 	if (feed_receive_hook(&state, NULL, NULL))
    + 		return 0;
    + 	state.cmd = commands;
 
> Why not count "size_t len" before you make a copy of prefix with
> tail adjustment, so that you can do xmemdupz() at the end without
> need for potential overallocation? 

> Style:
> 	if (!proc_receive_ref) {
> 
> like you did below.

    @@ builtin/receive-pack.c: struct command {
     +		ref_pattern->want_delete = 1;
     +		ref_pattern->want_modify = 1;
     +	}
    -+	ref_pattern->next = NULL;
    -+	ref_pattern->ref_prefix = xstrdup(prefix);
    -+	len = strlen(ref_pattern->ref_prefix);
    -+	while (len && ref_pattern->ref_prefix[len - 1] == '/')
    -+		ref_pattern->ref_prefix[--len] = '\0';
    -+	if (proc_receive_ref == NULL) {
    ++	len = strlen(prefix);
    ++	while (len && prefix[len - 1] == '/')
    ++		len--;
    ++	ref_pattern->ref_prefix = xmemdupz(prefix, len);
    ++	if (!proc_receive_ref) {
     +		proc_receive_ref = ref_pattern;
     +	} else {
     +		struct proc_receive_ref *end;


> Shouldn't the "negate" bit be jsut another field that has
> want_{add,delete,modify}, so that proc_receive_ref_append()
> can parse it only once without these four lines?

    @@ builtin/receive-pack.c: static int keepalive_in_sec = 5;
     +static struct proc_receive_ref {
     +	unsigned int want_add:1,
     +		     want_delete:1,
    -+		     want_modify:1;
    ++		     want_modify:1,
    ++		     negative_ref:1;
     +	char *ref_prefix;
     +	struct proc_receive_ref *next;
    -+} *proc_receive_ref = NULL;
    ++} *proc_receive_ref;
     +
     +static void proc_receive_ref_append(const char *prefix);
     +
    @@ builtin/receive-pack.c: struct command {
     +				ref_pattern->want_delete = 1;
     +			else if (*prefix == 'm')
     +				ref_pattern->want_modify = 1;
    ++			else if (*prefix == '!')
    ++				ref_pattern->negative_ref = 1;
     +			prefix++;
     +		}
     +		prefix++;

    @@ builtin/receive-pack.c: struct command {
     +
     +	for (p = proc_receive_ref; p; p = p->next) {
     +		const char *match = p->ref_prefix;
    -+		int neg = 0;
     +		const char *remains;
     +
     +		if (!p->want_add && is_null_oid(&cmd->old_oid))
    @@ builtin/receive-pack.c: struct command {
     +			 !is_null_oid(&cmd->new_oid))
     +			continue;
     +
    -+		if (*match == '!') {
    -+			neg = 1;
    -+			match++;
    -+		}
    -+
     +		if (skip_prefix(cmd->ref_name, match, &remains) &&
     +		    (!*remains || *remains == '/')) {
    -+			if (!neg)
    ++			if (!p->negative_ref)
     +				return 1;
    -+		} else if (neg) {
    ++		} else if (p->negative_ref) {
     +			return 1;
     +		}
     +	}
    @@ t/t5411/test-0050-proc-receive-refs.sh (new)
     +		git config --unset-all receive.procReceiveRefs &&
     +		git config --add receive.procReceiveRefs m:refs/heads/master &&
     +		git config --add receive.procReceiveRefs ad:refs/heads &&
    -+		git config --add receive.procReceiveRefs "a:!refs/heads"
    ++		git config --add receive.procReceiveRefs "a!:refs/heads"
     +	)
     +'
     +

---

Jiang Xin (10):
  transport: not report a non-head push as a branch
  t5411: add basic test cases for proc-receive hook
  receive-pack: add new proc-receive hook
  receive-pack: feed report options to post-receive
  New capability "report-status-v2" for git-push
  doc: add document for capability report-status-v2
  receive-pack: new config receive.procReceiveRefs
  t5411: test updates of remote-tracking branches
  transport: parse report options for tracking refs
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt              |  21 +
 Documentation/githooks.txt                    |  62 +++
 Documentation/technical/pack-protocol.txt     |  43 +-
 .../technical/protocol-capabilities.txt       |  17 +-
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 472 +++++++++++++++++-
 builtin/send-pack.c                           |  19 +
 remote.h                                      |   9 +
 send-pack.c                                   | 101 +++-
 t/helper/test-proc-receive.c                  | 176 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411-proc-receive-hook.sh                  | 117 +++++
 t/t5411/common-functions.sh                   |  56 +++
 t/t5411/once-0010-report-status-v1.sh         |  94 ++++
 t/t5411/test-0000-standard-git-push.sh        | 143 ++++++
 .../test-0001-standard-git-push--porcelain.sh | 147 ++++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0011-no-hook-error.sh            |  64 +++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 +++
 t/t5411/test-0013-bad-protocol.sh             | 217 ++++++++
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
 t/t5411/test-0032-report-with-options.sh      | 256 ++++++++++
 ...est-0033-report-with-options--porcelain.sh | 265 ++++++++++
 t/t5411/test-0034-report-ft.sh                |  44 ++
 t/t5411/test-0035-report-ft--porcelain.sh     |  45 ++
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 227 +++++++++
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 172 +++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  89 ++++
 .../test-0039-report-mixed-refs--porcelain.sh |  91 ++++
 t/t5411/test-0040-process-all-refs.sh         | 113 +++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 +++++
 t/t5411/test-0050-proc-receive-refs.sh        | 128 +++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport-helper.c                            | 128 +++--
 transport.c                                   | 159 ++++--
 48 files changed, 4320 insertions(+), 102 deletions(-)
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
2.26.2.543.ge7de2a6e37

