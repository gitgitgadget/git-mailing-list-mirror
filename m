From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/13] ref_resolves_to_object(): new function
Date: Fri,  3 Jun 2016 14:33:48 +0200
Message-ID: <d7a116ad608aa733c712870c1d6759165811756f.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oIw-0005Ac-1R
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbcFCMeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43782 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932263AbcFCMeP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:15 -0400
X-AuditID: 1207440d-bb3ff7000000090b-99-575179473341
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 84.B1.02315.74971575; Fri,  3 Jun 2016 08:34:15 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtis005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:13 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqOteGRhu8HizkMX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDNe3HrLXvCYt+Lrk2eMDYx/uboY
	OTkkBEwkzu+8xNzFyMUhJLCVUWLavsVQznEmiaaVT9hAqtgEdCUW9TQzgdgiAhESDa9aGEGK
	mAXmMEncftjJDJIQFnCQuP7qIVCCg4NFQFXiTFMSSJhXIEpi2ayj7BDb5CQuT38ANpNTwEKi
	794PsLiQgLnEwzm72Scw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJ
	ERJ0vDsY/6+TOcQowMGoxMPLsDggXIg1say4MvcQoyQHk5Io7/mzQCG+pPyUyozE4oz4otKc
	1OJDjBIczEoivH8KAsOFeFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoS
	vOYVQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoBiILwZGAUiKB2hvBUg7b3FB
	Yi5QFKL1FKOilDivMEhCACSRUZoHNxaWSl4xigN9KczrA1LFA0xDcN2vgAYzAQ0ueOQPMrgk
	ESEl1cA4OUdvp9qahm2rdOoiY6t/eP/zjN80lTm3yUT+ZUM398IynbsnVs1JvPFG3cyc21l+
	BvO1SY+vMQjmLhH5O6tny7UTH7viFm5226fk+Cskycvql2qda8I+q+0qm3erJtrP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296319>

Extract new function ref_resolves_to_object() from
entry_resolves_to_object(). It can be used even if there is no ref_entry
at hand.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1a46f32..8ab4d5f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -513,19 +513,32 @@ static void sort_ref_dir(struct ref_dir *dir)
 }
 
 /*
- * Return true iff the reference described by entry can be resolved to
- * an object in the database.  Emit a warning if the referred-to
- * object does not exist.
+ * Return true if refname, which has the specified oid and flags, can
+ * be resolved to an object in the database. If the referred-to object
+ * does not exist, emit a warning and return false.
+ */
+static int ref_resolves_to_object(const char *refname,
+				  const struct object_id *oid,
+				  unsigned int flags)
+{
+	if (flags & REF_ISBROKEN)
+		return 0;
+	if (!has_sha1_file(oid->hash)) {
+		error("%s does not point to a valid object!", refname);
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Return true if the reference described by entry can be resolved to
+ * an object in the database; otherwise, emit a warning and return
+ * false.
  */
 static int entry_resolves_to_object(struct ref_entry *entry)
 {
-	if (entry->flag & REF_ISBROKEN)
-		return 0;
-	if (!has_sha1_file(entry->u.value.oid.hash)) {
-		error("%s does not point to a valid object!", entry->name);
-		return 0;
-	}
-	return 1;
+	return ref_resolves_to_object(entry->name,
+				      &entry->u.value.oid, entry->flag);
 }
 
 /*
-- 
2.8.1
