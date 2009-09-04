From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: disconnect transport after fetching
Date: Thu, 3 Sep 2009 22:30:13 -0400
Message-ID: <20090904023013.GA14651@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0909020159080.28290@iabervon.org>
 <20090902063647.GA29559@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 04:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjOZI-0000Ex-R0
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 04:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbZIDCaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 22:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbZIDCaS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 22:30:18 -0400
Received: from peff.net ([208.65.91.99]:38111 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077AbZIDCaR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 22:30:17 -0400
Received: (qmail 16659 invoked by uid 107); 4 Sep 2009 02:30:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 03 Sep 2009 22:30:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Sep 2009 22:30:13 -0400
Content-Disposition: inline
In-Reply-To: <20090902063647.GA29559@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127683>

On Wed, Sep 02, 2009 at 02:36:47AM -0400, Jeff King wrote:

> This patch just explicitly calls disconnect after we are
> done with the remote end, which sends a flush packet to
> upload-pack and cleanly disconnects, avoiding the error
> message.

I see you applied this with some extra tests. I should have mentioned in
the original cover letter that I considered tests but intentionally did
not include them.

The problem is that clone forks upload-pack, and then hangs up on it by
exiting, and then upload-pack spews the unwanted message. But control
has returned to the shell after clone exits, meaning that the message
from upload-pack may or may not have gotten there by the time we grep
stderr.

So I don't think your test will ever incorrectly show a failure, but I
believe that it would pass randomly even without the related fix to the
code.

-Peff
