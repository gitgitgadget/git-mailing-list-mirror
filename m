From: Jeff King <peff@peff.net>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 12:51:47 -0400
Message-ID: <20120730165147.GD16701@sigill.intra.peff.net>
References: <jv5tln$96e$1@dough.gmane.org>
 <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
 <CAFjFENqGTumBRkDX4vJjQhGz0CrEC1VU1cDHWCERywa8vjVbRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org
To: Thomas Badie <thomas.badie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtCG-0007xw-3z
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab2G3Qvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 12:51:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41500 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875Ab2G3Qvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:51:50 -0400
Received: (qmail 17546 invoked by uid 107); 30 Jul 2012 16:51:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jul 2012 12:51:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2012 12:51:47 -0400
Content-Disposition: inline
In-Reply-To: <CAFjFENqGTumBRkDX4vJjQhGz0CrEC1VU1cDHWCERywa8vjVbRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202579>

On Mon, Jul 30, 2012 at 06:40:12PM +0200, Thomas Badie wrote:

> I understand your opinion. My solution was a easier way to make your
> proposition about `git log --oneline`, because I don't want to copy these
> 6 numbers by hand. I'd prefer select the right line simply.
> 
> My solution is intended for people who just use git, and whatever their
> environment (Unix, Windows...) because all is contained in git.
> 
> But I clearly agree that there is a lot of other solutions by using external
> tools.  But IMHO, it is preferable that I just have to add a `-i' to a command
> to make this choice simply, and not having to use my WM for this kind of task.

I am pretty mouse-averse, and I find a nice solution to these sorts of
interactive-selection problems is to use your editor. In its most basic
form, something like:

  git log --oneline >tmp
  $EDITOR tmp ;# and delete everything you don't want
  git cherry-pick `cat tmp`

assuming you are proficient with your editor, finding the entry you want
and deleting all of the unwanted lines should be just a few keystrokes.
And you can simplify it with a script like this:

  $ cat `which vpipe`
  #!/bin/sh
  trap 'rm -f $tmp' 0
  tmp=`mktemp vpipe-XXXXXX` &&
  cat >$tmp &&
  ${EDITOR:-vi} $tmp </dev/tty >/dev/tty &&
  cat $tmp

which you can then use like:

  git cherry-pick `git log | vpipe`

I know that sort of thing is not for everyone (you have to really like
your editor), but I thought I'd share in case it is useful.

-Peff
