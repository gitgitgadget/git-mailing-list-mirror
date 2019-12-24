Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F3C2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 09:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F68C206B7
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 09:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/PZQj7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfLXJ6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:58:36 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44726 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLXJ6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 04:58:36 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so7287889qvg.11
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IaG6c5Qbq21fm84/OjnbpOUnPUb5ax5gspAczOEk4vU=;
        b=c/PZQj7HzUnAyorRBuvc2hOAj846aB9cLqBeY5Gwpf4Go9kslYHEFfWYFBvpbEPLmI
         1UmSrcxUuAoTv0bax+pWHx7RKS7y2jqGA6rHUkaxnL7ObLuUwjaYoF3i8c+2+ruCqqYs
         uZCqih7P4MWsMExRKTtw2YuOdvjQKfLbIpIdmiJZpEEi1ZWIzxWiBFuR+K1eovOaX0sB
         vulvXBzVMvE0z7ON0hx8zfzHBJaDQdi9RUAZGK/BHKtLodMdmjlk8sY8PddAoy5HlIna
         1q1WCl0YCAMpQp0ZLVHEUFi/8Gpas5FenpVnQbeNOzrXGZLw1WUqcVCgcDhP6nkCmWDS
         e1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaG6c5Qbq21fm84/OjnbpOUnPUb5ax5gspAczOEk4vU=;
        b=hPEzqSIMWR1QDw95j4fxGqyoavIecmq4OiIXHhWMg6pHo4H68T72ioZqAdyjeTr/oC
         0IyxrezDf63wqi0zFv4hSnn+FnpZrv8qzBDs/hkO/z7Hu9F2eevXsOO+MbdvwNydCGNX
         J5teQHvhWZs2knOAsvggx9oJz6Lv0C79rRMRwKUy1U+S85d2+Q5/sWoaYw9ya0uhsOUh
         7ewobf3dV8IJ3mRxh3/mMS6U4ftJI/UuaWgYiwcrldGVd7rT09cN9zQJ9aR4mU5AGzh+
         zn55LLo5iEF4KE1ZlXnyq6fSRsg7FHqGYpsWe8vTX+dlvFqUm2e8VZ0iRWUTFldiAuTy
         Psow==
X-Gm-Message-State: APjAAAUil9Et0PrqyVeOAZU0r5nILn+H8/SPufSfCGRt8hXIqDe0YK4L
        PUGELReeFUEns05oy4xt0iw=
X-Google-Smtp-Source: APXvYqx6gKZgvcMJNoHaCdFxUYPE1Zm1On6ZUp2crWqhPekFS0tQx9S/KDDQB8E7Y2gtiA2BEsIDTg==
X-Received: by 2002:a0c:b034:: with SMTP id k49mr28718927qvc.144.1577181514774;
        Tue, 24 Dec 2019 01:58:34 -0800 (PST)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id y26sm7378339qtc.94.2019.12.24.01.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 01:58:34 -0800 (PST)
Date:   Tue, 24 Dec 2019 04:58:31 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 7/7] merge: teach --autostash option
Message-ID: <20191224095831.GA2743221@generichostname>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
 <4a47c27f-2c6a-0bd6-eac8-533700087af9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a47c27f-2c6a-0bd6-eac8-533700087af9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, Oct 18, 2019 at 10:46:37AM +0100, Phillip Wood wrote:
> Hi Denton
> 
> On 16/10/2019 18:26, Denton Liu wrote:
> > In rebase, one can pass the `--autostash` option to cause the worktree
> > to be automatically stashed before continuing with the rebase. This
> > option is missing in merge, however.
> 
> It might be helpful to say why this option is useful. I can see one might
> want to stash before doing `git pull` in the same way as one might before a
> rebase but what's the motivation for doing it before a normal merge?

Will do.

> 
> > 
> > Implement the `--autostash` option and corresponding `merge.autoStash`
> > option in merge which stashes before merging and then pops after.
> > 
> > Reported-by: Alban Gruin <alban.gruin@gmail.com>
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >   builtin/merge.c | 13 +++++++++++++
> >   builtin/pull.c  |  9 +++++----
> >   t/t5520-pull.sh |  8 --------
> >   3 files changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 062e911441..d1a5eaad0d 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -40,6 +40,7 @@
> >   #include "branch.h"
> >   #include "commit-reach.h"
> >   #include "wt-status.h"
> > +#include "autostash.h"
> >   #define DEFAULT_TWOHEAD (1<<0)
> >   #define DEFAULT_OCTOPUS (1<<1)
> > @@ -58,6 +59,8 @@ static const char * const builtin_merge_usage[] = {
> >   	NULL
> >   };
> > +static GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
> > +
> >   static int show_diffstat = 1, shortlog_len = -1, squash;
> >   static int option_commit = -1;
> >   static int option_edit = -1;
> > @@ -81,6 +84,7 @@ static int show_progress = -1;
> >   static int default_to_upstream = 1;
> >   static int signoff;
> >   static const char *sign_commit;
> > +static int autostash;
> >   static int no_verify;
> >   static struct strategy all_strategy[] = {
> > @@ -285,6 +289,8 @@ static struct option builtin_merge_options[] = {
> >   	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
> >   	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
> >   	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> > +	OPT_BOOL(0, "autostash", &autostash,
> > +	      N_("automatically stash/stash pop before and after")),
> >   	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
> >   	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
> >   	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
> > @@ -440,6 +446,7 @@ static void finish(struct commit *head_commit,
> >   		strbuf_addf(&reflog_message, "%s: %s",
> >   			getenv("GIT_REFLOG_ACTION"), msg);
> >   	}
> > +	apply_autostash(merge_autostash());
> >   	if (squash) {
> >   		squash_message(head_commit, remoteheads);
> >   	} else {
> > @@ -631,6 +638,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
> >   	} else if (!strcmp(k, "commit.gpgsign")) {
> >   		sign_commit = git_config_bool(k, v) ? "" : NULL;
> >   		return 0;
> > +	} else if (!strcmp(k, "merge.autostash")) {
> > +		autostash = git_config_bool(k, v);
> > +		return 0;
> >   	}
> >   	status = fmt_merge_msg_config(k, v, cb);
> > @@ -724,6 +734,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
> >   		for (j = common; j; j = j->next)
> >   			commit_list_insert(j->item, &reversed);
> > +		if (autostash)
> > +			perform_autostash(merge_autostash());
> >   		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> >   		clean = merge_recursive(&o, head,
> >   				remoteheads->item, reversed, &result);
> > @@ -1288,6 +1300,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> >   		/* Invoke 'git reset --merge' */
> >   		ret = cmd_reset(nargc, nargv, prefix);
> > +		apply_autostash(merge_autostash());
> >   		goto done;
> >   	}
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index d25ff13a60..ee186781ae 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -183,7 +183,7 @@ static struct option pull_options[] = {
> >   		N_("verify that the named commit has a valid GPG signature"),
> >   		PARSE_OPT_NOARG),
> >   	OPT_BOOL(0, "autostash", &opt_autostash,
> > -		N_("automatically stash/stash pop before and after rebase")),
> > +		N_("automatically stash/stash pop before and after")),
> 
> I've not looked closely at the code in this patch but noticed this. I think
> it would read better if it said
> 
>     automatically stash/stash pop before and after pulling

Since this is an `argh` argument, it says that we should "keep it
homogenous across the repository". Since rebase (which I copied it
from), merge and pull will be sharing the same argh string, I think that
we should leave it as is.

Thanks,

Denton

> 
> Best Wishes
> 
> Phillip
> 
> >   	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
> >   		N_("merge strategy to use"),
> >   		0),
> > @@ -671,6 +671,10 @@ static int run_merge(void)
> >   	argv_array_pushv(&args, opt_strategy_opts.argv);
> >   	if (opt_gpg_sign)
> >   		argv_array_push(&args, opt_gpg_sign);
> > +	if (opt_autostash == 0)
> > +		argv_array_push(&args, "--no-autostash");
> > +	else if (opt_autostash == 1)
> > +		argv_array_push(&args, "--autostash");
> >   	if (opt_allow_unrelated_histories > 0)
> >   		argv_array_push(&args, "--allow-unrelated-histories");
> > @@ -918,9 +922,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >   	if (get_oid("HEAD", &orig_head))
> >   		oidclr(&orig_head);
> > -	if (!opt_rebase && opt_autostash != -1)
> > -		die(_("--[no-]autostash option is only valid with --rebase."));
> > -
> >   	autostash = config_autostash;
> >   	if (opt_rebase) {
> >   		if (opt_autostash != -1)
> > diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> > index cf4cc32fd0..75f162495a 100755
> > --- a/t/t5520-pull.sh
> > +++ b/t/t5520-pull.sh
> > @@ -365,14 +365,6 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
> >   	test_pull_autostash_fail --rebase --no-autostash
> >   '
> > -for i in --autostash --no-autostash
> > -do
> > -	test_expect_success "pull $i (without --rebase) is illegal" '
> > -		test_must_fail git pull $i . copy 2>err &&
> > -		test_i18ngrep "only valid with --rebase" err
> > -	'
> > -done
> > -
> >   test_expect_success 'pull.rebase' '
> >   	git reset --hard before-rebase &&
> >   	test_config pull.rebase true &&
> > 
