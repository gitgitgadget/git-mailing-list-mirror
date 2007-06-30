From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Sat, 30 Jun 2007 10:27:41 -0400
Message-ID: <20070630142741.GA28917@thunk.org>
References: <20070628235319.GD29279@thunk.org> <20070629010507.GL12721@planck.djpig.de> <20070629034838.GF29279@thunk.org> <20070629063819.GA23138@coredump.intra.peff.net> <7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com> <alpine.LFD.0.98.0706290851480.8675@woody.linux-foundation.org> <20070629174046.GC16268@thunk.org> <alpine.LFD.0.98.0706291641590.8675@woody.linux-foundation.org> <7vlke2dw6w.fsf@assigned-by-dhcp.pobox.com> <alpine.LFD.0.98.0706292114350.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 16:28:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4dwS-0003xZ-03
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 16:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226AbXF3O2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 10:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbXF3O2I
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 10:28:08 -0400
Received: from THUNK.ORG ([69.25.196.29]:34039 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758891AbXF3O2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 10:28:05 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I4e3G-0003JU-J5; Sat, 30 Jun 2007 10:35:55 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I4dvJ-0004qN-V8; Sat, 30 Jun 2007 10:27:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706292114350.8675@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51218>

On Fri, Jun 29, 2007 at 09:24:41PM -0700, Linus Torvalds wrote:
> So you basically cannot get "perfect" with stdio. It's impossible. But the 
> above re-ordering will at least get you _closer_, and *most* of the time 
> you'll get exactly the error you'd expect.

Well, we *can* get perfect with stdio, but I can pretty much guarantee
no one will like it.  We could wrap printf, fprintf, purchar, et. al,
and check each of them for an error return.  The spec doesn't
currently specify that errno is supposed to be set, but a defect[1]
was filed last year saying that fprintf et.al, are indeed supposed to
set errno and not throw it away.

It would be a real pain in the *ss, though....

							- Ted

[1] http://www.opengroup.org/austin/mailarchives/ag-review/msg02161.html
