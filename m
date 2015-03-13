From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 01/10] Define a structure for object IDs.
Date: Fri, 13 Mar 2015 23:39:27 +0000
Message-ID: <1426289976-568060-2-git-send-email-sandals@crustytoothpaste.net>
References: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZBg-0008J9-VF
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbbCMXkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50103 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbbCMXkK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 87F7E28092;
	Fri, 13 Mar 2015 23:40:09 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265424>

Many places throughout the code use "unsigned char [20]" to store object IDs
(SHA-1 values).  This leads to lots of hardcoded numbers throughout the
codebase.  It also leads to confusion about the purposes of a buffer.

Introduce a structure for object IDs.  This allows us to obtain the benefits
of compile-time checking for misuse.  The structure is expected to remain
the same size and have the same alignment requirements on all known
platforms, compared to the array of unsigned char, although this is not
required for correctness.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 761c570..6582c35 100644
--- a/cache.h
+++ b/cache.h
@@ -43,6 +43,14 @@ int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
 unsigned long git_deflate_bound(git_zstream *, unsigned long);
 
+/* The length in bytes and in hex digits of an object name (SHA-1 value). */
+#define GIT_SHA1_RAWSZ 20
+#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+
+struct object_id {
+	unsigned char hash[GIT_SHA1_RAWSZ];
+};
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
-- 
2.2.1.209.g41e5f3a
