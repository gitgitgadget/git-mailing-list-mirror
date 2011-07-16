From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 00/23] remote-helper improvements
Date: Sat, 16 Jul 2011 15:03:20 +0200
Message-ID: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Xt-00056J-4m
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab1GPNEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab1GPNEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:22 -0400
Received: by ewy4 with SMTP id 4so996059ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FPIL0oyT+EhtANwv39zYg6KNmYQ2zjnwQtEsVzxKEcU=;
        b=XNpuqpzva8S/JJ+ZGHMSWYcWDNmeQQ/+jpSYESr8sqBX2lpDyxabsKJHZGqDNhjo6d
         mRFw+0qbcs1s5+d4pN97Ai9UKcaGuUOxRQ0cgMSyRPmOXx20hAZZIV/H0yfqg4Lr7Wg1
         L1lejJgQwnjb8+P2x4HbbS0AupZu5/IbaOvFA=
Received: by 10.14.101.4 with SMTP id a4mr1564206eeg.114.1310821460612;
        Sat, 16 Jul 2011 06:04:20 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177255>

Incorperated feedback from Junio, Johannes and Peff. I also included
Dmitry's patch that adds GITDIR, which I modified to just remove the
support for a gitdir command.

Dmitry Ivankov (1):
  remote-helpers: export GIT_DIR variable to helpers

Jeff King (6):
  transport-helper: fix minor leak in push_refs_with_export
  t5800: factor out some ref tests
  t5800: document some non-functional parts of remote helpers
  git-remote-testgit: import non-HEAD refs
  transport-helper: don't feed bogus refs to export push
  git_remote_helpers: push all refs during a non-local export

Sverre Rabbelier (16):
  t5800: use skip_all instead of prereq
  remote-curl: accept empty line as terminator
  git-remote-testgit: only push for non-local repositories
  git-remote-testgit: fix error handling
  fast-import: introduce 'done' command
  fast-export: support done feature
  transport-helper: factor out push_update_refs_status
  transport-helper: check status code of finish_command
  transport-helper: use the new done feature where possible
  transport-helper: update ref status after push with export
  transport-helper: change import semantics
  transport-helper: Use capname for refspec capability too
  transport-helper: implement marks location as capability
  transport-helper: die early on encountering deleted refs
  t5800: document inability to push new branch with old content
  t5800: point out that deleting branches does not work

 Documentation/git-fast-export.txt    |    4 +
 Documentation/git-fast-import.txt    |   25 ++++
 Documentation/git-remote-helpers.txt |    3 +
 builtin/fast-export.c                |    9 ++
 fast-import.c                        |    8 +
 git-remote-testgit.py                |   62 +++++----
 git_remote_helpers/git/exporter.py   |   15 ++-
 git_remote_helpers/git/importer.py   |   32 ++++-
 git_remote_helpers/git/non_local.py  |   20 +--
 git_remote_helpers/git/repo.py       |    7 +-
 git_remote_helpers/util.py           |   81 +++++++++++
 remote-curl.c                        |   10 ++-
 t/t5800-remote-helpers.sh            |  112 +++++++++++++---
 t/t9300-fast-import.sh               |   42 ++++++
 transport-helper.c                   |  251 ++++++++++++++++++----------------
 15 files changed, 494 insertions(+), 187 deletions(-)

-- 
1.7.5.1.292.g728120
