From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Fri, 22 Jun 2012 23:26:34 +0100
Message-ID: <20120622222633.GH25478@arachsys.com>
References: <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
 <20120622205026.GI32205@arachsys.com>
 <7vobobm3mi.fsf@alter.siamese.dyndns.org>
 <20120622220231.GG25478@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCJb-0006RR-TW
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759034Ab2FVW0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:26:52 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:33496 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759050Ab2FVW0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:26:37 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SiCJG-0006u0-TQ; Fri, 22 Jun 2012 23:26:35 +0100
Content-Disposition: inline
In-Reply-To: <20120622220231.GG25478@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200477>

Chris Webb <chris@arachsys.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It would be a lot more palatable approach to teach "rebase -i" defer
> > its "detaching HEAD to the onto commit" step before starting to read
> > the insn sheet.  Would such a change be too involved for it to be
> > worth supporting "rebase --root -i"?
> 
> I'm not sure as I don't really know the rebase shell scripts well at all,
> but I'm happy to take a look and see.

Ignoring the implementation, I think the nastiest bit here is what happens
for the user if there's a conflict, as Peff pointed out. Ideally, we want to
checkout a state we're going to replay the patch onto, so that if we drop
out because there's conflict (e.g. the patch modifies a file which doesn't
exist yet), git diff and git diff --cached do something sensible.

Without a detached orphan checkout, as Peff says, we'd have to put a
temporary empty commit in and then manually make the first commit avoiding
using it as a parent, which is very ugly. I'll take a look, but might be too
complex to be worth doing for this corner-case.

Cheers,

Chris.
