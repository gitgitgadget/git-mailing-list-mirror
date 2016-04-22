From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/6] Introduce a get_oid function.
Date: Fri, 22 Apr 2016 22:02:48 +0000
Message-ID: <20160422220253.839970-2-sandals@crustytoothpaste.net>
References: <20160422220253.839970-1-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:03:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjAd-0000m7-BJ
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbcDVWDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:03:24 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56120 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654AbcDVWDW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 18:03:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1B194282A9;
	Fri, 22 Apr 2016 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1461362599;
	bh=pEjHVV3f2pzjd9Npk6f5U1tmBPXcgEYM1IH5U3KHN8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHqlHzS9k6XXDACX/DiFr06jS7bwFs+CW7H3UYx4pz6U+XmPwDbPT4DjANzhU5XyN
	 lbvrdE5PHUM51cOCT8B/xQGJz/LqvuJg0vUe2oTpMN3ku8/PWLhw/00VuqonApbdLF
	 /eWMUXH9KY4Im/KLvEwDhfJvLirbxe6/TT83uiPZGuh294UL5XC54PUjL8OzDUUX82
	 SQa/CPCXbo8ICESUGo/FuhIe+ejaf7Mn20AOEuz0QUxdgQQ4BlfZIkIqy/ynRdpkKs
	 wlx5aXjBB7ojO5HHmXvvtjkyLXDqX+NWxUVX8NR/j0FtPI/4f7tMAo9NuRxkk5T758
	 x1dmqLHCBIGRekzfGIPtl8unXZFu+u4YmtrwW9HEG5tSIe34yyH+bhhUtWRZzDuDNu
	 YqANVZzt7/37Wcv4opsd2re/AeDsMNRi6R+ZccNgm2iAlRfJZv+Mrf1jJGv7JgVrog
	 cFBeNO4zdd7sWNVA3wxkJ5CHTn3VWSPozmFMYHhiVBg7yYgBrLw
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160422220253.839970-1-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292276>

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
2.8.1.369.geae769a
