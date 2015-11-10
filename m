From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 09/10] files_log_ref_write: new function
Date: Tue, 10 Nov 2015 12:42:39 +0100
Message-ID: <1acf1e54243bfc12adff878b1f454d3847ed198a.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7Kg-0000gn-VY
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbbKJLnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:13 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60562 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129AbbKJLnI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:08 -0500
X-AuditID: 1207440f-f79df6d000007c0f-ce-5641d84b993b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 50.08.31759.B48D1465; Tue, 10 Nov 2015 06:43:07 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABgljD014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:43:06 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqOt9wzHM4F2/isX8TScYLbqudDNZ
	NPReYbaYNOUmk8XtFfOZLX609DBbzLxqbdHb94nVgcPj7/sPTB47Z91l9zh7MNPjWe8eRo+L
	l5Q99i/dxuax4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDOW/YgtmMBXcf/RHdYGxivcXYyc
	HBICJhIPD99gh7DFJC7cW8/WxcjFISRwmVFi3/1GZgjnBJPEvZZpjCBVbAK6Eot6mplAbBEB
	NYmJbYdYQGxmgWVMErP22oLYwgLWEpdf9rF2MXJwsAioSnyb7Q0S5hWIkri0/wULxDI5iSn3
	25lASjgFLCTmnssACQsJmEscb5/IOIGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO9
	3MwSvdSU0k2MkDDk38HYtV7mEKMAB6MSD++Ebw5hQqyJZcWVuYcYJTmYlER5959yDBPiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwmv/AqicNyWxsiq1KB8mJc3BoiTOq75E3U9IID2xJDU7NbUg
	tQgmK8PBoSTBy34daKhgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KCrii4FxAZLi
	Adqbfw2onbe4IDEXKArReopRUUqcdxtIQgAkkVGaBzcWllxeMYoDfSnMywaynQeYmOC6XwEN
	ZgIavNQf5KHikkSElFQDY/OCj2e5vNt9XfmraqdoJCow+gstN4xT59x0n6Pi77LGGUoFjYG5
	wrqZzI0mmlNyM5wMjz3dfO73vg8afFq/Mx37b3ppu8tUM392knTqeHtC9J1psk1u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281112>

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
index 14ec506..aaf2639 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2734,6 +2734,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
index 9077c11..7b6c8bc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -177,4 +177,8 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.6.2
