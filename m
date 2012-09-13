From: Jeff King <peff@peff.net>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 11:43:10 -0400
Message-ID: <20120913154309.GB726@sigill.intra.peff.net>
References: <20120913170943725232.01d717ef@gpio.dk>
 <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Jens Bauer <jens-lists@gpio.dk>
X-From: git-owner@vger.kernel.org Thu Sep 13 17:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCBZe-0001S7-Pn
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 17:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117Ab2IMPnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 11:43:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43550 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758337Ab2IMPnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 11:43:13 -0400
Received: (qmail 4561 invoked by uid 107); 13 Sep 2012 15:43:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 11:43:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 11:43:10 -0400
Content-Disposition: inline
In-Reply-To: <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205388>

On Thu, Sep 13, 2012 at 11:34:50AM -0400, Drew Northup wrote:

> > I've read that git supports two different line endings; either CRLF or LF, but it does not support CR.
> > Would it make sense to add support for CR (if so, I hereby request it as a new feature) ?
> 
> Even if Git can't do CRLF/LF translation on a file it will still store
> and track the content of it it just fine. In fact you probably want
> translation completely disabled in this case. 

Yeah. If the files always should just have CR, then just don't ask git
to do any translation (by not setting the "text" attribute, or even
setting "-text" if you have something like autocrlf turned on globally),
and it will preserve the bytes exactly. I suspect diffs will look nasty
because we won't interpret CR as a line-ending, though.

Do the files actually need line-by-line diffing and merging? If not,
then you are fine.

If so, then it would probably be nice to store them with a canonical LF
in the repository, but convert to CR on checkout. Git can't do that
internally, but you could define clean/smudge filters to do so (see the
section in "git help attributes" on "Checking-out and checking-in";
specifically the "filter" subsection).

-Peff
