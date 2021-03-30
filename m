Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9148C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08BE61959
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 10:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhC3KOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 06:14:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:40213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhC3KNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 06:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617099215;
        bh=RJDSclSAO86BAAnO/z4qLgJRlt5d1gm1U2DUDLwY1GM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MbyQPZzNQlBdWn/NAlL46EE7UEI5raF3UhTVfwKLr0+t+Wb6+JjVLYhcxH1VyXcC3
         WsAm05O7B1r7R6G/LjzHtwOo9dMdKT9fHBnZ94tk5Hn1kbTcSVl0alIrx+544EpBPe
         PLPQ2Gm89LG8WAgeSUxQol2p9+LakXg43j3lznXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.127.121] ([213.196.213.200]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1lXTyH2xwp-007SSI; Tue, 30
 Mar 2021 12:13:34 +0200
Date:   Tue, 30 Mar 2021 12:13:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and
 revert messages
In-Reply-To: <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com> <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZO2JKo/ZHRXBqab6OiyCLN/jag3Z5Azlol4fTnNjR1ncX8/T4aH
 908cUYB8GiVDgkODq7DHKcC6Pm8ROufP6cGaRD6eKTfCJm7ieyCXNOlhw+76zE07TRWVDjs
 WieqoL7jny7Nry0jl4M1aKG18jNe0DgE4nhLFKBTU10EMkP6R6Ost4qfu30BWfkQNIkkQNn
 WYMnPfAatBhEG0IkbISeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1cTdwMJFs6s=:gpjg4/vkVNFbhu7//WERk8
 Tf1s8u8KzArsGJBulM/yu1t9bhO4hCVlokBv36Ff7B2/EHsHpEFCELL8PLOYvpiEi0Vy58XL9
 NNqZqrt3TwL6rzwwVs9n0ketVYcY5SEv9NY4QPo3Xf2fUdbb3SrUZfS2pe7MR9YfWX53jIJj4
 vd5rpZYVs4YrXVhBtncjgXTvYpACRZpDhTgwjnIKnK++V21x93YJ5YiQVvJuape7Ncvvq43WQ
 suDCZqod6hUG8YyeoGiFkEgGiiOD2JtTFOres9ORcWPi22HmmErsexffgAVgIrJiJtKnl9HMN
 bwsp58FSwOfLaAJmJrJQ8uotFyxKzRiEE8qUz1h/D37TG5ENiafWHWMcAbw2E/xcRDnTzy+NF
 in8HUBcdBZ0QmKF+CxT0awWO0cHWrZWI3BFJhJS2ubkhN4qfNipY43YG3UVt+nHN9gnuGIK+T
 XS1UT4gHfOHUucBq62dWOQ/1fifGVhRM7WSqbXaBBpimEVKS65WZSJZKzAE/TGsfz7NId12jL
 r9MmC3GBl7MRXjFGYhRBZLpCJnBgEVHoJrz1pxSKEu/ddPkzx95b1STnw4PU/IPVWWgm0g6ie
 byrNRMgj4E+E5r/ksWjOAZT1IfFtTaUy1McKpG/1I9k1KEQegh7nwYeWGEfN1L1Kmu0ViMLN2
 pVHI1ZhH6GozOjrbDKzARqsd3HdUxK/9ZkukcQQzx0lOUxSLyJvnqb5vLiKVddQ/7qZWCuB7M
 siDyd9tu8h+uYBjtHmdMCMzMVNTHm6VoE5gPN6QQxzUuw92QApbAduPJSFplNw5vy5tZasEAW
 PKwY+M/OK4L0PBc6fevUNKhOm9d9Du0kmckVX1UzQZnekGHSwGIO5vqW1J93HIlUdyJFIQ+LE
 JUT99QtRlCaakhbOn2/jvCZ4xHwZK4eQlTcYPbcOYFPw2nsGny4gLjHeNmjF60fI6QWd2qrEJ
 8oSehErGWtdQAocXewrft9qhNYSR9nlkhWW17WA1RGqY9thC/mJjkTyXCWl0JjbJZ7FXzrPGT
 wSCJlxQMYI1qOkhJNZE45YhPKXajVXuAK6WHFi7hYBLIaV30OfaDn3CVOh2t79F5Y8V9xlUbG
 23mqJ/2QRIPcbsaCjVARw7tElle0RsUkQ1rjRRTqR9XpUgFxb6vR8ORdnwJZAYKvy2hUO3CRm
 PNOgbZwXf39fawmN8Yvp+yC11BX56ba1VJQwj31HSoyihzP5r3uuAMF6Xxkmc4/eTIQoHS7Fu
 M5BQILWBP6KPkigyC
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 30 Mar 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> save_opts() should save any non-default values.  It was intended to do
> this, but since most options in struct replay_opts default to 0, it only
> saved non-zero values.  Unfortunately, this does not always work for
> options.edit.  Roughly speaking, options.edit had a default value of 0
> for cherry-pick but a default value of 1 for revert.  Make save_opts()
> record a value whenever it differs from the default.
>
> options.edit was also overly simplistic; we had more than two cases.
> The behavior that previously existed was as follows:
>
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit (ignore isatty(0))
>     cherry-pick        No edit                 See above
>     Specify --edit     Edit (ignore isatty(0)) See above
>     Specify --no-edit  (*)                     See above
>
>     (*) Before stopping for conflicts, No edit is the behavior.  After
>         stopping for conflicts, the --no-edit flag is not saved so see
>         the first two rows.
>
> However, the expected behavior is:
>
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit iff isatty(0)
>     cherry-pick        No edit                 Edit iff isatty(0)
>     Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
>     Specify --no-edit  No edit                 No edit
>
> In order to get the expected behavior, we need to change options.edit
> to a tri-state: unspecified, false, or true.  When specified, we follow
> what it says.  When unspecified, we need to check whether the current
> commit being created is resolving a conflict as well as consulting
> options.action and isatty(0).  While at it, add a should_edit() utility
> function that compresses options.edit down to a boolean based on the
> additional information for the non-conflict case.
>
> continue_single_pick() is the function responsible for resuming after
> conflict cases, regardless of whether there is one commit being picked
> or many.  Make this function stop assuming edit behavior in all cases,
> so that it can correctly handle !isatty(0) and specific requests to not
> edit the commit message.

Nicely explained!

I'll allow myself one tangent: the subject of the sequencer's Unix shell
script heritage seems to come up with an increasing frequency, in
particular the awful "let's write out one file per setting" strategy.

I would _love_ for `save_opts()` to write a JSON instead (or an INI via
the `git_config_*()` family of functions, as is done already by the
cherry-pick/revert stuff), now that we no longer have any shell script
backend (apart from `--preserve-merges`, but that one is on its way out
anyway).

The one thing that concerns me with this idea is that I know for a fact
that some enterprisey users play games with those files inside
`<GIT_DIR>/rebase-merge` that should be considered internal implementation
details. Not sure how to deprecate that properly, I don't think we have a
sane way to detect whether users rely on these implementation details
other than breaking their expectations, which is not really a gentle way
to ask them to update their scripts.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 314a86c5621b..81441020231a 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -182,7 +182,7 @@ static int run_sequencer(int argc, const char **argv=
, struct replay_opts *opts)
>  				"--signoff", opts->signoff,
>  				"--no-commit", opts->no_commit,
>  				"-x", opts->record_origin,
> -				"--edit", opts->edit,
> +				"--edit", opts->edit =3D=3D 1,

Honestly, I'd prefer `> 0` here.

>  				NULL);
>
>  	if (cmd) {
> @@ -230,8 +230,6 @@ int cmd_revert(int argc, const char **argv, const ch=
ar *prefix)
>  	struct replay_opts opts =3D REPLAY_OPTS_INIT;
>  	int res;
>
> -	if (isatty(0))
> -		opts.edit =3D 1;
>  	opts.action =3D REPLAY_REVERT;
>  	sequencer_init_config(&opts);
>  	res =3D run_sequencer(argc, argv, &opts);
> diff --git a/sequencer.c b/sequencer.c
> index 848204d3dc3f..d444c778a097 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1860,14 +1860,26 @@ static void record_in_rewritten(struct object_id=
 *oid,
>  		flush_rewritten_pending();
>  }
>
> +static int should_edit(struct replay_opts *opts) {
> +	assert(opts->edit >=3D -1 && opts->edit <=3D 1);

Do we really want to introduce more of these useless `assert()`s? I know
that we stopped converting them to `BUG()`, but I really dislike
introducing new ones: they have very little effect, being no-ops by
default in most setups.

> +	if (opts->edit =3D=3D -1)

Maybe `< 0`, as we do elsewhere for "not specified"?

> +		/*
> +		 * Note that we only handle the case of non-conflicted
> +		 * commits; continue_single_pick() handles the conflicted
> +		 * commits itself instead of calling this function.
> +		 */
> +		return (opts->action =3D=3D REPLAY_REVERT && isatty(0)) ? 1 : 0;

Apart from the extra parentheses, that makes sense to me.

> +	return opts->edit;
> +}
> +
>  static int do_pick_commit(struct repository *r,
>  			  enum todo_command command,
>  			  struct commit *commit,
>  			  struct replay_opts *opts,
>  			  int final_fixup, int *check_todo)
>  {
> -	unsigned int flags =3D opts->edit ? EDIT_MSG : 0;
> -	const char *msg_file =3D opts->edit ? NULL : git_path_merge_msg(r);
> +	unsigned int flags =3D should_edit(opts) ? EDIT_MSG : 0;
> +	const char *msg_file =3D should_edit(opts) ? NULL : git_path_merge_msg=
(r);
>  	struct object_id head;
>  	struct commit *base, *next, *parent;
>  	const char *base_label, *next_label;
> @@ -3101,9 +3113,9 @@ static int save_opts(struct replay_opts *opts)
>  	if (opts->no_commit)
>  		res |=3D git_config_set_in_file_gently(opts_file,
>  					"options.no-commit", "true");
> -	if (opts->edit)
> -		res |=3D git_config_set_in_file_gently(opts_file,
> -					"options.edit", "true");
> +	if (opts->edit !=3D -1)

s/!=3D -1/>=3D 0/

> +		res |=3D git_config_set_in_file_gently(opts_file, "options.edit",
> +						     opts->edit ? "true" : "false");
>  	if (opts->allow_empty)
>  		res |=3D git_config_set_in_file_gently(opts_file,
>  					"options.allow-empty", "true");
> @@ -4077,7 +4089,7 @@ static int pick_commits(struct repository *r,
>  	prev_reflog_action =3D xstrdup(getenv(GIT_REFLOG_ACTION));
>  	if (opts->allow_ff)
>  		assert(!(opts->signoff || opts->no_commit ||
> -			 opts->record_origin || opts->edit ||
> +			 opts->record_origin || should_edit(opts) ||
>  			 opts->committer_date_is_author_date ||
>  			 opts->ignore_date));
>  	if (read_and_refresh_cache(r, opts))
> @@ -4370,14 +4382,35 @@ static int pick_commits(struct repository *r,
>  	return sequencer_remove_state(opts);
>  }
>
> -static int continue_single_pick(struct repository *r)
> +static int continue_single_pick(struct repository *r, struct replay_opt=
s *opts)
>  {
> -	const char *argv[] =3D { "commit", NULL };
> +	struct strvec argv =3D STRVEC_INIT;
> +	int want_edit;

Do we really want that extra `want_edit` variable? I think the code would
be easier to read without it, and still be obvious enough.

> +	int ret;
>
>  	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
>  	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
>  		return error(_("no cherry-pick or revert in progress"));
> -	return run_command_v_opt(argv, RUN_GIT_CMD);
> +
> +	strvec_push(&argv, "commit");
> +
> +	/*
> +	 * continue_single_pick() handles the case of recovering from a
> +	 * conflict.  should_edit() doesn't handle that case; for a conflict,
> +	 * we want to edit if the user asked for it, or if they didn't specify
> +	 * and stdin is a tty.
> +	 */
> +	want_edit =3D (opts->edit =3D=3D 1) || ((opts->edit =3D=3D -1) && isat=
ty(0));
> +	if (!want_edit)

Here is what I would prefer:

	if (!opts->edit || (opts->edit < 0 && !isatty(0)))

The rest looks good, and the comments are _really_ helpful.

And the remainder of the patch also looks good, so I will spare readers
time by not even quoting it.

Thank you!
Dscho
