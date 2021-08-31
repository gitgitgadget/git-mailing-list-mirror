Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B8C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 21:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B809E60FC0
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 21:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbhHaVK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhHaVKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 17:10:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A8C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 14:09:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so3078227pjb.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UOvMf1afMtXV1P0LoQKTHPwaQe/bkExu4OY2rYfjTxY=;
        b=qShIyHFKb942PF0yLMp3wZkrMFONrGZmiRfteXWxYptGS/G/72TZ0QWuOuWs0UDd9q
         bET19O9eYJxMdHUsXm2i/PuTUMc90gtxqHaeHJJYZ00ADBzYGzgHl4DMvI/Bw9tlHQ+F
         2KElSrFmfPR3VqI0Z+pO2htg+XUlybafdc+67GAflHBkCRq1sJbiqL6P7tJs1AyYWpKf
         /Ju5GRVLf8B8RNMAdBWFJaBMakI9LVJN3TK8nRK+6RRhbmKjUdofoYE+odRB8xGYELDl
         aNtHOmiCfotal1KMxA722XGVAvVXLOTtJe/V8NBAjzQvdvgGm2xgfoPO/9dtgsLd71I/
         53xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UOvMf1afMtXV1P0LoQKTHPwaQe/bkExu4OY2rYfjTxY=;
        b=gHb8BVQ+SQ3840WNme7hyRPqYLLzf2tguPiDaqZzuq8s482XVurEsBNXirY+kcsACS
         u0goYUB7WHZn6a8f0+jDgtYbb89ho/dP81Vu2O4EbKH6ucoIGkj6ZgmppkQNl9yMDanL
         N4e5FEGYbi5sPcKHUHpxhaCrOGtnbNAcHWVar0VrDsG1/MwENjymta7+fcC1WfCfmHZS
         AAFwLs+sXrtXez3y+5uZdfrmND+i2hjcFYckV9p+9fXRu65eswkfvZfoT/SLqCp3KyDf
         LI7513eP/hAQ4qnzP6/nG0SJPXYRR7tYTJ8jxeLpPZU1lzCDiDNwl9pVT7GJiuj4BmA/
         HcRA==
X-Gm-Message-State: AOAM530s+UCjDm03ZPZsp4t8Bcd9z2hXmBpg5gWCpL1j7a/LPITvIq2w
        YYILfpaj9U2UrQYevqZkqVWCl7OCCCrqoQ==
X-Google-Smtp-Source: ABdhPJwf6ZSDSo1ruE6l1YamrrCkAv/wjA90oOMb/298b2F72GeGY0wgfdh/Naqr89RX5ZAc961lFA==
X-Received: by 2002:a17:90b:601:: with SMTP id gb1mr2605856pjb.96.1630444169178;
        Tue, 31 Aug 2021 14:09:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:9007:bdba:3f52:14ff])
        by smtp.gmail.com with ESMTPSA id z3sm3656797pjn.43.2021.08.31.14.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:09:28 -0700 (PDT)
Date:   Tue, 31 Aug 2021 14:09:23 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] hook: allow out-of-repo 'git hook' invocations
Message-ID: <YS6ag97rjkPwJUkS@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-7-emilyshaffer@google.com>
 <87ilzueh1g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilzueh1g.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 10:12:04PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 
> > Since hooks can now be supplied via the config, and a config can be
> > present without a gitdir via the global and system configs, we can start
> > to allow 'git hook run' to occur without a gitdir. This enables us to do
> > things like run sendemail-validate hooks when running 'git send-email'
> > from a nongit directory.
> 
> Sensible goal. Perhaps we should note in an earlier commit when
> config-based hooks are introduced something like:
> 
>     Even though we've added config-based hooks, they currently only work
>     if we can find a .git directory, even though certain commands such
>     as "git send-email" (or only that command?) can be run outside of a
>     git directory. A subsequent commit will address that edge-case.

Hmmm. I personally do not like "a subsequent commit adds this" in commit
messages. But I'm having trouble expressing why :) To me, "I know about
me and everything that came before me" is fine and "I wish in the future
x would happen" is fine, for commit messages, but "x will happen in the
future" feels a little wrong.

Anyway, I think it is a little distracting to include that message in
the earlier commit, since the "doesn't work outside of a repo" aspect of
hooks is not changing at all.

> 
> > [...]
> > Notes:
> >     For hookdir hooks, do we want to run them in nongit dir when core.hooksPath
> >     is set? For example, if someone set core.hooksPath in their global config and
> >     then ran 'git hook run sendemail-validate' in a nongit dir?
> > [...]
> >  git.c           |  2 +-
> >  hook.c          |  2 +-
> >  t/t1800-hook.sh | 20 +++++++++++++++-----
> >  3 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/git.c b/git.c
> > index 540909c391..39988ee3b0 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -538,7 +538,7 @@ static struct cmd_struct commands[] = {
> >  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
> >  	{ "hash-object", cmd_hash_object },
> >  	{ "help", cmd_help },
> > -	{ "hook", cmd_hook, RUN_SETUP },
> > +	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
> >  	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
> >  	{ "init", cmd_init_db },
> >  	{ "init-db", cmd_init_db },
> > diff --git a/hook.c b/hook.c
> > index 581d87cbbd..2e08156546 100644
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -218,7 +218,7 @@ struct list_head *list_hooks_gently(const char *hookname)
> >  
> >  	/* Add the hook from the hookdir. The placeholder makes it easier to
> >  	 * allocate work in pick_next_hook. */
> > -	if (find_hook_gently(hookname))
> > +	if (have_git_dir() && find_hook_gently(hookname))
> >  		append_or_move_hook(hook_head, NULL);
> >  
> >  	return hook_head;
> > diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> > index ef2432f53a..a7e45c0d16 100755
> > --- a/t/t1800-hook.sh
> > +++ b/t/t1800-hook.sh
> > @@ -118,15 +118,25 @@ test_expect_success 'git hook run -- pass arguments' '
> >  	test_cmp expect actual
> >  '
> >  
> > -test_expect_success 'git hook run -- out-of-repo runs excluded' '
> > -	write_script .git/hooks/test-hook <<-EOF &&
> > -	echo Test hook
> > -	EOF
> > +test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
> > +	test_config_global hook.global-hook.event test-hook --add &&
> > +	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
> > +
> > +	echo "global-hook" >expect &&
> > +	nongit git hook list test-hook >actual &&
> > +	test_cmp expect actual &&
> > +
> > +	echo "no repo no problems" >expect &&
> >  
> > -	nongit test_must_fail git hook run test-hook
> > +	nongit git hook run test-hook 2>actual &&
> > +	test_cmp expect actual
> >  '
> >  
> >  test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
> > +	write_script .git/hooks/test-hook <<-EOF &&
> > +	echo Test hook
> > +	EOF
> > +
> >  	mkdir my-hooks &&
> >  	write_script my-hooks/test-hook <<-\EOF &&
> >  	echo Hook ran $1 >>actual
> 
> If the only user of this is git-send-email, let's have tests for this in
> t/t9001-send-email.sh. That should also address your "Notes" above,
> i.e. let's just test it with core.hooksPath and see what the interaction
> looks like.

Yeah, I think it is probably fine to do allllll the git-send-email
fixups in this one commit, actually. I think your point is correct that
right now the only command which can benefit is git-send-email. It might
also be reasonable to drop this change from this series, but I won't
bother doing so unless it looks like this one commit is holding up the
rest of the series.

I could see, though, a later world where we might want something like a
"pre-clone" or "post-clone"(-pre-checkout) hook, now that we don't need
to have a .gitdir in order to run any hooks. Will make a very brief
"later it might be nice if..." addition to the commit message.

 - Emily
