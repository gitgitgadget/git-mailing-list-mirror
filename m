From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 00:50:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkwq-00031r-VP
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbXBLXvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbXBLXvA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:51:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:49975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030477AbXBLXu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:50:59 -0500
Received: (qmail invoked by alias); 12 Feb 2007 23:50:58 -0000
X-Provags-ID: V01U2FsdGVkX1+1ErwvKUa1Njkktp8Z9syY+FRa4q7DGJ6kR2ykvq
	tQCw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39461>

Hi,

On Mon, 12 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Mon, 12 Feb 2007, Junio C Hamano wrote:
> >
> >> I agree that we can assume editors can grok files with LF end-of-line 
> >> just fine and we would not need to do the reverse conversion on checkout 
> >> paths (e.g. "read-tree -u", "checkout-index").
> >
> > In that case, a simple pre-commit hook would suffice.
> >
> > No, the problem mentioned by Mark was a very real one: you _cannot_ rely 
> > on Windows' editors not to fsck up with line endings. The worst case is if 
> > the file contains _some_ CRLF and _some _LF_. Almost always I had the 
> > problem that it now converted _all_ LFs to CRLFs. Even those which already 
> > were converted.
> >
> > So, if we are to support text mode, it is not one-way. If we do one-way, 
> > we really do _not_ support text mode, but pre-commit conversion to LF 
> > style text. And in this case, core git does not need _any_ change.
> 
> Well I disagree in two counts.
> 
>  - I do not see how you propose to solve some CRLF and some LF
>    case with both-ways conversion.

Very easy. Forward: s/\r\n/\n/. Backward: s/\(^\|[^\r]\)\n/\r\n/.

>  - Pre-commit hook would not be sufficient.  In a edit, diff,
>    test and then commit cycle, diff and test step needs to look
>    at whatever the editor left on the filesystem, so the changes
>    to populate-filespec is needed to make diff part work.

Yes, you are right.

However, since this is all post-1.5.0 (right? Right?) why not go with more 
of Ted's proposal, and make this whole mess also usable for other things 
than just crlf issues?

And I _really_ think that you do not help Windows people by doing this 
one-way thing.

Ciao,
Dscho
