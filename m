From: Jeff King <peff@peff.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 2 Apr 2013 12:51:28 -0400
Message-ID: <20130402165128.GA19712@sigill.intra.peff.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
 <7vtxnogbft.fsf@alter.siamese.dyndns.org>
 <20130402163034.GA19252@sigill.intra.peff.net>
 <7vhajog9xp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Larres <jan@majutsushi.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:52:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4RG-0008Kc-6b
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761652Ab3DBQvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:51:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52304 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760598Ab3DBQvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:51:32 -0400
Received: (qmail 11054 invoked by uid 107); 2 Apr 2013 16:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 12:53:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 12:51:28 -0400
Content-Disposition: inline
In-Reply-To: <7vhajog9xp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219796>

On Tue, Apr 02, 2013 at 09:43:30AM -0700, Junio C Hamano wrote:

> > In some systems, yes, but git does not have any notion of "doc/" as an
> > item (after all, we track content in files, not directories), so I do
> > not see what it means to specify a directory except to say "everything
> > under it has this property".
> 
> That was true back when gitattributes (and ignore) was defined to
> apply only to the paths we track.  But export-ignore abuses the
> attrtibute system, allows a directory to be specified in the match
> pattern, and we declared that is a kosher use by the patch that
> caused 1.8.1.X regression, no?  So "Git does not have any notion of
> "doc/' as an item" is no longer true, I think.

Yes, but as I explained later, the meaning of "apply an attribute to
dir" in such cases is always equivalent to "apply attribute
recursively to dir/*". So I do not think we are violating that rule to
recursively apply all attributes.

But let's take a step back. I think Jan is trying to do a very
reasonable thing: come up with the same set of paths that git-archive
would. What's the best way to solve that? Recursive application of
attributes is one way, but is there another way we could help with
solving that?

Using:

  git ls-tree --name-only -zrt HEAD |
  git check-attr --stdin -z export-ignore

means we can find out that "foo/" is ignored. But he would have to
manually post-process the output to see that "foo/bar" is below "foo".
Not impossible, but I just wonder if git can be more helpful in figuring
this out.

-Peff
