From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 11:48:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 20:48:23 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GazPq-0002oH-4V
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 20:48:22 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GazPn-00073l-Dn; Fri, 20 Oct 2006 19:48:19 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GazPh-00073d-28
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 19:48:13 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KImAaX030895
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 11:48:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KIm946029672;
	Fri, 20 Oct 2006 11:48:09 -0700
To: Jan Hudec <bulb@ucw.cz>
In-Reply-To: <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
X-Spam-Status: No, hits=-0.975 required=5 tests=AWL,
	OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29522>



On Fri, 20 Oct 2006, Jan Hudec wrote:
>
> Let's consider following scenario:

Here's a real-life schenario that we hit several times with BK over the 
years:

 - take a real repository, and a patch that gets discussed that adds a new 
   file.
 - take two different people applying that patch to their trees (or, do 
   the equivalent thing, which is to just create the same filename
   independently, because the solution is obvious - and the same - to 
   both developers).
 - now, have somebody merge both of those two peoples trees (eg me)
 - have the two people continue to use their trees, modifying it, and 
   getting merged.

Trust me, this isn't even _unlikely_. It happens. And it's a serious 
problem for a file-ID case. Why? Because you have two different file ID's 
for the same pathname. 

(It happily only happened a handful of times, so it was never a big enough 
problem to cause me to think that BK was crap. But it definitely was a 
real issue).

What BK did (and what is likely the only reasonable thing to do) is to 
move one of the file-ID's to an "Attic" kind of place, and just go with 
the other. The nasty part is that now the developer whose file was 
"dropped" (and anybody who got the work from him) may still be continuing 
to work with _his_ copy of the same file, never even realizing that when 
his work gets merged, all his fixes GET THROWN AWAY!

And trust me, this isn't a theoretical thing. This actually happens. So 
you have problems at many levels: you have the problems that happen during 
the merge (where somebody needs to decide how to resolve the file-ID 
clash), but what a lot of SCM people seem to not have understood is that 
the problem actually _remains_ after the merge, and causes problems even 
down the line.

So yeah, content-based merging has its own problems (especially if you do 
things like re-indent a file as you move it, or if you have files that 
just look the same because they share 99% of their content through a 
copyright message), but at least so far, we've not really ever hit that 
issue in the kernel.

And we are actually approaching the old kernel BK tree in size with the 
current git tree (we're about 2/3rds of the way if you count number of 
commits). That's despite the fact that we actually have been moving things 
around.  So from a purely _practical_ standpoint, I really do have 
anecdotal evidence that I'm right.

I didn't have that evidence when I started, but I knew I was right anyway ;)

		Linus

PS. It's undoubtedly true that the SCM you use impacts _how_ you do 
development, so any project will almost automatically align itself with 
whatever SCM rules there are in place.

So "anecdotal evidence" in that sense isn't really wonderful, since it 
obviously is always a matter of a certain project/SCM combination - but 
the above example is about as neutral as you can get, since it's the 
_same_ project, with the _same_ maintainer, and roughtly the _same_ rules, 
just two different approaches wrt renames of the SCM's in question.
