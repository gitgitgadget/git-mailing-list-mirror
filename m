From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 15:46:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708141540420.25989@racer.site>
References: <11870975181798-git-send-email-bdowning@lavos.net>
 <20070814132209.GJ21692@lavos.net> <Pine.LNX.4.64.0708141506260.25989@racer.site>
 <20070814142428.GK21692@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKxge-0007yL-KM
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 16:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbXHNOr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbXHNOr5
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 10:47:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:40323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752697AbXHNOr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 10:47:56 -0400
Received: (qmail invoked by alias); 14 Aug 2007 14:47:55 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp051) with SMTP; 14 Aug 2007 16:47:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iHw1Bdikig33KXNcrh6vh6NRmfzBeTnHFWlOl5Y
	liScFRkefecT9l
X-X-Sender: gene099@racer.site
In-Reply-To: <20070814142428.GK21692@lavos.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55837>

Hi,

On Tue, 14 Aug 2007, Brian Downing wrote:

> On Tue, Aug 14, 2007 at 03:08:52PM +0100, Johannes Schindelin wrote:
> > Shouldn't read_cache() be _only_ called if
> > 
> > - it has not been read yet, and
> > - .gitattributes was not found in the work tree?
> > 
> > IOW check-attr is the wrong place for your patch IMHO.
> 
> I admit I just cargo-culted what builtin-checkout-index did upon starting.
> Off the cuff, though, I don't see how the cache could ever already be
> loaded upon the start of cmd_check_attr,

Right.  I was talking more about read_cache() being called later anyway, 
so you do not have to read the cache if a .gitattributes is there and you 
do not need the index to begin with.

> and the way the attr.c code is
> written, the cache be loaded when we check attributes or it will default
> to the old behavior (only checking the working directory.)

Why not just make sure that the index is read in read_index_data()?  
Something like

	/* read index if that was not already done yet */
	if (!istate->mmap)
		read_index(&istate);

(Yes, I know that read_index() calls read_index_from(), which in turn 
checks that, but read_attr() is called possibly pretty often, right?  So 
we might just as well spare a few cycles here.)

Ciao,
Dscho
