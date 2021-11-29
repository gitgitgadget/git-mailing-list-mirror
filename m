Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4621C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhK2WdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhK2Wc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:32:56 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F77C08ED86
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:57:49 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so5901652ood.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+ZEpsUKlk2gqn41c5A0HPnTZos4CNq2n2qVPz9thbiI=;
        b=IqADuHHF1wtALh6TiA8qS+tlpxEgSQdbuDR4evpOkMIdM85DMtnZwavH/63J7DiQbM
         kbksr0G3U/Ypl5wHeGH0yA4sxddUlIsyevuAyJehh+6GeME/5qso8yVFXhVQhInAXM93
         +ZBP5bDYNqaVAyPUwgUHvlHioPyEDnwrfic6JZOcXbkl+3tlO21uyY2BAXnFHlB/ogdq
         IZc+8ZBnAweWmeCn76JYyEQABaTnvjbAi64GzfBIlMA+senUcCRjusHc4hxdnDF5A5at
         cMh7bZsob2qAzM5WIH/KMLkcCA8DVcGaxEz9CjzPNeWfY+NVpxLqQjSc2m5kjpwM8VIh
         ASKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+ZEpsUKlk2gqn41c5A0HPnTZos4CNq2n2qVPz9thbiI=;
        b=QkGYMfvbi9pFclv1xXz1KLT4CBIpL5LxFhrrwn4MjdznpiXjYV9SVOCr1xa9m+wlOH
         YzZlUUeMhERDEN+AGBqiswJ9DyIZykW9/HO2dp6TMGCKk9LZ0lGJHQnh4aUjIIzLhm5x
         Q+QgmPO8PKZz/AotcVE7CGbK63m6VKsBNmMdhR0qZLevwjwvnFMRCv+KSNbPWgQCupEP
         hpS0CXhizNJaKRczrj3iPObi1MQvO+z097RfcnEBTENuIWbgqbIvgYcn7pGq6BOML9Ew
         1s3QmPGKFbwBrdjB3RDhjDevleEfGOxzOm7dsJm5CpfV8QcBHrWhwPVHwbqQDB6jhewK
         Q0uA==
X-Gm-Message-State: AOAM531HT0QuXklys4MPsLVqGPmUHNdQt6cqAg0jBl9dJ5KieNg9iqg9
        LKQVIzwWugUg6Ykrgkx4gLReSvdN/B0=
X-Google-Smtp-Source: ABdhPJw16XVO8HIfppJzRQDEycGdJdSPOKLW7u+nAIb8K0YzD98Iwp+l31iECZcT3+3I8b2kFyJzNw==
X-Received: by 2002:a4a:8515:: with SMTP id k21mr32167110ooh.71.1638208668976;
        Mon, 29 Nov 2021 09:57:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id j5sm2750595ots.68.2021.11.29.09.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:57:48 -0800 (PST)
Message-ID: <39e2bc15-298c-0932-109b-e92da3979dc2@gmail.com>
Date:   Mon, 29 Nov 2021 12:57:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 00/11] Avoid removing the current working directory,
 even if it becomes empty
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2021 5:40 PM, Elijah Newren via GitGitGadget wrote:
> Traditionally, if folks run git commands such as checkout or rebase from a
> subdirectory, that git command could remove their current working directory
> and result in subsequent git and non-git commands either getting confused or
> printing messages that confuse the user (e.g. "fatal: Unable to read current
> working directory: No such file or directory"). Many commands either
> silently avoid removing directories that are not empty (i.e. those that have
> untracked or modified files in them)[1], or show an error and abort,
> depending on which is more appropriate for the command in question. With
> this series, we augment the reasons to avoid removing directories to include
> not just has-untracked-or-modified-files, but also to avoid removing the
> original_cwd as well.

As I was reviewing v2, this version popped up in my inbox. Sorry about that.

The only actionable comment from my review of v2 was the addition of a check
that the worktree is in the expected state after commands are aborted due to
trying to remove the current working directory. Your suggested

	git diff --exit-code HEAD

should work for this. I might even add a "git rev-parse HEAD" to make sure
we are on the right ref, but that's perhaps too specific to something like
'git reset --hard <branch>'.

> Changes since v2:
> 
>  * the series is now only about the working tree. So if the original cwd is
>    outside the worktree (or we're in a bare repo), then the new code is a
>    no-op.
>  * fixed ugly early die() possibility (uses strbuf_getcwd() instead of
>    xgetcwd())
>  * modified the initial tests to show both expected and desired behavior.
>    subsequent patches fix the tests. One new patch added at the end which
>    simplifies the tests to only check for desired behavior.
>  * NULLify startup_info->original_cwd when it matches the toplevel worktree;
>    that is already protected and we don't need secondary protection for it.
>    This simplified some other codepaths so we don't have to check for
>    startup_info->original_cwd == "".
>  * clarified some commit messages

Looking at these changes I like all of them.

> Range-diff vs v2:
> 
>   1:  38a120f5c03 !  1:  4b0044656b0 t2501: add various tests for removing the current working directory

I like this new test structure. Using test_expect_success to document existing
behavior is a good strategy.

>   2:  f6129a8ac9c !  2:  200ddece05d setup: introduce startup_info->original_cwd>   3:  e74975e83cc !  3:  68ae90546fe unpack-trees: refuse to remove startup_info->original_cwd
>   4:  e06806e3a32 !  4:  1bb8905900c unpack-trees: add special cwd handling
>   5:  46728f74ea1 !  5:  8a33d74e7cf symlinks: do not include startup_info->original_cwd in dir removal
>   6:  01ce9444dae !  6:  11e4ec881bb clean: do not attempt to remove startup_info->original_cwd
These changes looked good.

>   -:  ----------- >  7:  39b1f3a225e rebase: do not attempt to remove startup_info->original_cwd

I had a small comment on this one, only because I think there is a condition
in your 'if' statement that is either unhelpful or is hiding something.

>   7:  edec0894ca2 !  8:  0110462a19c stash: do not attempt to remove startup_info->original_cwd
...
>        			cp.git_cmd = 1;
>       +			if (startup_info->original_cwd &&
>      -+			    *startup_info->original_cwd &&
>       +			    !is_absolute_path(startup_info->original_cwd))
>       +				cp.dir = startup_info->original_cwd;

And here is a similar use of is_absolute_path() that could be resolved the
same way as whatever you choose for the v3 patch 7.

>   8:  1815f18592b !  9:  2c73a09a2e8 dir: avoid incidentally removing the original_cwd in remove_path()
>   9:  adaad7aeaac ! 10:  d4e50b4053d dir: new flag to remove_dir_recurse() to spare the original_cwd
>   -:  ----------- > 11:  7eb6281be4b t2501: simplify the tests since we can now assume desired behavior

This last test cleanup is good to have.

Thanks,
-Stolee
