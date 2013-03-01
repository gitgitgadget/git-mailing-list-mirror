From: <git-users@io7m.com>
Subject: Debugging a bizarre problem: What can influence 'git fetch'?
Date: Fri, 1 Mar 2013 14:39:40 +0000
Message-ID: <20130301143940.7e31f0c2@copperhead.int.arc7.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 01 17:23:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBSk1-0004iS-Gi
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 17:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab3CAQW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 11:22:59 -0500
Received: from bs3-dallas.accountservergroup.com ([50.22.11.58]:36232 "EHLO
	bs3-dallas.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750778Ab3CAQW7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Mar 2013 11:22:59 -0500
X-Greylist: delayed 6195 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Mar 2013 11:22:59 EST
Received: from dsl78-143-199-137.in-addr.fast.co.uk ([78.143.199.137]:54417 helo=copperhead.int.arc7.info)
	by bs3-dallas.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git-users@io7m.com>)
	id 1UBR7e-000DFu-Ok
	for git@vger.kernel.org; Fri, 01 Mar 2013 08:39:43 -0600
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bs3-dallas.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - io7m.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217281>

Hello.

I'm working on a small project that talks to external git and fossil
repositories. I've run into a bizarre "this cannot happen" problem and
am completely mystified as to what's causing it.

Essentially, the problem is that a particular git command, run as part
of the unit tests for the project, fails reliably when executed from
the project's build system but works correctly when run directly from the
command line or when the same unit tests are executed from the IDE).

The unit test executes the following commands (where e5KbuUvD4Ps is a
random string to ensure that each invocation of the test starts from a
blank canvas):

/usr/bin/git clone --mirror --bare http://git.io7m.com/io7m-jaux.git /tmp/test-e5KbuUvD4Ps/io7m-jaux.git
/usr/bin/git --git-dir=/tmp/test-e5KbuUvD4Ps/io7m-jaux.git fetch -v

The 'git fetch' command raises the following error:

error: Unable to find f981a2bb02c38f20c1e3a5a0fc37c2b4ef5b92ea under http://git.io7m.com/io7m-jaux.git
Cannot obtain needed object f981a2bb02c38f20c1e3a5a0fc37c2b4ef5b92ea
error: Fetch failed.

The f981a2bb02c38f20c1e3a5a0fc37c2b4ef5b92ea is the HEAD commit of the master
branch in the above repos.

I can execute the fetch command from the command line (on the same clones created
by any past invocations of the unit test) and it works correctly. I can run the unit
test from the IDE and it works correctly.

In desperation, I've replaced the git binary with a shell script that logs
the current environment and command line arguments to a file before executing
the real git binary and in all cases, they're completely identical.

I'm out of ideas. What bizarre invisible environment pollution could possibly
be influencing 'git fetch' in this manner? Is there some way to get 'git fetch'
to be more verbose?

M
