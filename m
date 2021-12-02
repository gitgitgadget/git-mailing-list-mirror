Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6F2C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 23:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356508AbhLBXRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 18:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhLBXRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 18:17:30 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E2C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 15:14:07 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id p1-20020aa79e81000000b004a82ea1b82bso707313pfq.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 15:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8AmenpjrqVfrp8jLl+j0Q0q60z1a1IxSBvn8YFS/v/8=;
        b=ILqXfuSzlcP7oyVgqONP+WFYB7Q4u+FIFalEFWp4hfNatt7dTnpJ2lZBxFmPAO8RVZ
         1Bd8V6jwecijkFcPxC4kgq4BFU1FsQ6aBgKMfd8WBXRfTX9NzL2noMTqiYNXxBxzFuVs
         y79ta/BkhZcBzZ87g/CLVX1KuhHYlxVEHGf3migcPhlERb6bsN1Hn4jLONf4PbF5Lh5+
         4McEhlMxbqd4vTItQWQLFMmfyh/Df3LrcznEvxyh0sKGAlKvJo2G82AAiQ88tJD8yil4
         c+MI18iKMIqdl1zze3vIuVBW2AwKXLzsdSaybLkecuSZ/PZOWrR5oPDr7xXFDHDaFGmk
         dE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8AmenpjrqVfrp8jLl+j0Q0q60z1a1IxSBvn8YFS/v/8=;
        b=KMNA5ydnuaE+I0LliHMejPGhO14XxPQKUX5JlD50Y9N5fxJ4/UnKgxvwPH7hEOHK7b
         2mb/6NAs8L6HmeowRJCuJew/3ICvXJAYdmhziu/6ortcVXolDy+c6LEb2uNwRf2Jk6m3
         LJLnJeOdHBqiZvGKE45c/MK+/LH4CHfvVmFZN0+gwh9RrtAiyOeVbvxFGI3F98I09RgM
         XB3FXbkoSmeAnIUN1cjLBenesbEdpyzsm/kisGXWaYLVmOdVkDhzygmacU1pHaR0GD7H
         MLYaFIPP3mHwa4To4bhAwf+O3QNh5Q+t8K1JtQne2m2WTHbK1ccJMo7s5rMTH2kBcrnM
         kk+w==
X-Gm-Message-State: AOAM533pko2DYRSeQcdRz72NQnvyu64YAr3CFk4eoew3Mh9lX2CGdsSw
        mUykqXydEy5QasQGpVzGz6j/d8bGYb6LmbDg4P9x
X-Google-Smtp-Source: ABdhPJzgPr8G8/FnerLPUmrO+EBzEGBEIQZNpZlClRhLuXYi2jeVsUi9qC2RvzThXTfBwx9+VQgiVSOXBH2uEq3ZDesa
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1250:b0:4a8:18f8:5001 with
 SMTP id u16-20020a056a00125000b004a818f85001mr15673744pfi.59.1638486846607;
 Thu, 02 Dec 2021 15:14:06 -0800 (PST)
Date:   Thu,  2 Dec 2021 15:14:03 -0800
In-Reply-To: <xmqqlf1417mo.fsf@gitster.g>
Message-Id: <20211202231403.3451471-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqlf1417mo.fsf@gitster.g>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, peff@peff.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> variables we read without the includeIf directive", with variations
> >> of "condition" including
> >> 
> >>  - a literal X is among the values of multi-valued variable Y.
> >>  - a pattern X matches one of the values of multi-valued variable Y.
> >>  - a literal Y is the name of an existing configuration variable.
> >>  - a pattern Y matches the name of an existing configuration variable.
> > ...
> > code), in this case, unless there is another use case for this, I think
> > we should proceed with the use case that we know about first
> > (conditional include of a file supplied by a remote repo administrator).
> 
> Doing it that way without thinking flexibility through will paint us
> into a corner, from which we cannot get out of, doesn't it?
> 
> People will start asking "Why should we even have
> 'hasremoteurl:$URL' variant in 'includeIf' conditions, when one of
> the 'variableExists:Y' and friends can express the same thing",
> somebody new who is not yet in this community today will propose
> deprecating hasremoteurl in favor of more generalized approach and
> we have to give a sad answer "no, we earlier made a mistake of
> starting with a special case variant for expediency's sake, without
> thinking the general cases through.  Because existing users depend
> on it, we have to support it til the end of time."
> 
> We have the same regret with "why do we need grep.extendedRegexp
> when grep.patternType suffices?"  I am reluctant to see us knowingly
> commit the same mistake here, unless there is a very good reason.

Hmm...that's true. I was thinking that there wouldn't be a way to
predict exactly what we'll need, but perhaps making the config variable
name be of the form 'includeIf."hasconfig:remote.*.url".path' might give
us enough flexibility for the future.. I'll take a look.
