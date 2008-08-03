From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/5] Fix 'url.*.insteadOf' for submodule URLs
Date: Mon, 04 Aug 2008 00:57:00 +0200
Message-ID: <200808040057.00221.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 01:00:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmYV-0000ea-J4
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662AbYHCW5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 18:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756128AbYHCW5v
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 18:57:51 -0400
Received: from smtp.getmail.no ([84.208.20.33]:44311 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbYHCW5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 18:57:51 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5100L21RS3VR00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 00:57:39 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100HPGRR0Z340@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 00:57:00 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100CGPRR0UYWM@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 00:57:00 +0200 (CEST)
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91284>

As suggested in a thread some time ago, one could redefine the URL used to 
fetch submodules by adding a 'url.*.insteadOf' rule prior to the first 
invocation of 'git submodule update'.

However, this does not work with current Git, because the super-repo config 
(which is home to the 'url.*.insteadOf' rule) is not consulted by the 'git 
clone' that is invoked by 'git submodule update'.

These patches fix this issue by making 'git submodule' explicitly rewrite 
the submodule URL according to the super-repo config, prior to calling 'git 
clone'.

In order for the 'git submodule' shell script to properly rewrite URLs, it 
must gain access to the URL rewriting functionality in remote.c. To expose 
the URL rewriting functionality to 'git submodule' (and others, if needed), 
a new option ('rewrite-url') has been added to 'git config'.

The patch series is based on master. Whether or not this should be 
considered for v1.6.0 is to be decided by Junio. (My personal opinion is 
that although we're late in the release cycle, the patches are fairly 
straightforward, and should not pose a great risk of regressions.)

Johan Herland (5):
  Add testcase for 'git submodule' with url.*.insteadOf set in the
    super-repo
  Teach 'git config' to rewrite URLs according to current
    url.*.insteadOf rules
  Add selftest for new option '--rewrite-url' to 'git config'
  Add documentation on the new --rewrite-url option to 'git config'
  Teach 'git submodule' to rewrite submodule URLs according to
    super-repo's rules

 Documentation/git-config.txt |   10 ++++++++++
 builtin-config.c             |   23 ++++++++++++++++++++++-
 git-submodule.sh             |    6 ++++++
 t/t1300-repo-config.sh       |   14 ++++++++++++++
 t/t7400-submodule-basic.sh   |   11 +++++++++++
 5 files changed, 63 insertions(+), 1 deletions(-)


Have fun!

...Johan
