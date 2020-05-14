Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7221C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808F5206B6
	for <git@archiver.kernel.org>; Thu, 14 May 2020 10:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdPEsIWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgENKKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENKKT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 06:10:19 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94CAC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 03:10:18 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id z9so1355837qvi.12
        for <git@vger.kernel.org>; Thu, 14 May 2020 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O8h4M7oSZRKWmR/h2V0mLwwUhhZ8xe0lGcam+aLBIss=;
        b=BdPEsIWQwV4e3cKlI5BWUG7kmmYjtSoBW2e+geDWww/lepDEjNJN5i7kbIvxVrgGCQ
         OvF1EYNmfnpneoolO5J4hVXgrQWVvoJ2neosV0hrIwlwPFc4ZwKz3/MxCir2lw5C0+2J
         Xv+12SirvmOzuCaBIMEQzzwKkhIK9xSjnD0k48ygSFvo3e7IikeTGerepSyiSCSTjC+s
         /AKL4GmVva2IOqWT86o7EuBN78aEiMgvZo+bUawG+qh292XAsXgNEISQsHghQL2eAI39
         oaUpM8Q6kDRleCiLPr/D2E7g8POiWmYMleFGAbwuRtcsf4tqzF+YztGmn9a3iL5uw4TT
         5jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O8h4M7oSZRKWmR/h2V0mLwwUhhZ8xe0lGcam+aLBIss=;
        b=MImZqA0rWfPbyyBxiT05pNJFB4KgOREDzm4Bz1yAVOUspfoJgmfWjuVjiZ0qzKd38x
         Lfu6pNXCIF/aDfSowN1Xx7AJufWjo4fffNJruhAzhXItVPSrx1bEKFSXWJ4fOfpxGywR
         zBNsq1regXf4SH9e9WUv32gxekHUdAroSi7HUGHPRqJBD+u+gVGw+K1cWHa1lhGfaO7q
         DWZXfOPptsWW11lGD5X3uiEDB3tqPsmN4r0WCto4Su2LNLr6lQIiCn0nGg/oLoYqiUdt
         9+rvnALLUD/8JhGMsXuUueGVG52mPq+ljpMuTFD0EPyIvHABJZj6hhW2VwI/ovRtpvqe
         xCZA==
X-Gm-Message-State: AOAM530Hi4PH8a5eatiKCqquFq2JBABOrafWbcxaqA4pu2Pe/2iOm7Hm
        /E2+ZyW6g4liI0bBwQ3Fb0pmPtoP
X-Google-Smtp-Source: ABdhPJxWmpvWK78Homj+qc0T/3392sex0U7RDGSC+blLnUZ5IHbBFwWNf7If/nQxI+zSB63yy9foCw==
X-Received: by 2002:a05:6214:70a:: with SMTP id b10mr3962387qvz.186.1589451017544;
        Thu, 14 May 2020 03:10:17 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d207sm2178886qkc.49.2020.05.14.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 03:10:16 -0700 (PDT)
Date:   Thu, 14 May 2020 06:10:13 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell
 to C
Message-ID: <20200514101013.GA28018@generichostname>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Thu, May 14, 2020 at 01:47:36AM +0530, Shourya Shukla wrote:
> Convert submodule subcommand 'set-branch' to a builtin. Port 'set-branch'
> to 'submodule--helper.c' and call the latter via 'git-submodule.sh'.
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> Here is another conversion, this time it is 'set-branch'. It passes all
> the tests in t7419. I am aware that there are some repetitve parts in
> the conversion as well as variables which can be named better. I would
> love everyone's suggestion on this and how this can be made better.
> 
> The extra '$branch' on line 752 was because of Christian's help after
> reference from TLDP's Parameter Subsitution documentation:
> https://www.tldp.org/LDP/abs/html/parameter-substitution.html
> 
> Similarly, I had to change a coouple of other lines in the shell version
> so as to make it compatible with the C version.
> 
> Thank you so much Christian and Kaartic for the mentoring, this wouldn't
> have been possible otherwise :)
> 
>  builtin/submodule--helper.c | 58 +++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 31 ++------------------
>  2 files changed, 60 insertions(+), 29 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f50745a03f..5a8815b76e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2284,6 +2284,63 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static int module_set_branch(int argc, const char **argv, const char *prefix)
> +{
> +	int quiet = 0, opt_branch = 0, opt_default = 0;
> +	const char *newbranch;

nit: I would call this new_branch

> +	const char *path;
> +	char *config_name;
> +
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output for setting default tracking branch of a submodule")),
> +		OPT_BOOL(0, "default", &opt_default, N_("Set the default tracking branch to master")),
> +		OPT_BOOL(0, "branch", &opt_branch, N_("Set the default tracking branch to the one specified")),

This should use OPT_STRING and accept a string argument instead of using
the implicit command-line ordering.

> +		OPT_END()
> +	};
> +	const char *const usage[] = {
> +		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
> +		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if ((!opt_branch && !opt_default))
> +		die(_("At least one of --branch and --default required"));

Error messages in Git are generally written without capitalising the
first letter of the sentence.

> +
> +	if (opt_branch) {
> +		if (opt_default)
> +			die(_("--branch and --default do not make sense"));

This error message should be qualified, perhaps with something like "do
not make sense together".

> +
> +		newbranch = argv[0];
> +		path = argv[1];

These assignments are incorrect since we haven't check argc yet. Also,
they're redundant since you have the assignments in the if statement
below.

Also, if you do the OPT_STRING thing as described above, you can do the
`path = ...` outside of the if-statement since it'll be common to both
-d and -b.

> +
> +		if (argc != 2 || !(newbranch = argv[0]) || !(path = argv[1]))
> +			usage_with_options(usage, options);
> +
> +		config_name = xstrfmt("submodule.%s.branch", path);
> +		config_set_in_gitmodules_file_gently(config_name, newbranch);
> +
> +		printf(_("Default tracking branch set to '%s' successfully\n"), newbranch);

The original function did not print anything. We shouldn't alter the
behaviour if we're just porting it over so we should delete this.

> +		free(config_name);
> +	}
> +
> +	if (opt_default) {
> +		path = argv[0];
> +
> +		if (argc != 1 || !(path = argv[0]))
> +			usage_with_options(usage, options);
> +
> +		config_name = xstrfmt("submodule.%s.branch", path);
> +		config_set_in_gitmodules_file_gently(config_name, NULL);
> +
> +		printf(_("Default tracking branch set to 'master' successfully\n"));
> +		free(config_name);
> +	}

The same arguments for the above apply to this case too. Actually, the
only place where they both really differ is in the call to
config_set_in_gitmodules_file_gently(). Can you do all of your argument
checks together? Something like

	if (!!new_branch == opt_default)
		usage_with_options(usage, options);

Then the call to config_set_in_gitmodules_file_gently() could look like
this:

	config_name = xstrfmt("submodule.%s.branch", path);
	config_set_in_gitmodules_file_gently(config_name, new_branch ? new_branch : NULL);
	free(config_name);

and we wouldn't need the ifs at all.

> +
> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -2315,6 +2372,7 @@ static struct cmd_struct commands[] = {
>  	{"check-name", check_name, 0},
>  	{"config", module_config, 0},
>  	{"set-url", module_set_url, 0},
> +	{"set-branch", module_set_branch, 0},
>  };
>  
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 39ebdf25b5..2438ef576e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -719,7 +719,6 @@ cmd_update()
>  # $@ = requested path
>  #
>  cmd_set_branch() {
> -	unset_branch=false
>  	branch=
>  
>  	while test $# -ne 0
> @@ -729,7 +728,7 @@ cmd_set_branch() {
>  			# we don't do anything with this but we need to accept it
>  			;;
>  		-d|--default)
> -			unset_branch=true
> +			default=1
>  			;;
>  		-b|--branch)
>  			case "$2" in '') usage ;; esac
> @@ -750,33 +749,7 @@ cmd_set_branch() {
>  		shift
>  	done
>  
> -	if test $# -ne 1
> -	then
> -		usage
> -	fi
> -
> -	# we can't use `git submodule--helper name` here because internally, it
> -	# hashes the path so a trailing slash could lead to an unintentional no match
> -	name="$(git submodule--helper list "$1" | cut -f2)"
> -	if test -z "$name"
> -	then
> -		exit 1
> -	fi
> -
> -	test -n "$branch"; has_branch=$?
> -	test "$unset_branch" = true; has_unset_branch=$?
> -
> -	if test $((!$has_branch != !$has_unset_branch)) -eq 0
> -	then
> -		usage
> -	fi
> -
> -	if test $has_branch -eq 0
> -	then
> -		git submodule--helper config submodule."$name".branch "$branch"
> -	else
> -		git submodule--helper config --unset submodule."$name".branch
> -	fi
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"

The shell script portion looks good.

Thanks,

Denton

>  }
>  
>  #
> -- 
> 2.26.2
> 
