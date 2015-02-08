From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFD 0/3] worktree.* config keys and submodule and multiple worktrees
Date: Sun,  8 Feb 2015 20:16:31 +0700
Message-ID: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Max Kirillov <max@max630.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 14:16:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKRj1-0002KZ-Hc
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 14:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbBHNQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 08:16:30 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:44169 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbBHNQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 08:16:29 -0500
Received: by pdbft15 with SMTP id ft15so25130416pdb.11
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=pzBQWYAjPG9QxqMFysUupOF1Dxdc8npnYMPZS0lM/MY=;
        b=BgfDBVciF4QYvt5HTugJza5IsNz0feqbOa784q0zBvOm7mFuDZ/xdcfCt3Fz8N5RiP
         4ynP0/7WR9eB64WfpzJujHYQHj6l/RBwlDM0sP3HOJu9BDk6ud/4lG5MuVxHoCLaSv7R
         PfOrGG60yK/ddmGI3hxyaYEk4Vb5BCfSu63e8ranRmZvTAja1V1WLG1bADXNd75Thf7w
         PhcQz89UJOIzY0wwcPayP9eCeAF2Tq+wX+YcaqEi78dVnIFu01Wd/3u94YEyhrTm9YfJ
         NeZlDQ2K7fWUUp4B7NXw8ExDsO5tjJfCRI8oHuWb74Jc7K2t+Kp/Wx9+bZFRJx527FoR
         S0Qw==
X-Received: by 10.70.95.35 with SMTP id dh3mr20362529pdb.91.1423401389377;
        Sun, 08 Feb 2015 05:16:29 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id xw1sm13554169pac.47.2015.02.08.05.16.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 05:16:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:16:36 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263510>

1/3 is a more complete version of a patch I posted earlier [1]. It
makes sure that worktree.* config keys are stored in a different place
than $GIT_DIR/config. This allows us to work around the core.worktree
issue in multiple worktree setting.

I think 1/3 and 2/3 are fine. 3/3 is probably not. It's more of a
proof of concept. The tests pass, but there's no migration path for
existing submodules. Submodules modified by new Git will confuse old
Git because the old ones do not understand worktree.path (the
replacement for core.worktree)

But I think it's a start..

[1] http://article.gmane.org/gmane.comp.version-control.git/263134

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  config.c: new config namespace worktree.* stored in $GIT_DIR/config.w=
orktree
  setup: add worktree.path to shadow core.worktree
  submodule: use worktree.path instead of core.worktree

 Documentation/config.txt               |  7 ++++++-
 builtin/config.c                       |  8 +++++++
 config.c                               | 38 ++++++++++++++++++++++++++=
++++++++
 git-submodule.sh                       |  2 +-
 setup.c                                |  7 ++++++-
 submodule.c                            |  6 +++---
 t/lib-submodule-update.sh              |  8 +++----
 t/t1300-repo-config.sh                 | 31 ++++++++++++++++++++++++++=
+
 t/t7400-submodule-basic.sh             |  4 ++--
 t/t7409-submodule-detached-worktree.sh |  6 +++---
 10 files changed, 102 insertions(+), 15 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
