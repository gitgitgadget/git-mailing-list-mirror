From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/8] character encoding portability updates
Date: Mon, 18 May 2009 18:44:37 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CW2-0003Pz-6h
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbZERXo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZERXoz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:44:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50111 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZERXoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:55 -0400
Received: by mail.nrlssc.navy.mil id n4INitKI024906; Mon, 18 May 2009 18:44:56 -0500
X-OriginalArrivalTime: 18 May 2009 23:44:54.0996 (UTC) FILETIME=[A53C1940:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119474>

I got a clue from Alex Riesen's "Use UTF-8 instead of utf8 for backward
compatibility" commit 39d404d1 that some of the iconv issues on Solaris
and IRIX could be caused by character code naming issues.  It seems that
these platforms do not understand all of the alternate names that modern
platforms do.

Character encodings are not a strong point of mine, so do comment if you
see something wrong.

In particular, notice 4/8 that changes the default fallback encoding to
ISO8859-1 instead of latin1.  My understanding is that these two are
equivalent.

With this series applied, Solaris 10 must skip only 4 tests for me (plus two
more if I use Korn shell).  The remaining ones that are skipped have to do
with iconv but the character code conversions being tested are not installed.

Solaris 7 must skip 30 (32 with Korn shell), down from 52 (54), and IRIX 6.5
must skip only 13, down from 44.

-brandon


Brandon Casey (8):
  t3900: use ancient iconv names for backward compatibility
  Use 'UTF-8' rather than 'utf-8' everywhere for backward compatibility
  builtin-mailinfo.c: compare character encodings case insensitively
  builtin-mailinfo.c: use "ISO8859-1" instead of "latin1" as fallback
    encoding
  t3901: avoid negation on right hand side of '|'
  t3901: Use ISO8859-1 instead of ISO-8859-1 for backward compatibility
  t9301: use ISO8859-1 rather than ISO-8859-1
  t5100: use ancient encoding syntax for backwards compatibility

 builtin-log.c                             |    2 +-
 builtin-mailinfo.c                        |   10 +++----
 builtin-revert.c                          |    4 +-
 pretty.c                                  |    4 +-
 t/t3900-i18n-commit.sh                    |   28 ++++++++++----------
 t/t3900/{ISO-8859-1.txt => ISO8859-1.txt} |    0
 t/t3900/{EUCJP.txt => eucJP.txt}          |    0
 t/t3901-i18n-patch.sh                     |   40 ++++++++++++++--------------
 t/t5100/rfc2047-samples.mbox              |   32 +++++++++++-----------
 t/t5100/sample.mbox                       |    8 +++---
 t/t9129-git-svn-i18n-commitencoding.sh    |   10 +++---
 t/t9301-fast-export.sh                    |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh    |    2 +-
 13 files changed, 70 insertions(+), 72 deletions(-)
 rename t/t3900/{ISO-8859-1.txt => ISO8859-1.txt} (100%)
 rename t/t3900/{EUCJP.txt => eucJP.txt} (100%)
