From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/6] Introduce a get_oid function.
Date: Sun, 17 Apr 2016 23:10:36 +0000
Message-ID: <1460934641-435791-2-git-send-email-sandals@crustytoothpaste.net>
References: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arynb-0004Gd-Fg
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 04:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbcDRCT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 22:19:56 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52824 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751044AbcDRCTz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 22:19:55 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 30311282AC;
	Sun, 17 Apr 2016 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1460934674;
	bh=+1JprvRltjtrcTIGW3esXAO+XGBYDXisCFyw4r/olJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugP3gUtkIHt36jfa+CeTHiP3YrRYfs293144Srf7meXPyem+a3MkxtvJNIa5IMGOs
	 f6Hz9ha4llePutRQ3lRbB0SHlaMYT14go90OkUh3USCSGnlWgH3W2TxwFKxBj5M9Rx
	 Wq0lOfdG9Zqr7PrbKDaddG5nKAhSFch/pHbBdGDn3GHpgKro5TgoA9arM45WPuhP0e
	 Zdm0x7Gs8gkZyNBPosU0xjJAR9gJ7sWpOH26I0JopVmtVr4jQFAI2LGwCisjyaYv7l
	 CXjOM0RnnKbsCcl594O7cIDwCVTl6PMpmLYQQActWuvcRESdVWxkKknszFNnbZC9dj
	 N7uQgY6Eo2cAajzsSsyzSPHvxELLejE0eYPyXKCjQxHlsllChJSmniyW9bqggc/Qi6
	 jc14LCazAkn4YYqDqgZPlNLYA/SWuHUfcrm5VpVm7AhYCSlADtgwK54Jxcju8yRDPp
	 M3lsI5ZwS5PJaxpbvilFTlkuigdX7ydVyAMkCsOBeZm5onjw3Af
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291792>

The get_oid function is equivalent to the get_sha1 function, but uses a
struct object_id instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 2 ++
 sha1_name.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index 2711048c..22b73646 100644
--- a/cache.h
+++ b/cache.h
@@ -1156,6 +1156,8 @@ extern int get_sha1_blob(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc);
 
+extern int get_oid(const char *str, struct object_id *oid);
+
 typedef int each_abbrev_fn(const unsigned char *sha1, void *);
 extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 
diff --git a/sha1_name.c b/sha1_name.c
index 776101e8..ca7ddd6f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1215,6 +1215,15 @@ int get_sha1(const char *name, unsigned char *sha1)
 }
 
 /*
+ * This is like "get_sha1()", but for struct object_id.
+ */
+int get_oid(const char *name, struct object_id *oid)
+{
+	return get_sha1(name, oid->hash);
+}
+
+
+/*
  * Many callers know that the user meant to name a commit-ish by
  * syntactical positions where the object name appears.  Calling this
  * function allows the machinery to disambiguate shorter-than-unique
-- 
2.8.0.rc3.226.g39d4020
