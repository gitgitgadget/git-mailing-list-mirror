Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5704BC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 00:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310D761284
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 00:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhKLAsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhKLAsp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 19:48:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637FC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 16:45:55 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mv1-20020a17090b198100b001a67d5901d2so3795490pjb.7
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 16:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Opwhgg+j3eNDvjAUQJkivNtWoDFi3uo6dF1D5ltA5cM=;
        b=F99b22y3gPNqGGFXardb8aiIgM9SUYeArVDoqUQ7jhYhM5zpbOR9gcNWirnlVg4cvf
         3HVidvWpaSeLkDEHNebv7QmoZXRules1IaAZpE+tzTyYrNLWxorF5LBRGOWWdJKGW7zH
         +wuqNCjFRjs6s3hi7aMseDdeHcI1nTLCQRawZpCGoFNY6fWoOhigP+jfELEalUEhdD+1
         OZO71y9py56jx5rR7CoIJiV3HC57TBHbX0sYsYz0bPyNUaW/WheGm0D3/38Nvdlwib3O
         v19oDt2u+eMHb0dwCIxpntegPueZHuoyEXtEgvrmbzYxB1WD+36DrkxOVKyMwcVgGWmV
         86tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Opwhgg+j3eNDvjAUQJkivNtWoDFi3uo6dF1D5ltA5cM=;
        b=jYavdP+Dl6eq01AdEQFDCrs5Xx3lALoTfngtR3AJCYkTmOUURaEgs23KJDHcK7dzv+
         aRleWaNXx8IZVI1dpsdUhTVK55Rpy9z8W9yr+j0U+TZzGux4bcXZm8e4YHIqoWDHVZJX
         U65xPyKSfH036DXBIl0Ht9JFn5Cq+0MZ97s0QK7dhk+5kO75z6hOp2G9gv/NWbdcfzDL
         HzrmV8L9DPZvq2fsgWD6pshSYOOHjI2yRkTF7age600rFEEi6nsyY7WceJW1oCc5ajHb
         RlZIKm7EEaQm2AFoPSIcjIkLAIDS+8R9qB+yw3vBooU2DALqNlFJFCN/yjBSSj8cczMe
         aWhw==
X-Gm-Message-State: AOAM531jCb4yjQd/niRuxFXTFW7XA383uP4U26d8xDmoPTOBmFx+rWzI
        YjIQmLeAeSHsEOTmBLtZm/Iu5NR14zi9QQ==
X-Google-Smtp-Source: ABdhPJxWFZUL7hrmxqrMbXFRd/7GoXQUuwdf+KiL3lfDEp8NnIcuxgaJ3FIaX7ix88tI8TlSrSPb8LwFNdwY1w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:7085:: with SMTP id
 g5mr31156210pjk.124.1636677954985; Thu, 11 Nov 2021 16:45:54 -0800 (PST)
Date:   Thu, 11 Nov 2021 16:45:52 -0800
In-Reply-To: <xmqq7ddel9te.fsf@gitster.g>
Message-Id: <kl6lv90ytd4v.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: Re: [PATCH v1 2/3] config: introduce repo_config_set* functions
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> We have git_config_set() that sets a config value for the_repository's
>> config file, and repo_config_get* that reads config values from a struct
>> repository. Thus, it seems reasonable to have to have
>> repo_git_config_set() that can set values for a config file of a struct
>> repository.
>>
>> Implement repo_config_set() and repo_config_set_gently(), which
>> take struct repository. However, unlike other instances where struct
>> repository is added to a repo_* function, this patch does not change the
>> implementations of git_config_set() or git_config_set_gently(); those
>> functions use the_repository much deeper in their call chain through
>> git_pathdup(). Mark this inconsistency as NEEDSWORK.
>
> Being able to only affect "config" in the_repository->gitdir is less
> flexible than being able to affect "config" in repo->gitdir for any
> repository is good.  Do we need a similar thing for repo->commondir
> as well?

git_config_set() can only affect repo->gitdir, so from the perspective
of "what should a repo_* variant of git_config_set() do", then no, we do
not need a similar thing. As far as I can tell, config.c only works with
the gitdir, not the commondir.

I cannot comment on whether we will ever need to set config values in
the commondir.

> Many questions:
>
>  - What do these do for an existing key?  Add another value?
>    Replace existing one?  If the latter, what do we plan to do with
>    multi-valued keys?

For an existing key, this should replace the first instance found.
This eventually calls of git_config_set_multivar_in_file_gently() with
value_pattern=NULL, flags = 0. According to the comments:

 * if flags contains the CONFIG_FLAGS_MULTI_REPLACE flag, all matching
 *     key/values are removed before a single new pair is written. If the
 *     flag is not present, then replace only the first match.

We pass flags=0, so only the first instance is replaced.

 * - [value_pattern] as a string. It will disregard key/value pairs where value
 *   does not match.

We pass value_pattern=NULL, so we consider all instances.

>  - Don't we need an interface to remove, rename, etc.?

This function supports 'remove' by passing value=NULL. By rename, I
believe you're referring to renaming a config section, e.g. a repo_*
version of git_config_copy_or_rename_section_in_file()?

I think this is warranted if we perform a full plumbing of struct
repository through config.c. But I think it would be prudent to do this
plumbing piecemeal - perhaps starting with "set", and then proceeding to
the other operations. 

>  - If we call repo_config_set(repo, "key", "value") and then call
>    repo_git_config_string(repo, "key", &value) on the same
>    repository, do we read the value back or do we give a stale
>    value?

We read the correct value if repo == the_repository but we do not if r
!= the_repository. Thanks for spotting this bug.

I believe your concern comes from the fact that struct repository
caches config values in repo->config and thus we are not guaranteed to
read the value back from the file. Following this train of thought, we
can see that git_config_set_multivar_in_file_gently() clears the cache
for the_repository, by calling git_config_clear(). Because this is
hardcoded to the_repository, git_config_set_multivar_in_file_gently()
cannot be safely called from repo_config_set() and my implementation is
buggy.

>  - A change like this should make existing config_set() that only
>    works on the_repository into a thin wrapper, e.g.
>
> 	void git_config_set(const char *keyu, const char **value)
> 	{
> 		repo_config_set(the_repository, key, value);
> 	}
>
>    But that is not happening here.  What prevents us from doing so?

I think it is _possible_, as long as we plumb struct repository through
the call chain all the way to git_config_set_multivar_in_file_gently().

I didn't do so because I thought that I had an implementation of
repo_config_set() without introducing a major overhaul of config.c.
Because it is an alternative implementation, I decided not to replace
the existing one.

However, as noted above, this alternative implementation is wrong
because git_config_set_multivar_in_file_gently() makes use of
the_repository (i.e. I didn't read the function carefully enough).

I will attempt this plumbing, which will allow us to make
git_config_set() a thin wrapper. However, if this turns out to be too
difficult, I will implement branch --recurse-submodules with child
processes and leave this for a future clean up (as hinted at in the
cover letter).
