From: Jeff King <peff@peff.net>
Subject: Re: [Patch 0/5] Create single PDF for all HTML files
Date: Sat, 6 Oct 2012 15:32:05 -0400
Message-ID: <20121006193205.GD3644@sigill.intra.peff.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Sat Oct 06 21:32:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKa7O-0002J4-8l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 21:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab2JFTcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 15:32:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43187 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab2JFTcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 15:32:09 -0400
Received: (qmail 10236 invoked by uid 107); 6 Oct 2012 19:32:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 15:32:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 15:32:05 -0400
Content-Disposition: inline
In-Reply-To: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207173>

On Sat, Oct 06, 2012 at 05:51:15PM +0200, Thomas Ackermann wrote:

> I wanted to have a single PDF file which contains the complete Git documentation 
> (except user-manual) for easier reading on my tablet. The simplest way to do 
> this was by using wkhtmltopdf which can combine a set of HTML files into a sinlge 
> PDF file and also apply some reformatting. To this end HTML files for all the missing 
> files in Documentation/technical and Documentation/howto and also for all the 
> release notes in Documentation/RelNotes were created. 

It seems like a reasonable goal. I do not have a strong opinion on the
approach or how the final output looks, but I wasn't able to actually
get output at all after applying your patches. Running "make fullpdf"
(after installing dblatex) got me:

  The switch --book, is not support using unpatched qt, and will be
  ignored.The switch --footer-html, is not support using unpatched qt,
  and will be ignored.The switch --disable-external-links, is not
  support using unpatched qt, and will be ignored.

after which wkhtmltopdf began pegging my CPU. I let it run for 10
minutes before giving up.

Another way of doing this would be to format the individual troff
manpages into dvi or postscript, convert that into pdf, and then
concatenate that. Something like:

  for i in *.[157]; do
    man -Tdvi -l "$i" >"$i.dvi"
    dvipdfm "$i"
  done
  pdftk *.[157].pdf cat output full.pdf

works for me, though obviously that does not handle some of the non-man
items you included. No idea on how the output compares to yours, but
it's something you may want to look at.

-Peff
