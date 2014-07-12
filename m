From: Pete Wyckoff <pw@padd.com>
Subject: Re: git p4 diff-tree ambiguous argument error
Date: Sat, 12 Jul 2014 14:10:34 -0400
Message-ID: <20140712181034.GB26857@padd.com>
References: <1405013428825-7614774.post@n2.nabble.com>
 <53BED67D.8080006@diamand.org>
 <4EECAC73-DACA-4C0F-AE97-944F0DEE490B@mac.com>
 <BEE93DDF-7F3E-423D-AA3F-0D72E8FD08B3@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Duane Murphy <duanemurphy@mac.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 20:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X61kv-0002qt-DN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 20:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbaGLSKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 14:10:38 -0400
Received: from honk.padd.com ([71.19.245.7]:50220 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbaGLSKh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 14:10:37 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id 8EC4020D5;
	Sat, 12 Jul 2014 11:10:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4E0B7202A3; Sat, 12 Jul 2014 14:10:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <BEE93DDF-7F3E-423D-AA3F-0D72E8FD08B3@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253396>

duanemurphy@mac.com wrote on Thu, 10 Jul 2014 12:19 -0700:
> Some additional investigation. 
> 
> I am working in a copy of a repository that was originally used to pull the data 
> from Perforce. As part of my experiments to figure out this problem, I deleted 
> the contents of .git/git-p4-tmp/. 
> 
> I noticed that git-p4 would continue if those files were present. I have now 
> copied the files that were in .git/git-p4-tmp/ from the other repository. 
> 
> git-p4 is not crashing now, but I also noticed that none of the dates on these files
> have changed. These files should have been touched each time that a branch is taken,
> but these files have not changed while the sync is running.
> 
> That seems significant. 
> 
> I expect git-p4 to crash again on a new commit that is not in .git/git-p4-tmp/. 
> Then I have to start the 8-12 hour process over again (did I mention 70k commits?).

Bizarre.  That directory is really supposed to be temporary, and
live only during a single git p4 invocation.  It's just a bunch
of branch heads for the temporary commits.  I don't know why
those branches, and the git-p4-tmp directory, hang around after
you run git p4.  Might be worth your investigation.

The second weirdness is why a new run doesn't create the branch.
This maybe points to self.checkpoint() not really checkpointing.
It does send a "checkpoint" down the git fast-import stream,
which is supposed to make it write the branches out.  You might
consider grabbing the fast-import process in a debugger and see
why it's not writing out the branch head.

There's lots of changes since v1.7.12.4, but nothing obvious I
can see that would cause this.  Sorry,

		-- Pete
