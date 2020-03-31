Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B712C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A75C20848
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 11:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3HhGtnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgCaLzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:55:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43391 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaLzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 07:55:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id o10so22542508qki.10
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6J7mUrOWHSoiMGyDo7WhPZBGyHk42WOJO1xXRvuAqrE=;
        b=s3HhGtnvDYacRAI8UPRcGP19+f5jPd/xSBV3YXN2QDYnklUm8wnewqR4EOYqcB+a2c
         wreiI96h6XIGPIpMeQzJlq2s/e/XDWljGffrJIu6aXf3iVdcqlF5ZRi+ZKSej7c/AmIo
         AtFQZCH0I7mKDImRr+Jro7e9BnnNc3zooZt9GiMq8n6kpHzx6Q+USGDJ2+pPGyJlndDL
         Z00PxlhfaeAQScY7J9Z6G+r8u0KzALAneweweh32EdJV6m03f2Njm8wl289YprrqXSaP
         gov5Wm/hXSyJrjXxdIbs3fJCzBKG5hGPQzT3QpExTtG9tVMCnOMOK8InY2Gobjh+0keY
         TyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6J7mUrOWHSoiMGyDo7WhPZBGyHk42WOJO1xXRvuAqrE=;
        b=d0KG09xC2/RBE+jFB85m1CGHAUFaEdwxKWkKBPZ5dTebVYx2tOJ3J+0ETaqZz1Jj6O
         82k2KJRDUXnw24HlgJvFig8/S4VnBxRjaccEPsxEqZ+ZPXoWXZu1jBz5t/21KEjrv7LE
         v40o26iPDhi7bfUzmlYLuDgyvAsN7potu0vqh0qJk3JUIIvRv1IVJXzRGLBPhKjUjhZI
         6ljnVohWimnb18WwjIxoYxv5C10ZP1IcaDKez7T6wsB9Xj641aqvgfnBnYGCQQ+jLf2i
         PMTUJVKol6R9Xwe+RwrVsvMFj03cQbSOcVgxiSviy6NL/SHRwNnglvOf3QlnEVOx8Dkb
         vd4Q==
X-Gm-Message-State: ANhLgQ2gn/7p7ZAlPRo51U+M1rW5zcYSczfll4U+bcjBAgcbIxuY8glt
        yF7RA9Ju1fqbp54+CQlVBLY=
X-Google-Smtp-Source: ADFU+vvpoJDM0+YHs4z3GQlpMAr7slm9AQM3SMdKCukDY05fd87ezvd9sFRYoQUU5EiWvwec1sJI0w==
X-Received: by 2002:a37:6848:: with SMTP id d69mr4412647qkc.191.1585655715597;
        Tue, 31 Mar 2020 04:55:15 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n67sm13235863qte.79.2020.03.31.04.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 04:55:13 -0700 (PDT)
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, newren@gmail.com,
        gitster@pobox.com
References: <e917f451-c00a-c819-7f78-888ba6e8f5ea@gmail.com>
 <20200330165705.134447-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f6f93f52-cb7a-f2cb-aa21-51b98044b654@gmail.com>
Date:   Tue, 31 Mar 2020 07:55:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200330165705.134447-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2020 12:57 PM, Jonathan Tan wrote:
>>> Add a flag to "git rebase" to allow suppression of this feature. This
>>> flag only works when using the "merge" backend.
>>
>> So this is the behavior that already exists, and you are providing a way
>> to suppress it. However, you also change the default in this patch, which
>> may surprise users expecting this behavior to continue.
> 
> First of all, thanks for looking at this.
> 
> I'm not changing the default - was there anything in the commit message
> that made you believe it? If yes, I could change it.

It's not your fault. My confusion is all. You make it very clear, but
I got flipped around several times while reading the patch. Here is
your message again:

> When rebasing against an upstream that has had many commits since the
> original branch was created:
> 
>  O -- O -- ... -- O -- O (upstream)
>   \
>    -- O (my-dev-branch)
> 
> it must read the contents of every novel upstream commit, in addition to
> the tip of the upstream and the merge base, because "git rebase"
> attempts to exclude commits that are duplicates of upstream ones. This
> can be a significant performance hit, especially in a partial clone,
> wherein a read of an object may end up being a fetch.

So by default, it "attempts to exclude commits that are duplicates of
upstream ones." So that's the --no-keep-cherry-pick option, which is
the default.

> Add a flag to "git rebase" to allow suppression of this feature. This
> flag only works when using the "merge" backend.

Perhaps this is how I got confused. "suppression of this feature" probably
got associated with the "--no-" version of the flag in my head. But that's
not your fault. I'm probably biased from my experience with the
--no-show-forced-updates flag in "git fetch". There, the "--no-" option
disables the default behavior.

Maybe I wouldn't be as confused if the flag was reversed and called
"--no-skip-cherry-picks" or something. That direction would make it
more clear that this is a performance optimization with a possible
behavior side-effect. I doubt users will be lining up to "keep cherry-picks."
There is a reason we remove them by default, but it is also atypical
for the check to actually change the outcome.

But if we have a config option to change the default (as a follow-up)
then all of my complaints are reduced, because users will not need to
think about this very often.

> This flag changes the behavior of sequencer_make_script(), called from
> do_interactive_rebase() <- run_rebase_interactive() <-
> run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
> (indirectly called from sequencer_make_script() through
> prepare_revision_walk()) will no longer call cherry_pick_list(), and
> thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
> means that the intermediate commits in upstream are no longer read (as
> shown by the test) and means that no PATCHSAME-caused skipping of
> commits is done by sequencer_make_script(), either directly or through
> make_script_with_merges().

Perhaps the only change I would recommend for the commit message is to
be very clear about what "this flag" means. You are talking about the
"--keep-cherry-pick(s)" flag in this paragraph.

Thanks,
-Stolee
