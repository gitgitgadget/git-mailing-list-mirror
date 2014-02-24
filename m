From: Jeff King <peff@peff.net>
Subject: Re: Cygwin + git log = no pager!
Date: Mon, 24 Feb 2014 04:06:18 -0500
Message-ID: <20140224090618.GB10698@sigill.intra.peff.net>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
 <53085434.4060106@gmail.com>
 <CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
 <530AFAFD.2060504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 10:06:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHrUZ-0000YO-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 10:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbaBXJGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 04:06:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:55913 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751216AbaBXJGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 04:06:20 -0500
Received: (qmail 19401 invoked by uid 102); 24 Feb 2014 09:06:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 03:06:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 04:06:18 -0500
Content-Disposition: inline
In-Reply-To: <530AFAFD.2060504@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242582>

On Mon, Feb 24, 2014 at 08:55:41PM +1300, Chris Packham wrote:

> > Thanks for the response. I did set this environment variable in my
> > .bashrc like so:
> > 
> > export GIT_PAGER=less
> > 
> > However after I do a 'git log' it is just spitting it out all at once
> > and not entering the pager.
> > 
> 
> Um OK that was the obvious thing to try. There is also the config
> variable core.pager but GIT_PAGER should take precedence.

Presumably we are actually running what's in GIT_PAGER, but we can
double-check with:

  GIT_PAGER='echo custom pager' git log

You can also try:

  GIT_TRACE=1 git log

which should describe the pager being run.

> Could something be setting the environment variable LESS? Reading the
> git-config man page for core.pager git wants to set LESS to FRSX but if
> it is already set git takes that as an indication that you don't want to
> set LESS automatically.

We can also double-check the LESS setting in the executed pager:

  GIT_PAGER='echo LESS=$LESS' git log

If we are running less, and it is using FRSX, I'd suspect some kind of
terminal weirdness with less itself. With "-F", less will quit if the
whole output can be displayed; it's possible it thinks the screen is
bigger than it is.

Trying:

  GIT_PAGER=less LESS=RSX git log

might help.

-Peff
