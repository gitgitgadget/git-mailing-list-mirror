Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FF1DE882
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278775; cv=none; b=uzhlWyBtSOjw4ijs6JGmcLoJ/fh0thAq/rxJsX6gtQTWKPFFkwoadYIEROrf2tinftWutM8reSbNs03KfJAgMn47W+LChtDfpQ/dgU/hZAnz1ACxK3JTjSiNOIrPlDDeFY26FaRvmymlDgFmBYKLRo7u7wFVOERr1ePbS6uA8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278775; c=relaxed/simple;
	bh=rXbchmTmY3jCahx7i+deCMtNn8+ZuWCFspEQ9lixr48=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=nRVkqxHZHN7Nvux3TkIyNse4pZ9LiKEkYCNcSsprTa4/tjEsRKgfLvb9sm7hLRg/mKNLgTF9HGRK5hXup5K30JhkmMbHWC/sX+KdJFJ8TNjapDwjWAkt0bixqK06M/t080nyu6cPBtlM/VLANCFricEIczarwewaCEH7hhWrvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=a4RDGXHB; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="a4RDGXHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=jmY+Y0f5ynAegZpHkOwNewLJGIIb4XxIgR6u0bwpYp0=;
 b=a4RDGXHBX5SZqDKHCCi5ztGWqjqKrCb+FMHUxG9cWtC/cTSUH0dtt8IIrBuUtEwZxGUsOcjQ6sal
   qacqORPuYvTdAXFGzwt9rkzX7WuO1UyRoOIy9gqgLGJUuP+l3WodzeWg7a6qP7ccA/sP4Ggjhsz1
   ubH6q0IzyCMF+ltkmsyQBtpd4gEnCq15KYy3R/FFfDsrmC0nGk30IjjQPuLP3+C3FH2HiadXUAQ+
   KziZCDQjud4/+UY1QC09slGnvOiaKjhCTg2YjvxdEplNbRVCzX6GRHxAalaM93RsHuibUCmZfBg3
   nv/FQEhVMNIRJ9MqrQOGKPX1TcWP5hpqCuJSOg==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00LQIQUR6PB0@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:32:51 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 05/10] remote set-head: refactor for readability
Date: Fri, 22 Nov 2024 13:28:46 +0100
Message-id: <20241122123138.66960-6-bence@ferdinandy.com>
In-reply-to: <20241122123138.66960-1-bence@ferdinandy.com>
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHPmg53zA5rWzJswmd0gUM+aW2QZ5S71jt8DkyZjMJTtCE6MlFfLVcEzwuGFcay
 04gdTC0WXFhQikV0a2wpcJrH+DS0/QWikdh5lx22DPqVIjurJm/mtCZ15Jyer+8L
 nP7edMe12zevqeacfpK58DBxvHUC7mmsGptlLNis5FQXBsWpAEi6UzMCQd4Id0AX
 MmizGES23NoD2ba0eaJC+AwSIXL471ML+4vL1xsJ2in8VCrhmOxLgems7MsWY0Yk
 4E3IZqwrAS9fW7ozJPWT31tDsAsJwHTSxiOyQeyJuQpKD8KvS0LH1Nk0ejpzpaPK
 3uOnWFIE/H95v+8/vnblYSGpib6wkXJeRGZzNh7ohg3hCPnvaZV8MzWOSSvSVlbb
 VlCZ+6f7ecPMurEWWoCKXt3TSf5z1ugQWCWIfKbHX2l+yootn8xaoOUtqjdcWuvI
 eria9mVOh5INbYkhqVLCwo3/cg+7gK1QmlgIpG9A579hyW7T9ubnyuQ=

Make two different readability refactors:

Rename strbufs "buf" and "buf2" to something more explanatory.

Instead of calling get_main_ref_store(the_repository) multiple times,
call it once and store the result in a new refs variable. Although this
change probably offers some performance benefits, the main purpose is to
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
    
    v10: no change
    
    v11: no change
    
    v12: no change
    
    v13: more precise wording for commit message
    
    v14: no change
    
    v15: no change

 builtin/remote.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 8bca3fb04e..47ca650de8 100644
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
-			result |= error(_("Could not set up %s"), buf.buf);
+		if (!refs_ref_exists(refs, b_remote_head.buf))
+			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
+		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
+			result |= error(_("Could not set up %s"), b_head.buf);
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
2.47.0.298.g52a96ec17b

