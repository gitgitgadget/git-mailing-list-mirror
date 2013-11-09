From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Sat, 09 Nov 2013 08:05:53 +0100
Message-ID: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hb-0005PQ-95
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231Ab3KIHIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:25 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36245 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932264Ab3KIHIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 5DAB693;
	Sat,  9 Nov 2013 08:08:17 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237532>

Here is a big patch series to replace prefixcmp() with a new
has_prefix() function.

So the first patch of this series introduces has_prefix()
and the last patch removes prefixcmp().

Except in a few cases, I used a script that does basically
the following to generate the commits in between:

===
#!/bin/bash

perl -pi -e 's/!prefixcmp\(/has_prefix\(/g' "$1"
perl -pi -e 's/prefixcmp\(/!has_prefix\(/g' "$1"

git commit -m "$1: replace prefixcmd() with has_prefix()" "$1"
===

The few special cases are the following ones:

        - remote*: replace prefixcmd() with has_prefix()
        - transport*: replace prefixcmd() with has_prefix()
        - environment: replace prefixcmd() with has_prefix()

In first 2 cases above, I processed a few files at the same
time instead of just one.

In the case of "environment", I removed " != 0" after
"!has_prefix(...)" as it is not necessary and makes it
more difficult to understand the logic.

Of course it's possible to squash many of the commits
together if it is prefered.

Christian Couder (86):
  strbuf: add has_prefix() to be used instead of prefixcmp()
  diff: replace prefixcmd() with has_prefix()
  fast-import: replace prefixcmd() with has_prefix()
  remote*: replace prefixcmd() with has_prefix()
  daemon: replace prefixcmd() with has_prefix()
  pretty: replace prefixcmd() with has_prefix()
  revision: replace prefixcmd() with has_prefix()
  transport*: replace prefixcmd() with has_prefix()
  config: replace prefixcmd() with has_prefix()
  sha1_name: replace prefixcmd() with has_prefix()
  wt-status: replace prefixcmd() with has_prefix()
  upload-pack: replace prefixcmd() with has_prefix()
  test-line-buffer: replace prefixcmd() with has_prefix()
  parse-options: replace prefixcmd() with has_prefix()
  fetch-pack: replace prefixcmd() with has_prefix()
  git: replace prefixcmd() with has_prefix()
  tag: replace prefixcmd() with has_prefix()
  sequencer: replace prefixcmd() with has_prefix()
  commit: replace prefixcmd() with has_prefix()
  http: replace prefixcmd() with has_prefix()
  imap-send: replace prefixcmd() with has_prefix()
  help: replace prefixcmd() with has_prefix()
  log-tree: replace prefixcmd() with has_prefix()
  merge-recursive: replace prefixcmd() with has_prefix()
  notes: replace prefixcmd() with has_prefix()
  refs: replace prefixcmd() with has_prefix()
  setup: replace prefixcmd() with has_prefix()
  bisect: replace prefixcmd() with has_prefix()
  branch: replace prefixcmd() with has_prefix()
  http-push: replace prefixcmd() with has_prefix()
  send-pack: replace prefixcmd() with has_prefix()
  http-backend: replace prefixcmd() with has_prefix()
  notes-utils: replace prefixcmd() with has_prefix()
  pkt-line: replace prefixcmd() with has_prefix()
  alias: replace prefixcmd() with has_prefix()
  attr: replace prefixcmd() with has_prefix()
  connect: replace prefixcmd() with has_prefix()
  pager: replace prefixcmd() with has_prefix()
  convert: replace prefixcmd() with has_prefix()
  environment: replace prefixcmd() with has_prefix()
  shell: replace prefixcmd() with has_prefix()
  pathspec: replace prefixcmd() with has_prefix()
  submodule: replace prefixcmd() with has_prefix()
  test-string-list: replace prefixcmd() with has_prefix()
  builtin/apply: replace prefixcmd() with has_prefix()
  builtin/archive: replace prefixcmd() with has_prefix()
  builtin/branch: replace prefixcmd() with has_prefix()
  builtin/checkout: replace prefixcmd() with has_prefix()
  builtin/clean: replace prefixcmd() with has_prefix()
  builtin/clone: replace prefixcmd() with has_prefix()
  builtin/column: replace prefixcmd() with has_prefix()
  builtin/commit: replace prefixcmd() with has_prefix()
  builtin/describe: replace prefixcmd() with has_prefix()
  builtin/fast-export: replace prefixcmd() with has_prefix()
  builtin/fetch-pack: replace prefixcmd() with has_prefix()
  builtin/fetch: replace prefixcmd() with has_prefix()
  builtin/fmt-merge-msg: replace prefixcmd() with has_prefix()
  builtin/for-each-ref: replace prefixcmd() with has_prefix()
  builtin/fsck: replace prefixcmd() with has_prefix()
  builtin/help: replace prefixcmd() with has_prefix()
  builtin/index-pack: replace prefixcmd() with has_prefix()
  builtin/init-db: replace prefixcmd() with has_prefix()
  builtin/log: replace prefixcmd() with has_prefix()
  builtin/ls-remote: replace prefixcmd() with has_prefix()
  builtin/mailinfo: replace prefixcmd() with has_prefix()
  builtin/merge-recursive: replace prefixcmd() with has_prefix()
  builtin/merge: replace prefixcmd() with has_prefix()
  builtin/name-rev: replace prefixcmd() with has_prefix()
  builtin/notes: replace prefixcmd() with has_prefix()
  builtin/pack-objects: replace prefixcmd() with has_prefix()
  builtin/prune: replace prefixcmd() with has_prefix()
  builtin/receive-pack: replace prefixcmd() with has_prefix()
  builtin/reflog: replace prefixcmd() with has_prefix()
  builtin/remote: replace prefixcmd() with has_prefix()
  builtin/rev-parse: replace prefixcmd() with has_prefix()
  builtin/send-pack: replace prefixcmd() with has_prefix()
  builtin/shortlog: replace prefixcmd() with has_prefix()
  builtin/show-branch: replace prefixcmd() with has_prefix()
  builtin/show-ref: replace prefixcmd() with has_prefix()
  builtin/symbolic-ref: replace prefixcmd() with has_prefix()
  builtin/tag: replace prefixcmd() with has_prefix()
  builtin/tar-tree: replace prefixcmd() with has_prefix()
  builtin/unpack-objects: replace prefixcmd() with has_prefix()
  builtin/update-ref: replace prefixcmd() with has_prefix()
  builtin/upload-archive: replace prefixcmd() with has_prefix()
  strbuf: remove prefixcmp() as it has been replaced with has_prefix()

 alias.c                   |  2 +-
 attr.c                    |  2 +-
 bisect.c                  |  4 +--
 branch.c                  |  4 +--
 builtin/apply.c           | 12 +++----
 builtin/archive.c         |  4 +--
 builtin/branch.c          |  6 ++--
 builtin/checkout.c        |  8 ++---
 builtin/clean.c           |  4 +--
 builtin/clone.c           |  6 ++--
 builtin/column.c          |  2 +-
 builtin/commit.c          | 10 +++---
 builtin/describe.c        |  2 +-
 builtin/fast-export.c     |  2 +-
 builtin/fetch-pack.c      |  6 ++--
 builtin/fetch.c           | 16 +++++-----
 builtin/fmt-merge-msg.c   | 10 +++---
 builtin/for-each-ref.c    | 14 ++++-----
 builtin/fsck.c            |  6 ++--
 builtin/help.c            |  8 ++---
 builtin/index-pack.c      |  8 ++---
 builtin/init-db.c         |  2 +-
 builtin/log.c             |  8 ++---
 builtin/ls-remote.c       |  4 +--
 builtin/mailinfo.c        | 16 +++++-----
 builtin/merge-recursive.c |  2 +-
 builtin/merge.c           | 12 +++----
 builtin/name-rev.c        |  6 ++--
 builtin/notes.c           |  2 +-
 builtin/pack-objects.c    |  2 +-
 builtin/prune.c           |  4 +--
 builtin/receive-pack.c    |  6 ++--
 builtin/reflog.c          |  4 +--
 builtin/remote.c          |  8 ++---
 builtin/rev-parse.c       | 24 +++++++-------
 builtin/send-pack.c       |  8 ++---
 builtin/shortlog.c        |  6 ++--
 builtin/show-branch.c     | 20 ++++++------
 builtin/show-ref.c        |  6 ++--
 builtin/symbolic-ref.c    |  2 +-
 builtin/tag.c             |  2 +-
 builtin/tar-tree.c        |  2 +-
 builtin/unpack-objects.c  |  2 +-
 builtin/update-ref.c      | 10 +++---
 builtin/upload-archive.c  |  2 +-
 commit.c                  |  6 ++--
 config.c                  | 16 +++++-----
 connect.c                 |  2 +-
 convert.c                 |  2 +-
 daemon.c                  | 40 ++++++++++++------------
 diff.c                    | 56 ++++++++++++++++-----------------
 environment.c             |  2 +-
 fast-import.c             | 80 +++++++++++++++++++++++------------------------
 fetch-pack.c              | 12 +++----
 git-compat-util.h         |  2 +-
 git.c                     | 12 +++----
 help.c                    |  8 ++---
 http-backend.c            |  4 +--
 http-push.c               |  4 +--
 http.c                    |  8 ++---
 imap-send.c               | 10 +++---
 log-tree.c                |  8 ++---
 merge-recursive.c         |  6 ++--
 notes-utils.c             |  4 +--
 notes.c                   |  8 ++---
 pager.c                   |  2 +-
 parse-options.c           | 12 +++----
 pathspec.c                |  2 +-
 pkt-line.c                |  4 +--
 pretty.c                  | 36 ++++++++++-----------
 refs.c                    | 30 +++++++++---------
 remote-curl.c             | 14 ++++-----
 remote-testsvn.c          | 10 +++---
 remote.c                  | 46 +++++++++++++--------------
 revision.c                | 38 +++++++++++-----------
 send-pack.c               |  4 +--
 sequencer.c               |  8 ++---
 setup.c                   |  4 +--
 sha1_name.c               | 16 +++++-----
 shell.c                   |  2 +-
 strbuf.c                  |  6 ++--
 submodule.c               |  2 +-
 tag.c                     | 10 +++---
 test-line-buffer.c        |  6 ++--
 test-string-list.c        |  2 +-
 transport-helper.c        | 16 +++++-----
 transport.c               | 28 ++++++++---------
 upload-pack.c             | 10 +++---
 wt-status.c               | 16 +++++-----
 89 files changed, 455 insertions(+), 455 deletions(-)

-- 
1.8.4.1.566.geca833c
