From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 00/16] index-helper, watchman
Date: Wed,  6 Apr 2016 18:11:46 -0400
Message-ID: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:12:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvgo-0004h6-1W
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbcDFWMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:37 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33415 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbcDFWMg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:36 -0400
Received: by mail-qg0-f52.google.com with SMTP id j35so48391068qge.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lo/wh76HE3dvoX1EWY3DH9erLLmxChOU3AjsQEhsvYA=;
        b=Ekko2J0ASjr9W75ldPfNqWGC0YMza6GkdjFf9M1NGb9VOeFG9m0v6RRFccYgRFj23i
         vENXKxQg4EQ9nsKiniTnvyB/7Sy5Hqy4W6J6Fb94P3QI4f43dE4rxFaJLAEWe7sh2E6K
         MNey6MdpeW7rVZ0RHR6LNeYDULPWJhi3cWmwwv3Qv+cbEA81cl68+4hAo+Nw/rV6Yp6E
         q8/+rK6CgMgnJXxFnPEZ0IazrR/s52dMDvZMV4QBYXZ+snbUs6f8aELOr1N1xnIC7oKH
         PELMTAmQ+AMzLr9buvg3GiyoZ1Rshdr81qya2Zfbk6eBJbH2zK3U4T31Fcn4ysluOhrW
         3S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lo/wh76HE3dvoX1EWY3DH9erLLmxChOU3AjsQEhsvYA=;
        b=d2jrppSBsnNsJBvJz7UWLwonmJtrNdasdi4RBQFoar7nuKHQEyh4I5DNpf/IEX5XYu
         VQe6MGnGmB+P7Xce5UG2CuAJuTvdyWU1s/k3fbbebzQO47I1PsX6VKQDgEL3bf3NTRys
         4/d2W/q2/arrs6nqFDLDpeWH3YLiERXnDLJYoKROzBMZ1oik9ushBurNXoN2la350UFa
         d0T0FYtw+qaYBk0a+Zj/EhrsMrIAGLD7tj1qdd9VoBlGdvxTXyP8IXYB4MRIQGNxVRf6
         s5L2tlQB3GdP/6d2oOjTuQPsGlPcwwLZPFD/e1BXbRg2BKf73uC0HQP1A2fab4c0ViXS
         ZLjQ==
X-Gm-Message-State: AD7BkJKJ8b0TzfT45TJ9q7Ikm9cfoK3MokgZreBa12F425TvJ/7qBcd/9SCyMMg/bI2szA==
X-Received: by 10.140.225.6 with SMTP id v6mr8970057qhb.0.1459980754818;
        Wed, 06 Apr 2016 15:12:34 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290873>

The major change here is to switch from named pipes to sockets.  But so=
mehow
while doing this, I noticed a few other things (and others noticed some=
 too):

=46ixed bugs in successful write testing
Added a bit more doco
Improved tests slightly
Memory barriers
=2Egit vs .git/ from watchman
one patch moved/squashed at Duy's suggestion
(some of?) my spelling errors corrected

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
 Documentation/git-index-helper.txt |  64 +++++
 Makefile                           |  22 ++
 builtin/gc.c                       |   2 +-
 builtin/update-index.c             |  11 +
 cache.h                            |  23 +-
 config.c                           |  10 +
 config.mak.uname                   |   1 +
 configure.ac                       |   8 +
 daemon.c                           |   2 +-
 dir.c                              |  23 +-
 dir.h                              |   6 +
 environment.c                      |   8 +
 git-compat-util.h                  |  18 ++
 git.c                              |  35 ++-
 index-helper.c                     | 462 +++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       | 438 +++++++++++++++++++++++++++++=
++++--
 setup.c                            |   4 +-
 shm.c                              |  67 ++++++
 shm.h                              |  23 ++
 t/t7063-status-untracked-cache.sh  |  22 ++
 t/t7900-index-helper.sh            |  69 ++++++
 t/test-lib-functions.sh            |   4 +
 unpack-trees.c                     |   1 +
 watchman-support.c                 | 135 +++++++++++
 watchman-support.h                 |   7 +
 27 files changed, 1454 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
