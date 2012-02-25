From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 00/11] Column display
Date: Sat, 25 Feb 2012 18:41:07 +0700
Message-ID: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 12:39:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Fy2-0001jw-I6
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 12:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab2BYLjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 06:39:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44098 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab2BYLjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 06:39:01 -0500
Received: by daed14 with SMTP id d14so3436768dae.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 03:39:00 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.232.170 as permitted sender) client-ip=10.68.232.170;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.232.170 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.232.170])
        by 10.68.232.170 with SMTP id tp10mr16766683pbc.72.1330169940470 (num_hops = 1);
        Sat, 25 Feb 2012 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=nYfXJa70GS94neE1ducKTbGWq+c50EMaPuFl8BrJwzI=;
        b=mOzXoXX/8kJvFzxbtAeLJlWath/gaeSn9LJFybR33Y7OSlwDmoWEk5i8H8zBFzFx8F
         GyiaCCOF4x9z9Il+AwEVt2pogGccQMGlnhL3gUkKmbZA8SBr9sxvHP8V8evzDRV5D0SY
         N3wZoPt7D5InIefXOcqP1VfTi1dhnU73n2gI4=
Received: by 10.68.232.170 with SMTP id tp10mr13923378pbc.72.1330169940219;
        Sat, 25 Feb 2012 03:39:00 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id li19sm7012654pbb.17.2012.02.25.03.38.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 03:38:59 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 18:41:18 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191522>

Compared to v5 [1] this only has minor changes:

 - drop term_columns() patch because master already has that
 - style fixes
 - incorporate Ramsay's fix in option parsing code
 - make git_column_config() return either 0 or -1

[1] http://thread.gmane.org/gmane.comp.version-control.git/189758/focus=
=3D189875

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  column: add API to print items in columns
  Add git-column and column mode parsing
  Stop starting pager recursively
  column: add columnar layout
  column: support columns with different widths
  column: add column.ui for default column output settings
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
 builtin/column.c             |   62 ++++++
 builtin/commit.c             |    6 +
 builtin/tag.c                |   26 ++-
 column.c                     |  478 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   40 ++++
 command-list.txt             |    1 +
 git.c                        |    1 +
 help.c                       |   48 ++---
 pager.c                      |    2 +-
 parse-options.h              |    2 +
 t/t3200-branch.sh            |   77 +++++++
 t/t7004-tag.sh               |   44 ++++
 t/t7508-status.sh            |   24 ++
 t/t9002-column.sh            |  161 ++++++++++++++
 wt-status.c                  |   28 +++-
 wt-status.h                  |    1 +
 25 files changed, 1110 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh

--=20
1.7.8.36.g69ee2
