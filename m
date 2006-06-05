From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Horrible re-packing?
Date: Mon, 5 Jun 2006 14:40:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051432270.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org> <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051637490.24152@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 23:41:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnMom-0003IM-3Q
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 23:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWFEVk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 17:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWFEVk5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 17:40:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751021AbWFEVk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 17:40:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55Le32g012502
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 14:40:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55Le2vB025732;
	Mon, 5 Jun 2006 14:40:02 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606051637490.24152@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21346>



On Mon, 5 Jun 2006, Nicolas Pitre wrote:
> 
> In other words, the pack shrunk to less than half the size of the 
> previous one !

Ok, that's a bit more extreme than expected.

It's obviously great news, and says that the approach of sorting by 
"reversed name" is a great heuristic, but at the same time it makes me 
worry a bit that this thing that is supposed to be a heuristic ends up 
being _so_ important from a pack size standpoint. I was happier when it 
was more about saving a couple of percent.

Now, your repo may be a strange case, and it just happens to fit the 
suggested hash, but on the other hand it's nice to see three totally 
different repositories that all improve, albeit with wildly different 
numbers.

I'm wondering if we could have some "incremental optimizer" thing that 
would take a potentially badly packed archive, and just start looking for 
better delta chain possibilities? That way we would still try to get a 
good initial pack with some heuristic, but we could have people run the 
incremental improver every once in a while looking for good deltas that it 
missed due to the project not fitting the heuristics..

The fact that we normally do incremental repacking (and "-f" is unusual) 
is obviously one thing that makes us less susceptible to bad patterns (and 
is also what allows us to run the incremental optimizer - any good delta 
choice will automatically percolate into subsequent versions, including 
packs that have been cloned).

So the packing strategy itself seems to be very stable (and partly _due_ 
to the "optimization" to re-use earlier pack choices), but we currently 
lack the thing that fixes up any initial bad assumptions in case they 
happen.

			Linus
