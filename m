Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0F2C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhLIWUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhLIWUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:20:18 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF55DC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:16:44 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so4656736pjb.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BdJ52MNsltQkDiEjvSzvMWtQ7/8OfLO8TTyRs3h7P10=;
        b=f/vTAmF1ir/lrfH/a9TG/ob9A/P6RhdiZGrURe9TpQ+CuvnHb4CABg0oyW2jmrHx4Z
         cBtpnCfcrTEyMmkfkdXDB+Q6o+pKnM/nhkOT2/0yP6dzFGMs+/Gc+rgAaD4BaMh6KEBp
         duo5mwjNo+u20nG2T2XWfyRcTz0rzYrkaJCdf6XWXNt/ML+BYEGjVothd88sL6ZJSFU/
         Uz3qrTtyu7O1wBaroWX1ogPls5JsomGoZOTalYQCeobl801ASqeGWIN/Z1FCVCAT39YU
         k1LzOUh5gIls3/iIZ8WhT1tVKVvytsYEieoGKGTE8NCCCQjS82zgjW+kE2fW8vbi3mRO
         2DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BdJ52MNsltQkDiEjvSzvMWtQ7/8OfLO8TTyRs3h7P10=;
        b=E7stPz3CS/G4KIdz7QyioKZm9LSTbnJLDqYBIQvP8OFxHGSXV1Ay6yKSHkVcgf40tJ
         3RXxBOsvqm4RrnPWEMR/SeWrhDsfhKDl4HygC8+lG0+icO5dYGOuCbj32c/uwmJTR3kc
         sBWptG0pmSJc+uDOvUw7xSewcWdieHS1iPQMZ4n9MqKwFRGP23D4q5noBcHdRtGblIdD
         e6dpv8UGyOtb6hX6hIJ+G47G6Rvn9cWt9QKvT5ckwZNGPW0xxTFLrASBNU8lZ18X8X1+
         +WGtroAgoTn+4JkaC5o8EHOXTN4xBE9V5F3oC9rkgKwOKFeCXYSNGYL+4Rks/KoMdH0e
         fQzw==
X-Gm-Message-State: AOAM531Dex6p9tt7U3wfHgrYdYGmcIAfDrrpZLXTzmDvzXKxXRi8D1pW
        1zNrgF924geRmLDVAQQhmyNoQOAjZdIXJA==
X-Google-Smtp-Source: ABdhPJzfxPAQqsOa+LyzC0Mx0PsE24AtPii/Y8E6wIKa/PrNibBC4w2veaRB3YWClDcNUMubSY19Sxj9hzifBg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1486:: with SMTP id
 js6mr1147056pjb.0.1639088204232; Thu, 09 Dec 2021 14:16:44 -0800 (PST)
Date:   Thu, 09 Dec 2021 14:16:42 -0800
In-Reply-To: <20211209211951.498358-1-jonathantanmy@google.com>
Message-Id: <kl6lh7bha0fp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211209184928.71413-2-chooglen@google.com> <20211209211951.498358-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/5] branch: move --set-upstream-to behavior to setup_tracking()
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> This refactor is motivated by a desire to add a "dry_run" parameter to
>> create_branch() that will validate whether or not a branch can be
>> created without actually creating it - this behavior be used in a
>> subsequent commit that adds `git branch --recurse-submodules topic`.
>
> When I said that the patch was doing too much [1], I meant that for a
> patch that is supposed to be about refactoring, there were many lines
> that didn't seem to be a straightforward move. I've attached a version
> of the patch that I expected - notice that a reviewer can see that the
> lines are straightforwardly moved.
>
> [1] https://lore.kernel.org/git/20211123231035.3607109-1-jonathantanmy@google.com/

Thanks, the patch gave me a lot of think about.

Comparing yours and mine side-by-side makes it obvious that what I
thought was a 'simple' refactor is not so obvious to readers. I think I
can incorporate most of your patch.

>> +void setup_tracking(const char *new_ref, const char *orig_ref,
>> +			   enum branch_track track, int quiet, int expand_orig)
>>  {
>>  	struct tracking tracking;
>>  	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>> +	char *full_orig_ref;
>> +	struct object_id unused_oid;
>>  
>>  	memset(&tracking, 0, sizeof(tracking));
>> -	tracking.spec.dst = (char *)orig_ref;
>> +	if (expand_orig)
>> +		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
>> +	else
>> +		full_orig_ref = xstrdup(orig_ref);
>
> Having two meanings for a parameter (and which meaning used depending on
> another parameter) is quite confusing - I think it's better to call
> another function to expand the ref if necessary. See my patch below for
> an example.

Since you and Junio have both commented on this inconsistency, I'll drop
the extra parameter.

I wonder if you've considered another alternative [1], which is to
_always_ expand the ref, instead of _never_ expanding the ref. Always
expanding the ref wastes cycles, but it avoids creating an implicit
contract between setup_tracking() and
validate_branch_start_or_TODO_name().

>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index 267a624671..18e285a876 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -42,6 +42,23 @@ test_expect_success 'git branch abc should create a branch' '
>>  	git branch abc && test_path_is_file .git/refs/heads/abc
>>  '
>>  
>> +test_expect_success 'git branch abc should fail when abc exists' '
>> +	test_must_fail git branch abc
>> +'
>> +
>> +test_expect_success 'git branch --force abc should fail when abc is checked out' '
>> +	test_when_finished git switch main &&
>> +	git switch abc &&
>> +	test_must_fail git branch --force abc HEAD~1
>> +'
>> +
>> +test_expect_success 'git branch --force abc should succeed when abc exists' '
>> +	git rev-parse HEAD~1 >expect &&
>> +	git branch --force abc HEAD~1 &&
>> +	git rev-parse abc >actual &&
>> +	test_cmp expect actual
>> +'
>
> This seems like an unrelated test for a refactoring that doesn't seem to
> touch "force" (in builtin/branch.c, the line removed hardcodes force to
> 0).

I added this test because I was trying to simplify create_branch() by
moving around/deleting forcing and clobber_head_ok. It turns out that I
had actually broken the behavior of --force, but the test suite didn't
catch it.

I think this test is a step in the right direction, but it probably
falls into the category of 'incidental fix'. I am not sure where it
belongs if not here.

> Below is my diff, as mentioned.
>
> ---
> diff --git a/branch.c b/branch.c
> index 07a46430b3..a6803e9900 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -131,8 +131,8 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
>   * config.
>   */
> -static void setup_tracking(const char *new_ref, const char *orig_ref,
> -			   enum branch_track track, int quiet)
> +void setup_tracking(const char *new_ref, const char *orig_ref,
> +		    enum branch_track track, int quiet)
>  {
>  	struct tracking tracking;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> @@ -243,30 +243,12 @@ N_("\n"
>  "will track its remote counterpart, you may want to use\n"
>  "\"git push -u\" to set the upstream config as you push.");
>  
> -void create_branch(struct repository *r,
> -		   const char *name, const char *start_name,
> -		   int force, int clobber_head_ok, int reflog,
> -		   int quiet, enum branch_track track)
> +void TODO_name(struct repository *r, const char *start_name, int explicit_tracking,
> +	       char **out_real_ref, struct commit **out_commit)
>  {
>  	struct commit *commit;
>  	struct object_id oid;
>  	char *real_ref;
> -	struct strbuf ref = STRBUF_INIT;
> -	int forcing = 0;
> -	int dont_change_ref = 0;
> -	int explicit_tracking = 0;
> -
> -	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
> -		explicit_tracking = 1;
> -
> -	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
> -	    ? validate_branchname(name, &ref)
> -	    : validate_new_branchname(name, &ref, force)) {
> -		if (!force)
> -			dont_change_ref = 1;
> -		else
> -			forcing = 1;
> -	}
>  
>  	real_ref = NULL;
>  	if (get_oid_mb(start_name, &oid)) {
> @@ -304,6 +286,38 @@ void create_branch(struct repository *r,
>  
>  	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
>  		die(_("Not a valid branch point: '%s'."), start_name);
> +	if (out_real_ref)
> +		*out_real_ref = real_ref;
> +	if (out_commit)
> +		*out_commit = commit;
> +}

Using a separate out_real_ref makes a lot more sense than reusing
real_ref. I'll borrow this :)

> +
> +void create_branch(struct repository *r,
> +		   const char *name, const char *start_name,
> +		   int force, int clobber_head_ok, int reflog,
> +		   int quiet, enum branch_track track)
> +{
> +	struct commit *commit;
> +	struct object_id oid;
> +	char *real_ref = NULL;
> +	struct strbuf ref = STRBUF_INIT;
> +	int forcing = 0;
> +	int dont_change_ref = 0;
> +	int explicit_tracking = 0;
> +
> +	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
> +		explicit_tracking = 1;
> +
> +	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
> +	    ? validate_branchname(name, &ref)
> +	    : validate_new_branchname(name, &ref, force)) {
> +		if (!force)
> +			dont_change_ref = 1;
> +		else
> +			forcing = 1;
> +	}

This patch just moves things around without performing internal
simplification (like removing dont_change_ref). The simplification would
probably be done in a later patch.

Makes sense, I see how this is easier to review.

> @@ -821,12 +822,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		if (!ref_exists(branch->refname))
>  			die(_("branch '%s' does not exist"), branch->name);
>  
> -		/*
> -		 * create_branch takes care of setting up the tracking
> -		 * info and making sure new_upstream is correct
> -		 */
> -		create_branch(the_repository, branch->name, new_upstream,
> -			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
> +		TODO_name(the_repository, new_upstream, 1, &real_ref, NULL);
> +		setup_tracking(branch->name, real_ref, BRANCH_TRACK_OVERRIDE, quiet);
> +		free(real_ref);
>  	} else if (unset_upstream) {
>  		struct branch *branch = branch_get(argv[0]);
>  		struct strbuf buf = STRBUF_INIT;

See my previous comment and [1] about avoiding the implicit contract of
TODO_name() + setup_tracking(), but of course, this is still more
consistent than what what I proposed.

[1] https://lore.kernel.org/git/kl6l5yrzaq5z.fsf@chooglen-macbookpro.roam.corp.google.com

Thanks!
