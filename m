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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C49AC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 01:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A8661176
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 01:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbhHFBPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbhHFBPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 21:15:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B830C0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 18:14:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso13974981pjf.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=52Or5noors/qopjsI76HAZYS7LhXKdoSeAIVS5geYRM=;
        b=Akt/shdv9svJlTUYTxkvl8GtEhJlj83DiruG/7mNHhJvtdx0aAqOvuQy7JXmY1T5qi
         9Y9N8h0DN+rRHci/u1mzaWDf3aTgPydaeg4mE5dSuf+Qfi7thJ5vEdYv69JYRYrNXC9w
         Hv2/UGSMSmXfKlwktLTHnArNDbgKgOi8OCBsXgumsF4wZ7ODwNKHNloaSWL0WGhhtVqa
         vblPGjMn685lJUOGHy6jony1aHXmMp6wvLqmZ/tlLQ6zRRVjqmwrMqfIQDCFH8P3eFAR
         kU5R28CIPqPi1TP1sjFf2pMR5HqiAy9ySVipDTgUJOZPtiObnmea6307ywS1MOpAdfLs
         nF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=52Or5noors/qopjsI76HAZYS7LhXKdoSeAIVS5geYRM=;
        b=XJvrIRrJLWdR+tDG22lO6WACaL2X4VcSR/OgWPf7DA5E2wiLPd0gWMUaRQnEnhzP5d
         SHtcyPATys5wxNY7mokzW4yh7h71eP8noVgOz/QgWMvOIsTxdqBqyPNtJ6B+b9+AmImH
         LWdZym3fet8LZ3alVTqrNAkbeSXXVDXqgF8Cyta5RW67J4CVGjsJC1gDn9yiTC80cnDy
         vly51M5dyqVdtqxZaNtv26VUGA8C/M2irZ5i23F69HNOtv0LNsThBDWtLVd4chacE1B0
         MBIEsURbz8qGzEsnU4acuI6p6QhZRTK5spXdeKqKtqRkPUfQ52RV4x5Tw9nzYA07tISb
         eseg==
X-Gm-Message-State: AOAM533v53hMwvAR6UGdrooQLfalzeBCUKi1SqQWXMIe7cg9XUUoY6Fm
        ri3bpfiy1up1W4xv+rFrKJk=
X-Google-Smtp-Source: ABdhPJzKQv3TUse0qTRzqZ03cKg7jUS0Jj2AOw3ob5MUrktLuP7Uv+VLbGwKQQ5fZvHXE5YBKkNW6Q==
X-Received: by 2002:a17:90b:344:: with SMTP id fh4mr7327976pjb.29.1628212496464;
        Thu, 05 Aug 2021 18:14:56 -0700 (PDT)
Received: from localhost ([2402:800:63ed:3989:4118:d609:c805:f509])
        by smtp.gmail.com with ESMTPSA id a11sm9825747pgj.75.2021.08.05.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 18:14:55 -0700 (PDT)
Date:   Fri, 6 Aug 2021 08:14:54 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v2 6/9] submodule--helper: convert the bulk of
 cmd_add() to C
Message-ID: <YQyNDv3bzVZwpAVl@danh.dev>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210805074054.29916-7-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210805074054.29916-7-raykar.ath@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-05 13:10:51+0530, Atharva Raykar <raykar.ath@gmail.com> wrote:
> Introduce the 'add' subcommand to `submodule--helper.c` that does all
> the work 'submodule add' past the parsing of flags.
> 
> As with the previous conversions, this is meant to be a faithful
> conversion with no modification to the behaviour of `submodule add`.
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 160 ++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  96 +---------------------
>  2 files changed, 162 insertions(+), 94 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 99aabf1078..05ae9ebe50 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3046,6 +3046,165 @@ static int add_config(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static void die_on_index_match(const char *path, int force)
> +{
> +	struct pathspec ps;
> +	const char *args[] = { path, NULL };
> +	parse_pathspec(&ps, 0, PATHSPEC_PREFER_CWD, NULL, args);
> +
> +	if (read_cache_preload(NULL) < 0)
> +		die(_("index file corrupt"));
> +
> +	if (ps.nr) {
> +		int i;
> +		char *ps_matched = xcalloc(ps.nr, 1);
> +
> +		/* TODO: audit for interaction with sparse-index. */
> +		ensure_full_index(&the_index);
> +
> +		/*
> +		 * Since there is only one pathspec, we just need
> +		 * need to check ps_matched[0] to know if a cache
> +		 * entry matched.
> +		 */
> +		for (i = 0; i < active_nr; i++) {
> +			ce_path_match(&the_index, active_cache[i], &ps,
> +				      ps_matched);
> +
> +			if (ps_matched[0]) {
> +				if (!force)
> +					die(_("'%s' already exists in the index"),
> +					    path);
> +				if (!S_ISGITLINK(active_cache[i]->ce_mode))
> +					die(_("'%s' already exists in the index "
> +					      "and is not a submodule"), path);
> +				break;
> +			}
> +		}
> +		free(ps_matched);
> +	}
> +}
> +
> +static void die_on_repo_without_commits(const char *path)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_addstr(&sb, path);
> +	if (is_nonbare_repository_dir(&sb)) {
> +		struct object_id oid;
> +		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
> +			die(_("'%s' does not have a commit checked out"), path);
> +	}
> +}
> +
> +static int module_add(int argc, const char **argv, const char *prefix)
> +{
> +	int force = 0, quiet = 0, progress = 0, dissociate = 0;
> +	struct add_data add_data = ADD_DATA_INIT;
> +
> +	struct option options[] = {
> +		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
> +			   N_("branch of repository to add as submodule")),
> +		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
> +			   PARSE_OPT_NOCOMPLETE),
> +		OPT__QUIET(&quiet, N_("print only error messages")),
> +		OPT_BOOL(0, "progress", &progress, N_("force cloning progress")),
> +		OPT_STRING(0, "reference", &add_data.reference_path, N_("repository"),
> +			   N_("reference repository")),
> +		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
> +		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
> +			   N_("sets the submodule’s name to the given string "
> +			      "instead of defaulting to its path")),
> +		OPT_INTEGER(0, "depth", &add_data.depth, N_("depth for shallow clones")),
> +		OPT_END()
> +	};
> +
> +	const char *const usage[] = {
> +		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if (!is_writing_gitmodules_ok())
> +		die(_("please make sure that the .gitmodules file is in the working tree"));
> +
> +	if (prefix && *prefix &&
> +	    add_data.reference_path && !is_absolute_path(add_data.reference_path))
> +		add_data.reference_path = xstrfmt("%s%s", prefix, add_data.reference_path);
> +
> +	if (argc == 0 || argc > 2)
> +		usage_with_options(usage, options);
> +
> +	add_data.repo = argv[0];
> +	if (argc == 1)
> +		add_data.sm_path = guess_dir_name_from_git_url(add_data.repo, 0, 0);
> +	else
> +		add_data.sm_path = xstrdup(argv[1]);

add_data.sm_path is allocated in this block (regardless of legs).

> +	if (prefix && *prefix && !is_absolute_path(add_data.sm_path))
> +		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
> +
> +	if (starts_with_dot_dot_slash(add_data.repo) ||
> +	    starts_with_dot_slash(add_data.repo)) {
> +		if (prefix)
> +			die(_("Relative path can only be used from the toplevel "
> +			      "of the working tree"));
> +
> +		/* dereference source url relative to parent's url */
> +		add_data.realrepo = compute_submodule_clone_url(add_data.repo, NULL, 1);
> +	} else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, ':')) {
> +		add_data.realrepo = add_data.repo;
> +	} else {
> +		die(_("repo URL: '%s' must be absolute or begin with ./|../"),
> +		    add_data.repo);
> +	}
> +
> +	/*
> +	 * normalize path:
> +	 * multiple //; leading ./; /./; /../;
> +	 */
> +	normalize_path_copy(add_data.sm_path, add_data.sm_path);
> +	strip_dir_trailing_slashes(add_data.sm_path);
> +
> +	die_on_index_match(add_data.sm_path, force);
> +	die_on_repo_without_commits(add_data.sm_path);
> +
> +	if (!force) {
> +		int exit_code = -1;
> +		struct strbuf sb = STRBUF_INIT;
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		cp.git_cmd = 1;
> +		cp.no_stdout = 1;
> +		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
> +			     "--no-warn-embedded-repo", add_data.sm_path, NULL);
> +		if ((exit_code = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
> +			strbuf_complete_line(&sb);
> +			fputs(sb.buf, stderr);
> +			return exit_code;

But, we don't free it when return from here.

> +		}
> +		strbuf_release(&sb);
> +	}
> +
> +	if(!add_data.sm_name)
> +		add_data.sm_name = add_data.sm_path;
> +
> +	if (check_submodule_name(add_data.sm_name))
> +		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
> +
> +	add_data.prefix = prefix;
> +	add_data.force = !!force;
> +	add_data.quiet = !!quiet;
> +	add_data.progress = !!progress;
> +	add_data.dissociate = !!dissociate;
> +
> +	if (add_submodule(&add_data))
> +		return 1;

And here.

> +	configure_added_submodule(&add_data);
> +	free(add_data.sm_path);

However, it will be free()-d here, is it intended?

I think we may use UNLEAK above (for now) because we will exit process
after this function.

However, I anticipated we may need to do more stuffs after this
function in the future.

> +
> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -3060,6 +3219,7 @@ static struct cmd_struct commands[] = {
>  	{"clone", module_clone, 0},
>  	{"add-clone", add_clone, 0},
>  	{"add-config", add_config, 0},
> +	{"add", module_add, SUPPORT_SUPER_PREFIX},
>  	{"update-module-mode", module_update_module_mode, 0},
>  	{"update-clone", update_clone, 0},
>  	{"ensure-core-worktree", ensure_core_worktree, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8c219ef382..1070540525 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -145,104 +145,12 @@ cmd_add()
>  		shift
>  	done
>  
> -	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
> +	if test -z "$1"
>  	then
> -		 die "fatal: $(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
> -	fi
> -
> -	if test -n "$reference_path"
> -	then
> -		is_absolute_path "$reference_path" ||
> -		reference_path="$wt_prefix$reference_path"
> -
> -		reference="--reference=$reference_path"
> -	fi
> -
> -	repo=$1
> -	sm_path=$2
> -
> -	if test -z "$sm_path"; then
> -		sm_path=$(printf '%s\n' "$repo" |
> -			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
> -	fi
> -
> -	if test -z "$repo" || test -z "$sm_path"; then
>  		usage
>  	fi
>  
> -	is_absolute_path "$sm_path" || sm_path="$wt_prefix$sm_path"
> -
> -	# assure repo is absolute or relative to parent
> -	case "$repo" in
> -	./*|../*)
> -		test -z "$wt_prefix" ||
> -		die "fatal: $(gettext "Relative path can only be used from the toplevel of the working tree")"
> -
> -		# dereference source url relative to parent's url
> -		realrepo=$(git submodule--helper resolve-relative-url "$repo") || exit
> -		;;
> -	*:*|/*)
> -		# absolute url
> -		realrepo=$repo
> -		;;
> -	*)
> -		die "fatal: $(eval_gettext "repo URL: '\$repo' must be absolute or begin with ./|../")"
> -	;;
> -	esac
> -
> -	# normalize path:
> -	# multiple //; leading ./; /./; /../; trailing /
> -	sm_path=$(printf '%s/\n' "$sm_path" |
> -		sed -e '
> -			s|//*|/|g
> -			s|^\(\./\)*||
> -			s|/\(\./\)*|/|g
> -			:start
> -			s|\([^/]*\)/\.\./||
> -			tstart
> -			s|/*$||
> -		')
> -	if test -z "$force"
> -	then
> -		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
> -		die "fatal: $(eval_gettext "'\$sm_path' already exists in the index")"
> -	else
> -		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
> -		die "fatal: $(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
> -	fi
> -
> -	if test -d "$sm_path" &&
> -		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
> -	then
> -	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
> -	    die "fatal: $(eval_gettext "'\$sm_path' does not have a commit checked out")"
> -	fi
> -
> -	if test -z "$force"
> -	then
> -	    dryerr=$(git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" 2>&1 >/dev/null)
> -	    res=$?
> -	    if test $res -ne 0
> -	    then
> -		 echo >&2 "$dryerr"
> -		 exit $res
> -	    fi
> -	fi
> -
> -	if test -n "$custom_name"
> -	then
> -		sm_name="$custom_name"
> -	else
> -		sm_name="$sm_path"
> -	fi
> -
> -	if ! git submodule--helper check-name "$sm_name"
> -	then
> -		die "fatal: $(eval_gettext "'$sm_name' is not a valid submodule name")"
> -	fi
> -
> -	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
> -	git submodule--helper add-config ${force:+--force} ${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo" --path "$sm_path" --name "$sm_name"
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
>  }
>  
>  #
> -- 
> 2.32.0
> 

-- 
Danh
