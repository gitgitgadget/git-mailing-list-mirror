Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF161C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A321655
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9PbtTue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgJRNC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgJRNC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 09:02:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F2BC061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 06:02:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p11so3612412pld.5
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=RBIGKZr8sOFF7N1n8hFwYf5wt74RsvWq/Zwa/Hi5Gcg=;
        b=e9PbtTueJhERm0AZsD1JCHyqjQPXsOBf8QDZGDU0RIEBKZ/nxnPHgFaZayh9HA4/Th
         PvPAydNrh/DG/LmVBL1tpSP008XEGtF68iXP2arzi0LzX8aDifacIBxPkVenCnRMXLxG
         zsxev83o+q6XiXw/ksWmKQcsuhdMXGDvxcvDT4YLFilJhlVV5h6DzWoh2tSNsX3cXGjR
         Ub0r7f+BAZx/zaiHY+QHZWZ6DCMP6LA3o/DAaGLA74Td2Tpr0bPC6LlX2B/R8jKnWS++
         ghTvtxlYJBtt9tSjgqmMk5cMH28kTM2msAAkY2sYk7AM3f0smGLNP8hc6AD42GuzMwW7
         /HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=RBIGKZr8sOFF7N1n8hFwYf5wt74RsvWq/Zwa/Hi5Gcg=;
        b=S+L/cYbhRx6cf6ww7S9opz33I0FWgaaiF1il+dpQ6DhFlLax+QMWbG66bxA5N8l3pv
         8F6YCkAxlkDJTBn2qpHl32rNxFuzVNaUgINWVunrLWO/9j58b+a/gjx6R2svehMXF6Fv
         p0yOUE6vnaEmVypUAZ1aaF12l6R/kn68MsrJW0i9WcqcvdVwW46flS7cwdiLU3iP9sed
         xX2u1Ezsq0EDGyF7tyfYBMpudxtrwqo/rCWHnc1xrKeyw3ZvqSLPapWk9LUxVmFOFJcA
         a/oGpruI2ScdQhpWLtLrv7P2KvgX5Q/3CS4xd3HjSGiNVRKTLPPjrEj6e85ebAbAB+d/
         9wlQ==
X-Gm-Message-State: AOAM531Mjc8iWmJnJJu/2UX49AAdc0JYI2t5eviWUTtEr69SqHHb4MdN
        HLlKpYKt3iLxJi0IjF4PfmU=
X-Google-Smtp-Source: ABdhPJxBa15H2XGr5Epgj5cJAzeIiI0bk8kcvlz3VywjL6n6h0bVK+3lPy7FzpfOA0OspiBLFVi+jA==
X-Received: by 2002:a17:90a:de90:: with SMTP id n16mr12766775pjv.215.1603026146538;
        Sun, 18 Oct 2020 06:02:26 -0700 (PDT)
Received: from konoha ([45.127.46.217])
        by smtp.gmail.com with ESMTPSA id w10sm8643989pjy.13.2020.10.18.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 06:02:25 -0700 (PDT)
Date:   Sun, 18 Oct 2020 18:32:19 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     caleb.tillman@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy-Microproject][PATCH 1/1] t0000: replace 'test -[def]'
 with helpers
Message-ID: <20201018130219.GA6749@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018061052.32350-1-caleb.tillman@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Caleb,

I have some comments.

First of all, I notice that this is a v2 of this PATCH:
https://lore.kernel.org/git/20201018005522.217397-1-caleb.tillman@gmail.com/

So, I think that the subject of the mail should reflect the same. I
believe that you have used 'git format-patch' to generate this mail
therefore what you can do is:

'git format-patch -v2 @~n', where 'n' is the number of commits which you
want to include in the patch. So in your case it will be:
'git format-patch -v2 @~1' and a patch mail will be generated.

Also, you need not put the '[Outreachy-Microproject]' tag in the
subject, '[OUTREACHY]' will suffice.

Now, coming to the meat of the patch.

> The test_path_is* functions provide debug-friendly upon failure.

This commit can be redone to be even more better. This does not exactly
reflect what has been done. I understand that yes 'test_patch_is_*'
functions are better and why they are better. But where did you replace
them, this is left unanswered.

This is one example of how the commit messages can be, not too verbose
and not too short, somewhere in the middle:
https://lore.kernel.org/git/20200118083326.9643-6-shouryashukla.oo@gmail.com/

> Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
---
> Outreachy microproject, revised submission.
>  t/t0000-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 923281af93..eb99892a87 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
>  test_expect_success 'git read-tree followed by write-tree should be idempotent' '
> 	rm -f .git/index &&
> 	git read-tree $tree &&
> -	test -f .git/index &&
> +	test_path_is_file .git/index &&
>  	newtree=$(git write-tree) &&
> 	test "$newtree" = "$tree"

The change is fine but I feel you can easily find files in which you can
do the same type of change but in a large quantity. This way you will
get an even better idea of how the tests work at Git. To find such
files, one way can be to look here:
https://github.com/git/git/tree/master/t

Here if you try finding files which had commits over 11-12+ years ago,
you will find some ancient relics to modernise too! Great that you took
Taylor's advice ;)

Best of luck,
Shourya Shukla

