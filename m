Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A0C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3789060F36
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbhG3OII (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbhG3OIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 10:08:06 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F7C0613C1
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 07:08:01 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id db14so5202327qvb.10
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yjDTB0zXVK+NPAet+7ylhhQOATiX/uwa7J+6SeCJyMg=;
        b=DMvRlLcO6WqhPdsGK/MqkRvEn7lU3GhOKYFwYTZzhD4MZpyWIZKTQhBqtbt2KhQtgr
         irjYNdieM2iQyM19EvwrGbpa4qIDHzbo4HwGiUsQDSpT0FjO+UQ8TG3+M3QzubDwryub
         a7PygQiJc0PBE0brifxVh4eyPjoX1smQJIwG0axuqiFGJZG1IjppmHkOjNwnzCxagDLc
         8FRDL41WmGgfm9cna3/jcaD7RpgELXY52KqTTiTHuSnoS+7VWYG8clbtXvN05gXHgbUs
         fSQRGpde49vkFAiBJ6MQy6lL5+TR7laD13P8m613p+GgnUMib2Y2UYCMNHv74ELmh4Bs
         hL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yjDTB0zXVK+NPAet+7ylhhQOATiX/uwa7J+6SeCJyMg=;
        b=DvH73nhPOy2ep2PzrPi7xZzxoHRbdN+8udZlJSVJb6bEnB2JgKDWLsCoR5bXmxTxwy
         FMVU84O0vsQQsrItjv/BS7Qyoyu8ceqCVUxIHvsaVnoOToSGXLNwYY6xHpfYqzH/KHvf
         O9+SVERHiNZjgHz0E1+5Cf6d8A37hWJ8eBhNZ8ISzWwxNBdvC7/W7dQjfDPgAsfYo055
         /s7JXSjSd41cB6S5nEmpdldb7OCS9BUImSQjs6R58sSXv0ZKB3XyLjtZf1+AU651bKgW
         iqfy5Wk5MxmetBvc+XWpfWPTFYErrg20EzBXGKwhAeA6uKN5soh9mEMDKG6VZl4v19s3
         iVxg==
X-Gm-Message-State: AOAM533azX46FQHkyrI8k6PVm2uk8rF3CSmsZfQAN3BnJs0MElOTPX5S
        x/Ctbd9D/nqZZgTPfr5+hTs=
X-Google-Smtp-Source: ABdhPJyBESCwfxFNG96fWnv6ng4xdZ+09O+FGSU2AfSIZqCYQ3+hOXmmsGwI01J5deygSjTsKZAA+Q==
X-Received: by 2002:ad4:4521:: with SMTP id l1mr2951322qvu.29.1627654080331;
        Fri, 30 Jul 2021 07:08:00 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id d129sm932669qkf.136.2021.07.30.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:08:00 -0700 (PDT)
Date:   Fri, 30 Jul 2021 10:07:59 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support a default remote tracking setup upon
 branch creation
Message-ID: <YQQHv/suvHohpFBe@erythro.dev.benboeckel.internal>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <20210729020125.746206-2-mathstuf@gmail.com>
 <bcbe13a8-7f22-7564-77cd-674c7b2acbf6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcbe13a8-7f22-7564-77cd-674c7b2acbf6@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 30, 2021 at 09:35:49 -0400, Philippe Blain wrote:
> Le 2021-07-28 à 22:01, Ben Boeckel a écrit :
> >      $ git config remote.pushDefault myfork    # push to `myfork` by default
> >      $ git config push.default simple          # the default
> >      $ git config branch.autoSetupMerge always # always setup tracking
> 
> OK, so if I understand correctly this exisiting setting has to be changed
> to 'always' for the new settings you are adding to take effect, right ?
> I think this does make sense, reading the description of 'branch.autoSetupMerge',
> but maybe it should be spelled explicitely in the text of the commit message,
> and not just mentioned here in this terminal session excerpt.

Good point. I'll add it.

> >      $ git config branch.defaultRemote origin  # track from `origin`
> >      $ git config branch.defaultMerge main     # track the `main` branch
> 
> Small nit: maybe I would invert these two, so it can read:
> 
>        $ git config branch.defaultMerge main     # track the `main` branch ...
>        $ git config branch.defaultRemote origin  # ... from `origin`

Agreed.

> > Additionally, with the `extensions.worktreeConfig` setting, when a
> > separate work tree which is used for changes against a different branch
> > (e.g., a branch tracking a prior release), the `branch.defaultMerge`
> > setting may be changed independently, e.g., to `maint`.
> 
> This last paragraph is not explicitely needed, as nothing relating to
> 'extensions.worktreeConfig' is changed here right ? It's just the normal
> way that this setting works.

Yes. I'll mention more explicitly that this is the reason for preserving
split settings (rather than a single `branch.defaultTrack = origin/main`
setting that I had thought about until I saw the `--worktree` flag to
`git config` and was intrigued).

> > +branch.defaultRemote::
> > +	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
> > +	so that it will track a branch on the specified remote. This can be
> > +	used, in conjunction with `branch.defaultMerge`, in projects where
> > +	branches tend to target a single branch. This will be used to
> > +	initialize the "branch.<name>.remote" setting.
> > +
> > +branch.defaultMerge::
> > +	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
> > +	so that it will track a branch with this name. This can be used, in
> > +	conjunction with `branch.defaultRemote` in projects where branches tend
> > +	to target a single branch. This will be used to initialize the
> > +	"branch.<name>.merge" setting.
> 
> For the two setting above, if 'branch.autoSetupMerge' must be set to 'always' for
> the settings to work, I think it should be explicitely mentioned.

Will update.

> > diff --git a/environment.c b/environment.c
> > index 2f27008424..d550deabbd 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -60,6 +60,8 @@ int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
> >   char *check_roundtrip_encoding = "SHIFT-JIS";
> >   unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
> >   enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
> > +const char* git_branch_remote = NULL;
> > +const char* git_branch_merge = NULL;
> 
> Can the new settings be implemented without adding more global variables ?
> I think we are trying to move away from these. Apart from that the code
> looks OK to me.

I'm all for that, but didn't see guidance on where such things should be
stored. There's not a "context" object passed around, but I guess
stuffing it into `repository` is fine? This also gives a nice place to
free them rather than just leaking them too.

Alas, after some cursory investigation,
`config.c@@git_default_branch_config` does not have access to "the
repository" and the `cb` in `git_default_config` seems to be ~always be
`NULL`. So maybe that will have to wait for further refactoring of the
configuration tracking logic?

> > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> > index cc4b10236e..82137e8451 100755
> > --- a/t/t3200-branch.sh
> > +++ b/t/t3200-branch.sh
> > @@ -797,6 +797,45 @@ test_expect_success 'test tracking setup via --track but deeper' '
> >   	test "$(git config branch.my7.merge)" = refs/heads/o/o
> >   '
> >   
> > +test_expect_success 'test tracking setup via branch.default* and --track' '
> > +	git config branch.autosetupmerge always &&
> 
> You can use 'test_config branch.autosetupmerge always' so that the
> config is only active for the duration of the 'test_expect_success' block
> (see t/test-lib-functions.sh).

Nifty.

> > +	git config branch.defaultremote local &&
> > +	git config branch.defaultmerge main &&
> > +	git config remote.local.url . &&
> > +	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> > +	(git show-ref -q refs/remotes/local/main || git fetch local) &&
> > +	git branch --track other/foo my2 &&
> > +	git config branch.autosetupmerge false &&
> > +	test "$(git config branch.my2.remote)" = other &&
> 
> Here and for the following line you can use 'test_cmp_config'.
> 
> > +	test "$(git config branch.my2.merge)" = refs/heads/foo
> > +'
> 
> This tests checks that an explicit '--track' argument overrides the new configs.
> I would name it something like "'--track overrides 'branch.default{merge,remote}'"
> or something like this. I would also add another test before this one that just
> checks that the new settings by themselves work as expected;
> i.e. a simple 'git checkout -b' and verifying that the
> tracking info is correctly configured according to 'branch.default{merge,remote}'.
> 
> > +
> > +test_expect_success 'test tracking setup via branch.default* and --no-track' '
> > +	git config branch.autosetupmerge always &&
> > +	git config branch.defaultremote local &&
> > +	git config branch.defaultmerge main &&
> > +	git config remote.local.url . &&
> > +	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> > +	(git show-ref -q refs/remotes/local/main || git fetch local) &&
> > +	git branch --no-track my2 &&
> > +	git config branch.autosetupmerge false &&
> > +	! test "$(git config branch.my2.remote)" = local &&
> > +	! test "$(git config branch.my2.merge)" = refs/heads/main
> 
> Here you expect the configs to be absent, so for more clarity you could
> do
> 
>      git config branch.my2.remote >remote &&
>      test_must_be_empty remote
> 
> and the same for merge.
> 
> > +'
> > +
> > +test_expect_success 'test tracking setup via branch.default*' '
> > +	git config branch.autosetupmerge always &&
> > +	git config branch.defaultremote local &&
> > +	git config branch.defaultmerge main &&
> > +	git config remote.local.url . &&
> > +	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> > +	(git show-ref -q refs/remotes/local/main || git fetch local) &&
> > +	git branch my2 &&
> > +	git config branch.autosetupmerge false &&
> > +	test "$(git config branch.my2.remote)" = local &&
> > +	test "$(git config branch.my2.merge)" = refs/heads/main
> > +'
> > +
> >   test_expect_success 'test deleting branch deletes branch config' '
> >   	git branch -d my7 &&
> >   	test -z "$(git config branch.my7.remote)" &&
> > 
> 
> Oh, so here is the 'just test the new settings' test. Let's move that
> one to be before the two others.
> 
> Another test that could be added is one that does not change
> 'branch.autosetupmerge' but sets the new configs, and checks that the
> tracking info is *not* set.

I'll make the test suite updates as well.

Thanks for the review,

--Ben
