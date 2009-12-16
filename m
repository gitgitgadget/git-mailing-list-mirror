From: Mark Jerkovic <mjerkovic@aconex.com>
Subject: Re: git svn clone just stops
Date: Thu, 17 Dec 2009 07:47:38 +1100
Message-ID: <1260996458.6475.11.camel@mark.engr.acx>
References: <1260915555.6475.8.camel@mark.engr.acx>
	 <20091216081514.GB26038@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:48:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL0nB-0004uy-MD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 21:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZLPUr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 15:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbZLPUrx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 15:47:53 -0500
Received: from mail.aconex.com ([203.89.202.182]:58444 "EHLO
	postoffice2.aconex.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753371AbZLPUrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 15:47:46 -0500
X-ASG-Debug-ID: 1260996463-7f4300100000-QuoKaX
X-Barracuda-URL: http://postoffice2.aconex.com:8000/cgi-bin/mark.cgi
Received: from postoffice.aconex.com (localhost [127.0.0.1])
	by postoffice2.aconex.com (Spam & Virus Firewall) with ESMTP
	id 57270B4319; Thu, 17 Dec 2009 07:47:43 +1100 (EST)
Received: from postoffice.aconex.com (postoffice.yarra.acx [192.168.102.1]) by postoffice2.aconex.com with ESMTP id MXUW7SLt6RGCDQ6h; Thu, 17 Dec 2009 07:47:43 +1100 (EST)
X-Barracuda-Envelope-From: mjerkovic@aconex.com
Received: from gatekeeper.aconex.com (gatekeeper.yarra.acx [192.168.102.10])
	by postoffice.aconex.com (Postfix) with ESMTP id 11DFEA501BD;
	Thu, 17 Dec 2009 07:45:46 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gatekeeper.aconex.com (Postfix) with ESMTP id 291194892DF;
	Thu, 17 Dec 2009 07:47:43 +1100 (EST)
X-Virus-Scanned: amavisd-new at aconex.com
Received: from gatekeeper.aconex.com ([127.0.0.1])
	by localhost (gatekeeper.aconex.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FeyWlR74gtce; Thu, 17 Dec 2009 07:47:38 +1100 (EST)
Received: from [192.168.7.137] (melho0.aconex.com [203.89.192.141])
	by gatekeeper.aconex.com (Postfix) with ESMTP id 2DD344892D7;
	Thu, 17 Dec 2009 07:47:38 +1100 (EST)
X-ASG-Orig-Subj: Re: git svn clone just stops
In-Reply-To: <20091216081514.GB26038@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.1 
X-Barracuda-Connect: postoffice.yarra.acx[192.168.102.1]
X-Barracuda-Start-Time: 1260996463
X-Barracuda-Virus-Scanned: by Aconex Staff Email Spam Firewall at aconex.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135339>

On Wed, 2009-12-16 at 00:15 -0800, Eric Wong wrote:
> Mark Jerkovic <mjerkovic@aconex.com> wrote:
> > Hi all,
> > 
> > I am new to Git and I am attempting to clone a SVN repository
> > (containing approximately 60,000 commits) to Git.
> > 
> > Using Git v1.6.0.4 with the following command:
> > 
> > git svn clone https://path/to/svn/repo/trunk project.git
> > --authors-file=svnauthors.txt --no-metadata
> > 
> > the process just ends without any messages and the Git repository is
> > empty.  I have attempted this four times already, and each time it has
> > stopped after a different revision, so I can't pin it down to a
> > particular commit.
> 
> Hi Mark,
> 
> Any chance you're OOM-ing (extremely large file) or running
> out of space somewhere?  What exit code do you get when it exits?
> 
> > Has anyone experienced this before?  Is there a log anywhere that
> > records what is happening during this process?
> 
> Not without error messages of some sort.  git svn was designed with poor
> network conditions in mind and clone is resumable, so you can just
> resume like this:
> 
>    cd project.git && git svn fetch
> 
That is an excellent tip.  Thanks a lot!
> I wouldn't use --no-metadata at this point, though, as it makes it much
> harder to debug/fix things or recover from errors.
> 
> Once you're comfortable with it, you should be able to write
> "git filter-branch" invocation to remove the metadata lines.
I have done some more investigating and it appears that at some point a
branch was moved to replace our trunk.  When the migration process hits
this I it goes back to the beginning and starts migrating the branch
history too.  I think when it gets to the end of it is not able to
resume from the "move" point.  

I will try your resume tip to see if I can get it started again.

Many thanks,
Mark.
> 
