Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B2C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0627613BD
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGIOzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhGIOzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 10:55:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6BC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 07:52:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so1206155pju.1
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dHAk2x2MaUWd1ZpVP+1dEkFpMsygHQ983UyoJ3h84wU=;
        b=P7Qeb2z3JzAx6gf7gnFE9AZT8NPAF6GurigPLYV88SdtyBHJxOLT1tk/+v5v4pXE0x
         TWACVgEupMekECr0ZAulbMVIUYMl5hwfSCbuby8+SsOmZmNeKvJmzD9CBaKWejC96M6I
         jmERw5hsSTPvjleXhgauaV1wN+G6UWW4Z1Vx0JQp++tLkVWPMlT1EjmJFYvo4hAqstHH
         9j9V/4adfx5PTSNJA4PhUJwE4jJolaZ5JywtuXfRWpf7N1dLciNUBKxikS4spKJ9znK4
         pvPwE2Lt/sbmurq5096CE0xhJs3jsvfpMJAy8cVxG5MV7/GRgV/+kWdGPRv1SW3zeNoH
         viCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dHAk2x2MaUWd1ZpVP+1dEkFpMsygHQ983UyoJ3h84wU=;
        b=QSvFxIKEeIr8IwXKiJXbsgoC+1i6KMHDC/gwPjCw8K+FTRxnP2Utgw6jB7JIkXMVmG
         QA3sSP7QqlpcvXyNouARLHZcNpw1Rdl3RsRbiFmFjVaCOce8t7PgecGrS6FATytbynbg
         dqjyBmJdH1EGcIHgE85VoIeMke8nty1xE4wJymsJFR6d4j0LDIQn3Lk0qPNVLbC84g0A
         JJSjM9849xGJFupTevL07YOQ8cTWnXGMfomnaMgK0TrskcXRPyg9p99UQch0ITuVEFrr
         PJhV5t1VsSN30cNFgm6UzSDiTj7V9eSjXyNfZRoez6RjCgaVznE5th1BG2Aspj9YLE0x
         SdQQ==
X-Gm-Message-State: AOAM533tGiSOs9w7nPRGLlh+RU0L4UE1oQsEWp6rThyJM2TFCMB07NAt
        2x8KPrEtc3+9AOGEaZ8eIdE=
X-Google-Smtp-Source: ABdhPJyZV7ejJ4evOj73+8T+MaXUEwBCFOq18j6TiReLIPt1AKSquVToq/g+QrpVBB6mmbPvj9qKDA==
X-Received: by 2002:a17:902:b198:b029:11b:2246:e374 with SMTP id s24-20020a170902b198b029011b2246e374mr31420190plr.17.1625842353228;
        Fri, 09 Jul 2021 07:52:33 -0700 (PDT)
Received: from localhost ([2402:800:63b8:f6f9:3a91:18b:7264:dbcb])
        by smtp.gmail.com with ESMTPSA id w186sm1370819pfw.106.2021.07.09.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:52:32 -0700 (PDT)
Date:   Fri, 9 Jul 2021 21:52:29 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH v2 2/4] submodule: prefix die messages with 'fatal'
Message-ID: <YOhirWqj7ajsqlYw@danh.dev>
References: <20210706181936.34087-1-raykar.ath@gmail.com>
 <20210708095533.26226-1-raykar.ath@gmail.com>
 <20210708095533.26226-3-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708095533.26226-3-raykar.ath@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-08 15:25:31+0530, Atharva Raykar <raykar.ath@gmail.com> wrote:
> The standard `die()` function that is used in C code prefixes all the
> messages passed to it with 'fatal: '. This does not happen with the
> `die` used in 'git-submodule.sh'.
> 
> Let's prefix each of the shell die messages with 'fatal: ' so that when
> they are converted to C code, the error messages stay the same as before
> the conversion.

That sounds good.

> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -147,7 +147,7 @@ cmd_add()
>  
>  	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
>  	then
> -		 die "$(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
> +		 die "$(eval_gettext "fatal: please make sure that the .gitmodules file is in the working tree")"

Except that, "fatal: " isn't subjected to translation. And this will
create new translatable item for translator. Perhaps:

-		 die "$(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
+		 die "fatal: $(eval_gettext "please make sure that the .gitmodules file is in the working tree")"

-- Danh

>  	fi
>  
>  	if test -n "$reference_path"
> @@ -176,7 +176,7 @@ cmd_add()
>  	case "$repo" in
>  	./*|../*)
>  		test -z "$wt_prefix" ||
> -		die "$(gettext "Relative path can only be used from the toplevel of the working tree")"
> +		die "$(gettext "fatal: Relative path can only be used from the toplevel of the working tree")"
>  
>  		# dereference source url relative to parent's url
>  		realrepo=$(git submodule--helper resolve-relative-url "$repo") || exit
> @@ -186,7 +186,7 @@ cmd_add()
>  		realrepo=$repo
>  		;;
>  	*)
> -		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin with ./|../")"
> +		die "$(eval_gettext "fatal: repo URL: '\$repo' must be absolute or begin with ./|../")"
>  	;;
>  	esac
>  
> @@ -205,17 +205,17 @@ cmd_add()
>  	if test -z "$force"
>  	then
>  		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
> -		die "$(eval_gettext "'\$sm_path' already exists in the index")"
> +		die "$(eval_gettext "fatal: '\$sm_path' already exists in the index")"
>  	else
>  		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
> -		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
> +		die "$(eval_gettext "fatal: '\$sm_path' already exists in the index and is not a submodule")"
>  	fi
>  
>  	if test -d "$sm_path" &&
>  		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
>  	then
>  	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
> -	    die "$(eval_gettext "'\$sm_path' does not have a commit checked out")"
> +	    die "$(eval_gettext "fatal: '\$sm_path' does not have a commit checked out")"
>  	fi
>  
>  	if test -z "$force"
> @@ -238,7 +238,7 @@ cmd_add()
>  
>  	if ! git submodule--helper check-name "$sm_name"
>  	then
> -		die "$(eval_gettext "'$sm_name' is not a valid submodule name")"
> +		die "$(eval_gettext "fatal: '$sm_name' is not a valid submodule name")"
>  	fi
>  
>  	# perhaps the path exists and is already a git repo, else clone it
> @@ -281,7 +281,7 @@ or you are unsure what this means choose another name with the '--name' option."
>  	git config submodule."$sm_name".url "$realrepo"
>  
>  	git add --no-warn-embedded-repo $force "$sm_path" ||
> -	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
> +	die "$(eval_gettext "fatal: Failed to add submodule '\$sm_path'")"
>  
>  	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
>  	git submodule--helper config submodule."$sm_name".url "$repo" &&
> @@ -290,7 +290,7 @@ or you are unsure what this means choose another name with the '--name' option."
>  		git submodule--helper config submodule."$sm_name".branch "$branch"
>  	fi &&
>  	git add --force .gitmodules ||
> -	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
> +	die "$(eval_gettext "fatal: Failed to register submodule '\$sm_path'")"
>  
>  	# NEEDSWORK: In a multi-working-tree world, this needs to be
>  	# set in the per-worktree config.
> @@ -565,7 +565,7 @@ cmd_update()
>  		else
>  			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
>  				git rev-parse --verify HEAD) ||
> -			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
> +			die "$(eval_gettext "fatal: Unable to find current revision in submodule path '\$displaypath'")"
>  		fi
>  
>  		if test -n "$remote"
> @@ -575,12 +575,12 @@ cmd_update()
>  			then
>  				# Fetch remote before determining tracking $sha1
>  				fetch_in_submodule "$sm_path" $depth ||
> -				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
> +				die "$(eval_gettext "fatal: Unable to fetch in submodule path '\$sm_path'")"
>  			fi
>  			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
>  			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
>  				git rev-parse --verify "${remote_name}/${branch}") ||
> -			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
> +			die "$(eval_gettext "fatal: Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
>  		fi
>  
>  		if test "$subsha1" != "$sha1" || test -n "$force"
> @@ -604,36 +604,36 @@ cmd_update()
>  				# not be reachable from any of the refs
>  				is_tip_reachable "$sm_path" "$sha1" ||
>  				fetch_in_submodule "$sm_path" "$depth" "$sha1" ||
> -				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
> +				die "$(eval_gettext "fatal: Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
>  			fi
>  
>  			must_die_on_failure=
>  			case "$update_module" in
>  			checkout)
>  				command="git checkout $subforce -q"
> -				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> +				die_msg="$(eval_gettext "fatal: Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
>  				;;
>  			rebase)
>  				command="git rebase ${GIT_QUIET:+--quiet}"
> -				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
> +				die_msg="$(eval_gettext "fatal: Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
>  				must_die_on_failure=yes
>  				;;
>  			merge)
>  				command="git merge ${GIT_QUIET:+--quiet}"
> -				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
> +				die_msg="$(eval_gettext "fatal: Unable to merge '\$sha1' in submodule path '\$displaypath'")"
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
>  				must_die_on_failure=yes
>  				;;
>  			!*)
>  				command="${update_module#!}"
> -				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
> +				die_msg="$(eval_gettext "fatal: Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
>  				say_msg="$(eval_gettext "Submodule path '\$displaypath': '\$command \$sha1'")"
>  				must_die_on_failure=yes
>  				;;
>  			*)
> -				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
> +				die "$(eval_gettext "fatal: Invalid update mode '$update_module' for submodule path '$path'")"
>  			esac
>  
>  			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
> @@ -660,7 +660,7 @@ cmd_update()
>  			res=$?
>  			if test $res -gt 0
>  			then
> -				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
> +				die_msg="$(eval_gettext "fatal: Failed to recurse into submodule path '\$displaypath'")"
>  				if test $res -ne 2
>  				then
>  					err="${err};$die_msg"
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7aa7fefdfa..cb1b8e35db 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -51,7 +51,7 @@ test_expect_success 'submodule update aborts on missing gitmodules url' '
>  
>  test_expect_success 'add aborts on repository with no commits' '
>  	cat >expect <<-\EOF &&
> -	'"'repo-no-commits'"' does not have a commit checked out
> +	fatal: '"'repo-no-commits'"' does not have a commit checked out
>  	EOF
>  	git init repo-no-commits &&
>  	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
> @@ -199,7 +199,7 @@ test_expect_success 'submodule add to .gitignored path with --force' '
>  test_expect_success 'submodule add to path with tracked content fails' '
>  	(
>  		cd addtest &&
> -		echo "'\''dir-tracked'\'' already exists in the index" >expect &&
> +		echo "fatal: '\''dir-tracked'\'' already exists in the index" >expect &&
>  		mkdir dir-tracked &&
>  		test_commit foo dir-tracked/bar &&
>  		test_must_fail git submodule add "$submodurl" dir-tracked >actual 2>&1 &&
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index f4f61fe554..11cccbb333 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -448,7 +448,7 @@ test_expect_success 'fsck detects command in .gitmodules' '
>  '
>  
>  cat << EOF >expect
> -Execution of 'false $submodulesha1' failed in submodule path 'submodule'
> +fatal: Execution of 'false $submodulesha1' failed in submodule path 'submodule'
>  EOF
>  
>  test_expect_success 'submodule update - command in .git/config catches failure' '
> @@ -465,7 +465,7 @@ test_expect_success 'submodule update - command in .git/config catches failure'
>  '
>  
>  cat << EOF >expect
> -Execution of 'false $submodulesha1' failed in submodule path '../submodule'
> +fatal: Execution of 'false $submodulesha1' failed in submodule path '../submodule'
>  EOF
>  
>  test_expect_success 'submodule update - command in .git/config catches failure -- subdirectory' '
> @@ -484,7 +484,7 @@ test_expect_success 'submodule update - command in .git/config catches failure -
>  
>  test_expect_success 'submodule update - command run for initial population of submodule' '
>  	cat >expect <<-EOF &&
> -	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
> +	fatal: Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
>  	EOF
>  	rm -rf super/submodule &&
>  	test_must_fail git -C super submodule update 2>actual &&
> @@ -493,8 +493,8 @@ test_expect_success 'submodule update - command run for initial population of su
>  '
>  
>  cat << EOF >expect
> -Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
> -Failed to recurse into submodule path '../super'
> +fatal: Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
> +fatal: Failed to recurse into submodule path '../super'
>  EOF
>  
>  test_expect_success 'recursive submodule update - command in .git/config catches failure -- subdirectory' '
> -- 
> 2.32.0
> 

-- 
Danh
