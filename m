Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9577C4332F
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 17:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbiAKR3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 12:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiAKR33 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 12:29:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB846C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:29:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w12-20020a05690202cc00b006118e0d9e8cso2424423ybh.2
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ylAdE7Ui8AGcgF7VxD4KJJYuXKLyT0loPW+fANaSsc=;
        b=VGvI89jb550n/xool6vJA4B2IPj2PKrmdisSXQU5g4mnCn2+JbUCep3DAPZ4/uFous
         9O0KWJVU7DzADx23YrwGyn309fv/NmFmi+xBFBH4l4v9Gjftj57RZNBS6VLvRq+vOPi1
         tGj2nJNXVj3VAAyvmSZJxX21/gLDmrBCWSVRSuIklaob1u3TW8j/7yUhpmTalNkqO4tD
         xWCgIqjkKf56Obm7wEUlNoWMNZlSl5LG4a79F1FJ8o2/Y/uGKiuuUlXgTKwd3gUVv7kh
         /wKBSUmdmAI13eucxJQ2h3TcoKeodRLsXsjE8Pi8Pt9o6bAP8W/sfDncAuETim3GS/EZ
         4asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ylAdE7Ui8AGcgF7VxD4KJJYuXKLyT0loPW+fANaSsc=;
        b=qh+HWoLTfmOqREqHZtfRNmgM/1+cpl9ayPHHT9XaMN7R+c6vKef90jZ4pUbc9Ja+vL
         Y5UsEQMaMxapU3k/h2cTya5sV1cEs/I4obwXv5/ZcvTGRNQ+Tg0HxQXzAFPlDq6/vjsG
         MSflhZXlEfK20tRJczLaBTSxBHX95/h4czWcw/8wtLD4xKjkr/bM0PAMVN+bChZJOiLg
         196euZPq9XGXcGvseQiv2W0tNNtwVTLvK84dJhvouq8b74DFW7GPzID6ae72ResRGhIR
         czl/+acpv+QpYtp9m+9S/kx+pZd4hHaTVrOEnwWQwfiVU69Rj1ThIMqSx1HiQJwvMdR2
         4xwA==
X-Gm-Message-State: AOAM530fhR1Je8nihK7xNgn5DB0rSO2NpqJKX770kNO1YJWTx7XQjZFZ
        g13KmXf/cfb95pZNIYRgbr2DPwBDGBJygg==
X-Google-Smtp-Source: ABdhPJyWgAsDyMMu81rXP7KeQehKeLACZhGLaMV/BxeujBkZulres3woSax3Wrm49qZ6QkhU+UusNWKzn41rFw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:b98e:: with SMTP id
 r14mr6839756ybg.11.1641922168102; Tue, 11 Jan 2022 09:29:28 -0800 (PST)
Date:   Tue, 11 Jan 2022 09:29:26 -0800
In-Reply-To: <20220111020953.1225789-1-jonathantanmy@google.com>
Message-Id: <kl6la6g2kwp5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211220233459.45739-2-chooglen@google.com> <20220111020953.1225789-1-jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/5] branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
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

> Glen Choo <chooglen@google.com> writes:
>> This appears to be a leftover from 4fc5006676 (Add
>> branch --set-upstream, 2010-01-18), when --set-upstream would sometimes
>> create a branch and sometimes update tracking information without
>> creating a branch. However, we no longer support --set-upstream, so it
>> makes more sense to set tracking information with another function and
>> use create_branch() only to create branches. In a later commit, we will
>> remove the now-unnecessary logic from create_branch() so that "dry_run"
>> becomes trivial to implement.
>
> What do you mean by "leftover"?
>
> Aside from that, the pertinent information is that the mentioned commit
> changed create_branch() to no longer always create a branch, instead
> sometimes creating a branch and sometimes updating tracking information
> (and sometimes both). I don't think whether we support "--set-upstream"
> is material here.

I was hoping to explain why we made the decision to reuse
create_branch() to set tracking information (it made sense with
--set-upstream) and why it now makes sense to use another function
(because we no longer have --set-upstream).

But maybe this justification is unnecessary, and the desire to add a
dry_run parameter is enough.

>
> Also, what is the now-unnecessary logic to be removed in a later commit?

This would be the logic that makes create_branch() not create branches,
which is addressed in your proposed commit message.

>> Introduce dwim_and_setup_tracking(), which replaces create_branch()
>> in `git branch --set-upstream-to`. Ensure correctness by moving the DWIM
>> and branch validation logic from create_branch() into a helper function,
>> dwim_branch_start(), so that the logic is shared by both functions.
>
> I think it's clearer to just say what we're refactoring instead of
> saying that we're introducing a function and making sure that it is
> correct, not by testing (as one would expect), but by moving logic.
>
> I would write the commit message like this:
>
>   This commit is in preparation for a future commit that adds a dry_run
>   parameter to create_branch() (that is needed for supporting "git
>   branch --recurse-submodules", to be introduced in another future
>   commit).
>
>   create_branch() used to always create a branch, but this was changed
>   in 4fc5006676 (Add branch --set-upstream, 2010-01-18), when it was
>   changed to be also able to set tracking information.
>
>   Refactor the code that sets tracking information into its own
>   functions dwim_branch_start() and dwim_and_setup_tracking(). Also
>   change an invocation of create_branch() in cmd_branch() in
>   builtin/branch.c to use dwim_and_setup_tracking(), since that
>   invocation is only for setting tracking information.
>
> And if this is true:
>
>   As of this commit, create_branch() still sometimes does not create
>   branches, but this will be fixed in a subsequent commit.

Hm, I see. This makes sense, I'll incorporate some of your suggestions :)

>> @@ -244,7 +246,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>>  		case BRANCH_TRACK_INHERIT:
>>  			break;
>>  		default:
>> -			return;
>> +			goto cleanup;
>>  		}
>>  
>>  	if (tracking.matches > 1)
>> @@ -257,6 +259,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>>  				tracking.remote, tracking.srcs) < 0)
>>  		exit(-1);
>>  
>> +cleanup:
>>  	string_list_clear(tracking.srcs, 0);
>>  }
>>  
>
> This seems like it's just for avoiding a memory leak, and is unrelated
> to this commit, so it should go into its own commit.

Thanks for the catch.

>
>> @@ -340,31 +343,37 @@ N_("\n"
>>  "will track its remote counterpart, you may want to use\n"
>>  "\"git push -u\" to set the upstream config as you push.");
>>  
>> -void create_branch(struct repository *r,
>> -		   const char *name, const char *start_name,
>> -		   int force, int clobber_head_ok, int reflog,
>> -		   int quiet, enum branch_track track)
>
> This seems to have the same parameters as the "+" version, but wrapped
> differently - don't rewrap unless you're also changing it.

Ah, I didn't realize it had rewrapped. Thanks for the catch.

>> +/**
>> + * DWIMs a user-provided ref to determine the starting point for a
>> + * branch and validates it, where:
>> + *
>> + *   - r is the repository to validate the branch for
>> + *
>> + *   - start_name is the ref that we would like to test. This is
>> + *     expanded with DWIM and assigned to out_real_ref.
>> + *
>> + *   - track is the tracking mode of the new branch. If tracking is
>> + *     explicitly requested, start_name must be a branch (because
>> + *     otherwise start_name cannot be tracked)
>> + *
>> + *   - out_oid is an out parameter containing the object_id of start_name
>> + *
>> + *   - out_real_ref is an out parameter containing the full, 'real' form
>> + *     of start_name e.g. refs/heads/main instead of main
>> + *
>> + */
>> +static void dwim_branch_start(struct repository *r, const char *start_name,
>> +			   enum branch_track track, char **out_real_ref,
>> +			   struct object_id *out_oid)
>
> [snip]
>
>> @@ -401,7 +410,34 @@ void create_branch(struct repository *r,
>>  
>>  	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
>>  		die(_("Not a valid branch point: '%s'."), start_name);
>> -	oidcpy(&oid, &commit->object.oid);
>> +	if (out_real_ref)
>> +		*out_real_ref = real_ref ? xstrdup(real_ref) : NULL;
>
> I think you can just write "*out_real_ref = real_ref; real_ref = NULL;"
> here, and then not need to xstrdup.

Hm, you are right. The xstrdup was added because the original function
calls FREE_AND_NULL(real_ref) and then checks if real_ref is NULL. But
after the refactor, real_ref is not referenced after the
FREE_AND_NULL(real_ref), so that call can be removed.

I intend to remove the xstrdup, though it will introduce a bit of noise
because that block will no longer be moved wholesale.
