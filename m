From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] decode file:// and ssh:// URLs
Date: Sun, 30 May 2010 01:30:02 -0400
Message-ID: <20100530053002.GA19219@coredump.intra.peff.net>
References: <20100523091612.GB26123@coredump.intra.peff.net>
 <20100523091944.GB16520@coredump.intra.peff.net>
 <20100527105014.GA7865@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Abrahams <dave@boostpro.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun May 30 07:30:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIb6O-0007uh-AB
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 07:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab0E3FaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 01:30:04 -0400
Received: from peff.net ([208.65.91.99]:45129 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab0E3FaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 01:30:03 -0400
Received: (qmail 27693 invoked by uid 107); 30 May 2010 05:30:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 May 2010 01:30:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 May 2010 01:30:02 -0400
Content-Disposition: inline
In-Reply-To: <20100527105014.GA7865@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147983>

On Thu, May 27, 2010 at 01:50:15PM +0300, Ilari Liusvaara wrote:

> > With this patch, we will now percent-decode any file:// or
> > ssh:// url (or ssh+git, git+ssh, etc) at the transport
> > layer. We continue to treat plain paths and "host:path"
> > syntax literally.
> 
> One possible fallout: IPv6 scope syntax uses literal '%' in host
> part. The relevant RFC indicates it should be escaped, but in the past
> connect would fail if it was... But then, who uses that syntax...

Bleh. I am not happy about breaking a syntax people might be using, but
the current behavior is broken, which will cause problems for some other
people. Short of doing some context-sensitive "is this probably a
literal % in the host" heuristic (which I really think is a bad idea), I
think we will have to break one or the other.

-Peff
