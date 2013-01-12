From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/8] Initial support for Python 3
Date: Sat, 12 Jan 2013 19:23:38 +0000
Message-ID: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6h7-0000wo-1F
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab3ALTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:24:12 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:43714 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab3ALTYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:24:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 54292606565;
	Sat, 12 Jan 2013 19:24:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=unavailable
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyarmHl4OrLE; Sat, 12 Jan 2013 19:24:10 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 08BF96064CE;
	Sat, 12 Jan 2013 19:24:10 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id F3614161E556;
	Sat, 12 Jan 2013 19:24:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NDfnSje3kQn; Sat, 12 Jan 2013 19:24:09 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CD593161E1F3;
	Sat, 12 Jan 2013 19:24:01 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213301>

I started having a look to see how much work would be needed to make Git
work with Python 3 and the answer is mostly not much.  The exception is
git-p4.py which is hit hard by the distinction between byte strings and
unicode strings, particularly because the Python output mode of p4
targets Python 2.

I don't know if it's worthwhile to actually apply these but here they
are in case anyone's interested.

Having said that, the changes are minimal and involve either wrapping
parentheses around arguments to print or being a bit more explicit about
how we expect byte strings to be decoded to unicode.

With these patches all tests pass with python3 except t98* (git-p4), but
there are a couple of topics in-flight which will affect that
(fc/remote-testgit-feature-done and er/replace-cvsimport).

John Keeping (8):
  git_remote_helpers: Allow building with Python 3
  git_remote_helpers: fix input when running under Python 3
  git_remote_helpers: Force rebuild if python version changes
  git_remote_helpers: Use 2to3 if building with Python 3
  svn-fe: allow svnrdump_sim.py to run with Python 3
  git-remote-testpy: hash bytes explicitly
  git-remote-testpy: don't do unbuffered text I/O
  git-remote-testpy: call print as a function

 contrib/svn-fe/svnrdump_sim.py     |  4 ++--
 git-remote-testpy.py               | 40 +++++++++++++++++++-------------------
 git_remote_helpers/.gitignore      |  1 +
 git_remote_helpers/Makefile        | 10 ++++++++--
 git_remote_helpers/git/importer.py |  2 +-
 git_remote_helpers/setup.py        | 10 ++++++++++
 6 files changed, 42 insertions(+), 25 deletions(-)

-- 
1.8.1
