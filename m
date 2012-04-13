From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v9 0/9] Column display
Date: Fri, 13 Apr 2012 17:54:32 +0700
Message-ID: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 12:55:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIeAB-0006YN-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 12:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935131Ab2DMKzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 06:55:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35185 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2DMKza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 06:55:30 -0400
Received: by pbcun15 with SMTP id un15so3501433pbc.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=5XnLZgPqEH7yAPWCcvYTYN9J7Mv9JFKk9CIjZCwV+dk=;
        b=oJcKVQpptGmgAVcEtvvzXPcwQD/JGxqQJErIzsUwti1iep72p1f02NgA9qk0QDFKud
         gBK+uKshJmUTRneyDt1gJpua/2+irLx/DutNDy3CcOQ6ItHBAfEp4cEBASuwq49IivVF
         X20n/mYKAHx0ge0fK9LXLg6nPpsul/qXRgVa96tm3UZhNHZpKKd/mqn+g+le+nVRIlso
         kjOzOAyWmLmTkd4sndNfuYk9V2y/AdIPGkk3z32PM8H1rW+GfkXrvPKsELmuZakCunxp
         9J13ei/+gkU/5QRE+vkMvEZ3Zks+9WEWOY30M5bTYajqDG+cAUJuIlOQ9/UO6h+c5muJ
         kL6w==
Received: by 10.68.231.233 with SMTP id tj9mr4029370pbc.49.1334314530061;
        Fri, 13 Apr 2012 03:55:30 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id gh7sm8443835pbc.8.2012.04.13.03.55.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 03:55:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Apr 2012 17:54:42 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195410>

Compared to v8 [1], the only change is "COL_ENABLE(c) =3D=3D COL_ENABLE=
D"
becomes column_active(c). Oh the the experimental modes are dropped,
obviously they are not ready.

[1] http://thread.gmane.org/gmane.comp.version-control.git/191522/focus=
=3D192997

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

 .gitignore                   |    1 +
 Documentation/config.txt     |   38 ++++
 Documentation/git-branch.txt |    9 +
 Documentation/git-column.txt |   53 +++++
 Documentation/git-status.txt |    7 +
 Documentation/git-tag.txt    |    9 +
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/branch.c             |   32 +++-
 builtin/column.c             |   59 ++++++
 builtin/commit.c             |    7 +
 builtin/help.c               |    7 +-
 builtin/tag.c                |   27 +++-
 column.c                     |  435 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   45 +++++
 command-list.txt             |    1 +
 git.c                        |    1 +
 help.c                       |   59 +++----
 help.h                       |    2 +-
 pager.c                      |    2 +-
 parse-options.h              |    2 +
 t/t3200-branch.sh            |   77 ++++++++
 t/t7004-tag.sh               |   44 +++++
 t/t7508-status.sh            |   24 +++
 t/t9002-column.sh            |  179 +++++++++++++++++
 wt-status.c                  |   28 +++-
 wt-status.h                  |    1 +
 27 files changed, 1105 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh

--=20
1.7.3.1.256.g2539c.dirty
