From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 0/7] Support multiple worktrees
Date: Wed, 11 Dec 2013 21:15:26 +0700
Message-ID: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:10:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkV2-0007LN-KF
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab3LKOKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:10:48 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45994 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:10:47 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so9546065pdi.24
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=9ux58qOk18jJsF1q4CFSRlyYLoltyntI4ALZpLJ4pdk=;
        b=SDaK0xTwGuD81d6yPXS4bRBgsszrCOdP1Im/ygGuAze7rkav80QdbkbMasW061k7Y8
         F8tfdr0KZN5R+9b8VwIgEZaNCSuj/qpZX3CYeKUlnQeHkJYwQPEzV1E5tS/EE/TJv74c
         OIDAn8Euesno/6BDIdcn0olhjqMgZq/D5o5ZPQQsALSsplBKHGP5Ln+jDWNmeevDOOqr
         9olhQDRrWiyLkZurGee1f/bynrUye0had/BqupQNtdSxYdSc6QDAaSAYvUIVOpxAV8vz
         YOmjH63PuVFwEsUp374ZXgMhYlgI7tVs+y5QtALHddDlxVEUShHdLjHVZkMNq7JfNrS5
         hxbg==
X-Received: by 10.66.221.199 with SMTP id qg7mr1892831pac.13.1386771045785;
        Wed, 11 Dec 2013 06:10:45 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id g6sm45377030pat.2.2013.12.11.06.10.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:10:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:15:35 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239194>

This is what I imagine multi worktree support (aka git-new-workdir)
looks like. Basically two variables will control access to the repo:
$GIT_SUPER_DIR for worktree specific stuff and $GIT_DIR for the rest.

I like the idea of using git_path() to hide path relocation caused by
GIT_SUPER_DIR, but I may have made some design mistakes here..
setup_git_directory() changes are hairy. It's not surprise if I broke
something in there. Not important for a PoC though.

=46inal series may be a few patches longer as I only lay the foundation
in this series.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
  Make git_path() beware of file relocation in $GIT_DIR
  Add new environment variable $GIT_SUPER_DIR
  setup.c: add split-repo support to .git files
  setup.c: add split-repo support to is_git_directory()
  setup.c: reduce cleanup sites in setup_explicit_git_dir()
  setup.c: add split-repo support to setup_git_directory*
  init: add --split-repo with the same functionality as git-new-workdir

 builtin/init-db.c     |  42 +++++++++++++++
 cache.h               |   5 ++
 environment.c         |  37 ++++++++++++--
 path.c                |  45 ++++++++++++++--
 setup.c               | 139 ++++++++++++++++++++++++++++++++++--------=
--------
 t/t0060-path-utils.sh | 115 +++++++++++++++++++++++++++++++++++++++++
 test-path-utils.c     |   7 +++
 trace.c               |   1 +
 8 files changed, 339 insertions(+), 52 deletions(-)

--=20
1.8.5.1.77.g42c48fa
