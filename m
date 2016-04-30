From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 00/19] index-helper/watchman
Date: Fri, 29 Apr 2016 21:01:54 -0400
Message-ID: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:02:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJIi-0007ny-U2
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbcD3BCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 21:02:25 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34649 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcD3BCX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:23 -0400
Received: by mail-qg0-f44.google.com with SMTP id 90so34034396qgz.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiZ8Ws488J1ueQk7tGsAxXTh17SMURPq9PRGyT6rY6M=;
        b=ohY+pqfIm1eur9ZtAvSef7MAXAQ0PcagHrqaODsCxylj9NYfXI6pGoYtuLJoU+ToCO
         M1ijSPHPjddnmi2Kz9e2CRb3rWtkgIKA4dDrVrQZloPykRykdt14VJ2FCVR8c13DbQZ3
         4+ZZr+ZiEqnHNlAtgRfNX7EL0UFR3lmmnbZqsOLNCyShDCN5gK/7Rg3in2ItN+2pKgzn
         em+j8uBzZfSZgFLnXOWOAhCb5Li9mI57GngTPyEbmUmhD78eqExXAXkJp+58eOZL22y8
         RjdDi+W/D3h3VF3/nTn6eWBn9SaF7ajSXQbTwmSNB02UlOqTuatwaBIo/2fcgEmD744i
         KL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiZ8Ws488J1ueQk7tGsAxXTh17SMURPq9PRGyT6rY6M=;
        b=YgCNKZMhf1fw4h41gz9Etgc1o16Okp515Wr9qlNmZtZdyhIo66kVvzE4r4f+Bompnh
         d/1F5P707D1iyk8YIK8DfwkSSjZ8Mk2coB6NQrP1E94GJSENQ0nZon1z8cn3gF2v06V4
         M7muH9nP8bY5Ruhs+cOoYEHqH4UaQBC83CV0rtBMTQTn5Vp6+vlwQ95OUSK7+G+4qNhW
         pP8hlHMjecBdRgCMgUfbqJFXBI+Jo5mHvwNypcjn+9ZoCQyOdujSD6EdBxee28Fs9sH+
         pdHio1p9P+BbS2mu3JYuGnt7SilbZRbxFUhdMnYboCSklSf2NNPJaZDunQeF0IoxVNGF
         mmXA==
X-Gm-Message-State: AOPr4FVf+/0WGtwT5H7G3vr7rnLwo87hImwYegF/WiSLVm8VGI2u/UchYlrVHl3j/KNBJA==
X-Received: by 10.140.40.99 with SMTP id w90mr9651898qgw.42.1461978142994;
        Fri, 29 Apr 2016 18:02:22 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293099>

This version addresses Junio's comments on v6 -- primarily on 03/19, bu=
t
with spillover to 05/19 and 10/19.

* Added some docs on struct fields
* Misc doc and commit message cleanups
* Replaced select with poll
* Removed some parameters from shared_mmap_create
* Slight error handling improvement

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
 Documentation/git-index-helper.txt       |  81 +++++
 Documentation/git-update-index.txt       |   6 +
 Documentation/technical/index-format.txt |  22 ++
 Makefile                                 |  18 ++
 builtin/gc.c                             |   2 +-
 builtin/update-index.c                   |  16 +
 cache.h                                  |  25 +-
 config.c                                 |   5 +
 configure.ac                             |   8 +
 daemon.c                                 |   2 +-
 diff-lib.c                               |   4 +
 dir.c                                    |  25 +-
 dir.h                                    |   6 +
 environment.c                            |   3 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 503 +++++++++++++++++++++++=
++++++
 name-hash.c                              |   2 +
 preload-index.c                          |   2 +
 read-cache.c                             | 532 +++++++++++++++++++++++=
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
 31 files changed, 1552 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 test-dump-watchman.c
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
