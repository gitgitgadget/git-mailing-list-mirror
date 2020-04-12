Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97DC2D0EC
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483CA206C3
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GXsND09S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483CA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgDLVaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgDLVaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 17:30:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECEAC0A3BF5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 14:30:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AB1D5A03E;
        Sun, 12 Apr 2020 17:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wamITQYQwvUNCBDyMG5co/OTLGE=; b=GXsND0
        9SJjfih2j1DjRchcwzxfMQio7xOh78w6Q/vOITR9THGUVXi9D2lYTEoU6DRvD2Xn
        6H089Zuu4TYh79SKIAD0ki1ZLlWKleK4gaOsIJeKyssOpYYIH0MLT0K/ZkgfKsD4
        qJVRorzQU1w1WbzNDea4xDztZJUDfojP7W8/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iuz+JJl3fBCirARyhUkDh5GZERM+lVZG
        cPrL0NYZL72uJ0UEyv3Ym35dfPeC5dENzJ0ZkvCgBb5n1yQBfjvVNtiJPFXCGXNf
        JYn6wZ1emPVhxcvMaBaNIJYfAJr98YGzgY7Mx8AmBm6719JTtG7FxaPhICIeAnOd
        Rm+jXcPoHGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 322F35A03D;
        Sun, 12 Apr 2020 17:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3AF35A03C;
        Sun, 12 Apr 2020 17:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v10 2/8] receive-pack: add new proc-receive hook
References: <20200407120813.25025-1-worldhello.net@gmail.com>
        <20200412133022.17590-3-worldhello.net@gmail.com>
Date:   Sun, 12 Apr 2020 14:30:25 -0700
In-Reply-To: <20200412133022.17590-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 12 Apr 2020 09:30:16 -0400")
Message-ID: <xmqq5ze4e6j2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2C251EC-7D04-11EA-A88B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> The filter will check the prefix of the reference name, and if the
> command has a special reference name, the filter will turn a specific
> field (`run_proc_receive`) on for the command.  Commands with this filed
> turned on will be executed by a new handler (an hook named
> "proc-receive") instead of the internal `execute_commands` function.
> We can use this "proc-receive" command to create pull requests or send
> emails for code review.
>
> Suggested by Junio, this "proc-receive" hook reads the commands,
> push-options (optional), and send result using a protocol in pkt-line
> format.  In the following example, The letter "S" stands for
> "receive-pack" and letter "H" stands for the hook.

Heh, you're giving me too much credit here.  The exchange
illustrated below makes sense to me, ...

>     # Version and features negotiation.
>     S: PKT-LINE(version=1\0push-options atomic...)
>     S: flush-pkt
>     H: PKT-LINE(version=1\0push-options...)
>     H: flush-pkt
>
>     # Send commands from server to the hook.
>     S: PKT-LINE(<old-oid> <new-oid> <ref>)
>     S: ... ...
>     S: flush-pkt
>     # Send push-options only if the 'push-options' feature is enabled.
>     S: PKT-LINE(push-option)
>     S: ... ...
>     S: flush-pkt
>
>     # Receive result from the hook.
>     # OK, run this command successfully.
>     H: PKT-LINE(<old-oid> <new-oid> <ref> ok)
>     # NO, I reject it.
>     H: PKT-LINE(<old-oid> <new-oid> <ref> ng <reason>)
>     # Fall through, let 'receive-pack' to execute it.
>     H: PKT-LINE(<old-oid> <new-oid> <ref> ft)
>     # OK, but has an alternate reference.  The alternate reference name
>     # and other status are given in key=value pairs after the null
>     # character.
>     H: PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head
>                 forced-update)

The semantics of this one is fuzzy.  We made an update to a ref that
is different from the one that was requested (presumably that is what
is reported after "\0ref="), OK, but did we update the ref in the
request, too, or did we leave the ref in the request intact?  Or, do
we say "no\0ref=..." if we don't update the requested ref and
instead update a different one?  Let's hold the answer at this point
and keep thinking...

>     H: ... ...
>     H: flush-pkt
>
> After receiving a command, the hook will execute the command, and may
> create/update different reference.  For example, a command for a pseudo
> reference "refs/for/master/topic" may create/update different reference
> such as "refs/pull/123/head".  The alternate reference name and other
> status are given in key-value pairs as extended status of the report
> line.
>
> The list of commands returned from "proc-receive" will replace the
> relevant commands that are sent from user to "receive-pack", and
> "receive-pack" will continue to run the "execute_commands" function and
> other routines.  Finally, the result of the execution of these commands
> will be reported to end user.

It is not clear if there needs to be any correspondence between the
sequence of input commands and the sequence of output commands.  I
am guessing that there is not any and the hook is allowed to do
anything as it wants to.  For example:

 - it is OK to execute them all and report them, but in a totally
   random order.

 - it is OK to ignore all input and report no update (not even
   "ng").

 - it is OK to be asked to update one ref, but update and report
   updates to two refs that are not related to the requested ref.

Is my understanding correct?

Or does the design tie the set of input and output ref updates
closely together, i.e. one input corresponds to one output and they
are in order, so all the hook is allowed to do is

 - to execute and update as it is told, and report "ok",

 - to reject and report "ng", or

 - to update *another* ref without updating the requested one, with
   "ok\0ref=..." mechanism.

I am not sure which one is more sensible, though.

If we choose to use the "anything goes" approach, I do not think
there is no need for the "ok\nref=..." mechanism---we can just give
two output records, one "ok" for the original request, and a new
"ok" that reports the "we updated this one instead".

> +#define RUN_PROC_RECEIVE_SCHEDULED	1
> +#define RUN_PROC_RECEIVE_RETURNED	2
>  struct command {
>  	struct command *next;
>  	const char *error_string;
>  	unsigned int skip_update:1,
> -		     did_not_exist:1;
> +		     did_not_exist:1,
> +		     run_proc_receive:2;
>  	int index;
>  	struct object_id old_oid;
>  	struct object_id new_oid;
> @@ -817,6 +820,236 @@ static int run_update_hook(struct command *cmd)
>  	return finish_command(&proc);
>  }
>  
> +static struct command *find_command_by_refname(const struct command *list,
> +					       const char *refname)
> +{
> +	for (; list; list = list->next)
> +		if (!strcmp(list->ref_name, refname))
> +			return (struct command *)list;
> +	return NULL;
> +}
> +
> +static int read_proc_receive_report(struct packet_reader *reader,
> +				    struct command *commands,
> +				    struct strbuf *errmsg)
> +{
> +	struct command *cmd;
> +	struct command *hint = NULL;
> +	int code = 0;
> +
> +	for (;;) {
> +		struct object_id old_oid, new_oid;
> +		const char *refname;
> +		const char *p;
> +		char *status;
> +		char *msg = NULL;
> +
> +		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
> +			break;
> +		if (parse_oid_hex(reader->line, &old_oid, &p) ||
> +		    *p++ != ' ' ||
> +		    parse_oid_hex(p, &new_oid, &p) ||
> +		    *p++ != ' ') {
> +			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
> +				    reader->line);
> +			code = -1;
> +			continue;
> +		}
> +
> +		refname = p;
> +		status = strchr(p, ' ');
> +		if (!status) {
> +			strbuf_addf(errmsg, "proc-receive expected 'old new ref status [msg]', got '%s'\n",
> +				    reader->line);
> +			code = -1;
> +			continue;
> +		}
> +		*status++ = '\0';
> +		if (strlen(status) > 2 && *(status + 2) == ' ') {
> +			msg = status + 2;
> +			*msg++ = '\0';
> +		}

So, here we parsed "<old> <new> <ref> (ok|ng)", with status pointing
at ok/ng, or "<old> <new> <ref> (ok|ng) <why>", with status pointing
at ok/ng and msg pointing at <why>.  refname points at <ref>.

Most notably, "ok\0ref=..." is not handled any specially from a
normal "ok" here.

> +		if (strlen(status) != 2) {
> +			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
> +				    status, reader->line);
> +			code = -1;
> +			continue;
> +		}
> +
> +		/* first try searching at our hint, falling back to all refs */
> +		if (hint)
> +			hint = find_command_by_refname(hint, refname);
> +		if (!hint)
> +			hint = find_command_by_refname(commands, refname);
> +		if (!hint) {
> +			strbuf_addf(errmsg, "proc-receive reported status on unknown ref: %s\n",
> +				    refname);
> +			continue;
> +		}
> +		if (!hint->run_proc_receive) {
> +			strbuf_addf(errmsg, "proc-receive reported status on ref of builtin command: %s\n",
> +				    refname);
> +			continue;

Updates against a request to update certain ref hierarchies by the
hook is rejected here.

> +		}
> +		if (!strcmp(status, "ng")) {
> +			if (msg)
> +				hint->error_string = xstrdup(msg);
> +			else
> +				hint->error_string = "failed";
> +			code = -1;

The <why> in "(ok|ng) <why>" message is only used for "ng", which is
probably good, as the reason why something succeeded is not usually
very interesting.

> +		} else if (strcmp("ok", status)) {
> +			strbuf_addf(errmsg, "proc-receive has bad status '%s' for '%s'\n",
> +				    status, reader->line);
> +			code = -1;
> +			/* Skip marking it as RUN_PROC_RECEIVE_RETURNED */

But then shouldn't we be complaining if msg is not NULL here,
instead of silently ignoring?  Also we didn't see what happened to
the promised "ok\0ref=..." stuff here, or the passthru "ft".
Puzzled...

> +			continue;
> +		}
> +		oidcpy(&hint->old_oid, &old_oid);
> +		oidcpy(&hint->new_oid, &new_oid);
> +		hint->run_proc_receive |= RUN_PROC_RECEIVE_RETURNED;

Or, is this last one the catch all for "ft" (in other words, the
hook does not have to say "ft", but as long as it says two non-SP
letters that are not "ok" nor "ng", it is taken as "ft")?

> +	}
> +
> +	for (cmd = commands; cmd; cmd = cmd->next)
> +		if (cmd->run_proc_receive && !cmd->error_string &&
> +		    !(cmd->run_proc_receive & RUN_PROC_RECEIVE_RETURNED)) {
> +		    cmd->error_string = "no report from proc-receive";
> +		    code = -1;
> +		}
> +
> +	return code;
> +}

OK, so this sort-of answers my earlier question.  But not quite...

The output records and the input requests are tied by "<ref>" each
input record wanted to udpate.  The order does not matter, but not
having a corresponding report in the hook's output is like the hook
reporting a "ng" failure.  It also means that the hook can update
two refs in response to one request, but it is awkward.

> +static int run_proc_receive_hook(struct command *commands,
> +				 const struct string_list *push_options)
> +{
> +	struct child_process proc = CHILD_PROCESS_INIT;
> +	struct async muxer;
> +	struct command *cmd;
> +	const char *argv[2];
> +	struct packet_reader reader;
> +	struct strbuf cap = STRBUF_INIT;
> +	struct strbuf errmsg = STRBUF_INIT;
> +	int pr_use_push_options = 0;
> +	int version = 0;
> +	int code;
> +
> +	argv[0] = find_hook("proc-receive");
> +	if (!argv[0]) {
> +		rp_error("cannot find hook 'proc-receive'");
> +		return -1;
> +	}
> +	argv[1] = NULL;
> +
> +	proc.argv = argv;
> +	proc.in = -1;
> +	proc.out = -1;
> +	proc.trace2_hook_name = "proc-receive";
> +

Isn't this a brand new protocol between receive-pack and a hook?  I
am puzzled why we want a choice between using and not using
sideband.  It's not like you are maintaining compatibility with
ancient version of Git that talked with proc-receive hook but
without sideband, because it did not know how to multiplex sideband
communication.  Shouldn't we just always assume that the sideband is
available?

Or are we just letting the hook directly answer the push client and
that is why this thing needs to know if we are using sideband
between us and the client?  I kind of expected that you'd keep the
two communication channels on both sides isolated so that the side
that talks with the hook does not need to know how we are talking
with the client.

> +	if (use_sideband) {
> +		memset(&muxer, 0, sizeof(muxer));
> +		muxer.proc = copy_to_sideband;
> +		muxer.in = -1;
> +		code = start_async(&muxer);
> +		if (code)
> +			return code;
> +		proc.err = muxer.in;
> +	} else {
> +		proc.err = 0;
> +	}
> +
> +	code = start_command(&proc);
> +	if (code) {
> +		if (use_sideband)
> +			finish_async(&muxer);
> +		return code;
> +	}
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	/* Version negotiaton */
> +	packet_reader_init(&reader, proc.out, NULL, 0,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_DIE_ON_ERR_PACKET);
> ...
> @@ -1497,6 +1731,20 @@ static void execute_commands(struct command *commands,
>  
>  	reject_updates_to_hidden(commands);
>  
> +	/* Try to find commands that have special prefix in their reference names,

Style?

> +	 * and mark them to run an external "proc-receive" hook later.
> +	 */
