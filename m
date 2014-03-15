From: Justin Lebar <jlebar@google.com>
Subject: [PATCH 0/6] Fix misuses of "nor"
Date: Sat, 15 Mar 2014 01:41:56 -0700
Message-ID: <1394872922-2000-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Richard Hansen <rhansen@bbn.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 09:43:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOkBP-00066r-N2
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 09:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbaCOImb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 04:42:31 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:42694 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaCOIm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 04:42:27 -0400
Received: by mail-yh0-f74.google.com with SMTP id f10so439827yha.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cDY7HX4ojUIHIaXjmOi0n2u+jZ6AuQWm3aIpIrosKjg=;
        b=QP7W5omwZHDH0fcGjnJ0p3AKDcbDP9r0IKl9BrLqv6l6Jd7AQcEod3kLqdzXJLxPxG
         N8CNHSlUjHTEHFQ2rjG1M1AqA53ilKGmG2wI5Sa4a/Rs+m680sJja6keZVWsoGbzQgqr
         JDRtQbR2KFkF45QD5MvFI4Id1vNPt+ANQ/X1Znspp4nVWKX9wxfQr4yf7mYKdgWAfj9s
         +4/BOmebP8uHHKYxFwA+BM3CNntY1cv9bXMePy3HOffBBU1225rXOgB+n1IAtxM2ipU7
         DZeD0HZgTCIOXJXn6abRIapOjmXmfNf0sx00TrOFHWLKVP6ktwFlw4tOIFRQu2eyiUqZ
         8n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cDY7HX4ojUIHIaXjmOi0n2u+jZ6AuQWm3aIpIrosKjg=;
        b=ZF43ZZjYRGuYPLSn5Zk7AvbJVhnZnoljUmwXg91au+1ZfdbN4LNX9ijCBitl+mZxlT
         194j1MJB1+TZxfIjN6YheL+0G/wwys3IF/kuTcsqq4lkxPLX3NiVg6CnibLrvH5HfCx1
         7e7f+x+/ynkaOVIbKxt2xKfW9A1xrZhai0Vv8MbNwWHLmjTF2QHT4O4GpW65W2ORhm8U
         gMWorYk+GuLOMPFtJ4Rlpv8n1MLjmLi8rOIgDujOZl4BJYiWM3tUEe6Q9ka7n4EAeSlb
         RFlUV86u5+L4KKfRVk0IoXHUmfQIYvqvN5pw8OyduN33a/30u6muVDph92KHqwK6+yM6
         MysA==
X-Gm-Message-State: ALoCoQmhs9NxydwokKc2W1NWcO4bMnsGBC5rEuwEmQdeFkrUKJ2e6F+wGehgyEntaTmVN5wRuH+pN1kDor8Gd5qNxvtJYsA///ZpUIbGPFdgGJWCYiFH223JTWZIg8LPEu75fBCwVyi55G1ZXc+zqZdp+/BfUwlm8EWLzR3ovnCAUkN/IvgwCUI+2S2UD6sUr0zG9BKyj2h8
X-Received: by 10.236.17.161 with SMTP id j21mr4142378yhj.55.1394872946856;
        Sat, 15 Mar 2014 01:42:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id u4si1296132yhb.5.2014.03.15.01.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Mar 2014 01:42:26 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9C4195A4241;
	Sat, 15 Mar 2014 01:42:26 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id 484DF1A0889; Sat, 15 Mar 2014 01:42:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.279.gdc9e3eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244142>

I got annoyed by git's awkward use of "nor" in man pages and in git add -p, so
I went ahead and audited all uses of "nor" in the tree.  One might be able to
argue that some of the uses I've changed are technically acceptable, but that's
a pretty low bar to set for ourselves.  I aimed to make everything both correct
and idiomatic.

All I really care about is git-add--interactive.perl and (to a lesser extent)
the docs, so if any of these other changes are controversial or annoying to
take, I'm happy to drop them.

This is my first patch to git, so I've probably made a few fatal errors in how
I packaged this change; apologies in advance.

Justin Lebar (6):
  Documentation: Fix misuses of "nor"
  contrib: Fix misuses of "nor"
  l10n: Fix misuses of "nor"
  Fix misuses of "nor" in comments
  Fix misuses of "nor" outside comments
  Tests: Fix misuses of "nor"

 Documentation/CodingGuidelines                      |  4 ++--
 Documentation/config.txt                            |  6 +++---
 Documentation/diff-generate-patch.txt               |  2 +-
 Documentation/diff-options.txt                      |  2 +-
 Documentation/everyday.txt                          |  2 +-
 Documentation/git-add.txt                           |  4 ++--
 Documentation/git-count-objects.txt                 |  4 ++--
 Documentation/git-diff.txt                          |  4 ++--
 Documentation/git-prune.txt                         |  2 +-
 Documentation/git-push.txt                          |  2 +-
 Documentation/git-read-tree.txt                     |  2 +-
 Documentation/git-reset.txt                         |  6 +++---
 Documentation/git-show-branch.txt                   |  2 +-
 Documentation/git-show-ref.txt                      |  2 +-
 Documentation/howto/rebase-from-internal-branch.txt |  2 +-
 Documentation/howto/revert-a-faulty-merge.txt       |  4 ++--
 Documentation/howto/revert-branch-rebase.txt        |  2 +-
 Documentation/merge-options.txt                     | 15 +++++++--------
 Documentation/pretty-formats.txt                    |  2 +-
 Documentation/pretty-options.txt                    |  2 +-
 Documentation/rev-list-options.txt                  |  2 +-
 Documentation/technical/api-gitattributes.txt       |  2 +-
 Documentation/technical/pack-protocol.txt           |  8 ++++----
 Documentation/technical/protocol-common.txt         |  2 +-
 Documentation/user-manual.txt                       |  2 +-
 Makefile                                            |  2 +-
 builtin/apply.c                                     |  2 +-
 builtin/checkout.c                                  |  2 +-
 builtin/clean.c                                     |  6 +++---
 builtin/commit.c                                    |  2 +-
 builtin/log.c                                       |  2 +-
 builtin/pack-objects.c                              |  2 +-
 builtin/reset.c                                     |  4 ++--
 builtin/show-branch.c                               |  2 +-
 column.c                                            |  2 +-
 contrib/examples/git-checkout.sh                    |  2 +-
 contrib/examples/git-commit.sh                      |  2 +-
 contrib/examples/git-reset.sh                       |  4 ++--
 contrib/fast-import/import-directories.perl         |  4 ++--
 contrib/svn-fe/svn-fe.txt                           |  4 ++--
 delta.h                                             |  2 +-
 diff.c                                              |  2 +-
 git-add--interactive.perl                           |  4 ++--
 git-am.sh                                           |  2 +-
 gitweb/gitweb.perl                                  |  2 +-
 http.h                                              |  4 ++--
 perl/Git/SVN.pm                                     |  6 +++---
 perl/Git/SVN/Migration.pm                           |  2 +-
 pkt-line.h                                          |  2 +-
 po/bg.po                                            |  6 +++---
 po/de.po                                            |  6 +++---
 po/fr.po                                            |  6 +++---
 po/git.pot                                          |  6 +++---
 po/it.po                                            |  2 +-
 po/pt_PT.po                                         |  2 +-
 po/sv.po                                            |  6 +++---
 po/vi.po                                            |  6 +++---
 po/zh_CN.po                                         |  6 +++---
 remote.c                                            |  2 +-
 sha1_file.c                                         |  4 ++--
 t/t1001-read-tree-m-2way.sh                         |  2 +-
 t/t4005-diff-rename-2.sh                            |  2 +-
 t/t4009-diff-rename-4.sh                            |  2 +-
 t/t5304-prune.sh                                    |  2 +-
 t/t6036-recursive-corner-cases.sh                   |  2 +-
 t/t7104-reset.sh                                    |  2 +-
 t/t9400-git-cvsserver-server.sh                     |  2 +-
 test-chmtime.c                                      |  2 +-
 68 files changed, 111 insertions(+), 112 deletions(-)

-- 
1.9.0.279.gdc9e3eb
