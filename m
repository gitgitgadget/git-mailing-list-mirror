From: Jeff King <peff@peff.net>
Subject: Re: t/t1304: avoid -d option to setfacl (db82657)
Date: Tue, 29 Nov 2011 07:23:33 -0500
Message-ID: <20111129122333.GB30456@sigill.intra.peff.net>
References: <gitster/git/commit/db826571e4099066fe44233d95642591016c831b@github.com>
 <gitster/git/commit/db826571e4099066fe44233d95642591016c831b/729354@github.com>
 <CA+sFfMc6BCPvk1FCjZwyY_pWqXBut3D--OfrFEcfK5p97D-KHQ@mail.gmail.com>
 <D95BFEA0-BAC1-4CBD-8B56-27DB4BDF147C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	wsp 
	<reply+c-729354-3460aca0fa61e627f9d1a271cf70a99d5c1e7e4e-921167@reply.github.com>,
	Git Mailing List <git@vger.kernel.org>
To: Scott Parrish <wsparrish@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 13:23:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVMj2-0001fu-Vi
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 13:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab1K2MXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 07:23:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55636
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087Ab1K2MXg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 07:23:36 -0500
Received: (qmail 31134 invoked by uid 107); 29 Nov 2011 12:30:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 07:30:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 07:23:33 -0500
Content-Disposition: inline
In-Reply-To: <D95BFEA0-BAC1-4CBD-8B56-27DB4BDF147C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186055>

On Sat, Nov 19, 2011 at 03:28:49PM -0500, Scott Parrish wrote:

> > The abandoned POSIX draft does actually specify the FreeBSD behavior.
> > 
> > So I think it's kind of a toss-up.  Which option we choose should
> > probably depend on whether we get more test coverage by using the
> > "d[efault]" notation or by using the -d option.  That depends on
> > whether there are more Solaris users compiling git or whether there
> > are more FreeBSD users.  I don't know the answer to that either.  I
> > tend to think there are very few of either.
> 
> Is there a reason conditional logic can't be used (perhaps keying off
> of `uname -s` or the like) so that we have coverage in all cases?

It's nice if we can auto-detect such things based on behavior, and then
there's no need for maintaining a "uname -s" guess. Perhaps we can
check at the beginning of t1304 which one works (or neither), and set a
flag appropriately? It looks like we already check whether setfacl works
at all, so this would be a natural extension.

I started to do a "how about this" patch, but I realized that in order
to see whether "-d" worked as "default" versus "delete", we'll have to
check the output of "getfacl" to see if it reports the default entry.
And then I realized I have no idea what FreeBSD shows in such a case
(surely not "d:*", right?).

-Peff
