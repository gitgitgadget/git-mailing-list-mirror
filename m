Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA867C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF9C650E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhCJBXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 20:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhCJBXV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 20:23:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D06C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 17:23:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 16so9405886pfn.5
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 17:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgHEFFP0OTaWz//GfE2Gvh64jbsP96DL/vehanhb1v0=;
        b=S/FJvgtnM/0ZC4aCCiJH/GdmAa3X47lN3JoeVOatCZ+ExOrPGAYEuMHLJDsXrHRSUS
         Ji8U+SI3Jhl4aKeGLCX2l21eBnJMaC/aF6E4Lt9OzhUCmTXSCUvGOVzQt45cZxWCjXoS
         moakvYAyIHha/kf2BwqqTDlQvo9lFa38MgbRbpTBYvglleBRctifU8kAc2UAUzqTaTa2
         isDJpYfIro5pPrAUy0pfkAQZCkvmbm32xnwL71agf7T8BtPczKsb9QIogYWZfutGM/14
         EhCu3pb+JG7SVGYr5rdepXVRKFcjVDsB9m/tROUp1CZYR1zQg4WpMgBu3nQyQmQye4iP
         41Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgHEFFP0OTaWz//GfE2Gvh64jbsP96DL/vehanhb1v0=;
        b=eNb2hnD+tyAsZLG+p4NQNPMq2+HhISyh2fvGbn4zTzvVEv6w2Ij9DRmWbJhuNpMSaT
         8ALf42XXa07PgpOfy+4azr1cHLzsA9CmpSf+WaNWZrNjBGLqhX6qrW1++PsnvCZLejHN
         KZiKph/x1gvx7eByKwh6UoFmZQ7KqF31n6kg33Enr2lpceEi2DuIorjUBwBUuVs3Z0wJ
         7TScto0eXO0RZT4NgoH+ZLKT1wRaq/sH/0ntaoPZ6uPNovwLiUTiIkATsAanrGwUqfo3
         MNQAUYuSmtGgVjuweuDFrNs3dFlsctHlzRxkTRdnU9CicaaC/06sTwh9SI5McsQG+0q3
         u+3A==
X-Gm-Message-State: AOAM532ylgw4Vbt/KqEiQ/19NKUID6yoKGem+lZj+dxJOjzQbkF58gAu
        jokLBWTyMyaeXr2DIDUu6Kc=
X-Google-Smtp-Source: ABdhPJxaIB/7AkPHT5OHeaNbuk1wuLbfoqVzT89VEraA8QbcHJPV4S4yfdPldPl0R0MPQDVbhF5bAg==
X-Received: by 2002:aa7:8ad0:0:b029:1ed:fb30:e5d5 with SMTP id b16-20020aa78ad00000b02901edfb30e5d5mr846432pfd.79.1615339400818;
        Tue, 09 Mar 2021 17:23:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:357c:e8e3:4f20:9227])
        by smtp.gmail.com with ESMTPSA id cv3sm4068936pjb.9.2021.03.09.17.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:23:20 -0800 (PST)
Date:   Tue, 9 Mar 2021 17:23:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Seth House <seth@eseth.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH] mergetool: do not enable hideResolved by default
Message-ID: <YEgfhYSz7VaCtvH1@google.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <20210209200712.156540-2-seth@eseth.com>
 <YEbdj27CmjNKSWf4@google.com>
 <YEcKy83ZmvGTAfxq@ellen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEcKy83ZmvGTAfxq@ellen.lan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Seth House wrote:

> The very early days of these patch sets touched on this exact discussion
> point. (I'd link to it but that early discussion was a tad...unfocused.)
> I make semi-frequent reference of those versions of the conflicted file
> in the way you describe and have disabled hideResolved for a merge tool
> I maintain for that reason.

Thanks.  Do you have a public example of a merge that was produced in
such a way?  It might help focus the discussion.

For concreteness' sake: in the repository that Dana mentioned, one can
see some merges from before hideResolved at
https://android.googlesource.com/platform/tools/idea/+log/mirror-goog-studio-master-dev/build.txt.

The xml files there (I'm not sure these are the right ones for me to
focus on, just commenting as I observe) remind me of other routine
conflicts with xml I've had to resolve in the past, e.g. at
https://git.eclipse.org/r/c/jgit/jgit/+/134451/3.  Having information
from each side of the merge and not a mixture can be very helpful in
this kind of case.  That's especially true when the three-way merge
algorithm didn't end up lining up the files correctly, which has
happened from time to time to me in files with repetitive structure.

[...]
> There are three options to achieve the same end-goal of hideResolved
> that I've thought of:
>
> 1.  Individual merge tools should do this work, not Git.
>
>     A merge tool already has all the information needed to hide
>     already-resolved conflicts since that is what MERGED represents.
>     Conflict markers *are* a two-way diff and a merge tool should
>     display them as such, rather than display the textual markers
>     verbatim.
>
>     In many ways this is the ideal approach -- all merge tools could be
>     doing this with existing Git right now but none have seemingly
>     thought of doing so yet.

One obstacle to this is that a merge tool can't count on the file in
the worktree containing pristine conflict markers, because the user
may have already started to work on the merge resolution.

> 2.  Git could pass six versions of the conflicted file to a merge tool,
>     rather than the current four.
>
>     Merge tools could accept LOCAL, REMOTE, BASE, MERGED (as most
>     currently do), and also LCONFL and RCONFL files. The latter two
>     being copies of MERGED but "pre split" by Git into the left
>     conflicts and the right conflicts.
>
>     This would spare the merge tool the work of splitting MERGED. It may
>     encourage them to continue displaying LOCAL and REMOTE as useful
>     context but also make it easy to diff LCONFL with RCONFL and use
>     that diff to actually resolve the conflict. It could also make
>     things worse, as many tools simply diff _every_ file Git gives them
>     regardless if that makes sense or not (>_<).

Interesting!  I kind of like this, especially if it were something the
tool could opt in to.  That said, I'm not the best person to ask, since
I never ended up finding a good workflow using mergetool for my own use;
instead, I tend to do the work of a merge tool "by hand":

- gradually resolving the merge in each diff3-style conflict hunk by
  removing common lines from base+local and base+remote until there is
  nothing left in base

- in harder cases, making the worktree match the local version,
  putting the diff from base to remote in a temporary file, and then
  hunk by hunk applying it

- in even harder cases, using git-imerge
  <https://github.com/mhagger/git-imerge>

[...]
> 3.  Git could overwrite LOCAL and REMOTE to display only unresolved
>     conflicts.
>
>     (The current hideResolved addition.) This has the pragmatic benefit
>     of requiring the least amount of change for all merge tools,

That's a good argument for having the option available, *as long as
the user explicitly turns it on*.

[...]
> Does the need to default hideResolved to off mean that it is the wrong
> approach?

One disadvantage relative to (1) is that the mergetool has no way to
visually distinguish the automatically resolved portion.  For that
reason, I suspect this will never be something we can make the
default.  But in principle I'm not against it existing.

The implementation is concise and maintainable.  The documentation
adds a little user-facing complexity; I think as long as we're able
to keep it clear and well maintained, that should be okay.

git-mergetool.txt probably ought to mention the hideResolved setting.
Otherwise, users can have a confusing experience if they set the
config once and forget about it later.

[...]
> Thinking through an end-user's workflow: would a user want to configure
> two copies of the same merge tool -- one with hideResolved and one
> without? An easy conflict could benefit from the former but if it's
> a tricky conflict the user would have to exit the tool and reopen the
> same tool without the flag. That sounds like an annoying workflow, and
> although the user would now have that extra, valuable context it would
> also put them squarely back into the current state of viewing
> already-resolved conflicts.
>
> I know the Option 3, hideResolved, is merged and has that momentum and
> this patch looks good to me -- but perhaps Option 2 is more "correct",
> or Option 1, or yet another option I haven't thought of. Thoughts?

I suspect option 1 is indeed more correct.  Dana mentions that some
mergetools (p4merge?) use different colors to highlight the
'automatically resolved' portions, something that isn't possible using
option 3.

Thanks,
Jonathan
