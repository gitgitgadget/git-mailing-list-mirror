From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
 dscms and a "whole product" approach)
Date: Fri, 1 May 2009 14:37:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0905011420580.5379@localhost.localdomain>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <20090430142244.GA23550@coredump.intra.peff.net> <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
 <20090501190854.GA13770@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 01 23:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M00Si-0002oH-Hf
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 23:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbZEAVjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 17:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754601AbZEAVjz
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 17:39:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54003 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751907AbZEAVjy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 17:39:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n41LbT46009688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 May 2009 14:38:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n41LbS4I009190;
	Fri, 1 May 2009 14:37:28 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090501190854.GA13770@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118098>



On Fri, 1 May 2009, Jeff King wrote:
> 
> Thanks for the analysis; what you said makes sense to me. However, there
> is at least one case of somebody complaining that git doesn't scale as
> well as perforce for their load:

So we definitely do have scaling issues, there's no question about that. I 
just don't think they are about enterprise network servers vs the more 
workstation-oriented OSS world..

I think they're likely about the whole git mentality of looking at the big 
picture, and then getting swamped by just how _huge_ that picture can be 
if somebody just put the whole world in a single repository..

With perforce, repository maintenance is such a central issue that the 
whole p4 mentality seems to _encourage_ everybody to put everything into 
basically one single p4 repository. And afaik, p4 basically works mostly 
like CVS, ie it really ends up being pretty much oriented to a "one file 
at a time" model.

Which is nice in that you can have a million files, and then only check 
out a few of them - you'll never even _see_ the impact of the other 
999,995 files.

And git obviously doesn't have that kind of model at all. Git 
fundamnetally never really looks at less than the whole repo. Even if you 
limit things a bit (ie check out just a portion, or have the history go 
back just a bit), git ends up still always caring about the whole thing, 
and carrying the knowledge around.

So git scales really badly if you force it to look at everything as one 
_huge_ repository. I don't think that part is really fixable, although we 
can probably improve on it.

And yes, then there's the "big file" issues. I really don't know what to 
do about huge files. We suck at them, I know. There are work-arounds (like 
not deltaing big objects at all), but they aren't necessarily that great 
either.

I bet we could probably improve git large-file behavior for many common 
cases. Do we have a good test-case of some particular suckiness that is 
actually relevant enough that people might decide to look at it (and by 
"people", I do mean myself too - but I'd need to be somewhat motivated by 
it. A usage case that we suck at and that is available and relevant).

			Linus
