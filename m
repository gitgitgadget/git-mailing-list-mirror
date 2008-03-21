From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Permit refspec source side to parse as a sha1
Date: Fri, 21 Mar 2008 01:57:52 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210014100.19665@iabervon.org> <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:58:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcaHA-0004NR-Hf
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 06:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYCUF54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 01:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYCUF54
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 01:57:56 -0400
Received: from iabervon.org ([66.92.72.58]:50776 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbYCUF5z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 01:57:55 -0400
Received: (qmail 23644 invoked by uid 1000); 21 Mar 2008 05:57:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2008 05:57:52 -0000
In-Reply-To: <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77719>

On Thu, 20 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > So we should call the same code to parse the string, have that code do no 
> > validation at all, and have the caller validate the return as appropriate. 
> > The parsing doesn't depend at all on whether it's for fetching or pushing.
> 
> Obviously you did not read my patch before responding.
> 
> While I would agree that removing the check from parsing and add necessary
> checks to all callers would be another way to catch the same kind of
> breakages,
> 
>  (1) it would be more code to change, and I do not see a clear advantage,
>      in that approach, especially given the discussion that lead to
>      $gmane/77413;

Surely it's no more code to change all of the callers of parse_ref_spec to 
also call a function to validate it as appropriate than it is to change 
all of the callers of parse_ref_spec to call a different function instead.
 
>  (2) the error reporting by the callers that use the parsed result will
>      not be able to say "Invalid refspec '%s'" on the source string,
>      simply because the source string is not available to them anymore;

That's easy enough to keep, and likely even worthwhile; it would probably 
be nice, for example, to have "git fetch origin typo/*:something/*" give 
an error when the pattern doesn't match anything, and that error would 
need the refspec string.

>  (3) worse yet, the older code even discarded part of the user input, so
>      the error reporting that uses the parsed src/dst pair may not even be
>      similar to the problematic input the user gave us to begin with,
>      making it harder for the user to spot what we did not like and
>      correct it.

That was a bug that was fixed in the intermediate version.

> In any case, don't you agree that the patch you responded to is much
> easier to understand what we are (and we are not) checking than the
> original code?

No, I think it's much more complicated. It mixes the semantics of what an 
empty side means for a particular use of refspecs into the parsing of the 
string. At the very least, the checks should be outside of _internal() in 
the functions for particular uses.

	-Daniel
*This .sig left intentionally blank*
