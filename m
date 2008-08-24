From: Junio C Hamano <gitster@pobox.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 17:30:01 -0700
Message-ID: <7vzln3w8za.fsf@gitster.siamese.dyndns.org>
References: <20080822174655.GP23334@one.firstfloor.org>
 <m37ia8sv49.fsf@localhost.localdomain>
 <20080823071552.GU23334@one.firstfloor.org>
 <200808231121.41694.jnareb@gmail.com>
 <20080823165350.GY23334@one.firstfloor.org>
 <4d8e3fd30808231404y7293eb56g4fbed5565ab2aa9a@mail.gmail.com>
 <alpine.LFD.1.10.0808231440530.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Andi Kleen <andi@firstfloor.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 02:31:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX3Vo-0003ov-BQ
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 02:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYHXAaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 20:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYHXAaP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 20:30:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYHXAaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 20:30:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D33376BFBB;
	Sat, 23 Aug 2008 20:30:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2E1906BFB1; Sat, 23 Aug 2008 20:30:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808231440530.3363@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sat, 23 Aug 2008 14:52:37 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0C1A7F2-7173-11DD-86F9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93504>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Let's look at what happens. Let's say that your history looks like
>
> 	... -> A -> B -> C -> a -> b -> c
>
> where the upper-case letters are from the tree you track, and the 
> lower-case letters are the commits you added yourself.
>
> Now, let's say that the tree you track gets rebased, and in the process 
> 'B' is removed (because it turns out it was buggy), and A and C get 
> modified. What happens?
>
> You now have
>
> 	... -> A -> B -> C -> a -> b -> c     <- your branch
> 	  \
> 	    other stuff -> A' -> C'     <- newly rebased branch
>
> (where "other stuff" is whatever the remote branch was rebased on top 
> of) and when you now try to rebase your stuff on top of the newly rebased 
> branch, you are going to end up trying to rebase all the _old_ commits 
> that weren't even yours (ie it's going to try to rebase A, B and C too!)
> ...
> What you can do is to basically do
>
> 	git fetch nasty-tree
> 	git rebase C.. --onto nasty-tree
>
> ie you can explicitly _tell_ rebase which commits you want to rebase. 

Which if I am reading git-rebase.sh right (mind you, this is not my code,
so I may well be mistaken), that is what "pull --rebase" attempts to do
with the "oldremoteref" variable.
