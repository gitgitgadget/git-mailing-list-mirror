From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and
	optimize it a bit
Date: Sun, 7 Oct 2007 22:19:45 -0400
Message-ID: <20071008021945.GC20050@coredump.intra.peff.net>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <85fy0nknnq.fsf@lola.goethe.zz> <20071007161012.GB3270@steel.home> <851wc6lwkc.fsf@lola.goethe.zz> <20071007215749.GD2765@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 04:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeiDx-000179-0L
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 04:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbXJHCTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 22:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbXJHCTs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 22:19:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4495 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbXJHCTr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 22:19:47 -0400
Received: (qmail 9154 invoked by uid 111); 8 Oct 2007 02:19:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Oct 2007 22:19:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2007 22:19:45 -0400
Content-Disposition: inline
In-Reply-To: <20071007215749.GD2765@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60278>

On Sun, Oct 07, 2007 at 11:57:49PM +0200, Alex Riesen wrote:

> > > Can't the result of the expression be reused in compiled?
> > > Isn't it a common expression?
> > 
> > No, since the call to memcmp might change a->len or b->len.  A
> 
> Huh?! How's that? It is not even given them!

But they are non-local variables (they are part of structs passed in as
pointers), so that translation unit has no idea how they are allocated.
They could be globals that memcmp mucks with as a side effect.

That being said, standards-conforming compilers _can_ realize that
memcmp is a special, standards-defined function with no side effects and
act accordingly. gcc provides the 'pure' function attribute for this
purpose, which is used by glibc.

-Peff
