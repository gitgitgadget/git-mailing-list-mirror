From: Jeff King <peff@peff.net>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 09:51:11 -0400
Message-ID: <20090911135110.GA30860@coredump.intra.peff.net>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
 <20090911102329.GA13044@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, support@gitorious.org
To: Aloisio <aloisiojr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 15:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm6X0-0001S9-Lf
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 15:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbZIKNvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 09:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZIKNvN
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 09:51:13 -0400
Received: from peff.net ([208.65.91.99]:38847 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbZIKNvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 09:51:12 -0400
Received: (qmail 7325 invoked by uid 107); 11 Sep 2009 13:51:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 09:51:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 09:51:11 -0400
Content-Disposition: inline
In-Reply-To: <20090911102329.GA13044@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128193>

On Fri, Sep 11, 2009 at 06:23:29AM -0400, Jeff King wrote:

> > I faced a problem when trying to clone git://gitorious.org/qt/qt.git
> > 
> > this works:
> > git clone -n git://gitorious.org/qt/qt.git repo
> > 
> > this doesn't:
> > git clone -n git://gitorious.org/qt/qt.git repo >log
> > fatal: The remote end hung up unexpectedly
> > fatal: early EOF
> > fatal: index-pack failed
> 
> I can reproduce the problem here. But after staring at the strace for a
> long time, I don't think the problem is on the client side. The remote
> end _does_ hang up unexpectedly.
> 
> Looking at what we send, the only difference between the redirected and
> unredirected case I could find is that we send the "no-progress" flag to
> the server, which then hangs up on us instead of sending us the pack.
> Which makes no sense.

I did a little more testing, and I can't reproduce the problem against a
local git-daemon. I tried using several versions for the server, going
all the way back to v1.5.0, which pre-dates no-progress, and all of them
worked just fine.

So I am inclined to think there is something non-standard or broken at
gitorious.org. I'm cc'ing support@gitorious to see if they have any
comment.

-Peff
