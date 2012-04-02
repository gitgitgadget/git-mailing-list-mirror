From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH 0/2] git-svn: fixes for intermittent SIGPIPE
Date: Mon, 2 Apr 2012 20:13:36 +0400 (MSK)
Message-ID: <cover.1333381684.git.rkagan@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 18:13:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEjt5-0007Ud-Fg
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab2DBQNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:13:41 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36535 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403Ab2DBQNl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:13:41 -0400
Received: from localhost ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id q32GDa0Q004777;
	Mon, 2 Apr 2012 20:13:37 +0400 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194523>

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

Roman Kagan (2):
  git-svn: use POSIX::sigprocmask to block signals
  git-svn: ignore SIGPIPE

 git-svn.perl |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.7.7.6
