From: Jeff King <peff@peff.net>
Subject: Re: How to extract files out of a "git bundle", no matter what?
Date: Fri, 19 Dec 2008 15:21:19 -0500
Message-ID: <20081219202118.GA26513@coredump.intra.peff.net>
References: <494BFCAF.9060703@verizon.net> <87zlirc49l.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 21:23:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDlrt-000159-1Z
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 21:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbYLSUVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 15:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbYLSUVW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 15:21:22 -0500
Received: from peff.net ([208.65.91.99]:1402 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbYLSUVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 15:21:22 -0500
Received: (qmail 19609 invoked by uid 111); 19 Dec 2008 20:21:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Dec 2008 15:21:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Dec 2008 15:21:19 -0500
Content-Disposition: inline
In-Reply-To: <87zlirc49l.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103580>

On Sat, Dec 20, 2008 at 04:13:26AM +0800, jidanni@jidanni.org wrote:

> There must be a way to make a "phony tree" or whatever to "attach to"
> so extraction can proceed. Be sure to spell it all out on the
> git-bundle man page as a reference in case some non-computer people
> need to do aforementioned emergency extraction one day.

No, that information may not even be in the bundle at all (unless it is
a bundle that has a 0-ref basis). In particular, if a bundle contains
changes between some commit A and some commit B, then:

  - files that were not changed between A and B will not be included at
    all

  - the object pack in the bundle is "thin", meaning it may contain
    deltas against objects that are reachable from A, but not B. So even
    _within_ a changed file, you may see only the changes from A to B.

If the bundle has a 0-ref basis, then you can clone straight from the
bundle, which must have everything.

-Peff
