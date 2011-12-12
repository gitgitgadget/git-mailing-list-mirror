From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] mv: honor --verbose flag
Date: Mon, 12 Dec 2011 16:45:16 -0500
Message-ID: <20111212214516.GC9754@sigill.intra.peff.net>
References: <20111212074503.GB16511@sigill.intra.peff.net>
 <20111212075124.GB17532@sigill.intra.peff.net>
 <7vwra136tj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDga-0001vn-6T
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab1LLVpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:45:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48337
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab1LLVpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:45:19 -0500
Received: (qmail 5695 invoked by uid 107); 12 Dec 2011 21:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 16:51:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 16:45:16 -0500
Content-Disposition: inline
In-Reply-To: <7vwra136tj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186957>

On Mon, Dec 12, 2011 at 11:53:28AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The code for a verbose flag has been here since "git mv" was
> > converted to C many years ago, but actually getting the "-v"
> > flag from the command line was accidentally lost in the
> > transition.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > This has been broken since 2006, so I guess nobody really cares. But
> > it's simple to fix.
> 
> Heh. It means nobody exercised the codepaths that are inside "if (verbose)",
> so it may uncover old bugs, no?

I thought that at first, too, but actually there is only one code path
currently enabled by "verbose", and it is to print "Renaming ...". You
can also exercise that code path with "--dry-run" (and the whole path
consists of only a single printf, so hopefully we didn't manage to
squeeze any bugs in there).

Once upon a time, the verbose flag was passed on to add_file_to_index,
but that was dropped when the code switched to using
rename_index_entry_at in 81dc230 (git-mv: Keep moved index entries
inact, 2008-07-21).

-Peff
