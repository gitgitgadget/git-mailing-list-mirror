From: Jeff King <peff@peff.net>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 11:37:38 -0400
Message-ID: <20090312153738.GA24690@coredump.intra.peff.net>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com> <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de> <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com> <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302> <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com> <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com> <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Mar 12 16:44:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhn08-0007fF-66
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbZCLPhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 11:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbZCLPhs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:37:48 -0400
Received: from peff.net ([208.65.91.99]:37437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbZCLPhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 11:37:47 -0400
Received: (qmail 2559 invoked by uid 107); 12 Mar 2009 15:37:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Mar 2009 11:37:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2009 11:37:38 -0400
Content-Disposition: inline
In-Reply-To: <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113080>

On Thu, Mar 12, 2009 at 03:21:48PM +0000, Pieter de Bie wrote:

> You can also get this in other interactions, for example:
>
> 	$ git checkout -b origin/test HEAD
> 	$ git checkout -b origin/test master
>
> yes, these might be user errors, but I still think it's not OK to create a 
> new ref 'refs/heads/origin/test' if there's also a 'refs/ 
> remotes/origin/test' (as I've said a few months ago).

One thing that has been missing from this discussion (and I think you
are getting to it here) is a concrete rule for "X is harmful, and Y is
not". That is, how do we know when to warn, and then what do we do?

John's original example was "git checkout -b origin/test origin/test".
So it's a problem that they're textually the same, but obviously there
are more problematic cases.

The behavior I think you are implying would be something like:

  When making origin/test, try to resolve_ref("origin/test"); if it
  fails, we are OK. If it succeeds, then we know we will be creating an
  ambiguity. Complain and refuse the creation unless "-f" is given.

This would actually be a superset of the "branch already exists" case,
so it should be pretty simple to code, and it makes for a simple rule:
it is now "ref already exists".

Does that actually cover all of the problematic cases?

-Peff
