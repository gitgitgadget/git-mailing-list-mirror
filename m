From: marcnarc@xiplink.com
Subject: [PATCH v2 0/6] Default remote
Date: Wed, 11 Jul 2012 11:33:55 -0400
Message-ID: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soyvu-0005vj-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 17:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146Ab2GKPeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 11:34:24 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:18470 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755898Ab2GKPeV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 11:34:21 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q6BFY4UZ029776;
	Wed, 11 Jul 2012 11:34:05 -0400
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201306>

Incorporated feedback on the first version of this series[1], and also added
documentation updates.

Note that the documentation changes include 4 minor grammatical fixes (verb
tenses, added a "the" in a couple fo places).  

I also added Phil's "git push" scenario to patch #2's message, rather than
putting it in the documentation as I'd planned.  Explaining the behavior
change in the commit message felt more natural.

The specific differences from v1 are:

Patch #1 (Rename remote.c's default_remote_name static variables.):
  * Expanded the commit message to explain the choice of
    "effective_remote_name".

Patch #2 (Teach remote.c about the remote.default configuration setting.):
  * Added documentation updates.
  * Commit message now describes change in default "git push" behavior.
  * Moved new remote_get_default_name() and remote_count() functions
    to patch #3.

Patch #3 (Teach "git remote" about remote.default.):
  * (Was patch #4 in v1 of this series.)
  * Documented changes to "git remote".
  * The remote_get_default_name() and remote_count() functions are
    now added to remote.[ch] here, with proper declarations.
  * Added a test to ensure that renaming the "origin" remote still
    properly sets remote.default in repos created with an older
    version of git.

Patch #4 (Teach clone to set remote.default.):
  * (Was patch #3 in v1 of this series.)
  * Commit message now justifies changes to "git clone".

Patches 5 & 6 are unchanged.

		M.

[1] http://thread.gmane.org/gmane.comp.version-control.git/201065

Marc Branchaud (6):
      Rename remote.c's default_remote_name static variables.
      Teach remote.c about the remote.default configuration setting.
      Teach "git remote" about remote.default.
      Teach clone to set remote.default.
      Test that plain "git fetch" uses remote.default when on a detached HEAD.
      Teach get_default_remote to respect remote.default.

 Documentation/config.txt           |  8 ++++
 Documentation/git-pull.txt         |  6 ++-
 Documentation/git-push.txt         |  8 +++-
 Documentation/git-remote.txt       | 32 ++++++++++++++--
 Documentation/pull-fetch-param.txt |  6 +++
 builtin/clone.c                    |  2 +
 builtin/remote.c                   | 29 +++++++++++++++
 git-parse-remote.sh                |  5 +--
 remote.c                           | 34 +++++++++++++----
 remote.h                           |  2 +
 t/t5505-remote.sh                  | 76 ++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh                   | 17 +++++++++
 t/t5512-ls-remote.sh               |  8 +++-
 t/t5528-push-default.sh            |  4 +-
 t/t5601-clone.sh                   | 10 +++++
 t/t5702-clone-options.sh           |  7 +++-
 t/t7400-submodule-basic.sh         | 21 +++++++++++
 17 files changed, 253 insertions(+), 22 deletions(-)
