From: Jeff King <peff@peff.net>
Subject: Re: PostScript files: textconv and "git add -p"
Date: Wed, 5 Jan 2011 00:18:07 -0500
Message-ID: <20110105051807.GB5884@sigill.intra.peff.net>
References: <vpqy670brcb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 05 06:22:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaLpb-0001WP-FJ
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 06:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948Ab1AEFSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 00:18:16 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40879 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab1AEFSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 00:18:16 -0500
Received: (qmail 28880 invoked by uid 111); 5 Jan 2011 05:18:12 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 05:18:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 00:18:07 -0500
Content-Disposition: inline
In-Reply-To: <vpqy670brcb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164546>

On Tue, Jan 04, 2011 at 04:50:44PM +0100, Matthieu Moy wrote:

> If I do this:
> 
> ,----[ .gitattributes ]
> | *.ps diff=ps
> `----
> 
> ,----[ .gitconfig ]
> | [diff "ps"]
> |       textconv=ps2ascii
> `----
> 
> then I get the textconv niceness when running "git diff", which is
> cool, but "git add -p" still proposes me to stage hunks one by one,
> which isn't.
> 
> If I set "*.ps binary" in .gitattributes, "git add -p" becomes quiet,
> but textconv is disabled.

Yeah the "binary" attribute (which is a synonym for !diff along with
some crlf stuff) and "diff" are mutually exclusive. One says "don't diff
this" and the other says "diff this according to some special rules".
But fortunately, those special rules can contain "this is binary". So
you can get what you want with:

  echo '*.ps diff=ps' >.gitattributes
  git config diff.ps.textconv ps2ascii
  git config diff.ps.binary true

which will textconv the file in the usual places, but consider it binary
in all other circumstances (like "add -p").

-Peff

PS Your question made me very happy. I implemented "diff.*.binary" the
   way I did out of a vague sense of orthogonality, but I never quite
   came up with a concrete example where it was useful to set both.
   Thanks for providing one. :)
