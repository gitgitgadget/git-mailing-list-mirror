From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCHv3 1/2] t5304-prune: demonstrate bug in pruning alternates
Date: Mon, 2 Feb 2015 10:40:08 -0800
Message-ID: <FF73A39C-2678-40C2-9E2D-58855AEC4E40@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILuw-0006bM-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbbBBSkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:40:10 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48909 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753984AbbBBSkI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 13:40:08 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 90AB0206A5
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 13:40:08 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Feb 2015 13:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:from:content-type:content-transfer-encoding
	:subject:date:message-id:cc:to:mime-version; s=mesmtp; bh=4J5GcU
	WuH1V1y4tPdtMdeHktkUs=; b=LO5OJAML5YhU2plka6WSZJ6r4pOE1hf4fnJ8Kj
	48uuodVkoAMe76Yj2H1RYAxCqqTNXIVnx+iTHJFo75Lo+204V8OrusLLr7CtvVdf
	L1vJ30jixe00hq+G2TCPOtu9Sp+BKW6lw1gjw/xWf6O5cgFla6hh+NC4swWwJzrI
	3Myq4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:content-type
	:content-transfer-encoding:subject:date:message-id:cc:to
	:mime-version; s=smtpout; bh=4J5GcUWuH1V1y4tPdtMdeHktkUs=; b=EJx
	g7/xKTS2d4CQym2pRxC6ULQCc0Llb4rVRxVi+Hls+aS5HWuXR6zYzkzR0Im/H9eX
	BG/xm9AeTxT55VZNe9Mh75v76R1Z+CTdMHK50jiFnyLyLre7xrAL9Magu/ARlNNg
	072vPuDIHfKNqCfZJzxvMaSSOjGts1XjeN++9ric=
X-Sasl-enc: Tt1YNo4WsF95P9Nu5VSj7oTElfhoVfWaC9eE8mpwez6d 1422902408
Received: from [172.16.3.162] (unknown [206.169.144.70])
	by mail.messagingengine.com (Postfix) with ESMTPA id A2AF8C0029A;
	Mon,  2 Feb 2015 13:40:07 -0500 (EST)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263272>

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
Messed up the v2 patch, sorry.

 t/t5304-prune.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e32e46d..e825be7 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -253,4 +253,17 @@ test_expect_success 'prune .git/shallow' '
 	test_path_is_missing .git/shallow
 '
 
+test_expect_success 'prune: handle alternate object database' '
+	test_create_repo A && cd A &&
+	echo "Hello World" > file1 &&
+	git add file1 &&
+	git commit -m "Initial commit" file1 &&
+	cd .. &&
+	git clone -l -s A B && cd B &&
+	echo "foo bar" > file2 &&
+	git add file2 &&
+	git commit -m "next commit" file2 &&
+	git prune
+'
+
 test_done
-- 
2.3.0.rc2.2.g184f7a0
