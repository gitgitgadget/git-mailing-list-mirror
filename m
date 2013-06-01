From: Jeff King <peff@peff.net>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sat, 1 Jun 2013 01:03:55 -0400
Message-ID: <20130601050355.GA23408@sigill.intra.peff.net>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
 <51A963B7.6060002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 01 07:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UidzN-0003uS-UI
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 07:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab3FAFEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 01:04:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:37668 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab3FAFED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 01:04:03 -0400
Received: (qmail 21609 invoked by uid 102); 1 Jun 2013 05:04:44 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Jun 2013 00:04:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Jun 2013 01:03:55 -0400
Content-Disposition: inline
In-Reply-To: <51A963B7.6060002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226102>

On Sat, Jun 01, 2013 at 05:00:07AM +0200, Michael Haggerty wrote:

> This is a known problem.  The technical reason that this is not trivial
> to solve is the possibility of a directory/file conflict between old
> reflog files and references that might be created subsequently (which in
> turn is a limitation of how loose references and reflogs are mapped to
> filenames):
> [...]
> Peff proposed a solution to this problem [1], but AFAIK it is not making
> progress.

I was running with the patch series you mentioned for a while, but there
are some weird bugs with it that need to be tracked down.  I don't
recall the details, but I would occasionally get error messages that
showed that some parts of the code were surprised that the reflog
existed without the ref existing.

While I think solving the D/F conflict in the ref namespaces overall
would be a nice thing to have, doing it with compatibility with the
current system is complex and error-prone. I wonder if simply sticking
the reflog entries into a big GRAVEYARD reflog wouldn't be a great deal
simpler and accomplish the "keep deleted reflogs" goal, which is what
people actually want.

-Peff
