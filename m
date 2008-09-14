From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/16] Narrow/Partial/Sparse checkout
Date: Sun, 14 Sep 2008 20:07:49 +0700
Message-ID: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerLv-0005jW-0a
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbYINNIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 09:08:14 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYINNIO
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:08:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbYINNIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:08:13 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=lerEERaXVbiiHusX/mqhMuVG1fq22a6IN3whSLy0PHg=;
        b=kPkme3K9VEgHiTD20Nl42ia7dsZWNLBQ6HIMSddebvpyyYBYme0jDATWyltdGnDZlX
         WwxyhhRyRw/6X7Kcj+t06hrhUDfVctqKryguQA7RXuMffMU2ETE7FN1OczaIo+nMKhMF
         LUs3nFc0HdRrjQBoEab0w9lYQr39sXMSvMVlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kGE8w/sXPvA2+1AZGzxT49S+vpEscUbypna9ir7o57Yevh9UhgsCX+57GoT8fHfmob
         ic0PWgeeXLQQg+X3in3hs6R2iPA/nBTLsiGT5b58XqVbUPz77st9OcYpZlgIwT+DrWYT
         YTIFbjUW5vRWGOWAZf3CZz4vjqpm1yq+DQd4I=
Received: by 10.142.229.4 with SMTP id b4mr2264994wfh.19.1221397692688;
        Sun, 14 Sep 2008 06:08:12 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 24sm20066912wfc.6.2008.09.14.06.08.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:08:11 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:08:05 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95827>

I hope this series is now ready to be reviewed. Documentation is in
place so no more explanation here (main document is in git-checkout.txt=
).
The series could be splitted into:

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Extend index to save more flags
  Introduce CE_NO_CHECKOUT bit
  update-index: refactor mark_valid() in preparation for new options
  update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT b=
it
  ls-files: add --narrow-checkout option to "will checkout" entries
  Add tests for updating no-checkout entries in index

 .gitignore                         |    1 +
 Documentation/git-ls-files.txt     |    6 +++
 Documentation/git-update-index.txt |   12 ++++++
 Makefile                           |    2 +-
 builtin-ls-files.c                 |   11 ++++++
 builtin-update-index.c             |   40 +++++++++++++--------
 cache.h                            |   66 ++++++++++++++++++++++++++++=
+++++--
 read-cache.c                       |   57 ++++++++++++++++++++++++----=
---
 t/t2104-update-index-narrow.sh     |   36 +++++++++++++++++++
 test-index-version.c               |   14 ++++++++
 10 files changed, 212 insertions(+), 33 deletions(-)

This adds CE_NO_CHECKOUT bit and plumbing support to manipulate it.
This bit is to mark what entry will be checked out.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  Prevent diff machinery from examining worktree outside narrow checkou=
t
  checkout_entry(): CE_NO_CHECKOUT on checked out entries.
  ls-files: apply --deleted on narrow area only
  grep: skip files that have not been checked out

 builtin-grep.c                 |    7 ++++++-
 builtin-ls-files.c             |    2 +-
 diff-lib.c                     |    5 +++--
 diff.c                         |    4 +++-
 entry.c                        |    1 +
 t/t2104-update-index-narrow.sh |    6 ++++++
 6 files changed, 20 insertions(+), 5 deletions(-)

Various fixes to make sure it works once in this mode.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  unpack_trees(): add support for narrow checkout
  narrow spec: put '+' before a spec will change semantic of '*'
  ls-files: add --narrow-match=3Dspec option for testing narrow matchin=
g
  clone: support narrow checkout with --path option
  checkout: add new options to support narrow checkout

 Documentation/git-checkout.txt   |   68 ++++++++++++++++++++++++-
 Documentation/git-clone.txt      |    8 +++-
 Documentation/git-ls-files.txt   |    7 ++-
 builtin-checkout.c               |   44 ++++++++++++++++
 builtin-clone.c                  |   13 +++++
 builtin-ls-files.c               |   14 +++++-
 cache.h                          |    3 +
 t/t2011-checkout-narrow.sh       |   80 +++++++++++++++++++++++++++++
 t/t3003-ls-files-narrow-match.sh |   45 ++++++++++++++++
 t/t5703-clone-narrow.sh          |   39 ++++++++++++++
 unpack-trees.c                   |  105 ++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.h                   |    6 ++
 12 files changed, 427 insertions(+), 5 deletions(-)

Support for "git checkout" and "git clone" to enter/update/leave
narrow/sparse/partial checkout.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  ls-files: add --overlay option

 Documentation/git-ls-files.txt |    4 ++++
 builtin-ls-files.c             |   16 +++++++++++++---
 t/t2104-update-index-narrow.sh |    4 ++++
 3 files changed, 21 insertions(+), 3 deletions(-)

Bonus stuff, not strictly needed.
