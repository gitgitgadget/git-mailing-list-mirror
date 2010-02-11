From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5 v2] Worktree/Gitdir at root directory
Date: Thu, 11 Feb 2010 21:43:18 +0700
Message-ID: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaQE-0003Ou-SH
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab0BKOxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:53:33 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:59873 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab0BKOxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:53:33 -0500
Received: by ywh27 with SMTP id 27so1093717ywh.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=e4NWR1PS9dBG34ZHczttUwzgA2C0QrebaNlqHOajj/8=;
        b=Yo1c6a0PAymrhmmhji8L6efswvubT07Tm3KtCB5SSIHFosXGSKYrcChg1zTmJ6XAHb
         t3aslz9EMBzrx88tAcXmWeW9sCN81NgqkXxS7LaHykcFZ3hiUEOQicxTex+/ZsSkivhr
         pZ1Kge4miNohwOF4QlMbfHaGDKO4M6v9cQMTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ksmUvYMN3299sg73n9f0OSSA/B/9upNduKmXyZZEL5oXskgL3/FMvPZCURQ3va6Vhx
         c/q7UrJj21/kdBjZUuuEHjXZS/GQgLtC/eNCm0KNrUZ7MvU4I2DszZHdcjfHtp/0X+qJ
         lUWsjfsZNKRh0ZjF0ib2ReE/i4AjCQ2GK0668=
Received: by 10.150.252.41 with SMTP id z41mr308441ybh.175.1265899565871;
        Thu, 11 Feb 2010 06:46:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 21sm934666ywh.46.2010.02.11.06.46.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 06:46:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Feb 2010 21:43:24 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139596>

So here we go again. Changes are:

 - Support DOS drives as root path (Thanks Hannes)
 - Fix one "broken" test that I was too lazy to do last time
 - t1509-root-worktree.sh will refuse to run under root permission

I did not test it on Windows, so an Ack from someone who actually tests=
 it on Windows
is really appreciated.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  make_absolute_path(): Do not append redundant slash
  init-db, rev-parse --git-dir: do not append redundant slash
  Add is_root_path()
  Support working directory located at root
  Add test for using Git at root directory

 abspath.c                 |    5 +-
 builtin-init-db.c         |    9 +-
 builtin-rev-parse.c       |    4 +-
 git-compat-util.h         |   11 ++
 setup.c                   |   13 ++-
 t/t1509-root-worktree.sh  |  249 +++++++++++++++++++++++++++++++++++++=
++++++++
 t/t1509/excludes          |   14 +++
 t/t1509/prepare-chroot.sh |   38 +++++++
 8 files changed, 332 insertions(+), 11 deletions(-)
 create mode 100755 t/t1509-root-worktree.sh
 create mode 100644 t/t1509/excludes
 create mode 100755 t/t1509/prepare-chroot.sh
