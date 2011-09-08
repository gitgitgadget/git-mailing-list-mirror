From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Pushing with --mirror over HTTP?
Date: Wed, 7 Sep 2011 22:58:16 -0400
Message-ID: <20072.12104.965815.994761@winooski.ccs.neu.edu>
References: <20068.19089.303108.950233@winooski.ccs.neu.edu>
	<20110907213950.GI13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 04:58:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Uov-0002A5-H6
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 04:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757943Ab1IHC6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 22:58:24 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:40360 "EHLO
	winooski.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757938Ab1IHC6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 22:58:24 -0400
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id p882wJSI028408;
	Wed, 7 Sep 2011 22:58:19 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id p882wHCX028405;
	Wed, 7 Sep 2011 22:58:17 -0400
In-Reply-To: <20110907213950.GI13364@sigill.intra.peff.net>
X-Mailer: VM 8.1.93a under 23.2.1 (x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180935>

5 hours ago, Jeff King wrote:
> On Mon, Sep 05, 2011 at 12:05:37AM -0400, Eli Barzilay wrote:
> 
> > Is there anything broken with pushing with mirror over HTTP?  I'm
> > trying that with a github url, and I get a broken-looking error
> > message:
> > 
> >   remote part of refspec is not a valid name in :.have
> 
> It's probably nothing to do with http, but rather with alternate
> object databases on the server (which GitHub uses heavily). The
> server hands out fake ".have" refs telling you it has some other
> branch tips to base packs off of. So I suspect the "push --mirror"
> code is simply wrong for trying to update those refs (it may be
> exacerbated by using http, though, as the remote helper code seems
> to have some extra checks).

Ah -- I thought that this was some result of parsing some text message
or something like that, maybe if the error was

  remote part of refspec is not a valid name in ":.have"

or even

  remote part of refspec is not a valid name in: :.have

it would have been clearer?  Seems like it's a good place for this
since some `:foo' is likely to appear there, and the colon can be
confused as part of the text.

Also, maybe the man page should say something about `--mirror' not
working well with such servers?  It looks to me like mirroring to
github and to google code would be pretty popular.


> > and with the google code, I get:
> > 
> >   error: unable to push to unqualified destination: HEAD
> > 
> > Pushing to both of these work fine without `--mirror'.
> 
> This one, I'm not sure. It may be related.
> 
> > (BTW, as a workaround, I'm using
> >   push --force --tags <url> :
> > is this achieving the same effect for a repo without weird refs?)
> 
> Not quite. I think:
> 
>   git push --force <url> refs/*:refs/*
> 
> would be closer.

Thanks -- I'll use that instead.


> But even that's not quite right.  I believe that "--mirror" will
> also delete any remote refs that don't exist locally (which is why
> you are seeing the ":.have" refspec above, which attempts to delete
> it).

Is there some way of doing that?  (We do use a branch during releases
that is deleted after the release, so I need to propagate these
deletions.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
