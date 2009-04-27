From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and
	Mercurial
Date: Mon, 27 Apr 2009 14:15:02 -0700
Message-ID: <20090427211502.GI23604@spearce.org>
References: <200904260703.31243.chriscool@tuxfamily.org> <alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 23:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyYAa-0006G3-Oa
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 23:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbZD0VPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZD0VPE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 17:15:04 -0400
Received: from george.spearce.org ([209.20.77.23]:55158 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZD0VPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 17:15:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F274738215; Mon, 27 Apr 2009 21:15:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117715>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 26 Apr 2009, Christian Couder wrote:
> 
> > For information, now Google Code supports Mercurial [...]
> > 
> > Mercurial was choosen over Git because of this (one year old) analysis:
> > 
> > http://code.google.com/p/support/wiki/DVCSAnalysis
> 
> FWIW some little bird (yes, related to the Google Code team) told me that 
> the real reason was because [...]

There were certainly technical factors involved.

As the DVCSAnalysis document above describes, Hg's relatively
efficient custom Hg-in-HTTP protocol performs about as well as git://
does, but requires only stateless HTTP, rather than a stateful
direct TCP connection.

There is a fundemental reason why Google App Engine only supports
incoming HTTP connections on 80/443.  Its easy to stand up a new
application behind the existing load balancers.  Its quite a bit
more effort to add support for yet-another-protocol.

As the recent discussion on eclipse.egit

  http://www.eclipse.org/newsportal/article.php?id=34&group=eclipse.egit#34

showed, many users are stuck behind corporate firewalls where only
HTTP transit is available.

Tossing aside the Google server infrastructure and why HTTP might be
preferred there, Google also tries to target the widest user base
possible.  Running your VCS through HTTP, which can be easily run
through a corporate proxy, gives a wider user base than running your
VCS through an SSH tunnel, or a relatively new IANA assigned port.

A long-time GCC committer, and an old SVN committer, pointed out
to me the other day that the reason why SVN uses HTTP is so it
can get around corporate firewalls without involving the IT staff.
Because for the past 10 years, being "on the Internet" has meant
being "behind an HTTP and SMTP proxy".  And "tunneling through HTTP"
is somehow safe, no matter how insecure the protocol might be;
while opening an IANA assigned port causes the world to end.

IOW, if Git wants to expand into these user communities where the
individual is stuck behind a corporate proxy that only permits HTTP
"for security reasons" (but blindly winds up passing through whatever
it gets), we need to support a more efficient HTTP protocol.

-- 
Shawn.
