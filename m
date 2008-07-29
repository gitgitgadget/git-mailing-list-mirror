From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 08:50:02 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807290838360.3334@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <alpine.LFD.1.10.0807282023290.3334@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807291235350.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 17:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNrWy-0005Ex-Q1
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 17:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbYG2Pxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 11:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYG2Pxc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 11:53:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60310 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751862AbYG2Pxc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 11:53:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6TFr1X2029734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 08:53:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6TFr1nK008439;
	Tue, 29 Jul 2008 08:53:01 -0700
In-Reply-To: <Pine.LNX.4.64.0807291235350.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.41 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90650>



On Tue, 29 Jul 2008, Roman Zippel wrote:
> 
> I'm not dismissing it, but your focus is on how to get this result.

No, you misunderstand.

My focus is really on one single thing:

 - performance

with a smaller focus on the fact that I simply don't see how it's 
_possible_ to do better than our current all-or-nothing approach of 
simplification (eg either extreme simplification or none at all: nothing 
or --full-history).

So here's my challenge again, which you seem to have TOTALLY MISSED.

Make this be fast:

	time sh -c "git log <filename> | head"

nothing else matters. If you can make that one be fast, I'm happy. 

And that "| head" is really very fundamentally important. The important 
thing from a performance standpoint is not how long the _whole_ "log" 
takes. The important thing is how fast it _feels_, and that is directly 
tied to how fast it starts outputting the data.

Put another way: I _know_ how to simplify things. Trust me, Roman. That's 
not the problem. But doing it incrementally is really really hard, to the 
point that I actually believe that it is impossible to do. 

And doing it after-the-fact is simply not interesting. We could trivially 
(well, _fairly_ trivially) do it when we do the topology sort. But I have 
long long tried to teach people _not_ to do the topo sort inside the core 
git machinery, exactly because it is a horrid thing from an interactivity 
standpoint.

In fact, you can see what I'm talking about by trying --topo-order in the 
above timing test.

Really. Just _try_ it. And if you still don't understand what I'm talking 
about, I don't know what to say.

> > And quite frankly, I've seen that behaviour from you before, when it comes 
> > to other things.
> 
> What exact behaviour is that? That I dare to disagree with you?

No. The fact that you like arguing _pointlessly_, and just being abrasive, 
without actually helping or understanding the big picture. I'm thinking 
back on the whole scheduler thing. You weren't arguing with _me_, but you 
had the same modus operandi.

			Linus
