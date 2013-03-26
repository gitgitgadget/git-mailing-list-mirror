From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fast-import: Fix an gcc -Wuninitialized warning
Date: Tue, 26 Mar 2013 15:28:22 -0400
Message-ID: <20130326192822.GA28244@sigill.intra.peff.net>
References: <5151F278.2040109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:29:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZYG-0000MA-9e
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759895Ab3CZT21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:28:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40575 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962Ab3CZT20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:28:26 -0400
Received: (qmail 6751 invoked by uid 107); 26 Mar 2013 19:30:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 15:30:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 15:28:22 -0400
Content-Disposition: inline
In-Reply-To: <5151F278.2040109@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219191>

On Tue, Mar 26, 2013 at 07:09:44PM +0000, Ramsay Jones wrote:

> Commit cbfd5e1c ("drop some obsolete "x = x" compiler warning hacks",
> 21-03-2013) removed a gcc hack that suppressed an "might be used
> uninitialized" warning issued by older versions of gcc.
> 
> However, commit 3aa99df8 ('fast-import: clarify "inline" logic in
> file_change_m', 21-03-2013) addresses an (almost) identical issue
> (with very similar code), but includes additional code in it's
> resolution. The solution used by this commit, unlike that used by
> commit cbfd5e1c, also suppresses the -Wuninitialized warning on
> older versions of gcc.
> 
> In order to suppress the warning (against the 'oe' symbol) in the
> note_change_n() function, we adopt the same solution used by commit
> 3aa99df8.

Yeah, they are essentially the same piece of code, so I don't mind this
change.  It is odd to me that gcc gets it right in one case but not the
other, but I think we are deep into the vagaries of the compiler's code
flow analysis here, and we cannot make too many assumptions.

Were you actually triggering this warning, and if so, on what version of
gcc? Or did the asymmetry just offend your sensibilities?

-Peff
