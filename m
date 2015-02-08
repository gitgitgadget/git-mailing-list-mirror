From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/11] ref_transaction_delete(): check that old_sha1 is not null_sha1
Date: Sun,  8 Feb 2015 17:14:03 +0100
Message-ID: <1423412045-15616-10-git-send-email-mhagger@alum.mit.edu>
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
	id 1YKUVM-0002tl-WF
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbbBHQOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:14:31 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47383 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756509AbbBHQOa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:14:30 -0500
X-AuditID: 12074411-f79fa6d000006b8a-38-54d78b654fb3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 14.5F.27530.56B87D45; Sun,  8 Feb 2015 11:14:29 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9lD014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:27 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqJvafT3E4PU2XouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZr840sBXMY604+mwlWwNjO0sXIyeHhICJxPr956BsMYkL99azdTFy
	cQgJXGaUePrlM1hCSOAEk8S9C/EgNpuArsSinmYmEFtEQE1iYtshsBpmgdVMElvvsoHYwgKh
	Er0/loLZLAKqEp9uvAOr5xVwlWj7fI0NYpmcxPnjP5lBbE6g+JI3vcwQu1wk9tzqZZrAyLuA
	kWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukmRkiQCe5gnHFS7hCjAAejEg+v
	gcz1ECHWxLLiytxDjJIcTEqivEfDgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeBcdvhYixJuS
	WFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4D3RCTRUsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDt7QRp5y0uSMwFikK0nmLU5VjQvn8mkxBL
	Xn5eqpQ473+QIgGQoozSPLgVsJTyilEc6GNhXs0uoCoeYDqCm/QKaAkT0JLFS6+ALClJREhJ
	NTC6yiTV8HzmUI/MjddiEAs7e+/5m4Olf75bLqmQbm+WW/JRPie2QWPzobTKaYuOVAUp2iq6
	zNSU/1NR+e7Oswm3I7Qk/eM+Pfz+4OK/qgau5iS2tw1KrrqL9X6uWtQpNIPZQOTv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263518>

It makes no sense to delete a reference that is already known not to
exist.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index 8ab1f8e..85815d7 100644
--- a/refs.c
+++ b/refs.c
@@ -3703,6 +3703,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
+	if (old_sha1 && is_null_sha1(old_sha1))
+		die("BUG: delete called with old_sha1 set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_sha1, old_sha1,
 				      flags, msg, err);
-- 
2.1.4
