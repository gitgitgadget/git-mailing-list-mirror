From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 9 Jul 2007 10:40:30 -0400
Message-ID: <20070709144030.GE16032@thunk.org>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org> <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net> <20070709115029.GD16032@thunk.org> <200707091416.39949.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 16:40:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7uPw-0008Fm-S0
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 16:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbXGIOkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 10:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbXGIOkl
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 10:40:41 -0400
Received: from THUNK.ORG ([69.25.196.29]:58666 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465AbXGIOkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 10:40:40 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I7uXk-0004Qe-2A; Mon, 09 Jul 2007 10:48:53 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I7uPe-0007jp-9x; Mon, 09 Jul 2007 10:40:30 -0400
Content-Disposition: inline
In-Reply-To: <200707091416.39949.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51996>

On Mon, Jul 09, 2007 at 02:16:35PM +0100, Andy Parkins wrote:
> On Monday 2007 July 09, Theodore Tso wrote:
> > On Sun, Jul 08, 2007 at 10:39:41PM -0700, Junio C Hamano wrote:
> > > Are _identifiers with leading underscore Kosher thing to do, I
> > > wonder...  We do have ones with trailing ones (mostly qsort
> > > functions) and I think they are done that way for the sake of
> > > standards conformance.
> >
> > _[a-z]* is kosher for file scopes or function scoping:
> 
> Perhaps I'm reading it wrong but:
> 
> "All identifiers beginning with an underscore are reserved for ordinary 
> identifiers (functions, variables, typedefs, enumeration constants) with file 
                                                                      ^^^^^^^^^
> scope."
  ^^^^^^
> 
> Doesn't agree with what you've said.  I think that you _can_ use _[a-z]* for 
> labels or structure members - however, not within file or function scope.

I think the above does agree with what I said.  It says that you can
use functions, variables, typdefs, enumeration constants (not just
labels or structure members) WITH FILE SCOPE.  I.e., so long as it
doesn't leak across a .o linkage.  So one .o file can use a static
_my_strdup, and another .o file can use a static _my_strdup, and they
don't have to worry about multiply defined function conflicts, since
they are static functions with file or smaller scoping.

And if it's safe to use a file-level static scoping, then obviously it
would be safe to use a function-level static scoping.

> However, the rule of thumb I've always used is "don't start identifiers with 
> underscore".  I can't think of a situation that would mean you have to use an 
> underscore to start an identifier - so why get into detailed worries about 
> where it's allowed and where it isn't.  Just don't use it.  The document you 
> linked to gives exactly this advice:

Yep, this is the safer thing to do if you don't want to remember the
more complicated rule.  But it's not *necessary*; no system library
will use a single underscore followed by a lower-case letter, since
that's reserved for programs for local file-level scoping.  A system
library will use for its private function identifiers that begin
either a double underscore, or a underscore followed by an uppercase
latter.

Regards,

							- Ted
