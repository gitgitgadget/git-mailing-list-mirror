From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] t5510: do not leave changed cwd
Date: Fri,  4 Mar 2016 11:53:50 +0100
Message-ID: <f6499302a5dfb52bf6c9430581103da9569434a3.1457088499.git.git@drmicha.warpmail.net>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 11:54:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abnMu-0006pZ-U6
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 11:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbcCDKx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 05:53:58 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35632 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752835AbcCDKxz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 05:53:55 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 55D0B20BDD
	for <git@vger.kernel.org>; Fri,  4 Mar 2016 05:53:54 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 04 Mar 2016 05:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=RCT4D45zpWhPO0Zy4OF9Mm8k0Bw
	=; b=RGqWKjFmTRW6jlQJKRyoAA2PuOPcUN44P+z6hrfHnUmrXr+8Mgb7GS3dRqy
	2lGZM3N4pZIfKQK8ejXLOzjaLdGv1wWkE9152UQ4jbby+q+v5ADHb33QdaNk02OR
	J6ePWDBz4jzM1krJwtLLR/hn9aKSWotNGdLH/PU0HD1ul6sg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=RCT4
	D45zpWhPO0Zy4OF9Mm8k0Bw=; b=MBcTTx2nq+R4skMcCJ4tCQgJsNliCkVWzXYh
	3bRCkG9NDj1buApPATdFewLB40DW3qPg8BI/iYh1nR+N9LGCQGqwKzjJMYvV66mW
	rUAXk0i9J/CVTgZ2Js+Ke0LRzPrwFAhxLTNZ8h9M3p1F1dqipcb51GlCxfFYDo+w
	7nLtPgo=
X-Sasl-enc: QfZBud5cDMfl3oObD3VRo+1+k5raCF6Yijhjrzvv4Pn6 1457088833
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id CCD57680166;
	Fri,  4 Mar 2016 05:53:53 -0500 (EST)
X-Mailer: git-send-email 2.8.0.rc0.181.g163d81c
In-Reply-To: <cover.1457088499.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288244>

t5510 carefully keeps the cwd at the test root by using either subshells
or explicit cd'ing back to the root. Use a subshell for the last
subtest, too.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t5510-fetch.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0c10c85..38321d1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -679,10 +679,12 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	EOF
 	git clone "file://$D" auto-gc &&
 	test_commit test2 &&
-	cd auto-gc &&
-	git config gc.autoPackLimit 1 &&
-	GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
-	! grep "Should I try again" fetch.out
+	(
+		cd auto-gc &&
+		git config gc.autoPackLimit 1 &&
+		GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
+		! grep "Should I try again" fetch.out
+	)
 '
 
 test_done
-- 
2.8.0.rc0.181.g163d81c
