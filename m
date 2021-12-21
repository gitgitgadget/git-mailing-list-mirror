Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FCC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 13:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhLUNqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhLUNqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 08:46:01 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43E0C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:46:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q25so21048551oiw.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GLU/i3zPKgP2OnxsUXa/3nBOV0fdIF/kJaTSNBEwC8o=;
        b=ng2jzR1W59KUzWJ7QCfZZDNIeUz1Kj+71UV0VyAInrQ6cZJIJaUsDf6JFyE4jNuxTp
         C2UbvCqaOlpZwx6YV21i81HbFAvrpNwluRT1LXquyCqsPLUtsKaN8x57qaqRIhHf88cv
         ibD16GODmZQNVjDsqIwdZLTh2FJRPS5zxA/TJ0rRZBMBrovxqQOUKQ5t/+JjqC1ec09l
         vfSNdnEcCw2IdhnMzSqvAzhIPdN7vyORpBZvgShDYEpl97keDaqkk6ywcZlm07jTMzWa
         liS16SQiPlFbpxwT0x7K+x5iVz+TPSIrzFfeQokVyBE2TQN8gZBABRVTQAQOvDZCmwNN
         SNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GLU/i3zPKgP2OnxsUXa/3nBOV0fdIF/kJaTSNBEwC8o=;
        b=mqnY6ICb2SGuMZXBZAL7qWp+I6W/1ehP7gJw/tT7gnjXzpqmxaFTibFcQ5oVFCMdGY
         oziEjqxrkeMO0sjb96I7s3FbkXkDbJj27uLXc8ZKEaNhlkgOC1UrcYeRM8S8m8pXzc3y
         iO8dO7zJ5/MY8YuywIT3gljwONuzUeaN0lL7YctifrQju/bO1C6dAsvFskd5K9n4kf9b
         NueTfWDqY1IgW0a1RfN3LVj9TSSBhiRQR6e3ZvhmOysMUBLslVsfHIOWHiI0gaMhy/p1
         8uddn4BJzIcOFRFSSRtg/vq4fb0+FmTlrfrKkdyWS7L1mGwg4UIS3DBX9K20zxwGUF16
         oX8A==
X-Gm-Message-State: AOAM533EghKTCYgpBZa1rAVJAvjaJGZo0s9BlM3GEW4naSdLQT0hLJtL
        m/mHtq0rQXo+heH0uAkLsb0=
X-Google-Smtp-Source: ABdhPJwFoE9LYMA33bYA90hDyGHOsQyFrdOIoY+1S6mPptjTJ/3zxn1iT3ILU54k4Yvagv1+bGiiqg==
X-Received: by 2002:a05:6808:1201:: with SMTP id a1mr2433858oil.153.1640094360578;
        Tue, 21 Dec 2021 05:46:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c11c:699d:989:f926? ([2600:1700:e72:80a0:c11c:699d:989:f926])
        by smtp.gmail.com with ESMTPSA id n26sm3492964ooq.36.2021.12.21.05.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 05:45:59 -0800 (PST)
Message-ID: <c8c995d3-c73c-6b3f-8d5c-f1411abd56e9@gmail.com>
Date:   Tue, 21 Dec 2021 08:45:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] config: add repo_config_set_worktree_gently()
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
 <CAPig+cT=evew0iePP-TZ+DTJ=oY6hrjiOiDtYqEr6KLRvkqC9Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cT=evew0iePP-TZ+DTJ=oY6hrjiOiDtYqEr6KLRvkqC9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/2021 12:53 AM, Eric Sunshine wrote:
> On Mon, Dec 20, 2021 at 10:57 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> When adding config values to the worktree config, we might enable the
>> extensions.worktreeConfig setting and create the config.worktree file
>> for the first time. When the base repository is bare, this creates a
>> change of behavior for determining if the worktree is bare or not. A
>> worktree off of a bare repository is assumed to be non-bare when
>> extensions.worktreeConfig is disabled. When extensions.worktreeConfig is
>> enabled but config.worktree is empty, the worktree is considered bare
>> because the base repo's core.bare=true setting is used.
>>
>> To avoid issues like this, create a helper that initializes all the
>> right settings in the correct order. A caller will be added in the next
>> change.
> 
> As discussed already in [1], [2], and [3], the solution implemented by
> this patch is undesirable, and I gave an outline in [4] about how I
> think the new utility function ought to be implemented instead, so I
> won't say anything further about that here. However, I do still have
> one or two review comments to make about the general approach taken by
> patch. See below...
> 
> [1]: https://lore.kernel.org/git/CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cTVzMtiHzkJq7VRg4Xa3xhrq7KKCdK5OSDY6bvwKu_ynA@mail.gmail.com/
> [3]: https://lore.kernel.org/git/6d72a020-ded7-6ef2-825c-ce6421194b26@gmail.com/
> [4]: https://lore.kernel.org/git/CAPig+cTuLYFc9fpAe8Uq9fvBYuSGcc9SA1O-q1BRw0DYxDF4Eg@mail.gmail.com/
> 
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/config.c b/config.c
>> @@ -2880,6 +2880,33 @@ int git_config_set_gently(const char *key, const char *value)
>> +int repo_config_set_worktree_gently(struct repository *r,
>> +                                   const char *key, const char *value)
>> +{
>> +       int res;
>> +       const char *config_filename = repo_git_path(r, "config.worktree");
>> +
>> +       /*
>> +        * Ensure that core.bare reflects the current worktree, since the
>> +        * logic for is_bare_repository() changes if extensions.worktreeConfig
>> +        * is disabled.
>> +        */
>> +       if ((res = git_config_set_multivar_in_file_gently(config_filename, "core.bare",
>> +                                                         r->worktree ? "false" : "true",
>> +                                                         NULL, 0))) {
>> +               error(_("unable to set core.bare setting in worktree config"));
>> +               return res;
>> +       }
>> +       if (upgrade_repository_format(r, 1) < 0)
>> +               return error(_("unable to upgrade repository format to enable worktreeConfig"));
>> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
>> +               error(_("failed to set extensions.worktreeConfig setting"));
>> +               return res;
>> +       }
>> +
>> +       return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, 0);
>> +}
>> diff --git a/config.h b/config.h
>> @@ -253,6 +253,12 @@ void git_config_set_in_file(const char *, const char *, const char *);
>> +/**
>> + * Write a config value into the config.worktree file for the current
>> + * worktree. This will initialize extensions.worktreeConfig if necessary.
>> + */
>> +int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
> 
> I understand your desire to make this "setter" function as transparent
> and simple for clients as possible, however, I think it does too much
> by conflating two very distinct operations (one which changes the
> nature of the repository itself, and one which simply sets a config
> variable), and is far too magical. It doesn't help that the function
> name gives no indication of just how magical it is, and it is easy to
> imagine people calling this function thinking that it's just a simple
> "config setter" like all the other similarly-named functions, without
> realizing the impact it may have on the repository overall (i.e.
> upgrading to version 1 and changing to per-worktree config).
> 
> I would feel much more comfortable for the new utility function to
> have a single-purpose: namely, to upgrade the repository to a
> per-worktree configuration mode (if not already upgraded) as outlined
> in [4]. That's it. It shouldn't do anything other than that. This way,
> callers which need per-worktree configuration must call the new
> function explicitly to obtain the desired behavior, rather than
> getting per-worktree configuration as a magical and implicit
> side-effect of calling what looks like a plain old "config setter".
> This should make it easier to reason about. Taking this approach also
> means that you don't need to introduce a special-purpose "config
> setter" just for worktrees; instead, you'd use the normal existing
> "config setter" functions. For instance, if the new utility function
> is named enable_per_worktree_config(), then `git sparse-checkout init`
> might do something like this:

I understand your desire to separate these concerns, and maybe there
is value in having another method that _just_ does the "upgrade to
worktree config". However, if we don't also create this helper method
for setting worktree-specific config, then we are going to hit this
issue again.
 
>     enable_per_worktree_config(r);
>     config_path = repo_git_path(r, "config.worktree")
>     git_config_set_in_file_gently(config_path, "core.sparseCheckout", ...);
>     git_config_set_in_file_gently(config_path, "core.sparseCheckoutCone", ...);
> 
> (This, of course, assumes that repo_git_path() latches the changes
> made by enable_per_worktree_config() so that it "does the right
> thing", but it seems that existing code in `git sparse-checkout init`
> is already expecting it to do so, so perhaps it does work that way.)

If we expect every caller that assigns config to the worktree to follow
this sequence of events, then we should encapsulate that in a method so
developers can discover it and call it instead of needing to write these
lines over again. Just repeating the literal "config.worktree" in
multiple places is enough justification for making a helper, let alone
these more subtle issues around bare repos and non-bare worktrees.

The helper method will need clear documentation to say "this will upgrade
the repository format and add extensions.worktreeConfig" so those new
consumers are aware of the full functionality.

Thanks,
-Stolee
