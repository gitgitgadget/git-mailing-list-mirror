From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2] perl/Makefile.PL: detect MakeMaker versions incompatible with DESTDIR
Date: Thu, 24 Sep 2009 13:21:03 -0500
Message-ID: <FE_WTi0YAHrCrSdGFemlb7ALatFkdSu5V7Yfb5CUgyoxfv3ZFXdFABKbT1boP7aeGWli-gJPcBA@cipher.nrlssc.navy.mil>
References: <7wQSYSBJPoVtvyGI0lqsDW37w4byCpgpMaHiDKALwW_oJ9nHXddX9OBMnqXGZBVAo2U7Tc1BMxg@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, c@gryning.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 20:23:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqsxB-0006vN-EE
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 20:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZIXSV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 14:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZIXSV0
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 14:21:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33920 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbZIXSV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 14:21:26 -0400
Received: by mail.nrlssc.navy.mil id n8OILFkR001350; Thu, 24 Sep 2009 13:21:18 -0500
In-Reply-To: <7wQSYSBJPoVtvyGI0lqsDW37w4byCpgpMaHiDKALwW_oJ9nHXddX9OBMnqXGZBVAo2U7Tc1BMxg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 24 Sep 2009 18:21:15.0068 (UTC) FILETIME=[CD57FFC0:01CA3D43]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129054>

From: Brandon Casey <drafnel@gmail.com>

It appears that ExtUtils::MakeMaker versions older than 6.11 do not
implement the DESTDIR mechanism.  So add a test to the generated perl.mak
to detect when DESTDIR is used along with a too old ExtUtils::MakeMaker and
abort with a message suggesting the use of NO_PERL_MAKEMAKER.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This just reverses the logic in the test on $(MM_VERSION) so that the test
will also fail if MM_VERSION is unset.  Who knows if ancient versions set
it.  Sorry for the quick v2.

-brandon


 perl/Makefile.PL |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 320253e..0b9deca 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -5,6 +5,14 @@ sub MY::postamble {
 instlibdir:
 	@echo '$(INSTALLSITELIB)'
 
+ifneq (,$(DESTDIR))
+ifeq (0,$(shell expr '$(MM_VERSION)' '>' 6.10))
+$(error ExtUtils::MakeMaker version "$(MM_VERSION)" is older than 6.11 and so \
+	is likely incompatible with the DESTDIR mechanism.  Try setting \
+	NO_PERL_MAKEMAKER=1 instead)
+endif
+endif
+
 MAKE_FRAG
 }
 
-- 
1.6.4.3
