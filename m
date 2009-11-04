From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 00/13] Reroll of the remote-vcs-helper series
Date: Wed,  4 Nov 2009 20:48:05 +0100
Message-ID: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lr0-0008UA-76
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055AbZKDTtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758033AbZKDTtB
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:01 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61042 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025AbZKDTtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:00 -0500
Received: by ewy3 with SMTP id 3so3490470ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=WkLthRmuO6izKcmrq7uVmThYmN8OuLAv2Rm0HBhrezc=;
        b=Ft8fnk1JJgV8tEuz1vIDSektrxMfuimKlOdPm7DmFqMDkbiS56PGfQdv2S6A1MXD0/
         cswoPjPQan5laMHJ9al0c/iI6/SiCcqT2HYdBoDb1prtz3LT9CkNPy+EcXZr1A1zMtZA
         i8D/5IVzFsCWuNmvPaBtX645wSgyILcTDQLvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=V1FJauSQAqhncCHBhubEWw/kxWPX4yaRKwgGl7JtxweMzZotIwh7Tg30eNOhg5cf1T
         uCvNGT8oFBy0W6fMwvB5YsNwX1DH67ffkSwalMNnzAHtifVCfROeB779waJqoWRuEcRj
         XymgIL2rdvqPiqDZW9DyjgHzQBBe6wFSQL3Qo=
Received: by 10.213.24.3 with SMTP id t3mr137731ebb.40.1257364144723;
        Wed, 04 Nov 2009 11:49:04 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:04 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132121>

Major changes include removal of the cvs specific code as well incorperation
of most of Daniel's comments. For details see the post-triple-dash of the
individual patches.

Daniel, I haven't yet had time to write the 'refspec' part, but that is
something that can definitely go on top of the current series.

Daniel Barkalow (7):
      Fix memory leak in helper method for disconnect
      Allow programs to not depend on remotes having urls
      Use a function to determine whether a remote is valid
      Allow fetch to modify refs
      Add a config option for remotes to specify a foreign vcs
      Add support for "import" helper command
      Allow helpers to report in "list" command that the ref is unchanged

Johan Herland (1):
      Basic build infrastructure for Python scripts

Johannes Schindelin (1):
      Allow specifying the remote helper in the url

Sverre Rabbelier (4):
      Write local refs written by the "import" helper command only once
      Honour the refspec when updating refs after import
      Allow helpers to request the path to the .git directory
      Add Python support library for remote helpers

 Documentation/config.txt             |    4 +
 Documentation/git-remote-helpers.txt |   14 +-
 Makefile                             |   51 +++
 builtin-clone.c                      |    8 +-
 builtin-fetch.c                      |    7 +-
 builtin-ls-remote.c                  |    4 +-
 builtin-push.c                       |   68 ++--
 configure.ac                         |    3 +
 git_remote_helpers/.gitignore        |    2 +
 git_remote_helpers/Makefile          |   35 ++
 git_remote_helpers/__init__.py       |   16 +
 git_remote_helpers/git/git.py        |  678 ++++++++++++++++++++++++++++++++++
 git_remote_helpers/setup.py          |   17 +
 git_remote_helpers/util.py           |  194 ++++++++++
 remote.c                             |   15 +-
 remote.h                             |    2 +
 t/test-lib.sh                        |   10 +
 transport-helper.c                   |   99 +++++-
 transport.c                          |   31 ++-
 transport.h                          |   43 ++-
 20 files changed, 1253 insertions(+), 48 deletions(-)
