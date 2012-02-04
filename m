From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 00/12] Column display
Date: Sat,  4 Feb 2012 22:59:04 +0700
Message-ID: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:55:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RthxO-0006Ta-Au
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab2BDPzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:55:01 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40600 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab2BDPyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 10:54:51 -0500
Received: by pbdu11 with SMTP id u11so3706596pbd.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KYInheVb93sf3K8xo7AAo1EqeqlFwnl7wnaeLknzRe0=;
        b=l4JX/pmANkUxYiOayJfaGe7J0hvJSHTwhV7TjFyRQzqUjHEYpbkfr9l2Gm1QzjDfWP
         3hqTGpMnyWWE4u1CSyEf6SdcVT3HLwKkwhKcfdd2Lxqj9mo+k9yaIRh8B+RcPVyB82TE
         MAfZCxzTirF4o209EIubs0NQ1btq8OxnXY6gU=
Received: by 10.68.209.6 with SMTP id mi6mr28498269pbc.87.1328370890503;
        Sat, 04 Feb 2012 07:54:50 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id o7sm22395445pbq.8.2012.02.04.07.54.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:54:49 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 04 Feb 2012 22:59:16 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189875>

- Turn column bitflag type to unsigned int
- Get rid of global var git_colopts
- Get rid of ill-designed print_cell()
- Refuse to run "git branch -v --column" and "git tag -l -n --column"
- Fix "git status --column --no-color" always prints ANSI reset sequenc=
e
- Drop OPT_INTEGER hexadecimal support (it's not essential, the column
  helper functions can pass arguments are decimal)
- Add some more tests for column display

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  Save terminal width before setting up pager
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
 Documentation/git-tag.txt    |   11 +-
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/branch.c             |   38 +++-
 builtin/column.c             |   62 ++++++
 builtin/commit.c             |    8 +
 builtin/tag.c                |   30 +++-
 column.c                     |  480 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   36 +++
 command-list.txt             |    1 +
 git.c                        |    1 +
 help.c                       |   70 ++-----
 pager.c                      |   37 +++-
 parse-options.h              |    2 +
 t/t3200-branch.sh            |   50 +++++
 t/t7004-tag.sh               |   44 ++++
 t/t7508-status.sh            |   24 ++
 t/t9002-column.sh            |  135 ++++++++++++
 wt-status.c                  |   28 +++-
 wt-status.h                  |    1 +
 25 files changed, 1104 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh

--=20
1.7.8.36.g69ee2
