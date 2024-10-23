Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA751C75E6
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697947; cv=none; b=bHFyM69QftTGmBNqR5I9DQMWr01Z8GlfX0v2nAV8QsCKMBQNeIGK8KX6sSfHufljIDg2R98Jn/jVv1WmkNrmx7qlnHq1aICHR9pRL1qCcFPP3PAT1tnZj7kv1/He4aFBFg/lRi2UJHAdYH56kyFSV0/HvCK4OxT2uC8N4qURPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697947; c=relaxed/simple;
	bh=2hg3ImlrhKR/RXAYS/vuc9OlGAXyeTcwKeadmiDDB38=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=NO3p3BivYx0gp2Smj99r3B4nlqLFAwmSAgD5SijLGkVpjM18s0ALiC+Pv8Udwes7+WG/0ngAsk3ROzS2kQsdbiJlBELnK59jILlufpi9QkUyvV9ijVAQjcYPmMZjxUTHCQ+NeyY0KlCoywEat2FGV+jLdfBIrgP78Yu+pLhuQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=fqIUoV5S; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="fqIUoV5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=JbitfC1M2T60iBvVZgJTLQON3zzMw2X56KNdV9dFQ6I=;
 b=fqIUoV5SLJqdMmXjm1qEI3WKVOcrZEfxFrYCPZ/nv6VykNCFGK9DhWgBluPJ3nm/tp4lxiSFeDdF
   zAJDBDa4Qf5IyfC203/ocQibdZlwoFEgJ0NwEgE0YCMG2yy/iomBD7x/jXLBfV8A4METLXFPa8WU
   /FO/iTVtKJ6ikq4Z7G3xGcb04B9iXQWplwnlJTkhBcFAqSjOcxZAYJYjoszX8vi/OQARkPcoqZlg
   1ttjZFiLgY5lc/dGtMEDJ8dJUIbnz3ACxLiqMVdtkor5jME2XDzKqaPK/BokgvEmTnEvPfBpQT7a
   UK5jaIJeDnv8+ZYThB+b3LKu3gxiAJjbgrFSUw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT004OQFH3CJ70@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 15:39:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	ferdinandy.bence@ttk.elte.hu
Subject: [PATCH v12 4/8] remote set-head: better output for --auto
Date: Wed, 23 Oct 2024 17:36:38 +0200
Message-id: <20241023153736.257733-5-bence@ferdinandy.com>
In-reply-to: <20241023153736.257733-1-bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAE3E2yj7RcntEa9ZQAgXIrjzU4XcukpfUYogdhY4k8jpoCTBWTGODvDlIz70Xjn
 ssPa+a+P7IAcXylge902bAyLXr6svSzJuZRI/Rxd5GrQAp9rlDKhJ726RRZit0mP
 FKr+pSiQyUcysRZzxL75IwcwrysYnBilliGgxWsvzkQ9KqFTie8O9Bn2dQqBD7Bc
 NC0oE6HX1jviCE8ozeRKnXmAACizu56nIL8Nlr+W0ZeaDjifDbMWkaTBoSLJVzqA
 bonxm/7ruHEwy0nUAzKNJkhYUmFGUienbbJmCfjXDJ6A/V/hKkxAjMKVPbgUg49k
 mnGLN1/rKCGMiORyT1nQ887/nutRzbtMQgotOpv6awDbX92GUNu6Il7WivQ/4qkV
 iP6HD7DzA2pw90a66hP/lt36sZBT55XZ7/78M2NFiwP5pIcVMHyvkZ2sgb8K5lqV
 8xfDy89DVGKmF/Q9TaOjdP+oczV73LnX9sYTqcr66llp/z1iazgRMpi5

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
    
    v10: no change
    
    v11: no change
    
    v12: no change

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
2.47.0.94.g1247fb88fd.dirty

