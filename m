From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 0/8] Antique UTF-8 filename support
Date: Wed, 13 May 2009 00:50:23 +0200
Message-ID: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40oI-0000Sx-FZ
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZELWuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:50:40 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbZELWuj
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:50:39 -0400
Received: from mail.dewire.com ([83.140.172.130]:19383 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbZELWuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8B274145A594;
	Wed, 13 May 2009 00:50:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nzh8lva8f26a; Wed, 13 May 2009 00:50:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 6602A145A584;
	Wed, 13 May 2009 00:50:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118962>

=46rom: Robin Rosenberg <robin.rosenberg@gmail.com>

Since there is some interest in the topic, now, I can republish my old =
2 =C2=BD year old
patches so there is some real code to comment on. They apply on top of
6dcfa306f2b67b733a7eb2d7ded1bc9987809edb, For completness I send
all patches, but the interesing stuff is in patch 4 and 5. Beware of en=
coding
issues with the test cases.

They do not handle Windows UTF-16 at all, but I think that is just a ma=
tter of writing
windows specifc wrappers for the filename and directory handling routin=
es.

=46eel free to rewamp and steal ideas and add constructive criticism. D=
on't even=20
think of cherry-picking and rebasing, It's careful handpicking with cop=
y/paste at=20
best, but mostly it's fuel for discussions.

I'd admit some parts are quite kludgy and probably slow. as I was prima=
rily=20
interested to see if it was even feasible, which it was. however there =
was simply
no interest, which meant there was no point in optimizing it. It was si=
mply the
wrong problem at the time.

Disclaimer: A problem with this approach is that, although it does char=
acter
conversion, if you are on a non-UTF-8 locale it will not let you mange
any repository. That is basically impossible and hence not the goal. It=
 does
help people with the same (or close) languages to cooperate without enf=
orcing
a common encoding as long as stick to the common characters, i.e. the o=
nes
that can be converted between the locales involved.

This is probably the most out-dated patch series ever.=20

-- robin

Robin Rosenberg (8):
(mostly obsolete)
  UTF helpers
  Messages in locale.
  Extend tests to cover locale wrt to commit messages.

The interesing stuff (patch 4 & 5)
  UTF file names.
  Extend all tests to work on UTF-8 filenames.

old wip
  test of utf_locallinks
  Convert symlink dest in diff
  UTF-8 in non-SHA1-objects

 Makefile                            |    8 +-
 builtin-add.c                       |    5 +-
 builtin-cat-file.c                  |    6 +-
 builtin-checkout-index.c            |   46 +++-
 builtin-commit-tree.c               |    9 +-
 builtin-ls-files.c                  |   26 ++-
 builtin-ls-tree.c                   |   16 +-
 builtin-rev-parse.c                 |    7 +-
 builtin-update-index.c              |   18 +-
 builtin-write-tree.c                |    5 +-
 diff.c                              |  111 ++++++--
 dir.c                               |   22 +-
 git-commit.sh                       |    5 +
 git-compat-util.h                   |   43 +++
 git-rebase.sh                       |    1 +
 git.c                               |    9 +
 log-tree.c                          |    4 +-
 merge-index.c                       |   25 ++-
 read-cache.c                        |    8 +-
 refs.c                              |   11 +-
 setup.c                             |   28 ++-
 t/lib-read-tree-m-3way.sh           |   38 ++--
 t/t-utf-filenames.sh                |   95 +++++++
 t/t-utf-msg.sh                      |   43 +++
 t/t0000-basic.sh                    |  117 ++++----
 t/t0010-racy-git.sh                 |   10 +-
 t/t1000-read-tree-m-3way.sh         |  240 +++++++++---------
 t/t1001-read-tree-m-2way.sh         |   56 ++--
 t/t1020-subdirectory.sh             |   63 +++---
 t/t1100-commit-tree-options.sh      |   12 +-
 t/t1400-update-ref.sh               |   10 +-
 t/t2000-checkout-cache-clash.sh     |   18 +-
 t/t2001-checkout-cache-clash.sh     |   30 +-
 t/t2002-checkout-cache-u.sh         |    8 +-
 t/t2003-checkout-cache-mkdir.sh     |  118 ++++----
 t/t2004-checkout-cache-temp.sh      |  144 +++++-----
 t/t2100-update-cache-badpath.sh     |   48 ++--
 t/t2101-update-index-reupdate.sh    |   56 ++--
 t/t3000-ls-files-others.sh          |   36 ++--
 t/t3002-ls-files-dashpath.sh        |   24 +-
 t/t3010-ls-files-killed-modified.sh |  104 ++++----
 t/t3020-ls-files-error-unmatch.sh   |   10 +-
 t/t3100-ls-tree-restrict.sh         |  122 +++++-----
 t/t3101-ls-tree-dirname.sh          |   88 +++---
 t/t3400-rebase.sh                   |   18 +-
 t/t3401-rebase-partial.sh           |   24 +-
 t/t3402-rebase-merge.sh             |   17 +-
 t/t3403-rebase-skip.sh              |   10 +-
 t/t3500-cherry.sh                   |   26 +-
 t/t3600-rm.sh                       |   28 +-
 t/t3700-add.sh                      |   30 +-
 t/t4000-diff-format.sh              |   26 +-
 t/t4001-diff-rename.sh              |   20 +-
 t/t4002-diff-basic.sh               |  160 ++++++------
 t/t4003-diff-rename-1.sh            |   66 +++---
 t/t4004-diff-rename-symlink.sh      |   40 ++--
 t/t4005-diff-rename-2.sh            |   54 ++--
 t/t4006-diff-mode.sh                |   14 +-
 t/t4008-diff-break-rewrite.sh       |  100 ++++----
 t/t4009-diff-rename-4.sh            |   63 +++---
 t/t4011-diff-symlink.sh             |   38 ++--
 t/t4012-diff-binary.sh              |   16 +-
 t/t7301-rev-parse.sh                |   20 ++
 t/test-lib.sh                       |   13 +-
 test-utf.c                          |   61 +++++
 utf.c                               |  501 +++++++++++++++++++++++++++=
++++++++
 utf.h                               |   27 ++
 67 files changed, 2133 insertions(+), 1142 deletions(-)
 create mode 100755 t/t-utf-filenames.sh
 create mode 100755 t/t-utf-msg.sh
 create mode 100755 t/t7301-rev-parse.sh
 create mode 100644 test-utf.c
 create mode 100644 utf.c
 create mode 100644 utf.h
