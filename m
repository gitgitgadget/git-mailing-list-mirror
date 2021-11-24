Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B9CC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 00:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhKXAzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhKXAzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 19:55:48 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CE0C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 16:52:39 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a16-20020a17090aa51000b001a78699acceso2332631pjq.8
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 16:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dw1+gHemo75yZ4yD8iEL9VgFEYOB4MkHBWtk1AKekiI=;
        b=fQjLY3JxF6mfavfGCMHfVCJSUCfEJaV4rbV8VFvrQA9w+HzCcEzE4cYd/QBr/pUi2X
         /STa2kiQGxO+0V6WlmUHjs7zEtjYKEi9IkccxD8e9y8A2K1sXdNky9mrf9ZowOt1luXL
         U2EEGnEGSN66LDlfEEkhn+z6bCA3sEOjLXPlxFQR07rcbrHwdS6Zf+KUicCCGaXigPdK
         3hAl4H9l0fwT+vy8gdJZ+U6dV1HyRqdc5eEK2oj+uF8Ivh18b0rpBIi6MzRAHvJoEFQR
         5w/FuBaYL9yRr1mC1PcsacxvmWjJABIL7L0VzUaT2c69XHnNfH0TN1OrPe/eO7G9SOms
         dlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dw1+gHemo75yZ4yD8iEL9VgFEYOB4MkHBWtk1AKekiI=;
        b=Tvns1YM0LBrPCFTXq8VLT7VxoBLyz6tZVGhJ/nGj31L25505aPgFJFIDMfqoypyxY0
         Sa0XvMAJDegRZeHqjqqXTVivUBGgdvi6lqlPYQjCZITWQHPTQcRHHnXujIbHdcpefEms
         kHOSOyKh6dVKJltwTys9JDlxAmlxHlwApTSdPhTvGTB48sf1gTeOg0anmDIfPF3xilEL
         MC1a45ygrd4mfVhR0g6RcsKnLPr42ccPxTX4ZqAalqfsfuuQONOCSVgIq+AgAWSWWuuH
         fXqMubIUYZ7PGVfPMqPSdVt5SFKmk4GElXdw2NkK44qnwOjdhWx14OhrK20OdMDnT1cA
         lSzQ==
X-Gm-Message-State: AOAM531ESAgEv9Y0jCQOWme3dGSFz8Q0hp3+K+28qGSXLkN4UGcdvgCy
        ynXDyLheSbJeyhsf0biiy4VvG7wlL54f3A==
X-Google-Smtp-Source: ABdhPJx8ZydoxmEOAOCl0eW6Ok78PDMr1KPodIDJyipSJHNu6BdGLFd+xNVkuh+prZQzSABJIAlfitxbJSc9YQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8f94:b0:143:8e81:3ec1 with SMTP
 id z20-20020a1709028f9400b001438e813ec1mr12569384plo.52.1637715158939; Tue,
 23 Nov 2021 16:52:38 -0800 (PST)
Date:   Tue, 23 Nov 2021 16:52:37 -0800
In-Reply-To: <20211123231035.3607109-1-jonathantanmy@google.com>
Message-Id: <kl6lr1b6tlwq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-4-chooglen@google.com> <20211123231035.3607109-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/4] branch: add --dry-run option to branch
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> When running "git branch --recurse-submodules topic"
>
> At this point, this argument has not been introduced yet, so better to
> just say "A future patch will introduce branch creation that recurses
> into submodules, so..."
>
>> +-n::
>> +--dry-run::
>> +	Can only be used when creating a branch. If the branch creation
>> +	would fail, show the relevant error message. If the branch
>> +	creation would succeed, show nothing.
>
> Right now we only plan to use this internally so it's not worth using a
> single character argument for this right now, I think. We can always add
> it later if we find it useful.

For the reasons you specified, I didn't intend to add -n. However, -n is
automatically added by OPT__DRY_RUN, so I thought it was appropriate to
document it.

>> -	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
>> -	    list + edit_description + unset_upstream > 1)
>> +	create = 1 - (!!delete + !!rename + !!copy + !!new_upstream +
>> +		      !!show_current + !!list + !!edit_description +
>> +		      !!unset_upstream);
>> +	if (create < 0)
>>  		usage_with_options(builtin_branch_usage, options);
>
> Hmm...I think it would be clearer just to call it noncreate_options and
> print usage if it is greater than 1. Then whenever you want to check if
> it's create, check `!noncreate_options` instead.

Sounds good.

>> @@ -852,10 +862,20 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  		if (track == BRANCH_TRACK_OVERRIDE)
>>  			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
>>  
>> -		create_branch(the_repository,
>> -			      argv[0], (argc == 2) ? argv[1] : head,
>> -			      force, 0, reflog, quiet, track);
>> +		if (dry_run) {
>> +			struct strbuf buf = STRBUF_INIT;
>> +			char *unused_full_ref;
>> +			struct object_id unused_oid;
>>  
>> +			validate_new_branchname(branch_name, &buf, force);
>> +			validate_branch_start(the_repository, start_name, track,
>> +					      &unused_oid, &unused_full_ref);
>> +			strbuf_release(&buf);
>> +			FREE_AND_NULL(unused_full_ref);
>> +			return 0;
>> +		}
>> +		create_branch(the_repository, branch_name, start_name, force, 0,
>> +			      reflog, quiet, track);
>>  	} else
>>  		usage_with_options(builtin_branch_usage, options);
>>  
>
> I don't think we should use separate code paths for the dry run and the
> regular run - could create_branch() take a dry_run parameter instead?
> (If there are too many boolean parameters, it might be time to convert
> some or all to a struct.)

That sounds reasonable, it would be good not to have duplicate code
paths.

> This suggestion would require a reworking of patch 2, which is why I
> didn't comment there. But if we are not going to use this suggestion and
> are going to stick with patch 2, then my comment on it is that it seems
> to be doing too much: I ran "git show --color-moved" on it and saw that
> quite a few lines were newly introduced (not just moved around).

I will do the reworking, but the final result will probably look very
similar to the one in patch 2. Does it look more acceptable with
--color-moved-ws=ignore-all-space? Some text had to be reindented
(because I removed one conditional), but I also replaced some functions
with repo_* versions.
