From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] DEFAULT_DOC_TARGET
Date: Thu, 3 Jan 2013 17:25:37 -0500
Message-ID: <20130103222537.GA12128@sigill.intra.peff.net>
References: <1357239920-2201-1-git-send-email-gitster@pobox.com>
 <20130103203222.GB4632@sigill.intra.peff.net>
 <20130103210541.GA11783@sigill.intra.peff.net>
 <20130103210731.GB11783@sigill.intra.peff.net>
 <7v4nixx61c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 23:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqtEe-0005St-6C
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 23:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab3ACWZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 17:25:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42362 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808Ab3ACWZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 17:25:40 -0500
Received: (qmail 11271 invoked by uid 107); 3 Jan 2013 22:26:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 17:26:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 17:25:37 -0500
Content-Disposition: inline
In-Reply-To: <7v4nixx61c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212617>

On Thu, Jan 03, 2013 at 02:20:31PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Not surprising for such a large refactoring, but this has conflicts with
> > what's in next. Here's the patch to apply on top of the conflicted tree
> > you get from merging this with "next":
> 
> Yeah, verifying the manual fixup is a bit tricky indeed.  The output from
> 
>  $ git blame -C HEAD^.. -- config.mak.uname | grep '^[^^]'
> 
> shows only the first line of the resulting file, and the output from
> 
>  $ git blame --reverse -C HEAD^.. -- Makefile | grep '^^'
> 
> shows only the three-line "Platform specific tweaks" comment, which
> was replaced by your version in config.mak.uname, so nothing extra
> was added and nothing important was lost between the two, it seems.

Yeah, it's probably easier to do than verify. I knew that my patch was a
straight copy/paste move of the big if/else block, replacing it with the
include. So the obvious resolution is to mechanically move the "theirs"
block from next in the same way. And then the resulting diff shows the
fixup (which you can verify does not do anything fancy).

It's really the same logic that merge-recursive uses for full-file
renames, except that git is not smart enough to figure out that it was a
500-line block that moved, not the whole file. It comes up rarely enough
that it is probably not worth trying to teach the merge machinery about
code block movement. But it would be cool. :)

-Peff
