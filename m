From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 12:00:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
 <200610202047.11291.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Hudec <bulb@ucw.cz>, Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 21:02:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gazby-0005SJ-91
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 21:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992770AbWJTTAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 15:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992801AbWJTTAh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 15:00:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992792AbWJTTAe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 15:00:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KJ09aX031545
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 12:00:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KJ04wI030037;
	Fri, 20 Oct 2006 12:00:06 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610202047.11291.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.975 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29523>



On Fri, 20 Oct 2006, Jakub Narebski wrote:

> Jan Hudec wrote:
> 
> > And note, that it is /not/ required to use file-ids to handle this.
> > Darcs handles this just as well with it's patch algebra
> > (http://darcs.net/DarcsWiki/PatchTheory) without need of any IDs.
> 
> And Darcs is, from opinions I've read, dog-slow.

You really cannot expect to get any kind of performance at all unless you:

 - are able to ignore 99.9% of all files on merging (ie you have to be 
   able to totally ignore the files that are identical in both sides, and 
   you really shouldn't even _care_ about why they ended up being 
   identical)

 - are able to ignore 99% of what the commits _did_ in between the merges 
   (ie if you need to look at them at all, only look at the part that 
   matters for the 0.1% of files that you couldn't ignore)

If you have to parse all the commit details all the way down to the common 
parent, you're basically already screwed. There's no _way_ you can make it 
fast. 

Git goes one step further: it _really_ doesn't matter about how you got to 
a certain state. Absolutely _none_ of what the commits in between the 
final stages and the common ancestor matter in the least. The only thing 
that matters is what the states at the end-point are.

(Of course, you _could_ plug in a merge algorithm that cares, since there 
is more data there. I'm just talking about the standard "recursive" 
algorithm here.)

That's why git can be so fast, but it's actually more important than that: 
the fact that it doesn't matter _how_ you got to a certain state is 
actually a huge and important feature. In other words, you should see it 
as a guarantee, not as a "lack of knowledge".

Darcs thinks it matters how you got somewhere. Git consciously says: none 
of the individual patches matter, the only thing that matters is the end 
result, because you could have gotten the same result in a lot of 
different ways, and nobody _cares_.

			Linus
