From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6.1 0/8] git log -L, cleaned up and (hopefully) fixed
Date: Tue, 14 Dec 2010 23:54:07 +0100
Message-ID: <cover.1292366984.git.trast@student.ethz.ch>
References: <7vhbegroj2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:54:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdlK-0003BE-Eu
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411Ab0LNWyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:54:19 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:10668 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183Ab0LNWyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:54:17 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 23:54:09 +0100
Received: from localhost.localdomain (84.74.105.24) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 23:54:16 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <7vhbegroj2.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163705>

Junio C Hamano wrote:
> 
> This patch set has too many whitespace errors, and worse yet, cannot be
> applied with "git am --whitespace=fix" because it has test vectors that
> depend on having "SP followed by HT" (context lines of diff output) and
> traling SP (graph output).
> 
> Could you please straighten that out first?
> 
> My preference is to protect offending whitespaces like this:
> 
> 	sed -e 's/Q/ /g' -e 's/Z$//' >expected-no-M <<\EOF
[...]
> which has an added benefit of making them more visible.

Sorry for the mess.  I stuck to the s/#$// style I already had in some
places for now, but used the Qs and ran the rest through
whitespace=fix.  It now applies cleanly to master.


Bo Yang (8):
  Refactor parse_loc
  Export three functions from diff.c
  Export rewrite_parents() for 'log -L'
  Implement line-history search (git log -L)
  log -L: support parent rewriting
  log -L: add --graph prefix before output
  log -L: add --full-line-diff option
  log -L: implement move/copy detection (-M/-C)

 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   22 +
 Documentation/line-range-format.txt |   18 +
 Makefile                            |    2 +
 builtin/blame.c                     |   99 +--
 builtin/log.c                       |   79 ++-
 diff.c                              |    6 +-
 diff.h                              |   17 +
 line.c                              | 2153 +++++++++++++++++++++++++++++++++++
 line.h                              |   72 ++
 revision.c                          |   22 +-
 revision.h                          |   23 +-
 t/t4301-log-line-single-history.sh  |  685 +++++++++++
 t/t4302-log-line-merge-history.sh   |  174 +++
 t/t4303-log-line-move-detect.sh     |  238 ++++
 t/t4304-log-line-copy-detect.sh     |  220 ++++
 t/t8003-blame-corner-cases.sh       |    6 +
 17 files changed, 3730 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line.c
 create mode 100644 line.h
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh
 create mode 100755 t/t4303-log-line-move-detect.sh
 create mode 100755 t/t4304-log-line-copy-detect.sh

-- 
1.7.3.3.807.g6ee1f
