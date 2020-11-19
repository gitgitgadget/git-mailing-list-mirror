Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30093C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C1922267
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QWxouu9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgKSTQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:16:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60573 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgKSTQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 14:16:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B51B80B69;
        Thu, 19 Nov 2020 14:16:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DASzpaW1dTsvpqS4DNBegRC0pJQ=; b=QWxouu
        9dppsBsyAQvlqW5qqTFlWkUQaDPuGWxHjgXM5bK3m4EWenO1oVh0L3FhQKdK6WNL
        4naU4CKfa4zl0KO//ElNcVobJy1Qk9uEnlg0TBK5dhUzd0v694MyYwQ317z1m77r
        HOVg0Zmm6+tw8VScg44ORxyQT8adWMVJ8E4ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dQmb8RFAI8Wa+xB6ZT7pvTc7xrrWp39y
        u1JU0/vg52PuAS3vlUZLxk5frZy1v7ruuQ059eQJhnjht3Ix26Iuxn4zjnARV+Nh
        C7Hb7DLS+GjWP6aYQZ0a2NBBJ6S+R8oLSMfR0RyTt4yo69TnvuW97YlRjdVDej3J
        qQIKuK4m6Dc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4389780B67;
        Thu, 19 Nov 2020 14:16:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0D7480B65;
        Thu, 19 Nov 2020 14:16:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v3] hooks: allow input from stdin for commit-related hooks
References: <pull.790.v2.git.1605801043899.gitgitgadget@gmail.com>
        <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 11:16:34 -0800
In-Reply-To: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com> (Orgad
        Shaneh via GitGitGadget's message of "Thu, 19 Nov 2020 15:56:16
        +0000")
Message-ID: <xmqqwnyhxilp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD3C0954-2A9B-11EB-96ED-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Let hooks receive user input if applicable.
>
> Closing stdin originates in f5bbc3225 (Port git commit to C,
> 2007). Looks like the original shell implementation did have
> stdin open. Not clear why the author chose to close it on
> the C port (maybe copy&paste).

Please drop unsubstanciated guess in the parentheses.  If anything,
we've learned during the discussion thread that it is a bad idea to
leave the standard input open when spawning hooks in general, and to
me it looks like a lot more plausible reason why we tightened the
interface when it was made from "only to run hooks for 'git commit'"
to an interface that more widely usable to run any hook.  If we are
not going to record that finding in the log message to help people
to find out what we knew at the time when the commit was created,
then we shouldn't mislead them with "maybe copy&paste" that is not
backed by anything other than a hunch.

> Allow stdin only for commit-related hooks. Some of the other
> hooks pass their own input to the hook, so don't change them.

Before this paragraph that gives orders to the code to "be like so",
the log message needs to explain why it is a good idea to make such
a change.  Which hook benefits by being able to read the standard
input?  Describe what becomes possible in terms of end-user visible
effects (i.e. "now reading standard input becomes possible for
pre-commit hook" is *not* an answer.  What new things a pre-commit
hook that now can read from the standard input do for the end user?)
to justify why such a change is a good thing to have, before this
paragraph to justify why leaving the standard input open for hooks
run by "git commit" is a good idea and is a safe thing to do.

Note that even "git commit" may compete for its standard input with
hooks. "git commit -F - <message" currently may read the message to
EOF before doing anything interesting like spawning a hook, but it
is not implausible that the reading of the message may want to
happen much later in a future codebase, at which point the hook may
end up stealing the beginning of the message by reading from the
standard input.  So ideally, if we can find a way to selectively
close the standard input for the hooks if "git commit" itself uses
the standard input, that would be better than unconditionally
leaving it open.

Let's reorder the patch hunks to see the bottom layer first, as the
callers are mostly the same.

> diff --git a/run-command.h b/run-command.h
> index 6472b38bde..e6a850c6fe 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -201,11 +201,16 @@ int run_command(struct child_process *);
>   */
>  const char *find_hook(const char *name);
>  
> +#define RUN_HOOK_ALLOW_STDIN 1
> +
>  /**
>   * Run a hook.
> - * The first argument is a pathname to an index file, or NULL
> - * if the hook uses the default index file or no index is needed.
> - * The second argument is the name of the hook.
> + * The first argument is an array of environment variables, or NULL
> + * if the hook uses the default environment and doesn't require
> + * additional variables.
> + * The second argument is zero or RUN_HOOK_ALLOW_STDIN, which enables
> + * stdin for the child process (the default is no_stdin).
> + * The third argument is the name of the hook.
>   * The further arguments correspond to the hook arguments.
>   * The last argument has to be NULL to terminate the arguments list.
>   * If the hook does not exist or is not executable, the return
> @@ -215,8 +220,8 @@ const char *find_hook(const char *name);
>   * On execution, .stdout_to_stderr and .no_stdin will be set.
>   */
>  LAST_ARG_MUST_BE_NULL
> -int run_hook_le(const char *const *env, const char *name, ...);
> -int run_hook_ve(const char *const *env, const char *name, va_list args);
> +int run_hook_le(const char *const *env, int opt, const char *name, ...);
> +int run_hook_ve(const char *const *env, int opt, const char *name, va_list args);

Is this new parameter meant to be used as an enum?  When the
run_hook interface gets extended the next time and we want a new
option, is the option expected to be mutually incompatible with
allow-stdin?  

I suspect that it would make this a more useful API if this new
parameter is not used as an enum but as a collection of flag bits.

If so, a few things must change in the above:

 - The description of the second parameter in the comment shouldn't
   say "zero or RUN_HOOK_ALLOW_STDIN"; it should rather say "an
   OR'ed collection of feature bits like RUN_HOOK_ALLOW_STDIN
   defined above"

 - The second parameter should be 'unsigned flags', not 'int opt'.

It is my understanding that "git commit" only needs run_hook_ve() to
drive its hook scripts.  Isn't it premature to touch run_hook_le(),
in which nobody wants to leave the standard input open while running
hooks?  It _might_ be a better idea to allow users of _le() to do
the same eventually, but then perhaps it is a good idea to do so in
a separate step at the end, as "only to be complete" patch.  That
is, the structure of the topic ought to be something like:

 - [PATCH 1/2] add the "unsigned flags" word to _ve(), assign the
   RUN_HOOK_ALLOW_STDIN bit, and update commit.c::run_commit_hook()
   to pass RUN_HOOK_ALLOW_STDIN to it.

 - [PATCH 2/2] after surveying the options "git commit" takes, find
   out the condition where "git commit" itself would want to consume
   the standard input (e.g. "commit -F -", there may be others), and
   tell run_commit_hook() *not* to pass RUN_HOOK_ALLOW_STDIN when we
   use the standard input ourselves (i.e. forbid hooks to read from
   it).

 - [PATCH 3/2] add the same "unsigned flags" word to _le(), and
   teach all callers to pass 0, as a "just for completeness" step.

Personally, I think we should stop at [2/2], and do not do [3/2], as
there is no real demonstrated use of the standard input for hooks.
Especially because users of the _le() interface includes programs
like receive-pack whose standard input should not be molested, I'd
feel safer not to see [3/2] done at all (for that matter, I'm not
happy with [1/2] unless it comes with [2/2], either).

> diff --git a/run-command.c b/run-command.c
> index 2ee59acdc8..21b1f0a5e9 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1343,7 +1343,7 @@ const char *find_hook(const char *name)
>  	return path.buf;
>  }
>  
> -int run_hook_ve(const char *const *env, const char *name, va_list args)
> +int run_hook_ve(const char *const *env, int opt, const char *name, va_list args)
>  {
>  	struct child_process hook = CHILD_PROCESS_INIT;
>  	const char *p;
> @@ -1356,20 +1356,21 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
>  	while ((p = va_arg(args, const char *)))
>  		strvec_push(&hook.args, p);
>  	hook.env = env;
> -	hook.no_stdin = 1;
> +	if (!(opt & RUN_HOOK_ALLOW_STDIN))
> +		hook.no_stdin = 1;

OK, so you are using the parameter as a flag word after all.  Then
"int opt" should definitely be "unsigned flags".  And these two
lines would be more readable, when written like so:

	hook.no_stdin = !(flags & RUN_HOOK_ALLOW_STDIN);

I would think.

>  	hook.stdout_to_stderr = 1;
>  	hook.trace2_hook_name = name;
>  
>  	return run_command(&hook);
>  }
>  
> -int run_hook_le(const char *const *env, const char *name, ...)
> +int run_hook_le(const char *const *env, int opt, const char *name, ...)
>  {
>  	va_list args;
>  	int ret;
>  
>  	va_start(args, name);
> -	ret = run_hook_ve(env, name, args);
> +	ret = run_hook_ve(env, opt, name, args);

I'd rather not to see the function signature of _le() changed in
patches [1/2] and [2/2]; instead we can just pass hardcoded 0 from
here to the underlying _ve().

Now, what is left is individual commands that use the run_hook
interface.

> diff --git a/commit.c b/commit.c
> index fe1fa3dc41..775019ec9d 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1646,7 +1646,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
>  		strvec_push(&hook_env, "GIT_EDITOR=:");
>  
>  	va_start(args, name);
> -	ret = run_hook_ve(hook_env.v, name, args);
> +	ret = run_hook_ve(hook_env.v, RUN_HOOK_ALLOW_STDIN, name, args);
>  	va_end(args);
>  	strvec_clear(&hook_env);
>  

This is good for [1/2].  We should avoid "git commit" from competing
with hooks for its standard input by conditionally passing
ALLOW_STDIN from here---only when the program itself does not use
the standard input in [2/2].

> diff --git a/builtin/am.c b/builtin/am.c

"git am <mbox" reads from the mailbox.  "git am -i" interacts with
the end user via its stdin/stdout.  There may be other situations
where the hooks should not touch the standard input.

> diff --git a/builtin/checkout.c b/builtin/checkout.c

I do not offhand think of a reason why "git checkout" would compete
with its hooks for the standard input.  If we were to allow hooks to
read from the standard input, that should come as an independent
patch for each program after patch [3/2], I think.  The ones I don't
mention below should never leave the standard input open for hooks.

> diff --git a/builtin/clone.c b/builtin/clone.c
> diff --git a/builtin/gc.c b/builtin/gc.c
> diff --git a/builtin/merge.c b/builtin/merge.c
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> diff --git a/reset.c b/reset.c

Ditto.


> diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> index b3485450a2..e915ffe546 100755
> --- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> +++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> @@ -7,6 +7,7 @@ test_description='pre-commit and pre-merge-commit hooks'
>  HOOKDIR="$(git rev-parse --git-dir)/hooks"
>  PRECOMMIT="$HOOKDIR/pre-commit"
>  PREMERGE="$HOOKDIR/pre-merge-commit"
> +POSTCOMMIT="$HOOKDIR/post-commit"
>  
>  # Prepare sample scripts that write their $0 to actual_hooks
>  test_expect_success 'sample script setup' '
> @@ -28,11 +29,15 @@ test_expect_success 'sample script setup' '
>  	echo $0 >>actual_hooks
>  	test $GIT_PREFIX = "success/"
>  	EOF
> -	write_script "$HOOKDIR/check-author.sample" <<-\EOF
> +	write_script "$HOOKDIR/check-author.sample" <<-\EOF &&
>  	echo $0 >>actual_hooks
>  	test "$GIT_AUTHOR_NAME" = "New Author" &&
>  	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
>  	EOF
> +	write_script "$HOOKDIR/user-input.sample" <<-\EOF
> +	! read -r line || echo "$line" > hook_input
> +	exit 0

Style (Documentation/CodingGuidelines)

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.

So, when our "read" immediately hits EOF (or I/O error, but let's
not worry about that case for now), we leave hook_input file alone,
but otherwise we write the single line we read to hook_input, and
regardless of an error, we report success to the invoking "git
commit".  Which makes sense.

We report success even when we had trouble writing into hook_input
file, though.  Perhaps you should lose the "exit 0" at the end?

> +	EOF
>  '
>  
>  test_expect_success 'root commit' '
> @@ -278,4 +283,34 @@ test_expect_success 'check the author in hook' '
>  	test_cmp expected_hooks actual_hooks
>  '
>  
> +test_expect_success 'with user input' '
> +	test_when_finished "rm -f \"$PRECOMMIT\" user_input hook_input" &&
> +	cp "$HOOKDIR/user-input.sample" "$PRECOMMIT" &&
> +	echo "user input" > user_input &&

Style (I won't repeat from here on).

> +	echo "more" >>file &&
> +	git add file &&
> +	git commit -m "more" < user_input &&
> +	test_cmp user_input hook_input
> +'

This is probably a good place to also test

	git commit -F - <user_input

and see what happens.

Thanks.
