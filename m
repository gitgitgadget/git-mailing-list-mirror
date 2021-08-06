Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C22C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7319461179
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbhHFUdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:33:00 -0400
Received: from a.mx.sigpipe.cz ([37.221.242.114]:1675 "EHLO a.mx.sigpipe.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhHFUc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:32:59 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Aug 2021 16:32:59 EDT
Received: by a.mx.sigpipe.cz (Postfix, from userid 1001)
        id 6742A155503595; Fri,  6 Aug 2021 22:23:58 +0200 (CEST)
Date:   Fri, 6 Aug 2021 22:23:58 +0200
From:   Roman Neuhauser <rn+git@sigpipe.cz>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] clone: Allow combining --bare and --origin
Message-ID: <YQ2aXpfzyOOUFhQk@isis.sigpipe.cz>
References: <xmqqv94mtdyj.fsf@gitster.g>
 <20210804133010.25855-1-oystwa@gmail.com>
 <xmqqbl6dqgvc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbl6dqgvc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

i'm "the user" in this story.  Muchas gracias to osse for turning
my bickering into a patch.

A little background.  I use --origin a lot (or git remmote rename
afterwards), because origin carries no information about the remote
repository, and I could have cloned any of those.  The URL I used
in `git clone` has little to do with which remotes I'll want to
pull from and which I'll want to push to.  "origin" is suspicious
and I'm used to giving my remotes names that mean something to me.

My need for git clone --bare --origin surfaced when I was writing
a tool for versioning dotfiles (don't we all have one).  It has to
be able to work with pre-existing files in the home dir:

$ git dirs clone $url x
# git-dir is $PWD/.git-dirs/repo.d/x
# work-tree is $PWD

I used git clone --bare / git config core.bare false /
git config core.worktree ... and hit the error message when I tried
to add support for --origin.

# gitster@pobox.com / 2021-08-04 10:06:31 -0700:
> In other words, if there were two remotes in the configuration file,
> you cannot tell which one was given to --origin when you made the
> repository with "git clone".

I'm not sure why this matters (not saying it doesn't).
 
> But we'd end up treating them the same.  And something like
> remote.originName would help that.  Otherwise, we'd end up sending
> this message:
> 
>     Even if we give "--bare --origin yourfavouritename" to you now,
>     unlike how 'origin' is treated in the default case, in the
>     resulting repository, 'yourfavouritename' is not special at all.

Isn't that the case in non-bare repositories as well?
BTW I don't like special cases but realize that the "origin" ship has
sailed long ago.
 
> Some people may want to treat yourfavouritename is not special at
> all, while some people may want to treat yourfavouritename truly as
> a replacement for 'origin' that is the default.  The message we
> would be sending is that we'd ignore the latter folks.
 
Can't they just continue doing what they've been doing so far,
that is leave it at "origin"?  I'm not sure this would be my concern
as a user of this feature.

-- 
roman
