From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 15:54:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271545140.3952@g5.osdl.org>
References: <20060927222854.82278.qmail@web51014.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 00:55:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSiJD-00060X-GG
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 00:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031195AbWI0Wy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWI0Wy6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 18:54:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965163AbWI0Wy5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 18:54:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RMslnW002058
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 15:54:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RMskdM020169;
	Wed, 27 Sep 2006 15:54:47 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927222854.82278.qmail@web51014.mail.yahoo.com>
X-Spam-Status: No, hits=-0.466 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27942>



On Wed, 27 Sep 2006, Matthew L Foster wrote:
>
> So the separate action of replication is not tracked?

Correct. Replication without changes is a no-op.

> Replication/sub merges are denied the possibility of "truth"?

No, it's actually much deeper than that.

To git, pure replication simply isn't an action at all, so trying to track 
it would be like trying to track all the voices in my head - something 
that doesn't exist. It wouldn't be "truth", it would be insanity.

And the thing is, _not_ tracking it is really fundamental. If you actually 
track the issue of copying a git repository, you'd end up in a technically 
untenable and insane situation. You could never "merge" two git trees ever 
again without going into an infinite bouncing back-and-forth of "A merged 
the changes from B" and "B merged the fact that A merged the changes from 
B" and "A merged the fact that B merged the fact that A merged the changes 
from B" and so on ad infinitum.

There's another reason too, namely that if you track where things came 
from and when, suddenly it matters whether you cloned from the _original_ 
repository or from somewhere else. And that's also fundamnetally wrong, 
since I don't actually want to give _anybody_ access to the actual 
original repository on my machine, so everything always has to go through 
an intermediate repository. If we tracked that, we'd just confuse 
everything, and it wouldn't be seamless any more.

There's one final reason, namely that I wanted to design git to just track 
_contents_. So the design philosophy is very much against tracking exactly 
which repository something has been in, since that has nothing to do with 
the deeper issue of what you are actually tracking.

		Linus
