From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Getting 'git log' (or something else) to show me the relevant
 sub-graph?
Date: Tue, 20 Apr 2010 17:18:17 +0200
Message-ID: <4BCDC5B9.1000705@drmicha.warpmail.net>
References: <201004201649.31084.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 17:21:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4FGU-0007ni-AM
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 17:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab0DTPVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 11:21:25 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54228 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752158Ab0DTPVY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 11:21:24 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DA9F9EAC74;
	Tue, 20 Apr 2010 11:21:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 20 Apr 2010 11:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3cdXLaYdbsVgxxAh3J+i+CkF9gs=; b=F+1JR2AR+/UNihQ5/fNg70xS3aR0QDgnvx6+qNrtRd0w22K+drFDi7JcE7Kn8QuWgB40Ec8YiEhZmBje6VEozIXtd0kL+tOjxdjro3o9CeY3BpZ54KRLYFEBJV0+CycdMgaSjHcxoMAsmVwz8rx1KWiU9zAp3z0Q9KOJ5lN+O8A=
X-Sasl-enc: PlO0M6ziIcyFc6dR0VDyuYkglFQPUb9cokkkWYFf9Qjg 1271776883
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 33B1A4B3099;
	Tue, 20 Apr 2010 11:21:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <201004201649.31084.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145384>

Johan Herland venit, vidit, dixit 20.04.2010 16:49:
> Hi,
> 
> Consider the following (simplified) history:
> 
> ---O---O---O---O---O---O---O---O---O---O---O---O---M2--H  <-- mainline
>     \                                             /
>      O---O---O---O---O---O---O---M1--D---E---F---G  <-- dev-branch
>               \                 /
>                O---O---A---B---C  <-- topic-branch
> 
> Now, assume that I have bisected my way through to 'A', and found that 
> it introduces some bug. Now, I'm interested in visualizing the path 
> that this bug "travelled" to get into "mainline", i.e. the following 
> sub-graph:
> 
>                           --M2--H  <-- mainline
>                            /
>         --M1--D---E---F---G  <-- dev-branch
>          /
> A---B---C  <-- topic-branch
> 
> In other words, I'm interested in the following log (with decorations):
> 
> H (mainline)
> M2
> G (dev-branch)
> F
> E
> D
> M1
> C (topic-branch)
> B
> A
> 
> I have unsuccessfully dug through the 'git log' documentation to figure 
> out if it can produce this log, so I'm now throwing the question to the 
> almighty knowledge of the mailing list...
> 
> Here are some of my closest attempts, so far:
> 
> - git branch --contains A
> 	gives me "topic-branch", "dev-branch" and "mainline", which is
> 	relevant, but incomplete.
> 
> - git log --oneline --decorate --graph A^..mainline
> 	gives me a log/graph where I can search for A and then use the graph
> 	to trace the way back up to "mainline", but it still displays a lot of
> 	uninteresting commits (ancestors of M1 and M2) that I have to
> 	disregard. Although this is ok once in a while, the problem is common
> 	enough (and the real-world graphs complicated enough), that I'd like a
> 	better solution, if possible.
> 
> I guess what I'm looking for is something similar to --first-parent, 
> except instead of the _first_ parent, it should follow the _relevant_ 
> parent, as far as the relationship between A and "mainline" is 
> concerned.
> 
> In set-theory terms I guess what I want is "that which is both an 
> ancestor of H, and a descendant of A (inclusive)", but I don't know how 
> to explain this to 'git log'.

This would require a reverse tree walker for the first half of that set
intersection. It would come in handy in many situations, but we don't
have it.

Mathematically speaking it is trivial to associate to a directed graph
the graph with opposite orientation. Then we could walk as usual...

But, in fact, we do not "walk then intersect", but the walker implements
the intersection, so having that other dag would not even help.

Maybe we can teach the walker to mark commits as uninteresting which do
not have A in their ancestry?

Michael
