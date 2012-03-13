From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 00/9] Column display
Date: Tue, 13 Mar 2012 19:09:12 +0700
Message-ID: <cover.1331638663.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:06:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QUk-0005As-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab2CMMGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:06:20 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59624 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab2CMMGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:06:17 -0400
Received: by dadp12 with SMTP id p12so885281dad.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RM3yn9zB960WRyizWjKmEEIkB1CfelFbLCau6gTii7w=;
        b=YcxI6gvQCA79M624dDogCeOZsDjUUgUYMRzYiAy5SLPo3apSdtNHoYyhFeL2PHNg7Z
         Q+oODAt8MqqV8757GINBXSqLhUJZS0/2pIbRV9DDbRQZXA45dj+BwLqE7ulBlecNMtAp
         477gbC//yQBtozp1nzyqtB5w77Jr9pMXhzRos1i05Jg4/J/97jIvB1yskpTl0//6zm+0
         q4xPf+9HBfRVtBUwezWVpsbao78VwWNrSAaoMuw75cZ9780UnmewJNkN3W6CMfLjF+/G
         YJx/6uryxG2yNg0LC/htW/D/z7N7ak6prt3TfwkL/9acA4IFl8GKejBfbeosFjKcIgLt
         5ffg==
Received: by 10.68.236.35 with SMTP id ur3mr8697582pbc.43.1331640377383;
        Tue, 13 Mar 2012 05:06:17 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id f8sm632970pbe.42.2012.03.13.05.06.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:06:15 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:09:25 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192997>

This series fixes problems found in v6:

 - rework config code. I think it looks nicer now.
 - fix valgrind issue in shrink_columns()
 - make "help -a" respect column.*
 - only use up to term_columns() - 1. If we try to print to the last
   column, the line may be wrapped around.

This series misses the 1.7.10 train already and I wasn't going to post
this until the 1.7.10 comes out, but I'd like to take feedback on 3
extra WIP patches at the end. They deal with cases where column
layout is not as efficient as it should be. More details in the patch
description.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  Add column layout skeleton and git-column
  Stop starting pager recursively
  column: add columnar layout
  column: add dense layout support
  help: reuse print_columns() for help -a
  branch: add --column
  status: add --column
  column: support piping stdout to external git-column process
  tag: add --column

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  ls-files: support --column
  column: support "denser" mode
  column: support grouping entries

 .gitignore                   |    1 +
 Documentation/config.txt     |   38 +++
 Documentation/git-branch.txt |    9 +
 Documentation/git-column.txt |   53 +++
 Documentation/git-status.txt |    7 +
 Documentation/git-tag.txt    |    9 +
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/branch.c             |   32 ++-
 builtin/column.c             |   59 ++++
 builtin/commit.c             |    7 +
 builtin/help.c               |    7 +-
 builtin/ls-files.c           |    8 +
 builtin/tag.c                |   27 ++-
 column.c                     |  724 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   44 +++
 command-list.txt             |    1 +
 git.c                        |    1 +
 help.c                       |   59 ++--
 help.h                       |    2 +-
 pager.c                      |    2 +-
 parse-options.h              |    2 +
 t/t3200-branch.sh            |   77 +++++
 t/t7004-tag.sh               |   44 +++
 t/t7508-status.sh            |   24 ++
 t/t9002-column.sh            |  179 +++++++++++
 wt-status.c                  |   28 ++-
 wt-status.h                  |    1 +
 28 files changed, 1401 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh

--=20
1.7.8.36.g69ee2
