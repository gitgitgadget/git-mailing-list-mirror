Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE4171088
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278782; cv=none; b=HiKiO5FExHo4EHZqgNEo2Z67gGMUJkSlNDzvq1LmDn6vkjWImDflWqV08wFe5j3X9OHyiqODL9DE0WqnCN4GX23ShAY8LSOvX3SsMNXpGwJX21A82D8LppGiHzZwgvoiMbRKblJzPmZ7uP2q3SsMWwmKHeLQp+1AQ//r+eH8nCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278782; c=relaxed/simple;
	bh=uOiFThTXmBuQlkaFYZ3JcNtAmXJSSw4seb5EGtE667c=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=tW4pD00Q10L9C5VVn596koD2pjlpDcnW4DIbJvL8S1Iz+wv5GXHinuKgmXQ8BNMI39DdgRwUCBfJlCVRCFqIiIT+T8QImBTo6kbJR1UKFPkS0DYB/S9RJzHvWXIdCTeOQbHQWjQOx3pTLkYunu8MasvkDNFAbEjgF0piHVhBClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=FgJw+vQD; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="FgJw+vQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=pW155Tyzkw1hfbQWTBK2wqhAjVlNE0gEixj3aPmAk70=;
 b=FgJw+vQDAvEnan8ij9LVohj5K9HoKIr7ijFj5RkSy3fWqEuzcB7Z4/QoZ+Z606jYrzljBSAjOIsd
   TbRMZ3LV2T9yaS4qxRlNR1NGe+aGNolttn9eUSkEQPq/b+RdPNRdf/CAV2HrxETr3AoEmo+okz5G
   Hv83GmQp/HNVOwFiBDWuNUJqXIVAbQgDXamDeCr1rCyg6HgxfTIrgMljRdP+XKQ/uxXRRybqCG2S
   QN8PYkhFDdyivIbtfQ8f+3WeKlgyXO7HTXa1Ij4hhPsM4opj3wMs0hdAxD8Rh18YHLy8CxsFcXly
   O1eGg+VXS/giCc1RdX+yNk9Qaut9N5tPGiz/og==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00IH3QUYOC70@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:32:58 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 06/10] remote set-head: better output for --auto
Date: Fri, 22 Nov 2024 13:28:47 +0100
Message-id: <20241122123138.66960-7-bence@ferdinandy.com>
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
 AAG/BPE2Gx8pkLvG8hopB4zX7FvKjrqK44Vl5GFUxSCbTi05zQ93/fmccNGAJtv9
 Ul6VMUbN6v80/W7C6h5WX+CTQkZJwKy9KOV3NdVvKrD9FxlxKp9azPJhkvXrj8sE
 37GkXMKmJR2z3znPgZ6uhiKvRf0HbZMgMxA5GPWNlGLgIIuG540SfcbmLwW53Gh2
 vB601eYn0eol+K42QDebTtQqMGXFBTcWA3wEbzUcRsOtE3nbW4AmX+40z9B50g1q
 GNNwFwFCjcwSbO65sCk/hoFYHu8WH9GPA0OoHstEu8nj3DaZXzK5ka9VgWTJJzpE
 hZEKzs5IxbIV/gdz+GhYJEdx6bQvlEvxnmWHIbD8CSm+odzJz8pux2SJoqyGqgDZ
 JXWlGzBg6wOFRx+jYj14cKFpdKIv0jhMtBc7QPsSSg3TTl2T5KJr3XaWFZhhG4gr
 UIg4H0NPboOod4407nNPR5f6ieeSawx8ptQYMowGGGEhhMuEhy88G8M=

Currently, set-head --auto will print a message saying "remote/HEAD set
to branch", which implies something was changed.

Change the output of --auto, so the output actually reflects what was
done: a) set a previously unset HEAD, b) change HEAD because remote
changed or c) no updates. As edge cases, if HEAD is changed from
a previous symbolic reference that was not a remote branch, explicitly
call attention to this fact, and also notify the user if the previous
reference was not a symbolic reference.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v1-v2:
    
        was RFC in https://lore.kernel.org/git/20240910203835.2288291-1-bence@ferdinandy.com/
    
    v3:
    
        This patch was originally sent along when I thought set-head was
        going to be invoked by fetch, but the discussion on the RFC
        concluded that it should be not. This opened the possibility to make
        it more explicit.
    
        Note: although I feel both things the patch does are really just
        cosmetic, an argument could be made for breaking it into two, one
        for the no-op part and one for the --auto print update.
    
        Was sent in:
        https://lore.kernel.org/git/20240915221055.904107-1-bence@ferdinandy.com/
    
    v4:
        - changes are now handled atomically via the ref update transaction
        - outputs have changed along the lines of Junio's suggestion
        - minor refactor to set_head for improved legibility
    
    v5: - the minor refactor has been split out into its own patch
    
    v6: - fixed uninitialized prev_head
        - fixed case of unusual previous target
        - fixed a test that would have been actually broken at this patch
          (the output was only correct with the later update to fetch)
        - added 4 tests for the 4 output cases
    
    v7: - change commit prefix to be more in line with project standards
        - fixed tests to also work with the reftable backend
        - renamed report function, fixed style issue with checking buf len
        - fixed not releasing an strbuf
    
    v8: no change
    
    v9: - mark output strings in report_set_head_auto as translatable
        - rename buf_prev to b_local_head for consistency
        - use ${SQ} in tests instead of '\''
    
    v10: no change
    
    v11: no change
    
    v12: no change
    
    v13: added handling the edge case of previous remote/HEAD being
    a detached HEAD
    
    v14: - fixed badly named variable
         - fixed not reporting errors correctly
    
    v15: no change

 builtin/remote.c  | 59 +++++++++++++++++++++++++++++++++++---------
 t/t5505-remote.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 47ca650de8..e1f15e68f4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1399,10 +1399,38 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static void report_set_head_auto(const char *remote, const char *head_name,
+			struct strbuf *b_local_head, int was_detached) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head = NULL;
+
+	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
+	skip_prefix(b_local_head->buf, buf_prefix.buf, &prev_head);
+
+	if (prev_head && !strcmp(prev_head, head_name))
+		printf(_("'%s/HEAD' is unchanged and points to '%s'\n"),
+			remote, head_name);
+	else if (prev_head)
+		printf(_("'%s/HEAD' has changed from '%s' and now points to '%s'\n"),
+			remote, prev_head, head_name);
+	else if (!b_local_head->len)
+		printf(_("'%s/HEAD' is now created and points to '%s'\n"),
+			remote, head_name);
+	else if (was_detached && b_local_head->len)
+		printf(_("'%s/HEAD' was detached at '%s' and now points to '%s'\n"),
+			remote, b_local_head->buf, head_name);
+	else
+		printf(_("'%s/HEAD' used to point to '%s' "
+			"(which is not a remote branch), but now points to '%s'\n"),
+			remote, b_local_head->buf, head_name);
+	strbuf_release(&buf_prefix);
+}
+
 static int set_head(int argc, const char **argv, const char *prefix)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
+	int i, opt_a = 0, opt_d = 0, result = 0, was_detached;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
+		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
@@ -1440,20 +1468,27 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
 
-	if (head_name) {
-		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
-		/* make sure it's valid */
-		if (!refs_ref_exists(refs, b_remote_head.buf))
-			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
-		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
-			result |= error(_("Could not set up %s"), b_head.buf);
-		else if (opt_a)
-			printf("%s/HEAD set to %s\n", argv[0], head_name);
-		free(head_name);
+	if (!head_name)
+		goto cleanup;
+	strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
+	if (!refs_ref_exists(refs, b_remote_head.buf)) {
+		result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
+		goto cleanup;
+	}
+	was_detached = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
+			"remote set-head", &b_local_head);
+	if (was_detached == -1) {
+		result |= error(_("Could not set up %s"), b_head.buf);
+		goto cleanup;
 	}
+	if (opt_a)
+		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
 
+cleanup:
+	free(head_name);
 	strbuf_release(&b_head);
 	strbuf_release(&b_remote_head);
+	strbuf_release(&b_local_head);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 61e3ecc1af..d15b579c95 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -444,12 +444,63 @@ test_expect_success REFFILES 'set-head --auto failure' '
 	)
 '
 
+test_expect_success 'set-head --auto detects creation' '
+	(
+		cd test &&
+		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto to update a non symbolic ref' '
+	(
+		cd test &&
+		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
+		git update-ref refs/remotes/origin/HEAD HEAD &&
+		HEAD=$(git log --pretty="%H") &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} was detached at ${SQ}${HEAD}${SQ} and now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects no change' '
+	(
+		cd test &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} is unchanged and points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects change' '
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/ahead &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} has changed from ${SQ}ahead${SQ} and now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects strange ref' '
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/heads/main &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} used to point to ${SQ}refs/heads/main${SQ} (which is not a remote branch), but now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
 test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to main" >expect &&
+		echo "${SQ}two/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
 		test_cmp expect output
 	)
 '
@@ -468,6 +519,16 @@ test_expect_success 'set-head explicit' '
 	)
 '
 
+test_expect_success 'set-head --auto reports change' '
+	(
+		cd test &&
+		git remote set-head origin side2 &&
+		git remote set-head --auto origin >output 2>&1 &&
+		echo "${SQ}origin/HEAD${SQ} has changed from ${SQ}side2${SQ} and now points to ${SQ}main${SQ}" >expect &&
+		test_cmp expect output
+	)
+'
+
 cat >test/expect <<EOF
 Pruning origin
 URL: $(pwd)/one
-- 
2.47.0.298.g52a96ec17b

