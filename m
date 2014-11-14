From: Mike Blume <blume.mike@gmail.com>
Subject: [PATCH v4] Allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 12:13:13 -0800
Message-ID: <1415995993-70879-1-git-send-email-blume.mike@gmail.com>
Cc: Mike Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 21:13:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpNFB-0007nk-Rx
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbaKNUNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:13:18 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57646 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbaKNUNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:13:17 -0500
Received: by mail-pa0-f49.google.com with SMTP id lj1so17913440pab.8
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3lBEWS3RNR2aeQczc18JITnmEX/CqOgafTTEP9GFrvo=;
        b=N+yBumk5VzuXVi7dQNEw5cZI1kovcCa0gfF/uWyeEJ3T5AWHwly3t2TsLCYwBqDSRE
         OBfaOwkeT7EGyk2aXxmetEYl6zuDev5SOsK4HfOJeR3fXaAjdGGbt+RRJmSWoR77pyCn
         VyxLu7v7R4GuquZvoI9fkkbgzyoZfZeDhTKX4AWzGjeLK8N1uusx+czoX70cjLYygovC
         x3Po+G4dLcbn7FZP2kiaQSJ/65MKmSAICAp44hpJ4wqae5OdiOGmbukHzzpfXhNfY7Op
         8jwlaakXyXbYoFGF4wGhAGMbaLd8MQqLAaTVugbkaDB3du71EdGdaRwN9rQIB/5DxAVx
         HRng==
X-Received: by 10.67.14.129 with SMTP id fg1mr12375670pad.114.1415995996680;
        Fri, 14 Nov 2014 12:13:16 -0800 (PST)
Received: from tcc-michael-4.local.com ([50.59.189.124])
        by mx.google.com with ESMTPSA id te2sm28263595pbc.51.2014.11.14.12.13.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Nov 2014 12:13:16 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc1.197.g60bf093
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TTY tests were previously skipped on all Mac OS systems because of a
bug where reading from pty master occasionally hung. This bug has since
been found not to be reproducible under Mac OS 10.9 and 10.10.1.

Therefore, run TTY tests under Mac OS 10.9 (Mavericks) and higher.

Signed-off-by: Mike Blume <blume.mike@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Improved-by: John Szakmeister <john@szakmeister.net>
Improved-by: Johannes Sixt <j6t@kdbg.org>
Improved-by: Jeff King <peff@peff.net>
---
 t/lib-terminal.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 5184549..275fb09 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -29,7 +29,12 @@ test_lazy_prereq TTY '
 	# After 2000 iterations or so it hangs.
 	# https://rt.cpan.org/Ticket/Display.html?id=65692
 	#
-	test "$(uname -s)" != Darwin &&
+	# Under Mac OS X 10.9, this problem appears to be gone.
+	#
+	{
+		test "$(uname -s)" != Darwin ||
+		test "$(uname -r | cut -d. -f1)" -ge 13
+	} &&
 
 	perl "$TEST_DIRECTORY"/test-terminal.perl \
 		sh -c "test -t 1 && test -t 2"
-- 
2.2.0.rc1.197.g60bf093
