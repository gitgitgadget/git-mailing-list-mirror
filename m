From: Jeff King <peff@peff.net>
Subject: Re: Trouble with case-insensitive filesystems
Date: Fri, 26 Oct 2007 12:34:50 -0400
Message-ID: <20071026163450.GA19673@coredump.intra.peff.net>
References: <20071026145204.GA294@localhost.daprodeges.fqdn.th-h.de> <4722064C.1000201@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 26 18:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlS9K-0006TP-Ky
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 18:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbXJZQey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 12:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbXJZQey
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 12:34:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1588 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865AbXJZQex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 12:34:53 -0400
Received: (qmail 31883 invoked by uid 111); 26 Oct 2007 16:34:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Oct 2007 12:34:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2007 12:34:50 -0400
Content-Disposition: inline
In-Reply-To: <4722064C.1000201@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62424>

On Fri, Oct 26, 2007 at 05:22:52PM +0200, Andreas Ericsson wrote:

> There are no areas in git to patch. There's no sane way to handle your
> case, so the best you could opt for is to import it to a system with
> sane case-handling, alter the repo so no two filenames clash, and then
> check it out on your case-insensitive filesystem. Note that you'll

You don't need a sane system, since git's index provides one:

  # make our new repo without checking anything out
  git-clone -n /path/to/other/repo repo
  cd repo

  # grab a text representation of what would be checked out
  git-ls-tree -r HEAD >files
  # fix up any broken filenames
  $EDITOR files
  # and shove it into the index
  git-update-index --index-info <files

  # update your working tree
  git-checkout-index -a
  # and optionally save the commit
  git-commit -m 'broken filenames hack'

Of course, all of the prior commits won't be usable. You would have to
repeat this hack on every commit using git-filter-branch for that.

-Peff
