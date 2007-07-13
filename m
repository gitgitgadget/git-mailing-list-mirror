From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: git-svn: trunk missing, checks out tag instead
Date: Fri, 13 Jul 2007 13:24:43 -0400
Message-ID: <f158199e0707131024o5eb27b72v900f0d0613bc834b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 19:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Osr-0004V5-0O
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 19:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465AbXGMRYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 13:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbXGMRYq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 13:24:46 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:12083 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbXGMRYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 13:24:45 -0400
Received: by ik-out-1112.google.com with SMTP id b32so418304ika
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 10:24:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lJs6+56dKhiM0JMzakul4KPglwvWG4LKeSrH9o08svDrL+T5DpfMa9hHQXLcppSomq08iMpKhGqPxRx21LwWwHfhtXk/c4b5ykgTbUiSatmr5DU+yAK5wT4GRHUAS2WY3H41SK/T3atCqWFh118L3QCcbizbPKqd6wzgi5u1HKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TmkKHUYglPrjC4gUyC9CqPMNDw2XQ2QThbOUcZXm2ammftx2ehD/ThU3ijXgDVpGFBA7h18ok/JK5LAUhhBt0Oyzviwbv2rY52xhkdabcLOfAz3TloXSlUVVvTmywp8ylpRTa08T2Tr2A677C3SkcksT5r3ptRrL/NlqOL/pumE=
Received: by 10.78.149.15 with SMTP id w15mr523660hud.1184347483465;
        Fri, 13 Jul 2007 10:24:43 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Fri, 13 Jul 2007 10:24:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52402>

I am using git-svn version 1.5.3.rc1.4.gaf83 (svn 1.4.3), and I work
with an SVN repository that is layed out like this:

/trunk/proj1/
...
/trunk/proj2/
...
/trunk/testing/
...

/branches/proj1/
...
/branches/proj2/
...
/branches/testing/
/branches/testing/0000-baseline

/tags/proj1/
...
/tags/proj2/
...
/tags/testing/
/tags/testing/0000-baseline-0

I want to track the testing project, so I tried to use this git-svn
command line:

git-svn clone <base-url> -T/trunk/testing -t/tags/testing
-b/branches/testing testing

This appears to work, though I do get this warning message (edited for privacy):

W: Ignoring error from SVN, path probably does not exist: (175002): RA
layer request failed: REPORT request failed on
'/<server_path>/!svn/bc/101': REPORT of '/<server_path>!svn/bc/101':
Could not read chunk size: Secure connection truncated
(https://<myserver>)

When I run 'git branch -a' in the new testing directory I get this:

* master
  0000-baseline
  0000-baseline@1546
  1.0
  1.0@1549
  1.0@1656
  tags/0000-baseline
  tags/0000-baseline-0
  tags/0000-baseline@1663

Where is the remote branch for trunk? And, why do I have remote
entries for the defunct 1.0 branch that I deleted from svn earlier
today?  What's more, the latest changes from /trunk/testing do not
appear in my working directory, and gitk confirms that master is
pointing at the same commit as tags/0000-baseline-0.

If I just try to track the trunk like this:

git-svn clone <base-url>/trunk/testing

Then I get all of the latest changes and 'git branch -a' shows:

* master
  git-svn

So that seems OK at least.  It just doesn't work when I try to get
branches and tags.  For now, I'll just work this way.

FWIW, I suspect this behavior may be related to recent changes I made
to the Subversion repository.  I created
/branches/testing/0000-baseline today by copying an _old_ revision of
/trunk/testing.  Then I created /tags/testing/0000-baseline-0 by
copying /branches/testing/0000-baseline.  No commits have been done on
/testing/trunk since then.  Perhaps the recent (probably latest)
commit that copied an OLD version of trunk is somehow confusing
git-svn?  Once I commit a change to the subversion trunk, I'll try to
clone trunk, branches, and tags again and post an update to this
message.  Maybe it will work then.

Thanks for your help.

Bradford C. Smith
