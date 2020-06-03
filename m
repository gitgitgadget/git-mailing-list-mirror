Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4129C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2D520679
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 16:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ByfiU1Xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFCQvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCQvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 12:51:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59FC08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 09:51:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so2163477pgh.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eMknIwcAjtJLGHHVO9km80wZqf6p9xP6V+A/7KsbTLk=;
        b=ByfiU1XyclgNO1NDOJ0ORRezPUX5N8TuY1tA5se/yaKo4URp+hIqUCdOG0gim3EbC7
         F/G+qcgFhgfqxPRTCDODPjJcLfuei6E0MYLG0kLkDbRfXhOEl7XWb9MaVhwqoNHITkU9
         K1p/haEglVjTUC/5fLqKgWvNfx219RT1am+iIoci+35J/KyKlfYzky4IQ3wSfGwA/ql2
         Q19+N5nsRx8RxnyRs45caDmeaTkgdjWSJfzjriZ3hYrDp3DtNLCv/QXcwD61uPWaBQ92
         XFQbVJDm80UsN2GJapILL139GGbqu7RVeknj+3VjEz+yiFPZwYTVzc6zzimlPu9GheTZ
         OO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eMknIwcAjtJLGHHVO9km80wZqf6p9xP6V+A/7KsbTLk=;
        b=SyqG/Yi0vVEszFor5HqIactdEs0zn/7tctxxIEp2pee2eB5i681M6jXXJ18YlhDu3A
         altQ+EQXFQ1yZkyql9KzzWNdPnWW/D0O5MuN1syhf8jy0ypu+U9FgDQ6PZ0wH2hrdxIk
         TLw/re5Jq6+IJK+WLKE2CwXm+HQ88RaBKHvoKri1MF297GgJK0kvISbwOE1atrhCYqfc
         TKSFDM1WJOr04GMS52pe07UP6B3t9/n6dJcahIoapc69gRhnkSk1qgAlLLkUhEyhQWhL
         ISHe6mgZszWcfPnRz8bBLiEPk7CqNQN4YHyZ4VYNOyDPH98RakcWnlRm6dF4q6mv/eQt
         hYOA==
X-Gm-Message-State: AOAM530Btdf0sInIqsDkH0FYxjILCs+APo5RuALlijJUV+JUsAu34pC+
        M9xOO0uYMQeicwM+XUg+lCy5n91dlZo=
X-Google-Smtp-Source: ABdhPJzmuaVbV4Lrv/Gwb5k9dEwgsnBw88cSUIvnTJf5owOEnDJj5+BMAEINRRXsyoBAFVhct1NVMg==
X-Received: by 2002:a17:90a:d083:: with SMTP id k3mr852999pju.8.1591203105422;
        Wed, 03 Jun 2020 09:51:45 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c194sm2272632pfc.212.2020.06.03.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 09:51:44 -0700 (PDT)
Date:   Wed, 3 Jun 2020 10:51:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] refs: implement reference transaction hook
Message-ID: <20200603165142.GA24049@syl.local>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick,

On Wed, Jun 03, 2020 at 02:27:50PM +0200, Patrick Steinhardt wrote:
> In order to test the impact on the case where we don't have any
> "reference-transaction" hook installed in the repository, this commit
> introduces a new performance test for git-update-refs(1). Run against an
> empty repository, it produces the following results:
>
>   Test                                   HEAD~             HEAD
>   ------------------------------------------------------------------------------
>   1400.2: update existing reference      2.05(1.58+0.54)   2.08(1.58+0.57) +1.5%
>   1400.3: create and destroy reference   1.79(1.38+0.49)   1.82(1.39+0.51) +1.7%
>
> So the overhead is around ~1.5%. Given that git-update-refs(1) is a
> near-direct wrapper around reference transactions, there likely is no
> other command that is impacted much worse than this.

This is a serious performance regression that is worth considering. For
example, a 1.5% slow-down on average in reference transactions would
cause be enough for me to bisect the regression down to see what
changed.

What are ways that this could be avoided? I bet that this would work
quite well with Emily's work on hooks, where we could check in the
configuration first whether a hook is even configured.

Could this be integrated with that? If not, could you cache the result
of whether or not the hook exists, and/or implement some mechanism to
say something like, for eg., "only run reference transaction hooks
core.blah = 1" is true?

I haven't myself looked seriously at your patch (although I do plan on
doing so, but haven't yet had time), but I think that this should be
considered thoroughly before moving forward.

Thanks,
Taylor
