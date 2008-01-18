From: Andreas Ericsson <ae@op5.se>
Subject: Re: I don't want the .git directory next to my code.
Date: Fri, 18 Jan 2008 09:41:39 +0100
Message-ID: <47906643.2010201@op5.se>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 09:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmqJ-00027e-Cm
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYARIoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 03:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbYARIoX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:44:23 -0500
Received: from mail.op5.se ([193.201.96.20]:48412 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbYARIoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 03:44:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 83E9C1F08033;
	Fri, 18 Jan 2008 09:44:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fb8lFkVfpELm; Fri, 18 Jan 2008 09:44:18 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.124])
	by mail.op5.se (Postfix) with ESMTP id F0A7F1F0802F;
	Fri, 18 Jan 2008 09:44:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <478EEAC4.2010006@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70978>

Mike wrote:
> 
> 
> Linus Torvalds wrote:
> 
>> Some people don't split this up, and they tend to make horrible 
>> horrible mistakes, like checking in the *results* of the 
>> post-processing too (ie binary result blobs that can be regenerated 
>> from the other files), because they don't make a clear separation 
>> between the parts they do development on, and the end result.
> 
> Honestly, I think your mode of thinking is centered around compiled 
> languages and linux app(/kernel) development.  The web app 
> development/deployment model is very different.
> 
> With PHP, Python, and Ruby, the development is the deployment.  The 
> source is the output.  You can't develop web apps in those languages 
> unless the source files you're working on are under the doc root of your 
> development server.   "the parts they do development on" and "the end 
> result" *are* the same files.
> 

We develop several different PHP packages. We have a test-server where
pandemonium reings with regards to .git directories and which branches
are checked out where. We also have a release process, and .git dirs
*never* end up on production servers.

The release-process is this: "git tag -s $tag_name; git push $tag_name".
The update-hook then marks the repo as having a new release and a cron-
job, running every 5 minutes, takes care of updating our production
servers. It took me all of 30 minutes to hack up, and not only does it
make sure we never publish the .git directory, it also makes it really,
really easy for <insert-non-git-savvy-customer-X> to report a version in
which he or she has spotted a bug.

> 
> There's a fundamental "best practice" of web development being violated 
> here- keep your docroots clean, only put stuff in them that should go 
> live (or should eventually go live when ready).  Other files should not 
> live under docroot.
> 

You accomplish that by making sure only stable and signed versions hit
the deployment server(s). Manual scp/rsync/ftp-mirroring of the testing
server's docroot is just plain stupid.

> 
> Maybe git just isn't intended to be used for anything besides compiled
> languages like c?  Or maybe just not for web app development?
> 

Well, it was originally intended to manage the Linux kernel, but it's
written in such a way as to be capable of competently manage just about
anything.


> Finally, to this statement:
> 
>> It's almost always a bad idea to develop in the tree that is also where
>> you "export" things, and if you find git annoying in this respect, ask
>> yourself why pretty much *every*single*scm*out*there* makes their
>> infrastructure even more noticeable (eg CVS subdirectories in every 
> single
>> directory etc)
> 
> I don't think that pointing at other SCM's practices as the authority is 
> the stance you really want to take. I can direct you to a video of a 
> speech by a brilliant guy, in front of some googlers, where he explains 
> that the entire reason he started the git project is because of the 
> problems with "*every*single*scm*out*there*".
> 

Those problems aren't "all the scm's in the world store their meta-data
somewhere!" though, and the ability to tar up a working-tree and get the
git-directory too is not always a bad thing. It's just your release
process that needs to eliminate the manual step there so you never copy
it by accident. That's why people write small and simple scripts though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
