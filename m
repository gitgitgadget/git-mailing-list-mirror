From: Mike Blume <blume.mike@gmail.com>
Subject: [PATCH] allow TTY tests to run under recent Mac OS
Date: Thu, 13 Nov 2014 14:01:27 -0800
Message-ID: <1415916087-18953-1-git-send-email-blume.mike@gmail.com>
Cc: Mike Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:01:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp2SN-0000lf-VX
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 23:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934096AbaKMWBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 17:01:32 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35976 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933512AbaKMWBb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 17:01:31 -0500
Received: by mail-pa0-f49.google.com with SMTP id lj1so16017734pab.22
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3JwA1y3XS2T9sDEzyIBhkCISpx9htJIKuW2iXbesSJ0=;
        b=j7KnKbFbTvR63AP4oRJH8iEIEW4kZ1Se2v+qurt+qGYLmK0lPqzP9alH/qRG3Xbjo9
         nDI71A6FIW/BTS4VD1cL0salQXVprJaqZBDn1K6MyoOqmo/GViH9Bi3HN2mQ6AGinW7R
         AmVedcXGEqMvBRnWNmz8Zo93jQuqPabOOOFhw3XsNhurTloGAp2kHDUWtFu6+EdFxbWH
         X/Ed6qcdJUMiMmPHDtSz4LuYV0/SiRscCpfbqpeWcNjk9fvJqXyYGya65mgdzRZoHjPc
         j8Gl4a8CgGgMfTETy6dvGdezD3toilBFfK4ZWryvM++HCz+F3/HmBiyIkPmXWwQzFFHC
         mong==
X-Received: by 10.66.145.42 with SMTP id sr10mr5510581pab.73.1415916090848;
        Thu, 13 Nov 2014 14:01:30 -0800 (PST)
Received: from tcc-michael-4.local.com ([50.59.189.124])
        by mx.google.com with ESMTPSA id ml5sm25843405pab.32.2014.11.13.14.01.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Nov 2014 14:01:30 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc1.197.g60bf093
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
TTY on Yosemite and higher

Signed-off-by: Mike Blume <blume.mike@gmail.com>
---
 t/lib-terminal.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 5184549..1311ce0 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -29,7 +29,10 @@ test_lazy_prereq TTY '
 	# After 2000 iterations or so it hangs.
 	# https://rt.cpan.org/Ticket/Display.html?id=65692
 	#
-	test "$(uname -s)" != Darwin &&
+	# Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
+	# appears to be gone.
+	#
+	[[ test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1") -ge 14 ]] &&
 
 	perl "$TEST_DIRECTORY"/test-terminal.perl \
 		sh -c "test -t 1 && test -t 2"
-- 
2.2.0.rc1.197.g60bf093
