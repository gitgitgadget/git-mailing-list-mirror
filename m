From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 19:14:27 -0400
Message-ID: <20080501231427.GD21731@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com> <20080501153457.GB11469@sigill.intra.peff.net> <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri May 02 01:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrhzj-0004iO-Ul
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 01:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933962AbYEAXOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 19:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933951AbYEAXO3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 19:14:29 -0400
Received: from peff.net ([208.65.91.99]:1554 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933917AbYEAXO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 19:14:28 -0400
Received: (qmail 11491 invoked by uid 111); 1 May 2008 23:14:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 19:14:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 19:14:27 -0400
Content-Disposition: inline
In-Reply-To: <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80946>

On Thu, May 01, 2008 at 12:12:33PM -0700, Steven Grimm wrote:

> However, that leaves the question of which default will be wrong the  
> least often.
>
> In my personal experience, I think a directory rename has almost always 
> meant that I would want new files to appear in the new directory rather 

I do agree that the rename is probably more often desired.

> Of course, the discussion is moot anyway until someone writes code to  
> detect the situation; my impression is the current behavior is the way it 
> is simply because it's what naturally happens in the absence of  
> merge-time detection of a directory getting renamed.

Yes, I think that is largely a correct impression (although I think
Linus has spoken out against directory renaming in the past, so there is
at least a little bit of conscious effort). I suspect the right sequence
of steps to implement this would be:

  1. write a proof-of-concept that shows directory renaming after the
    fact (e.g., take a conflicted merge, scan the diff for directory
    renames, and then fix up the files). That way it is available, but
    doesn't impact git at all.

  2. If people think it is useful, build it into the diff and merge
     machinery so that it can happen automagically, but make it
     optional. Thus git fully supports it, but the policy decision is
     left up to the user.

  3. Make it the default if it is the common choice.

So we just need somebody to volunteer to work on 1. ;)

-Peff
