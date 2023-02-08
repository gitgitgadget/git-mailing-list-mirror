Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3777C636CD
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 00:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBHAfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHAfd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 19:35:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7D3B3C8
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 16:35:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so312125wmb.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 16:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLPuOunr0/ldOiwA87kwTcuGbUycMkAfCC6NtkqIHm0=;
        b=AOglo+Ifr89xldJsOsXiM6qvD6FR4NK7BRYOPmwvqZdLxMthFlQuFnxTPKZ2XecCMS
         6DptNGFMas75N7TbdvhsgzwumyWsf1W+EirrzOav62M7UOlTs5bcHzIsTwki3XmQUOoc
         5gUWP04pG2F5Wr9+KihQeLktPiy1ZYP9uUQSYNjbTxNf6WD/C4Wzr4dj6Zs0DVTm2/gB
         ZdyuT2ti3jciba50OdSttl2YW/wMrqzsRDaD46bACtdOXQV13kv2QEKE3LpH0nO/ZHCy
         Luo4o1GPUzsnQ9n0vnufyEaKsPSXFCooY4lM5tVwL6x9tfuvWUQcYS/gHF0SVZ3QiX1G
         DRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLPuOunr0/ldOiwA87kwTcuGbUycMkAfCC6NtkqIHm0=;
        b=a+nNkZSWcabyVywT7pEGjVKUGslHbdjlaVF4BcC6HtiTtw/oWEaXNBgeckUUabyNnm
         0lSxO0cWd+ZRlFpEekTY9PaHJpfj+J+jOtx0JOrhRooElAJ3dTHkh8+LXT6Nnso+hs/7
         fjFAV9RLxpMragcSQqPOELLLy9antjs2t9RsknWLKprVbf26cjEBAzwznO5KoFjSsVfe
         JX7M9F16kHuVKjeo13b8kHsYk+XCfLCgt7D5TmaTKo4DXwRJtGyU9kqpdfgyX5VyEVMy
         qRT7IMkUkJ59z6nL1FgDtfbpvu0EOLdHExCriLCoaHj6SirosyL0GndQRfNTNfWsqMmr
         PY+g==
X-Gm-Message-State: AO0yUKV+J/KHdI7YfOo7VAdAX18fumaMx4MC/sSv65XOAPgFMaUC3+QV
        FRlMWF+XrSFTqQLdLEr7Fn4=
X-Google-Smtp-Source: AK7set81z1+JGPjZRWmf+k43B0nwCmS+q3uT0KZcZUOxFioxjXpwsmTjBN7Dg0W2VqkdOBY9yn4yRw==
X-Received: by 2002:a05:600c:984:b0:3e1:97d:612e with SMTP id w4-20020a05600c098400b003e1097d612emr263930wmp.29.1675816529983;
        Tue, 07 Feb 2023 16:35:29 -0800 (PST)
Received: from [192.168.2.52] (141.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.141])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003dd19baf45asm285537wmo.40.2023.02.07.16.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 16:35:29 -0800 (PST)
Subject: Re: [PATCH v3 0/3] branch: operations on orphan branches
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <230207.86cz6l501v.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <1450c94f-b0e4-a424-edd4-8c88b72febf5@gmail.com>
Date:   Wed, 8 Feb 2023 01:35:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <230207.86cz6l501v.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-feb-2023 09:33:39, Ævar Arnfjörð Bjarmason wrote:

Thank you reviewing this.

> 
> On Tue, Feb 07 2023, Rubén Justo wrote:
> 
> > Avoid some confusing errors operating with orphan branches when
> > working with worktrees.
> >
> > Changes from v2:
> >
> >  - Renamed "ishead_and_reject_rebase_or_bisect_branch()" to
> >    "die_if_branch_is_being_rebased_or_bisected()"
> 
> Looking this over holistically, I think this is a great example of where
> factoring something out into a function is just making readbility
> worse. This function is only used in copy_or_rename_branch(), and the
> overloaded name & semantics are making things quite confusing.
> 
> Whereas if we just start by pulling it into its only caller I think this
> gets much better, at the end of this message is a diff-on-top these
> three patches where I do that (I kept the "target" variable to minimize
> the diff with the move detection, but we probalby want the strbuf
> directly instead).

I'm sorry, but I don't agree.  copy_or_rename_branch() already does some
heterogeneous things.  IMHO, making it also iterate worktrees makes
things worse, in terms of readability.  I could agree with maybe the
function die_if_branch_is_being_rebased_or_bisected() could be part of a
more general use, maybe something in worktree.h.
 
> >    A proposed name "die_if_branch_is_is_use()" has not been used because
> >    it could lead to confusion.  We don't yet support copying or renaming
> >    a branch being rebased or bisected, but we do under other uses.
> 
> Another thing that I think could be improved in this series is if you
> skip the refactoring-while-at-it of changing the existing
> "if/if/die/die" into a "if/die/?:".

I'm sorry, but I don't agree with this reasoning either.  The ternary op
here allows the code to be more clear, IMHO, in the intention: there is
no conditional die() or error(), the conditional is for the message.

> 
> In the below diff I have that proposed change on top, but this snippet
> here shows the diff to "origin/master":
> 	
> 	@@ -806,7 +806,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> 	 
> 	 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
> 	 		if (!ref_exists(branch_ref.buf))
> 	-			error((!argc || !strcmp(head, branch_name))
> 	+			error((!argc || branch_checked_out(branch_ref.buf))
> 	 			      ? _("No commit on branch '%s' yet.")
> 	 			      : _("No branch named '%s'."),
> 	 			      branch_name);
> 	@@ -851,10 +851,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> 	 		}
> 	 
> 	 		if (!ref_exists(branch->refname)) {
> 	-			if (!argc || !strcmp(head, branch->name))
> 	+			if (!argc || branch_checked_out(branch->refname))
> 	 				die(_("No commit on branch '%s' yet."), branch->name);
> 	 			die(_("branch '%s' does not exist"), branch->name);
> 	 		}
> 
> I.e. your refactoring of this in 2/3 turns out to in the end have just
> been inflating the code change, for no functional benefit.
> 
> I wouldn't mind if this were in some pre-cleanup, or if it actually made
> the code easier to read, but IMO this pattern of using a ternary to
> select the format to "error" or "die" makes things worse for
> readability. It's a few bytes less code, but makes things harder to follow overall.
> 
> And even if you disagree with that as far as the end state is concerned,
> I think it's unarguable that it makes the 2/3 harder to follow, since
> it's sticking a refactoring that's not neede dfor the end-goal here into
> an otherwise functional change.
> 
> I'm aware that some of the code in the context uses this pattern, and
> you probably changed the "if" block you modified to be consistent with
> the code above, but I think in this case it's better not to follow the
> existing style (which is used in that function, but is a rare exception
> overall in this codebase).
> 
> The diff-on-top, mentioned above:
> 
> == BEGIN
> 	
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 7efda622241..dc7a3e3dde1 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -486,45 +486,16 @@ static void print_current_branch_name(void)
>  		die(_("HEAD (%s) points outside of refs/heads/"), refname);
>  }
>  
> -/*
> - * Dies if the specified branch is being rebased or bisected.  Otherwise returns
> - * 0 or, if the branch is HEAD in any worktree, returns 1. If the branch is HEAD
> - * and also orphan, returns 2.
> - */
> -static int die_if_branch_is_being_rebased_or_bisected(const char *target)
> -{
> -	struct worktree **worktrees = get_worktrees();
> -	int i, ret = 0;
> -
> -	for (i = 0; worktrees[i]; i++) {
> -		struct worktree *wt = worktrees[i];
> -
> -		if (wt->head_ref && !strcmp(target, wt->head_ref))
> -			ret = is_null_oid(&wt->head_oid) ? 2 : 1;
> -
> -		if (!wt->is_detached)
> -			continue;
> -
> -		if (is_worktree_being_rebased(wt, target))
> -			die(_("Branch %s is being rebased at %s"),
> -			    target, wt->path);
> -
> -		if (is_worktree_being_bisected(wt, target))
> -			die(_("Branch %s is being bisected at %s"),
> -			    target, wt->path);
> -	}
> -
> -	free_worktrees(worktrees);
> -	return ret;
> -}
> -
>  static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
>  {
>  	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
>  	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
>  	const char *interpreted_oldname = NULL;
>  	const char *interpreted_newname = NULL;
> -	int recovery = 0, oldref_is_head, oldref_is_orphan;
> +	int recovery = 0, oldref_is_head = 0, oldref_is_orphan = 0;
> +	struct worktree **worktrees;
> +	int i;
> +	const char *target;
>  
>  	if (strbuf_check_branch_ref(&oldref, oldname)) {
>  		/*
> @@ -537,8 +508,29 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  			die(_("Invalid branch name: '%s'"), oldname);
>  	}
>  
> -	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
> -	oldref_is_orphan = (oldref_is_head > 1);
> +	worktrees = get_worktrees();
> +	target = oldref.buf;
> +	for (i = 0; worktrees[i]; i++) {
> +		struct worktree *wt = worktrees[i];
> +
> +		if (wt->head_ref && !strcmp(target, wt->head_ref)) {
> +			oldref_is_head = 1;
> +			if (is_null_oid(&wt->head_oid))
> +				oldref_is_orphan = 1;
> +		}
> +
> +		if (!wt->is_detached)
> +			continue;
> +
> +		if (is_worktree_being_rebased(wt, target))
> +			die(_("Branch %s is being rebased at %s"),
> +			    target, wt->path);
> +
> +		if (is_worktree_being_bisected(wt, target))
> +			die(_("Branch %s is being bisected at %s"),
> +			    target, wt->path);
> +	}
> +	free_worktrees(worktrees);
>  
>  	if ((copy || !oldref_is_head) &&
>  	    (oldref_is_orphan || !ref_exists(oldref.buf)))
> @@ -858,10 +850,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			die(_("no such branch '%s'"), argv[0]);
>  		}
>  
> -		if (!ref_exists(branch->refname))
> -			die((!argc || branch_checked_out(branch->refname))
> -			    ? _("No commit on branch '%s' yet.")
> -			    : _("branch '%s' does not exist"), branch->name);
> +		if (!ref_exists(branch->refname)) {
> +			if (!argc || branch_checked_out(branch->refname))
> +				die(_("No commit on branch '%s' yet."), branch->name);
> +			die(_("branch '%s' does not exist"), branch->name);
> +		}
> +		
>  
>  		dwim_and_setup_tracking(the_repository, branch->name,
>  					new_upstream, BRANCH_TRACK_OVERRIDE,
> 
> == END
> 
> P.S. if I were refactoring those ?: for style in that function I'd
> probably go for this on-top. The N_() followed by _() pattern is
> probably overdoing it, but included to show that one way out of this
> sort of thing with i18n is that you can pre-mark the string with N_(),
> then use it with _() to emit the message (right now the code uses
> "copy?" over "copy ?" instead to align them):
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index dc7a3e3dde1..e42f9bc4900 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -805,31 +805,35 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		}
>  
>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
> -		if (!ref_exists(branch_ref.buf))
> -			error((!argc || branch_checked_out(branch_ref.buf))
> -			      ? _("No commit on branch '%s' yet.")
> -			      : _("No branch named '%s'."),
> -			      branch_name);
> -		else if (!edit_branch_description(branch_name))
> +		if (!ref_exists(branch_ref.buf)) {
> +			if (!argc || branch_checked_out(branch_ref.buf))
> +				error(_("No commit on branch '%s' yet."),
> +				      branch_name);
> +			else
> +				error(_("No branch named '%s'."), branch_name);
> +		} else if (!edit_branch_description(branch_name)) {
>  			ret = 0; /* happy */
> +		}
>  
>  		strbuf_release(&branch_ref);
>  		strbuf_release(&buf);
>  
>  		return ret;
>  	} else if (copy || rename) {
> +		static const char *cannot_copy = N_("cannot copy the current branch while not on any.");
> +		static const char *cannot_rename = N_("cannot rename the current branch while not on any.");
>  		if (!argc)
>  			die(_("branch name required"));
>  		else if ((argc == 1) && filter.detached)
> -			die(copy? _("cannot copy the current branch while not on any.")
> -				: _("cannot rename the current branch while not on any."));
> +			die("%s", copy ? _(cannot_copy) : _(cannot_rename));
>  		else if (argc == 1)
>  			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
>  		else if (argc == 2)
>  			copy_or_rename_branch(argv[0], argv[1], copy, copy + rename > 1);
> +		else if (copy)
> +			die(_("too many branches for a copy operation"));
>  		else
> -			die(copy? _("too many branches for a copy operation")
> -				: _("too many arguments for a rename operation"));
> +			die(_("too many arguments for a rename operation"));
>  	} else if (new_upstream) {
>  		struct branch *branch;
>  		struct strbuf buf = STRBUF_INIT;
>  
