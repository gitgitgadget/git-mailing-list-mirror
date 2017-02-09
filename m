Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADE81FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 07:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbdBIHEy (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 02:04:54 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35638 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdBIHEw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 02:04:52 -0500
Received: by mail-pg0-f68.google.com with SMTP id 204so17124689pge.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 23:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E/9o7ZvcHQTGuYswzfb0tg33G67nU6sHsUTUIjApVIc=;
        b=UZKdALYs43MHR9PvOj2rSnFkn8PUdMkludjO4MvJg8jdabnlSQd/0v+BdDCpNG/eZV
         JZ3bCt515wLQAbjcrbRscWdPC8b12vg+YkUtOtyOepsu7C+LdK1luuFrHVE3sA3HqYtV
         h96/Ru9PVrmP0MKvgvxj61/to9dAxCHZHhygO9aRXGV8TAfLGvWaVzYqNTS11I8sYw+o
         SnRCN0OyAJavQDeDqWG3FyQ8wVx0fExegmuYMzFtDj4cM/KxX/gf46NS4mM5Jb3CoPK1
         NxvIKqebhyhh5cRTzkMMdY53qkLzaoCCTmJgXS502YF3qnkhngAxKJNREvZGwev0qV42
         pDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E/9o7ZvcHQTGuYswzfb0tg33G67nU6sHsUTUIjApVIc=;
        b=TC0AYHeEh08ZdnqcIr7nNuasWRv47qaM6pZVZw1GQIlRXu8zdA8b9RNAF5aSoCJMgm
         qQi4rJ2rhoPZd1XiMnBQanDPHsJP3GAwqsXLg/nUZhMPdlZwKFkq1hol+/z1cFDWHKny
         nJtcX5kSJE9ZCdqxkKx6Lf3TeZE63UzMtK868Gf3jVx3KEiTpTbqIjLEBOkla1s9p9ZY
         ei0nNBgq+mfZvB4ZV+hXwg7/HAD481oazDOSZEVgwJTtqPiWP3/5HGU3zlqUpntG+DJ0
         drJG/o7sDGJO8DUIj5Miqy00bDhUzLbIcuyQZWfvpE8uWPgLG24yuyccabyswm+2bD0j
         Hm+w==
X-Gm-Message-State: AMke39m0sY7yRZOckGvQB4HgyiFgPuG4A9cWVBmWCb3RZaiDgDn+EFJcDhpsmSapqycFDQ==
X-Received: by 10.99.175.16 with SMTP id w16mr2158519pge.32.1486623347452;
        Wed, 08 Feb 2017 22:55:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id g64sm25468636pfc.57.2017.02.08.22.55.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 22:55:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs from another worktree
References: <20170208113144.8201-1-pclouds@gmail.com>
        <20170208113144.8201-3-pclouds@gmail.com>
        <37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu>
Date:   Wed, 08 Feb 2017 22:55:44 -0800
In-Reply-To: <37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 9 Feb 2017 07:07:39 +0100")
Message-ID: <xmqqpoirsvin.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There are two meanings of the concept of a "ref store", and I think this
> change muddles them:
>
> 1. The references that happen to be *physically* stored in a particular
>    location, for example the `refs/bisect/*` references in a worktree.
>
> 2. The references that *logically* should be considered part of a
>    particular repository. This might require stitching together
>    references from multiple sources, for example `HEAD` and
>    `refs/bisect` from a worktree's own directory with other
>    references from the main repository.
>
> Either of these concepts can be implemented via the `ref_store` abstraction.
> ...
> The `ref_store` that you want here for a worktree is not the worktree's
> *logical* `ref_store`. You want the worktree's *physical* `ref_store`.
> Mixing logical and physical reference stores together is a bad idea
> (even if we were willing to ignore the fact that worktrees are not
> submodules in the accepted sense of the word).

I am not quite sure what mental model you are suggesting as a
preferred solution.  We can

 - represent a set of refs stored for a particular worktree
   (i.e. HEAD, refs/bisect, and refs/worktree/<name>, iirc), as
   bunch of ref_stores;

 - represent a set of refs shared across a set of worktrees that
   share the primary one, as another ref_store;

 - a caller who wants to get a "logical" view of a single worktree
   user can pick one of the first kind and union that with the
   second one, and represent the result as a (synthetic) ref_store.

The third one is "stitching together from multiple sources".  By
"mixing logical and physical is a bad idea", do you mean that the
same abstraction "ref_store" should not be used for the first two
(which are physical) and the third one (which is logical)?  Do you
want to call the first two "physical_ref_store"and the last one
"ref_store" and keep them distinct?

For the purpose of anchoring objects in the object store shared by
multiple worktrees, we can either iterate over all the ref_stores
of the first two kind, or iterate over all the ref_stores of the
third kind for all worktrees.  The latter of course is less
efficient as the enumeration

	for worktree in all worktrees:
		for ref in get_ref_store(worktree)
			mark tip of ref reachable

will work on all the shared refs multiple times, but as an
abstraction that may be simpler.  The alternative of working at the
physical level would be more efficient

	for worktree in all worktrees:
		for ref in get_ref_store_specific_to_worktree(worktree):
	        	mark tip of ref reachable
	for ref in get_ref_store_shared_across_worktrees():
        	mark tip of ref reachable

but this consumer now _knows_ how the logical ref_store of a
worktree is constructed (i.e. by combining the two ref_stores),
which appears as a layering violation.

I am however not sure if these issues are what you are driving at,
and what exact design you are suggesting.
