From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH/RFC 08/10] Don't append default merge message to -m message
Date: Thu, 10 Apr 2008 01:58:39 +0200
Message-ID: <1207785521-27742-9-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-8-git-send-email-joerg@alea.gnuu.de>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkH2-0004V7-5j
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbYDJADX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbYDJADV
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:21 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3465 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbYDJADG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:06 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 44D30488063; Thu, 10 Apr 2008 02:03:03 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBg-0004mE-1N; Thu, 10 Apr 2008 01:58:44 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBe-0007Ek-Io; Thu, 10 Apr 2008 01:58:42 +0200
X-Mailer: git-send-email 1.5.4.5
In-Reply-To: <1207785521-27742-8-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79153>

Picked from <7vabko3dm2.fsf@gitster.siamese.dyndns.org>
From: gitster@pobox.com (Junio C Hamano)
Date: Sun, 23 Mar 2008 22:17:09 -0700
---
 git-merge.sh |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..bd9699d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -250,17 +250,19 @@ else
 	# We are invoked directly as the first-class UI.
 	head_arg=HEAD
 
-	# All the rest are the commits being merged; prepare
-	# the standard merge summary message to be appended to
-	# the given message.  If remote is invalid we will die
-	# later in the common codepath so we discard the error
-	# in this loop.
-	merge_name=$(for remote
-		do
-			merge_name "$remote"
-		done | git fmt-merge-msg
-	)
-	merge_msg="${merge_msg:+$merge_msg$LF$LF}$merge_name"
+	if test -z "$merge_msg"
+	then
+		# All the rest are the commits being merged; prepare
+		# the standard merge summary message to be appended to
+		# the given message.  If remote is invalid we will die
+		# later in the common codepath so we discard the error
+		# in this loop.
+		merge_msg=$(for remote
+			do
+				merge_name "$remote"
+			done | git fmt-merge-msg
+		)
+	fi
 fi
 head=$(git rev-parse --verify "$head_arg"^0) || usage
 
-- 
1.5.4.5
