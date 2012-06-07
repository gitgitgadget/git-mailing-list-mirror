From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 0/5] git log -L, all new and shiny
Date: Thu, 7 Jun 2012 12:23:24 +0200
Message-ID: <cover.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 12:23:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScZsj-0000jN-RB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 12:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759419Ab2FGKXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 06:23:35 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57286 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2FGKXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 06:23:32 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 12:23:29 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 12:23:29 +0200
X-Mailer: git-send-email 1.7.11.rc1.243.gbf4713c
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199385>

I too thought it would never happen -- but then again this is still
not ready, I'm just trying to give it some exposure.

My mail archive says we were at v6 last time, but this is a rewrite
rather than a reroll.  In efforts to make the code understandable, I
tried to compose it of little functions that do little operations on
little data structures, to at least some success.

If you just want to dive in, patch it into your git or pull from

  git://github.com/trast/git.git line-log-WIP

and then try something like

  git log -L '/^int main/,/^}/':git.c
  git log --graph -L '/^static void sha1_object/,/^}/':builtin/index-pack.c 681b07de11

The TODO list:

* I dropped the tests for now, so we need new ones.

* A good split of the main patch would be nice :-)

* Much of the code leaks memory like a sieve because I was lazy.  It's
  workable on the git repository, but eats a few hundred MB for simple
  tasks even there.

* Missing features:
  - detect/filter merges at the hunk level
    (and ideally show a combined diff for the nontrivial ones)
  - -M and -C support
  - ...?

There's also a longer-term wishlist hinted at in the commit message of
the main patch: the diff machinery currently makes no provisions for
chaining its various bells and whistles.  As the most obvious example,
it is not possible to run a word diff over the result of 'log -L'.
Changes in this direction would probably also make the implementation
of 'log -L' fit nicely in there somewhere.


Bo Yang (3):
  Refactor parse_loc
  Export three functions from diff.c
  Export rewrite_parents() for 'log -L'

Thomas Rast (2):
  blame: introduce $ as "end of file" in -L syntax
  Implement line-history search (git log -L)

 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   22 +
 Documentation/line-range-format.txt |   24 +
 Makefile                            |    2 +
 builtin/blame.c                     |   99 +--
 builtin/log.c                       |   53 ++
 diff.c                              |    6 +-
 diff.h                              |   17 +
 line.c                              | 1245 +++++++++++++++++++++++++++++++++++
 line.h                              |   79 +++
 log-tree.c                          |    3 +
 revision.c                          |   22 +-
 revision.h                          |   16 +-
 t/t8003-blame-corner-cases.sh       |    6 +
 14 files changed, 1491 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line.c
 create mode 100644 line.h

-- 
1.7.11.rc1.243.gbf4713c
