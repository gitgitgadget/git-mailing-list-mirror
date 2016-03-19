From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 00/15] index-helper, watchman
Date: Fri, 18 Mar 2016 21:04:33 -0400
Message-ID: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:06:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5LG-0008Bc-I7
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbcCSBGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:06:07 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35856 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcCSBGF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:06:05 -0400
Received: by mail-qg0-f51.google.com with SMTP id u110so114609741qge.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmk4zNxYagts0kvcun+nAP28HyP0AhrJYqEjxILu6LE=;
        b=qBWq/3YXSNuFpTRd30kCEmodEts8kZvWmX2jSNgGr/a2Y6nRstrDQeJNX5tQLRhwrC
         jN8kdQzUVevaPnOGNYQLrZquHI4t6NH0kmVsSUw92rShj5A/imhAMR7VG4+FpUCOxcAh
         Ezv3OTcU98/I8a9Y7/uWf3VrbPuYb45ekJR9fOMxhpqhDI7KECBBOJ95a+ptIEVGJzhZ
         dUjVxSMVGk/VzihSfA71lg0qg17tOQX+oU8MkBBBIs3Nj6WiyxzEEEX16DfxM9Ljx9VH
         kVQ7ckUmk3iYUGFN2bxyQvz0y69foTywe64QBKpZyeOhiqYK1VTMaJIl7zgWUvVqJCOo
         vJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmk4zNxYagts0kvcun+nAP28HyP0AhrJYqEjxILu6LE=;
        b=N/xAMD7nDbkSeYzcl7U1qVnTt3Y4kvKOF1KpBE4/r/kyxwKshoXSyBsCXGFVEvaHIT
         qbDc6UHIqHTUqiX5etkPPD6Gr29n5Kq//hmvOlQsaR0Z02jAb1cEiH1i6AnP46R+v4rC
         0/Un8OqAIOTyrd6FxwsJYuUENH5kgxdDgb5KKLLZM3T56/8Rb3PMRBsEBolx8nZbPN7L
         3pCLEw7YZtkw76MzWUewZxn1F118czRcz1vqTibfbwNUNH0+2V/8oYScRwO3fx1D7G1L
         QfzBNlP3TVLwKR7epbHO8S8UzXdjtjNnvRv0+sGzMJvu1lE0MtWuO+Q//eazoGlxnX+0
         +kWg==
X-Gm-Message-State: AD7BkJK/gTcXva9h9u0OKokZHkCzp8N+EFirdFX/MJ5pP0gptWZB2tVxuJq2Q4iPEpk/vw==
X-Received: by 10.140.218.139 with SMTP id o133mr27750657qhb.33.1458349563682;
        Fri, 18 Mar 2016 18:06:03 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.06.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:06:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289269>

In this version:

I removed the statistics since they're not really a core part of the
series and we can always add them later.

I added a little more testing.

I merged the untracked cache/watchman mashup into the relevant
patches.  Hopefully I didn't screw it up -- I got into the rebase
weeds here and took a while to get out.  I wish I were better at
rebasing.

I moved the index-helper to a named-pipe based IPC mechanism instead
of a signal-based one.  I don't actualy know much about named pipes
other than what I learned while writing this, so someone with clue
should probably take a peek.

The index-helper pid files was kind of a hassle -- there was a
lot of mechanism involved in making sure that they were in fact
pointing to a live index-helper process.  With named pipes, we don't
really need them: if a live index-helper is running, it can simply be
instructed to die, and if it's not, then the pipe can be safely
removed and a new index-helper started.

Because there is no longer a pid file for index-helper, index-helper
has no way to let git know that it should wait for a watchman update
reply when poked.  I worked around this by making the waiting
configurable, and giving a sensible default.  Note that in the
no-watchman case, the wait will be short even if misconfigured,
because the daemon can immediately send an "OK" message.

I updated some commit messages, following Junio and Duy's suggestions.

Johannes Schindelin said that he would work on the Windows side, so
I've dropped the Windows bits (including one patch).  Since I don't
know anything about Windows, it's probably for the best that I'm not
coding for it.

I eliminated the ability to start up an index-helper when there was
already one running because I don't see why you would want to do that,
and because it would lead to multiple readers on the same named pipe,
which has undefined behavior.  Just kill the old one if you're done
with it.

David Turner (7):
  read-cache: invalidate untracked cache data when reading WAMA
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
 Documentation/git-index-helper.txt |  64 ++++++
 Makefile                           |  21 ++
 builtin/gc.c                       |   2 +-
 builtin/update-index.c             |  11 +
 cache.h                            |  18 +-
 config.c                           |  10 +
 config.mak.uname                   |   1 +
 configure.ac                       |   8 +
 daemon.c                           |   2 +-
 dir.c                              |  23 +-
 dir.h                              |   6 +
 environment.c                      |   8 +
 git-compat-util.h                  |   1 +
 git.c                              |  35 ++-
 index-helper.c                     | 439 +++++++++++++++++++++++++++++=
++++++
 read-cache.c                       | 455 +++++++++++++++++++++++++++++=
++++++--
 setup.c                            |   4 +-
 shm.c                              |  67 ++++++
 shm.h                              |  23 ++
 t/t7063-status-untracked-cache.sh  |  23 ++
 t/t7900-index-helper.sh            |  60 +++++
 t/test-lib-functions.sh            |   4 +
 unpack-trees.c                     |   1 +
 watchman-support.c                 | 134 +++++++++++
 watchman-support.h                 |   7 +
 26 files changed, 1406 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
