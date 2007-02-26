From: Paul Collins <paul@briny.ondioline.org>
Subject: git-remote and remotes with '.' in their names
Date: Mon, 26 Feb 2007 20:36:26 +1300
Message-ID: <87k5y5tlol.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 09:10:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLawK-0005No-QW
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 09:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXBZIKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 03:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933791AbXBZIKR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 03:10:17 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:3627 "EHLO
	jenny.ondioline.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbXBZIKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 03:10:15 -0500
X-Greylist: delayed 1682 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Feb 2007 03:10:15 EST
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id 79AC68CD98; Mon, 26 Feb 2007 20:41:32 +1300 (NZDT)
Received: by briny.internal.ondioline.org (Postfix, from userid 1000)
	id 1FD75C655; Mon, 26 Feb 2007 20:36:26 +1300 (NZDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40613>

I just switched my remotes over to the git-remote way (which is very
nice!) and was looking for a way to list all of the known remotes.
git-remote with no arguments almost does it, but I get the following:

  [briny(linux-2.6)] git --version
  git version 1.5.0.1
  [briny(linux-2.6)] cat .git/config
  [core]
          repositoryformatversion = 0
          filemode = true

  [user]
          email = "paul@briny.ondioline.org"
  [remote "origin"]
          url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
          fetch = +refs/heads/*:refs/remotes/origin/*
  [remote "wireless-dev"]
          url = git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
          fetch = +refs/heads/*:refs/remotes/wireless-dev/*
  [remote "stable-2.6.19"]
          url = git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
          fetch = +refs/heads/*:refs/remotes/stable-2.6.19/*
  [remote "stable-2.6.20"]
          url = git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git
          fetch = +refs/heads/*:refs/remotes/stable-2.6.20/*
  [remote "wireless-2.6"]
          url = git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
          fetch = +refs/heads/*:refs/remotes/wireless-2.6/*
  [briny(linux-2.6)] git-remote
  origin
  stable-2
  wireless-2
  wireless-dev

With this patch I get the correct list, but then it will break if
there are ever config keys like "remote.$remote_name.foo.bar".


--- git-remote~	2007-02-26 01:15:33.000000000 +1300
+++ git-remote	2007-02-26 20:31:20.000000000 +1300
@@ -68,7 +68,7 @@
 		$git->command(qw(config --get-regexp), '^remote\.');
 	};
 	for (@remotes) {
-		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
+		if (/^remote\.(.*)\.(\S*)\s+(.*)$/) {
 			add_remote_config(\%seen, $1, $2, $3);
 		}
 	}


-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
