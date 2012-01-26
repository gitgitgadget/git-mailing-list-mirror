From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Thu, 26 Jan 2012 12:29:48 -0500
Message-ID: <20120126172948.GC5278@sigill.intra.peff.net>
References: <20120125214625.GA4666@sigill.intra.peff.net>
 <1af46e50-fdc5-47b8-af36-d070d91dd954@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 18:29:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqT93-0001YC-HO
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 18:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab2AZR3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 12:29:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45853
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557Ab2AZR3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 12:29:52 -0500
Received: (qmail 27397 invoked by uid 107); 26 Jan 2012 17:36:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 12:36:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 12:29:48 -0500
Content-Disposition: inline
In-Reply-To: <1af46e50-fdc5-47b8-af36-d070d91dd954@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189156>

On Thu, Jan 26, 2012 at 08:51:52AM -0500, Stephen Bash wrote:

> >   $ cat .gitattributes
> >   *.pdf filetype=pdf
> >   $ cat .git/config
> >   [filetype "pdf"]
> >           binary = true
> >           textconv = pdf2txt
> 
> Looking at this purely as a user, what difference/advantage would that bring versus
> 
>   $ cat .gitattributes
>   *.pdf binary=true textconv=pdf2text

For "binary", probably not much. But for textconv, it is all about the
split between attributes and config, as mentioned below:

> To partially answer my own question: one advantage of putting the
> filetype information in a config file is it allows system- and
> user-wide filetype settings.  In my personal experience I've always
> handled that information on a per-repository basis, but that doesn't
> mean everyone would want to.

Right. Setting things system-wide instead of per-repo is one advantage.
But more important is that attributes are not per-repo, but rather
"per-project". They get committed, and everybody who works on the
project shares them.

In your example, the gitattributes get committed, and the project is
mandating "you _will_ use pdf2text to view diffs of these files". But
that may not be appropriate for everybody who clones. Somebody may have
a different pdf-to-text converter. Somebody may simply have pdf2txt at a
different path, or need different options. Or somebody may want to skip
it altogether and use an external diff command, or even just see the
files as binary.

By splitting the information across the two files, the project gets to
say "this file is of type pdf", and then each user gets to decide "how
do I want to diff pdf files?"

-Peff
