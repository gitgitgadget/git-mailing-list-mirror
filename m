Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A4C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8922078C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXKB8Fnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbgDCNkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:40:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54068 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390789AbgDCNkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 09:40:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id d77so7211415wmd.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ppp81GFlcJF55EHzPeUsQzEKifSeeH1UcB/lRDId3Ho=;
        b=AXKB8Fnpc3vrJwDZklOfkJZeiE2ZxtJExzO1x3EHYJMNcddlStw9brtk6KermZHPLf
         ExNFLzwOOfDMxFsfXMHcOJy8jNEPWCOC+Ze3WmH44Psh2a7ZwJJufE+n9Tt3nEaIxvCH
         OerQwXWEOmZWPzUNkEBGpmtN2FSJVnzHxxRA5iHONT+v9AGgHuJI+5qxR3Plgr1GZiCh
         3Jl46GQIaaZCas9I7mkny4URq691SMYBLn6ul9sd9C/TsSizZhVdoH1LBhnCYT5CWMUj
         NBp2xwrPvwNifZj1eqW4LcGspKJoaN+rzWCrT6R6RPVKJzkEgIPd0IaY8ADvwjxsyVbs
         /uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ppp81GFlcJF55EHzPeUsQzEKifSeeH1UcB/lRDId3Ho=;
        b=aIdOC0MZXz79ulYcZerY8+gd8cPZ0a7Ayn1uarUmPPT5axHZOd+WCVp8zbJ4JtRW23
         AebY50nnVW8jXyczoy5Ovftx5hJnwlqYFdek1TqQi0BKX1KnMtLsR5ulxrU/Y4QAm2GK
         C8hwAsx59M3hduK+B6HrpcN9eOwNcW/ki0pcWwxo+GW4fFB7vDPIiSdN0TZzyokQte2y
         Xtb9eGNFJjWgD2jmKcGp93Wrxro1IQWr9z65boxnXzX0BWWd7G2rsbvb+Qjg8NRJ5oRm
         SgNvrfNup4V7ZvVH8WJk+DmH8FQ1itgN9pDdQyFUPNYAwRT1AUUmJ1xIXULyQNUkhvo8
         /cGQ==
X-Gm-Message-State: AGi0PuZ07wnLA9C/VXafjEW/BnLQigvLZlSjnc9XaGo6KtHfFQCOulpn
        l/0jgl5eH6kc2oMYEERcGIxbLC/m
X-Google-Smtp-Source: APiQypKbdwFMB9kGclmBK0Zix/5tWnBfvwDwvRIkJGH+lA5hfbbX27VWKthv4HCUOxtqH7X8pUs3kg==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr2341335wmc.132.1585921228936;
        Fri, 03 Apr 2020 06:40:28 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id w3sm12087942wrn.31.2020.04.03.06.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:40:28 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 9/9] update-ref: implement interactive transaction
 handling
To:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1585129842.git.ps@pks.im> <cover.1585811013.git.ps@pks.im>
 <5670bea2b15bafbd93d7d507b35e54980ad06fb9.1585811014.git.ps@pks.im>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fd4b874a-478f-2139-e910-c000b8a1f396@gmail.com>
Date:   Fri, 3 Apr 2020 14:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5670bea2b15bafbd93d7d507b35e54980ad06fb9.1585811014.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick

On 02/04/2020 08:10, Patrick Steinhardt wrote:
> The git-update-ref(1) command can only handle queueing transactions
> right now via its "--stdin" parameter, but there is no way for users to
> handle the transaction itself in a more explicit way. E.g. in a
> replicated scenario, one may imagine a coordinator that spawns
> git-update-ref(1) for multiple repositories and only if all agree that
> an update is possible will the coordinator send a commit. Such a
> transactional session could look like
> 
>      > start
>      < start: ok
>      > update refs/heads/master $OLD $NEW
>      > prepare
>      < prepare: ok
>      # All nodes have returned "ok"
>      > commit
>      < commit: ok
> 
> or
> 
>      > start
>      < start: ok
>      > create refs/heads/master $OLD $NEW
>      > prepare
>      < fatal: cannot lock ref 'refs/heads/master': reference already exists
>      # On all other nodes:
>      > abort
>      < abort: ok
> 
> In order to allow for such transactional sessions, this commit
> introduces four new commands for git-update-ref(1), which matches those
> we have internally already with the exception of "start":
> 
>      - start: start a new transaction
> 
>      - prepare: prepare the transaction, that is try to lock all
>                 references and verify their current value matches the
>                 expected one
> 
>      - commit: explicitly commit a session, that is update references to
>                match their new expected state
> 
>      - abort: abort a session and roll back all changes
> 
> By design, git-update-ref(1) will commit as soon as standard input is
> being closed. While fine in a non-transactional world, it is definitely
> unexpected in a transactional world. Because of this, as soon as any of
> the new transactional commands is used, the default will change to
> aborting without an explicit "commit". To avoid a race between queueing
> updates and the first "prepare" that starts a transaction, the "start"
> command has been added to start an explicit transaction.
> 
> Add some tests to exercise this new functionality.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   Documentation/git-update-ref.txt |  26 ++++++
>   builtin/update-ref.c             | 106 +++++++++++++++++++++++--
>   t/t1400-update-ref.sh            | 131 +++++++++++++++++++++++++++++++
>   3 files changed, 255 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index 9bd039ce08..3e737c2360 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -66,6 +66,10 @@ performs all modifications together.  Specify commands of the form:
>   	delete SP <ref> [SP <oldvalue>] LF
>   	verify SP <ref> [SP <oldvalue>] LF
>   	option SP <opt> LF
> +	start LF
> +	prepare LF
> +	commit LF
> +	abort LF
>   
>   With `--create-reflog`, update-ref will create a reflog for each ref
>   even if one would not ordinarily be created.
> @@ -83,6 +87,10 @@ quoting:
>   	delete SP <ref> NUL [<oldvalue>] NUL
>   	verify SP <ref> NUL [<oldvalue>] NUL
>   	option SP <opt> NUL
> +	start NUL
> +	prepare NUL
> +	commit NUL
> +	abort NUL
>   
>   In this format, use 40 "0" to specify a zero value, and use the empty
>   string to specify a missing value.
> @@ -114,6 +122,24 @@ option::
>   	The only valid option is `no-deref` to avoid dereferencing
>   	a symbolic ref.
>   
> +start::
> +	Start a transaction. In contrast to a non-transactional session, 

I found the talk of "non-transactional" sessions a bit confusing because 
the normal --stdin does update all the refs it is given as a single 
transaction, so that if it cannot update one ref none of them are 
updated. If I've understood correctly these changes are about 
coordinating transactions across several repositories. I'm not sure how 
best to convey that in the man page - perhaps we could call them single 
repository transactions and multi repository transaction or something.

Best Wishes

Phillip

> a
> +	transaction will automatically abort if the session ends without an
> +	explicit commit.
> +
> +prepare::
> +	Prepare to commit the transaction. This will create lock files for all
> +	queued reference updates. If one reference could not be locked, the
> +	transaction will be aborted.
> +
> +commit::
> +	Commit all reference updates queued for the transaction, ending the
> +	transaction.
> +
> +abort::
> +	Abort the transaction, releasing all locks if the transaction is in
> +	prepared state.
> +
>   If all <ref>s can be locked with matching <oldvalue>s
>   simultaneously, all modifications are performed.  Otherwise, no
>   modifications are performed.  Note that while each individual
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 348407b896..b74dd9a69d 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -312,21 +312,80 @@ static void parse_cmd_option(struct ref_transaction *transaction,
>   		die("option unknown: %s", next);
>   }
>   
> +static void parse_cmd_start(struct ref_transaction *transaction,
> +			    const char *next, const char *end)
> +{
> +	if (*next != line_termination)
> +		die("start: extra input: %s", next);
> +	puts("start: ok");
> +}
> +
> +static void parse_cmd_prepare(struct ref_transaction *transaction,
> +			      const char *next, const char *end)
> +{
> +	struct strbuf error = STRBUF_INIT;
> +	if (*next != line_termination)
> +		die("prepare: extra input: %s", next);
> +	if (ref_transaction_prepare(transaction, &error))
> +		die("prepare: %s", error.buf);
> +	puts("prepare: ok");
> +}
> +
> +static void parse_cmd_abort(struct ref_transaction *transaction,
> +			    const char *next, const char *end)
> +{
> +	struct strbuf error = STRBUF_INIT;
> +	if (*next != line_termination)
> +		die("abort: extra input: %s", next);
> +	if (ref_transaction_abort(transaction, &error))
> +		die("abort: %s", error.buf);
> +	puts("abort: ok");
> +}
> +
> +static void parse_cmd_commit(struct ref_transaction *transaction,
> +			     const char *next, const char *end)
> +{
> +	struct strbuf error = STRBUF_INIT;
> +	if (*next != line_termination)
> +		die("commit: extra input: %s", next);
> +	if (ref_transaction_commit(transaction, &error))
> +		die("commit: %s", error.buf);
> +	puts("commit: ok");
> +	ref_transaction_free(transaction);
> +}
> +
> +enum update_refs_state {
> +	/* Non-transactional state open for updates. */
> +	UPDATE_REFS_OPEN,
> +	/* A transaction has been started. */
> +	UPDATE_REFS_STARTED,
> +	/* References are locked and ready for commit */
> +	UPDATE_REFS_PREPARED,
> +	/* Transaction has been committed or closed. */
> +	UPDATE_REFS_CLOSED,
> +};
> +
>   static const struct parse_cmd {
>   	const char *prefix;
>   	void (*fn)(struct ref_transaction *, const char *, const char *);
>   	unsigned args;
> +	enum update_refs_state state;
>   } command[] = {
> -	{ "update", parse_cmd_update, 3 },
> -	{ "create", parse_cmd_create, 2 },
> -	{ "delete", parse_cmd_delete, 2 },
> -	{ "verify", parse_cmd_verify, 2 },
> -	{ "option", parse_cmd_option, 1 },
> +	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
> +	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
> +	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
> +	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
> +	{ "option",  parse_cmd_option,  1, UPDATE_REFS_OPEN },
> +	{ "start",   parse_cmd_start,   0, UPDATE_REFS_STARTED },
> +	{ "prepare", parse_cmd_prepare, 0, UPDATE_REFS_PREPARED },
> +	{ "abort",   parse_cmd_abort,   0, UPDATE_REFS_CLOSED },
> +	{ "commit",  parse_cmd_commit,  0, UPDATE_REFS_CLOSED },
>   };
>   
>   static void update_refs_stdin(void)
>   {
>   	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
> +	enum update_refs_state state = UPDATE_REFS_OPEN;
>   	struct ref_transaction *transaction;
>   	int i, j;
>   
> @@ -374,14 +433,45 @@ static void update_refs_stdin(void)
>   			if (strbuf_appendwholeline(&input, stdin, line_termination))
>   				break;
>   
> +		switch (state) {
> +		case UPDATE_REFS_OPEN:
> +		case UPDATE_REFS_STARTED:
> +			/* Do not downgrade a transaction to a non-transaction. */
> +			if (cmd->state >= state)
> +				state = cmd->state;
> +			break;
> +		case UPDATE_REFS_PREPARED:
> +			if (cmd->state != UPDATE_REFS_CLOSED)
> +				die("prepared transactions can only be closed");
> +			state = cmd->state;
> +			break;
> +		case UPDATE_REFS_CLOSED:
> +			die("transaction is closed");
> +			break;
> +		}
> +
>   		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
>   			input.buf + input.len);
>   	}
>   
> -	if (ref_transaction_commit(transaction, &err))
> -		die("%s", err.buf);
> +	switch (state) {
> +	case UPDATE_REFS_OPEN:
> +		/* Commit by default if no transaction was requested. */
> +		if (ref_transaction_commit(transaction, &err))
> +			die("%s", err.buf);
> +		ref_transaction_free(transaction);
> +		break;
> +	case UPDATE_REFS_STARTED:
> +	case UPDATE_REFS_PREPARED:
> +		/* If using a transaction, we want to abort it. */
> +		if (ref_transaction_abort(transaction, &err))
> +			die("%s", err.buf);
> +		break;
> +	case UPDATE_REFS_CLOSED:
> +		/* Otherwise no need to do anything, the transaction was closed already. */
> +		break;
> +	}
>   
> -	ref_transaction_free(transaction);
>   	strbuf_release(&err);
>   	strbuf_release(&input);
>   }
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index a6224ef65f..48d0d42afd 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1404,4 +1404,135 @@ test_expect_success 'handle per-worktree refs in refs/bisect' '
>   	! test_cmp main-head worktree-head
>   '
>   
> +test_expect_success 'transaction handles empty commit' '
> +	cat >stdin <<-EOF &&
> +	start
> +	prepare
> +	commit
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start prepare commit >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'transaction handles empty commit with missing prepare' '
> +	cat >stdin <<-EOF &&
> +	start
> +	commit
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start commit >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'transaction handles sole commit' '
> +	cat >stdin <<-EOF &&
> +	commit
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" commit >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'transaction handles empty abort' '
> +	cat >stdin <<-EOF &&
> +	start
> +	prepare
> +	abort
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start prepare abort >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'transaction exits on multiple aborts' '
> +	cat >stdin <<-EOF &&
> +	abort
> +	abort
> +	EOF
> +	test_must_fail git update-ref --stdin <stdin >actual 2>err &&
> +	printf "%s: ok\n" abort >expect &&
> +	test_cmp expect actual &&
> +	grep "fatal: transaction is closed" err
> +'
> +
> +test_expect_success 'transaction exits on start after prepare' '
> +	cat >stdin <<-EOF &&
> +	prepare
> +	start
> +	EOF
> +	test_must_fail git update-ref --stdin <stdin 2>err >actual &&
> +	printf "%s: ok\n" prepare >expect &&
> +	test_cmp expect actual &&
> +	grep "fatal: prepared transactions can only be closed" err
> +'
> +
> +test_expect_success 'transaction handles empty abort with missing prepare' '
> +	cat >stdin <<-EOF &&
> +	start
> +	abort
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start abort >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'transaction handles sole abort' '
> +	cat >stdin <<-EOF &&
> +	abort
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" abort >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'transaction can handle commit' '
> +	cat >stdin <<-EOF &&
> +	start
> +	create $a HEAD
> +	commit
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start commit >expect &&
> +	test_cmp expect actual &&
> +	git rev-parse HEAD >expect &&
> +	git rev-parse $a >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'transaction can handle abort' '
> +	cat >stdin <<-EOF &&
> +	start
> +	create $b HEAD
> +	abort
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start abort >expect &&
> +	test_cmp expect actual &&
> +	test_path_is_missing .git/$b
> +'
> +
> +test_expect_success 'transaction aborts by default' '
> +	cat >stdin <<-EOF &&
> +	start
> +	create $b HEAD
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start >expect &&
> +	test_cmp expect actual &&
> +	test_path_is_missing .git/$b
> +'
> +
> +test_expect_success 'transaction with prepare aborts by default' '
> +	cat >stdin <<-EOF &&
> +	start
> +	create $b HEAD
> +	prepare
> +	EOF
> +	git update-ref --stdin <stdin >actual &&
> +	printf "%s: ok\n" start prepare >expect &&
> +	test_cmp expect actual &&
> +	test_path_is_missing .git/$b
> +'
> +
>   test_done
> 
