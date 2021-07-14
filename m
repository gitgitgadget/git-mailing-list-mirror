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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2695C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A6F6136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhGNXTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 19:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhGNXTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 19:19:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F1C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:16:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dj21so5529043edb.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wkzrePOoeVDcweCYut3jgz2dQhpZoXdHsmk3db2aoTQ=;
        b=UWtZFIOCPLEogeZbQGfLky0mTPr17uSQTtZqw/qYZvfNdRR1+ROveTT/kfpK5R9OKC
         hyitfYItGvKJ5mUFhW6S0R1/W78DPoKaq4cAjW6TweKc8PBMNUG7Aycd+BDnXpZ+HeLF
         QB6gk3u9bibpBKdHMcavVmn/ocAXEVgeYT448MsYSZDpdxPvuT6D84HE7HcLf+9KIFYy
         stPFayyEunljVjOJspQ4OgC+PW3fnulCksQ7NuMLmPOkBdZUt2bjWpzgc3q75xvL4sGY
         k8zsBWDW5GNzcxwf1ytTdeXnRgH9Ll+coNQ1cQTAYHukHv3eXwMD71nL6NBtgiRdSU8U
         jBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wkzrePOoeVDcweCYut3jgz2dQhpZoXdHsmk3db2aoTQ=;
        b=Z9roun9KJFf3L/vYKp83jUotK0SUJEa3j4V6eAo+RSsIMYToVCaFFH4lYZ8M/qAPCa
         4UWgdji66NCrORjkkuVSbuJ+em9IRfwAT00wzO+69yfwsDRfwR/xcQN7/1xEAN8+9xZc
         uzKhE1jPRcaRvhSBEGqYbyb368S+Horpb9WuqOFkpb/s5wM+amC8BAJa4lDVgSO4Wf21
         UqRckBmV2wiuer6nEK13TGReG6FKxEzO5iv9KC9kuOmKdwXe0nUsoTi7qbJLyRw3aAvu
         xgIgsiAQJgCP0tUMmYetO+zHzra5XCdS4uYrMA+HcOXxi32dLMpoSxug8Q1b7aAK7xoR
         mx5g==
X-Gm-Message-State: AOAM531ACgLG1Ru1fRvCOCaNontQu8rwULZYs0VlIhWn2fiNWB01hE9z
        fyb0udSwmI9J5Dlyl8V2roKonvsEw2HTz8d9
X-Google-Smtp-Source: ABdhPJyXNcHrqMjJUwHe/4qoevuBrzdgPJWpMxeTxYD3hLwXO4HZs8sIoFaDDuIvPuvh6WanC8nKmw==
X-Received: by 2002:a05:6402:160d:: with SMTP id f13mr1030553edv.295.1626304587399;
        Wed, 14 Jul 2021 16:16:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gu15sm1214031ejb.63.2021.07.14.16.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:16:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 1/1] completion: graduate out of contrib
Date:   Thu, 15 Jul 2021 01:03:51 +0200
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <20210714202344.614468-1-felipe.contreras@gmail.com>
 <20210714202344.614468-2-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210714202344.614468-2-felipe.contreras@gmail.com>
Message-ID: <87bl74zdtb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Felipe Contreras wrote:

> These have been stable and widely used for quite a long time, they even
> have tests outside of the contrib area, and most distributions ship
> them, so they can be considered part of the core already.
>
> We should be consistent and either we move the tests to contrib, or we
> move the completions out of contrib.
>
> Let's move them out of contrib and provide an installation target
> install-extra.
>
> By default bash-completion installs the completions to
> $(pkgdatadir)/completions, which is
> $(prefix)/share/bash-completion/completions. And since most distributions do
> not change this, it is obviously the right default that distributions
> can override with bashcompdir.
>
> By default zsh looks for completions in
> $(prefix)/share/zsh/site-functions.

I'm very much in favor of this, i.e. both to promote git-completion.*,
and also to generally re-organize contrib/* a bit (not being done here).

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Makefile                                          | 10 ++++++++++
>  {contrib => extra}/completion/git-completion.bash |  0
>  {contrib => extra}/completion/git-completion.zsh  |  0
>  {contrib => extra}/completion/git-prompt.sh       |  0
>  t/t9902-completion.sh                             |  8 ++++----
>  t/t9903-bash-prompt.sh                            |  2 +-
>  6 files changed, 15 insertions(+), 5 deletions(-)
>  rename {contrib => extra}/completion/git-completion.bash (100%)
>  rename {contrib => extra}/completion/git-completion.zsh (100%)
>  rename {contrib => extra}/completion/git-prompt.sh (100%)
>
> diff --git a/Makefile b/Makefile
> index 502e0c9a81..0a13e5f077 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -532,6 +532,7 @@ sharedir = $(prefix)/share
>  gitwebdir = $(sharedir)/gitweb
>  perllibdir = $(sharedir)/perl5
>  localedir = $(sharedir)/locale
> +bashcompdir = $(sharedir)/bash-completion/completions
>  template_dir = share/git-core/templates
>  htmldir = $(prefix)/share/doc/git-doc
>  ETC_GITCONFIG = $(sysconfdir)/gitconfig
> @@ -2015,6 +2016,7 @@ bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
>  mandir_SQ = $(subst ','\'',$(mandir))
>  mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
>  infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
> +sharedir_SQ = $(subst ','\'',$(sharedir))
>  perllibdir_SQ = $(subst ','\'',$(perllibdir))
>  localedir_SQ = $(subst ','\'',$(localedir))
>  localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
> @@ -2025,6 +2027,7 @@ htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
>  prefix_SQ = $(subst ','\'',$(prefix))
>  perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
>  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
> +bashcompdir_SQ = $(subst ','\'',$(bashcompdir))
>  
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>  TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
> @@ -3112,6 +3115,13 @@ quick-install-man:
>  quick-install-html:
>  	$(MAKE) -C Documentation quick-install-html
>  
> +install-extra: install-completion
> +
> +install-completion:
> +	$(INSTALL) -D -m 644 extra/completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
> +	$(INSTALL) -D -m 644 extra/completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
> +	$(INSTALL) -D -m 644 extra/completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
> +
These are missing a .PHONY target (like the other install-* targets).

The bash-completion target corresponds to what I've got in Debian's git
package, but not the prompt:
    
    $ dpkg -L git|grep -e completion -e prompt
    /etc/bash_completion.d
    /etc/bash_completion.d/git-prompt
    /usr/lib/git-core/git-sh-prompt
    /usr/share/bash-completion
    /usr/share/bash-completion/completions
    /usr/share/bash-completion/completions/git
    /usr/share/bash-completion/completions/gitk

I've got no idea what we should pick by default though, maybe what you
have is more standard.

Also why /git and /_git for bash and zsh (looks good) but /git-prompt
instead of /git-prompt.sh?

>  
>  ### Maintainer's dist rules
> diff --git a/contrib/completion/git-completion.bash b/extra/completion/git-completion.bash
> similarity index 100%
> rename from contrib/completion/git-completion.bash
> rename to extra/completion/git-completion.bash
> diff --git a/contrib/completion/git-completion.zsh b/extra/completion/git-completion.zsh
> similarity index 100%
> rename from contrib/completion/git-completion.zsh
> rename to extra/completion/git-completion.zsh
> diff --git a/contrib/completion/git-prompt.sh b/extra/completion/git-prompt.sh
> similarity index 100%
> rename from contrib/completion/git-prompt.sh
> rename to extra/completion/git-prompt.sh
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index cb057ef161..32601b755d 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -36,7 +36,7 @@ complete ()
>  GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr rebase ls-files'
>  GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
>  
> -. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> +. "$GIT_BUILD_DIR/extra/completion/git-completion.bash"
>  
>  # We don't need this function to actually join words or do anything special.
>  # Also, it's cleaner to avoid touching bash's internal completion variables.
> @@ -2383,14 +2383,14 @@ test_expect_success 'git clone --config= - value' '
>  test_expect_success 'sourcing the completion script clears cached commands' '
>  	__git_compute_all_commands &&
>  	verbose test -n "$__git_all_commands" &&
> -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
>  	verbose test -z "$__git_all_commands"
>  '
>  
>  test_expect_success 'sourcing the completion script clears cached merge strategies' '
>  	__git_compute_merge_strategies &&
>  	verbose test -n "$__git_merge_strategies" &&
> -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
>  	verbose test -z "$__git_merge_strategies"
>  '
>  
> @@ -2399,7 +2399,7 @@ test_expect_success 'sourcing the completion script clears cached --options' '
>  	verbose test -n "$__gitcomp_builtin_checkout" &&
>  	__gitcomp_builtin notes_edit &&
>  	verbose test -n "$__gitcomp_builtin_notes_edit" &&
> -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
>  	verbose test -z "$__gitcomp_builtin_checkout" &&
>  	verbose test -z "$__gitcomp_builtin_notes_edit"
>  '
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index bbd513bab0..784e523fd4 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./lib-bash.sh
>  
> -. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
> +. "$GIT_BUILD_DIR/extra/completion/git-prompt.sh"
>  
>  actual="$TRASH_DIRECTORY/actual"
>  c_red='\\[\\e[31m\\]'

It's more of a "for bonus points", but a nic way to round-trip this
would be to make this work with GIT_TEST_INSTALLED.

I.e. source these relative to GIT_EXEC_PATH, not $GIT_BUILD_DIR, I think
that just sourcing them as e.g.:

    . git-completion.bash

But the GIT_TEST_INSTALLED case is tricker, maybe we'd need to add a
"git --share-path" :(
