From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 01/12] sha1_file: introduce has_object_file helper.
Date: Tue, 10 Nov 2015 02:22:19 +0000
Message-ID: <1447122150-672570-2-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvyaG-0000jx-CR
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbbKJCWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:22:51 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58383 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537AbbKJCWu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:50 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 95DB928095;
	Tue, 10 Nov 2015 02:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122170;
	bh=fc6zpCyqSoGT5oFBS8Mk7FWdIDRyPAWDZedxZKqDRGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zdry38/KO56V3XMKW76ZmocX4eOTJOFuA5GxC17/YX8VqUDJDLfrHE4l7cd5ceij7
	 R+imHOARzSWU94ns1AZqlhgUPlNR/J6ubFEHo/lNMw9aLStpDvnUZ5//IxdT6q6U4Q
	 ojvXPRiflhDE907q52NDoTsZhbg/hfGUvlVg3wCUH1nJCKSxQ+1r2d49UY//vKYKrR
	 hqnc1r+rdy3wFxvuNplLzB8Aw87s2XMR7Esc/lngfAzLDsc8GuhCG2GYELW3HrwxUN
	 bh0oZwbPeZ1xtIndsUe0Andzy4eFcD1fzX2OXuEX6i19H6KnORUCXB6bGswjyDiHUd
	 SuNM45fnMMEZLe+kH5jY/PGxKjrv/YZlX8n6+wxdaGcqlNHsy5FPNvOlCju1s1Nebc
	 R1kC6YEfxAC5b1rXhi44Vw8DWEa5t0PDWO9CeBuWAkyddZ9RQH+yBWUUJ6t1fqccsf
	 ANSnKkV18r2sgx0LAyIQr2vb/YyUhKnA7wo8yXhQzI9ViHr9YNA
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281089>

Add has_object_file, which is a wrapper around has_sha1_file, but for
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 3 +++
 sha1_file.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 3ba0b8f3..27bc121b 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,6 +1030,9 @@ static inline int has_sha1_file(const unsigned char *sha1)
 	return has_sha1_file_with_flags(sha1, 0);
 }
 
+/* Same as the above, except for struct object_id. */
+extern int has_object_file(const struct object_id *oid);
+
 /*
  * Return true iff an alternate object database has a loose object
  * with the specified name.  This function does not respect replace
diff --git a/sha1_file.c b/sha1_file.c
index c5b31de9..59515b77 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3227,6 +3227,11 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
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
2.6.2.409.gb049f0a
