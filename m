From: Jeff King <peff@peff.net>
Subject: Re: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 22:20:35 -0500
Message-ID: <20090301032035.GB30384@coredump.intra.peff.net>
References: <20090228.191206.75012167.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdcFl-0004Qz-7V
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 04:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbZCADUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbZCADUl
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:20:41 -0500
Received: from peff.net ([208.65.91.99]:50890 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755136AbZCADUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 22:20:40 -0500
Received: (qmail 28464 invoked by uid 107); 1 Mar 2009 03:20:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Feb 2009 22:20:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Feb 2009 22:20:35 -0500
Content-Disposition: inline
In-Reply-To: <20090228.191206.75012167.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111810>

On Sat, Feb 28, 2009 at 07:12:06PM -0800, David Miller wrote:

> From git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-next-2.6
>  * branch            master     -> FETCH_HEAD
> fatal: unable to read tree c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
> davem@sunset:~/src/GIT/net-next-2.6$ git show c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
> fatal: bad object c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
> davem@sunset:~/src/GIT/net-next-2.6$ 
> 
> Now, what's funny is that this tree object does exist in my
> tree on master.kernel.org:

"bad object" is about an object that did not parse correctly, as opposed
to one that is missing. So it's possible that your repository is
corrupted.

> I don't understand how this can happen, and I'd like to be able
> to diagnose this intelligently.

I'm not up on the latest techniques for verifying and fixing corruption.
But I think with recent enough git, you can grab a good copy of the
object from another repo and put it in

  .git/objects/c9/ee57c5c20c3b7a2d7784a4172aef8b34c3a844

that git would do the right thing.

> So, what is an easy way to figure out what commit references tree
> object X?

Try:

  git log --all --pretty=format:'%H %T' | grep c9ee57c5c | cut -d' ' -f1

keeping in mind that there may be multiple such commits.

-Peff
