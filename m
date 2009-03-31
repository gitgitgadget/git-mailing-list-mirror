From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add warning about known issues to documentation of
	cvsimport
Date: Tue, 31 Mar 2009 15:40:56 -0400
Message-ID: <20090331194056.GA23102@coredump.intra.peff.net>
References: <20090323195304.GC26678@macbook.lan> <20090324031448.GA12829@coredump.intra.peff.net> <20090330223646.GC68118@macbook.lan> <20090331112812.GA2090@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:42:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LojrC-00086f-AY
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 21:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbZCaTlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 15:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbZCaTlM
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 15:41:12 -0400
Received: from peff.net ([208.65.91.99]:33555 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573AbZCaTlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 15:41:10 -0400
Received: (qmail 12498 invoked by uid 107); 31 Mar 2009 19:41:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 15:41:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 15:40:56 -0400
Content-Disposition: inline
In-Reply-To: <20090331112812.GA2090@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115302>

On Tue, Mar 31, 2009 at 07:28:12AM -0400, Jeff King wrote:

> On Tue, Mar 31, 2009 at 12:36:46AM +0200, Heiko Voigt wrote:
> 
> > > Note the extra blank line between each heading and its list, and the
> > > lack of a blank line between the end of the first list and the heading
> > > of the second. Your source is very readable, so it really is just
> > > asciidoc being silly, but I wonder if there is a way to work around
> > > that.
> > 
> > My xmlto is not working at the moment. I will check that.
> 
> I looked into it a little more; it happens all over the place, so it is
> a problem somewhere in the documentation toolchain. So don't worry about
> it for this particular patch.

I looked into it more and posted to the docbook-apps list.  Here's what
I found out: the problem is fixed in docbook-xsl 1.74.3. However, our
template to prevent extra .sp in manpage-base.xml prevents it.

That fix is in 7ef0435 (spurious .sp in manpages, 2006-12-13), and I get
good output by reverting it and using docbook 1.74.3.

Going back to the original discussion, it looks like it is a workaround
for docbook-xsl 1.69.0:

  http://article.gmane.org/gmane.comp.version-control.git/32957

Assuming that is correct, I think the sane choices are:

  1. drop the workaround, as that version of docbook-xsl is now several
     years old

     or

  2. turn the workaround off by default, but add a knob to turn it on
     (DOCBOOK_XSL_1690?)

Having it on by default and turning it off with a knob seems silly,
since most versions don't need it. Debian stable is shipping 1.73 these
days, which looks fine without 7ef0435. Are there other platforms still
shipping 1.69.0? Is it too old for us to care?

-Peff
