From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Tue, 26 Jun 2007 13:11:28 -0400
Message-ID: <20070626171127.GA28810@thunk.org>
References: <87r6nzu666.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org> <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 19:11:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3EZm-0003ek-UX
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 19:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184AbXFZRLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757167AbXFZRLh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 13:11:37 -0400
Received: from THUNK.ORG ([69.25.196.29]:58226 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756714AbXFZRLg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 13:11:36 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I3EhO-0008DJ-LG; Tue, 26 Jun 2007 13:19:30 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I3EZc-0001sr-8E; Tue, 26 Jun 2007 13:11:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50966>

On Mon, Jun 25, 2007 at 04:16:56PM -0700, Linus Torvalds wrote:
> Again, this is something that a non-stdio-based buffering library would 
> easily handle. You could just test the file descriptor _once_ at the 
> beginning, to see if it's a regular file or not. And then you could have 
> the error handling where it belongs (when the IO is actually done, and the 
> error actually happens) rather than in the callers using a bad interface 
> that sometimes loses 'errno'.

Is there something obviously wrong with doing something like this?

	if ((fstat(fileno(stdout), &st) < 0) &&
	    !S_ISREG(st.st_mode))
		setbuf(stdout, NULL);

This would change stdout to use completely unbuffered I/O we're not
sending the output to a file.

						- Ted
