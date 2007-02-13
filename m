From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 09:23:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:24:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1Nq-0005cP-Cb
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXBMRXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbXBMRXm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:23:42 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45045 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbXBMRXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:23:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DHNPhB029546
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 09:23:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DHNOZ7003886;
	Tue, 13 Feb 2007 09:23:24 -0800
In-Reply-To: <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.423 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39547>



On Tue, 13 Feb 2007, Linus Torvalds wrote:
> 
> I'd much rather just get this right, and that means "no hooks". If people 
> start using commit hooks etc, that will just mean that they won't use them 
> for all-windows environments (why use it? Everybody hass CRLF, and 
> everybody _wants_ CRLF), or it will just be relatively expensive to have a 
> complex hook anyway.
> 
> So I think we should plan on something like .gitattributes or similar, so 
> that we _can_ handle mixed environments well, without any real setup or 
> any real costs.

Here's a patch that I think we can merge right now. There may be other 
places that need this, but this at least points out the three places that 
read/write working tree files for git update-index, checkout and diff 
respectively. That should cover a lot of it.

Some day we can actually implement it. In the meantime, this points out a 
place for people to start. We *can* even start with a really simple "we do 
CRLF conversion automatically, regardless of filename" kind of approach, 
that just look at the data (all three cases have the _full_ file data 
already in memory) and says "ok, this is text, so let's convert to/from 
DOS format directly".

THAT somebody can write in ten minutes, and it would already make git much 
nicer on a DOS/Windows platform, I suspect.

And it would be totally zero-cost if you just make it a config option 
(but please make it dynamic with the _default_ just being 0/1 depending 
on whether it's UNIX/Windows, just so that UNIX people can _test_ it 
easily).

		Linus
