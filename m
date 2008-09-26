From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git ls-files -m --with-tree does double output
Date: Fri, 26 Sep 2008 18:50:43 -0400
Message-ID: <20080926225043.GC24817@coredump.intra.peff.net>
References: <87od2dv7mz.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:52:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjMAG-0000Fz-Me
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 00:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbYIZWuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 18:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYIZWuq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 18:50:46 -0400
Received: from peff.net ([208.65.91.99]:1438 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbYIZWup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 18:50:45 -0400
Received: (qmail 8718 invoked by uid 111); 26 Sep 2008 22:50:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Sep 2008 18:50:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Sep 2008 18:50:43 -0400
Content-Disposition: inline
In-Reply-To: <87od2dv7mz.fsf@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96889>

On Wed, Sep 24, 2008 at 06:19:32PM +0200, Anders Melchiorsen wrote:

> I think that this is wrong? The combination of -m and --with-tree
> shows duplicate entries. Git 1.6.0.2.

I have confirmed this, and it looks like it has always been that way. It
looks like overlay_tree_on_cache just does a read_tree to pull the tree
into the index, and then we end up with duplicate entries.

I'm not too familiar with the read_tree code, so I am cc'ing Junio (who
is out of touch for a little while) and Linus, who are much more clueful
in this area.

It isn't clear to me which code is _supposed_ to be pulling out such
duplicates here. That is, is read_tree broken, or is
overlay_tree_on_cache just calling it wrong?

-Peff
