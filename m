From: Jeff King <peff@peff.net>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take
 options
Date: Wed, 26 Feb 2014 05:52:49 -0500
Message-ID: <20140226105249.GE25711@sigill.intra.peff.net>
References: <530DA00E.4090402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 26 11:53:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIc6l-0007QD-8i
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbaBZKwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:52:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:57263 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751255AbaBZKwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:52:53 -0500
Received: (qmail 9893 invoked by uid 102); 26 Feb 2014 10:52:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 04:52:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 05:52:49 -0500
Content-Disposition: inline
In-Reply-To: <530DA00E.4090402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242713>

On Wed, Feb 26, 2014 at 09:04:30AM +0100, Michael Haggerty wrote:

> It would be nice to support more flexibility in the todo-list commands
> by allowing the commands to take options.  Maybe
> 
> * Convert a commit into a merge commit:
> 
>       pick -p c0ffeee -p e1ee712 deadbab The oneline of the commit after

This seems like a reasonable feature to me. All of your examples are
possible with an "e"dit and another git command, but the convenience may
be worth it (though personally, most of the examples you gave are
particularly interesting to me[1]).

I'd worry a little that it is not a summer's worth of work, but I
suspect there are other parts of rebase--interactive that could use
attention once the student is familiar with the code.

> * After squashing two commits, add a "Signed-off-by" line to the
>   commit log message:
> 
>     pick deadbee Implement feature XXX
>     squash --signoff f1a5c00 Fix to feature XXX
> 
>   or GPG-sign a commit:
> 
>     pick --gpg-sign=<keyid> deadbee Implement feature XXX
> 
> * Reset the author of the commit to the current user or a specified
>   user:
> 
>     pick --reset-author deadbee Implement feature XXX
>     pick --author="A U Thor <author@example.com>" deadbab The oneline of
> the commit after

Your first example would need some commit-tree magic, I think. But could
you implement these two with:

   pick deadbee Implement feature XXX
   exec git commit --amend --signoff --reset-author

? You could even alias the "amend" command to "exec git commit --amend",
like:

  amend --signoff --reset-author

Maybe that is unnecessarily unfriendly to the user, though.

-Peff

[1] The one feature I would like in this vein is that editing the title
    in the instruction-sheet would modify the commit message of the
    relevant commit. For some reason I try to do this every few weeks,
    but of course the changes are just thrown away.
