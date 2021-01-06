Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C1CC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20FC2310D
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 15:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbhAFPkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 10:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFPkv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 10:40:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10FC06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 07:40:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g185so2986906wmf.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 07:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BterJfKyn7GVjX8dS3RcT2YiZnieSHyTuoQse1BmPhg=;
        b=Yri2BBE/oabk7R5JKNtpmmnWVMhyILDgV8VXssk4Yhjuq5ZfBl90kv92kEaLbsprZJ
         d15yWiMbA2VwcHvowtirmjKd8JsmT7ZC+Og53Ox0FLJjJfCwvYb5nBFbZ+6d0l/wzVIc
         C2wyjwqe9wX7LHJp+8ki5zc0eZb8pdbp/N0f5BzgFQvnFpfRlw/hDTf+CA2uokuRZYYx
         pK53PI7VB0TpgHwxRMc2huwBOB3Gv792VPascq5LN92lqKfjWxeQyqsrCnzoKvbt5yIK
         z6rPrtH/BDfZAYAcdV6vKSzX2D3pnGPEAyX/3F1FDoIWiP8QJzWrF966Q3Jm55KqKL0n
         JOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BterJfKyn7GVjX8dS3RcT2YiZnieSHyTuoQse1BmPhg=;
        b=IwQjeBWspjOyvXQy2+IEXNq4PSQPosBjMQ8vb9yD/wH7jS5o63wBVNxzx0dqSujj0X
         0XNA98v+yjjgIeQ8sY+rixd6ofMybZrkBeMMhK3uTrojAsiqN6ZCvKBvhVKpT4G/mbYl
         txqgm3afK8ddgdZ9JciQ3tifraj96MIABr+2bkVJPf+uF43gwWNfoOBFTJFEf8qdfArI
         7s/Rr3q6P9SupkV8Q0f7tSLRA8aFiZ5dPM0FO9BDGb3peAbsghNGua15nguFK1YJVvkK
         IkL+qxQKrv24xgcPp3a1fnpudWxl9kXt8GBMxGuPhYL0kv0bkW1jc4Mx90bK9O+q4tJm
         39hw==
X-Gm-Message-State: AOAM532fY2BlbPz2ac8B2X/U++WxwRS+Pjz+V8mSjRb8bvAhelpG9Qzm
        5MtAGigfPv/nVPwJiyfTU6uYLPXzrHo=
X-Google-Smtp-Source: ABdhPJyzNHgJxTZwimqrzveFC97XgImy+AD29czuXx1eQJpnqwRpuAnHTElNsd+hVbdVimLz37pIxg==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr4250049wmc.39.1609947609595;
        Wed, 06 Jan 2021 07:40:09 -0800 (PST)
Received: from [192.168.1.240] (183.252.189.80.dyn.plus.net. [80.189.252.183])
        by smtp.gmail.com with ESMTPSA id h20sm3844964wrb.21.2021.01.06.07.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 07:40:08 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug report: git rebase ignores different context, resulting in
 subtle breakage
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        git@vger.kernel.org
Cc:     Daniel Stone <daniel@fooishbar.org>
References: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <502b710e-6347-5fa7-0461-21a84ae2250d@gmail.com>
Date:   Wed, 6 Jan 2021 15:40:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michel

Sorry for the slow response, this fell through the Christmas cracks.

On 14/12/2020 14:37, Michel Dänzer wrote:
> 
> (Originally reported as a GitLab issue: 
> https://gitlab.com/gitlab-org/gitlab/-/issues/292754)
> 
> 
> All output below is from Debian git 2.29.2-1.
> 
> 
> The following branches of 
> https://gitlab.freedesktop.org/daenzer/mesa.git can be used to reproduce:
> 
> gitlab-issue-292754/pre-rebase (pre-rebase state)
> gitlab-issue-292754/base (new base)
> gitlab-issue-292754/bad-rebase (bad post-rebase state)
> 
> 
> The pre-rebase commit b9f18d0ddb6b075819bc2c6b9fa36dee483ef443 contains 
> this (truncated) hunk:
> 
> @@ -480,13 +491,9 @@ sanity:
> 
>     rules:
> 
>       - if: *is-pre-merge
> 
>         when: on_success
> 
> -    - if: *is-forked-branch
> 
> -      when: manual
> 
>       # Other cases default to never
> 
>     script:
> 
>       # ci-fairy check-commits --junit-xml=check-commits.xml
> 
> 
> 
> The new base commit f20153536087079f39f1ab9995ac3d36dd3c467f contains 
> this hunk:
> 
> @@ -484,10 +484,8 @@ sanity:
> 
>       - .fdo.ci-fairy
> 
>     stage: sanity
> 
>     rules:
> 
> -    - if: *is-pre-merge
> 
> +    - if: *is-forked-branch-or-pre-merge
> 
>         when: on_success
> 
> -    - if: *is-forked-branch
> 
> -      when: manual
> 
>       # Other cases default to never
> 
>     variables:
> 
>       GIT_STRATEGY: none
> 
> 
> 
> Both remove the same 2 lines, but the context is different both before 
> and after those lines.
> 
> My expectation for this case would be that
> 
>   git rebase gitlab-issue-292754/base gitlab-issue-292754/pre-rebase
> 
> fails with a conflict. However, it succeeds without any indication of 
> trouble, resulting in these contents in commit 
> 4e549e1ac3354f465d8afe0174902e62143a6ff4:
> 
>     rules:
> 
> 
>      - if: *is-forked-branch-or-pre-merge
> 
> 
>         when: on_success
> 
> 
>       # Other cases default to never
> 
> 
>     variables:
> 
> 
>       GIT_STRATEGY: none
> 
>     script:
> 
> 
>       # ci-fairy check-commits --junit-xml=check-commits.xml
> 
> 
> I.e. identical to the new base.

This looks like the correct merge to me as the changes in the original 
commit are already in the new base. Rebase has detected that the context 
lines do not match and used a 3-way merge instead of a simple patch 
application. This matches the behavior of the merge based rebase backend 
which is the default in recent versions of git. Git tracks content not 
changes and so rebasing a branch means cherry-picking each commit onto 
the rebased version of it's parent, not applying each patch on top of 
the new base.

Best Wishes

Phillip


> However, the 2 removed lines had a different effect in the original 
> pre-rebase context, and the post-rebase state no longer matches the 
> original intention. git rebase silently introduced a subtle bug.
> 
> 
> git rebase --apply results in this output:
> 
>   First, rewinding head to replay your work on top of it...
> 
>   Applying: ci: Run sanity job only in pre-merge pipelines
> 
>   Using index info to reconstruct a base tree...
> 
>   M    .gitlab-ci.yml
> 
>   Falling back to patching base and 3-way merge...
> 
>   Auto-merging .gitlab-ci.yml
> 
> 
> Looks like the applying strategy does detect the conflict, but there's 
> an automatic fallback to the merging strategy, which again succeeds 
> (with the same broken result).
> 
> 
> The only way I've found to avoid the broken behaviour is git rebase -s 
> octopus [...]:
> 
>   error: could not apply b9f18d0ddb6... ci: Run sanity job only in pre
>   merge pipelines
> 
>   Resolve all conflicts manually, mark them as resolved with
> 
>   "git add/rm <conflicted_files>", then run "git rebase --continue".
> 
>   You can instead skip this commit: run "git rebase --skip".
> 
>   To abort and get back to the state before "git rebase", run "git rebase
>   --abort".
> 
>   Could not apply b9f18d0ddb6... ci: Run sanity job only in pre-merge
>   pipelines
> 
> 
