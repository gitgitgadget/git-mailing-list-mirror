From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/2] Add submodule-support to git archive
Date: Sun, 25 Jan 2009 01:52:04 +0100
Message-ID: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 01:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQtGA-0004nS-Fi
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 01:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000AbZAYAwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbZAYAwP
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 19:52:15 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:53686 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633AbZAYAwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 19:52:14 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id n0P0q7Jt014475;
	Sun, 25 Jan 2009 01:52:07 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107030>

This is a cleaned up version of my previous patches which allows git archive
to include submodule content in the archive output.

The main difference between this series and the previous ones is that the
behaviour of `git archive --submodules` are now predictable; the content
included from submodules is defined by the gitlink entries found when
traversing the <tree-ish> specified on the command line, and the set of
submodules to include are defined by specifying either `--submodules=all` or
`--submodules=checkedout` (which is the default mode of operation, i.e. what
you get by only specifying `--submodules`).

To make the `--submodules` option more userfriendly, any submodule repository
discovered during traversal will be registered as an alternate odb (this
will typically be required to make the inter-repository traversal succeed).

Finally, the option `--submodules=group:<name>` is not yet implemented. I
wanted to get these first two patches published early since they define the
semantics of the --submodules option. Adding a 'group' selector on top is
mostly a question of pulling information out of .gitmodules and .git/config,
i.e. not very exciting (but it will be done ;-)

Lars Hjemli (2):
  tree.c: allow read_tree_recursive() to traverse gitlink entries
  archive.c: add support for --submodules[=(all|checkedout)]

 Documentation/git-archive.txt |    5 ++
 archive.c                     |   81 +++++++++++++++++++++++++-
 archive.h                     |    4 +
 builtin-ls-tree.c             |    9 +--
 cache.h                       |    1 +
 merge-recursive.c             |    2 +-
 sha1_file.c                   |   11 +++-
 t/t5001-archive-submodules.sh |  129 +++++++++++++++++++++++++++++++++++++++++
 tree.c                        |   28 +++++++++
 9 files changed, 259 insertions(+), 11 deletions(-)
 create mode 100755 t/t5001-archive-submodules.sh
