From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/13] ref_transaction_delete(): check that old_sha1 is not null_sha1
Date: Tue, 17 Feb 2015 18:00:20 +0100
Message-ID: <1424192423-27979-11-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlWO-00040f-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbbBQRBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:01:07 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62409 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248AbbBQRAs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:48 -0500
X-AuditID: 12074413-f79f26d0000030e7-36-54e373c05efd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D5.5B.12519.0C373E45; Tue, 17 Feb 2015 12:00:48 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXf000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:46 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHug+HGIwaY5PBZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzHl47x1hwg7Vi2vVXjA2Mu1m6GDk5JARMJBZ92MoIYYtJXLi3nq2L
	kYtDSOAyo8TNqU+ZIZzjTBL/+18zgVSxCehKLOppBrNFBNQkJrYdApvELLCaSWLrXaBuDg5h
	gQiJyxM5QEwWAVWJCbOsQSp4BVwl7ty7wAyxS07i/PGfYDYnUHzZr2XsILaQgIvE/I7ZTBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAkx4R2Mu07KHWIU4GBU
	4uG1mPAoRIg1say4MvcQoyQHk5IoLycwQIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8AalAOV4
	UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8bUVAjYJFqempFWmZOSUI
	aSYOTpDhXFIixal5KalFiaUlGfGguIgvBkYGSIoHaG8WSDtvcUFiLlAUovUUoy7Hgvb9M5mE
	WPLy81KlxHlTQIoEQIoySvPgVsASyitGcaCPhXnXgVTxAJMR3KRXQEuYgJbM//MIZElJIkJK
	qoEx3rx2nvu3791WAlLzApYavlVKWbVv6auuWYv7d+9dpslr82DXgt5ny85dn9D48M2i+Fui
	cR/nSO//ImZ1Nenw6qBzibNNDk/10lv4QPvTHwfdO8efnrk9OeuI/SUZNb0978TZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263962>

It makes no sense to delete a reference that is already known not to
exist.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index b9cf284..d5bfd11 100644
--- a/refs.c
+++ b/refs.c
@@ -3702,6 +3702,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
+	if (old_sha1 && is_null_sha1(old_sha1))
+		die("BUG: delete called with old_sha1 set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_sha1, old_sha1,
 				      flags, msg, err);
-- 
2.1.4
