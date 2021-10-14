Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFF4C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2E1611C7
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhJNSrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJNSrr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 14:47:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FFC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:45:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e7so6370786pgk.2
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jeomx3AaiPPx+Jy9bQnmHPTAe+g6rmofjHGC42tbzN4=;
        b=BREhRkmhtIETuACvqWV2WlzqtUlQuyMU5wrvyAND2OArh9YmKfslhdTWJQP/ehDCeh
         hPc9N27rZkm2NUMnFQu/MdyHRo8PP5bDSCYJpXBCZbEx1lVl8kC0gwDkugNNzrSL5D/K
         eyujOgf8CuBcDT6Q42R+yJQM6x/l0lQPfRnVFM4oFIJkkQyG0byVMS0dE6ocdgRxZqu6
         7gYTNqppw0EyMhOsKlhhNicD5BXWduuxBeRbMLiYMUBZ7rtRFlKewWw9RKr6im6M5D8W
         Lfv0JOraIX/X5W50jx3yprUQaAEK9PyjqHEn6HGJ8AyWTX9Mlzjti/m7N0OrcZiiVblE
         DMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jeomx3AaiPPx+Jy9bQnmHPTAe+g6rmofjHGC42tbzN4=;
        b=fLI1hr3SnGuTwAz+FQsQrHWsSWmVYhTSnApFZzHpN4EIdwginpkr40Z3BRNLIWKQ+Z
         TNoffQeA4Os1U0Q5/5Mcew83pLD5o+VESS514rdaT9pm89XYQsOyjwUOxLWrh0JYRZWd
         upQWImAM96tI32RMivCOVMock1XPG/ZcoJ95EPpAcqb/C4aYtrFSJKqenxQQsxF+6yoE
         /bN4ecavzs2/5ooXTUP65K5ets2cTyLSTWw5Nrctz8OPv2t2l4Ajbc1TWBH4Pz1lFXt4
         v7qFNjwwNH6PDfACOp1jd6WXEB7gwdh85rulbwfK9f2V4U/i2R13jJFPercUSvaJierI
         naYw==
X-Gm-Message-State: AOAM530XdlJV91gc9BTb5bAzAOOLPhJjBmcfTcJo3ksqcao2FDvrPOLY
        bTLsGlXE4fOcDud4I9cjk+sfu+IqNfH25Q==
X-Google-Smtp-Source: ABdhPJx4DRw6YgtruTDJ0DeDi5yTShWE0AbeoT3wlkfOcuU7iBxAMIuCxasV0RcWU6ho4iEEs7x3Pg==
X-Received: by 2002:a63:3606:: with SMTP id d6mr2234415pga.271.1634237141451;
        Thu, 14 Oct 2021 11:45:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
        by smtp.gmail.com with ESMTPSA id y13sm3085727pgc.46.2021.10.14.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:45:40 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:45:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] submodule: record superproject gitdir during
 'update'
Message-ID: <YWh60MiWNKC8JseC@google.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <20210819200953.2105230-5-emilyshaffer@google.com>
 <66111c98-8be3-d3e5-288f-cb5b59744cb5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66111c98-8be3-d3e5-288f-cb5b59744cb5@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 08:59:55PM -0400, Derrick Stolee wrote:
> 
> On 8/19/2021 4:09 PM, Emily Shaffer wrote:
> > +		# Cache a pointer to the superproject's gitdir. This may have
> > +		# changed, so rewrite it unconditionally. Writes it to worktree
> > +		# if applicable, otherwise to local.
> > +		relative_gitdir="$(git rev-parse --path-format=relative \
> > +						 --prefix "${sm_path}" \
> > +						 --git-dir)"
> > +
> > +		git -C "$sm_path" config --worktree \> +			submodule.superprojectgitdir "$relative_gitdir"
> 
> Ok, I see now why you care about the worktree config. The scenario you
> are covering is something like moving a submodule within a worktree and
> not wanting to change the relative path of other copies of that submodule
> within other worktrees, yes?
> 
> For commands such as 'init' and 'add', we don't have the possibility of
> colliding with other worktrees because the submodule is being created
> for the first time, so the relative path should be safe to place in the
> non-worktree config.
> 
> I do struggle with the fact that these are inconsistent across the
> two commits. It makes me think that there should only be one way to
> do it, and either the NEEDSWORK needs to be fixed now, or this line
> shouldn't include --worktree. Much of this can depend on the reason
> the worktree config exists for a submodule. I expect you have more
> context than me, so could you help me understand?
> 
> Moving to a different concern I am now realizing with this config:
> What happens if a submodule moves, and then a user runs 'git checkout'
> in the superproject to move it back? How do we make this config value
> update across those movements? Is there a possibility of integrating
> with unpack_trees() to notice that a submodule has moved and hence we
> should update this config value?

I think that switching from "sub worktree to super gitdir" to "sub
gitdir to super gitdir" fixes this neatly - the gitdir-to-gitdir path
will be identical regardless of worktree, so we can set it in the main
submodule config (lose the '--worktree' arg).

This also will fix the case you describe, moving around the submodule in
the superproject's tree from checkout to checkout, as the gitdir will
not move.

Thanks a bunch for the review and sorry it took me so long to reply. v4
incoming.

 - Emily
