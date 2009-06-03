From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 15:47:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906031544170.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
 <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> <7v8wk96knh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> <7vmy8p54fr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBzFX-0005MD-3t
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbZFCWrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbZFCWrv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:47:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59331 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752284AbZFCWru (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 18:47:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53MlEKB006077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2009 15:47:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53MlDsb000447;
	Wed, 3 Jun 2009 15:47:13 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vmy8p54fr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120659>



On Wed, 3 Jun 2009, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > For example, right now there is _no_ way to get even a "show diff relative 
> > to first parent". You can do "-m", which will show it relative to _both_ 
> > parents, but nobody ever wants that. And you can do "-c" or "--cc", but 
> > that simplifies away all the paths that match in one. 
> 
> Actually for that "Where did my file 'x' go across the merge chain", I was
> going to suggest something like
> 
> 	git log --simplify-merges -m --raw -- x

Ok. Not very readable, but it's certainly getting closer.

> > So here's a challenge: in the git repository, get a nice view of what your 
> > merges looked like. The closest I can get is
> >
> > 	git log -c --stat --grep="Merge branch '"
> >
> > which is actually very non-intuitive ("-c" on its own gives no useful 
> > output, but "-c --stat" gives nice diffstat against the first parent, 
> > which in this case is what we want).
> 
> I think the logical place to hook that into is the --first-parent option.
> 
> I actually have very hard resisted so far the temptation to do so because
> your mantra has always been "in a merge, all parents are equal." 

Oh, I agree. The challenge was just the first step - how to make it do 
merges in general sanely would be the issue.

Because if you do just --first-parent, then that won't even show the 
test-case that Graham actually had - because the missing file didn't come 
in from the first parent of a merge. 

The challenge was mainly as a way to point out that even some fairly 
simple cases aren't all that simple.

		Linus
