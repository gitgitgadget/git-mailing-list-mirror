From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Mon, 23 Jul 2007 11:40:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231136530.14781@racer.site>
References: <20070723041741.GA22461@midwinter.com> <Pine.LNX.4.64.0707231059490.14781@racer.site>
 <46A481B4.7000502@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICvLQ-0002NT-KN
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985AbXGWKkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756632AbXGWKks
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:40:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:51197 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755991AbXGWKks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:40:48 -0400
Received: (qmail invoked by alias); 23 Jul 2007 10:40:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 23 Jul 2007 12:40:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194dcd15XN4scZjO/eAZGeqAfdApS8mt2pUw4/B++
	bAawq3Z+A1O33S
X-X-Sender: gene099@racer.site
In-Reply-To: <46A481B4.7000502@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53424>

Hi,

On Mon, 23 Jul 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > Up until here, I was with you.  But this feels very wrong.
> > 
> > Why not compare COMMIT_MSG to the templatefile, if there is one?  I.e.
> > 
> > test ! -z "$templatefile" && cmp "$GIT_DIR"/COMMIT_MSG "$templatefile" &&
> > 	die "Unchanged message; will not commit"
> >   
> 
> The template can itself have comments -- instructions or explanations of
> fields to fill in, for example -- and since comments have been stripped 
> from COMMIT_MSG at this point, a comparison against such a template 
> would always fail.

Ah, I missed that.  But IIRC your patch does not wrap that logic behind 
test ! -z "$templatefile", right?  So this is my modified suggestion:

test ! -z "$templatefile" && {
	grep -vie '^Signed-off-by:' < "$GIT_DIR"/COMMIT_MSG" > "$GIT_DIR"/tmp1
	grep -ve '^#' < "$templatefile" > "$GIT_DIR"/tmp1
	trap 'rm "$GIT_DIR"/tmp[12]' 0
	cmp "$GIT_DIR"/tmp[12] &&
	die "Unchanged message; will not commit"
}

Ciao,
Dscho
