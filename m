From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t/gitweb-lib: Don't pass constant to decode_utf8
Date: Thu, 14 Oct 2010 15:36:09 -0400
Message-ID: <1287084969-81868-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 21:36:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6TbE-0005AX-Id
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 21:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab0JNTgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 15:36:16 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39425 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab0JNTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 15:36:16 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 418A11FFC54A; Thu, 14 Oct 2010 19:36:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 8FC261FFC546;
	Thu, 14 Oct 2010 19:36:04 +0000 (UTC)
X-Mailer: git-send-email 1.7.3.1.139.g4284d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159066>

Running 'decode_utf8("", Encode::FB_CROAK)' causes perl 5.10 to die on
OS X 10.6.4 with:

Modification of a read-only value attempted at
/Library/Perl/Updates/5.10.0/darwin-thread-multi-2level/Encode.pm line
216.

This is because Encode 2.40 updates the string to decode in-place when
a second argument is passed.  Work around this by passing an empty
variable ($_) instead of a constant string ("")

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/gitweb-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 8c490c8..c31d815 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -80,7 +80,7 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+perl -MEncode -e 'decode_utf8($_, Encode::FB_CROAK)' >/dev/null 2>&1 || {
 	skip_all='skipping gitweb tests, perl version is too old'
 	test_done
 }
-- 
1.7.3.1.139.g4284d
