From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 10/11] files_log_ref_write: new function
Date: Mon,  9 Nov 2015 18:03:47 +0100
Message-ID: <b017ec518536e9f21c2900b3821b40a8a3a8f375.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:12:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvpzM-0006hc-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbbKIRL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:11:56 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46283 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149AbbKIRLy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:11:54 -0500
X-AuditID: 12074414-f794f6d000007852-db-5640d216be09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DD.2D.30802.612D0465; Mon,  9 Nov 2015 12:04:22 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yx026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:20 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCt2ySHMYMN8IYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xOrA7vH3/Qcmj52z7rJ7nD2Y6fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO+Pdko8sBRP4Kta/Oc3ewHiFu4uRk0NCwETiwo3v
	bBC2mMSFe+uBbC4OIYHLjBJXflxkgXBOMEl83XOXGaSKTUBXYlFPMxOILSKgJjGx7RBYEbPA
	R0aJuT8WAiU4OIQFrCV+ftYAqWERUJX4vGUCWD2vQJTEo7Z+FohtchJT7reDxTkFLCR2nPjH
	CGILCZhLTFy1hmkCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCGh
	J7KD8chJuUOMAhyMSjy8ETPtw4RYE8uKK3MPMUpyMCmJ8kafcAgT4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMJbsAsox5uSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwZt8
	AahRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQb8cXA6ABJ8QDttQVp5y0uSMwF
	ikK0nmJUlBKHmCsAksgozYMbC0sorxjFgb4U5jW4CFTFA0xGcN2vgAYzAQ1e6g82uCQRISXV
	wGi9YYqJk7nhcbF4S6fvty6F3upPY6lfvSX8cACP+mpXNndbvrUx008fUN5/Xmkel0zy+9LM
	oG7eiavsN221l/rjYS0fnJ6YeFw564mRbsLF4w9ml4eLH3Lj663/vz8+bJ+QldLL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281067>

From: David Turner <dturner@twopensource.com>

Because HEAD and stash are per-worktree, every refs backend needs to
go through the files backend to write these refs.

So create a new function, files_log_ref_write, and add it to
refs/refs-internal.h. Later, we will use this to handle reflog updates
for per-worktree symbolic refs (HEAD).

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++++++
 refs/refs-internal.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a2e5a56..1094348 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2735,6 +2735,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg,
 			 int flags, struct strbuf *err)
 {
+	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
+				   err);
+}
+
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err)
+{
 	struct strbuf sb = STRBUF_INIT;
 	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
 				  err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8f5cfb4..88a5be0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -179,4 +179,8 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.6.2
