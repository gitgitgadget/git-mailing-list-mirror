From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-add: fix command line building to call
	interactive
Date: Sun, 25 Nov 2007 23:14:38 -0500
Message-ID: <20071126041437.GA6471@sigill.intra.peff.net>
References: <1195996542-86074-1-git-send-email-win@wincent.com> <7vd4tynqpw.fsf@gitster.siamese.dyndns.org> <F09249EB-475A-4352-A3A1-A8B15D2A94FF@wincent.com> <7vlk8mmatu.fsf@gitster.siamese.dyndns.org> <22CBC161-57C2-4A7E-9415-CE8117758A44@wincent.com> <7vprxyksxf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwVN9-0004V7-AQ
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 05:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbXKZEOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 23:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbXKZEOm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 23:14:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3369 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbXKZEOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 23:14:41 -0500
Received: (qmail 17381 invoked by uid 111); 26 Nov 2007 04:14:39 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 25 Nov 2007 23:14:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Nov 2007 23:14:38 -0500
Content-Disposition: inline
In-Reply-To: <7vprxyksxf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66040>

On Sun, Nov 25, 2007 at 11:48:28AM -0800, Junio C Hamano wrote:

> > 	git-add -i *.h
> >
> > (Note that's "*.h" and not "\*.h"). In the Git repository, without  
> > validation, this just works. With strict validation, it would complain...
> 
> I'd mostly agree, but we need to realize that this is a two edged sword.
> Pathspecs can be leading-directories or fileglobs.  For fileglobs, you
> are right.  The user can let the shell do the globbing.  Not validating,
> however, also means that
> 
> 	git add -p Documentatoin
> 
> would report "there is nothing to patch" without being helpful, pointing
> out that the name of the directory is misspelled.

I think the problem there is not validation, but that the previous
proposal was validating the wrong thing. IOW, the user doesn't want a
complaint "this file is not tracked by git" (which catches untracked
things with *.h) but rather "this file does not even exist" (which
catches typos like Documentatoin).

So it is not really a git pathspec being provided (from the user's point
of view), but rather something else (a pathspec _or_ a working tree
file).

-Peff
