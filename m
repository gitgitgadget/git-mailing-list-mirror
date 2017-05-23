Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1F020281
	for <e@80x24.org>; Tue, 23 May 2017 19:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935008AbdEWTgc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:36:32 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35920 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbdEWTgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:36:31 -0400
Received: by mail-pf0-f178.google.com with SMTP id m17so123913126pfg.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LnHlt7GvF2GmTA9fITKyeRNu7fxK/ZsmkDkj1iv8u9s=;
        b=QNmmqXNFW5nmAs1yPUSQhL/0TfJGmleSUUDYDUNzm5uD20RHpZy7hzE4e3nq0/1lfv
         zQqKmsD/3tsnznCpfiBrNe88y+DQzZqEVQkGU+GqQdPS7V0Lmy6dQUGBMC8eDQxw0jAX
         oZ9bmJm039s4IaqMP45bcaoS21gAv8kuCLhc45JyGjnR9QFcU8we/psxYhXWqpQKbXQ2
         ySHEsWp21Icrj2iK8FbmWolHduFlSKw+N6rtxZkaSDsNDiCmFbsxmKSt1jeMDvMw/dEN
         kYb5lfHWSCOMtaKRsEkIr6BmizgFjuGY8xz5cwgJPVGjCuADFfRB6BAD7mORMxGpv0z2
         ljFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LnHlt7GvF2GmTA9fITKyeRNu7fxK/ZsmkDkj1iv8u9s=;
        b=AtqO5hX3arnmas+cpHgu+Wj7psNMtttOjHbBtKcYZk9yD4VCWIaxZ6GEwB3ArHlDep
         EHi46BG4xhlp3zrEd9hgb2bC8mV1/Sk7gy6FTurBruOxSHCOKpoT70y14f8I4Qxokb15
         LUTogCJecggv46xQkwUZ7FAxWWUTkd/E4YkErfpt4cGE801ya0E0ani815qJzGJwlb5I
         CvZF+wl/rbo5YLZHH4BHQtC/g4XcJFPGDCPEqN0bG4vo6FB8qaUK/XfSmoNSfFlWWdIs
         4ptNWt4CvQ9G0ZGhhn3pYFQyMMv32jWGpKB833+WaFIZhP0RmSGx3N4n8aTu5quv4Nj0
         DrjQ==
X-Gm-Message-State: AODbwcBMvE71S4OcYoC/bm8uAD1zqS+lZrpY3Oc8sWB82SwZzYkkkwyE
        J8pqxRTfhS6N2p4r
X-Received: by 10.84.191.228 with SMTP id a91mr38471301pld.62.1495568189961;
        Tue, 23 May 2017 12:36:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id n87sm2937166pfi.124.2017.05.23.12.36.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 12:36:29 -0700 (PDT)
Date:   Tue, 23 May 2017 12:36:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        christian.couder@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [GSoC][PATCH v4 2/2] submodule: port subcommand foreach from
 shell to C
Message-ID: <20170523193627.GG115919@google.com>
References: <20170515183405.GA79147@google.com>
 <20170521125814.26255-1-pc44800@gmail.com>
 <20170521125814.26255-2-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170521125814.26255-2-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/21, Prathamesh Chavan wrote:
> This aims to make git-submodule foreach a builtin. This is the very
> first step taken in this direction. Hence, 'foreach' is ported to
> submodule--helper, and submodule--helper is called from git-submodule.sh.
> The code is split up to have one function to obtain all the list of
> submodules. This function acts as the front-end of git-submodule foreach
> subcommand. It calls the function for_each_submodule_list, which basically
> loops through the list and calls function fn, which in this case is
> runcommand_in_submodule. This third function is a calling function that
> takes care of running the command in that submodule, and recursively
> perform the same when --recursive is flagged.
> 
> The first function module_foreach first parses the options present in
> argv, and then with the help of module_list_compute, generates the list of
> submodules present in the current working tree.
> 
> The second function for_each_submodule_list traverses through the
> list, and calls function fn (which in case of submodule subcommand
> foreach is runcommand_in_submodule) is called for each entry.
> 
> The third function runcommand_in_submodule, generates a submodule struct sub
> for $name, value and then later prepends name=sub->name; and other
> value assignment to the env argv_array structure of a child_process.
> Also the <command> of submodule-foreach is push to args argv_array
> structure and finally, using run_command the commands are executed
> using a shell.
> 
> The third function also takes care of the recursive flag, by creating
> a separate child_process structure and prepending "--super-prefix displaypath",
> to the args argv_array structure. Other required arguments and the
> input <command> of submodule-foreach is also appended to this argv_array.
> 
> The commit 1c4fb136db (submodule foreach: skip eval for more than one
> argument, 2013-09-27), which explains that why for the case when argc>1,
> we do not use eval. But since in this patch, we are calling the
> command in a separate shell itself for all values of argc, this case
> is not considered separately.
> 
> Both env variable $path and $sm_path were added since both are used in
> tests in t7407.
> 
> Helped-by: Brandon Williams <bmwill@google.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> This series of patch is based on gitster/jk/bug-to-abort for untilizing its
> BUG() macro.
> 
> In this new version of patch, a new function
> get_submodule_displaypath is introduced, which is the same one
> as that in the patch series for porting of submodule subcommand
> status. I had to again introduce this in this patch as well as
> I am working on two separate branches for parting of each function.
> Also, the function for_each_submodule_list repeats for the same
> reason.
> 
> I have pushed this work on Github at:
> https://github.com/pratham-pc/git/commits/foreach
> 
> Its build report is available at:
> https://travis-ci.org/pratham-pc/git/builds/
> Branch: foreach
> Build #67
> 
> I have also made some changes in git-submodule.sh for correcting
> the $path variable. And hence made the corresponding changes in
> the new test introduced in t7407-submodule-foreach as well.
> I have push this work at:
> https://github.com/pratham-pc/git/commits/foreach-bug-fixed
> 
> Its build report is available at:
> https://travis-ci.org/pratham-pc/git/builds/
> Branch: foreach-bug-fixed
> Build #66
> 
>  builtin/submodule--helper.c | 142 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  39 +-----------
>  2 files changed, 143 insertions(+), 38 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 566a5b6a6..4e19beaff 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -13,6 +13,8 @@
>  #include "refs.h"
>  #include "connect.h"
>  
> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item, void *cb_data);
> +
>  static char *get_default_remote(void)
>  {
>  	char *dest = NULL, *ret;
> @@ -219,6 +221,23 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
>  	return 0;
>  }
>  
> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +	const char *super_prefix = get_super_prefix();
> +
> +	if (prefix && super_prefix) {
> +		BUG("cannot have prefix '%s' and superprefix '%s'",
> +		    prefix, super_prefix);
> +	} else if (prefix) {
> +		struct strbuf sb = STRBUF_INIT;
> +		return xstrdup(relative_path(path, prefix, &sb));

You have a potential memory leak here, you need to release the strbuf
before returning.

> +	} else if (super_prefix) {
> +		return xstrfmt("%s/%s", super_prefix, path);
> +	} else {
> +		return xstrdup(path);
> +	}
> +}
> +
>  struct module_list {
>  	const struct cache_entry **entries;
>  	int alloc, nr;
> @@ -331,6 +350,15 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static void for_each_submodule_list(const struct module_list list, submodule_list_func_t fn, void *cb_data)

nit: You could probably break this line so its not longer than 80 chars.

> +{
> +	int i;
> +	for (i = 0; i < list.nr; i++)
> +		fn(list.entries[i], cb_data);
> +
> +	return;

No return needed.

> +}

small nit, and not that important, but could this function potentially
be moved closer to where it is used? What as the rational for placing it
here?

> +
>  static void init_submodule(const char *path, const char *prefix, int quiet)
>  {
>  	const struct submodule *sub;
> @@ -487,6 +515,119 @@ static int module_name(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct cb_foreach {
> +	int argc;
> +	const char **argv;
> +	const char *prefix;
> +	unsigned int quiet: 1;
> +	unsigned int recursive: 1;
> +};
> +#define CB_FOREACH_INIT { 0, NULL, 0, 0 }

Need an extra NULL as Stefan pointed out:
  { 0, NULL, NULL, 0, 0 }

> +
> +static void runcommand_in_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +	struct cb_foreach *info = cb_data;
> +	char *toplevel = xgetcwd();
> +	const struct submodule *sub;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	char* displaypath = NULL;
> +	int i;
> +
> +	/* Only loads from .gitmodules, no overlay with .git/config */
> +	gitmodules_config();
> +
> +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +	sub = submodule_from_path(null_sha1, list_item->name);
> +
> +	if (!sub)
> +		die(_("No url found for submodule path '%s' in .gitmodules"),
> +		      displaypath);
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.use_shell = 1;
> +	cp.dir = list_item->name;
> +
> +	argv_array_pushf(&cp.env_array, "name=%s", sub->name);
> +	argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
> +	argv_array_pushf(&cp.env_array, "path=%s", list_item->name);
> +	argv_array_pushf(&cp.env_array, "sha1=%s", oid_to_hex(&list_item->oid));
> +	argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
> +
> +	for (i = 0; i < info->argc; i++)
> +		argv_array_push(&cp.args, info->argv[i]);
> +
> +	if (!is_submodule_populated_gently(list_item->name, NULL))
> +		return;

This check needs to be hoisted up probably before calculating the
display path, otherwise you have a bunch of memory leaks that need to be
plugged. Something like:

    +	sub = submodule_from_path(null_sha1, list_item->name);
    +
    +	if (!sub)
    +		die(_("No url found for submodule path '%s' in .gitmodules"),
    +		      displaypath);
    +
    +	if (!is_submodule_populated_gently(list_item->name, NULL))
    +		return;
    +
    +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);

> +
> +	if (!info->quiet)
> +		printf(_("Entering '%s'\n"), displaypath);
> +	if (info->argv[0] && run_command(&cp))
> +		die(_("run_command returned non-zero status for %s\n."), displaypath);
> +
> +	if (info->recursive) {
> +		struct child_process cpr = CHILD_PROCESS_INIT;
> +
> +		cpr.use_shell = 1;

You can set .git_cmd = 1 instead.

> +		cpr.dir = list_item->name;
> +		prepare_submodule_repo_env(&cpr.env_array);
> +
> +		argv_array_pushl(&cpr.args, "git", "--super-prefix", displaypath,

And then you don't need to include "git" here.

> +				 "submodule--helper", "foreach", "--recursive", NULL);
> +
> +		if (info->quiet)
> +			argv_array_push(&cpr.args, "--quiet");
> +
> +		for (i = 0; i < info->argc; i++)
> +			argv_array_push(&cpr.args, info->argv[i]);
> +
> +		if (run_command(&cpr))
> +			die(_("run_command returned non-zero status while \
> +			      recuring in the nested submodules of %s\n."),

If you're going to split these two lines up then it may make more sense
to use concatenation instead of a continuation '\'.  I'm not sure how
the spaces at the beginning of the line will look when printed.
Something like this:

    +			die(_("run_command returned non-zero status while"
    +			      "recursing in the nested submodules of %s\n."),


Also s/recuring/recursing

> +			      displaypath);
> +	}
> +
> +	free(displaypath);
> +	free(toplevel);
> +}
> +
> +static int module_foreach(int argc, const char **argv, const char *prefix)
> +{
> +	struct cb_foreach info = CB_FOREACH_INIT;
> +	struct pathspec pathspec;
> +	struct module_list list = MODULE_LIST_INIT;
> +	int quiet = 0;
> +	int recursive = 0;
> +
> +	struct option module_foreach_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output of entering each submodule command")),
> +		OPT_BOOL(0, "recursive", &recursive,
> +			 N_("Recurse into nested submodules")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper foreach [--quiet] [--recursive] <command>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_foreach_options,
> +			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
> +		die("BUG: module_list_compute should not choke on empty pathspec");

You mentioned using the 'BUG()' function call, and you use it up above,
so why not use it here too.

> +
> +	info.argc = argc;
> +	info.argv = argv;
> +	info.prefix = prefix;
> +	info.quiet = !!quiet;
> +	info.recursive = !!recursive;

If these values are boolean why do we need to do the extra '!!'?

> +
> +	for_each_submodule_list(list, runcommand_in_submodule, &info);
> +
> +	return 0;
> +}
> +
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>  			   const char *depth, struct string_list *reference,
>  			   int quiet, int progress)
> @@ -1212,6 +1353,7 @@ static struct cmd_struct commands[] = {
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> +	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index c0d0e9a4c..032fd2540 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -322,45 +322,8 @@ cmd_foreach()
>  		shift
>  	done
>  
> -	toplevel=$(pwd)
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
>  
> -	# dup stdin so that it can be restored when running the external
> -	# command in the subshell (and a recursive call to this function)
> -	exec 3<&0
> -
> -	{
> -		git submodule--helper list --prefix "$wt_prefix" ||
> -		echo "#unmatched" $?
> -	} |
> -	while read -r mode sha1 stage sm_path
> -	do
> -		die_if_unmatched "$mode" "$sha1"
> -		if test -e "$sm_path"/.git
> -		then
> -			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> -			say "$(eval_gettext "Entering '\$displaypath'")"
> -			name=$(git submodule--helper name "$sm_path")
> -			(
> -				prefix="$prefix$sm_path/"
> -				sanitize_submodule_env
> -				cd "$sm_path" &&
> -				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
> -				# we make $path available to scripts ...
> -				path=$sm_path &&
> -				if test $# -eq 1
> -				then
> -					eval "$1"
> -				else
> -					"$@"
> -				fi &&
> -				if test -n "$recursive"
> -				then
> -					cmd_foreach "--recursive" "$@"
> -				fi
> -			) <&3 3<&- ||
> -			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
> -		fi
> -	done
>  }
>  
>  #
> -- 
> 2.11.0
> 

-- 
Brandon Williams
