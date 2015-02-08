From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/11] ref_transaction_create(): check that new_sha1 is valid
Date: Sun,  8 Feb 2015 17:14:02 +0100
Message-ID: <1423412045-15616-9-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUVM-0002tl-5p
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbbBHQOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:14:30 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52179 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756700AbbBHQO2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:14:28 -0500
X-AuditID: 1207440d-f79976d000005643-1d-54d78b63fbe0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BD.FC.22083.36B87D45; Sun,  8 Feb 2015 11:14:27 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9lC014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:26 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqJvcfT3EYNFVXYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZB5sXshdMYa1oWqjfwNjF0sXIySEhYCJx7dJtdghbTOLCvfVsXYxc
	HEIClxklriw4xg7hnGCS+LjjMyNIFZuArsSinmYmEFtEQE1iYtshsEnMAquZJLbeZQOxhQV8
	JX52LgGzWQRUJe5PWgJWzyvgItG2YyvUZjmJ88d/MoPYnAKuEkve9ILZQkA1e271Mk1g5F3A
	yLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIyTIeHcw/l8nc4hRgINRiYe3
	Q+56iBBrYllxZe4hRkkOJiVR3qPhQCG+pPyUyozE4oz4otKc1OJDjBIczEoivIsOXwsR4k1J
	rKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8J7oBBoqWJSanlqRlplTgpBm
	4uAEGc4lJVKcmpeSWpRYWpIRD4qM+GJgbICkeID2doK08xYXJOYCRSFaTzHqcixo3z+TSYgl
	Lz8vVUqc9z9IkQBIUUZpHtwKWEp5xSgO9LEw7xuQKh5gOoKb9ApoCRPQksVLr4AsKUlESEk1
	MIbOn+T/3pn7z7+1zRb9prMVp29yWhUcdLjb27wwWePYpmNN1q/bCnvaXnPGyO4q+dd8kC1z
	2eZg/8vsVcw2HAGPFs2wOCmS8ZbrxFnzh593NXq+FK/Yvr3XXczce1KmbPg2D+6t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263517>

Creating a reference requires a new_sha1 that is not NULL and not
null_sha1.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index 6bd6581..8ab1f8e 100644
--- a/refs.c
+++ b/refs.c
@@ -3691,6 +3691,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create called without valid new_sha1");
 	return ref_transaction_update(transaction, refname, new_sha1,
 				      null_sha1, flags, msg, err);
 }
-- 
2.1.4
