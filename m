From: Jeff King <peff@peff.net>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 11:27:20 -0400
Message-ID: <20090422152719.GA12881@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 17:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LweNg-0001d4-Or
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 17:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbZDVP10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 11:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZDVP1Z
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 11:27:25 -0400
Received: from peff.net ([208.65.91.99]:51695 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbZDVP1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 11:27:24 -0400
Received: (qmail 16060 invoked by uid 107); 22 Apr 2009 15:27:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 11:27:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 11:27:20 -0400
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117206>

On Tue, Apr 21, 2009 at 05:46:16PM -0400, John Dlugosz wrote:

> Immediately after doing a git gc, a git fsck --full reports dangling
> objects.  Is this normal?  What does dangling mean, if not those things
> that gc finds?

gc will leave dangling loose objects for a set expiration time
(defaulting to two weeks). This makes it safe to run even if there are
operations in progress that want those dangling objects, but haven't yet
added a reference to them (as long as said operation takes less than two
weeks).

You can also end up with dangling objects in packs. When that pack is
repacked, those objects will be loosened, and then eventually expired
under the rule mentioned above. However, I believe gc will not always
repack old packs; it will make new packs until you have a lot of packs,
and then combine them all (at least that is what "gc --auto" will do; I
don't recall whether just "git gc" follows the same rule).

-Peff
