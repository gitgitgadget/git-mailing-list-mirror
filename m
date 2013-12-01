From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/5] use starts_with() and ends_with()
Date: Sun, 01 Dec 2013 08:49:13 +0100
Message-ID: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 08:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn1no-0004Pp-UX
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 08:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936Ab3LAHu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 02:50:27 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:63746 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750843Ab3LAHu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 02:50:26 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id CD2F310B;
	Sun,  1 Dec 2013 08:50:03 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238579>

This is a new patch series along the lines Junio suggested in this
thread:

http://thread.gmane.org/gmane.comp.version-control.git/238054/

I send it now because I saw a 1.8.5 tag.

The patches in this series can be related to what Junio suggested
this way:

 * A set of clean-up patches to normalize oddball usages of existing
   functions (e.g. normalize 'prefixcmp(a,b) != 0' in some file(s)
   to 'prefixcmp(a,b)');

-> Patches 1/5 and 2/5 are such kind of cleanups.

 * A single patch to introduce the new function(s), to be applied on
   top of 1.8.5;

-> Patch 3/5 does that.

 * A large patch to convert all uses of prefixcmp to starts_with and
   suffixcmp to ends_with in the 1.8.5 codebase;

-> Patch 4/5 does that.

 * A patch for each topic in flight to convert newly introduced
   prefixcmp/suffixcmp to starts_with/ends_with, to be applied after
   the topic graduates to 'master' after 1.8.5; and then finally

-> I didn't start to work on that yet. I hope that I will only need
   to take care of what is going on in 'next'.

 * A separate patch to remove prefixcmp and suffixcmp, to be applied
   after _all_ in-flight topic has graduated to 'master'.

-> Patch 5/5 does that.


Christian Couder (5):
  environment: normalize use of prefixcmp() by removing " != 0"
  builtin/remote: remove postfixcmp() and use suffixcmp() instead
  strbuf: introduce starts_with() and ends_with()
  Replace {pre,suf}fixcmp() with {starts,ends}_with()
  strbuf: remove prefixcmp() and suffixcmp()

 alias.c                   |  2 +-
 attr.c                    |  2 +-
 bisect.c                  |  4 +--
 branch.c                  |  4 +--
 builtin/apply.c           | 12 +++----
 builtin/archive.c         |  4 +--
 builtin/branch.c          |  6 ++--
 builtin/checkout.c        |  8 ++---
 builtin/clean.c           |  4 +--
 builtin/clone.c           |  8 ++---
 builtin/column.c          |  2 +-
 builtin/commit.c          | 10 +++---
 builtin/describe.c        |  2 +-
 builtin/fast-export.c     |  2 +-
 builtin/fetch-pack.c      |  6 ++--
 builtin/fetch.c           | 18 +++++------
 builtin/fmt-merge-msg.c   | 10 +++---
 builtin/for-each-ref.c    | 14 ++++-----
 builtin/fsck.c            |  6 ++--
 builtin/help.c            |  8 ++---
 builtin/index-pack.c      |  8 ++---
 builtin/init-db.c         |  2 +-
 builtin/log.c             |  8 ++---
 builtin/ls-remote.c       |  4 +--
 builtin/mailinfo.c        | 16 +++++-----
 builtin/merge-recursive.c |  4 +--
 builtin/merge.c           | 12 +++----
 builtin/name-rev.c        |  6 ++--
 builtin/notes.c           |  2 +-
 builtin/pack-objects.c    |  2 +-
 builtin/prune.c           |  4 +--
 builtin/receive-pack.c    |  6 ++--
 builtin/reflog.c          |  4 +--
 builtin/remote.c          | 22 +++++--------
 builtin/repack.c          |  2 +-
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
 connected.c               |  2 +-
 convert.c                 |  2 +-
 daemon.c                  | 40 ++++++++++++------------
 diff.c                    | 56 ++++++++++++++++-----------------
 environment.c             |  2 +-
 fast-import.c             | 80 +++++++++++++++++++++++------------------------
 fetch-pack.c              | 12 +++----
 git-compat-util.h         |  4 +--
 git.c                     | 12 +++----
 help.c                    |  8 ++---
 http-backend.c            |  4 +--
 http-push.c               |  4 +--
 http.c                    | 10 +++---
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
 strbuf.c                  | 12 +++----
 submodule.c               |  2 +-
 tag.c                     | 10 +++---
 test-line-buffer.c        |  6 ++--
 test-string-list.c        |  2 +-
 transport-helper.c        | 16 +++++-----
 transport.c               | 28 ++++++++---------
 upload-pack.c             | 10 +++---
 vcs-svn/fast_export.c     | 11 +------
 wt-status.c               | 16 +++++-----
 92 files changed, 469 insertions(+), 486 deletions(-)

-- 
1.8.4.1.561.g12affca
