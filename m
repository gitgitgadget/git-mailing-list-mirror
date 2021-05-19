Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E760C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C033611B0
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhESJZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhESJZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:25:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A3C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:23:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m124so9003227pgm.13
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4SCINZJL+OeTeIHOdeq9Osk1pgGvR2G8O3ruWOwqVg=;
        b=qv33j3UHb/ijBCovDWTQTck7kA+g2TyQyahmhpEyHXl2UVzEv5SUXBuEXtKi6J2gcy
         ZeBhvZZW9n5+B07k10KzRNPPcbG0FNF9FC9TxmxAkgjb1+0d1rX6V3wn3ZBqbXsH34fX
         sh/OAIGb2xJ0cEsr9Th7MCrJytazBrynsHMS5/k2GNfhFMO3cyrtuosmzO5R21fAQU8z
         Nvqr8azuVOI68vAxYwaKCKGsaG/PGqFcWFCn1/JAAHTusro/Td2G61PS60Ux3U5Yn9mT
         1lKwatDTEozPiTMXTmPL+UCzUHkhMlVAJU7Q0H+rxwOgicuTBfFOdq8x1dJNXe7hPaoE
         T4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4SCINZJL+OeTeIHOdeq9Osk1pgGvR2G8O3ruWOwqVg=;
        b=aIYaOa7R7QKWCWZvyuzOLnzSYyoxp5Ra6S3RpD3G5hLa7yC0Sa8v36DPH+5hdQyzfW
         N7ngmYRdFqD5HqEQcGX5U7Jzz05/kt3uSs8nVi7eGtG8IGkFKUg1xgi04Mg1ZGgL1a95
         wX2r43/WAFn4bJHX7s5a38dbkiFcgq85efyxHTdp6RdwBIYt49TH3nyRUKmkaeuVlQlc
         ujjI75e8YU1CZk0TlcJ/TI7a7wWi1ASUk4BHrB061C1iyKsNSOvaz6yG7PExXJjRcT5K
         lQMtIC/3ctY86ZC66V27kKX5wzcfQMnCDOXOjRNqmJOQDHTWtyerdumBC7MrM9temthm
         sDKQ==
X-Gm-Message-State: AOAM530S+zP8QMhmGaZs8Ke8tTiNk2CN2JXuaFnlO3clK1zKYCtObOyt
        egZU5JlviqZ1RaY+CI4/Gdo=
X-Google-Smtp-Source: ABdhPJwZG1rWr1VWtS+CBfmJInHqYT3hJfXJqJFjpKMQL8Efd8ijP8nBYc3Y4BPNRmO8q2yH0jJCQQ==
X-Received: by 2002:a62:e504:0:b029:2d8:3306:f171 with SMTP id n4-20020a62e5040000b02902d83306f171mr9671576pff.37.1621416227834;
        Wed, 19 May 2021 02:23:47 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id z25sm15859825pgu.89.2021.05.19.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 02:23:47 -0700 (PDT)
Date:   Wed, 19 May 2021 02:23:44 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] stash show: don't setup default diff output format if
 --{include,only}-untracked given
Message-ID: <YKTZIOOe+IW41MXp@generichostname>
References: <76dfa90a32ae926f7477d5966109f81441eb2783.1621325684.git.liu.denton@gmail.com>
 <xmqq35uj1pmd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq35uj1pmd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, May 19, 2021 at 10:25:30AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > When `git stash show` is given no arguments, it will pass `--stat` to
> > `git diff` by default. When any argument is given, `--stat` is no longer
> > passed by default.
> >
> > When `git stash show` learned the `--include-untracked` and
> > `--only-untracked` options, it failed to retain the same behaviour of
> > not passing `--stat` by default.
> >
> > This isn't necessarily incorrect since with other arguments, they're
> > passed through directly to `git diff` which means it wouldn't make sense
> > to pass `--stat` as well. With `--include-untracked` and
> > `--only-untracked`, they are handled by `git stash show` directly
> > meaning we don't necessarily have this conflict. However, this would be
> > unintuitive for users since the existing behaviour seems to be that if
> > any arguments are given, `--stat` will not be given by default.
> 
> But even for users who do not care about the implementation, the
> options that affect "What to show" and "How to show them" are easily
> distinguishable at the conceptual level, no?  When showing stash
> without telling the command what or how to show, we omit untracked
> part by default, and we show only diffstat by default.  When we tell
> it to show also/only untracked, it is unclear if it is confusing or
> natural to average users if that affects how the chosen part of the
> stash gets shown.
> 
> Showing untracked will be a new feature in the upcoming release, so
> we may want to either (1) revert the whole thing before we can agree
> on the desired behaviour or (2) clarify in the document that what to
> show and how to show them are two orthogonal axes with their own
> default that are orthogonal to avoid the "confusion" you are trying
> to address with this patch.

I could be convinced either way and I was erring on the side of caution
by proposing this patch. I'm okay with the status quo so we can keep the
behaviour as is, unless someone objects in which case we should revert
pending more discussion.

I'll send a follow-up patch later this week clarifying the docs.

Thanks,
Denton
