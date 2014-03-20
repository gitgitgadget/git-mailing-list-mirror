From: Justin Lebar <jlebar@google.com>
Subject: [PATCH 0/4] Fix misuses of "nor" (v2)
Date: Thu, 20 Mar 2014 15:16:21 -0700
Message-ID: <1395353785-23611-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 23:45:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQlik-0006Gb-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667AbaCTWpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 18:45:50 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:53083 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759312AbaCTWpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 18:45:49 -0400
Received: by mail-pb0-f73.google.com with SMTP id rp16so201039pbb.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 15:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=z+XhrriCigW9Qqw/piAHWxs2CcJ443pNibcXCBmfc60=;
        b=n+3r95hmi1gn9OkohXd3YA2qarJL6dIb+vCttdmvwm0TxEVXIyI49WnqWnNV0k6xL8
         ZmVVRzxKg5fz4DlCuJItFP299oNDjIFR/6ZwmbQnuDU7+OMj1huOL1Tn6cltxDNHnUVF
         T9CaINX9NGmEIFPVVpmbrYdiNUFOXL3zR+CGFduQOCtJAghht59GurtCHhIj2g4vilfK
         9J0ove9Ke49vpqExwAC+/zpcRgFC3FmJSbAL/1sCRqOgrmbl5l7yLHOEKWUpTq+PyEwd
         sJEMOVw3MEQ3Vv0pQ8XG/YSBitwG/xSS+zenAAJDNCpL6i+Txle+dZZ+1a5+VZZPUgEQ
         eAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z+XhrriCigW9Qqw/piAHWxs2CcJ443pNibcXCBmfc60=;
        b=UNarqghUqAUe45Jbw48XJUtePQhIEE4bY32Jx/GpnDbibZKAW7jgdIYahSHK5fOYNX
         fp8J5HVCtNdxzS3IGUtj4sdRdadFhsh4wDHiKErkiA1L6V5x2KJMjr90Q2Uaw08wUGh9
         nLLa+Co72/Li+EZSc6W8KsJJRhhi48Dq8c4x31pG6GjEEmrS3kJ5LLSbPFTMZQlhDLYb
         YT37x+417OQaQk4Su7QzrX2orzHDv17/izqJM+Sg6Fx3ISA4CMX45gTGTBawPIt6G/r3
         NRHY02iPIvJpPL3k6R3XOaeIgLckt0/eWpAMLyZ5P9ld822JWuzop8u+G7yu/o4SDhIS
         HSWA==
X-Gm-Message-State: ALoCoQnUQu6gHxmfDbI4uStJNXHUdEPAWeKOWleXh6s6qOW3KvpZ4UPkPcTcOayPnUAUX3R/NkH+4S3CjJRCDAnVywyGDcdtplpNTxCcSRzM3NKpDYLoxtKqzbFV5Yg5yLcoN4MzKW5VFxz+pOfem6sqJx7EzN/6v9CwKDk2Gb25LaPkzHXQHHzOvrMcuE2hUL43MoA8WYhi
X-Received: by 10.66.163.70 with SMTP id yg6mr12589683pab.44.1395353809695;
        Thu, 20 Mar 2014 15:16:49 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k45si571040yhn.4.2014.03.20.15.16.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Mar 2014 15:16:49 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 651825A422C;
	Thu, 20 Mar 2014 15:16:49 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id 064931A1653; Thu, 20 Mar 2014 15:16:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.279.gdc9e3eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244598>

I got annoyed by git's awkward use of "nor" in man pages and in git add -p, so
I went ahead and audited all uses of "nor" in the tree.  One might be able to
argue that some of the uses I've changed are technically acceptable, but that's
a pretty low bar to set for ourselves.  I aimed to make everything both correct
and idiomatic.

All I really care about is git-add--interactive.perl and (to a lesser extent)
the docs, so if any of these other changes are controversial or annoying to
take, I'm happy to drop them.

Changes from v1 are:

- Drop the l10n patch (changes will be automatically picked up later).
- Fold the inside-tests and outside-tests patches.
- CC different people, as Duy indicated he wasn't comfortable reviewing.

Justin Lebar (4):
  Documentation: Fix misuses of "nor"
  contrib: Fix misuses of "nor"
  Fix misuses of "nor" in comments
  Fix misuses of "nor" outside comments and in tests

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
 59 files changed, 88 insertions(+), 89 deletions(-)

-- 
1.9.0.279.gdc9e3eb
