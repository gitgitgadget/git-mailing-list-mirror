From: Jeff Epler <jepler@unpythonic.net>
Subject: A note on modern git plus ancient meld ("wrong number of
 arguments")
Date: Thu, 9 Feb 2012 13:17:43 -0600
Message-ID: <20120209191742.GA20703@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 20:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZcu-0004nt-MC
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349Ab2BITZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:25:48 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:53216 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758272Ab2BITZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:25:48 -0500
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Feb 2012 14:25:47 EST
Received: by unpythonic.net (Postfix, from userid 1000)
	id D5C73114972; Thu,  9 Feb 2012 13:17:43 -0600 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190309>

I note this just in case it helps someone else track down a similar
problem, not because I think any change needs to be made to git, as a
version of meld new enough to not be affected by this problem is 5 years
old.

At $DAYJOB, I recently encountered a problem after upgrading from (don't
laugh) git 1.7.1 to 1.7.8.3: one developer stated that meld failed to
run, instead displaying the error 'Wrong number of arguments (Got 5)'. 

We determined that this user was running a very old version of meld
(1.1.1) from his home directory, as opposed to the also very old system
version of meld (1.1.5).  It turns out that the check added in 
    f61bd9c mergetools/meld: Use '--output' when available
fails on meld 1.1.1, leading git to incorrectly believe the --output
flag is supporrted:
    $ meld-1.1.1 --output /dev/null --help >/dev/null 2>&1; echo $?
    0   # i.e., detected as supported
The test as written gives the correct ("not supported") result with meld
1.1.5:
    $ meld-1.1.5 --output /dev/null --help >/dev/null 2>&1; echo $?
    2   # i.e., detected as supported

so if you encounter the message 'Wrong number of arguments (Got 5)' from
meld, then check whether you have an ancient version of meld.  If for
some reason you can't upgrade to at least 1.1.5, maybe you'd find the
following configuration flags useful:
    [merge]
        tool = ancientmeld
    [mergetool "ancientmeld"]
        cmd = meld-1.1.1 \"$LOCAL\" \"$MERGED\" \"$REMOTE\"

Jeff
