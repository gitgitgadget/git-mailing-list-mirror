From: David Turner <dturner@twopensource.com>
Subject: [PATCH 00/19] index-helper, watchman
Date: Wed,  9 Mar 2016 13:36:03 -0500
Message-ID: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:36:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiyN-00076L-9n
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678AbcCISgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:35 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35701 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbcCISgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:33 -0500
Received: by mail-qk0-f169.google.com with SMTP id o6so24102112qkc.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08WuMVvZyQlldeWXfevsQR6VSLZdkuX7TRVgF/p8vZo=;
        b=n+SS4qZ1vPoIwX6kzov9MfjyuU7+LF9z4LF2uJ8z4bq8qcDJMVCPzDFfhiDVuRa3iA
         lluhLZUB8wftyE04+cEtF6OZHE6eCCL+ScDIJHfXlixK8cOV1nLG+bAK58pDq1euLV9f
         BSjTdb9n4P6tHuJO1dKvkaW6Y2H362AnJtS1w7jFl5V+q0Z9sYtBhi+I7XezBr9CirLr
         Btm0L9WzQp/rnKqnF+LGs+hXPVjOaNR6EivshcKrMijSYrgrlxSTF5WlQJKkv5Koldcy
         89OPqaeYPgsIg/hopJUbURk1t1rBhiq8kSoxfURZvLCDqn5iAiEF1oOhrHBSI3zNRXT8
         y76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08WuMVvZyQlldeWXfevsQR6VSLZdkuX7TRVgF/p8vZo=;
        b=Wko4LbS4T40so795dUqX+bN2WR3zcIQqo4vw9i4AKbhMEGVhhGeoLpp9jOny3qQ7mA
         yRnuoOPrYeDKaUooS82zwlOjFP517TRJpM1MrhDp6YZ7ojTd+0uPB01fyz4dhza8qYiG
         XRi3sxsojTyu2PADv3F+boPa9z/7x/nECldsPqq3ehKLCW6sVtemEMcLLuU55Fgxv4SG
         GOm8YvE+B/ZHzeEO/ZAI16WOdkDVSswB8N3Ni6vHQumtzZpIPYYPsNsIlvpZoQDDugim
         XJBtgrL8AApF4nkNP6gc0yojkon62Xci0KwR4XM/oNqih3qqI7ynnx1yFJC9U3+6lJTt
         SpjA==
X-Gm-Message-State: AD7BkJJgJ8Kw3brnP35MQ73c/A8L7CC2nZgKgzvVb7+yCNijV79TZGl2lL8Hop0Zl3ed0A==
X-Received: by 10.55.81.87 with SMTP id f84mr44601742qkb.10.1457548592940;
        Wed, 09 Mar 2016 10:36:32 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:32 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288548>

This is a rebase and extension of Duy's work on git index-helper and
watchman support.

Patches 1-14 and are more-or-less just Duy's patches, rebased. I fixed
up a race condition with signal handling, but otherwise didn't change
much.

Patch 15 preserves the untracked cache and watchman extensions across
checkouts.

Patches 16-18 are new index-helper patches that I wrote to improve the
general usability of index-helper.

And patch 19 is for discussion only -- if the overall concept is
correct, I'll rewrite it into the places where it should go.  I didn't
do it yet in part because I am not sure folks will agree with it and
in part because I didn't want to mess too much with Duy's code before
re-sending it.

I haven't used this code much.  I just wrote patches 16-18 today, in
fact. It's got fewer tests than I would like, in part because it is
somewhat difficult to test since it involves two separate persistent
daemons (index-helper, watchman), and the interaction between them.

At Twitter, we're still using something based on my earlier watchman
patches[1].  We would like to switch to this (especially if this is
the version that mainstream git is going towards).  But we have other
local patches[2], and I haven't fully finished migrating them to 2.8.
My informal testing shows that with the untracked cache and watchman
index extensions, and git index-helper[3], performance is slightly
better than my earlier code.  That's not a surprise, since the
index-helper eliminates index verification time.

[1] https://github.com/dturner-tw/git/tree/dturner/watchman

[2] e.g. something like this:
https://github.com/dturner-tw/git/tree/dturner/journal

[3] In both cases, I'm using a version which has the SSE ref-parsing
and hashmap code; these were rejected due to complexity but they provid=
e
a benefit for us, so we still use them.

David Turner (5):
  unpack-trees: preserve index extensions
  index-helper: rewrite pidfile after daemonizing
  index-helper: process management
  index-helper: autorun
  hack: watchman/untracked cache mashup

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (14):
  trace.c: add GIT_TRACE_PACK_STATS for pack usage statistics
  read-cache.c: fix constness of verify_hdr()
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  trace.c: add GIT_TRACE_INDEX_STATS for index statistics
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  index-helper: add Windows support
  read-cache: add watchman 'WAMA' extension
  Add watchman support to reduce index refresh cost
  read-cache: allow index-helper to prepare shm before git reads it
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support

 .gitignore                         |   1 +
 Documentation/git-index-helper.txt |  56 +++++
 Documentation/git.txt              |   4 +
 Makefile                           |  21 ++
 builtin/gc.c                       |   2 +-
 builtin/update-index.c             |  11 +
 cache.h                            |  20 +-
 config.c                           |   5 +
 config.mak.uname                   |   3 +
 configure.ac                       |   8 +
 daemon.c                           |   2 +-
 dir.c                              |  23 +-
 dir.h                              |   6 +
 environment.c                      |   3 +
 git-compat-util.h                  |   1 +
 git.c                              |  37 +++-
 index-helper.c                     | 437 +++++++++++++++++++++++++++++=
+++++++
 read-cache.c                       | 441 +++++++++++++++++++++++++++++=
++++++--
 setup.c                            |   4 +-
 sha1_file.c                        |  24 ++
 shm.c                              | 163 ++++++++++++++
 shm.h                              |  23 ++
 t/t7063-status-untracked-cache.sh  |  23 ++
 t/t7900-index-helper.sh            |  23 ++
 t/test-lib-functions.sh            |   4 +
 trace.c                            |  16 ++
 trace.h                            |   1 +
 unpack-trees.c                     |   1 +
 watchman-support.c                 | 134 +++++++++++
 watchman-support.h                 |   7 +
 30 files changed, 1481 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
