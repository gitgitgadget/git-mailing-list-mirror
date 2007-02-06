From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 08:35:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org>
References: <20070206023111.GB9222@spearce.org> <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
 <20070206054808.GA10508@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 17:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HETI8-0001lB-8S
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 17:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXBFQfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 11:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbXBFQfd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 11:35:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39763 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbXBFQfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 11:35:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l16GZ5mA028339
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Feb 2007 08:35:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l16GZ4EV022220;
	Tue, 6 Feb 2007 08:35:05 -0800
In-Reply-To: <20070206054808.GA10508@spearce.org>
X-Spam-Status: No, hits=-0.422 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38856>



On Tue, 6 Feb 2007, Shawn O. Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> >
> > I think this is quite error prone, demonstrated by the fact that we 
> > screwed that up ourselves on a few occasions.  I think that the frontend 
> > should be relieved from this by letting it provide the time of change in 
> > a more natural format amongst all possible ones(like RFC2822 for 
> > example) and gfi should simply give it to parse_date().
> 
> This is a really good point.  Its a little bit of work to switch
> to parse_date(); I'll try to get it done tomorrow night.

Actually, I disagree. We've traditionally have had _less_ bugs with the 
pure integer format than we ever had with RFC2822 format.

The original (first seven days) date format inside git objects was 
rfc2822, and it was *horrible*. Not only does it take time to parse, 
people get it constantly wrong, and it's ambiguous what summer-time means 
etc. It's basically impossible to get anything that is totally repeatable 
from it, and you have to be so lax as to effectively accept even buggy 
input. And yes, buggy input exists.

So I would strongly suggest that gfi keeps to the standard git date format 
which is easy to parse, and totally unambiguous. Yes, you can get it 
wrong, but at least then it's very clear *who* gets it wrong: it's 
whatever feeds data to gfi. If gfi accepts a "soft" format, you get into 
all these gray areas of whether you want to be strictly rfc2822 only, or 
whether you actually want to accept stuff that everybody accepts 
(including the git date functions, that try very hard to turn anything 
sensible into a date). And DST. And odd timezone names, etc etc.

Having a hard format, set in stone, and totally unambiguous, is really a 
good thing. It actually ends up resulting in fewer bugs in the end, 
because it just makes sure that everybody is on the same page.

		Linus
