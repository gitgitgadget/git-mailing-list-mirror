From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: fix combined diff
Date: Fri, 23 Feb 2007 00:34:28 -0500
Message-ID: <20070223053428.GA13301@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0702230517480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 06:34:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKT4j-0003Ty-Up
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 06:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXBWFeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 00:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbXBWFeb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 00:34:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3368 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750895AbXBWFea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 00:34:30 -0500
Received: (qmail 6130 invoked from network); 23 Feb 2007 00:34:41 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Feb 2007 00:34:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2007 00:34:28 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702230517480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40416>

On Fri, Feb 23, 2007 at 05:20:32AM +0100, Johannes Schindelin wrote:

> With "const unsigned (*parent)[20]", "parent + 1" is not the
> same as "&parent[1]"...

Actually, they _are_ the same (the C standard definition of A[B] is *(A+B)).
The problem is the operator precedence of the cast:

> -		hashcpy((unsigned char*)parent + i, ent[ents - 1 - i].item->sha1);

which translates to "cast parent to an unsigned char pointer, and then
add i * sizeof(unsigned char) to it".

Your fix works because [] binds more tightly, fixing the precedence
problem. You could also do this:
  hashcpy((unsigned char*)(parent + i), ...

-Peff
