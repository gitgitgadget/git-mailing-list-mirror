From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-import: catch deletion of non-existent file in input
Date: Sun, 15 Jul 2012 20:26:52 -0400
Message-ID: <20120716002652.GA27304@sigill.intra.peff.net>
References: <87ehogrham.fsf@bitburger.home.felix>
 <20120712210138.GA15283@sigill.intra.peff.net>
 <m2pq80uj56.fsf@igel.home>
 <20120713130246.GB2553@sigill.intra.peff.net>
 <m2hatbvkyh.fsf@igel.home>
 <20120715102300.GA28667@sigill.intra.peff.net>
 <20120715181151.GA1986@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Felix Natter <fnatter@gmx.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 02:27:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqZ9P-0000t4-W0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 02:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab2GPA0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 20:26:55 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:60438
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab2GPA0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 20:26:54 -0400
Received: (qmail 23219 invoked by uid 107); 16 Jul 2012 00:26:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 15 Jul 2012 20:26:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jul 2012 20:26:52 -0400
Content-Disposition: inline
In-Reply-To: <20120715181151.GA1986@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201490>

On Sun, Jul 15, 2012 at 01:11:51PM -0500, Jonathan Nieder wrote:

> > Subject: fast-import: catch deletion of non-existent file in input
> [...]
> > We silently ignored the bogus "D foo" directive, and the
> > resulting tree incorrectly contained "bar". With this patch,
> > we notice the bogus input and die.
> 
> This breaks svn-fe, which relies on the existing semantics when asked
> to copy an empty directory.

Thanks for the report. I had a worry while writing this that somebody
was relying on the behavior. Let's just drop it, then. It's nice to
catch errors in exporters, but not at the expense of compatibility
issues.

We could introduce a new feature bit, but I'm not sure it is really
worthwhile. The older versions of bzr-fast-export would not set the bit
anyway, and newer versions are already fixed, so it is kind of closing
the barn door after the horse has left (we might catch other bugs, but
this one is kind of oddly specific; if somebody wanted to audit
fast-import for other similar cases and introduce a "strict" feature
bit, that might be worthwhile. But for this single change, I don't think
so).

> Let's repeat that for emphasis: API breaks in fast-import not guarded
> with a new "feature" type are not ok.

Totally agree. The question in my mind was whether this was a bug fix or
an API change, and it sounds like it is too far towards the latter.

-Peff
