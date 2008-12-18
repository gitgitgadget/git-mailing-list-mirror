From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add git-edit-index.perl
Date: Thu, 18 Dec 2008 09:04:11 -0500
Message-ID: <20081218140411.GB6706@coredump.intra.peff.net>
References: <20081217204749.GA18261@janet.wally> <20081218043734.GD20749@coredump.intra.peff.net> <alpine.DEB.1.00.0812181446430.6952@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neil Roberts <bpeeluk@yahoo.co.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 18 15:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJVl-0001uY-2o
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 15:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYLROEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 09:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbYLROEP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 09:04:15 -0500
Received: from peff.net ([208.65.91.99]:4348 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbYLROEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 09:04:14 -0500
Received: (qmail 2318 invoked by uid 111); 18 Dec 2008 14:04:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Dec 2008 09:04:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Dec 2008 09:04:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812181446430.6952@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103462>

On Thu, Dec 18, 2008 at 02:48:39PM +0100, Johannes Schindelin wrote:

> Yes, it is a neat idea.  But I always keep in mind what Junio had to say 
> about my "add -e" thing (that I use pretty frequently myself): you will 
> put something into the index that has _never_ been tested.
> 
> Would we really want to bless such a workflow with "official" support?

That is definitely something to be concerned about. Which is why my
workflow is something like:

  $ hack hack hack
  $ while ! git diff; do
      git add -p
      git commit
    done
  $ for i in `git rev-list origin..`; do
      git checkout $i && make test || barf
    done

That is, it is not inherently a problem to put something untested into
the index as long as you are doing it so that you can go back and test
later.

It _would_ be a nicer workflow to say "I don't want these changes yet"
and selectively put them elsewhere, test what's in the working tree,
commit, and then grab some more changes from your stash. But we don't
have interactive stashing and unstashing yet, which would be required
for that.

-Peff
