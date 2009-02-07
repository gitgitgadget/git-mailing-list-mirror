From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: import Term::ReadKey with 'require'
Date: Fri, 6 Feb 2009 23:54:02 -0500
Message-ID: <20090207045401.GA21135@sigill.intra.peff.net>
References: <20090206140126.GA18364@coredump.intra.peff.net> <1233948601-4828-1-git-send-email-trast@student.ethz.ch> <20090206203037.GB19959@coredump.intra.peff.net> <200902070021.18928.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 07 06:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVfLd-0000sA-TN
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 06:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZBGEyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 23:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbZBGEyK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 23:54:10 -0500
Received: from peff.net ([208.65.91.99]:37109 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbZBGEyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 23:54:09 -0500
Received: (qmail 15127 invoked by uid 107); 7 Feb 2009 04:54:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 06 Feb 2009 23:54:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 23:54:02 -0500
Content-Disposition: inline
In-Reply-To: <200902070021.18928.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108811>

On Sat, Feb 07, 2009 at 12:21:13AM +0100, Thomas Rast wrote:

> > (note that you could also skip the import and just call
> > Term::ReadKey::ReadKey by its full name).
> 
> I tried that but couldn't get either Term::ReadKey::ReadKey or
> Term::ReadKey->ReadKey to work.  In retrospect, I suppose it requires
> parentheses too.

Right, you would still need the parentheses. But note that the second
syntax (with the "->") would always be wrong. The "::" syntax just says
"find this name not in the current namespace, but in this absolute
namespace I am giving you". But "X->Y" is actually a syntactic shorthand
for "look up X::Y (or Z::Y, where Z is the blessed package of X), and
then call X::Y(X, @_)".

Which makes sense for object-oriented stuff. You get the object or the
classname as the first parameter to a method. But for a regular package
function, you would be calling

  Term::ReadKey::ReadKey('Term::ReadKey', 0)

which of course makes no sense.

But I think doing the import makes more sense (and is how Term::ReadKey
is intended to be used), so the patch you posted is best.

-Peff
