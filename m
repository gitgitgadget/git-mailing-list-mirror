Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30707C43462
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E81060190
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 14:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhDIOfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhDIOfl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 10:35:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F230C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 07:35:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 184so6728526ljf.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Fm1BsgqWXUVXz57uOuyV/THOFFyrCIDq3kS4IEkp4w=;
        b=PMe46jXLxGuvy8dlTWofzl8rJBDoLfrcOTCg8e7xT518hgCpXqKZOrkxMRwpVBLwYv
         cxjNqaMo1wpfWnWzX+4FrPqguCvIZC+6q97TOwy1F7fJdXM2UtxkNfHC1KFgl7byGZN5
         nTnuFLqaszCBxrVTXE2oHQv1Eg7w+WspkmF/N14NOcaMQ0b6fX8EhELGgVbaOVnajXsW
         uxwe6FEdpvPjLma0jal2ngI7HbByiTeC+Nb+yj2fnuIn55kXjpZ5D3r+fpX3uhATPyMZ
         tLBrUnSQqCiYxkgI1ykEqUo8/8wr87RiThZxE4MbJvmWWYEmgtpkqzkQvdUTPXGeGSBz
         VGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Fm1BsgqWXUVXz57uOuyV/THOFFyrCIDq3kS4IEkp4w=;
        b=Sm537F0D4EtBJYjS+CDeH+lWdXhI41923E1OvAWKM7bCtKdNs34M+GKnpMU9i0FcDP
         ww2+d57UkvvkYlsR8lH6u/0YrUm7Qk90Z3itQ+SQccFcAVbF5Lx7GoXcghWyF4EtEXmA
         +Gy35rHrOQV2vVPVlPOcoX0mZ0QRtX6ApPAJgOfbIyQQTESDeKg6tLXXG71FEV0EpJrE
         ifdt+alkR/FCBiozWVWUIWrssPoCpqjiqqnTT0VmUVo2xNJL1CYMDpu4Q5DzRF/sWLet
         Y+DDavOr3mTzV5mMvYUupBZwRxHX4cFbarHHQq1YOI86gCjMFbbi1dfy22NLJcTtSgqD
         JARg==
X-Gm-Message-State: AOAM533d6Y5/kGeih8srnbEu4IwhrPZPqC1MQrLvKoPsV8xOpJN5NtVU
        RbwAEoL/lei1dOH5FoFGabtl+oW+1lApQc8PWksfnQ==
X-Google-Smtp-Source: ABdhPJz7wLObvvZxubNm0F+eAmxHl1oO/FYgNtWiGqmuxZ5g4xH7sF4hJh5Ov+qFurXfvBzONGicg4xDOr9e33sKU2U=
X-Received: by 2002:a2e:6a12:: with SMTP id f18mr6114666ljc.113.1617978924939;
 Fri, 09 Apr 2021 07:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210408233936.533342-1-emilyshaffer@google.com> <20210408233936.533342-3-emilyshaffer@google.com>
In-Reply-To: <20210408233936.533342-3-emilyshaffer@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 9 Apr 2021 11:35:13 -0300
Message-ID: <CAHd-oW4VoBbZHc7cLdn0LPM531qNDGOfwPZdKiKoG4BoRFaqdg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] config: add 'config.superproject' file
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Emily

I'm not familiar enough with this code to give a full review and I
imagine you probably want comments more focused on the design level,
while this is an RFC, but here are some small nitpicks I found while
reading the patch. I Hope it helps :)

On Thu, Apr 8, 2021 at 8:39 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 4b4cc5c5e8..a33136fb08 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -48,7 +48,7 @@ unset an existing `--type` specifier with `--no-type`.
>
>  When reading, the values are read from the system, global and
>  repository local configuration files by default, and options
> -`--system`, `--global`, `--local`, `--worktree` and
> +`--system`, `--global`, `--superproject`, `--local`, `--worktree` and
>  `--file <filename>` can be used to tell the command to read from only
>  that location (see <<FILES>>).
>
> @@ -127,6 +127,17 @@ rather than from all available files.
>  +
>  See also <<FILES>>.
>
> +--superproject::
> +       For writing options: write to the superproject's
> +       `.git/config.superproject` file, even if run from a submodule of that
> +       superproject.

Hmm, I wonder what happens if a repo is both a submodule and a
superproject (i.e. in case of nested submodules). Let's see:

# Create repo/sub/sub2
$ git init repo
$ cd repo
$ touch F && git add F && git commit -m F
$ git submodule add ./ sub
$ git -C sub submodule add ./sub sub2
$ git -C sub commit -m sub2
$ git commit -m sub

# Now test the config
$ git -C sub/sub2 config --superproject foo.bar 1
$ git -C sub/sub2 config --get foo.bar
1
$ git -C sub config --get foo.bar
<nothing>
$ git config --get foo.bar
<nothing>

It makes sense to me that `foo.bar` is not defined on `repo`, but
shouldn't it be defined on `repo/sub`? Or am I doing something wrong?

(`git -C sub rev-parse --git-dir` gives `.git/modules/sub/`, where
indeed there is a config.superproject with `foo.bar` set.)

> diff --git a/builtin/config.c b/builtin/config.c
> index f71fa39b38..f0a57a89ca 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -26,7 +26,7 @@ static char key_delim = ' ';
>  static char term = '\n';
>
>  static int use_global_config, use_system_config, use_local_config;
> -static int use_worktree_config;
> +static int use_worktree_config, use_superproject_config;
>  static struct git_config_source given_config_source;
>  static int actions, type;
>  static char *default_value;
> @@ -130,6 +130,8 @@ static struct option builtin_config_options[] = {
>         OPT_GROUP(N_("Config file location")),
>         OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
>         OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
> +       OPT_BOOL(0, "superproject",
> +                &use_superproject_config, N_("use superproject config file")),
>         OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
>         OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
>         OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
> @@ -697,6 +699,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>         else if (use_system_config) {
>                 given_config_source.file = git_etc_gitconfig();
>                 given_config_source.scope = CONFIG_SCOPE_SYSTEM;
> +       } else if (use_superproject_config) {
> +               struct strbuf superproject_cfg = STRBUF_INIT;
> +               git_config_superproject(&superproject_cfg, get_git_dir());
> +               given_config_source.file = xstrdup(superproject_cfg.buf);
> +               given_config_source.scope = CONFIG_SCOPE_SUPERPROJECT;
> +               strbuf_release(&superproject_cfg);

Nit: maybe it would be a bit cleaner to replace the xstrdup() +
strbuf_release() lines with a single:

    given_config_source.file = strbuf_detach(superproject_cfg, NULL);

>         } else if (use_local_config) {
>                 given_config_source.file = git_pathdup("config");
>                 given_config_source.scope = CONFIG_SCOPE_LOCAL;
> diff --git a/config.c b/config.c
> index 67d9bf2238..28bb80fd0d 100644
> --- a/config.c
> +++ b/config.c
> @@ -21,6 +21,7 @@
>  #include "dir.h"
>  #include "color.h"
>  #include "refs.h"
> +#include "submodule.h"
>
>  struct config_source {
>         struct config_source *prev;
> @@ -1852,6 +1853,17 @@ const char *git_etc_gitconfig(void)
>         return system_wide;
>  }
>
> +void git_config_superproject(struct strbuf *sb, const char *gitdir)
> +{
> +       if (!get_superproject_gitdir(sb)) {
> +               /* not a submodule */
> +               strbuf_reset(sb);

Do we have to reset `sb` here? It seems that get_superproject_gitdir()
leaves the buffer empty when we are not inside a submodule.

> diff --git a/submodule.h b/submodule.h
> index 4ac6e31cf1..1308d5ae2d 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -149,6 +149,12 @@ void prepare_submodule_repo_env(struct strvec *out);
>  void absorb_git_dir_into_superproject(const char *path,
>                                       unsigned flags);
>
> +/*
> + * Return the gitdir of the superproject, which this project is a submodule of.
> + * If this repository is not a submodule of another repository, return 0.

Nit: it might be nice to say what's the state of `buf` on a 0 return.
Perhaps also be more explicit about the return codes? Maybe something
like:

"If this repository is a submodule of another repository, save the
superproject's gitdir on `buf` and return 1. Otherwise, return 0 and
leave `buf` empty."

> +int get_superproject_gitdir(struct strbuf *buf);
> +
>  /*
>   * Return the absolute path of the working tree of the superproject, which this
>   * project is a submodule of. If this repository is not a submodule of
> diff --git a/t/t1311-superproject-config.sh b/t/t1311-superproject-config.sh
> new file mode 100755
> index 0000000000..650c4d24c7
> --- /dev/null
> +++ b/t/t1311-superproject-config.sh
> @@ -0,0 +1,124 @@
[...]
> +test_expect_success 'superproject config applies to super and submodule' '
> +       cat >.git/config.superproject <<-EOF &&
> +       [foo]
> +               bar = baz
> +       EOF
> +
> +       git config --get foo.bar &&
> +       git -C sub config --get foo.bar &&
> +
> +       rm .git/config.superproject

Hmm, if this test fails before removing the config.superproject file,
couldn't it interfere with other tests (like the 'can --edit
superproject config')? Perhaps this and the other similar cleanup
removals could be declared inside a `test_when_finished` clause, to
ensure they are performed even on test failure.

> +test_expect_success 'can --unset from super or sub' '
> +       git config --superproject apple.species honeycrisp &&
> +       git -C sub config --superproject banana.species cavendish &&
> +
> +       git config --unset --superproject banana.species &&
> +       git -C sub config --unset --superproject apple.species
> +'

Nice "cross-setting/unsetting" test :)

[...]
> +# This test deletes the submodule! Keep it at the end of the test suite.
> +test_expect_success 'config.submodule works even with no submodules' '

s/config.submodule/config.superproject/ ?
