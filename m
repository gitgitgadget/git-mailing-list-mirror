From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: don't link to example mail addresses
Date: Sun, 16 Dec 2012 07:04:05 -0500
Message-ID: <20121216120405.GA14320@sigill.intra.peff.net>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
 <20121215182408.GD2725@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Dec 16 13:04:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkCxN-0005dk-Bx
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 13:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab2LPMEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 07:04:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56012 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab2LPMEP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 07:04:15 -0500
Received: (qmail 29558 invoked by uid 107); 16 Dec 2012 12:05:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 16 Dec 2012 07:05:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2012 07:04:05 -0500
Content-Disposition: inline
In-Reply-To: <20121215182408.GD2725@river.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211590>

On Sat, Dec 15, 2012 at 06:24:09PM +0000, John Keeping wrote:

> > I think I'd just render them monospace everywhere. We are very
> > inconsistent about which form of quotes we use in the documentation (I
> > think because most of the developers read the source directly and not
> > the rendered asciidoc). And then we don't have to worry about the "$$"
> > construct (and IMHO it makes the source much more readable, and marking
> > the address as a literal looks good in the output, too).
> 
> I agree that the source is more readable as monospaced, but I think we
> need to keep the quotes around the text in git-tag(1) and probably
> git-fast-import(1) so that it is differentiated from the surrounding
> text in the man page output.

Hmm, good point. I use MAN_BOLD_LITERAL, which serves that purpose, but
I guess not everyone does (and it is not the default; I wonder if it
should be).  But if MAN_BOLD_LITERAL is not in use, then `` literals
have zero typographical impact in the manpages.

So maybe we do need to do something else. I was just hoping we could get
away with something more readable in the source.

By my reading of the asciidoc user guide, the mechanism that is hurting
us is that mailto is an inline macro, and that foo@bar automatically
triggers that inline macro. Furthermore, the right way to suppress
expansion of macros is with a backslash escape. Doing this:

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index d1844ea..68bca1a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -427,7 +427,7 @@ Here `<name>` is the person's display name (for example
 
 Here `<name>` is the person's display name (for example
 ``Com M Itter'') and `<email>` is the person's email address
-(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
+(``\cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
 and greater-than (\x3e) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
 `<name>` and `<email>` are free-form and may contain any sequence

seems to produce the output we want. I think it's a little less ugly
than the "$$" quoting, but not by much. No clue if one is accepted by
more asciidoc versions or not.

-Peff
