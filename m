Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA3C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 12:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF64065036
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 12:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhCPMxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCPMwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 08:52:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B7C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 05:52:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id e19so72014253ejt.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4Jsvgs+okMXZsq1nPEAmSVcPVSx7Lsq0TPi6tf7QcRU=;
        b=DfsRmDtcVHKZK5ZfdwNYZY7oXd/BKN8CMYzO7b8Fnd8xDsZmR+UjXXyXU6nU/foSmu
         CtVkYwgr4+Gu/xJYcbfuis9vYPehHZAsNTC5lAniMeGv2yZ2tKRPmkEhGEFq57kzdfCl
         6vXgiC+4Qr4JZEW3tstYoD8o/ceOMALvQF6nkbPDVAVQps7budVWh8NuZAnX6Q70iwxU
         qMl1GVZlcLMoMVhY7gfQfRNwAo0r9+evwrkL2IVxOIU2ENkHAk6r3iiJYAhOL48yAcNz
         WeT8Bev0SgkX/WNtjYcV6+P8W8nAAEc6005w6XVcP17OlUwShko589hClMU7MhVYq2VU
         Vmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4Jsvgs+okMXZsq1nPEAmSVcPVSx7Lsq0TPi6tf7QcRU=;
        b=gc/ox7SjlvECb5ZgTw9SznIPWyYoCSb06PT+/peslKM257lwGM7hQm4EG3XzP1Khbi
         NVdKvBcvvNUhG0sQGaTK3UzT9MJ22W7ZU7GYd/KO29M1hJvfQbLL+pPBzEO53e3ps1Gs
         7FX8zcLF6t1mjFIL7ywNCj0PHthjTV41RQX846t4ta3n3kvts5kKhoQYDTwHCMUvLpGV
         nxinuBFibGd9rSsMUNbIxeMOlgzyYeXpucCyYRDpJASHFIrlA5TxIaPwao8in7rAK30i
         9u5hDsHEhXvr03JB9QYvXWDAs8aAAFXTdCKBwOpbg9aoUSXFBdD7eRnBL9gXtnudiWQ0
         94ZQ==
X-Gm-Message-State: AOAM533hbeIY0lnRbNXMi+UF+RHxej/WjghWDUiD6RJSkTQY+3+6mjjw
        ejuHaC0Uh27BYXfWDmI+r4nfqWzbrJhUnQ==
X-Google-Smtp-Source: ABdhPJyKZU9oyzErBFpddPEm1xBjYVILZJb0xWHXPpBI6H18rjnQGO2YGA6JmyjLtwJ18xRgX/7XaQ==
X-Received: by 2002:a17:907:d15:: with SMTP id gn21mr28682579ejc.337.1615899167631;
        Tue, 16 Mar 2021 05:52:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lu26sm9222354ejb.33.2021.03.16.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 05:52:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v8 1/2] [GSOC] commit: add --trailer option
References: <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com>
 <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
 <f81b6e66a6ba6b2fc8e6307dbc5fba9cddcff181.1615813658.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <f81b6e66a6ba6b2fc8e6307dbc5fba9cddcff181.1615813658.git.gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 13:52:46 +0100
Message-ID: <87zgz3dzvl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 15 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Historically, Git has supported the 'Signed-off-by' commit trailer
> using the '--signoff' and the '-s' option from the command line.
> But users may need to provide other trailer information from the
> command line such as "Helped-by", "Reported-by", "Mentored-by",
>
> Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
> other trailers to `interpret-trailers` and insert them into commit
> messages.

I paged through v1-v8, looking mostly good so far. Some comments:

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-commit.txt |  9 ++++++++-
>  builtin/commit.c             | 23 +++++++++++++++++++++++
>  t/t7502-commit-porcelain.sh  | 20 ++++++++++++++++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 17150fa7eabe..f74d320f0c96 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>  	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> -	   [-S[<keyid>]] [--] [<pathspec>...]
> +	   [-S[<keyid>]] [--] [<pathspec>...] [(--trailer <token>[(=|:)<value>])...]
>  
>  DESCRIPTION
>  -----------
> @@ -166,6 +166,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>  
>  include::signoff-option.txt[]
>  
> +--trailer <token>[(=|:)<value>]::
> +	Specify a (<token>, <value>) pair that should be applied as a
> +	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
> +	<committer@example.com>" --trailer "Helped-by:C O Mitter \
> +	<committer@example.com>"` will add the "Signed-off-by" trailer
> +	and the "Helped-by" trailer in the commit message.)
> +	See linkgit:git-interpret-trailers[1] for details.
>  -n::
>  --no-verify::
>  	This option bypasses the pre-commit and commit-msg hooks.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 739110c5a7f6..250e93d977df 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,6 +113,7 @@ static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit, *pathspec_from_file;
> +static struct strvec trailer_args = STRVEC_INIT;
>  
>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -131,6 +132,14 @@ static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>  
> +static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
> +{
> +	BUG_ON_OPT_NEG(unset);
> +
> +	strvec_pushl(&trailer_args, "--trailer", arg, NULL);
> +	return 0;
> +}
> +
>  static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
>  {
>  	enum wt_status_format *value = (enum wt_status_format *)opt->value;
> @@ -958,6 +967,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  
>  	fclose(s->fp);
>  
> +	if (trailer_args.nr) {
> +		struct child_process run_trailer = CHILD_PROCESS_INIT;
> +
> +		strvec_pushl(&run_trailer.args, "interpret-trailers",
> +			     "--in-place", "--if-exists=add",
> +			     git_path_commit_editmsg(), NULL);
> +		strvec_pushv(&run_trailer.args, trailer_args.v);
> +		run_trailer.git_cmd = 1;
> +		if (run_command(&run_trailer))
> +			strvec_clear(&run_trailer.args);

This is git-commit, shouldn't we die() here instead of ignoring errors
in sub-processes?

> +		strvec_clear(&trailer_args);
> +	}
> +
>  	/*
>  	 * Reject an attempt to record a non-merge empty commit without
>  	 * explicit --allow-empty. In the cherry-pick case, it may be
> @@ -1507,6 +1529,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> +		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("trailer(s) to add"), PARSE_OPT_NONEG, opt_pass_trailer),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),

Not required for this change, but perhaps a change here to N_() (if we
can get it to fit) + doc update saying that we prefer
--trailer="Signed-Off-By: to --signoff"? More on that later.

>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 6396897cc818..0acf23799931 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -154,6 +154,26 @@ test_expect_success 'sign off' '
>  
>  '
>  
> +test_expect_success 'trailer' '
> +	>file1 &&
> +	git add file1 &&
> +	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
> +		--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
> +		--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
> +		--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
> +		-m "hello" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -e "1,7d" commit.msg >actual &&
> +	cat >expected <<-\EOF &&
> +	Signed-off-by: C O Mitter <committer@example.com>
> +	Signed-off-by: C O Mitter1 <committer1@example.com>
> +	Helped-by: C O Mitter2 <committer2@example.com>
> +	Reported-by: C O Mitter3 <committer3@example.com>
> +	Mentored-by: C O Mitter4 <committer4@example.com>
> +	EOF
> +	test_cmp expected actual
> +'
> +

How does this interact with cases where the user has configured
"trailer.separators" to have a value that doesn't contain ":"?  I
haven't tested, but my reading of git-interpret-trailers(1) is that if
you supplied "=" instead that case would just work:

    By default only : is recognized as a trailer separator, except that
    = is always accepted on the command line for compatibility with
    other git commands.

I don't know if that does the right thing in the presence of
--if-exists=add.

So it would be good to update these tests so you test:

 * For the --if-exists=add case at all, there's no tests for it
   now. I.e. add some trailers manually to the commit (via -F or
   whatever) and then see if they get added to, replacet etc.

 * Ditto but for the user having configured trailer.separators (see the
   test_config helper for how to set config in a test). I.e. if it's "="
   does adding trailers work, how about if it's "=" on the CLI but the
   config/commit message has ";" instead of ":" or something?

 * Hrm, actually I think tweaking "-c trailer.ifexists" won't work at
   all, since the CLI switch would override it. I honestly don't know,
   but why not not supply it and keep the addIfDifferentNeighbor
   default?

   If it's essential that seems like a good test / documentation
   addition...

 * For the above -c ... case I can't think of a good way to deal with it
   that doesn't involve pulling in git_trailer_config() into
   git_commit_config(), but perhaps the least nasty way is to just set a
   flag in git_commit_config() if we see a "trailer.ifexists" flag, and
   if so don't provide "--if-exists=add", if there's no config (this
   will include "git -c ... commit" we set provide "--if-exists=add" )
   or as noted above, maybe we can skip the whole thing and use the
   addIfDifferentNeighbor default.

And, not needed for this patch but worth thinking about:

 * We pass through --trailer to git-interpret-trailers, what should we
   do about the other options? Should git-commit eventually support
   --trailer-where and pass it along as --where to
   git-interpret-trailers, or is "git -c trailer.where=... commit" good
   enough?

 * It would be good to test for and document if that "-c trailer.*"
   trick works (no reason it shouldn't). I.e. to add something like this
   after what you have (along with tests, and check if it's even true):

       Only the `--trailer` argument to
       linkgit:git-interpret-trailers[1] is supported. Other
       pass-through switches may be added in the future, but currently
       you'll need to pass arguments to
       linkgit:git-interpret-trailers[1] along as config, e.g. `git -c
       trailer.where=start commit [...] --trailer=[...]`.
      
 * We have a longer-term goal of having the .mailmap apply to trailers,
   it would be nice if git-interpret-trailers had some fuzzy-matching to
   check if the RHS of a trailer is a name/E-Mail pair, and if so did
   stricter validation on it with the ident functions we use for fsck
   etc. (that's copied & subtly different in several different places in
   the codebase, unfortunately[1]).

More thoughts:

 * Having written all the above I checked how --signoff is implemented.

   It seems to me to be a good idea to (at least for testing) convert
   the --signoff trailer to your implementation. We have plenty of tests
   for it, does migrating it over pass or fail those?

 * I also agree with Junio that we shouldn't have a --fixed-by or
   whatever and wouldn't add --signoff today, but it seems very useful
   to me to have a shortcut like:

       --trailer "Signed-off-by"

   I.e. omitting the value, or:

      --trailer "Signed-off-by="

   Or some other thing we deem sufficiently useful/sane
   syntax/unambiguous.n

   Then the value would be provided by fmt_name(WANT_COMMITTER_IDENT)
   just as we do in append_signoff() now. I think a *very common* case
   for this would be something like:

       git commit --amend -v --trailer "Reviewed-by"

   And it would be useful to help that along and not have to do:

       git commit --amend -v --trailer "Reviewed-by=$(git config user.name) <$(git config user.email)>"

   Or worse yet, manually typo your name/e-mail address, as I'm sure I
   and many others will inevitably do when using this option...

1. https://lore.kernel.org/git/87bld8ov9q.fsf@evledraar.gmail.com/
