From: Jeff King <peff@peff.net>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Sat, 11 Aug 2007 09:49:28 -0400
Message-ID: <20070811134927.GA2411@coredump.intra.peff.net>
References: <20070810154108.GA779@ruiner> <20070810173242.GA23628@coredump.intra.peff.net> <alpine.LFD.0.999.0708101109310.30176@woody.linux-foundation.org> <18109.21984.26228.849806@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Hetro <whee@smaertness.net>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 15:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJrLf-0002Tz-Ph
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 15:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbXHKNtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 09:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbXHKNtd
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 09:49:33 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3668 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbXHKNtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 09:49:32 -0400
Received: (qmail 14406 invoked by uid 111); 11 Aug 2007 13:49:38 -0000
X-Spam-Status: No, hits=-1.2 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 11 Aug 2007 09:49:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2007 09:49:28 -0400
Content-Disposition: inline
In-Reply-To: <18109.21984.26228.849806@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55611>

On Sat, Aug 11, 2007 at 04:23:28PM +1000, Paul Mackerras wrote:

> There has been a commit with duplicate parents in the kernel git tree
> for ages (13e65280), and gitk handles it just fine, so I don't think
> it's simply a problem with duplicate parents.

gitk fails with this test script, which creates two commits, the second
one referencing the first as a duplicate:

mkdir repo &&
cd repo &&
git-init &&
echo one >file &&
git-add file &&
git-commit -m one &&
echo two >file &&
git-add file &&
tree=$(git-write-tree) &&
parent=$(git-rev-parse HEAD) &&
commit=$(git-commit-tree $tree -p $parent -p $parent <file) &&
git-update-ref HEAD $commit &&
gitk

To run it, you will actually need to disable git-commit-tree's checking
for duplicate parents. You can do this by commenting out the call to
new_parent in builtin-commit-tree.c:114.

-Peff
