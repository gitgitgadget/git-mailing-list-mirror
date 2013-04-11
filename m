From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Thu, 11 Apr 2013 01:05:09 -0400
Message-ID: <20130411050509.GC27795@sigill.intra.peff.net>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
 <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
 <20130411043346.GE14551@sigill.intra.peff.net>
 <CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 07:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ9hR-0002u4-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 07:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab3DKFFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 01:05:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39717 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549Ab3DKFFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 01:05:16 -0400
Received: (qmail 11779 invoked by uid 107); 11 Apr 2013 05:07:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 01:07:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 01:05:09 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220820>

On Wed, Apr 10, 2013 at 11:53:38PM -0500, Felipe Contreras wrote:

> > But if we push some commits to the helper, moving Y up to Z, then it
> > would build the new commit (which contains the foreign-vcs's equivalent of
> > Y..Z) on top of Z, not Y.
> 
> Why would it do that? If X points to say revision 100, presumably it
> was stored somewhere while doing a fetch. Similarly, if foreign
> version of Z is 150, it can update that number while doing a push. The
> next fetch it would start from 151.

I think the only reason not to bump the marker forward during the push
would be if the helper wants for some reason to "re-import" from the
foreign source rather than accepting the git versions of the commits.
Something like git-svn's markup of the commit messages with revision ids
comes to mind. But if it matters, then by definition that would mean
that the import/export is not bidirectionally clean. git-svn is
definitely not that, but I hope that vcs-svn will be (I have not kept up
on its status).

So I can buy the argument that bumping it forward ourselves will not
matter for any well-implemented helper.

That is the sort of thing that might be helpful to include in the commit
message; if somebody does run across such a helper and bisects to your
commit, then they can understand the rationale for the decision.

-Peff
