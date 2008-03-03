From: Jeff King <peff@peff.net>
Subject: Re: Some issues working with empty/bare repositories...
Date: Mon, 3 Mar 2008 03:10:21 -0500
Message-ID: <20080303081021.GA6578@sigill.intra.peff.net>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:11:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW5lE-0003hS-KY
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 09:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbYCCIKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 03:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbYCCIKX
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 03:10:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4246 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbYCCIKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 03:10:23 -0500
Received: (qmail 12965 invoked by uid 111); 3 Mar 2008 08:10:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 03 Mar 2008 03:10:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2008 03:10:21 -0500
Content-Disposition: inline
In-Reply-To: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75906>

On Sat, Mar 01, 2008 at 07:40:39PM +0000, Reece Dunn wrote:

> Consider the following workflow:
> 
>     $ mkdir foo
>     $ cd foo
>     $ git --bare init
> 
>     $ git log
>     fatal: bad default revision 'HEAD'
> 
> This message is confusing for a newbie. Displaying "no commits" would
> make more sense here.

The tricky thing here is that "git log" doesn't know we have no
commits in the repo; it only knows that HEAD is bogus. But it may be
that we can just say something like:

  fatal: unable to resolve HEAD; do you have any commits?

>     $ git clone foo bar
>     Initialized empty Git repository in /home/reece/bar/.git/
>     $ ls -a /home/reece
>     . .. foo

As of 1.5.4, this now says "fatal: cannot clone empty repository". There
has been work recently on a C version of clone which tries to match the
sequence of "init && remote add && fetch && checkout" more closely. I
haven't looked closely, but I suspect it may just work (by which I mean
create an empty repo with origin config pointing to the parent repo).

> It appears from the git output (with the inconsistently capitalized
> git - see --version output above) that the clone succeeded, but it
> does not create bar/.git/, even though it said that it did.

It did create it...it just deleted it afterwards without telling you. :)

-Peff
