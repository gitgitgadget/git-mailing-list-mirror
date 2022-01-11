Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA74C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbiAKCKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbiAKCKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:10:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1944CC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:10:00 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id t11-20020a17090a6a0b00b001b3a590dbefso1126711pjj.4
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L8HHqphjZWxARvw+NWvQaodtomzQZoICPr15Sjnwkwk=;
        b=TuYMndpxZDsjjB4JGtYzNoFCIhTQd/+ffvyfVlQuxdTCK0UNrla8Z2qYGu+M9fPP29
         5z4MxuG94mE3uk71Jqokfr+Kl+CVMV3QfVRuW+PV/H1C2K45KYshe5zc7hv1oQpxm7hT
         Js2Btt4JbvUmL8jjIPPhP3DbiNvlChaRX1wW5vpOLVBLWgcpJbJuDfvGxSX7CsJQMW9B
         nPYDtBFSoZvD/qC1CnSy58rwlIwSGw0u5NFIEUoyHFfi1qBzrDyNaum4BUSHczzaYgSJ
         5OX+CpeD2076rngQeWPIR7/YwxbsgrAFf9WyHDxoyyqvCGBPgZ1kGIYS6a7jlMCd0qac
         k5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L8HHqphjZWxARvw+NWvQaodtomzQZoICPr15Sjnwkwk=;
        b=fj5DAkyFIjJLWPgrF4S7eH4ptHq90TYvgqh2bsho0wgMZ8Uk1FWGK/CDzZPHzrySR9
         HWL+xJ0CWxTtBEIjedVhrBI8zynCH0ZmDxQ5Vq1M604MdUvk/kUzmnFPzatnOXpXbh7E
         F4MZMmmQ1ycfPz+i2ulpltA0lhhhmHz/ndpWHjyew8+3giWVue4Z1xaBytRDIsu84IQ5
         Td5v9Amqzm26L88s+XwXcbe1O03rOHaz29o6/CtBONjSzILdQ9weWeAND34PMSPY81q6
         HLgl7+wVM54trRAJNh5f/4LE01v4Qi1gG69RkYgrd+s2tM1Z4apoQxpsyGO5vad5txAd
         XZxw==
X-Gm-Message-State: AOAM530GlfOmftdZH4urFeoqZGdgFcc1xik3nMV2C/mYcrXsh5r1yKkc
        ucP+BCuX+1Wtmy+Im+ZeiBDMlBIKcKOCdwCH1UL1
X-Google-Smtp-Source: ABdhPJz+FPPzWw7FKLiU45ABMHJEiHYnhroj0nt0rD2jGt6Qhq9N5yWNOey34Yd9r/sIGWqeSQj5DRL/hfSi96yZXrsB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:8f1d:: with SMTP id
 n29mr2160272pgd.342.1641866999520; Mon, 10 Jan 2022 18:09:59 -0800 (PST)
Date:   Mon, 10 Jan 2022 18:09:53 -0800
In-Reply-To: <20211220233459.45739-2-chooglen@google.com>
Message-Id: <20220111020953.1225789-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-2-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH v6 1/5] branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> This refactor is motivated by a desire to add a "dry_run" parameter to
> create_branch() that will validate whether or not a branch can be
> created without actually creating it - this behavior will be used in a
> subsequent commit that adds `git branch --recurse-submodules topic`.

Makes sense.

> Adding "dry_run" is not obvious because create_branch() is also used to
> set tracking information without creating a branch, i.e. when using
> --set-upstream-to. 

create_branch() is complicated, OK.

> This appears to be a leftover from 4fc5006676 (Add
> branch --set-upstream, 2010-01-18), when --set-upstream would sometimes
> create a branch and sometimes update tracking information without
> creating a branch. However, we no longer support --set-upstream, so it
> makes more sense to set tracking information with another function and
> use create_branch() only to create branches. In a later commit, we will
> remove the now-unnecessary logic from create_branch() so that "dry_run"
> becomes trivial to implement.

What do you mean by "leftover"?

Aside from that, the pertinent information is that the mentioned commit
changed create_branch() to no longer always create a branch, instead
sometimes creating a branch and sometimes updating tracking information
(and sometimes both). I don't think whether we support "--set-upstream"
is material here.

Also, what is the now-unnecessary logic to be removed in a later commit?

> Introduce dwim_and_setup_tracking(), which replaces create_branch()
> in `git branch --set-upstream-to`. Ensure correctness by moving the DWIM
> and branch validation logic from create_branch() into a helper function,
> dwim_branch_start(), so that the logic is shared by both functions.

I think it's clearer to just say what we're refactoring instead of
saying that we're introducing a function and making sure that it is
correct, not by testing (as one would expect), but by moving logic.

I would write the commit message like this:

  This commit is in preparation for a future commit that adds a dry_run
  parameter to create_branch() (that is needed for supporting "git
  branch --recurse-submodules", to be introduced in another future
  commit).

  create_branch() used to always create a branch, but this was changed
  in 4fc5006676 (Add branch --set-upstream, 2010-01-18), when it was
  changed to be also able to set tracking information.

  Refactor the code that sets tracking information into its own
  functions dwim_branch_start() and dwim_and_setup_tracking(). Also
  change an invocation of create_branch() in cmd_branch() in
  builtin/branch.c to use dwim_and_setup_tracking(), since that
  invocation is only for setting tracking information.

And if this is true:

  As of this commit, create_branch() still sometimes does not create
  branches, but this will be fixed in a subsequent commit.

> @@ -217,9 +217,11 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
>  }
>  
>  /*
> - * This is called when new_ref is branched off of orig_ref, and tries
> - * to infer the settings for branch.<new_ref>.{remote,merge} from the
> - * config.
> + * Used internally to set the branch.<new_ref>.{remote,merge} config
> + * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
> + * dwim_and_setup_tracking(), this does not do DWIM, i.e. "origin/main"
> + * will not be expanded to "refs/remotes/origin/main", so it is not safe
> + * for 'orig_ref' to be raw user input.
>   */
>  static void setup_tracking(const char *new_ref, const char *orig_ref,
>  			   enum branch_track track, int quiet)

The comment makes sense.

> @@ -244,7 +246,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  		case BRANCH_TRACK_INHERIT:
>  			break;
>  		default:
> -			return;
> +			goto cleanup;
>  		}
>  
>  	if (tracking.matches > 1)
> @@ -257,6 +259,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  				tracking.remote, tracking.srcs) < 0)
>  		exit(-1);
>  
> +cleanup:
>  	string_list_clear(tracking.srcs, 0);
>  }
>  

This seems like it's just for avoiding a memory leak, and is unrelated
to this commit, so it should go into its own commit.

> @@ -340,31 +343,37 @@ N_("\n"
>  "will track its remote counterpart, you may want to use\n"
>  "\"git push -u\" to set the upstream config as you push.");
>  
> -void create_branch(struct repository *r,
> -		   const char *name, const char *start_name,
> -		   int force, int clobber_head_ok, int reflog,
> -		   int quiet, enum branch_track track)

This seems to have the same parameters as the "+" version, but wrapped
differently - don't rewrap unless you're also changing it.

> +/**
> + * DWIMs a user-provided ref to determine the starting point for a
> + * branch and validates it, where:
> + *
> + *   - r is the repository to validate the branch for
> + *
> + *   - start_name is the ref that we would like to test. This is
> + *     expanded with DWIM and assigned to out_real_ref.
> + *
> + *   - track is the tracking mode of the new branch. If tracking is
> + *     explicitly requested, start_name must be a branch (because
> + *     otherwise start_name cannot be tracked)
> + *
> + *   - out_oid is an out parameter containing the object_id of start_name
> + *
> + *   - out_real_ref is an out parameter containing the full, 'real' form
> + *     of start_name e.g. refs/heads/main instead of main
> + *
> + */
> +static void dwim_branch_start(struct repository *r, const char *start_name,
> +			   enum branch_track track, char **out_real_ref,
> +			   struct object_id *out_oid)

[snip]

> @@ -401,7 +410,34 @@ void create_branch(struct repository *r,
>  
>  	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
>  		die(_("Not a valid branch point: '%s'."), start_name);
> -	oidcpy(&oid, &commit->object.oid);
> +	if (out_real_ref)
> +		*out_real_ref = real_ref ? xstrdup(real_ref) : NULL;

I think you can just write "*out_real_ref = real_ref; real_ref = NULL;"
here, and then not need to xstrdup.

> +	if (out_oid)
> +		oidcpy(out_oid, &commit->object.oid);
> +
> +	FREE_AND_NULL(real_ref);
> +}

Comparing dwim_branch_start()...

> +void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
> +			     const char *orig_ref, enum branch_track track,
> +			     int quiet)
> +{
> +	char *real_orig_ref;
> +	dwim_branch_start(r, orig_ref, track, &real_orig_ref, NULL);
> +	setup_tracking(new_ref, real_orig_ref, track, quiet);
> +}

...and this...

> @@ -823,12 +823,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		if (!ref_exists(branch->refname))
>  			die(_("branch '%s' does not exist"), branch->name);
>  
> -		/*
> -		 * create_branch takes care of setting up the tracking
> -		 * info and making sure new_upstream is correct
> -		 */
> -		create_branch(the_repository, branch->name, new_upstream,
> -			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
> +		dwim_and_setup_tracking(the_repository, branch->name,
> +					new_upstream, BRANCH_TRACK_OVERRIDE,
> +					quiet);
>  	} else if (unset_upstream) {
>  		struct branch *branch = branch_get(argv[0]);
>  		struct strbuf buf = STRBUF_INIT;

...looking at this, I can see that dwim_and_setup_tracking() indeed does
everything that this create_branch() invocation would do, so overall the
commit makes sense.
