From: Jeff King <peff@peff.net>
Subject: Re: Pretty date option for git tag?
Date: Mon, 18 May 2009 13:45:47 -0400
Message-ID: <20090518174547.GA14509@sigill.intra.peff.net>
References: <20090518151440.GA10536@andros.its.yale.edu> <4A118696.80902@drmicha.warpmail.net> <alpine.LFD.2.01.0905181015080.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, dloewenherz@gmail.com,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 18 19:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M66uT-0002Pu-Ss
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 19:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbZERRpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 13:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbZERRps
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 13:45:48 -0400
Received: from peff.net ([208.65.91.99]:43063 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbZERRps (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 13:45:48 -0400
Received: (qmail 18532 invoked by uid 107); 18 May 2009 17:45:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 18 May 2009 13:45:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 May 2009 13:45:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0905181015080.3301@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119460>

On Mon, May 18, 2009 at 10:20:49AM -0700, Linus Torvalds wrote:

> It's a rather expensive operation, but it does have the really nice 
> property that it will show the date of the commit the tag is pointing to, 
> rather than necessarily the date of the tag itself (which is not 
> well-defined unless the tag is signed).

It seems like you should be able to script around for-each-ref and
remain efficient, but I don't think there is a way to convince it to
dereference tags. Something like:

  git for-each-ref --format='%(refname)
  Tag: %(taggername) %(taggeremail) %(taggerdate)
  Commit: %(authorname) %(authoremail) %(authordate)
  ' refs/tags

almost works, but the commit fields are always empty. So I think you
would have to parse and manually rev-parse each one.

-Peff

PS The for-each-ref command above caused a segfault when run in git.git.
   Patch to follow.
