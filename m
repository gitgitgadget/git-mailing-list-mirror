Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1991946B3
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729455943; cv=none; b=EK0XBMTZBvZLMcap5s79sOIF1uuy2CQiWcwgqJsCWqxCQet5JcxI0ofwS0iAJlrlG1rMV/q5PyDyO3pseDFW9GfenjklVuRU0SoOQCUYU9LWoPzvb4hC8krcEZ5IExSEJmHUf13StRlMRqGB3O+dhy03tKlYQR4XhcX6R/YrSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729455943; c=relaxed/simple;
	bh=ptSjux7QZfJGhTmzwwGwOb9tNSLv2CBo8YaNdkxkSfs=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=YoDW1JRWM5Rf6JD0+Ci+vomTiHp5WjzGnIGvEKedSBM0W2OQnMfrmAfyZtKtG/hgNHvWbbXe6a4hQCNp8xGemMJhykNvcaYynVNcE5lNwd/uweZlcCgEk/H/5sy5JoaAphcrqeCFv9yK2JZkVTyB20iIjAVGWVgPxbPgDVi94yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Je0xmK7e; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Je0xmK7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=vShDr6nzSfAwQjeSFoJ9uxzbfHDzHXiW7B6yzkx9yjc=;
 b=Je0xmK7e4jx6wc1j+11BFH4HbKqu9saMNm96edU7c5HMeegV6GbH9wigHBm/PMmaAA2A44NjHEwy
   dw6l6zp2UKnGJokvzP11gxNCrFTcamMHpUFiwLQOK5R4EvY0ma700JpHX8JduzsHVFHsyZ4mOmHH
   3RqObJkilhJKBtcUBaL2QA/HTdRpm/V2pwp7nq5KPLYbnOL1P70FRVPTL7lv99NxSE7dxPa6rac4
   z/+VHkOEjvoTvrRJDn3e9xn70Vgx+Jilmp5gtze6jfLvX3qbZzoLGi4kjG3F+Slw/Qy4rUMraexw
   s60qqAtz9E4EMn+3dG5csUwkkmKOq0eR18kOjA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLO0076C8QS7W30@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 20 Oct 2024 20:25:40 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>
Subject: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Date: Sun, 20 Oct 2024 22:24:48 +0200
Message-id: <20241020202507.2596990-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAH3D2/l5r9c/iY69S+A4TX5yv9CZU9F8ev3mnv253ZGlKzn4RbnUBnZvZj8tBqi
 FCQrEDGoTU02yhfoDneholVZ+H6N11jVPz8j+RXd6AuYqelfT1qbmYAR20UtOeuH
 p+UynsWIT5dMIwjwsnKwT5EkIj2/TqDJ2Tg245ByBoYfdMXG7iRmFJmbwtWZkUo3
 CwqA9hlI8SbrD5jbPC7O7vpAxV5kQZj2cuaLSJEqskvEE+JUs/Hv+4Ei7ZCU6ZCj
 sZKQkXl/Z05O84EFnTKesgI9gsIx7RXBDtTwaofO7iyFdGo2a6nj59t2xxwcUXBA
 AWMW1FAl8bqTlSsZDb+V0Ka2uBQfgeOdKF7IICVvrcnib2QCPNfezDCNNo/hthPV
 vKz+w/4rxcegZNse5Nhze28utzLDJYatfampIcJqD27TRA4SYGyOqTikWsHoDFzI
 ESMhcYhCShIaYWMgSxa0ok/CCU/GdExqI2+znLGlsVTGC3blccER1pk=

The HEAD of the remote is useful in many situations, but currently one
would need to know the name of the remote to perform something like
"git log origin/HEAD..", which makes writing remote agnostic aliases
complicated. Introduce the new shorthand "@{upstreamhead}" which returns
<remote>/HEAD for the same <remote> "@{upstream}" would yield.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    RFC v1: Testing and documentation is completely missing, I'll add those
            in a v2 if people think the patch has merit.

 object-name.c | 15 ++++++++++++++-
 remote.c      | 36 ++++++++++++++++++++++++++++++++++++
 remote.h      |  8 ++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index c892fbe80a..f40a226a57 100644
--- a/object-name.c
+++ b/object-name.c
@@ -936,6 +936,12 @@ static inline int push_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
+static inline int upstream_head_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{upstreamhead}", "@{uh}" };
+	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
+}
+
 static enum get_oid_result get_oid_1(struct repository *r, const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
@@ -985,7 +991,8 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 					continue;
 				}
 				if (!upstream_mark(str + at, len - at) &&
-				    !push_mark(str + at, len - at)) {
+				    !push_mark(str + at, len - at) &&
+				    !upstream_head_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1729,6 +1736,12 @@ int repo_interpret_branch_name(struct repository *r,
 					    options);
 		if (len > 0)
 			return len;
+
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
+					    upstream_head_mark, branch_get_upstream_head,
+					    options);
+		if (len > 0)
+			return len;
 	}
 
 	return -1;
diff --git a/remote.c b/remote.c
index 10104d11e3..302f013a25 100644
--- a/remote.c
+++ b/remote.c
@@ -1980,6 +1980,42 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
+const char *branch_get_upstream_head(struct branch *branch, struct strbuf *err)
+{
+	struct strbuf retval = STRBUF_INIT, refstring = STRBUF_INIT;
+	struct string_list l = STRING_LIST_INIT_DUP;
+
+	if (!branch)
+		return error_buf(err, _("HEAD does not point to a branch"));
+
+	if (!branch->merge || !branch->merge[0]) {
+		/*
+		 * no merge config; is it because the user didn't define any,
+		 * or because it is not a real branch, and get_branch
+		 * auto-vivified it?
+		 */
+		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname))
+			return error_buf(err, _("no such branch: '%s'"),
+					 branch->name);
+		return error_buf(err,
+				 _("no upstream configured for branch '%s'"),
+				 branch->name);
+	}
+
+	if (!branch->merge[0]->dst)
+		return error_buf(err,
+				 _("upstream branch '%s' not stored as a remote-tracking branch"),
+				 branch->merge[0]->src);
+
+	string_list_split(&l, branch->merge[0]->dst, '/', -1);
+	strbuf_addf(&refstring, "refs/remotes/%s/HEAD", l.items[2].string);
+
+	if (refs_read_symbolic_ref(get_main_ref_store(the_repository), refstring.buf, &retval))
+			return error_buf(err, _("%s does not exist"), refstring.buf);
+
+	return retval.buf;
+}
+
 static const char *tracking_for_push_dest(struct remote *remote,
 					  const char *refname,
 					  struct strbuf *err)
diff --git a/remote.h b/remote.h
index a7e5c4e07c..a1d0f44297 100644
--- a/remote.h
+++ b/remote.h
@@ -360,6 +360,14 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
  */
 const char *branch_get_push(struct branch *branch, struct strbuf *err);
 
+/**
+ * Return the fully-qualified refname of the HEAD branch for the same remote
+ * that "branch@{upstream}" is on.
+ *
+ * The return value and `err` conventions match those of `branch_get_upstream`.
+ */
+const char *branch_get_upstream_head(struct branch *branch, struct strbuf *err);
+
 /* Flags to match_refs. */
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
-- 
2.47.0.94.gc947641c25

