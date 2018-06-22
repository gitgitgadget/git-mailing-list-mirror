Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFC11F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934397AbeFVQ1k (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52328 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934378AbeFVQ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so2814880wmb.2
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+COV/PNVANjNiVO3HrifDxj3YVhsmsbfzmvemjQ61N0=;
        b=t041TEHkoweBIaqARS78tINjvGfdl1DO8gbxjlyBGVVd2tL64a2hUnb+o0WCWfkPaj
         GvfWAWqEzLlJQ8mLTXA38z509TsGx2PYOfJW5tzzI199nu8wUcK5LsyWxRbyE251V1GG
         YmnvCx7mA8CGT6V4q5JOCwd2xOIJd0BLmoGHo5tgnWfd6LNWCe8oE91OJZQ1MPl70dTN
         6Y4eipittqaCkw5jgJnmR2oPzPc8nF8acVo5p7JxF9uPQmv6k5Yr39RQ5qkbGZ2n61Nz
         ZXh7vC41aOH5u7taNoo7F3EurVFuwsOG693y2wcBlHeLNIXSSFOq6UBPP9/5cYE0hXok
         L25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+COV/PNVANjNiVO3HrifDxj3YVhsmsbfzmvemjQ61N0=;
        b=RscFPPISMK81Tgkb+LqZTgH4IRkpVqP9UELwXMP0P22WvtodPlu5sFIJ2iAEHRty/P
         56WwCVJR8pOlLtLh7JcoyzDB0u0y4MLt+3+EOjxaEmtcGF9kCj3oqdyVsJa0o5U+4pRW
         KBgr8xEYjDnd72oXCqIsJfLtfKLTZ7NN6WKDmP6ibgFrzaj7pr53KkEpP9X6nFMuNb1L
         Pn9s1QqSRnpn9KnXmbVrWR+E6HzvYjtAzHGtb9ga1muyYJmffyad/9qgeU3KhYoBRCHU
         544xG1e6PeBZ4h0hr1UclKh1H5tLQRcCZJi34+VrxBucab4nkDF2ycs1I8/+IKJFjL8P
         5xwA==
X-Gm-Message-State: APt69E0hdJzBF1fRJVPtaiaklty5jC6WfdRCJJfoVvXceWy7clZEfLNC
        lrmnJx/hVuN5jIDUtitOURU=
X-Google-Smtp-Source: ADUXVKL8OKWelZof1ZkwA11dkf4g707m9oLgmI2ZZxVi8g+FrUg8TBAegb3ZYByPu59/k4KZ9Nth8A==
X-Received: by 2002:a1c:387:: with SMTP id 129-v6mr2264062wmd.53.1529684853735;
        Fri, 22 Jun 2018 09:27:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e6-v6sm9269981wro.11.2018.06.22.09.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:27:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action() in C
References: <20180619154421.14999-1-alban.gruin@gmail.com>
        <20180621141732.19952-1-alban.gruin@gmail.com>
        <20180621141732.19952-3-alban.gruin@gmail.com>
Date:   Fri, 22 Jun 2018 09:27:32 -0700
In-Reply-To: <20180621141732.19952-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Thu, 21 Jun 2018 16:17:31 +0200")
Message-ID: <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites (the misnamed) setup_reflog_action() from shell to C. The
> new version is called checkout_base_commit().

;-) on the "misnamed" part.  Indeed, setting up the comment for the
reflog entry is secondary to what this function wants to do, which
is to check out the branch to be rebased.

I do not think "base_commit" is a good name, either, though.  When I
hear 'base' in the context of 'rebase', I would imagine that the
speaker is talking about the bottom of the range of the commits to
be rebased (i.e. "rebase --onto ONTO BASE BRANCH", which replays
commits BASE..BRANCH on top of ONTO and then points BRANCH at the
result), not the top of the range or the branch these commits are
taken from.

> index 51c8ab7ac..27f8453fe 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3129,6 +3129,36 @@ static const char *reflog_message(struct replay_opts *opts,
>  	return buf.buf;
>  }
>  
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
> +	return run_command_silent_on_success(&cmd);

For the same reason as 1/3, I think it makes more sense to have
"else" here.

> +int checkout_base_commit(struct replay_opts *opts, const char *commit,
> +			 int verbose)
> +{
> +	const char *action;
> +
> +	if (commit && *commit) {

Hmm, isn't it a programming error to feed !commit or !*commit here?
I offhand do not think of a reason why making such an input a silent
no-op success, instead of making it error out, would be a good idea.

> +		action = reflog_message(opts, "start", "checkout %s", commit);
> +		if (run_git_checkout(opts, commit, verbose, action))
> +			return error(_("Could not checkout %s"), commit);
> +	}
> +
> +	return 0;
> +}
> +
>  static const char rescheduled_advice[] =
>  N_("Could not execute the todo command\n"
>  "\n"
> diff --git a/sequencer.h b/sequencer.h
> index 35730b13e..42c3dda81 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -100,6 +100,9 @@ int update_head_with_reflog(const struct commit *old_head,
>  void commit_post_rewrite(const struct commit *current_head,
>  			 const struct object_id *new_head);
>  
> +int checkout_base_commit(struct replay_opts *opts, const char *commit,
> +			 int verbose);
> +
>  #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>  #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>  void print_commit_summary(const char *prefix, const struct object_id *oid,
