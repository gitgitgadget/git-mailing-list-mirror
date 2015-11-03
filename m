From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 16/25] refs: move head_ref_namespaced to the common code
Date: Tue,  3 Nov 2015 08:40:00 +0100
Message-ID: <49cf53c5dc2bc96a79bf07203ddeb01836c8a937.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWD0-0007Um-S5
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbbKCHkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:43 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48281 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752929AbbKCHkf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:35 -0500
X-AuditID: 12074411-f797e6d000007df3-f8-563864f3b54e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.B5.32243.3F468365; Tue,  3 Nov 2015 02:40:35 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdD016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:34 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqPs5xSLMYPNWbouuK91MFg29V5gt
	bq+Yz2zxb0KNA4vH3/cfmDwWbCr1uHhJ2ePzJrkAlihum6TEkrLgzPQ8fbsE7oyLr9exFLTx
	VZx8f5e5gfEGdxcjJ4eEgInE7xf/WSBsMYkL99azdTFycQgJXGaUuHh4GwuEc4xJ4teEh+wg
	VWwCuhKLepqZQGwRATWJiW2HwLqZBQokZi/dClYjLOAt8fdDN3MXIwcHi4CqxPs5NSBhXoEo
	iUs9F9khlslJTLnfDjaGU8BC4sHdP2BxIQFziU33lrFNYORdwMiwilEuMac0Vzc3MTOnODVZ
	tzg5MS8vtUjXVC83s0QvNaV0EyMkdAR3MM44KXeIUYCDUYmHd8ES8zAh1sSy4srcQ4ySHExK
	orzrYizChPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwFgQC5XhTEiurUovyYVLSHCxK4rx8S9T9
	hATSE0tSs1NTC1KLYLIyHBxKErwTgTEiJFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqS
	EQ+KjPhiYGyApHiA9q5MBtlbXJCYCxSFaD3FqCglzjsZJCEAksgozYMbC0sIrxjFgb4U5r0A
	UsUDTCZw3a+ABjMBDQ7fZgoyuCQRISXVwCi4+Nj/QAHTUP5p3z7V73RykprYpBt99Nm/hxrF
	px4Y33z9Nij6k/ym7VNXR6fsE+0sWHXZZO3717O79MNb7zRUb1z0z0TO+1kT56/U7LsisUob
	nee2yv6yt5D0u6zddFXqzuq9/L3/1/FOuGb/2bR0WR/rb6Np21x37/ROTypJ+ztx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280761>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 15 ---------------
 refs/refs.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 53f69f3..728e646 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1952,21 +1952,6 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0;
-	struct object_id oid;
-	int flag;
-
-	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
-	strbuf_release(&buf);
-
-	return ret;
-}
-
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs/refs.c b/refs/refs.c
index 9644df6..6af5fd6 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -826,3 +826,18 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 {
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
+
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+	struct object_id oid;
+	int flag;
+
+	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
+		ret = fn(buf.buf, &oid, flag, cb_data);
+	strbuf_release(&buf);
+
+	return ret;
+}
-- 
2.6.2
