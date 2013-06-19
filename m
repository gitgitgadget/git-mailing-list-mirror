From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] t/t5528-push-default: generalize test_push_*
Date: Wed, 19 Jun 2013 16:41:43 +0530
Message-ID: <1371640304-26019-6-git-send-email-artagnon@gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:15:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGMA-0003b0-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934414Ab3FSLPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:15:08 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50582 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934408Ab3FSLPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:15:04 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so5044884pad.9
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 04:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zRECJpXb8UEOhdUUvV//c+hUXK4SUhhhB24waXjTfWQ=;
        b=P/dn+1mrKezCVRgq5oQ7zuM+0cqTooS/jVpWgsCVBI0vRUqPupVGas1ftHCo5QWfSJ
         i2+DB0Mx/nxCaZ/QeSZ6KC76Ta/3W5rKVNow/rxHx+fIiioHP21STvdyZ/fmU7jMJqEK
         fn1qrnvADKm3m1lPZ9f7g47uN+Xu4JdDdRWNicmxjnE02uGaUvxK6SolMZ9qpPM007Wy
         mN4HPxJ1bImEAceCNXabZsFq4OGfRF8rNm54zMvTj6DIDNXfWUt6Mgx6V3XgJyBIHo/p
         6hmvPx+mJBt8MT0dOF0b0bCQAlvu/fdCcrGkoOpg95bI24EcTMWzohzKQvSFTLLJMmT5
         vyFA==
X-Received: by 10.68.96.193 with SMTP id du1mr2312287pbb.142.1371640503897;
        Wed, 19 Jun 2013 04:15:03 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id iq2sm22746579pbb.19.2013.06.19.04.15.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 04:15:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.454.gff6ba36
In-Reply-To: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228388>

The setup creates two bare repositories: repo1 and repo2, but
test_push_commit() hard-codes checking in repo1 for the actual output.
Generalize it and its caller, test_push_success(), to optionally accept
a third argument to specify the name of the repository to check for
actual output.  We will use this in the next patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5528-push-default.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index e54dd02..b599186 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -15,17 +15,19 @@ test_expect_success 'setup bare remotes' '
 
 # $1 = local revision
 # $2 = remote revision (tested to be equal to the local one)
+# $3 = [optional] repo to check for actual output (repo1 by default)
 check_pushed_commit () {
 	git log -1 --format='%h %s' "$1" >expect &&
-	git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
+	git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
 	test_cmp expect actual
 }
 
 # $1 = push.default value
 # $2 = expected target branch for the push
+# $3 = [optional] repo to check for actual output (repo1 by default)
 test_push_success () {
 	git -c push.default="$1" push &&
-	check_pushed_commit HEAD "$2"
+	check_pushed_commit HEAD "$2" "$3"
 }
 
 # $1 = push.default value
-- 
1.8.3.1.454.g30263f3.dirty
