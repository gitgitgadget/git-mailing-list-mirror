From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 00:42:28 -0500
Message-ID: <478EEAC4.2010006@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 06:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFNWu-0001KE-En
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 06:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbYAQFmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 00:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbYAQFmc
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 00:42:32 -0500
Received: from relay03.pair.com ([209.68.5.17]:4997 "HELO relay03.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751033AbYAQFmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 00:42:31 -0500
Received: (qmail 11732 invoked from network); 17 Jan 2008 05:42:29 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 17 Jan 2008 05:42:29 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70830>



Linus Torvalds wrote:

> Some people don't split this up, and they tend to make horrible horrible 
> mistakes, like checking in the *results* of the post-processing too (ie 
> binary result blobs that can be regenerated from the other files), because 
> they don't make a clear separation between the parts they do development 
> on, and the end result.

Honestly, I think your mode of thinking is centered around compiled 
languages and linux app(/kernel) development.  The web app 
development/deployment model is very different.

With PHP, Python, and Ruby, the development is the deployment.  The 
source is the output.  You can't develop web apps in those languages 
unless the source files you're working on are under the doc root of your 
development server.   "the parts they do development on" and "the end 
result" *are* the same files.

The "development server -> staging server -> live
server" model has been around in common use for as long as web
applications have. In fact, the term "deployment" falls apart here. 
 From my web app developer perspective, the deployment is what lands on 
the live server.  For your git perspective, the "deployment" may mean 
the .../docroot/php directory for the development server (where our app 
code lives).

There's a fundamental "best practice" of web development being violated 
here- keep your docroots clean, only put stuff in them that should go 
live (or should eventually go live when ready).  Other files should not 
live under docroot.

Among the reasons for that is security.  If one of those .git dirs does 
slip out and go live, it's a *huge* *gaping* *security* *hole*.  You 
could download the repository because those files don't have extensions, 
so the browser would just download them. I could write a spider that 
crawls around the web appending /.git to urls.

If we end up having to write a special "publisher" app to move files 
from dev to live, then it will only be because of those damn .git 
directories.  More likely we'd add some exclusions into an rsync 
wrapper, I guess. And then still worry about tarring up the docroot (not 
all of which is gitted).  And then worry that some young developer on 
the team might SCP a directory's contents and he didn't notice that .git 
dir because it doesn't show up under "ls" or the "ll" alias.

Maybe git just isn't intended to be used for anything besides compiled
languages like c?  Or maybe just not for web app development?

Finally, to this statement:

> It's almost always a bad idea to develop in the tree that is also where
> you "export" things, and if you find git annoying in this respect, ask
> yourself why pretty much *every*single*scm*out*there* makes their
> infrastructure even more noticeable (eg CVS subdirectories in every 
single
> directory etc)

I don't think that pointing at other SCM's practices as the authority is 
the stance you really want to take. I can direct you to a video of a 
speech by a brilliant guy, in front of some googlers, where he explains 
that the entire reason he started the git project is because of the 
problems with "*every*single*scm*out*there*".

Mike
