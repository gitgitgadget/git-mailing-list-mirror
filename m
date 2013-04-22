From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/33] refs: document the fields of struct ref_value
Date: Mon, 22 Apr 2013 21:52:10 +0200
Message-ID: <1366660361-21831-3-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMnw-0004QV-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab3DVTxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:32 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:43659 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755021Ab3DVTxb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:31 -0400
X-AuditID: 12074413-b7f226d000000902-2e-5175953a8e31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 30.3E.02306.A3595715; Mon, 22 Apr 2013 15:53:30 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOF008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:29 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqGs1tTTQ4PpedYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M74sfUKY8EhtoqlbXeYGhj/
	snQxcnJICJhINLy+ww5hi0lcuLeerYuRi0NI4DKjxLMZW6CcC0wSy+Z9A+tgE9CVWNTTzARi
	iwioSUxsOwQWZxZwkNj8uZERxBYWcJfY/ms/2FQWAVWJ1jdvweK8Ai4SC5bfZoTYpiBxfPs2
	MJtTwFXidMcJsDlCQDUrDk5lmcDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJ
	XmpK6SZGSLAI72DcdVLuEKMAB6MSD6+Ae2mgEGtiWXFl7iFGSQ4mJVFejilAIb6k/JTKjMTi
	jPii0pzU4kOMEhzMSiK8ovlAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwM
	B4eSBO+3yUCNgkWp6akVaZk5JQhpJg5OEMEFsoEHaIM8yHbe4oLE3OLMdIiiU4yKUuK8bpOA
	EgIgiYzSPLgBsLh+xSgO9I8wbzTIHh5gSoDrfgU0mAlocGZCCcjgkkSElFQD41qDkx9qkm0N
	y6rfKESvn3g0df7dr5mv7NfuniWvyG9rdyWs+K/ipGlni8wET632fNx3/f79rfcOH5E8++Sk
	yPF5xmf4Jv3uY50/szD+X0XSv7alF92XV584wbOkac75S72H96mcV4+fFFS30/Ubp8drm5kP
	AgqVleXUHBx6U/VylSd8O7tG7p8SS3FGoqEWc1FxIgC1ZsZ+xgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222052>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/refs.c b/refs.c
index 30b4bf7..1df1ccd 100644
--- a/refs.c
+++ b/refs.c
@@ -109,7 +109,19 @@ struct ref_entry;
  * (ref_entry->flag & REF_DIR) is zero.
  */
 struct ref_value {
+	/*
+	 * The name of the object to which this reference resolves
+	 * (which may be a tag object).  If REF_ISBROKEN, this is
+	 * null.  If REF_ISSYMREF, then this is the name of the object
+	 * referred to by the last reference in the symlink chain.
+	 */
 	unsigned char sha1[20];
+
+	/*
+	 * If REF_KNOWS_PEELED, then this field holds the peeled value
+	 * of this reference, or null if the reference is known not to
+	 * be peelable.
+	 */
 	unsigned char peeled[20];
 };
 
-- 
1.8.2.1
