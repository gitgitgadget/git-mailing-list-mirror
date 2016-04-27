From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 00/19] index-helper/watchman
Date: Wed, 27 Apr 2016 16:04:22 -0400
Message-ID: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVjM-0003h7-5I
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbcD0UFL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2016 16:05:11 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36090 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbcD0UFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:09 -0400
Received: by mail-qg0-f48.google.com with SMTP id d90so21813109qgd.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1Zky+jckzImQc7PEnzFVpzuVQSJPr07TEbIXk8XXkI=;
        b=EDZ+5W//+C8DwahbEvim5GfSdniXoDjPAlmFE7D01JIWo12RpRmkeCgSJpW0yE2pqv
         Phq0hzje3JsFxYW3jonfdyV3Y+YIBfmOBx+wqBoEWYiFYsL7rzeSMtaD54iwQchAON3E
         XpIB3zpIgvLRHb18KmLk0R695RyVTfiFeYnMTNHWcU/Qd99f+NYCgz+YxnVPKrLM3uVK
         8zA6b9sOLTVkWByTWgfiW9RDRueha4jQPqreMHQ45+FA/rGg+ZQ0D2l3UZTslzdzynPe
         637MkeZHa3OEvzwBo/RZVIiazkfZ0h6X/6zKz+KDbdW1oLVkN5drMoaciiY1dxNDJ4Ez
         9BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1Zky+jckzImQc7PEnzFVpzuVQSJPr07TEbIXk8XXkI=;
        b=g6TRqemuqT4e8x2NDJ2S4+jFc80V+giYjuYcAFdGfcfpB/1/SSsma3ykn4Z8BoB+g5
         N8vOOAAgWlEVuQRNz0wBzloTql38ci3Q2sCbibyZe12W3YoNot/AOSBLTYHOdRJt8j/n
         xZ4ycOgzyL//CiS0ZKihLeFp+xLph/7N7QU5pX2Y0mFbJ6aqR4TcUK5SMBqWoi0Sy3OB
         7a97UVYw7+Fy/frpPfryBxV8SK+EEK0bgWS9/l++w3IslTEe/Hj/T574gkZgH99n9TOu
         7YAh3m7yjaQT9Z5G218JddVsSgB+C8cBBQ5tHDQgpZhapTHt1JS3o+ebW4SQnxejIVfq
         bWbg==
X-Gm-Message-State: AOPr4FVvDr9SXBWej56+kQmZ49Nab8a1yiFJsuTl2yz5unmmXxQZmhBSmW1m0esXCZYFSQ==
X-Received: by 10.140.30.10 with SMTP id c10mr10323869qgc.87.1461787508596;
        Wed, 27 Apr 2016 13:05:08 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:07 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292805>

What's new:

1. configs for automatically populating the untracked-cache and
watchman extensions.

2. index-helper errors go to index-helper.log (index-helper redirects s=
tdout,
stderr)

3. Duy's "Add tracing to measure where most of the time is spent"

4. index-helper sends/receives watchman status (OK/NAK)

5. use packet_read infrastructure for communication with index-helper.

6. rearranged a tiny bit of code so two instances match up

I decided not to do the weird thing where we pass fds over the socket,
because the mailing list consensus was that it was maybe too weird.

David Turner (8):
  index-helper: log warnings
  unpack-trees: preserve index extensions
  watchman: add a config option to enable the extension
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run
  untracked-cache: config option

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  read-cache.c: fix constness of verify_hdr()
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  read-cache: add watchman 'WAMA' extension
  Add watchman support to reduce index refresh cost
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support
  Add tracing to measure where most of the time is spent

 .gitignore                               |   2 +
 Documentation/config.txt                 |  12 +
 Documentation/git-index-helper.txt       |  78 +++++
 Documentation/git-update-index.txt       |   6 +
 Documentation/technical/index-format.txt |  22 ++
 Makefile                                 |  18 ++
 builtin/gc.c                             |   2 +-
 builtin/update-index.c                   |  16 +
 cache.h                                  |  16 +-
 config.c                                 |   5 +
 configure.ac                             |   8 +
 daemon.c                                 |   2 +-
 diff-lib.c                               |   4 +
 dir.c                                    |  25 +-
 dir.h                                    |   6 +
 environment.c                            |   3 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 511 +++++++++++++++++++++++=
++++++
 name-hash.c                              |   2 +
 preload-index.c                          |   2 +
 read-cache.c                             | 533 +++++++++++++++++++++++=
+++++++-
 refs/files-backend.c                     |   2 +
 setup.c                                  |   4 +-
 t/t1701-watchman-extension.sh            |  37 +++
 t/t7063-status-untracked-cache.sh        |  22 ++
 t/t7900-index-helper.sh                  |  68 ++++
 t/test-lib-functions.sh                  |   4 +
 test-dump-watchman.c                     |  16 +
 unpack-trees.c                           |   1 +
 watchman-support.c                       | 135 ++++++++
 watchman-support.h                       |   7 +
 31 files changed, 1549 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 test-dump-watchman.c
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
