Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE061C636D4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 01:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBPBcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 20:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBPBcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 20:32:39 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C01B305
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 17:32:37 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 56DA31F626;
        Thu, 16 Feb 2023 01:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1676511157;
        bh=Dl5OLg+5ibpHCQ8ACrgUMuPCzdbx8uRhRj+R1ACyEMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yl4vgurWUOGYe8VE1Efe2V+WOZ80FlSwlhu1rXz/5s5CRnLmVJ6mNmEPPNSiq9xeN
         S2EC24BfI30//lyKkej61Hcyx7HR0gFQ9O36S9gd9syZuLMRkg6ouQmzkADHZyB2ob
         FaJglHxf7nz0nwWOJXd6u+9ieYg8KuEjo4vQUUzQ=
Date:   Thu, 16 Feb 2023 01:32:37 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] fetch: support hideRefs to speed up connectivity
 checks
Message-ID: <20230216013237.M252435@dcvr>
References: <20230209122857.M669733@dcvr>
 <20230212090426.M558990@dcvr>
 <Y+qjRZTn7DNib1uB@coredump.intra.peff.net>
 <13cef8e7-71af-27a5-77a3-a08f75720d1a@iee.email>
 <Y+rmlcRoP1aMioTC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+rmlcRoP1aMioTC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Mon, Feb 13, 2023 at 11:30:35PM +0000, Philip Oakley wrote:
> > On 13/02/2023 20:53, Jeff King wrote:
> > > On Sun, Feb 12, 2023 at 09:04:26AM +0000, Eric Wong wrote:
> > >
> > >>  Sidenote: I'm curious about the reason $(pwd) is used in some
> > >>  places while $PWD seems fine in others, so it doesn't seem to be
> > >>  a portability problem.  I chose $PWD since it's faster.
> > > It sometimes matters; one is a Windows path (with "C:\", etc) and one is
> > > a Unix-style path. Many spots are happy with either type, but it
> > > sometimes bites us when doing string comparisons, or in a few specific
> > > cases. See
> > >
> > >   https://lore.kernel.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/
> > >
> > > for an example.
> > >
> > There is guidance in t/README L680-684 though it maybe not that easy to
> > spot.
> > 
> > A more recent patch was
> > https://lore.kernel.org/git/4f5c5633-f5a2-3c99-329e-3057b8d447d2@kdbg.org/
> > with slightly more details.
> 
> Thanks, both explanations are much better than the one I found (my
> digging in the archive consisted of "I know JSixt has corrected me on
> this at least once...").

Thanks both.  Looks like my use of GIT_TRACE="$PWD"/trace is
fine and there's plenty of examples where $PWD is used for
GIT_TRACE* in our test suite (`git grep GIT_TRACE.*PWD')

Any comments on the actual change itself?  Thanks again.
