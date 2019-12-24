Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEE8C2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E72071A
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4hPyY0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLXKFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:05:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39368 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLXKFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 05:05:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so15685267qko.6
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wcphV6Uzp/jZFbCObPKJJ3YPzNZ3EjjtX2L0BwsLjE8=;
        b=l4hPyY0vvUrOMZPjO1FPEgsyLlJTul0QoB35nZr/8nexhMKrAnevKu1Bh/7zMpohPu
         wzb3hjCb40gphPqYizmWUbcUcQRU80xQux7z0fyRkvhxT5BvCvB+dwSKJ8HhG4sYan98
         LhVbCsACjwMjLwb5SgKpbeFFRX13saSiEGJWhMfI5/58OEoiM4HRznSO8AwvTXbLV3+q
         HP09PPlmn2jHdheS4vsRHcEUnDObEIQPe9n5AC4PLwa6tS1jvFKNHEaPhFi63DdldGzl
         7kWOMtLVc4tHyoCTWNAm/RoSCIOGPVFfh4JBzeMSbL4ccos13MzM0onezHuMzbrU1MZs
         WvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wcphV6Uzp/jZFbCObPKJJ3YPzNZ3EjjtX2L0BwsLjE8=;
        b=FozdNpRXSI8XgUIDJsYW++xhz/pKWj6BGA7OSYIbXP6PzAb54PaBKm4RzqDHTj22hm
         ikqNIBFs0z+Z0RQ4hT689vXLrVYoKNwSAUZm/xWb7fC3D30Rf+z2395BuSnX1dQKJO2k
         h9tn3Bv85l5IZHfZ9kpXeyHDO0XcHRPjUgqJZyOCIqo9g7XfJCCnVwpe0RyRZ4cnoXUx
         4l9zY8+mqXNKFplydBCe7HAIz2l2ssSnF1BFNXltABXchxnC1+dZUE2oqIStNcjDakhi
         a5OOxEjTP/RTMPI+WdPZGFucou6hizQ/8VUVs0WJ/R9ay/BuQ/9UQKUOY6vrGASRCKTW
         bkGA==
X-Gm-Message-State: APjAAAVHzxG5QqBBMmQAxSaP1FOQvDOVu8CLkCyftwRaVXpwyPrXFXKL
        +4GaKPqC7/GWA4FtgmaNH5k=
X-Google-Smtp-Source: APXvYqw9F0UTfUI+0bSAZsYoPjvbeXWnBfy0H9Uv5OCel8DgBeiem5jKj/V7F3iQwv8JLYDymEvBHA==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr29625699qkk.423.1577181910223;
        Tue, 24 Dec 2019 02:05:10 -0800 (PST)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id q73sm6678720qka.56.2019.12.24.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 02:05:09 -0800 (PST)
Date:   Tue, 24 Dec 2019 05:05:07 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 7/7] merge: teach --autostash option
Message-ID: <20191224100507.GB2743221@generichostname>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1910212103080.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910212103080.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Oct 21, 2019 at 09:10:09PM +0200, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Wed, 16 Oct 2019, Denton Liu wrote:
> 
> > In rebase, one can pass the `--autostash` option to cause the worktree
> > to be automatically stashed before continuing with the rebase. This
> > option is missing in merge, however.
> >
> > Implement the `--autostash` option and corresponding `merge.autoStash`
> > option in merge which stashes before merging and then pops after.
> >
> > Reported-by: Alban Gruin <alban.gruin@gmail.com>
> 
> Maybe "Suggested-by" would be more accurate, it is not like this feature
> request was a bug report...

Makes sense.

> 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  builtin/merge.c | 13 +++++++++++++
> >  builtin/pull.c  |  9 +++++----
> >  t/t5520-pull.sh |  8 --------
> >  3 files changed, 18 insertions(+), 12 deletions(-)
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 062e911441..d1a5eaad0d 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -40,6 +40,7 @@
> >  #include "branch.h"
> >  #include "commit-reach.h"
> >  #include "wt-status.h"
> > +#include "autostash.h"
> >
> >  #define DEFAULT_TWOHEAD (1<<0)
> >  #define DEFAULT_OCTOPUS (1<<1)
> > @@ -58,6 +59,8 @@ static const char * const builtin_merge_usage[] = {
> >  	NULL
> >  };
> >
> > +static GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
> > +
> >  static int show_diffstat = 1, shortlog_len = -1, squash;
> >  static int option_commit = -1;
> >  static int option_edit = -1;
> > @@ -81,6 +84,7 @@ static int show_progress = -1;
> >  static int default_to_upstream = 1;
> >  static int signoff;
> >  static const char *sign_commit;
> > +static int autostash;
> >  static int no_verify;
> >
> >  static struct strategy all_strategy[] = {
> > @@ -285,6 +289,8 @@ static struct option builtin_merge_options[] = {
> >  	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
> >  	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
> >  	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> > +	OPT_BOOL(0, "autostash", &autostash,
> > +	      N_("automatically stash/stash pop before and after")),
> >  	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
> >  	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
> >  	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
> > @@ -440,6 +446,7 @@ static void finish(struct commit *head_commit,
> >  		strbuf_addf(&reflog_message, "%s: %s",
> >  			getenv("GIT_REFLOG_ACTION"), msg);
> >  	}
> > +	apply_autostash(merge_autostash());
> 
> Should this not be guarded by `if (autostash)`?

The apply_autostash() checks if an autostash file exists and then
applies it if it does. As a result, we should be unconditionally calling
apply_autostash().

I guess that an odd edge-case that might come up is that a user may
run into a merge conflict, resolve the conflict, create a
.git/MERGE_AUTOSTASH file and then, after they commit, the autostash
file will be applied. Currently, rebase behaves the same way so I think
it's safe to leave the behaviour as is. I don't think this is a common
use-case that will come up anyway ;)

> 
> >  	if (squash) {
> >  		squash_message(head_commit, remoteheads);
> >  	} else {
> > @@ -631,6 +638,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
> >  	} else if (!strcmp(k, "commit.gpgsign")) {
> >  		sign_commit = git_config_bool(k, v) ? "" : NULL;
> >  		return 0;
> > +	} else if (!strcmp(k, "merge.autostash")) {
> > +		autostash = git_config_bool(k, v);
> > +		return 0;
> >  	}
> >
> >  	status = fmt_merge_msg_config(k, v, cb);
> > @@ -724,6 +734,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
> >  		for (j = common; j; j = j->next)
> >  			commit_list_insert(j->item, &reversed);
> >
> > +		if (autostash)
> > +			perform_autostash(merge_autostash());
> >  		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> >  		clean = merge_recursive(&o, head,
> >  				remoteheads->item, reversed, &result);
> > @@ -1288,6 +1300,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> >
> >  		/* Invoke 'git reset --merge' */
> >  		ret = cmd_reset(nargc, nargv, prefix);
> > +		apply_autostash(merge_autostash());
> 
> Again, this should be guarded by `if (autostash)`, methinks.
> 
> >  		goto done;
> >  	}
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index d25ff13a60..ee186781ae 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -183,7 +183,7 @@ static struct option pull_options[] = {
> >  		N_("verify that the named commit has a valid GPG signature"),
> >  		PARSE_OPT_NOARG),
> >  	OPT_BOOL(0, "autostash", &opt_autostash,
> > -		N_("automatically stash/stash pop before and after rebase")),
> > +		N_("automatically stash/stash pop before and after")),
> 
> Makes sense; this is now shared between the rebase and the merge modes.
> 
> >  	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
> >  		N_("merge strategy to use"),
> >  		0),
> > @@ -671,6 +671,10 @@ static int run_merge(void)
> >  	argv_array_pushv(&args, opt_strategy_opts.argv);
> >  	if (opt_gpg_sign)
> >  		argv_array_push(&args, opt_gpg_sign);
> > +	if (opt_autostash == 0)
> > +		argv_array_push(&args, "--no-autostash");
> > +	else if (opt_autostash == 1)
> > +		argv_array_push(&args, "--autostash");
> 
> Or shorter:
> 
> 	argv_array_pushf(&args, "%s-autostash", opt_autostash ? "-" : "--no");
> 
> Ah, but that would mishandle `-1`. I bet I will be puzzled by this
> again. Maybe it would make sense to mention in a code comment that it
> can be `-1` in which case we leave it to `rebase` to use the config
> settings to determine whether or not to autostash.

I copied this over from the rebase case. I'll add a comment there as
well.

> 
> >  	if (opt_allow_unrelated_histories > 0)
> >  		argv_array_push(&args, "--allow-unrelated-histories");
> >
> > @@ -918,9 +922,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >  	if (get_oid("HEAD", &orig_head))
> >  		oidclr(&orig_head);
> >
> > -	if (!opt_rebase && opt_autostash != -1)
> > -		die(_("--[no-]autostash option is only valid with --rebase."));
> > -
> >  	autostash = config_autostash;
> >  	if (opt_rebase) {
> >  		if (opt_autostash != -1)
> > diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> > index cf4cc32fd0..75f162495a 100755
> > --- a/t/t5520-pull.sh
> > +++ b/t/t5520-pull.sh
> > @@ -365,14 +365,6 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
> >  	test_pull_autostash_fail --rebase --no-autostash
> >  '
> >
> > -for i in --autostash --no-autostash
> > -do
> > -	test_expect_success "pull $i (without --rebase) is illegal" '
> > -		test_must_fail git pull $i . copy 2>err &&
> > -		test_i18ngrep "only valid with --rebase" err
> > -	'
> > -done
> > -
> 
> Nice!
> Dscho

Thanks,

Denton

> 
> >  test_expect_success 'pull.rebase' '
> >  	git reset --hard before-rebase &&
> >  	test_config pull.rebase true &&
> > --
> > 2.23.0.897.g0a19638b1e
> >
> >
