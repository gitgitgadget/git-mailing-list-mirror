From: mriou <matthieu.riou@gmail.com>
Subject: git-svn: file not found in commit
Date: Thu, 11 Sep 2008 19:48:06 -0700 (PDT)
Message-ID: <19448485.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 04:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdyij-0000OW-VN
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 04:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbYILCsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 22:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYILCsJ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 22:48:09 -0400
Received: from kuber.nabble.com ([216.139.236.158]:50949 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbYILCsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 22:48:08 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Kdyhb-0007do-0U
	for git@vger.kernel.org; Thu, 11 Sep 2008 19:48:07 -0700
X-Nabble-From: matthieu.riou@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95680>


Hi,

I'm trying to import with git-svn an Apache repository located at:

http://svn.eu.apache.org/repos/asf/ode

Doing so, at some point git-svn seems to get lost when identifying a parent:

r563284 = 1e889810d5344e1222077f4026b028a922826d45 (trunk)
Found possible branch point:
https://svn.eu.apache.org/repos/asf/ode/trunk/tasks =>
https://svn.eu.apache.org/repos/asf/ode/branches/bart, 563283
Initializing parent: bart@563283
W: Ignoring error from SVN, path probably does not exist: (175007): HTTP
Path Not Found: '/repos/asf/!svn/bc/10001/ode/trunk/tasks' path not found
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories
branch_from: /incubator/ode => /incubator/ode/trunk/tasks
Found possible branch point:
https://svn.eu.apache.org/repos/asf/incubator/ode/trunk/tasks =>
https://svn.eu.apache.org/repos/asf/ode/trunk/tasks, 560672
Initializing parent: bart@560672
Found branch parent: (bart@563283) 69e8e3436d6572333b81a2c12cb6d3db8d4780a7
Following parent with do_switch
Successfully followed parent
r560673 = 7bf3908aca6fccf484f7dd806e57292400600f70 (bart@563283)
        D       hibernate.rake
        D       cobertura.rake
        D       jdepend.rake
jbi.rake was not found in commit 7bf3908aca6fccf484f7dd806e57292400600f70
(r560673)

The error message is correct, that revision didn't contain this file, it's
been added much later. So the parent identification seems to be getting it
wrong. And I have to agree the logs are confusing around that revision:

$ svn log -r 563283:563286 --verbose https://svn.apache.org/repos/asf/
------------------------------------------------------------------------
r563283 | mszefler | 2007-08-07 00:19:24 +0300 (Tue, 07 Aug 2007) | 2 lines
Changed paths:
  D /ode/branches/bart

Remove.
------------------------------------------------------------------------
r563284 | mszefler | 2007-08-07 00:19:32 +0300 (Tue, 07 Aug 2007) | 2 lines
Changed paths:
  A /ode/branches/bart (from /ode/trunk/tasks:563283)
  D /ode/trunk/tasks

Moved.
------------------------------------------------------------------------
r563285 | mszefler | 2007-08-07 00:20:11 +0300 (Tue, 07 Aug 2007) | 2 lines
Changed paths:
  A /ode/trunk/tasks (from /ode/branches/bart:563284)

copyied back.
------------------------------------------------------------------------
r563286 | mszefler | 2007-08-07 00:21:57 +0300 (Tue, 07 Aug 2007) | 2 lines
Changed paths:
  A /ode/branches/bart/tasks (from /ode/trunk/tasks:563285)

copied.
------------------------------------------------------------------------

So my questions are the following:
 - is there a way I can help git svn finding the correct ancestor?
 - is there a way I can ask git svn to ignore ancestors only when it fails?

If the answer is no in both cases, maybe I could add a switch to ignore
those errors?

Thanks,
Matthieu
-- 
View this message in context: http://www.nabble.com/git-svn%3A-file-not-found-in-commit-tp19448485p19448485.html
Sent from the git mailing list archive at Nabble.com.
