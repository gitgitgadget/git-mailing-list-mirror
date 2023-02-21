Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAFDC64EC7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBUSi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 13:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjBUSiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 13:38:22 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B211D92A
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:38:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d1-20020a17090a3b0100b00229ca6a4636so6155301pjc.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlapT+WDbDo+7Wc7iw5Zh004AnmgKDIB2DvsPqlKyQ0=;
        b=aAwAOrqZfo15zFDG/31fUYuDTqt0M/TF7NKCm/1wo/mBA8uwEvAwzTQztL3SW25wVN
         UXTV4aEqMzhmEdiwd8WTRM3ezAnbrQ65IyQNrMigeh7gqXr7DsMHg98DE0QR58G6PAkx
         liPE0l6RNw5ZmVXGUOmybz67EetDagSzowT3PAonwerO15mIsaBFY8aoO2Jmp3hReoxF
         aHtdySvWRhchFs9Rov2fe7BnUODscJgdwknu+J6k0BzDxo4Mrv10JBJgghaUec9o+1V/
         dsg+RERcnQLUHsYXVk7G6DQ8Y4YchtGYm9ZIxe2Ct2XgUux8ZR0623kSTC8c/gV6WmRr
         gwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlapT+WDbDo+7Wc7iw5Zh004AnmgKDIB2DvsPqlKyQ0=;
        b=LpmlBY0lftlU5ETv0OT124uj4G+GuuaOS0NbgRbn6l2r9UYs2GUVvpAg7tTlo9qdd1
         Zr+0fiqhy3DZ2Z5QZqtqg/YHRgx2VH3AukZtI6yBVV+D4qCZjYmVJhnAt7/oGrCrba0e
         vCQf/62G8Mc/ipB3AuY53LE4lfw55cRqgpUAdD6Yo4UdwDXPJGgOsYfEfe2tcbsKp3eK
         wlvdrQJfGEUw2+fse8bI5u7Iw8fQJTm5C13c2eigX9RnjhuV4dgnSdJ1e+NxufYmb2Pq
         BNq+phwfgzXzLHsQG4IxAwSpM+kznOYksZOYj0PfO3q325v8l7qbrn/PozlqJ9UvkpXn
         dbOQ==
X-Gm-Message-State: AO0yUKVModzCsIqyNV/wy87vxNseYGhhoGIDnjEQxIy5sTruIv3AGZTb
        ND5afUN+Rd6pN1ktfNMbm6u1HAgqhHQ=
X-Google-Smtp-Source: AK7set87y7eeHcmnneFkihn7BmZqsN1NM270VpE4YgjrSqTZHvCio4DHQjsXwvi7SYu0SFpDH5Hvow==
X-Received: by 2002:a05:6a20:9387:b0:c0:c905:7b09 with SMTP id x7-20020a056a20938700b000c0c9057b09mr17072025pzh.44.1677004697782;
        Tue, 21 Feb 2023 10:38:17 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j3-20020aa78d03000000b00593e5a45ce7sm10197654pfe.173.2023.02.21.10.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:38:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] restore: fault --staged --worktree with merge opts
References: <20230218163936.980-1-andy.koppe@gmail.com>
Date:   Tue, 21 Feb 2023 10:38:16 -0800
In-Reply-To: <20230218163936.980-1-andy.koppe@gmail.com> (Andy Koppe's message
        of "Sat, 18 Feb 2023 16:39:36 +0000")
Message-ID: <xmqqa616g8yv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> The 'restore' command already rejects the --merge, --conflict, --ours
> and --theirs options when combined with --staged, but accepts them when
> --worktree is added as well.
>
> Unfortunately that doesn't appear to do anything useful. The --ours and
> --theirs options seem to be ignored when both --staged and --worktree
> are given, whereas with --merge or --conflict, the command has the same
> effect as if the --staged option wasn't present.

I think "--ours" and "--theirs" should not have any effect unless
you are checking out from the index to the working tree.  And
"--worktree --staged" (i.e. update both working tree and the index
[*]) is clearly outside that use case.  It is understandable that
these options are not "honored", simply because there is no sane way
to "honor" them [*], but it may give us a nicer end-user experience
if we noticed such incompatible combinations of options and errored
out, instead of silently ignored them.

	Side note: "--staged" here is a bit of misnomer, but it
        unfortunately is way too late to fix.  When an option
        affects only the index, "--cached" is how we spell it (and
        "--index" is an option that makes the command affect both
        the index and the working tree).

	Side note 2: it is conceivable that --worktree --staged
	--ours may want to (1) resolve the conflicted path to stage
	#2 in the index and (2) check out the result in the working
	tree.  But until such an improved behaviour gets
	implemented, it is probably better to error it out for now.
	It is much easier to allow what has been forbidden later,
	than changing the behaviour of a command to work
	differently.

> So reject those options with '--staged --worktree' as well, using
> opts->accept_ref to distinguish restore from checkout.

OK.  This probably deserves in-code comment, if the patch is
introducing behaviour that is specific to only one command in a
codepath that is shared across multiple commands.

I like the general thrust of the change, but have some comments on
the implementation.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a5155cf55c..b09322f7c8 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -489,13 +489,11 @@ static int checkout_paths(const struct checkout_opts *opts,
>  		die(_("'%s' must be used when '%s' is not specified"),
>  		    "--worktree", "--source");
>  
> -	if (opts->checkout_index && !opts->checkout_worktree &&
> -	    opts->writeout_stage)
> +	if (!opts->accept_ref && opts->checkout_index && opts->writeout_stage)
>  		die(_("'%s' or '%s' cannot be used with %s"),
>  		    "--ours", "--theirs", "--staged");

We used to die when "--ours/--theirs" is given (i.e. writeout_stage
is not 0), checkout_index is set *AND* checkout_worktree is not set,
i.e. when "--staged" (i.e. restore the path in the index) but not
"--worktree" is in effect.

Now, we drop "checkout_worktree is not set" as the condition, but
only when we are doing "git restore".  We die "--ours/--theirs" is
given and checkout_index is set, i.e. "--staged" is there, whether
"--worktree" is given or not.

Makes sense.

> -	if (opts->checkout_index && !opts->checkout_worktree &&
> -	    opts->merge)
> +	if (!opts->accept_ref && opts->checkout_index && opts->merge)
>  		die(_("'%s' or '%s' cannot be used with %s"),
>  		    "--merge", "--conflict", "--staged");

Likewise.

> +test_expect_success 'restore with merge options rejects --staged' '
> +	test_must_fail git restore --staged --merge . -- 2>err1 &&

What is "." meant to be on this command line?  If it is "the whole
working tree", it should come after the double-dash "--", no?  As
written, I _think_ it is stripping "--" at the end, but ".", which
was written before "--" to explicitly say "this is not a pathspec",
is still taken as a pathspec (which may be a bug in the option
parsing code).

> +	test_i18ngrep "cannot be used with" err1 &&

"test_i18ngrep" is on its way out (it was part of an older way for
i18n testing that has been removed).  We can use "grep" instead.

> +	test_must_fail git restore --staged --conflict=diff3 . -- 2>err2 &&
> +	test_i18ngrep "cannot be used with" err2 &&
> +	test_must_fail git restore --staged --ours . -- 2>err3 &&
> +	test_i18ngrep "cannot be used with" err3 &&
> +	test_must_fail git restore --staged --theirs . -- 2>err4 &&
> +	test_i18ngrep "cannot be used with" err4
> +'

Not making a suggestion yet, but thinking aloud.  Would it make it
easier to see what is being tested if we wrote these as a loop:

	for opts in \
		"--staged --merge" \
		"--staged --conflict=diff3" \
		"--staged --ours" \
		"--staged --theirs"
	do
		test_must_fail git restore $opts 2>err &&
		grep "cannot be used with" err || return
	done

Without having to skip every alternating lines, we can see what
option combinations are being tested fairly easily when written that
way, perhaps?

> +test_expect_success 'restore with merge options rejects --staged --worktree' '
> +	test_must_fail git restore --staged --worktree --merge . -- 2>err1 &&
> +	test_i18ngrep "cannot be used with" err1 &&
> +	test_must_fail git restore --staged --worktree --conflict=diff3 . -- 2>err2 &&
> +	test_i18ngrep "cannot be used with" err2 &&
> +	test_must_fail git restore --staged --worktree --ours . -- 2>err3 &&
> +	test_i18ngrep "cannot be used with" err3 &&
> +	test_must_fail git restore --staged --worktree --theirs . -- 2>err4 &&
> +	test_i18ngrep "cannot be used with" err4
> +'
> +
>  test_done

Thanks.
