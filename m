From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 02/13] sha1_file: introduce has_object_file helper.
Date: Fri,  9 Oct 2015 01:43:48 +0000
Message-ID: <1444355039-186351-3-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:45:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMkc-0001bi-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbbJIBpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:14 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58052 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755627AbbJIBpI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:08 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 01BA228097;
	Fri,  9 Oct 2015 01:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355108;
	bh=TYw/FVDf0FvYMZT9J0p6DhbHoan+43KW7/MBT589otc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0vYL6uJqL0Fo/KWrNTFjItvj+ap6p5apMWo3XNW1QyZGLBTWNmYJa9CN9o68VwyZR
	 wD4pwbES1JnIlnnnA1OJ1kDM++Z4YJFdV4FjI/n8m3q7RbjE3UV3vfIQQmxYTI+QGh
	 xe59vqU6f/+8mh6Kyba5NrsZLgGlcGcLkRh235cPX7iEOBxqMvkfDpyucGt+e2fP3V
	 NRPmKUW56pOUSOwsrTMYJsP+Stx6G0Wt5eyboK1Gt8BaHcC2iPdnDNoam6CYrwNoue
	 Sknfma/KJZhWYtGcvRSPF9Wu/XSiBvty98T+9axgeqv626mV61QDl/qLHjAPe/eao4
	 QbwLpCWk2fjq/CL3PqCYiXi36GwJVacel/K0oHcbbOkLopG3MLpXdAMprZxEXadmYg
	 jVEmEu937oefQy+4M0zUStTa6vF09zKmI2TqeusQLZ97YPPQoVUpfAvp/e43ZQwh+y
	 VvQOaAi6e0ZY/UZ6rnHV4rhC0oYKpTD2TIvIu8Xjc50MDIVuB6h
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279288>

Add has_object_file, which is a wrapper around has_sha1_file, but for
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 3 +++
 sha1_file.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 752031e8..61a686e3 100644
--- a/cache.h
+++ b/cache.h
@@ -1002,6 +1002,9 @@ static inline int has_sha1_file(const unsigned char *sha1)
 	return has_sha1_file_with_flags(sha1, 0);
 }
 
+/* Same as the above, except for struct object_id. */
+extern int has_object_file(const struct object_id *oid);
+
 /*
  * Return true iff an alternate object database has a loose object
  * with the specified name.  This function does not respect replace
diff --git a/sha1_file.c b/sha1_file.c
index d295a322..77aa4f05 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3220,6 +3220,11 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 	return find_pack_entry(sha1, &e);
 }
 
+int has_object_file(const struct object_id *oid)
+{
+	return has_sha1_file(oid->hash);
+}
+
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
-- 
2.6.1
