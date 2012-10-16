From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 13:39:46 +0200
Message-ID: <0140f3f2f2f4bded6868f4082bef0c36e9a8560e.1350387132.git.git@drmicha.warpmail.net>
References: <k5gq60$q8c$1@ger.gmane.org>
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 13:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO5VN-00049d-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab2JPLj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:39:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43415 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754515Ab2JPLjy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 07:39:54 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C94AC20A38;
	Tue, 16 Oct 2012 07:39:53 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Oct 2012 07:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=w2
	pDUicwMYrtyf4lorATOpufP2U=; b=cIAtNZf+bBulWxgithsoc/GzjX+FqvO16H
	gjDYBIXgIuG9uhPUQTi+wbsvt1ePYNRpUeTWnPCsrV3qXZTPVnj2GmzKvrJCpdPS
	xxlGIntT+Vhay+aP+o/U2MJlHjtnMjB6UB22Eqd5qxtyaMapbXF0Wjae/lNbGNd6
	5P5pVScHM=
X-Sasl-enc: i704Wq2kwwx0COkwEntAjiEgfHrjIV5MpR1VYuGJprIT 1350387593
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6CADE4827C7;
	Tue, 16 Oct 2012 07:39:53 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc2.304.g9f3ac5c
In-Reply-To: <k5gq60$q8c$1@ger.gmane.org>
In-Reply-To: <cover.1350387132.git.git@drmicha.warpmail.net>
References: <cover.1350387132.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207818>

Some test want to use the time command (not the shell builtin) and test
for its availability at /usr/bin/time.

Provide a lazy prereq TIME_COMMAND which tests for /usr/bin/time and
/bin/time. If any is found, set TEST_COMMAND_PATH to the first match.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Rather than iterating over 2 or more hardcoded paths, one could use
"test -P time" or allow a make variable TIME_COMMAND_PATH whose
executability is checked by the prereq. I really don't know what's best.

 t/test-lib.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 489bc80..7977c15 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -738,6 +738,13 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
 	esac
 '
 
+test_lazy_prereq TIME_COMMAND '
+	for command in /usr/bin/time /bin/time
+	do
+		test -x "$command" && break
+	done && TIME_COMMAND_PATH="$command"
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
-- 
1.8.0.rc2.304.g9f3ac5c
