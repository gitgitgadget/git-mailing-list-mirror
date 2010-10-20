From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v3 (maint)] t/gitweb-lib: Don't pass constant to decode_utf8
Date: Wed, 20 Oct 2010 19:07:10 -0400
Message-ID: <1287616030-88078-1-git-send-email-brian@gernhardtsoftware.com>
References: <201010202105.59370.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sven Verdoolaege <skimo@kotnet.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 01:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8hkh-0004UF-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 01:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab0JTXHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 19:07:14 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59788 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab0JTXHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 19:07:13 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id D8B4F1FFC05B; Wed, 20 Oct 2010 23:07:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 960B91FFC057;
	Wed, 20 Oct 2010 23:07:03 +0000 (UTC)
X-Mailer: git-send-email 1.7.3.1.209.g52408
In-Reply-To: <201010202105.59370.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159449>

Encode.pm started updating the string to decode in-place when
a second argument is passed in version 2.40.  This causes
'decode_utf8("", Encode::FB_CROAK)' to die with a message like:

Modification of a read-only value attempted at .../Encode.pm line 216.

Work around this by passing an empty variable instead of a constant
string.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
 Changes since v2:
 - Re-wrapped first paragraph for easier reading
 - Removed long OS X-specific Perl library path
 - Added Ack

 t/gitweb-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 81ef2a0..1b9523d 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -80,7 +80,7 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+perl -MEncode -e '$e="";decode_utf8($e, Encode::FB_CROAK)' >/dev/null 2>&1 || {
     skip_all='skipping gitweb tests, perl version is too old'
     test_done
 }
-- 
1.7.3.1.209.g52408
