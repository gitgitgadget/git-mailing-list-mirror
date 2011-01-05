From: Jeff King <peff@peff.net>
Subject: Re: concurrent fetches to update same mirror
Date: Wed, 5 Jan 2011 17:57:52 -0500
Message-ID: <20110105225752.GA9774@sigill.intra.peff.net>
References: <ig2kjt$f2u$1@dough.gmane.org>
 <20110105204738.GA7629@sigill.intra.peff.net>
 <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com>
 <20110105205324.GA7808@sigill.intra.peff.net>
 <20110105211313.GB7808@sigill.intra.peff.net>
 <4D24F3E9.3070904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 23:58:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PacIq-0001iU-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 23:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab1AEW5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 17:57:55 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab1AEW5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 17:57:55 -0500
Received: (qmail 1932 invoked by uid 111); 5 Jan 2011 22:57:54 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 22:57:54 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 17:57:52 -0500
Content-Disposition: inline
In-Reply-To: <4D24F3E9.3070904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164604>

On Wed, Jan 05, 2011 at 04:42:49PM -0600, Neal Kreitzinger wrote:

> In the case of concurrent pulls to the same non-bare repo, could the
> working tree or index get corrupted, or does git have concurrency
> control mechanisms for this too?

There's a lock on the index, so it shouldn't be corruptable; one process
will just end up waiting. I'm not sure offhand whether writing working
tree files is done under any lock, but I would tend to think not, since
it can be a long process. However, writing the same file twice should be
OK; we unlink the old version and create the new from scratch. So the
first writer will get its write-in-progress unlinked, and the second one
will "win".

-Peff
