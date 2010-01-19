From: Jeff King <peff@peff.net>
Subject: Re: "warning: Updating the currently checked out branch may cause
 confusion" on bare repositories
Date: Tue, 19 Jan 2010 17:43:44 -0500
Message-ID: <20100119224343.GA11758@coredump.intra.peff.net>
References: <xuu2ska3doix.fsf@nowhere.com>
 <20100119062904.GB23212@spearce.org>
 <xuu2my093owy.fsf@nowhere.com>
 <20100119185906.GF23466@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXMne-0005pv-MF
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 23:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab0ASWnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 17:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755833Ab0ASWnr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 17:43:47 -0500
Received: from peff.net ([208.65.91.99]:37728 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab0ASWnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 17:43:46 -0500
Received: (qmail 26653 invoked by uid 107); 19 Jan 2010 22:48:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 Jan 2010 17:48:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2010 17:43:44 -0500
Content-Disposition: inline
In-Reply-To: <20100119185906.GF23466@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137500>

On Tue, Jan 19, 2010 at 10:59:06AM -0800, Shawn O. Pearce wrote:

> Adam Megacz <adam@megacz.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > > That should already be the case.  Did you create the bare repository
> > > by taking a copy of a non-bare's .git directory?  Check your bare
> > > repository's config file and see if core.bare = false, if so set
> > > it to true to signal it really is bare.
> > 
> > Hrm, is there a reason why this is explicitly configured rather than
> > detected?
> 
> I don't know why we do this.  I think its because the guessing
> logic can guess wrong sometimes.

Yup, although I am having trouble finding any actual discussion of when
it can go wrong. There is some mention here:

  http://article.gmane.org/gmane.comp.version-control.git/35993

and a little bit here in the 1.5.0 release notes:

  http://article.gmane.org/gmane.comp.version-control.git/39612

But the latter talks about the heuristic being "does it end with .git",
which I don't think we actually use anymore. So who knows if the
heuristic failures are even trigger-able anymore. I tried looking at the
setup code for an answer, but my eyes started bleeding from the horrible
spaghetti code and I couldn't make out any of the text.

> Its rare to see it fail.  But I think it can fail if you create
> a file called HEAD in the top level of your source code tree.
> (For example.)

I don't think that would do it. When looking for a git dir we check for
a well-formed HEAD, as well as objects and refs directories. The is_bare
check seems to be more about "did we actually find a workdir" these
days.

-Peff
