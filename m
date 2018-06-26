Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F7B1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 17:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeFZRfG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 13:35:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54225 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933906AbeFZRfF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 13:35:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so2860871wmc.3
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xbtCD3iYTPLJIPP6CA/qierWXQ3k/9T99rDNkNCxv5E=;
        b=BLV2o6+PxxN3OK1KVVOPutg9sSACcGRyVdT11Ss+nazNxRglZMWqBQQAizd6Kzelyu
         uMb2/8UC6mxrpypTvN+HyeqAfpQmtZdeHJKYu/hrp4S3xyWrTQtHwKzZVzRzyLbuZfvz
         If9Aan03+wJzaD2IfjA/z0DO2bllCk+XGyUWtctGG+8hZe8yCuOEu68nofK+x/tbvxzm
         qUTHMErQNLUqqNZvF7WlGSQmTR0302Kbg5w1vFzcaL9iTteR42OJhqgF0dnEwjN8rmRJ
         gjDdLueVYxAclAjJ4nQ8MPy9JB+Ff97/3d5te/G+JgkzubVrxYa40vHjGkmLTeiRTkjc
         g+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xbtCD3iYTPLJIPP6CA/qierWXQ3k/9T99rDNkNCxv5E=;
        b=XIViC8bQRmk57HbCmpIpqo+bVapJZjgHFbvzjkn87vHMklr/IVsnWXb28ZvwDGijRG
         LxRbAcpyZICDM7rJx5lNIvRdtzwWzJAxuak9nD+EZibUjibt5lTuncZUdjHY0UkVfM3s
         X6ZBAdDGIcojN0gpKJGIZAO9QIEYS9I188nd4/mImuV92OX0BelK+Mo7AaneLPh0Qs8A
         SnvtoCBmf+r506topvx0z3+wmy/8m20lq/Vw4MsUH2B9/nQm3R5UknstcfplcV7JDAwJ
         Dc0HIvpIao9j3EmLndY5RRir+NawvNC2KXY5K3pBva+l8C03+qKT2gZCxDugRRvjiTbW
         Kh3g==
X-Gm-Message-State: APt69E2rnTkBLlr3d8Hcl1Px3SeDUZCLN1Ois9yxOrO8nZy+cF73kHgO
        YSqlz/9SZF0CwxWhBnvzgdc=
X-Google-Smtp-Source: AAOMgpeQu81rXZys8L/zmYrxUcWvxnP6nFwMif4uHua1mU6DYK0Awx/TNb0+mxi066nFZjoUAcGFmA==
X-Received: by 2002:a1c:7fc1:: with SMTP id a184-v6mr1830374wmd.161.1530034503386;
        Tue, 26 Jun 2018 10:35:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v14-v6sm2297582wro.33.2018.06.26.10.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:35:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v4 2/3] rebase -i: rewrite checkout_onto() in C
References: <20180621141732.19952-1-alban.gruin@gmail.com>
        <20180625134419.18435-1-alban.gruin@gmail.com>
        <20180625134419.18435-3-alban.gruin@gmail.com>
Date:   Tue, 26 Jun 2018 10:35:00 -0700
In-Reply-To: <20180625134419.18435-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 25 Jun 2018 15:44:18 +0200")
Message-ID: <xmqqsh59lad7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites checkout_onto() from shell to C. The new version is called
> detach_onto(), given its role.

The name, given its role, may be good, but is the implementtaion
robust enough to fulfill the promise its name gives?

>  	git rebase--helper --check-todo-list || {
>  		ret=$?
> -		checkout_onto
> +		git rebase--helper --detach-onto "$onto_name" "$onto" \
> +		    "$orig_head" ${verbose:+--verbose}

Here, $onto_name is what the end-user gave us (e.g. it is
"master..." in "git rebase --onto=master... base"), while $onto is a
40-hex object name of the commit.  $orig_head is also a 40-hex
object name.

And this call shows how the above shell scriptlet calls into the
detach_onto() thing ...

> +	if (command == DETACH_ONTO && argc == 4)
> +		return !!detach_onto(&opts, argv[1], argv[2], argv[3], verbose);

... which is defined like so:

> +int detach_onto(struct replay_opts *opts,
> +		const char *onto_name, const char *onto,
> +		const char *orig_head, unsigned verbose)
> +{
> +	struct object_id oid;
> +	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
> +
> +	if (get_oid(orig_head, &oid))
> +		return error(_("%s: not a valid OID"), orig_head);

Which means that this can be more strict to use get_oid_hex() to
catch possible mistakes in the caller.

> +	if (run_git_checkout(opts, onto, verbose, action)) {

And this could be a bit problematic, as we can see below how the
"checkout" thing does not guarantee "detaching" at all ...

> +		apply_autostash(opts);
> +		sequencer_remove_state(opts);
> +		return error(_("could not detach HEAD"));
> +	}
> +
> +	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> +}
> +

... which can be seen here ...

> +static int run_git_checkout(struct replay_opts *opts, const char *commit,
> +				int verbose, const char *action)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +	cmd.git_cmd = 1;
> +
> +	argv_array_push(&cmd.args, "checkout");
> +	argv_array_push(&cmd.args, commit);
> +	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> +
> +	if (verbose)
> +		return run_command(&cmd);
> +	else
> +		return run_command_silent_on_success(&cmd);
> +}

This drives the external command "git checkout" with _any_ string
the caller passes in "commit".  If the variable happens to have
'master', for example, it would be "git checkout master" and if you
have a branch with that name, it will not detach but check out the
branch to build on it.  It is a caller's responsibility to give a
suitable "commit" if it wants to use this helper to detach.

So perhaps the caller of this function in detach_onto() should pass
"%s^0" or even do something like

	struct object_id onto_oid;
	char onto_hex[GIT_MAX_HEXSZ + 1];

	if (get_oid(onto, &onto_oid) || oid_to_hex_r(onto_hex, &onto_oid))
		return error(...);
	if (run_git_checkout(opts, onto_hex, verbose, action)) {
		...

to ensure that it keeps the promise its name gives.

I can hear "Oh, but it is a bug in the caller to give anything that
won't result in detaching in 'onto'" but that is not a valid excuse,
given that this _public_ function is called "detach_onto".  Making
sure detachment happens is its responsibility, not its callers'.

Or we could do a cop-out alternative of commenting the function in *.h
file to say "onto must be given as 40-hex", with a code to make sure
the caller really gave us a 40-hex and not a branch name.  That is a
less ideal but probably acceptable alternative.

>  static const char rescheduled_advice[] =
>  N_("Could not execute the todo command\n"
>  "\n"
> diff --git a/sequencer.h b/sequencer.h
> index 35730b13e..9f0ac5e75 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -100,6 +100,10 @@ int update_head_with_reflog(const struct commit *old_head,
>  void commit_post_rewrite(const struct commit *current_head,
>  			 const struct object_id *new_head);
>  
> +int detach_onto(struct replay_opts *opts,
> +		const char *onto_name, const char *onto,
> +		const char *orig_head, unsigned verbose);
> +
>  #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>  #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>  void print_commit_summary(const char *prefix, const struct object_id *oid,
