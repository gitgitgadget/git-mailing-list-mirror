Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660D8200E0
	for <e@80x24.org>; Wed, 28 Dec 2016 06:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750834AbcL1GIp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 01:08:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:60886 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbcL1GIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 01:08:44 -0500
Received: (qmail 2724 invoked by uid 109); 28 Dec 2016 06:08:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 06:08:44 +0000
Received: (qmail 15988 invoked by uid 111); 28 Dec 2016 06:09:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 01:09:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 01:08:41 -0500
Date:   Wed, 28 Dec 2016 01:08:41 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "John P. Hartmann" <jphartmann@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: HowTo distribute a hook with the reposity.
Message-ID: <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
 <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 09:32:22PM -0800, Jacob Keller wrote:

> On Tue, Dec 27, 2016 at 5:34 PM, John P. Hartmann <jphartmann@gmail.com> wrote:
> > I would like a hook in .got/hooks to be made available to all who clone or
> > pull a particular project.  I'd also like the hook to be under git control
> > (changes committed &c).  I added a hook, but git status does not show it.
> > Presumably git excludes its files in .git/ from version control lest there
> > be a chiken-and-egg situation.
> >
> > Is there a way to achieve this?  Or a better way to do it?
> >
> > Thanks,  j.
> 
> Best way I found, was add a script with an "installme" shell script or
> similar that you tell all users of the repository that they are
> expected to run this to install the scripts. You can' make it happen
> automatically.

I agree that is the best way to do it.

I didn't dig up previous discussions, but the gist is usually:

  1. Cloning a repository should not run arbitrary code from the remote
     without the user on the cloning side taking some further affirmative
     action.

     This is for security reasons. Obviously the next step is quite often
     to run "make" which does run arbitrary code, but that counts as an
     action.

  2. We could write a feature in git that manages hooks (or config, etc).
     But ultimately you would still be running "git clone
     --trust-remote-hooks" or something to satisfy point (1).

  3. There's not much point in doing point (2), because you can just
     spell it as "git clone && cd clone && ./install-hooks" and then git
     does not have to care at all about your scripts.

  4. A hook (or config) management system could do fancy things like
     merging your custom local config, picking up changes from the
     remote, etc. But all of that can happen outside of Git totally (and
     quite often you want to manage things in contributors setups
     _besides_ Git data anyway).

     An example system is:

       https://github.com/Autodesk/enterprise-config-for-git

     (with the disclaimer that I've never used it myself, so I have no
     idea how good it is).

I think you probably know all that, Jake, but I am laying it out for the
benefit of the OP and the list. :)

-Peff
