From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Thu, 09 Dec 2010 20:53:19 +0100
Message-ID: <4D0133AF.40000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 20:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQmYS-0006UW-3d
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 20:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab0LITxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 14:53:22 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:55700 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab0LITxW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 14:53:22 -0500
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id B357518158B10;
	Thu,  9 Dec 2010 20:53:20 +0100 (CET)
Received: from [213.64.3.195] (helo=birne.lan)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PQmYK-00014p-00; Thu, 09 Dec 2010 20:53:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX1/I7koK+nRN+Ed8LXkJi/wp/u4ryWj+VPyzbFOn
	gZt8R2cFTmEmOXE7KXtNVkikmdQbE/kAUCE0eCXDUGBA/b7oKD
	x2xrH+Bxk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163308>

Do not depend on internal implementation details of svn,
which right now uses perl to create a .gz file.
So this test case will even work in the future,
when svn changes its implementation.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
  t/t9143-git-svn-gc.sh |    4 +---
  1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
index 337ea59..4594e1a 100755
--- a/t/t9143-git-svn-gc.sh
+++ b/t/t9143-git-svn-gc.sh
@@ -37,13 +37,11 @@ test_expect_success 'git svn gc runs' 'git svn gc'
   test_expect_success 'git svn index removed' '! test -f=20
=2Egit/svn/refs/remotes/git-svn/index'
  -if perl -MCompress::Zlib -e 0 2>/dev/null
+if test -r .git/svn/refs/remotes/git-svn/unhandled.log.gz
  then
  	test_expect_success 'git svn gc produces a valid gzip file' '
  		 gunzip .git/svn/refs/remotes/git-svn/unhandled.log.gz
  		'
-else
-	say "# Perl Compress::Zlib unavailable, skipping gunzip test"
  fi
   test_expect_success 'git svn gc does not change unhandled.log files'=
 '
--=20
1.6.6
