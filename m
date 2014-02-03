From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/26] inotify support
Date: Mon,  3 Feb 2014 11:28:48 +0700
Message-ID: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:29:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAB9u-0000lO-Hx
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbaBCE3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:18 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38270 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaBCE3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:17 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so6580217pbc.36
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=a+3lFpzPbzMU+iasQ5ib3pQbuQE0OCZ1DsaYJ7ZC1cQ=;
        b=MO1AS2KVIXvqTCVpTJso0TaQXYS0B0Y5lsAqUpO83a4E+E4Ouy6s4nYFAhIYH35mKW
         WuWBvO6yuVuqo6hBbRJ6em0fFFAA91acdXTgEhjgL/eAkg9Wii8HDs/V2NF+ziLb5DR8
         A6tVscpO8ROxehvxfxQRZzbaXckma0WPOeykXkF6aUTKfPiv8pJyKn+uH0MK4mQt4UwU
         VBsV0CrlKQt1BXKzYP/tFRr85MZeaQpKzxbZ43S8rtXEcfoAgX5IYPJFqDSV/sxf4xK4
         rtUeRAA1SOCJoN+g/m7ToX4fRJDdRUKqBO53AwTdgZ42hRmURMLr+lYszwCG152jjYJf
         nEmg==
X-Received: by 10.68.143.34 with SMTP id sb2mr25353445pbb.135.1391401757242;
        Sun, 02 Feb 2014 20:29:17 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id lh13sm134193905pab.4.2014.02.02.20.29.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:15 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241395>

I'm happy with this now. The only things left are applying ewah on the
watch index extension and maybe improve lookup performance a bit. The
former needs jk/pack-bitmap graduated. The latter is not urgent. Oh
and maybe address "BUGS" section (more like known limitations) in
git-file-watcher.txt.

=46or early adopters that fear a buggy file-watcher may cause update
loss, set GIT_TEST_WATCHED=3D1 (or 2). It'll do lstat() to verify
file-watcher results (so no perf. gain). Beware of race condition
that may lead to false positives, mentioned in 20/26 (maybe I should
do something about it).

The series can also be fetched from

https://github.com/pclouds/git.git file-watcher

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (26):
  pkt-line.c: rename global variable buffer[] to something less generic
  pkt-line.c: add packet_write_timeout()
  pkt-line.c: add packet_read_line_timeout()
  unix-socket: make unlink() optional in unix_stream_listen()
  Add git-file-watcher and basic connection handling logic
  file-watcher: check socket directory permission
  file-watcher: remove socket on exit
  file-watcher: add --detach
  read-cache: save trailing sha-1
  read-cache: new flag CE_WATCHED to mark what file is watched
  Clear CE_WATCHED when set CE_VALID alone
  read-cache: basic hand shaking to the file watcher
  read-cache: ask file watcher to watch files
  read-cache: put some limits on file watching
  read-cache: get changed file list from file watcher
  git-compat-util.h: add inotify stubs on non-Linux platforms
  file-watcher: inotify support, watching part
  file-watcher: inotify support, notification part
  Wrap CE_VALID test with ce_valid()
  read-cache: new variable to verify file-watcher results
  Support running file watcher with the test suite
  file-watcher: quit if $WATCHER/socket is gone
  file-watcher: tests for the daemon
  ls-files: print CE_WATCHED as W (or "w" with CE_VALID)
  file-watcher: tests for the client side
  Disable file-watcher with system inotify on some tests

 .gitignore                               |    2 +
 Documentation/config.txt                 |   19 +
 Documentation/git-file-watcher.txt (new) |   54 ++
 Documentation/git-ls-files.txt           |    1 +
 Documentation/technical/index-format.txt |    9 +
 Makefile                                 |    3 +
 builtin/grep.c                           |    2 +-
 builtin/ls-files.c                       |   14 +-
 builtin/update-index.c                   |   12 +-
 cache.h                                  |   17 +
 config.mak.uname                         |    1 +
 credential-cache--daemon.c               |    2 +-
 daemon.c                                 |   30 +-
 diff-lib.c                               |    4 +-
 diff.c                                   |    2 +-
 file-watcher-lib.c (new)                 |  321 +++++++++
 file-watcher-lib.h (new)                 |    8 +
 file-watcher.c (new)                     | 1149 ++++++++++++++++++++++=
++++++++
 git-compat-util.h                        |   43 ++
 pkt-line.c                               |   61 +-
 pkt-line.h                               |    2 +
 read-cache.c                             |  119 +++-
 setup.c                                  |   25 +
 t/t1011-read-tree-sparse-checkout.sh     |    2 +
 t/t2104-update-index-skip-worktree.sh    |    2 +
 t/t7011-skip-worktree-reading.sh         |    2 +
 t/t7012-skip-worktree-writing.sh         |    2 +
 t/t7513-file-watcher.sh (new +x)         |  382 ++++++++++
 t/t7514-file-watcher-lib.sh (new +x)     |  190 +++++
 test-file-watcher.c (new)                |  111 +++
 unix-socket.c                            |    5 +-
 unix-socket.h                            |    2 +-
 unpack-trees.c                           |    2 +-
 wrapper.c                                |   47 ++
 34 files changed, 2591 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/git-file-watcher.txt
 create mode 100644 file-watcher-lib.c
 create mode 100644 file-watcher-lib.h
 create mode 100644 file-watcher.c
 create mode 100755 t/t7513-file-watcher.sh
 create mode 100755 t/t7514-file-watcher-lib.sh
 create mode 100644 test-file-watcher.c

--=20
1.8.5.2.240.g8478abd
