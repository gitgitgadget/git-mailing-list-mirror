From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 00/12] Reroll of the remote-vcs-helper series
Date: Wed, 18 Nov 2009 02:42:20 +0100
Message-ID: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:43:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZa3-0000gW-B6
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbZKRBnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbZKRBnW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:17370 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393AbZKRBnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:21 -0500
Received: by ey-out-2122.google.com with SMTP id 25so5797eya.19
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=GfNuCuuS8n+Q2RV18flse8W8L00YOxflPpS3eimIcxs=;
        b=CtOdEeHRZJ/lw44sHcqgep33w2Oma1lrRp1n9cQ1vaHBGYZdQGt1Q2MddubG4sa6DU
         cWlBs6VTveCrUUOPda3iZt0tlhRrn8bbo66fyQa9JNf32lOpmaxHLAjdaOsWIHakTmK5
         uY6MKo3bCW5hGrOlQ3Uo1YOLzcmUDPQnhrwB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=DUOjJACCanb759n3+aFIzDBhyv2e3y1aEGj9Oa0wk+nnSSTrL3o9U3N0nEoZPUtiJp
         aPJBTNrxe9UYCzZ5Op0/s+2ZAgZURohPdMtIZ/dMIXgPTj6NtNXdYJ+bloiwaqXK2V/h
         47Ymf1CYJ5elToc19LkCM2evb1umleBkOs3gw=
Received: by 10.216.90.210 with SMTP id e60mr533838wef.120.1258508606535;
        Tue, 17 Nov 2009 17:43:26 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:25 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133123>

I'd say these are all good for next (assuming Daniel doesn't spot
any mistakes). Daniel, valgrind reports some more memory leaks, but
are not introduced by this series. I have fixed the few obvious ones
that I pointed out in my earlier mail though.

I ejected the 'gitdir' patch since it'll have to wait till after the
sr/gfi-options reroll.

If I can find some time I'll send a version of 'git-remote-hg' that
has read-only support for local hg repositories later on.

Daniel Barkalow (8):
      Fix memory leak in helper method for disconnect
      Allow programs to not depend on remotes having urls
      Use a function to determine whether a remote is valid
      Allow fetch to modify refs
      Add a config option for remotes to specify a foreign vcs
      Add support for "import" helper command
      Allow helper to map private ref names into normal names
      Allow helpers to report in "list" command that the ref is unchanged

Johan Herland (1):
      Basic build infrastructure for Python scripts

Johannes Schindelin (1):
      Allow specifying the remote helper in the url

Sverre Rabbelier (2):
      Fix various memory leaks in transport-helper.c
      Add Python support library for remote helpers

 Documentation/config.txt             |    4 +
 Documentation/git-remote-helpers.txt |   28 ++-
 Makefile                             |   51 +++
 builtin-clone.c                      |    3 +-
 builtin-fetch.c                      |    7 +-
 builtin-ls-remote.c                  |    2 +-
 builtin-push.c                       |   68 ++--
 configure.ac                         |    3 +
 git_remote_helpers/.gitignore        |    2 +
 git_remote_helpers/Makefile          |   35 ++
 git_remote_helpers/__init__.py       |   16 +
 git_remote_helpers/git/git.py        |  678 ++++++++++++++++++++++++++++++++++
 git_remote_helpers/setup.py          |   17 +
 git_remote_helpers/util.py           |  194 ++++++++++
 remote.c                             |   42 ++-
 remote.h                             |    7 +
 t/test-lib.sh                        |   10 +
 transport-helper.c                   |  123 ++++++-
 transport.c                          |   31 ++-
 transport.h                          |   41 ++-
 20 files changed, 1316 insertions(+), 46 deletions(-)
