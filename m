From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCH 1/2] t5710-info-alternate: demonstrate bug in unpacked pruning
Date: Sun, 1 Feb 2015 13:55:00 -0800
Message-ID: <BF4AA771-DEB5-4DED-9C74-768036C1E2DD@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 22:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI2U2-0008Sb-NT
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 22:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbBAVzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 16:55:05 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55556 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635AbbBAVzE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Feb 2015 16:55:04 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A06D207F0
	for <git@vger.kernel.org>; Sun,  1 Feb 2015 16:55:03 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Sun, 01 Feb 2015 16:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:from:content-type:content-transfer-encoding
	:subject:date:message-id:cc:to:mime-version; s=mesmtp; bh=3Zfx8Y
	+zepv8+d88mm4zZ6P0AzA=; b=Tqb+aN4u5oA1xxb2V6wgOZUyvrISro70xTiCzt
	hypfV7Uq2Nut7MC89cjiP9lxcW4mr1rpfNSKMiyj0etJDMYpBA7TGtSQCGdEvKgi
	72z1/P6oQL3nbz2pXU3CxkHLi14OeZmNTAHft0UKZV3H//MXGUsSZWMfrT95njDN
	o7xFU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:content-type
	:content-transfer-encoding:subject:date:message-id:cc:to
	:mime-version; s=smtpout; bh=3Zfx8Y+zepv8+d88mm4zZ6P0AzA=; b=Hy8
	YFZR5pSD2pUDIVW4ay/qjjaTQjBK/9tp3Rp/zXIQ/RzaFyF5wjExjt7uMJxW70w1
	cjNysxtKP7YVIYWlvcLb4Fzq4bUTp/Sf+axXWhHWSITD0dTqujZRmHukERZmLhfx
	iLZiUJfHjuwe38rEs93VdLeHBrDyyf30XRWvyMu0=
X-Sasl-enc: MfEvNzqOIqmGZXrXd12gUTlkNAwNpU2Djl95pRhOIRji 1422827703
Received: from [172.16.60.11] (unknown [24.5.84.102])
	by mail.messagingengine.com (Postfix) with ESMTPA id A2E7D6800F2;
	Sun,  1 Feb 2015 16:55:02 -0500 (EST)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263239>

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
 t/t5710-info-alternate.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 5a6e49d..d82844a 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -18,6 +18,7 @@ reachable_via() {
 
 test_valid_repo() {
 	git fsck --full > fsck.log &&
+	git prune &&
 	test_line_count = 0 fsck.log
 }
 
@@ -47,8 +48,7 @@ test_expect_success 'preparing third repository' \
 'git clone -l -s B C && cd C &&
 echo "Goodbye, cruel world" > file3 &&
 git add file3 &&
-git commit -m "one more" file3 &&
-git repack -a -d -l &&
+git commit -m "one more without packing" file3 &&
 git prune'
 
 cd "$base_dir"
-- 
2.3.0.rc2.2.g184f7a0
