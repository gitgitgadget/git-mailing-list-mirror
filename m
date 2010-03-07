From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Sun,  7 Mar 2010 19:09:33 +0700
Message-ID: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFMY-0006M7-5u
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab0CGMNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:09 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:43117 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab0CGMNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:06 -0500
Received: by pzk32 with SMTP id 32so2186141pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=r+mxPBob4EZprZNiPkCUiLd/yQeWsW8fHQxHVjyihzA=;
        b=rLMlkXpNmd1FYkr3vEvMPyGfhLeDrzP9+rm6OHUJ7U2nYwrFHlHuOZZnA/AsR5OYSI
         SvHyat+1SvlPcST40Z2lU4FtMbcOFa8UdFBmEZrrS0dm/7+RzF/XwyIkn+8HZIFvB781
         JNk062FxkEX7gvGKMjJRNFonFHlLgOM0kbWqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Bhs6DheG7oqOGXBymqlg1/fmJR4Kjbv7IfE9lN/aOZeukrBJgaYtO5/qUD0Ure7h6l
         ge5yu5QGzJou+siikaRH7ry4dKH5PVLqYJjDilfm3Kz16cX4EHlcljRchU1PFliwnbH8
         8Q6hHXaJGHTw2EgnQSl+r118vBxtwZ4KS92cU=
Received: by 10.114.188.31 with SMTP id l31mr2368620waf.119.1267963982711;
        Sun, 07 Mar 2010 04:13:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3630240pzk.11.2010.03.07.04.13.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:09:47 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141678>

This adds support to show columnized output in the mentioned commands.
I am quite happy with columnized "git branch/tag".

There is still room for improvement. For example, if "git column" is go=
ing to
display all items in one or two lines (too wide screen), then falling b=
ack to
one column mode would be better.

I'm also experimenting aligned grep output.  While it's useful
sometimes to look for things near the beginning of line, I don't know
if it's really worth the effort.

Anyway, enjoy the new output (Hmm.. "git config -l" may be applicable f=
or
columnization too)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  Move term_columns() to pager.c
  setup_pager(): save terminal width before redirecting stdout
  Add columnizer
  help: use columnizer
  Add builtin command "column"
  Add helpers to redirect stdout to "git column"
  add core.columns
  tag: support column output with --columns
  branch: support column output with --columns
  ls-files: support column output with --columns
  grep: do not return early in cmd_grep() if there is no error
  grep: support column output with --columns

 .gitignore                   |    1 +
 Documentation/config.txt     |    8 ++
 Documentation/git-branch.txt |    8 ++
 Documentation/git-column.txt |   40 ++++++++++
 Documentation/git-grep.txt   |   10 +++
 Documentation/git-tag.txt    |   11 +++-
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/branch.c             |   18 ++++-
 builtin/column.c             |   42 +++++++++++
 builtin/grep.c               |   48 +++++++------
 builtin/ls-files.c           |   10 +++
 builtin/tag.c                |   17 ++++-
 cache.h                      |    2 +
 column.c                     |  164 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   25 +++++++
 command-list.txt             |    1 +
 config.c                     |    6 ++
 environment.c                |    1 +
 git.c                        |    1 +
 help.c                       |   55 +++-----------
 pager.c                      |   95 ++++++++++++++++++++++++
 t/t9002-column.sh            |  101 ++++++++++++++++++++++++++
 23 files changed, 595 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh
