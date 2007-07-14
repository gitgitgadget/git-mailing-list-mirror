From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Fwd: git-svn: trunk missing, checks out tag instead
Date: Sat, 14 Jul 2007 15:04:36 -0400
Message-ID: <f158199e0707141204n6fd9f79dg26453c5581a97c4d@mail.gmail.com>
References: <f158199e0707131024o5eb27b72v900f0d0613bc834b@mail.gmail.com>
	 <f158199e0707131205w358676e5j88f8e4c63b1be1f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 21:04:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9mv3-0006lo-U6
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 21:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760339AbXGNTEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 15:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760107AbXGNTEj
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 15:04:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:12377 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759375AbXGNTEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 15:04:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so756259ugf
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:04:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsUoVpdvAWPm5grJncLQL4tjKeV1lbXq2op48xPR12bxjZRYPPoWnyd+s68Tfuwtom3iThLkXn+d08+JObc3+9ipxOxNa+qUQn0MVj1KSiVukr5eiWH1Pv7e9tYPkytZonzmeogjiqzJceUeV/AJ8sF6++v5L25fpV6Rv6JBbN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uk8utCqw8yKUq6keIjdnjS0sJsHKcNCd2mTMvi9Uuaa/H/0bQ2TpobDEg0g8v/3zjeaRfe2Tmph8c7kakDWMax14gS29wze/KLYwFp0ADDMohS10G8Zd5TcggJ/jxjJehs8QbPE2z0ITdmVpyZAQNSW2WkjgeZKbJAHLAFf1Ehk=
Received: by 10.78.204.7 with SMTP id b7mr769742hug.1184439876080;
        Sat, 14 Jul 2007 12:04:36 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Sat, 14 Jul 2007 12:04:36 -0700 (PDT)
In-Reply-To: <f158199e0707131205w358676e5j88f8e4c63b1be1f5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52498>

TWIMC,
(Cc: to git-svn author, Eric Wong)

I tried it again today, and it worked!  Looking at the command more
closely and playing with it a bit I discovered I had written the
command line slightly differently.

This works:

git-svn clone https://my.server.net/repos/path/ -Ttrunk/testing -ttags/testing \
                     -bbranches/testing testing

This doesn't:

git-svn clone https://my.server.net/repos/path -T/trunk/testing
-t/tags/testing \
                     -b/branches/testing testing

So, clearly this command is extremely sensitive to where the slashes go.

With the "good" version of the command I get a trunk branch.  With the
"bad" version I don't.  Either way, I get the defunct 1.0 branch and
the error message mentioned in the original email below.

HTH,

Bradford C, Smith


---------- Forwarded message ----------
From: Bradford Smith <bradford.carl.smith@gmail.com>
Date: Jul 13, 2007 3:05 PM
Subject: Fwd: git-svn: trunk missing, checks out tag instead
To: git@vger.kernel.org

UPDATE:

I get the same behavior even after checking in a new change on the trunk.

Oh, well...

Bradford

---------- Forwarded message ----------
From: Bradford Smith <bradford.carl.smith@gmail.com>
Date: Jul 13, 2007 1:24 PM
Subject: git-svn: trunk missing, checks out tag instead
To: git@vger.kernel.org


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
