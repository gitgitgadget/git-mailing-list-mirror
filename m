From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Fri, 11 Jun 2010 14:23:30 +0200
Message-ID: <cover.1276059473.git.hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 11 14:30:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON3NS-0005BH-RC
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 14:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760210Ab0FKMaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 08:30:19 -0400
Received: from darksea.de ([83.133.111.250]:56926 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760008Ab0FKMaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 08:30:16 -0400
Received: (qmail 1393 invoked from network); 11 Jun 2010 14:23:33 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Jun 2010 14:23:33 +0200
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148942>

The following patch series is a work in progress. The idea is whenever
you need to merge two SHA1's of a submodule we search for a ref in the
submodule which already contains both. If one such ref exists the
resulting SHA1 is the one pointed at by that ref.

The implementation currently searches through all refs and if one (and
only one) ref exists which contains both sides it merges. In all other
cases it fails.

Future Plans:

  * Only search stable branches. E.g. by default only master and
    */master. The stable branch list will be configurable.

  * Use read_gitfile_gently for submodule .git handling

  * Use strbuf in git_path_submodule

Further comments or ideas?

The series can also be found on github:

http://github.com/hvoigt/git/tree/hv/submodule_merge

cheers Heiko

Heiko Voigt (3):
  extend ref iteration for submodules
  add missing && to submodule-merge testcase
  implement automatic fast forward merge for submodules

 cache.h                    |    3 +
 merge-recursive.c          |    9 ++-
 path.c                     |   21 ++++++++
 refs.c                     |   89 +++++++++++++++++++++++---------
 refs.h                     |    2 +
 submodule.c                |  121 ++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                |    2 +
 t/t7405-submodule-merge.sh |  117 ++++++++++++++++++++++++++++++++++++++++---
 8 files changed, 328 insertions(+), 36 deletions(-)
