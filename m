From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/41] Add and use error_errno() and warning_errno()
Date: Sun,  1 May 2016 18:14:16 +0700
Message-ID: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLU-0006dd-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbcEALPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:15 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34317 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbcEALPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:14 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so16150457pac.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/qO+tyLHyLMHDfsbmwJ+ofleO4VJSeBhukxYmYz2MU=;
        b=UWObTw17eby9EtD9WIE9QTFUMYSTaZPtVlKhtBCjkpCPWTw4qxxWLGI0Hjk0grYyYO
         icQcWv+GyFuGOShwDzZfZQj2bek9fFsZgfvNdMH2tiuV+AM2LE0NPD95jvqTFfpxcWuz
         xrGjt7atd5ElvNYcdBEsfxP+YX2qOespQt1aWk3v7lab03OK7tqsCW0D7uNf9P3UCSH5
         wkokj4zErV5zJivrRrDt8m8ZuxbF1pkxGoaMs6V7l0/VR9yNvac8zQ1WXp9TFpKoWVYQ
         xznoR2hbNfvlJXZG+HeVTodt9yIF9gnMrGp3bGsZ7+0ZvBlDxvqwGDYg5mLPFhsGySck
         m+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/qO+tyLHyLMHDfsbmwJ+ofleO4VJSeBhukxYmYz2MU=;
        b=XZPMNBSrM0fzgOk1bonyPnDY/Dyp9pasiYVKFPw6lqmdCUsmewR1pHfEuDseXr3WQD
         amWMJc9In0vErltsiIdIC7HRqoL8JmIG5bZIAIJkdC2+nG6Ror8/0V64TPJEbe8aPyFj
         OeMNZngFXekGdkj78Qh6iApYwigFn4PE7hpBz1U2kr68rYgZFZHi9jVVxasNiafNCGz9
         bFQsVq3RzufA1FY6fQzvwqA3PAStX65F6rKoiJG4zHSxkE7+af3G6w11kY7p23kEzNES
         i8JLOonh1pFVSn1s8Pqo4ByCCQoROMxRNVSwoeId29VeyyAr31pw/IWHfcePmX2NF2PL
         E1lA==
X-Gm-Message-State: AOPr4FXEB8Q2xJkIrP3FYKb1N8t/KjYI8vhnnOr7EjpFMaIkl3b75XFSNuRsNZKXIly6Uw==
X-Received: by 10.66.132.72 with SMTP id os8mr43355221pab.63.1462101312719;
        Sun, 01 May 2016 04:15:12 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id q70sm37047082pfj.81.2016.05.01.04.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:07 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293150>

This is a spinoff from my worktree-move topic. This series adds
die_errno() companions, error_errno() and warning_errno(), and use them
where applicable to reduce the amount of typing (in future). Changes
are split by file (which explains the huge number of patches). I leave
builtin/apply.c and refs/files-backend.c untouched because they are
currently hot zones.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (41):
  usage.c: move format processing out of die_errno()
  usage.c: add warning_errno() and error_errno()
  bisect.c: use die_errno() and warning_errno()
  builtin/am.c: use error_errno()
  builtin/branch.c: use error_errno()
  builtin/fetch.c: use error_errno()
  builtin/help.c: use warning_errno()
  builtin/mailsplit.c: use error_errno()
  builtin/merge-file.c: use error_errno()
  builtin/pack-objects.c: use die_errno() and warning_errno()
  builtin/rm.c: use warning_errno()
  builtin/update-index.c: use error_errno()
  builtin/upload-archive.c: use error_errno()
  builtin/worktree.c: use error_errno()
  check-racy.c: use error_errno()
  combine-diff.c: use error_errno()
  compat/win32/syslog.c: use warning_errno()
  config.c: use error_errno()
  connected.c: use error_errno()
  copy.c: use error_errno()
  credential-cache--daemon.c: use warning_errno()
  diff-no-index.c: use error_errno()
  editor.c: use error_errno()
  entry.c: use error_errno()
  fast-import.c: use error_errno()
  gpg-interface.c: use error_errno()
  grep.c: use error_errno()
  http.c: use error_errno() and warning_errno()
  ident.c: use warning_errno()
  mailmap.c: use error_errno()
  reachable.c: use error_errno()
  rerere.c: use error_errno() and warning_errno()
  run-command.c: use error_errno()
  sequencer.c: use error_errno()
  server-info.c: use error_errno()
  sha1_file.c: use {error,die,warning}_errno()
  transport-helper.c: use error_errno()
  unpack-trees.c: use error_errno()
  upload-pack.c: use error_errno()
  vcs-svn: use error_errno()
  wrapper.c: use warning_errno()

 bisect.c                   |  7 +++----
 builtin/am.c               | 11 +++++------
 builtin/branch.c           |  3 +--
 builtin/fetch.c            |  4 ++--
 builtin/help.c             |  8 ++++----
 builtin/mailsplit.c        | 10 +++++-----
 builtin/merge-file.c       | 10 +++++-----
 builtin/pack-objects.c     |  8 +++-----
 builtin/rm.c               |  2 +-
 builtin/update-index.c     |  8 ++++----
 builtin/upload-archive.c   |  3 +--
 builtin/worktree.c         |  2 +-
 check-racy.c               |  2 +-
 combine-diff.c             |  3 +--
 compat/win32/syslog.c      |  6 +++---
 config.c                   | 22 +++++++++-------------
 connected.c                |  9 +++------
 copy.c                     |  6 +++---
 credential-cache--daemon.c |  4 ++--
 diff-no-index.c            |  3 +--
 editor.c                   |  3 +--
 entry.c                    | 10 ++++------
 fast-import.c              | 10 +++++-----
 git-compat-util.h          |  2 ++
 gpg-interface.c            |  6 ++----
 grep.c                     |  4 ++--
 http.c                     | 10 ++++------
 ident.c                    |  8 +++-----
 mailmap.c                  |  3 +--
 reachable.c                |  3 +--
 rerere.c                   | 18 +++++++-----------
 run-command.c              | 15 +++++++--------
 sequencer.c                |  3 +--
 server-info.c              |  2 +-
 sha1_file.c                | 32 +++++++++++++-------------------
 transport-helper.c         |  6 +++---
 unpack-trees.c             |  6 ++----
 upload-pack.c              |  3 +--
 usage.c                    | 44 ++++++++++++++++++++++++++++++++++----=
------
 vcs-svn/line_buffer.c      |  4 ++--
 vcs-svn/sliding_window.c   |  2 +-
 vcs-svn/svndiff.c          |  4 ++--
 vcs-svn/svndump.c          |  4 ++--
 wrapper.c                  |  4 ++--
 44 files changed, 161 insertions(+), 176 deletions(-)

--=20
2.8.0.rc0.210.gd302cd2
