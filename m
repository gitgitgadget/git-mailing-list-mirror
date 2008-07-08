From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Tue, 8 Jul 2008 04:19:47 +0000
Message-ID: <20080708041947.GA2542@spearce.org>
References: <200807080227.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4h4-0000Rq-De
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYGHETs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYGHETs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:19:48 -0400
Received: from george.spearce.org ([209.20.77.23]:52019 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYGHETs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:19:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2EADB38195; Tue,  8 Jul 2008 04:19:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807080227.43515.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87704>

Jakub Narebski <jnareb@gmail.com> wrote:
> I'd very much like to have (or perhaps to wrote) some sort of interim 
> progress report for Google Summer of Code 2008 projects on 
> http://git.or.cz/gitwiki/SoC2008Projects.  Therefore I'd like you to 
> expand and/or correct those mini-summaries below.
> 
> (It would be, I guess, good preparation for GSoC 2008 mid-term 
> evaluations, which according to GSoC 2008 timeline
>   http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
> are to take place July 7 -- July 14.)

Yes, it is that time for evaluations.  The evaluations are now open
to students and mentors alike; please make sure you complete them
by the deadline of July 14th.
 
> 4. Eclipse plugin push support (!)
> 
> Student: Marek Zawirski
> Mentor: Shawn O. Pearce
> 
> I am not following egit/jgit development close enough, but if I remember 
> correctly there is some code which provides very rudimentary support 
> for native generation of simplified packs, and IIRC also for push over 
> some protocols.
> 
> And there is push support over SFTP and (encrypted) Amazon S3...

Marek is on holiday right now, so I have to answer for him here.
Otherwise I would have preferred to let him do it.

Thus far Marek has completed generation of packs, including delta
re-use from packs using either v1 or v2 index, including taking
advantage of the CRC inside the v2 index to accelerate a safe reuse.
This code permits jgit to write a valid pack.

The packing code does not (yet) search for a delta base, or create
a new delta for an undeltified object.  Packing loose objects packs
them as whole objects in the pack file, resulting in little to no
reduction over their loose object size.  This is not a limitation
of Java.  Marek and I simply decided that protocol support was more
important than really tight network transport at this point in time.

As a result of being able to create pack files Marek was able to
implement the client side of git-push for the native pack transfer
service, aka push over SSH, push to another local repository (by
forking 'git receive-pack') and push over anonymous git://.

Using Marek's pack generation code I added support for push over
the dumb sftp:// and amazon-s3:// protocols, with the latter also
supporting transparent client side encryption.

I chose to add these features to jgit partly as an exercise to prove
that Marek's code was built well enough to be reused for this task,
partly because I wanted to backup some private personal repositories
to Amazon S3, and partly to prove that multiple dumb transports
could implement push support.

All of the above is done in the non-Eclipse, BSD licensed jgit
library, making it available to any tool built on top of the Java
platform, even if said tool does not use the Eclipse platform or
any other code from Eclipse.


At this point Marek's code is in the main egit.git tree's master
branch, and is in "production" use by myself and Robin, and maybe
a few others.  I am quite happy with the work Marek has completed
to date for the project.

When Marek returns from his holiday he will be working on Eclipse
UI features to expose this jgit push functionality to the end-user
within the Eclipse workbench.

-- 
Shawn.
