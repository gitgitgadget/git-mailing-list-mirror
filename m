Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82659C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8B760200
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhGWPzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhGWPzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:55:50 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE4C0613D3
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:36:22 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso1761521ota.13
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/Wf+ZFMZdFp2oSBO91YhMo+I6AvpCQoCbl7a4EToo1Y=;
        b=m0ssU6t/mFHgQPYRuh3jPXFWpIkYATSEChj8e0BFtBdl8lunbNpj7FwJePgkx1ZxEw
         YG80eYLaOBVuvbMlmnWngWTIZ/XVQGE8s+YnEyapCJi1pMIpW/e6wAoOJOVp9s4bLRev
         y4m/Xvpc2PY8xjFb42XBsc4iwngs1lvS7O3mty3Q0I1V3G8/A1900Dpg/OU5Ci510iGY
         qYqlRDTeF+s4PLnk4Sv44H9suW2ZVvbkcW7ahg5I3+9zp1qmmILnVPPY9lL7rNbsC7K4
         LrNMxUbcW/aBn8Q8vMfHIQdY6dcqCKn769o7ccDgdQst1IW+toPuy6kROxxVS1/Jkcm8
         frlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/Wf+ZFMZdFp2oSBO91YhMo+I6AvpCQoCbl7a4EToo1Y=;
        b=Xgf5mFgQEtnt7b9dtADMe3FG9GggtZL5WbSFhbWSC6QwI9EMmcDBi4HUNRtXnBd53q
         m61d6loPlbF2KdUDBoVEv4PabEkS3QoSzCO+OPsge2fa1hS3og9390qMOIkORkIx97tU
         c4NGsYUKSlYB/4EVnb+zJR4nwKRYmWotLf9bnV9bFQlAFjCJZzn8Dl/rtr5qblTjsDmB
         eGGQyn6JrgTZd9zAXVIEjUONvCci9GSnIHo7KNG4Df5hKLe66t33UN7PyGiI/s2slBBX
         ldl2BVkSiX4Vllr+ppd9v2Bep2+OfbvWs8L+Uhxec4oU74qS3eCqArBCZLxBtCLypIW/
         RIyA==
X-Gm-Message-State: AOAM530IYq3ivZ99kIJQQ2zjYwyzpHXrK+kUdjkJIc/i8P7QlNUKHAD1
        NUWWLL5KVG7ECXtr5GJOFyw=
X-Google-Smtp-Source: ABdhPJxuym3KfLWWbZ6lxY1NlWXhRplgYv3soxPnmT12PSdGUsFp6bHZddsP2OdIreomnk7U6sRgCg==
X-Received: by 2002:a9d:4789:: with SMTP id b9mr3572299otf.335.1627058181775;
        Fri, 23 Jul 2021 09:36:21 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s2sm5488575ooc.15.2021.07.23.09.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:36:21 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:36:20 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Message-ID: <60faf00444122_defb208cb@natae.notmuch>
In-Reply-To: <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
 <xmqqy29z9r94.fsf@gitster.g>
 <xmqqtukn9p0g.fsf@gitster.g>
 <60f8c8c92a215_1d0abb20859@natae.notmuch>
 <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Jul 21, 2021 at 08:24:25PM -0500, Felipe Contreras wrote:
> 
> > I'm not trashing the current behavior, I'm explaining what the consensus
> > is. I spent several man-days re-reading old threads, and this is the
> > consensus of what should happen:
> > 
> >   1. git pull              # merge HEAD into upstream
> >   2. git pull origin topic # merge topic into HEAD
> > 
> > Of the people that expressed an opinion, 100% of them stated that what
> > `git pull` does in the first case today is not desirable.
> 
> I did not participate in the threads you linked earlier, so I am
> probably not in that 100%. But you did use my name below:
> 
> > Yes, you are correct that if *everyone* followed the topic branch
> > workflow, everything would work correctly, but that's not what happens
> > in reality, in reality people do all kinds of workflows, and wrong
> > merges are pervasive.
> > 
> > Everyone--including Linus, Jeff, and you--agree that there's two
> > different ways of using `git pull`: integrator versus developer.
> > 
> > When a user is doing `git pull` to synchronize changes to push to the
> > same branch, that's a centralized two-way workflow, so he is acting both
> > as an integrator and as a developer, and it's in that particular case
> > that the order of the parents should be reversed. Everyone agrees on
> > that.
> > 
> > When the user the opposite explicitely: `git pull origin master`
> > Linus calls it a "back-merge" [1], and in that case the order of the
> > parents should not be reversed.
> 
> So I feel compelled to say now that I do not think that changing the
> order of parents for "git pull" is the obviously correct thing to do.

That's not the same as saying it's the wrong thing to do.

More importantly, while for you it might not be the obviously correct
thing to do, it should be obvious that there is a problem. Whether
reversing the parents in case #1 is the best solution or not is
debatable.

> And likewise, in the one thread I do remember participating in, I
> expressed something similar:
> 
>   https://lore.kernel.org/git/20140502214817.GA10801@sigill.intra.peff.net/

In that comment you mentioned that you were not against reversing the
order of the parents, but if we did, that it should done with a
configuration that the user explicitely turns on:

  I wanted to make one point: if we are going to do such a switch, let's
  please make it something the user explicitly turns on.

I am not against adding a configuration to reverse the parents only on
case #1. Additionally we could delineate a migration path that mentions
that in the future this will be default, although that can be done and
discussed later.

But the fact that there's a problem is not debatable.


Either way it's precisely because `git pull` is a command with so much
inertia that it's hard to change (although not impossible), that I
decided to create a new `git update` command whose whole purpose is to
implement case #1, which is intended for normal developers, not
integrators, and there the order of the parents is reversed by default.

-- 
Felipe Contreras
