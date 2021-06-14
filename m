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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEFBC48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF6761241
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhFNOSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:18:51 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:43545 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhFNOSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 10:18:44 -0400
Received: by mail-ej1-f47.google.com with SMTP id ci15so16980268ejc.10
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kduK89vgu/NMTWRNCxoF7HynwZTj5jPf+d0yNVbl4HI=;
        b=kW584td+zT0nopoUTPcggkmm9WNCBb/kt5pVn9j8SesybirKwxbp4PZfMQpynyKmrF
         uFSVQWc2hGvQPUeq+Fg2jm1XAo7sdFqIdH8ohV3wXvEm13W2j4AAJjaJ7kMY5wRu9Zj1
         B5pPOvw1vURSbM0ANASIpZc2YnG5iH/IJhyboRD/mjtJM3r2I7oeLXHesoN/6tHtu6sF
         Qxwl4bzvQ0zeEEu9oP3QEw3JWH0WdWFOIgX/uUEG9UqnQAvwkoP+l1pkhfVcZ7Hujjsq
         f3mkDIVVu+/MP24qFwd1hJXw/2oaYY/otCnlSROBdgDVr+MCTf0jwivQfCKYaG7eZ+Ws
         ZfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kduK89vgu/NMTWRNCxoF7HynwZTj5jPf+d0yNVbl4HI=;
        b=E2/rkIsMCEgUJuBYxtLu1ua+9zdUHwQJBOZc0ZRf78FT6Iu0RRQ5ne4EN2ZH1XWnD9
         ijN8R8nWMdcREH9zpYqHIB3RFWPbLWctOxrc/Tdte6XVg/bpAylH0nfL9OPXbDlI5866
         NDx8Rw0kKlYM4ymYt5kC97b2I0TtWwHJl7ybtx8s3YYiktpCt+IrCRsI9q/prCysKJ3P
         Bwv9H3v08jAPYKG01BOsktahqvyQ5rDg46tF/uV4ixWk6+jqhUURaoa+HmmIikGekegu
         yYHCYxbixxWnqQMqqoWaU6HJ7Iw9GpiOgrIRzTV6HSSz4oZLTnbLwAopsP8gTh/+qY9U
         Ek4g==
X-Gm-Message-State: AOAM533nrZhcNk6EuhmP3Pf+543Xfk9aODNmVa9TPMrkwgkDRQ+V5UQA
        ebDVGvlXxqsGPvar1IPLuTw=
X-Google-Smtp-Source: ABdhPJwI8oQdDdU4lmra3y7wgkCP/8yiQyg2FuRRNM19G6fvGpJwKXmltRs6i8h1CgLzxf3QDigZZQ==
X-Received: by 2002:a17:906:b7d7:: with SMTP id fy23mr15906260ejb.49.1623680139414;
        Mon, 14 Jun 2021 07:15:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id kb20sm7488497ejc.58.2021.06.14.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 07:15:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] completion: graduate out of contrib
Date:   Mon, 14 Jun 2021 16:12:53 +0200
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
 <20210614043450.1047571-2-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210614043450.1047571-2-felipe.contreras@gmail.com>
Message-ID: <87wnqwzg51.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 13 2021, Felipe Contreras wrote:

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
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Makefile                                        |  3 +++
>  extra/Makefile                                  | 17 +++++++++++++++++

Please let's not continue following the IMO anti-pattern of having these
sub-Makefiles. Let's just add the target to the top-level Makefile.

See e.g. the recent discussion starting at
https://lore.kernel.org/git/87pmz4ig4o.fsf@evledraar.gmail.com/ I also
have some WIP work to un-split most of this to e.g. make "install"
follow the normal quiet rules, if we're invoking those in a sub-Makefile
that becomes much more difficult....

>  .../completion/git-completion.bash              |  0
>  .../completion/git-completion.zsh               |  0
>  {contrib => extra}/completion/git-prompt.sh     |  0
>  t/t9902-completion.sh                           |  8 ++++----
>  t/t9903-bash-prompt.sh                          |  2 +-
>  7 files changed, 25 insertions(+), 5 deletions(-)
>  create mode 100644 extra/Makefile
>  rename {contrib => extra}/completion/git-completion.bash (100%)
>  rename {contrib => extra}/completion/git-completion.zsh (100%)
>  rename {contrib => extra}/completion/git-prompt.sh (100%)
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..5bb03808b3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3105,6 +3105,9 @@ quick-install-man:
>  quick-install-html:
>  	$(MAKE) -C Documentation quick-install-html
>  
> +install-extra:
> +	$(MAKE) -C extra install
> +
>  
>  
>  ### Maintainer's dist rules
> diff --git a/extra/Makefile b/extra/Makefile
> new file mode 100644
> index 0000000000..26d8be55b0
> --- /dev/null
> +++ b/extra/Makefile
> @@ -0,0 +1,17 @@
> +bashcompdir = $(sharedir)/bash-completion/completions
> +
> +DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
> +sharedir_SQ = $(subst ','\'',$(sharedir))
> +bashcompdir_SQ = $(subst ','\'',$(bashcompdir))
> +gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
> +
> +INSTALL ?= install

...and a large part of the Makefile is just things like this that we'd
mostly/entirely get for free.

> +
> +all:
> +
> +install: install-completion
> +
> +install-completion:
> +	$(INSTALL) -D -m 644 completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
> +	$(INSTALL) -D -m 644 completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
> +	$(INSTALL) -D -m 644 completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
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

