From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from
 stdin
Date: Mon, 26 Feb 2007 17:47:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 17:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLj0j-0003dO-67
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 17:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbXBZQre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 11:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbXBZQre
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 11:47:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:33233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030317AbXBZQrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 11:47:33 -0500
Received: (qmail invoked by alias); 26 Feb 2007 16:47:31 -0000
X-Provags-ID: V01U2FsdGVkX1/C+8wFno/Csy/TmYQz/M1cvksW9zNu+EX8R99HQN
	P6sA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40629>

Hi,

On Mon, 26 Feb 2007, Linus Torvalds wrote:

> > +	if (read > 0 && data[read - 1] == '\n')
> > +		data[read - 1] = '\0';
> > +	else
> > +		data[read] = '\0';
> 
> First off, "read" here may be -1.

Ah yes. I somehow had the erroneous impression that xread() die()s on 
error like xmalloc()...

> 	/* Why do this? Because Dscho did.. */
> 	if (offset && data[offset-1] == '\n')
> 		offset--;

Well yes, it probably does not change anything except the output, which 
you see only when debugging.

It's not like I care deeply, because this part of the code will hopefully 
soon go away, when git-fetch is a proper builtin.

However, I compile with -DXMALLOC_POISON=1 and _that_ did not play well, 
whereas the read fails rather rarely on stdin...

But I agree your patch is saner.

Ciao,
Dscho
