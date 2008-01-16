From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 10:15:12 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Neil Macneale <mac4-git@theory.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCno-00063Z-Cg
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbYAPSPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYAPSPX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:15:23 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48545 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070AbYAPSPW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 13:15:22 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GIFCTS015582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 10:15:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GIFC5Z017247;
	Wed, 16 Jan 2008 10:15:12 -0800
In-Reply-To: <478E3D8E.1090300@talkingspider.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70714>



On Wed, 16 Jan 2008, Mike wrote:
>
> Neil Macneale wrote:
> >
> > It seems to me that you are asking git to be your deployment software,
> > which is a bad fit.
> 
> I'm asking git to get out of my deployment!

I think you mis-understood.

The normal way of handling this is to NOT DO DEVELOPMENT IN YOUR 
DEPLOYMENT TREE!

It's almost always a bad idea to develop in the tree that is also where 
you "export" things, and if you find git annoying in this respect, ask 
yourself why pretty much *every*single*scm*out*there* makes their 
infrastructure even more noticeable (eg CVS subdirectories in every single 
directory etc)

So while you can do various tricks (symlinking ".git", using GIT_DIR, etc 
etc) to get the .git contents out of your worktree, the thing is, the 
correct thing to do is almost always to simply re-think the whole problem, 
and come at it the other way: rather than getting .git out of your 
development tree, you should consider getting your development tree out of 
your deployment area!

Let me do a few examples of why this is a good idea:

 - the whole point of development trees and SCM's (and that's *especially* 
   true with git) is how you can try things out, go backwards in time, and 
   generally just do *development*.

   If you do that in what is your public deployment area, you're already 
   very limited. Not only may you not want to make that .git directory 
   accessible to others (while you *do* obviously want to make the 
   deployment itself), you also end up exposing things like your 
   management scripts and source code along with "generated files" etc 
   that are the things you actually want to deploy.

   Yes, it's certainly quite possible that you simply don't have any 
   management scripts etc, and that you don't generate any files, and you 
   simply want to just deploy the exact files that you also want to track. 
   But that really is a fairly unusual thing to do.

 - with git in particular, you lose a lot of the capabilities if you are 
   forcing yourself to have "deployment == development tree". Things like 
   switching branches for managing different versions suddenly are 
   painful, because you're artificially forcing a 1:1 relationship between 
   "development" and "deployment".

 - Most sane people want to deploy and test separately. In particular, you 
   want to test *before* you deploy. People make mistakes, they don't want 
   to show them. Or there are consistency requirements, and/or you simply 
   want to deploy to multiple sites simultaneously. All of which really 
   re-inforces the "develop separately" mentality, where the actual 
   deployment is then a separate "now I'm ready, let's push out the 
   result".

Now, maybe none of these things are issues at all for you. Good for you. 
But hopefully this explains why most people don't have your issues, and 
why people try to tell you that "deployment software" is a separate thing 
from "source control management", and you often want both, and _want_ to 
keep them separate.

		Linus
