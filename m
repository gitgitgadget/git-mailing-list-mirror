From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/33] refs: document flags constants REF_*
Date: Sun, 14 Apr 2013 14:54:16 +0200
Message-ID: <1365944088-10588-2-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMUH-0005c4-9w
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab3DNMzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:31 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:60506 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834Ab3DNMzS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:18 -0400
X-AuditID: 12074414-b7fb86d000000905-ec-516aa735a1d8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D3.A8.02309.537AA615; Sun, 14 Apr 2013 08:55:17 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAjw007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:16 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqGu6PCvQ4OdFKYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M74828Rc8E7norddz+xNTAu4upi5OSQEDCRWP90KSuELSZx4d56NhBbSOAyo0RXQ1kX
	IxeQfZZJYs/ul4wgCTYBXYlFPc1MXYwcHCIC2RK718qDhJkFHCQ2f25kBAkLC1hLrJifChJm
	EVCVWLFxBzuIzSvgInFn+nxGiFUKEse3bwOzOQVcJaY/P8YOsdZFYtbm2awTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJJ5EdjEdOyh1iFOBgVOLhdWDJChRi
	TSwrrsw9xCjJwaQkyqu4DCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNexFSjHm5JYWZValA+T
	kuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBqwEyVLAoNT21Ii0zpwQhzcTBCSK4QDbw
	AG14uxRkQ3FBYm5xZjpE0SlGRSlx3o8gCQGQREZpHtwAWOS/YhQH+keY9ylIFQ8wacB1vwIa
	zAQ02GdvOsjgkkSElFQDo+ejmVfXnq/WfSkTIXvwkOj60ONm2XnZuXKr3oQYbK+tD5sro+in
	ve2e79meaon5+XPfv+W833msfsHDP6dyfHyClzaoPIszm96xT8vLm3PStpKfFfPFNT+dX3pg
	Xru15Tyvc9ynH/5teP4gRMy6Nmvasx3PpnJWaZ0t2P9af9KSi1seJEyIZVJiKc5I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221125>

Document the bits that can appear in the "flags" parameter passed to
an each_ref_function and/or in the ref_entry::flag field.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 +++++++++++-
 refs.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index de2d8eb..30b4bf7 100644
--- a/refs.c
+++ b/refs.c
@@ -158,7 +158,17 @@ struct ref_dir {
 	struct ref_entry **entries;
 };
 
-/* ISSYMREF=0x01, ISPACKED=0x02, and ISBROKEN=0x04 are public interfaces */
+/*
+ * Bit values for ref_entry::flag.  REF_ISSYMREF=0x01,
+ * REF_ISPACKED=0x02, and REF_ISBROKEN=0x04 are public values; see
+ * refs.h.
+ */
+
+/*
+ * The field ref_entry->u.value.peeled of this value entry contains
+ * the correct peeled value for the reference, which might be
+ * null_sha1 if the reference is not a tag or if it is broken.
+ */
 #define REF_KNOWS_PEELED 0x08
 
 /* ref_entry represents a directory of references */
diff --git a/refs.h b/refs.h
index a35eafc..17bc1c1 100644
--- a/refs.h
+++ b/refs.h
@@ -10,8 +10,21 @@ struct ref_lock {
 	int force_write;
 };
 
+/*
+ * Bit values set in the flags argument passed to each_ref_fn():
+ */
+
+/* Reference is a symbolic reference. */
 #define REF_ISSYMREF 0x01
+
+/* Reference is a packed reference. */
 #define REF_ISPACKED 0x02
+
+/*
+ * Reference cannot be resolved to an object name: dangling symbolic
+ * reference (directly or indirectly), corrupt reference file, or
+ * symbolic reference refers to ill-formatted reference name.
+ */
 #define REF_ISBROKEN 0x04
 
 /*
-- 
1.8.2.1
