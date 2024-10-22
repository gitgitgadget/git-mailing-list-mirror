Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4514EC55
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626586; cv=none; b=FnSHhTIefwgzKbEgA6VGu/DulNrjwp2Ql2jtac7DRNbI2DBXp5y1jwmJ4uyOWhhTT2slnN6B80IV7yfbDiCavSlsHH0Oma3Szx0dWejr9b+uhCNfjrILWCXLXV/BfNjDJc6g68qxnBb3nfO/P4LAFiPGbQ8WI7jw7XI+S19XA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626586; c=relaxed/simple;
	bh=rAoegY0N8I1GgIYsvlRpjR4+uot64LI0uDAvvDfU53U=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Bdzl55fqyOtrjh7HbhB16F2bYC9FI85KhhQY1k3ILivo1cDB6UNDfvbb38LpBSE0DCgaYEN/Fl0Q6lfpwvRC1AwK0gwZABwQWFJ+A7scbNznQ45dGeT8eLQHOYxohFW6efy4KpVLW0Ug4enYveaok2xrxVPo/YVpcJESlNKZcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IHjZ12+L; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IHjZ12+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=m4CrtxU9BBiXcF0zLhzLpmvg6VEP6ojE1ZctA+SPDR8=;
 b=IHjZ12+LXfsMaQM1+jFJr54qB7vPGJ0104hKpD+WKJF79YoqUtnZOcSEPazgrQsZjn2OCR6/bZQ2
   PpVFLgapz/MCuw09NC90xZbSKM8mH/kEa35isYWWgXCSBAF8lg3OkuudZQvGFhstm4/OkD2Pd5EX
   qP4GOaXreNxHktHv0zqGBfg4cwwrKiuNmihzOiOkDU9MeHO4zoEMGXA4hzXqW6RuhieNOcFtghCH
   kSoLTDRoZeNWto2SRogCZ5nM+gvmDYkCn4KgyVO9csx+C/npoDalgat0FmNrtmLVwbJeApGR9RTc
   92iuuSfC48+dysFW6n4Y7IZHHzUrX5zTMqNAHQ==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR006PZWEOGZ90@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:49:36 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v11 3/8] remote set-head: refactor for readability
Date: Tue, 22 Oct 2024 21:45:40 +0200
Message-id: <20241022194710.3743691-4-bence@ferdinandy.com>
In-reply-to: <20241022194710.3743691-1-bence@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAEaY43CsX4NS5gnX13mxeflHPj4BoTX7uiPTxCe+2EPNdQOKX973DeBaZxpBN4U
 b0AA7+5xFQF/if8asuoVYmPxeYf7X5xNvraYr1yGdgXU6EPwMwYfYQhiQUtGmawW
 kdUJ8wUrEZNwCuK2ad0/ZBcgQrf9kY3KGshYSewvI1eZFKXGNuG7RjX29Y2vtnXi
 IiAJikPbfoYa5jXnuZ6LqUGR+E9k8IGGiz7j5zP4bWBULjx7VkcAFNNVDlJyUkMv
 wIPGYccRDlqj1/BbeZ4K/nQJrSmSx4jBdWVMpulMh9ejmtLc9FdAp8EUtnSWA4M2
 wFa5D/yamLNOmQtKPONOCWVpNtS223c5b2iURlGDmorlyzWoATlzG9BMbTy6/WJY
 qAvTx74xMWxH+fKkVWyUm65RapZ8ApEN4OK7v/7OyJLbNWmrjZ6250+2+ntpW454
 ZO0AneUVNAPgGPl8+an9e4L3V4FyFUgQxETm/5FxA/TfHUGe4lMbkJoY

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
    
    v10: no change
    
    v11: no change

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
2.47.0.94.gb64850d498

