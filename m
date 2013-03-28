From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v10 0/5] git log -L
Date: Thu, 28 Mar 2013 17:47:29 +0100
Message-ID: <cover.1364488205.git.trast@inf.ethz.ch>
References: <CALWbr2xW1SsNXq0wCh9jd_qGVrACLuQT-UETcG+zoxw9xjKSHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	"Thomas Rast" <trast@inf.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:48:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFzk-0003sx-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab3C1Qrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:47:39 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35631 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756776Ab3C1Qri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:47:38 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:34 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:35 +0100
X-Mailer: git-send-email 1.8.2.446.g2b4de83
In-Reply-To: <CALWbr2xW1SsNXq0wCh9jd_qGVrACLuQT-UETcG+zoxw9xjKSHw@mail.gmail.com>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219431>

From: Thomas Rast <trast@inf.ethz.ch>

This adds a bunch of fixes and failing tests for invalid -L arguments;
as Antoine discovered, some variations would segfault v9.

I also changed the beginning of parse_range_funcname (in patch 4/5),
which now also lets you backslash-escape a : in a funcname regex.  The
old version was based on the assumption that there could only be a ':'
in the string if we were coming from scan_range_arg, which made it a
bit hard to read.


Bo Yang (2):
  Refactor parse_loc
  Export rewrite_parents() for 'log -L'

Thomas Rast (3):
  Implement line-history search (git log -L)
  log -L: :pattern:file syntax to find by funcname
  Speed up log -L... -M

 Documentation/blame-options.txt     |   21 +-
 Documentation/git-blame.txt         |    6 +-
 Documentation/git-log.txt           |   23 +
 Documentation/line-range-format.txt |   25 +
 Makefile                            |    4 +
 builtin/blame.c                     |   99 +--
 builtin/log.c                       |   31 +
 line-log.c                          | 1228 +++++++++++++++++++++++++++++++++++
 line-log.h                          |   49 ++
 line-range.c                        |  243 +++++++
 line-range.h                        |   36 +
 log-tree.c                          |    4 +
 revision.c                          |   22 +-
 revision.h                          |   16 +-
 t/perf/p4211-line-log.sh            |   34 +
 t/t4211-line-log.sh                 |   53 ++
 t/t4211/expect.beginning-of-file    |   43 ++
 t/t4211/expect.end-of-file          |   62 ++
 t/t4211/expect.move-support-f       |   40 ++
 t/t4211/expect.simple-f             |   59 ++
 t/t4211/expect.simple-f-to-main     |  100 +++
 t/t4211/expect.simple-main          |   68 ++
 t/t4211/expect.simple-main-to-end   |   70 ++
 t/t4211/expect.two-ranges           |  102 +++
 t/t4211/expect.vanishes-early       |   39 ++
 t/t4211/history.export              |  330 ++++++++++
 t/t8003-blame-corner-cases.sh       |    6 +
 27 files changed, 2690 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line-log.c
 create mode 100644 line-log.h
 create mode 100644 line-range.c
 create mode 100644 line-range.h
 create mode 100755 t/perf/p4211-line-log.sh
 create mode 100755 t/t4211-line-log.sh
 create mode 100644 t/t4211/expect.beginning-of-file
 create mode 100644 t/t4211/expect.end-of-file
 create mode 100644 t/t4211/expect.move-support-f
 create mode 100644 t/t4211/expect.simple-f
 create mode 100644 t/t4211/expect.simple-f-to-main
 create mode 100644 t/t4211/expect.simple-main
 create mode 100644 t/t4211/expect.simple-main-to-end
 create mode 100644 t/t4211/expect.two-ranges
 create mode 100644 t/t4211/expect.vanishes-early
 create mode 100644 t/t4211/history.export

-- 
1.8.2.446.g2b4de83
