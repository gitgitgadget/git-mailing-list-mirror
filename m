From: Jeff King <peff@peff.net>
Subject: Re: git rev-list %an, %ae, %at bug in v1.7.10.1 and beyond
Date: Tue, 22 May 2012 02:13:28 -0400
Message-ID: <20120522061328.GA17896@sigill.intra.peff.net>
References: <CAGyf7-G3nNTTP1bKdd9HLKEn-8+LoxCeY2R08x9gKZwS0L_N6g@mail.gmail.com>
 <20120522043221.GA6859@sigill.intra.peff.net>
 <20120522043509.GB6859@sigill.intra.peff.net>
 <CAGyf7-Gj8YynENrnkZMT4WSEDtYpmUL5qaS4TEuvfaa_YcXxOw@mail.gmail.com>
 <20120522055811.GA10597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue May 22 08:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWiLh-0008M2-7I
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 08:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab2EVGNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 02:13:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51508
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab2EVGNb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 02:13:31 -0400
Received: (qmail 13368 invoked by uid 107); 22 May 2012 06:13:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 02:13:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 02:13:28 -0400
Content-Disposition: inline
In-Reply-To: <20120522055811.GA10597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198183>

On Tue, May 22, 2012 at 01:58:11AM -0400, Jeff King wrote:

>   $ git init
>   $ echo content >foo && git add foo
>   $ GIT_AUTHOR_NAME=a git commit -m msg
>    Author:  <>
>    1 file changed, 1 insertion(+)
>    create mode 100644 foo
> 
> Uh oh, that's odd. And worse:
> 
>   $ git log -1 --format='|%an <%ae>|'
>   | <>|
> 
> So there is definitely a bug. The unicode thing is a red herring, and if
> there was any unicode at some point, git stripped it out when making the
> commit. The real regression seems to be in single-character names.
> 
> I'll see if I can find the bug.

Both are caused by an off-by-one error in split_ident_line. I just
posted a patch.

-Peff
