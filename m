From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/9] column output v3
Date: Sun, 20 Mar 2011 19:57:44 +0700
Message-ID: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:58:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ICz-0002jT-7w
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab1CTM6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:58:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50802 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1CTM6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:58:06 -0400
Received: by iwn34 with SMTP id 34so5553777iwn.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=1Qljzwu4LQyrqKQPPiHMUQTYKy5ee37WPI4ytKCier0=;
        b=eS9GGVf7jlEodGstKvAnhYNgB0gE7bloURwHAVnHLIvDEx/V/pePMYHlImcfAalIuN
         7gQxAjGDfVY1W7sV2I0fLiUUyWj20SGDW48xDf0AA/uCCjivmtVMT7eKGQLqy3lA/hF4
         vbvudnC/0OD7ji/xtF0pfM6nMnzGlFDgNrpvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=LZMc6sQk2QOGN05f+XIdLb/TA+LIr18oEWryBnQPue6EMUBV4akyfmdMalp8n7RzGg
         YRENozLRI4uQri73geJjNA1B06z7Zh5Hzm6yD1lEO0ujfJdHebIXyoi01EMCRxYrJF7P
         EaizGLvEAMCrqq2q4rLmmkup5Pb5RB8+tQd2Y=
Received: by 10.42.96.4 with SMTP id h4mr5125803icn.136.1300625884179;
        Sun, 20 Mar 2011 05:58:04 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id d10sm2961729ibb.17.2011.03.20.05.57.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:58:03 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:57:53 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169502>

Compared to v2 [1]. It's quite ready for consumption:

 - dense mode works better (and consumes more cpu cycles, but not much)
 - there should be no impact when it's not activated (i.e. no
   output buffering)
 - column.ui is used for default settings. Not sure if I should go for
   column.branch and column.tag
 - --[no-]column can be used to override column.ui

[1] http://mid.gmane.org/1297254284-3729-1-git-send-email-pclouds@gmail=
=2Ecom

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  Move term_columns() to pager.c and save terminal width before pager
  Add display_columns() to display in columnar layout
  column: add functions to parse column settings
  display_columns: add COL_MODE_{COLUMN,ROW} mode
  display_columns: add COL_DENSE to do unequal column layout
  column: add column.ui for default column output settings
  help: reuse display_columns() for help -a
  tag: add --column
  branch: add --column

 .gitignore                   |    1 +
 Documentation/config.txt     |   24 +++
 Documentation/git-branch.txt |    9 +
 Documentation/git-tag.txt    |   11 +-
 Makefile                     |    3 +
 builtin/branch.c             |   23 ++-
 builtin/tag.c                |   21 ++-
 column.c                     |  378 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   22 +++
 help.c                       |   53 +-----
 pager.c                      |   33 ++++
 parse-options.h              |    2 +
 t/t9002-column.sh            |  135 +++++++++++++++
 test-column.c                |   39 +++++
 14 files changed, 701 insertions(+), 53 deletions(-)
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh
 create mode 100644 test-column.c

--=20
1.7.4.74.g639db
