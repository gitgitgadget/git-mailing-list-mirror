From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 09:48:19 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711290945060.8458@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 18:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxnWJ-0003Yb-0M
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 18:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbXK2RtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 12:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761132AbXK2RtI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 12:49:08 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56376 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760357AbXK2RtG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 12:49:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATHmKwY004443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 09:48:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATHmJxf031981;
	Thu, 29 Nov 2007 09:48:19 -0800
In-Reply-To: <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66550>



On Thu, 29 Nov 2007, Nicolas Pitre wrote:
> 
> Well, see below for the patch that actually split the pack data into 
> objects of the same type.  Doing that "git checkout" on the kernel tree 
> did improve things for me although not spectacularly.

Umm. See my earlier numbers. For "git checkout" with cold cache, the 
*bulk* of the time is actually the ".gitignore" file lookups, so if you 
see a three-second improvement out of 17s, it may not look spectacular, 
but considering that probably 10s of those 17s were something *else* going 
on, I suspect that if you really did just a plain "git checkout", you 
actually *do* have a spectacular improvement of roughly 7s -> 4s!

Try with

	time git read-tree -m -u HEAD HEAD > /dev/null

instead.

But if that is what you already did, then yeah, the performance 
improvement for cold-cache wasn't as big as I was hoping for.

		Linus
