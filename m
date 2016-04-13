From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 00/16] index-helper, watchman
Date: Tue, 12 Apr 2016 20:32:53 -0400
Message-ID: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kW-0002jC-5m
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916AbcDMAda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:33:30 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34069 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758906AbcDMAd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:26 -0400
Received: by mail-qk0-f181.google.com with SMTP id r184so13614739qkc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oD23vzorr6YE54k+nYYfS3H/mnjL1x1KjDXVU9OMNUo=;
        b=bYsZ1O8neiCWY5WivXJKkDKUkN3eGbPf9Gn5wQRnBf9i6Yqr0h0/ZPVqv+l8Q+r4SE
         Ht+zwbNlxvaKiUn9hC1EedT5uMft1NNXo54ogfE2nejPB7IBh5nVaH2GDOq+IJcttUbs
         EregbfEEzJuTwzpyfu/GYSw1AezAXPojnPS7KIgaT/ImO61Z5uay9zp5rwfti5nYsLBY
         JRqOmw/nSiM6KZDvJAWSPfJu8xab2OdGFhp33q5fOo8+vxp3Gfp7VHYi3gAV0a4Ya1We
         SnP8raQHgT24yL+1LYVi0FHBuwMr7dw20Z/7+Dklwr1swACgbRIyKFJ/wGZIdhj9Kn2O
         qpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oD23vzorr6YE54k+nYYfS3H/mnjL1x1KjDXVU9OMNUo=;
        b=WfkNSViA+oJNgz03YiAGaC4gucTSwdWcCxFMqh4ujqPR5v9Z7FkwSg/X4MDmM6Q5b6
         UX52cF6kjYMa5fkJWinCgaeqXeKc8UqTI1z1T6Brd5UOtsGCk4W0jC7dlc8WUmC6qnb3
         n7xTEA50+e44TkdoktGV36rqMt1G4gwi/8ZC/KwmAEGHEzRyePkIPZOAdJmatWhE0uv4
         5Vuzb0U/a7zf9DQRtGNsobYPBZJmM0AQKF5q1uSE8La1SwZ+dA54KpnZqS+jPrGD45Nw
         bpmsRdFNuQBe+IFi3WFsiyWC1sHMlCNeV47JKoUAq1fRyTf/hoVCtYA1lY40vTLhBhbf
         EvvA==
X-Gm-Message-State: AOPr4FWh6irWDey2zx9Hq8WuAzSAR+RuPVn1jEqnyW2mRB3FEY/onZYzVkp2vsrWoUVZ+Q==
X-Received: by 10.55.81.3 with SMTP id f3mr7374421qkb.35.1460507600184;
        Tue, 12 Apr 2016 17:33:20 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291343>

This version has been tested on OS X and Linux.  It switches from
POSIX-Realtime shm to plain old mmap.  Thanks to JI for this
suggestion.

This version incorporates a couple of fixes from Ramsay Jones.

There might be a couple of minor spelling/grammar fixes too.

David Turner (6):
  unpack-trees: preserve index extensions
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run
  read-cache: config for waiting for index-helper

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
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

 .gitignore                         |   1 +
 Documentation/config.txt           |  10 +
 Documentation/git-index-helper.txt |  66 +++++
 Makefile                           |  17 ++
 builtin/gc.c                       |   2 +-
 builtin/update-index.c             |  11 +
 cache.h                            |  23 +-
 config.c                           |  10 +
 configure.ac                       |   8 +
 daemon.c                           |   2 +-
 dir.c                              |  23 +-
 dir.h                              |   6 +
 environment.c                      |   8 +
 git-compat-util.h                  |  18 ++
 git.c                              |  35 ++-
 index-helper.c                     | 534 +++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       | 520 +++++++++++++++++++++++++++++=
++++++-
 setup.c                            |   4 +-
 t/t7063-status-untracked-cache.sh  |  22 ++
 t/t7900-index-helper.sh            |  68 +++++
 t/test-lib-functions.sh            |   4 +
 unpack-trees.c                     |   1 +
 watchman-support.c                 | 135 ++++++++++
 watchman-support.h                 |   7 +
 24 files changed, 1513 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
