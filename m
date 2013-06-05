From: Jeff King <peff@peff.net>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Wed, 5 Jun 2013 11:43:45 -0400
Message-ID: <20130605154344.GA8664@sigill.intra.peff.net>
References: <20130604141314.GD22308@pomac.netswarm.net>
 <20130604160815.GB15953@sigill.intra.peff.net>
 <20130605111918.GE22308@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 17:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkFsN-0007es-Om
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 17:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab3FEPns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 11:43:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:51574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755311Ab3FEPnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 11:43:47 -0400
Received: (qmail 29324 invoked by uid 102); 5 Jun 2013 15:44:33 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 10:44:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 11:43:45 -0400
Content-Disposition: inline
In-Reply-To: <20130605111918.GE22308@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226453>

On Wed, Jun 05, 2013 at 01:19:18PM +0200, Ian Kumlien wrote:

> > Older versions of git silently ignored errors reading config files, but
> > it was tightened in v1.8.1.1, as there can be quite serious implications
> > to failing to read expected config (e.g., imagine transfer.fsckobjects,
> > or receive.deny* is ignored).
> 
> Yes, i agree, it's suboptimal but I for one would use getpwuid to get
> the home directory of the executing user to avoid this - though i don't
> know how portable it is (or if there is any other issues)

We considered having git-daemon's "--user" option do that, but:

  1. It would be a regression for people who are intentionally setting
     HOME to get different config profiles. And it would be a surprise
     to admins, as other user-switching daemons (e.g., inetd) do not
     tweak HOME.

  2. It would not have covered all cases, including yours. xinetd is the
     one doing the user-switching here.

-Peff
