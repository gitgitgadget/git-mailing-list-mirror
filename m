From: Jeff King <peff@peff.net>
Subject: Re: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 3 Mar 2009 11:25:19 -0500
Message-ID: <20090303162519.GE32079@coredump.intra.peff.net>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net> <49AD547E.7030703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?=22Peter_Valdemar_M=C3=B8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXSG-0004lN-DH
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbZCCQZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbZCCQZY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:25:24 -0500
Received: from peff.net ([208.65.91.99]:50006 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbZCCQZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:25:24 -0500
Received: (qmail 17810 invoked by uid 107); 3 Mar 2009 16:25:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 11:25:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 11:25:19 -0500
Content-Disposition: inline
In-Reply-To: <49AD547E.7030703@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112109>

On Tue, Mar 03, 2009 at 05:02:06PM +0100, Michael J Gruber wrote:

> > but what it actually does is find changes where the string was introduced
> > or removed. So it literally counts the number of occurences before and
> > after the commit, and the commit is interesting if they are not equal.
> 
> Hmm. The diffcore doc sounds more like if the filepair is picked if
> #before > 0 and #after = 0, but not if #after > 0.

Nope, the code is #before != #after. There are some special cases around
deleted and unmerged files, but the obvious one is:

    $ sed -n 89,92p diffcore-pickaxe.c
                    else if (!diff_unmodified_pair(p) &&
                             contains(p->one, needle, len, regexp) !=
                             contains(p->two, needle, len, regexp))
                            has_changes++;

So maybe the diffcore documentation needs to be clarified.

> In any case, the pickaxe can't detect moving around of strings, right?

No, it won't (and see my other mail elsewhere in the thread for why that is
actually hard to define).

-Peff
