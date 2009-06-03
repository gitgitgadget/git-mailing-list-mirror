From: Jeff King <peff@peff.net>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 19:37:10 -0400
Message-ID: <20090603233710.GA10578@coredump.intra.peff.net>
References: <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> <7v8wk96knh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> <7vmy8p54fr.fsf@alter.siamese.dyndns.org> <20090603224413.GA2902@coredump.intra.peff.net> <alpine.LFD.2.01.0906031547480.4880@localhost.localdomain> <20090603230606.GA5462@coredump.intra.peff.net> <alpine.LFD.2.01.0906031619150.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 01:37:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC01P-0000cL-LZ
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 01:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZFCXhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 19:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbZFCXhR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 19:37:17 -0400
Received: from peff.net ([208.65.91.99]:50565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbZFCXhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 19:37:17 -0400
Received: (qmail 27794 invoked by uid 107); 3 Jun 2009 23:37:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Jun 2009 19:37:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2009 19:37:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0906031619150.4880@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120665>

On Wed, Jun 03, 2009 at 04:27:39PM -0700, Linus Torvalds wrote:

> >   rm b.txt && git add b.txt &&
> >   echo resolve >a.txt && git add a.txt &&
> >   git commit -m merged
> 
> This doesn't work at all for me.
> 
> Do
> 
> 	git show HEAD:b.txt
> 
> and it still shows b.txt in the commit. You should have used
> 
> 	git rm b.txt
> 
> rather than "git add b.txt" (or you use use "-u" or "-a" to git add).

Er, sorry, yeah, I botched the recipe (I initially used "git rm" by
itself, but it complains about "changes staged in the index", so I fixed
it up manually and then botched writing out the automated version).

But I see you figured out what I meant, so...

> But you're right. Even when fixed, it does seem to need "--full-history" 
> to stay around, and --simplify-merges is insufficient. Bug in merge 
> simplification?

I don't even see it with --full-history. I get:

  $ git log -m --stat --oneline | head
  b1a38ec (from 2671fa7) merged
   a.txt |    2 +-
   1 files changed, 1 insertions(+), 1 deletions(-)
  b1a38ec (from d0bac65) merged
   a.txt |    2 +-
   b.txt |    1 -
   2 files changed, 1 insertions(+), 2 deletions(-)

  $ git log -m --stat --oneline -- b.txt
  (no output)

  $ git log --simplify-merges -m --stat --oneline -- b.txt
  912ac84 other 1
   b.txt |    1 +
   1 files changed, 1 insertions(+), 0 deletions(-)

  $ git log --full-history -m --stat --oneline -- b.txt
  912ac84 other 1
   b.txt |    1 +
   1 files changed, 1 insertions(+), 0 deletions(-)

Is there some trick to enabling both path limiting _and_ still showing
the merge commit? Or is this a bug?

-Peff
