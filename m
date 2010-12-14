From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed on
 cygwin
Date: Tue, 14 Dec 2010 18:34:29 +0000
Message-ID: <4D07B8B5.2030409@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZu1-0005Vk-9K
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828Ab0LNSqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:46:54 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52779 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758534Ab0LNSqw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:46:52 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZtj-00078o-Xr; Tue, 14 Dec 2010 18:46:52 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163674>


The test using the conflict_hunks helper function (test 9) fails
on cygwin, since sed (by default) throws away the CR from CRLF
line endings. This behaviour is undesirable, since the validation
code expects the CRLF line-ending to be present. In order to fix
the problem we pass the -b (--binary) option to sed, using the
SED_OPTIONS variable. We use the SED_STRIPS_CR prerequisite in the
conditional initialisation of SED_OPTIONS.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Note that this test does not fail on MinGW, but I don't
really know why, given commit ca02ad3... ahem ;-)

 t/t3032-merge-recursive-options.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2293797..f70f6c4 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -13,9 +13,11 @@ test_description='merge-recursive options
 
 . ./test-lib.sh
 
+test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
+
 test_expect_success 'setup' '
 	conflict_hunks () {
-		sed -n -e "
+		sed $SED_OPTIONS -n -e "
 			/^<<<</ b inconflict
 			b
 			: inconflict
-- 
1.7.3
