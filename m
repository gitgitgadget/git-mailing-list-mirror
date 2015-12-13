From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/3] format-patch: check that header line has expected format
Date: Sun, 13 Dec 2015 17:27:18 +0000
Message-ID: <1450027638-788102-4-git-send-email-sandals@crustytoothpaste.net>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 18:28:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ARQ-0000Gh-J3
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 18:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbbLMR13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 12:27:29 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44778 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974AbbLMR10 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2015 12:27:26 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 70E53282CD;
	Sun, 13 Dec 2015 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450027645;
	bh=En+Hjuu0M+e4plkaz6QxmKQIPWhbxeMDHV7LuHkI0I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1hHqjJbQ24Sbun46Hq/KmZap2KqRVQHSNUwOwD8fiZw0TrRs2JrBAVaujg5pMz2p4
	 AYRXv9JTAeBqJNAQC+O3x+qvd8YVWxC3l6nKVXho3QGdD+STxvBO+iHJhpmJ60TcDh
	 ZIL5H/WnG/s/VeE4uLijvzz2gVyXIOIKe0HY1xmT02ywmHqrtbOJRJkdfDXKmzuhF4
	 Z/AEmqinw3KH2sRwLgWNwYyOzmv9f+xJc4ITVuT+UyneqIbo2BehIAqakknrKLS615
	 J1+wO9yJXA3jWv3YjnvXfr6zgmxlnLl7qGyO+6yodTr16p8baKqkiuUaviHwyaW639
	 IuMYpABiP3RvoCawzVr+IbzLcHvix9aaNNz3luu5jPpcp7EBtzKYi1y5p471sW69JF
	 6CgtNiHAKE3GNTYHb+xOJgHZTIJwLsz22fU8QnAGxm7gdxgt5zAz5yr7T6GXfbcK7+
	 JU0QMI1kMiCZ3BF4qFVWcYiF7XhjLvAW5/MLCT1XEfw51DctSqe
X-Mailer: git-send-email 2.7.0.rc0.173.g4a846af
In-Reply-To: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282335>

The format of the "From " header line is very specific to allow
utilities to detect Git-style patches.  Add a test that the patches
created are in the expected format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4014-format-patch.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b740e3da..362bc228 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1437,4 +1437,10 @@ test_expect_success 'format-patch --zero-commit' '
 	test $cnt = 3
 '
 
+test_expect_success 'From line has expected format' '
+	git format-patch --stdout v2..v1 >patch2 &&
+	cnt=$(egrep "^From [0-9a-f]{40} Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&
+	test $cnt = 3
+'
+
 test_done
