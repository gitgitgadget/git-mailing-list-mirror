From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH nd/gitignore-trailing-whitespace] t0008: skip trailing space
 test on Windows
Date: Tue, 11 Mar 2014 08:46:40 +0100
Message-ID: <531EBF60.90309@viscovery.net>
References: <xmqqiortijxp.fsf@gitster.dls.corp.google.com>	<531D764E.2000809@viscovery.net> <xmqqfvmprfly.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 08:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNHOl-0007in-UZ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 08:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbaCKHqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 03:46:47 -0400
Received: from so.liwest.at ([212.33.55.23]:53383 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbaCKHqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 03:46:46 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WNHOb-0001UP-ES; Tue, 11 Mar 2014 08:46:41 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0684C16613;
	Tue, 11 Mar 2014 08:46:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqfvmprfly.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243846>

From: Johannes Sixt <j6t@kdbg.org>

The Windows API does not preserve file names with trailing spaces (and
dots), but rather strips them. Our tools (MSYS bash, git) base the POSIX
emulation on the Windows API. As a consequence, it is impossible for bash
on Windows to allocate a file whose name has trailing spaces, and for git
to stat such a file. Both operate on a file whose name has the spaces
stripped. Skip the test that needs such a file name.

Note that we do not use (another incarnation of) prerequisite FUNNYNAMES.
The reason is that FUNNYNAMES is intended to represent a property of the
file system. But the inability to have trailing spaces in a file name is
a property of the Windows API. The file system (NTFS) does not have this
limitation.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0008-ignores.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index bbaf6b5..63beb99 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -793,7 +793,7 @@ EOF
 	test_cmp err.expect err
 '

-test_expect_success 'quoting allows trailing whitespace' '
+test_expect_success !MINGW 'quoting allows trailing whitespace' '
 	rm -rf whitespace &&
 	mkdir whitespace &&
 	>"whitespace/trailing  " &&
-- 
1.9.0.1534.ga05fa03
