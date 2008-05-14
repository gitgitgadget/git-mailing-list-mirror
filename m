From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] sane rebase/stash support with submodules
Date: Wed, 14 May 2008 18:03:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141802480.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 14 19:04:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKOb-0007hT-O2
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbYENRDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbYENRDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:03:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:40349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753072AbYENRDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:03:15 -0400
Received: (qmail invoked by alias); 14 May 2008 17:03:13 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp010) with SMTP; 14 May 2008 19:03:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18a7DxlJPQaLI5P1wHLv1/34CHTUYPDQfUn9+jx0u
	lbqHWuHIoQ0WWP
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82111>


Submodules are special in that they cannot be blindly updated with
a checkout.  Indeed, submodules do not even have to be checked out (and
in that case, must not be updated).  It is the user's responsibility to
care about the working tree state of submodules.

Therefore, it does not make sense in stash/rebase to test for dirty
submodules: they would not be updated anyway.

This patch series does exactly that: working tree states of submodules
are ignored with stash and rebase, by calling update-index and
the diff programs with the freshly introduced --ignore-submodules option.

Johannes Schindelin (3):
  diff options: Introduce --ignore-submodules
  Teach update-index about --ignore-submodules
  Ignore dirty submodule states during rebase and stash

 Documentation/diff-options.txt     |    3 +
 Documentation/git-update-index.txt |    5 ++
 builtin-update-index.c             |    4 ++
 cache.h                            |    1 +
 diff.c                             |    9 ++++
 diff.h                             |    1 +
 git-rebase--interactive.sh         |   11 ++--
 git-rebase.sh                      |    8 ++--
 git-stash.sh                       |    6 +-
 read-cache.c                       |    4 ++
 t/t7402-submodule-rebase.sh        |   92 ++++++++++++++++++++++++++++++++++++
 11 files changed, 132 insertions(+), 12 deletions(-)
 create mode 100755 t/t7402-submodule-rebase.sh
