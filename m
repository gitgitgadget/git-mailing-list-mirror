From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 0/8] git log -L, cleaned up and (hopefully) fixed
Date: Tue, 14 Dec 2010 03:03:23 +0100
Message-ID: <cover.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKFW-0008W1-Id
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759034Ab0LNCDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:03:36 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:54357 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758989Ab0LNCDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:03:35 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:28 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:31 +0100
X-Mailer: git-send-email 1.7.3.3.797.g7a32f
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163615>

This is (finally) a reroll of Bo's GSoC project.  It's still not meant
for final inclusion, see below, but I think it would be great if it
got some exposure to the masses to get feedback.

The main changes:

* It now uses -L 1,2:README option syntax.  Yay!  Hopefully this
  removes the main stumbling block.  It's also far less code.

* I squashed and rearranged the entire series to taste.  This does
  mean that the bulk of the code comes just in three commits (4, 5 and
  8).  I saw no real reason to split any finer -- the existing splits
  resulted in commits that did not work or sometimes even compile.  In
  fact I was half tempted to merge 5 and 4, too.

* -M and -C now actually work.

* As a result of the option syntax change and unrelated commits that
  since went into 'next', a few patches were superfluous and have been
  dropped.

* Various cleanup and refactorings where I saw the opportunity.

My todo/blockers for inclusion on this:

* There's got to be an obvious blunder or three considering the time.

* Any bugs found by testers :-)

* The tests are still in a weird form and lack the usual (for
  diff-based work) corner cases.

* git-blame should learn -L 1,2:README syntax so that they can be
  interchanged.  (Based on discussions at GitTogether.  Plans for the
  other way around have been dropped.)

Further directions:

* More refactorings would be nice, if possible.  There are about four
  types of ranges right now, handled in subtly different ways, leading
  to lots of code.

* Performance optimizations would also help :-)

* (This is *really* far out:) We had a thread where we discussed
  possibilities to make it walk forward as well as backward in
  history.  This will require some careful refactoring of the
  mechanisms, but would be very cool.  (-L n,m,rev:file works as a
  syntax, so we're not painting ourselves into a corner here).


Bo Yang (8):
  Refactor parse_loc
  Export three functions from diff.c
  Export rewrite_parents() for 'log -L'
  Implement line-history search (git log -L)
  log -L: support parent rewriting
  log -L: add --graph prefix before output
  log -L: add --full-line-diff option
  log -L: implement move/copy detection (-M/-C)

 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   22 +
 Documentation/line-range-format.txt |   18 +
 Makefile                            |    2 +
 builtin/blame.c                     |   99 +--
 builtin/log.c                       |   79 ++-
 diff.c                              |    6 +-
 diff.h                              |   17 +
 line.c                              | 2153 +++++++++++++++++++++++++++++++++++
 line.h                              |   72 ++
 revision.c                          |   22 +-
 revision.h                          |   23 +-
 t/t4301-log-line-single-history.sh  |  685 +++++++++++
 t/t4302-log-line-merge-history.sh   |  174 +++
 t/t4303-log-line-move-detect.sh     |  238 ++++
 t/t4304-log-line-copy-detect.sh     |  220 ++++
 t/t8003-blame.sh                    |    6 +
 17 files changed, 3730 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line.c
 create mode 100644 line.h
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh
 create mode 100755 t/t4303-log-line-move-detect.sh
 create mode 100755 t/t4304-log-line-copy-detect.sh

-- 
1.7.3.3.811.g76615
