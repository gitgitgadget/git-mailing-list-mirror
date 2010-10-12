From: David Barr <david.barr@cordelta.com>
Subject: [PATCH/RFC] Add support for subversion dump format v3
Date: Wed, 13 Oct 2010 00:50:17 +1100
Message-ID: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5fFZ-0004Px-Iz
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356Ab0JLNud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:50:33 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:59800
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932283Ab0JLNua (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 09:50:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 444FBC042;
	Wed, 13 Oct 2010 00:50:32 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6gElEC+lhDg; Wed, 13 Oct 2010 00:50:29 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id 6154EC066;
	Wed, 13 Oct 2010 00:50:29 +1100 (EST)
X-Mailer: git-send-email 1.7.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158841>

This series follows Jonathan Nieder's svn diff applier series.

Patches 1 to 4 add the required infrastructure to fast-import.
The primary feature is the addition of the cat-file command to
fast-import. This allows access to objects written to the
the current pack prior to a checkpoint and is critical to
retrieving full-texts to drive the diff applier.

Patch 5 adds the basic parsing necessary to process the v3 format.

Patch 6 adds logic around decoding prop deltas.

Patch 7 integrates svn-fe with svn-da to decode text deltas.
It was primarily authored by Jonathan but inspired by Ram and
completed by myself.
This is probably the most sprawling of the series and likely the
heaviest target of review.

 Documentation/git-fast-import.txt |   49 +++++++++
 contrib/svn-fe/svn-fe.txt         |    6 +-
 fast-import.c                     |  147 +++++++++++++++++++++++++-
 t/t9010-svn-fe.sh                 |    6 +-
 t/t9300-fast-import.sh            |  210 +++++++++++++++++++++++++++++++++++++
 test-svn-fe.c                     |    3 +-
 vcs-svn/fast_export.c             |  187 ++++++++++++++++++++++++++++++++-
 vcs-svn/fast_export.h             |   13 ++-
 vcs-svn/repo_tree.c               |   37 +++++++-
 vcs-svn/repo_tree.h               |    3 +
 vcs-svn/svndiff.c                 |   11 +--
 vcs-svn/svndiff.h                 |    3 +-
 vcs-svn/svndump.c                 |   99 ++++++++++++++++--
 13 files changed, 739 insertions(+), 35 deletions(-)
