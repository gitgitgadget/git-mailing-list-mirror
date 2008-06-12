From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 00:18:47 -0400
Message-ID: <20080612041847.GB24868@sigill.intra.peff.net>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 12 06:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6eHp-0003Dr-Ha
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 06:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbYFLESv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 00:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbYFLESv
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 00:18:51 -0400
Received: from peff.net ([208.65.91.99]:3432 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbYFLESu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 00:18:50 -0400
Received: (qmail 1834 invoked by uid 111); 12 Jun 2008 04:18:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 00:18:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 00:18:47 -0400
Content-Disposition: inline
In-Reply-To: <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84696>

On Wed, Jun 11, 2008 at 06:25:23PM -0500, Brandon Casey wrote:

> Yes, I think usually stashes are used for very short term storage. At the
> same time, I don't expect a stash (however old) to disappear without me
> explicitly deleting it.
> 
> In particular, I don't want to experience this:
> 
> $ git stash list
> stash@{0}: WIP on master: 8c372fb... git-cvsimport: do not fail when CVS is /
> $ git pull
> $ git stash apply
> fatal: Needed a single revision
> : no valid stashed state found

Did that actually happen to you? Because it seems kind of unlikely to me
that you would perform this exact sequence of events, _exactly_ 90 days
after stashing (i.e., the 90 day period expires sometime between "git
stash list" and "git pull"). Not to mention that you actually _care_
about the stash 90 days later.

So yes, I would hate for that to happen, too. However, I think there is
a real benefit to garbage collecting stashes, and the scenario you
describe seems implausibly unlikely.

-Peff
