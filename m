From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Sun,  7 Feb 2016 20:11:37 +0100
Message-ID: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 20:11:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSUkJ-0000RY-Ly
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 20:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbcBGTLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 14:11:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:32806 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754480AbcBGTLj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 14:11:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id AF00020960
	for <git@vger.kernel.org>; Sun,  7 Feb 2016 14:11:38 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Sun, 07 Feb 2016 14:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=
	mesmtp; bh=a04B0lCZc7upa81mMsvQ16z+3wE=; b=XM/9xNDa73P+h6srr+Dfr
	bvALMwCv9g2cVQloKqqTD2hJFgRz8hWI9u44NLWPo5wXT8qjGxrhPizEeMn8SGrZ
	zKWuUfFo4IM/bf6zU9a6xlmG9v3xYrGZZZ+UjSh2scWPnLVVPT0QsC24tt1Felby
	00xCbg7ruYZNG4FTFtdMoU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=a04B0lCZc7upa81mMsvQ16z+3w
	E=; b=jwmO94iJskYI2GipTuc/gOy4FHZyAkLny0+6QanVd6K/aACYVdoR/v6lJS
	q57Gsoql59Zxcu0x1bHrBmaV76dupq17zAOFwMLNFjX5T2Y/JISFaf0ki72Fh0wm
	nE7gIZmKUkWiDooj2i+0cUaeID2u0Qpz4r3oK10/vj+qOMJmE=
X-Sasl-enc: 7/4wDAhZNe2AWI7mjJ+MVJaSB/5iDonO4PtU160TT5wB 1454872298
Received: from localhost (dslb-178-011-155-180.178.011.pools.vodafone-ip.de [178.11.155.180])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3374B6800FA;
	Sun,  7 Feb 2016 14:11:38 -0500 (EST)
X-Mailer: git-send-email 2.7.0.373.g083f1fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285736>

bcb11f1 (mingw: mark t9100's test cases with appropriate prereqs, 2016-01-27)
replaced "/bin/sh" in exec.sh by the shell specified in SHELL_PATH, but
that breaks the subtest which checks for a specific checksum of a tree
containing.

Revert that change that was not explained in the commit message anyways
(exec.sh is never executed).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

 t/t9100-git-svn-basic.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 5464b5b..936913c 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -30,7 +30,8 @@ test_expect_success \
 		echo "deep dir" >dir/a/b/c/d/e/file &&
 		mkdir bar &&
 		echo "zzz" >bar/zzz &&
-		write_script exec.sh </dev/null &&
+		echo "#!/bin/sh" >exec.sh &&
+		chmod +x exec.sh &&
 		svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
 	) &&
 	rm -rf import &&
-- 
2.7.0.373.g083f1fe
