From: Jeff King <peff@peff.net>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Thu, 2 Jun 2011 22:52:26 -0400
Message-ID: <20110603025226.GA32600@sigill.intra.peff.net>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <m31uzdxjf9.fsf@localhost.localdomain>
 <20110601225128.GB16820@sigill.intra.peff.net>
 <201106022202.33393.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 04:52:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSKV0-0001NZ-83
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 04:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab1FCCw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 22:52:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54485
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab1FCCw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 22:52:29 -0400
Received: (qmail 3315 invoked by uid 107); 3 Jun 2011 02:52:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 22:52:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 22:52:26 -0400
Content-Disposition: inline
In-Reply-To: <201106022202.33393.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174993>

On Thu, Jun 02, 2011 at 10:02:31PM +0200, Jakub Narebski wrote:

> > No, that is always supposed to be a symbolic ref. Making it a real ref
> > would be confusing. I don't think fetch should look at HEAD at all; it's
> > outside its refspec. However, clone does treat HEAD specially, and
> > should probably convert the remote's detached HEAD into a local detached
> > HEAD (we already do if it's part of referenced history).
> 
> Hmmm... in ordinary case (not on detached HEAD) "git fetch" would never
> modify my local branches nor my local HEAD.

Right. Fetch should never touch those things. Nor should it ever touch
refs/remotes/$remote/HEAD, as that is not really "where is the remote
HEAD pointing" but rather "what would I like the alias $remote to point
to"? Clone sets it to the remote HEAD, as that is the most obvious
choice; but if the user changes it, we should leave their choice in
place.

> On the other hand IIRC origin/HEAD do not follow switching branches at
> origin, and is staying at the value at clone (or "git remote
> set-head"), isn't it?

Right.

> So what to do when HEAD on origin is detached?  Modify .git/HEAD, or
> maybe .git/refs/remotes/origin/HEAD?

I don't think fetch should do _anything_ with the remote HEAD. It's
outside of its refspec scope. This is purely about what clone should do,
and that's an easier problem, because it's not "modify" but rather
"create".

-Peff
