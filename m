Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A9193078
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378461; cv=none; b=gpqayDj9b16Wo5BDLAcBS8qrcYYIomtTOBRlg/KyotiKqrB7+pr16vRZxTVLHpU3JCQrMMOHXopAUsxDqJ2bQgYni1a9ELcS597cYNEEYGnzMTup9dSWzw0pzuvhdCboZR4ior+Pysok6dxcpH0MD8sdmzXf1gKtyj4uzzzMJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378461; c=relaxed/simple;
	bh=32sBjvg21ZO0HleeipYag+o4qGPdYHHCqGOuRLkrWCI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=YN7koToILpvGrajtPCFp9d9XNLcU/NlExIUR2kdKDKohdlx+kkd9eWc2RJaC7C561VgYTW1v0e3T44JVth00ug+57eVKqWnhsR0CiQnunmT08JT1QwblvK/7T9yq8hHDFs8MGFE0poC58xXzsm7iyv9VCZdTeHGyCG0EIacuGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=kGtSfU4m; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="kGtSfU4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=lvShIfDiIEo2Iq3YK73pd6dhV6FONGDeZNRYgyDY4Qg=;
 b=kGtSfU4m+alHT/bxyhyQa44zXJbJq6OtLXKqJR2VjWOqIN4BrdXU5dSP4W5zHP4bswEy6S5pteix
   oOVUf8RQMiraZ1gt/KuX3lUTjLJhb782KYEhUR6Wv3qA3vJ2DW/8ky1gupLiXHqNOZ2GPRWUulhA
   /G1kz1Itnj9Opwqb/jgTzjX6w4aVwDEpW05OBylt+Bx6i34UjX0WqyLzQypCe9+AvHwfnFKBmBu8
   M4C6jvQt4HPD3EdZ0DtbrgHkg+TbZMjB1ucyTgz3lmM882dNIOzBnm8f1OIBInb/uXEKfbZmRML2
   zxx3udHHNnO5/W68Rl72xtLjo9ipHfCgLXgLfw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM002QWKYDV990@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:13 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v9 3/7] remote set-head: refactor for readability
Date: Sun, 20 Oct 2024 00:53:10 +0200
Message-id: <20241019225330.4001477-4-bence@ferdinandy.com>
In-reply-to: <20241019225330.4001477-1-bence@ferdinandy.com>
References: <Zw8IKyPkG0Hr6/5t@nand.local>
 <20241019225330.4001477-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAE2GdbF+mCcWjovfScOg+z3IZUY0hnhSpQctsQOhAOWKoxa7Cyuo8IjDh0hOxf1
 h7tysrbbirtWtpX0pL9oTOzCg+GfvzfDXgwp0zRIWbfizp+T0MOh3p8x5Flu2tvR
 LjCAaa+EFltHEgx9BQuMw8N7MkH21Ae9IGgJFbLgI/kGBpwM7JthAqD2JbGQ0RMf
 /IQel3QGy7O6hrPbA6ds5nxTmdpMosQubQUDlc/yWxfmkWUArcpC5pxEsufuEmMg
 n9deNuFy7BCR14YJcrrqh3tKVtCbmVKIYirjzcZo/lQtcNe9Zw/8iLafTkQ4218O
 l59fZ0R51Nr5r7i/p2DW84YmaRu/kAYj9mEzRULOe4mY1ao/cfoKGAFk8JMwnkka
 tqJ5R3Qo7oNki6G3c/uiD7v3IeexhKh7/2MmrbBK/G5+jdsJnlTqbV6DMt8Xxq3x
 p5O3iIT5SYK6KiQYo9jOT0RaC8w0vEfKfc+Ow23q0YG4Bkz8iMuPeo4b

Rename buf and buf2 to something more explanatory.

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store in a new refs variable. Although this change
probably offers some performance benefits, the main purpose is to
shorten the line lengths of function calls using this variable.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v5: new patch (split from the next patch as a preparatory step)
    
    v6: no change
    
    v7: - change commit prefix to be more in line with project standards
    
    v8: no change
    
    v9: - further improve readability by renaming buf, and buf2 consistently
          with how patch 6 was already done

 builtin/remote.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 76670ddd8b..1d68c5b2ba 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1402,8 +1402,9 @@ static int show(int argc, const char **argv, const char *prefix)
 static int set_head(int argc, const char **argv, const char *prefix)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
 	char *head_name = NULL;
+	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1415,7 +1416,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
 	if (argc)
-		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
@@ -1434,25 +1435,25 @@ static int set_head(int argc, const char **argv, const char *prefix)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, NULL, REF_NO_DEREF))
-			result |= error(_("Could not delete %s"), buf.buf);
+		if (refs_delete_ref(refs, NULL, b_head.buf, NULL, REF_NO_DEREF))
+			result |= error(_("Could not delete %s"), b_head.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
 
 	if (head_name) {
-		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
-			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
-			result |= error(_("Could not setup %s"), buf.buf);
+		if (!refs_ref_exists(refs, b_remote_head.buf))
+			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
+		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
+			result |= error(_("Could not setup %s"), b_head.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
 	}
 
-	strbuf_release(&buf);
-	strbuf_release(&buf2);
+	strbuf_release(&b_head);
+	strbuf_release(&b_remote_head);
 	return result;
 }
 
-- 
2.47.0.92.g83fdbe24c3.dirty

