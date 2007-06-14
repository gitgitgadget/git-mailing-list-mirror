From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH guilt] make guilt use standard POSIX shell
Date: Thu, 14 Jun 2007 14:50:55 +0200
Message-ID: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyon5-0003EC-IY
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbXFNMvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbXFNMvF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:05 -0400
Received: from pan.madism.org ([88.191.52.104]:60885 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbXFNMvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:04 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3E66FDA65;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 584569294B; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50190>

This patch series makes guilt be able to work with a standard posix shell.

This has been tested with bash, zsh, dash and posh acting as /bin/sh.

This uses awk and sed a bit more than before, but POSIX awk and sed should be
enough. Though GNU find and GNU /bin/echo from the coreutils needs to be
there.

Here is the shortlog:

	Pierre Habouzit (7):
		  Regression test suite needs bash, that's OK.
		  guilt(1): Obvious bashisms fixed.
		  guilt(1): simplifications...
		  guilt(1): reimplement push_patch, using a subshell to avoid locals.
		  Easy commands, without bashisms.
		  guilt-status(1): Remove bashisms.
		  Remove last bashisms from remaining commands.

and the diffstat:

	 guilt                       |  448 +++++++++++++++++++------------------------
	 guilt-add                   |    7 +-
	 guilt-applied               |    4 +-
	 guilt-delete                |    4 +-
	 guilt-export                |    6 +-
	 guilt-files                 |    6 +-
	 guilt-fold                  |    4 +-
	 guilt-fork                  |    6 +-
	 guilt-graph                 |   13 +-
	 guilt-header                |    4 +-
	 guilt-help                  |    6 +-
	 guilt-import                |    6 +-
	 guilt-import-commit         |    6 +-
	 guilt-init                  |    4 +-
	 guilt-new                   |   15 +-
	 guilt-next                  |    6 +-
	 guilt-patchbomb             |   10 +-
	 guilt-pop                   |    4 +-
	 guilt-prev                  |    4 +-
	 guilt-push                  |   16 +-
	 guilt-rebase                |    4 +-
	 guilt-refresh               |    4 +-
	 guilt-rm                    |    4 +-
	 guilt-series                |    6 +-
	 guilt-status                |   58 +++---
	 guilt-top                   |    4 +-
	 guilt-unapplied             |   12 +-
	 regression/010-init.sh      |    1 +
	 regression/011-no-repo.sh   |    1 +
	 regression/020-push.sh      |    1 +
	 regression/021-pop.sh       |    1 +
	 regression/022-applied.sh   |    1 +
	 regression/023-top.sh       |    1 +
	 regression/024-unapplied.sh |    1 +
	 regression/025-new.sh       |    1 +
	 regression/026-delete.sh    |    1 +
	 regression/027-refresh.sh   |    1 +
	 regression/050-series.sh    |    1 +
	 regression/060-files.sh     |    1 +
	 regression/Makefile         |    2 +-
	 uninstall                   |    7 +-
	 41 files changed, 317 insertions(+), 375 deletions(-)
