Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5587C2B9F4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4F6613A9
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 00:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhFRADF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFRADF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 20:03:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3FC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 17:00:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y15so471151pfl.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JXMMuvpxiwbqTbjFhCciPZNNOq0+i7EXBOdhS6VbE4M=;
        b=pGd6XJNKivuf5X1UmqYC4mbW2QnKIIfjrLNZAdSfdttEzNLWD8d3Clcsm6Sd+kVjZt
         HmmKvY0TXzrvY7woIktAJaiNIWhsd2yeIydlkQjgwDwcFI/06N72fDzPnqiJSGlo7ip5
         YZrwddxokbdPQhs0DFRabNjbpx3jALyU7lDrADK38Pv/r6rB0CjIafZCdzVdVZR4d1Ld
         YWW5f8moUYxxpFaUQjormnh5F9aOi5qeV/znhwTXQFg9+4d9vzqH5iUn6bEI3vRdtZd6
         Y/Rnoj18jdGiG6AxvPKX/KI48cNNcZQL/XvD0MiG8RUcQzZTwB43syV1HfWkMZhNdE9o
         PW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXMMuvpxiwbqTbjFhCciPZNNOq0+i7EXBOdhS6VbE4M=;
        b=CG1WjzOnmplfXhsxmKoLQG+hOK6tnyddYsLjpJ5RorZ8+Md1Hw0ZGc+pOg9oo+h7KR
         5ERsK6tmh/7nlEIKv3YVray6zOY1A2rhp2/paX74sdNW0i8eVcYD09EZYssnoKGpzx5n
         IHv+T9TydMpAGjcwa6VctTE3ExPpvAd++Tomy9RCCzzDhf6yhIGpKGRccB/OiY1zktMc
         wP5TZPjQOJ7pnjp8dkVuSMIajKX7p5qCzVthygMCDsxg1XG4k4UUHxaLLXwEyaNOuic2
         NRMW5VRrfHz5yUvOCl58dp92I/foot4DpYJZaxwfvGgfsQs07vGvOgsp+++YQ20VC4CR
         ZDQQ==
X-Gm-Message-State: AOAM53166IaYmdJQqX+mGefDJEtYCbeY6uJdCsnrGv+Cf+v7s8tY5byA
        orjidA3Mkzf+NCNPKx7MfP9lbA==
X-Google-Smtp-Source: ABdhPJyXJlz0WhdSRMCc7C7TUgRrO1XiSju95EvsvZjMviMWw5VZ7qTgG8jbG7hVfgQmBOE//8KwKg==
X-Received: by 2002:a62:7915:0:b029:2e9:c33e:e6be with SMTP id u21-20020a6279150000b02902e9c33ee6bemr2270345pfc.18.1623974455308;
        Thu, 17 Jun 2021 17:00:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:30e4:83fc:53b6:fa47])
        by smtp.gmail.com with ESMTPSA id w18sm6572189pjg.50.2021.06.17.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:00:54 -0700 (PDT)
Date:   Thu, 17 Jun 2021 17:00:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
Message-ID: <YMviMFy4yCFXFiEv@google.com>
References: <20210616004508.87186-1-emilyshaffer@google.com>
 <20210616004508.87186-3-emilyshaffer@google.com>
 <xmqqsg1iqv5n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsg1iqv5n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 01:40:36PM +0900, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> > +submodule.superprojectGitDir::
> > +	The relative path from the submodule's worktree  to the superproject's
> > +	gitdir. This config should only be present in projects which are
> > +	submodules, but is not guaranteed to be present in every submodule. It
> > +	is set automatically during submodule creation.
> > ++
> > +	In situations where more than one superproject references the same
> > +	submodule worktree, the value of this config and the behavior of
> > +	operations which use it are undefined. To reference a single project
> > +	from multiple superprojects, it is better to create a worktree of the
> > +	submodule for each superproject.
> 
> You'd need to dedent the second paragraph that follows a lone '+'
> sign to typeset this correctly.

Ok.

> 
> The new paragraph suggests separate worktrees for the same submodule
> repository, but for that to work correctly,
> 
>  - "git clone [--recurse-submodules]" that clones the second
>    superproject that shares the same submodule with a superproject
>    that we already locally has to support a way for users to tell
>    where to grab that existing submodule from and arrange a new
>    worktree, instead of creating another instance of the submodule
>    repository by cloning it afresh.
> 
>  - The "submodule.superprojectGitDir" needs to be set to
>    per-worktree half of the repo-local configuration file.
> 
> Because I usually do not pay much attention to the submodule part of
> the toolset, I may well be mistaken, but I suspect that the former
> does not exist yet.  If I recall correctly, the latter was a NEEDSWORK
> item in the previous round of this patchset?
> 
> As I said, I think it is OK for now to stop at declaring that you
> cannot simply do it without hinting something that may not fully
> work.

Yeah, that is all correct. Ok, I will drop the broken suggestion.

 - Emily
