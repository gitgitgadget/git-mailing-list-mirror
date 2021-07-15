Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF13C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A097860FF4
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbhGOTLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243608AbhGOTJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 15:09:58 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E794C0613EF
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 11:59:34 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id e203-20020a4a55d40000b029025f4693434bso1790957oob.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xjAaIAgXF+0ODPyX5Wjxz6uThUWYeDSMiFyHtHIYe/M=;
        b=UaxTTZcEBuRpLANzfYnND139PlDoEEJfVXe5NhS7bqzcGyzCUfQ0VtYozjqIRy37EW
         r3OrVYtDeGqQwzsjgDwh31vxyhDZvIH2cY+sR7+nlOF5pK11DYTIAKMwJF1QLq0kNSOK
         sel86J9UVPYj6ODpsk2gsrq1jp6W1k4XXeD/YA3RsTFmdXjrv03F2bx0wwtE9kF9jji8
         y3mzFAZVnMNrywf7+A2bvaycaUhFv8ectx1WOWjt/jax5LYEejcXpaO1hxA3pUrCDqRI
         kCj12DUrJOz9/HVnZhh8bA09zfaFhNarqn92TjkBAtYQWbFQiux5j91bjABfViUxo3vA
         eeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xjAaIAgXF+0ODPyX5Wjxz6uThUWYeDSMiFyHtHIYe/M=;
        b=Yue63zlU4N6M6BD1gp4bOVXorbdkzMXTiIGVZzQX4+MixZQ4Scilnw2AHIPoGAis+P
         EbZleqR4Q8+8LrjFqIp5hht3kXM5MzelzyHV68eGFxVDGxC3AlAAU7cnPax22no77h+y
         5jXHZORUi8LKPY434OL2KUB2RM94CsCoUgj8+LHgCaRyBG8xdiwg5PUi4nGFMAUJQ7/S
         UzehgY1P0oP5L8jjEz3pHeEj/Ly3zYD4SVtW2K80j1VGGwl4rN/foFsUJydZk4RoUeNT
         eH+DYK/fg79h6+ozdVLh9rz2YFTOVg1hOI1nNRm2DWyT1fwiOpLUB4DcBzm9Y2e64n/2
         BQzw==
X-Gm-Message-State: AOAM5331HLrpW2JzBMMSMYEaH/5o9lxnnfb+G0cyBnD17WbMRzaPjizE
        uzRU/Rg7cgscX+URYKEBw7Q=
X-Google-Smtp-Source: ABdhPJwXwkbE91w9tvc/anH9dgwTv0pj5NjmWtCR03WK/TILzRVPAWU8obO70LCSRgCnCkz8Kds7rQ==
X-Received: by 2002:a4a:55cd:: with SMTP id e196mr4575095oob.2.1626375573928;
        Thu, 15 Jul 2021 11:59:33 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 61sm1207303oth.17.2021.07.15.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:59:33 -0700 (PDT)
Date:   Thu, 15 Jul 2021 13:59:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60f0859399369_519c2083c@natae.notmuch>
In-Reply-To: <87bl74zdtb.fsf@evledraar.gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <20210714202344.614468-1-felipe.contreras@gmail.com>
 <20210714202344.614468-2-felipe.contreras@gmail.com>
 <87bl74zdtb.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 1/1] completion: graduate out of contrib
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Jul 14 2021, Felipe Contreras wrote:

> > --- a/Makefile
> > +++ b/Makefile
> > @@ -532,6 +532,7 @@ sharedir =3D $(prefix)/share
> >  gitwebdir =3D $(sharedir)/gitweb
> >  perllibdir =3D $(sharedir)/perl5
> >  localedir =3D $(sharedir)/locale
> > +bashcompdir =3D $(sharedir)/bash-completion/completions
> >  template_dir =3D share/git-core/templates
> >  htmldir =3D $(prefix)/share/doc/git-doc
> >  ETC_GITCONFIG =3D $(sysconfdir)/gitconfig
> > @@ -2015,6 +2016,7 @@ bindir_relative_SQ =3D $(subst ','\'',$(bindir_=
relative))
> >  mandir_SQ =3D $(subst ','\'',$(mandir))
> >  mandir_relative_SQ =3D $(subst ','\'',$(mandir_relative))
> >  infodir_relative_SQ =3D $(subst ','\'',$(infodir_relative))
> > +sharedir_SQ =3D $(subst ','\'',$(sharedir))
> >  perllibdir_SQ =3D $(subst ','\'',$(perllibdir))
> >  localedir_SQ =3D $(subst ','\'',$(localedir))
> >  localedir_relative_SQ =3D $(subst ','\'',$(localedir_relative))
> > @@ -2025,6 +2027,7 @@ htmldir_relative_SQ =3D $(subst ','\'',$(htmldi=
r_relative))
> >  prefix_SQ =3D $(subst ','\'',$(prefix))
> >  perllibdir_relative_SQ =3D $(subst ','\'',$(perllibdir_relative))
> >  gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))
> > +bashcompdir_SQ =3D $(subst ','\'',$(bashcompdir))
> >  =

> >  SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
> >  TEST_SHELL_PATH_SQ =3D $(subst ','\'',$(TEST_SHELL_PATH))
> > @@ -3112,6 +3115,13 @@ quick-install-man:
> >  quick-install-html:
> >  	$(MAKE) -C Documentation quick-install-html
> >  =

> > +install-extra: install-completion
> > +
> > +install-completion:
> > +	$(INSTALL) -D -m 644 extra/completion/git-completion.bash '$(DESTDI=
R_SQ)$(bashcompdir_SQ)'/git
> > +	$(INSTALL) -D -m 644 extra/completion/git-prompt.sh '$(DESTDIR_SQ)$=
(sharedir_SQ)'/git-core/git-prompt.sh
> > +	$(INSTALL) -D -m 644 extra/completion/git-completion.zsh '$(DESTDIR=
_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
> > +
> These are missing a .PHONY target (like the other install-* targets).

All right.

> The bash-completion target corresponds to what I've got in Debian's git=

> package, but not the prompt:
>     =

>     $ dpkg -L git|grep -e completion -e prompt
>     /etc/bash_completion.d
>     /etc/bash_completion.d/git-prompt
>     /usr/lib/git-core/git-sh-prompt
>     /usr/share/bash-completion
>     /usr/share/bash-completion/completions
>     /usr/share/bash-completion/completions/git
>     /usr/share/bash-completion/completions/gitk
> =

> I've got no idea what we should pick by default though, maybe what you
> have is more standard.

git-prompt.sh is not really part of the completion stuff, so I don't
think the location Debian chose is correct. At some point in time they
were together, so perhaps that why they chose the same location.

Generally scripts and other shared data belongs in /usr/share.

> Also why /git and /_git for bash and zsh (looks good) but /git-prompt
> instead of /git-prompt.sh?

Probably because it was split from 'git'.

> >  ### Maintainer's dist rules
> > diff --git a/contrib/completion/git-completion.bash b/extra/completio=
n/git-completion.bash
> > similarity index 100%
> > rename from contrib/completion/git-completion.bash
> > rename to extra/completion/git-completion.bash
> > diff --git a/contrib/completion/git-completion.zsh b/extra/completion=
/git-completion.zsh
> > similarity index 100%
> > rename from contrib/completion/git-completion.zsh
> > rename to extra/completion/git-completion.zsh
> > diff --git a/contrib/completion/git-prompt.sh b/extra/completion/git-=
prompt.sh
> > similarity index 100%
> > rename from contrib/completion/git-prompt.sh
> > rename to extra/completion/git-prompt.sh
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index cb057ef161..32601b755d 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -36,7 +36,7 @@ complete ()
> >  GIT_TESTING_ALL_COMMAND_LIST=3D'add checkout check-attr rebase ls-fi=
les'
> >  GIT_TESTING_PORCELAIN_COMMAND_LIST=3D'add checkout rebase'
> >  =

> > -. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> > +. "$GIT_BUILD_DIR/extra/completion/git-completion.bash"
> >  =

> >  # We don't need this function to actually join words or do anything =
special.
> >  # Also, it's cleaner to avoid touching bash's internal completion va=
riables.
> > @@ -2383,14 +2383,14 @@ test_expect_success 'git clone --config=3D - =
value' '
> >  test_expect_success 'sourcing the completion script clears cached co=
mmands' '
> >  	__git_compute_all_commands &&
> >  	verbose test -n "$__git_all_commands" &&
> > -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> > +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
> >  	verbose test -z "$__git_all_commands"
> >  '
> >  =

> >  test_expect_success 'sourcing the completion script clears cached me=
rge strategies' '
> >  	__git_compute_merge_strategies &&
> >  	verbose test -n "$__git_merge_strategies" &&
> > -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> > +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
> >  	verbose test -z "$__git_merge_strategies"
> >  '
> >  =

> > @@ -2399,7 +2399,7 @@ test_expect_success 'sourcing the completion sc=
ript clears cached --options' '
> >  	verbose test -n "$__gitcomp_builtin_checkout" &&
> >  	__gitcomp_builtin notes_edit &&
> >  	verbose test -n "$__gitcomp_builtin_notes_edit" &&
> > -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> > +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
> >  	verbose test -z "$__gitcomp_builtin_checkout" &&
> >  	verbose test -z "$__gitcomp_builtin_notes_edit"
> >  '
> >
> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> > index bbd513bab0..784e523fd4 100755
> > --- a/t/t9903-bash-prompt.sh
> > +++ b/t/t9903-bash-prompt.sh
> > @@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >  =

> >  . ./lib-bash.sh
> >  =

> > -. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
> > +. "$GIT_BUILD_DIR/extra/completion/git-prompt.sh"
> >  =

> >  actual=3D"$TRASH_DIRECTORY/actual"
> >  c_red=3D'\\[\\e[31m\\]'
> =

> It's more of a "for bonus points", but a nic way to round-trip this
> would be to make this work with GIT_TEST_INSTALLED.
> =

> I.e. source these relative to GIT_EXEC_PATH, not $GIT_BUILD_DIR, I thin=
k
> that just sourcing them as e.g.:
> =

>     . git-completion.bash
> =

> But the GIT_TEST_INSTALLED case is tricker, maybe we'd need to add a
> "git --share-path" :(

Yes, we would need --share-path, and perhaps GIT_SHARE_PATH, and so on.

Might make sense for a future patch.

-- =

Felipe Contreras=
