Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBA1D150C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946539; cv=none; b=ZGB3eZp9MLEpx+NY8EYhk9q97yZCSc4O85kU3qsnk9fLQpb6nJpaHA8JU1wFo7lAvmuIxAwPZUWBO3aZmISFSPrBQTMRDKnv2HbcN2jKboHTy6pMD4kE6J+qjQ4nox0dpM4hddtRiATeauT9pVFyR+IFG5KT4sMjlnVn5ruW+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946539; c=relaxed/simple;
	bh=gmhsJaXOBW3wMdcHdUF47yIz5h5aTnzuOq3cVS63nxA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=eNYr2oJMicVitt2LWkTMC4hBJfIxAviEQmh8KqQ1qywT32Z1hSwEkHe32IJCuZkNEaaqYKhzK5mAdTUxYLrnl9hyulOXTVCXp2olNA3bt6299KVOxx4xRb1rLtOAdMAXsvHxjgN6/LiZlU2iwcutrLeiBd6yHHblpYtFlxMMn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=o/QY/Q2E; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="o/QY/Q2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=13kLsyyvTUo3TQFyhL/nr+TFa9nY5TepCu6PXcrzVkY=;
 b=o/QY/Q2EhvlOaTKoC9wmqHJmH32JzIKbhJ6n6+1pBYVN8RayehIYPr36XPdaSMtd45IC91Y7IrgO
   xeTdQWZ7XGOH6U41Uq4AKrnDZS7iKz+3F029QNasR4uzpyx4VSINVq8IV1khgzkQaZD0qvSPMWdd
   IPCe+rgv7MgabOk4nFB4+u/eRFjp9YZbQUSjNzYsd4LPLjzQ6CGe2OQXp9+j3//qAi0pcKNFqVHs
   L1DoG5rBRvLxiD2cSnL/xcLK4zcjXiyhqwaAV4aBWpjPjAV0jW2fVYRNHqQ5KPFue/IMt0j5Kscl
   kszhBoRy+oyspwF4qdLJTbGlf0q9usVI2GT9Zw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLD003LMBOITI80@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 14 Oct 2024 22:55:30 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	karthik.188@gmail.com
Subject: [PATCH v8 2/6] remote set-head: add new variable for readability
Date: Tue, 15 Oct 2024 00:53:11 +0200
Message-id: <20241014225431.1394565-3-bence@ferdinandy.com>
In-reply-to: <20241014225431.1394565-1-bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGcuVeOwkX3W2cLsPbVZLkAlTmB2rPTAs2X0MxsxKf4JHeph2UTvCBUpG9DynqP
 BAMwpCbQX7N2fsaWFaNCub7VRSd+4CjzMyXodx/KT9msStynRRvu59dg1j3Olk+u
 UJ1z4jI1iTPpf0A70bDgFmAggYDfhtRbxD8fmkv1h5Pbf2c4Em9cyPjWYIsewJve
 /WTXXzSOyvE6qrtnLvWWkz6rBXTQwPNFTqymxOp2Rr2NqNjdISOZ/AOzdllj5zbF
 kX7eBhxZfKcvgrtBCHJCExnhFffnFDi44DECEOzm4eVcplrfGzUqcR9Lrl5/8mOV
 eahdNA0hhe7OCvadwvpTwgJPki27iWU+QQZThLl50iqkPeBbg8vtST0Rr0acx0Eo
 JjQDtvcYm3wBkuWtV2U1jtVCkUx8SWn8XFuv2cyYeENoniW81fJLWiTtcTrof9de
 PtXQ6k23i0H9ugjv3rLcQ1XEVyN1eK0spjn4mFLVGH6CWTO+/6wul5ff

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store in a new refs variable. Although this change
probably offers some performance benefits, the main purpose is to
shorten the line lengths of function calls using this variable for
better readability.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v5: new patch (split from the next patch as a preparatory step)
    
    v6: no change
    
    v7: - change commit prefix to be more in line with project standards
    
    v8: no change

 builtin/remote.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d8ff440027..353ffd2c43 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1404,6 +1404,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	char *head_name = NULL;
+	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1434,7 +1435,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, NULL, REF_NO_DEREF))
+		if (refs_delete_ref(refs, NULL, buf.buf, NULL, REF_NO_DEREF))
 			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
@@ -1442,9 +1443,9 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
+		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head", NULL))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", NULL))
 			result |= error(_("Could not setup %s"), buf.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
-- 
2.47.0.7.g072c39eddb.dirty

