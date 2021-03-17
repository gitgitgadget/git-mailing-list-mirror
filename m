Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918DEC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 05:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC0064FA7
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 05:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCQF1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 01:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQF0q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 01:26:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6062C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 22:26:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d23so223222plq.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kGxXpIYjrMBpYkhbEZTTeWh7Gc5Qxtj5NDKhM3vFUk0=;
        b=otLHRKOMB9hmNucCiUz/tfN04Cocn2hD2DwKB4KleAL2XrAcvfI5peZzsXB3nrssiG
         Oee0ohr1feNOAOCFC+wjXpw5B/0Mjfl6uFTGvcxS/4ORJIaZY1s/Mu7PHTIvSfCHmaoC
         ifxDiiPeABKAkm+LrU3kOlPS7lWXbGIxabxTXju6CuUjEJhUv7gJHy02yKy5xuxDzN1y
         hOOCLue8gTGEHs7lS/ANTmeeghItti7FoYbauqkxBMHsE4U/KWafYhdz1BiDs06K9uTG
         F2/5KPE2BTitFBWHrMRiwuPGbzTqMEb8c9nVrqlzlRcgeuhKcDpI0lWelKgSiHXlvByb
         7WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGxXpIYjrMBpYkhbEZTTeWh7Gc5Qxtj5NDKhM3vFUk0=;
        b=pBkF3RYwMlvL4uvG4PbMDu8sljq9IhbxQbuigDxs99P4hIdd1KcYwe+qDdxgeoo4uW
         oHdfp1sMKlUeR1CJYwSW8/x8lxrcI380LL03S5lQVWuzTnrJQF5/NJwwcDascilzQtaY
         TZNCvO+KZ+ZYcB/znAF4kb+VNj73hLluIBmJ8A2yovg4C6G8TWAz5+z8EqjXbK/iG61g
         eRV6MpuMo7Oti+K91y+QcUgQiv+urErAD3SeZTvzquCBoAbvkvfzqGnxH/+iMFtcf+ic
         WVLRdZe6ZfQcFNp7ZA3FJYJ1v7cxxGycTJEUGNWueMENBy6m5JCo1hqHyMGsXCo/BhxY
         2c9w==
X-Gm-Message-State: AOAM5336Wd3Bgr+gUOsqLx2raId9RqlOd0hKRo8LGAy3AIE8Lqzsi+s0
        3SU7yhdNj3WLun07p0inCNc=
X-Google-Smtp-Source: ABdhPJzh63RUypKVlvuu94vilv9uvRPXOWoq9bu+KToiP0IGHu4139C5vAkFdukA+zjfpIr0Am4OEg==
X-Received: by 2002:a17:90a:d58a:: with SMTP id v10mr2796765pju.36.1615958806117;
        Tue, 16 Mar 2021 22:26:46 -0700 (PDT)
Received: from konoha ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id e1sm18255460pfi.175.2021.03.16.22.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 22:26:45 -0700 (PDT)
Date:   Wed, 17 Mar 2021 10:56:41 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     christian.couder@gmail.com, adlternative@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v9] [GSOC] commit: add --trailer option
Message-ID: <20210317052641.GA8212@konoha>
References: <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
 <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/03 10:39, ZheNing Hu via GitGitGadget wrote:

Hey ZheNing!

> From: ZheNing Hu <adlternative@gmail.com>
> 
> Historically, Git has supported the 'Signed-off-by' commit trailer
> using the '--signoff' and the '-s' option from the command line.
> But users may need to provide other trailer information from the
> command line such as "Helped-by", "Reported-by", "Mentored-by",
> 
> Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
> other trailers to `interpret-trailers` and insert them into commit
> messages.
> 
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>

I have been away for a while and directly seeing a V9 of this patch
feels great! Its good that you have worked upon the patch. The above
approach seems good to me!

>  	/*
>  	 * Reject an attempt to record a non-merge empty commit without
>  	 * explicit --allow-empty. In the cherry-pick case, it may be
> @@ -1507,6 +1528,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> +		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("trailer(s) to add"), PARSE_OPT_NONEG, opt_pass_trailer),

I feel that a better option description could be offered? Maybe
something like: 'add custom trailer(s)'.


>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),

I have not yet gone through the the V2-V8s but I have a comment not
associated with the contents of the patch. I feel that you should wait a
little before posting a new version of the patch. I see that V4-V8 are
put up in almost 3 hour gaps. This isn't technically wrong or prohibited
by the communication rules of the List but I feel that posting a patch
in such short intervals makes it hard to review and unnecessarily
increases the versions of the patch. The reviewer lags behind the patch
series in fact.

What you could do instead is post one patch per day instead of 3-4 in
one single day so that your patches get thorough reviews. This way, you
won't create 3-4 new versions of the patch containing not-so-many
significant changes. You get me?

Also, in your reply on the V1 here:
https://lore.kernel.org/git/CAOLTT8SpAOj51jqYUYqYwXaVKSn1fANvetauaG0z4etiBMzVEw@mail.gmail.com/

I read:

> It's exactly what you said.
> My lack of English sometimes limits my expression.

It is okay please do not worry. Neither do we have English as our first
language nor have we ever communicated this much with an English
speaking audience online. I struggled initially too especially with many
American terms used here. You will get the hang of it soon.

Keep contributing!

Regards,
Shourya Shukla

