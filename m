From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: report bogus input to -C/-M/-B
Date: Thu, 21 Oct 2010 13:07:44 -0400
Message-ID: <20101021170744.GB15667@sigill.intra.peff.net>
References: <20101021144947.GA18210@sigill.intra.peff.net>
 <20101021165340.GE3732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 19:07:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ybh-0007lR-ML
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 19:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab0JURHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 13:07:04 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364Ab0JURHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 13:07:03 -0400
Received: (qmail 7824 invoked by uid 111); 21 Oct 2010 17:07:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 17:07:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 13:07:44 -0400
Content-Disposition: inline
In-Reply-To: <20101021165340.GE3732@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159526>

On Thu, Oct 21, 2010 at 11:53:40AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Before:
> > 
> >   $ git diff -CM
> >   $ echo $?
> >   128
> > 
> > After:
> > 
> >   $ git diff -CM
> >   error: invalid argument to -C: M
> >   $ echo $?
> >   128
> 
> Yes, please.
> 
> Who is it that exits(128) in this code path?  Are there other
> functions it calls that might return an error without reporting it to
> stderr?

It's setup_revisions(). It only happens when calling
handle_revision_opt(), which either succeeds, calls error() for its
error cases, or chains to diff_opt_parse(). The latter uses error()
appropriately except for the -B/-M/-C cases.

So I think we're good after this patch is applied.

-Peff
