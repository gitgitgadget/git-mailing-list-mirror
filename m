From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 3/3] format-patch: check that header line has expected format
Date: Tue, 15 Dec 2015 01:52:05 +0000
Message-ID: <1450144325-182108-4-git-send-email-sandals@crustytoothpaste.net>
References: <1450144325-182108-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 02:52:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8enM-0001Ek-IC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 02:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078AbbLOBwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 20:52:20 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47230 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932965AbbLOBwP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 20:52:15 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 98F8E282CD;
	Tue, 15 Dec 2015 01:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450144333;
	bh=+T9hdkWFZI9j8o/KQALjV9FO9Qeu3X+FGGowzygHOng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPFIl+A3KLLa62Grid0ZM0vIFh9potkcfv1eVB6awJhzX1QN04N/9a+78lFuTa/ZD
	 OdW2onmE/Ew3UUijYsSe0TLWUXh/3sm4+1DKQ//nZOkQqzAExyR2r9fnG8TLGXz377
	 vk41DAa/NHTUHOPC/EBzwmGsK4mTmBctX5XQ8jNHK3nLvH/wg4nxGL43+b+UP+rALG
	 2yUcAw+fkQPnUJv5rujPBTG0yIhhEMwZgb91UC5SB1qTwu870jV9DaOlliuelajXub
	 99xlnIa6c2Rl8zZZE5jUY7cywVGDcIXdZS9orc3WRDFCrw5lpwHwTq+9HGTkNmS69K
	 iiWz1HoaFLNqEZ4Q4R+RmhHCY29mpxQr720NahfWLfUeKjGwxjFEr5tAxD+DSAzPGk
	 qHg8xTmkoS0PY3cbxs9C8+fDO6e9empxZoXkp0DC7vtHo9kgAGWPdGV5UkYYv6gjvr
	 W/5TkuqdFP1odUYDSXott3rYpPQC/br5fiSTOQbwGYsQS+XQ+Qm
X-Mailer: git-send-email 2.7.0.rc0.173.g4a846af
In-Reply-To: <1450144325-182108-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282464>

The format of the "From " header line is very specific to allow
utilities to detect Git-style patches.  Add a test that the patches
created are in the expected format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4014-format-patch.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 2737ca63..646c4750 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1438,4 +1438,11 @@ test_expect_success 'format-patch --zero-commit' '
 	test_cmp expect actual
 '
 
+test_expect_success 'From line has expected format' '
+	git format-patch --stdout v2..v1 >patch2 &&
+	grep "^From " patch2 >from &&
+	grep "^From $_x40 Mon Sep 17 00:00:00 2001$" patch2 >filtered &&
+	test_cmp from filtered
+'
+
 test_done
-- 
2.7.0.rc0.194.g1187e4e.dirty
