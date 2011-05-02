From: Jeff King <peff@peff.net>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Mon, 2 May 2011 15:33:21 -0400
Message-ID: <20110502193321.GB10487@sigill.intra.peff.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:33:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGys4-0000YG-BA
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab1EBTdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:33:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44956
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab1EBTdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:33:23 -0400
Received: (qmail 7895 invoked by uid 107); 2 May 2011 19:35:06 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 May 2011 15:35:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2011 15:33:21 -0400
Content-Disposition: inline
In-Reply-To: <7vr58glxro.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172624>

On Mon, May 02, 2011 at 12:15:23PM -0700, Junio C Hamano wrote:

> Either end of revision range operator can be omitted to default to
> HEAD, as in "origin.." (what did I do since I forked) or "..origin" (what
> did they do since I forked).  But this resulted in ".." to be interpreted
> as an empty range "HEAD..HEAD", and worse yet, because ".." does exist on
> the filesystem, we get this annoying output:
> 
>   $ cd Documentation/howto
>   $ git log .. ;# give me recent commits that touch Documentation/ area.
>   fatal: ambiguous argument '..': both revision and filename
>   Use '--' to separate filenames from revisions
> 
> Surely we could say "git log .. --", but we shouldn't have to.

I got slightly confused reading this, because I thought at first you
wanted ".." to be some kind of magic rev specifier. In particular, your
last line should say:

  git log -- ..

no?

I finally figured it out by reading your example carefully.

As far as the patch goes, I think it is the right thing to do. We should
probably disallow ".." as a revision (because it is nonsensical to ask
for, just as it would be to ask for a non-existent ref). And then the
only sane thing is to consider it as a path.

I didn't check, but what does your patch do with:

  $ cd "`git rev-parse --show-toplevel`"
  $ git log ..

?

-Peff
