From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/5] Consolidate path normalization functions
Date: Sat,  7 Feb 2009 16:08:26 +0100
Message-ID: <1234019311-6449-1-git-send-email-j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Feb 07 16:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVovV-0006PA-JF
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbZBGPPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:15:35 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbZBGPPd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:15:33 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:39612 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbZBGPPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:15:32 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Feb 2009 10:15:32 EST
Received: from localhost.localdomain (unknown [93.83.142.38])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 0BE5E10A70A;
	Sat,  7 Feb 2009 16:08:31 +0100 (CET)
X-Mailer: git-send-email 1.6.1.297.g9b01e
In-Reply-To: <498CAF73.6050409@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108858>

This series:

 - moves sanitary_path_copy around, which accounts for the bulk
   of the change;

 - updates longest_ancestor_length(), the core function of
   GIT_CEILING_DIRECTORIES;

 - adjust the test suite, uncovers a buglet in sanitary_path_copy(),
   and fixes it.

 - removes normalize_absolute_path() that duplicated functionality
   of sanitary_path_copy().

As a side effect, this fixes GIT_CEILING_DIRECTORIES on Windows, where
this feature is currently broken.

Johannes Sixt (4):
  Make test-path-utils more robust against incorrect use
  Move sanitary_path_copy() to path.c and rename it to
    normalize_path_copy()
  Test and fix normalize_path_copy()
  Remove unused normalize_absolute_path()

Ren=C3=A9 Scharfe (1):
  Fix t1504 on Windows

 cache.h                 |    2 +-
 path.c                  |  124 ++++++++++++++++++++++++++-------------
 setup.c                 |   88 +---------------------------
 t/t0060-path-utils.sh   |   33 +++++-----
 t/t1504-ceiling-dirs.sh |    6 +-
 test-path-utils.c       |   14 +++-
 6 files changed, 115 insertions(+), 152 deletions(-)
