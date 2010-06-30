From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 0/4] implement automatic submodule merge strategy when possible
Date: Wed, 30 Jun 2010 21:23:47 +0200
Message-ID: <cover.1277923843.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 30 21:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU2tA-00078n-CW
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 21:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab0F3TX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 15:23:56 -0400
Received: from darksea.de ([83.133.111.250]:55005 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754995Ab0F3TXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 15:23:54 -0400
Received: (qmail 18714 invoked from network); 30 Jun 2010 21:23:52 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 30 Jun 2010 21:23:52 +0200
X-Mailer: git-send-email 1.7.1.528.gb3958.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149985>

This series implements a semi-automatic submodule merge as was discussed
in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/148942

In short:

Suppose we merge two submodule hashes A and B. If either A->B or B->A is
a fast-forward the automatic result is the one containing both.

If there is not direct relation between A and B but we find a merge on
any ref that contains both we suggest this as a possible resolution to
the user. If there are more merges we output a list of them.

The suggestion tells the user to use update-index because
checkout_submodule() on which Jens is working is not finished yet. This
is a temporary solution and we can automatically checkout a submodule
later when this is implemented.

Note: As I am not that familiar with the git codebase yet another pair
of eyes would be really appreciated.

The newest version of this series can always be found on

git://github.com/hvoigt/git.git

Branch: submodule_merge_v2

Heiko Voigt (4):
  add missing && to submodule-merge testcase
  teach ref iteration module about submodules
  extent setup_revisions() so it works with submodules
  implement automatic fast forward merge for submodules

 cache.h                    |    3 +
 merge-recursive.c          |    9 ++-
 path.c                     |   38 +++++++++++
 refs.c                     |  130 +++++++++++++++++++++++++++++--------
 refs.h                     |    8 ++
 revision.c                 |   32 +++++----
 revision.h                 |    1 +
 submodule.c                |  154 ++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                |    2 +
 t/t7405-submodule-merge.sh |  124 +++++++++++++++++++++++++++++++++--
 10 files changed, 450 insertions(+), 51 deletions(-)
