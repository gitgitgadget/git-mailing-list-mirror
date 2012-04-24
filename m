From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH 0/3] git-svn: fixes for intermittent SIGPIPE
Date: Tue, 24 Apr 2012 10:53:16 +0400
Message-ID: <cover.1335250396.git.rkagan@mail.ru>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 08:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMZir-0008VA-Lz
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 08:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab2DXG7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 02:59:33 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:7119 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154Ab2DXG7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 02:59:32 -0400
Received: from localhost ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id q3O6x7Kn016822;
	Tue, 24 Apr 2012 10:59:08 +0400 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196190>

In my work environment subversion is still being used as the main
revision control system.  Therefore many people who prefer to work with
git have to resort to git-svn.

However, in many configurations it used to suffer from the notorious
"git-svn died of signal 13" problem (see e.g.
http://thread.gmane.org/gmane.comp.version-control.git/134936 and the
links therein).

I believe to have tracked down the issue to the connection being closed
by the server when http keep-alive is in use, and the client dying on
SIGPIPE because its handler is left at SIG_DFL when a new request is
being made.

The patches have been tested on

- Linux Fedora 16 x86_64, git 1.7.7.6, perl v5.14.2, svn 1.6.17
- Windows 7 x64 + Cygwin, git 1.7.9, perl v5.10.1, svn 1.7.4,
- Windows 7 x64 + MsysGit, git 1.7.9.msysgit.0, perl v5.8.8, svn 1.4.6

This is the third version of the series; compared to the previous submission
the log message of the first patch was reworded to make it more palatable.

Roman Kagan (3):
  git-svn: use POSIX::sigprocmask to block signals
  git-svn: ignore SIGPIPE
  git-svn: drop redundant blocking of SIGPIPE

 git-svn.perl |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.7.7.6
