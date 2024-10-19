Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E2193079
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378469; cv=none; b=YV6vfkhFi405IX908S66Q+4wtRsh0ZV+hQsOk4ljsW0Pi3wPR7FGY2jQCaVZQsFQ6kb9a0jAcfatv2ZAnJWszdBxPOfrczYabdSmP6IC/bP7ckD80BvMegoTqlHttqDVAFM+52nuLhxg1DsewJ/0X/aRx5X/iQlDKkPw84RWNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378469; c=relaxed/simple;
	bh=aFOJAKYLu5SnZiYdCdU/ClPHHd+ZZOHlGwiWbkzU7Mk=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=syvx7VcIT9ad+oTp8EaPKMMxQQ+oMmsUkOvk3EL1xWxmeFu/xbdnIKvBCfLHZrFFigzGEFyLEWuX5vWGOV+V3dJvnurlsUetuYe/RGVEOxC7+MN17qqr0/LLnHp0HKC5Jeqc3+/KQObc2HUeLXZTGhBSzKm00VeUWFZ1Y+FA11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=qCyhCdR4; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="qCyhCdR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=y1BNSKRlDEaGGEl4eiT6ihTV12rTSt5qD/FdjobxVAM=;
 b=qCyhCdR4gCjn1mR3rt/C4+k/d/WLCpV7ZLQQAgjk4fSpF29riQxFjs8pk2xJFfl07FIsRUGb65XR
   6rF1Gp9qQ5XdDerNhec9j/SrlUaYEu1I+i870a6OpODl8nTW7M+0l4uYgEKsKOM4bCqt6QEPKH3I
   JPNXEEpce5sYlUYZKYyL522btTO7zwgPMFtqUlY+2tuQSBHeYFGWxXmUrdQ7a9NP4YKYxDiMM3p/
   TvD9/AYxb8wTEBhhtGe90G09hzIGQZtXw3B76i9aHM9DutPwxBtaF/Cs5/TPaPi/tooW6OympO4N
   +oAxweGF7GUY+UPTUzWUzG2sw+JPEpqSTy1oEw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM00LUAKYJ9550@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:19 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v9 4/7] remote set-head: better output for --auto
Date: Sun, 20 Oct 2024 00:53:11 +0200
Message-id: <20241019225330.4001477-5-bence@ferdinandy.com>
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
 AAG5c+B7OrMmi4a7Ddn1G66z4zyF1/W3ghMBkREf/BIoKsu7XPz8tQlXhYV+JvqZ
 aYRnLBZkHkQCRaZVkpPOY5GW0wI/MaiSXAQpjGo83rkZeLj3sqMmLaP3Z2NGgkIN
 NSuNfqeT9QN5pxUWfOt41OZGVaWWCLCbeODnrKPwKLYFPeZq/m6cdhuX4BP7Hs15
 sNs1TsTGL3XP4xIcMdjX5mIqZ8+0imWCQMMHh3DCuZ8rb6+9At9TdhBmrg6Kk6s/
 2O00AB8W/+amVIlp+6j4xnT89WYdG06kopMUk248w325gR6tEgKH+u8NvDobzT2D
 Myqixe0As1anSmcbqVV2wEcl7dLrDNgDgMoeR+Zbes5VxSPqGRUjhwhEBFZtwbB7
 Riv9VSB5GnUQUvMj3ANcu79OhoKl1Mm4jRA7cHiwtLuufet3+n07tE66Ho2K/zlT
 dVpyAbno2c4coW4hHFRsE6dxE8UORDREnSclgDLHnVUZMl3+RvLcC0o1

Currently, set-head --auto will print a message saying "remote/HEAD set
to branch", which implies something was changed.

Change the output of --auto, so the output actually reflects what was
done: a) set a previously unset HEAD, b) change HEAD because remote
changed or c) no updates. As a fourth output, if HEAD is changed from
a previous value that was not a remote branch, explicitly call attention
to this fact.

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

 builtin/remote.c  | 33 +++++++++++++++++++++++++++---
 t/t5505-remote.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1d68c5b2ba..108f1271d3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1399,10 +1399,35 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static void report_set_head_auto(const char *remote, const char *head_name,
+			struct strbuf *b_local_head) {
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
+	else
+		printf(_("'%s/HEAD' used to point to '%s' "
+			"(which is not a remote branch), but now points to '%s'\n"),
+			remote, b_local_head->buf, head_name);
+	strbuf_release(&buf_prefix);
+}
+
 static int set_head(int argc, const char **argv, const char *prefix)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
+		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
@@ -1445,15 +1470,17 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		/* make sure it's valid */
 		if (!refs_ref_exists(refs, b_remote_head.buf))
 			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
-		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
+		else if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
+					"remote set-head", &b_local_head))
 			result |= error(_("Could not setup %s"), b_head.buf);
 		else if (opt_a)
-			printf("%s/HEAD set to %s\n", argv[0], head_name);
+			report_set_head_auto(argv[0], head_name, &b_local_head);
 		free(head_name);
 	}
 
 	strbuf_release(&b_head);
 	strbuf_release(&b_remote_head);
+	strbuf_release(&b_local_head);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 9b50276646..0ea86d51a4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -432,12 +432,51 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
+test_expect_success 'set-head --auto detects creation' '
+	(
+		cd test &&
+		git symbolic-ref -d refs/remotes/origin/HEAD &&
+		git remote set-head --auto origin >output &&
+		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
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
@@ -456,6 +495,16 @@ test_expect_success 'set-head explicit' '
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
2.47.0.92.g83fdbe24c3.dirty

