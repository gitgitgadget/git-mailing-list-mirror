Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48715575E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946583; cv=none; b=SM7CK5elE+UsT58wCDFSo8jV76WiMqX8TpAEQ/7zWtL8N389OwsxqxrjcDoIjBzZuHaB7qNCj3AjAZKY4bXIAijr7K3qORKXIkVypIP//2BPIypVqQSqaS58yPc6V8aIWrD10yNNZB67F8NEuTeHrXt8t6bel8ZCZxgJbROyxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946583; c=relaxed/simple;
	bh=cCRBB3EBQZcCvz/0LOTQCmMBIGXSBZBtrm0D5TZIhUA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=e621E4IlgFFHCyuQorXJSTw6BMXsRu4kTm64mfpvIuPDC63AzrrkREs8RNsXNZbOrYu5lRt+pua1S26m0X5X8DTRCyQhvyKuhfpbJcjhreYFUzzh27uBFmsl2wRiqt5LXZXm0Reh6tacOiBevge6Pw6XBU087XfhRC6X04cGvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=jWgR6Fod; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="jWgR6Fod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=oGx9tA9eHpBjxPOuZ5dSk3uDkR+8CFv+xlCMR4b23ZQ=;
 b=jWgR6FodSsMTDt9AoqZCVuFOwCyvkvblP9avpUbfk9Qipo/7+LciqVQv/o7BAplgjMsieuy1Z/uB
   LkSSB6TFYNEB5WQeKzEatqHxMu9H/vqgIgHGGzL1N2HZubmqk7DZh82V8Y9JAgAdJfkgY10Bo/QT
   zowONRznq+wX0f1h9L+BoFr5KlNGSVtWrOaNaptydngA+qBmur8w0axZTsDkYX0QEQDDaL6gQ5j+
   PonTTXu78AQ7aOEC4zQzNxMtrmm18b8ycEyo/rA40tmuKd6yhwYIQ2P5CYAV7feYi/O7lhtNH+Bk
   tBSAkenO/PUJwDKx537HJ+Bp+eakIIX5r0vgDA==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLD0014ZBPQ49C0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 14 Oct 2024 22:56:14 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	karthik.188@gmail.com
Subject: [PATCH v8 3/6] remote set-head: better output for --auto
Date: Tue, 15 Oct 2024 00:53:12 +0200
Message-id: <20241014225431.1394565-4-bence@ferdinandy.com>
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
 AAGMNonlunkk/59nMRWYrMAnGxC2sk0VIX02wnEW3qz3IK4VlbZOn9SrmTIzeTpz
 qESBWZqURjJ02PI5WcjxR+q5i0FWRS+LSJFzf0cDEdCyu9g9Vwxq5gSmQ1M24tO5
 bkvqHR4KPrN6mRBwXhjsF9fxDKHKkpQsU/Kc24wOJJB/BwsRSo9TMaLl9BLQYPC7
 DkCK67LkStA4NVao4k/GFNB0G5rDi/47MMQH6sHb03DB2PX7Vx6VwEsWBw3AnIV/
 W8EK6YaeR2z/9vdA+vaxG7c0TCx6Xk49/CTWBmO9+NLjcdmw4BFGeADfiY1Smqxv
 +qdF4ulsB3qqnddmGuEJOjacmzTM5CbS9nCUIYzcr6lTtlygrtT4LmUfrDM64xti
 TzZv9NmZ+nCos0HtvHdVUXutVuUgH7+VCEd8zuHFvPewfFIJBLF7w7ORpmGkVkpP
 kzGcPgqQvsX9xdPmaXYsK+jnBVqwfBYBZHtpSQ5sIZDWpIWp7USlpeSY

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

 builtin/remote.c  | 35 ++++++++++++++++++++++++++++----
 t/t5505-remote.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 353ffd2c43..2b6948439f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1399,10 +1399,35 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static void report_set_head_auto(const char *remote, const char *head_name,
+			struct strbuf *buf_prev) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head = NULL;
+
+	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
+	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
+
+	if (prev_head && !strcmp(prev_head, head_name))
+		printf("'%s/HEAD' is unchanged and points to '%s'\n",
+			remote, head_name);
+	else if (prev_head)
+		printf("'%s/HEAD' has changed from '%s' and now points to '%s'\n",
+			remote, prev_head, head_name);
+	else if (!buf_prev->len)
+		printf("'%s/HEAD' is now created and points to '%s'\n",
+			remote, head_name);
+	else
+		printf("'%s/HEAD' used to point to '%s' "
+			"(which is not a remote branch), but now points to '%s'\n",
+			remote, buf_prev->buf, head_name);
+	strbuf_release(&buf_prefix);
+}
+
 static int set_head(int argc, const char **argv, const char *prefix)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT,
+		buf_prev = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
@@ -1445,15 +1470,17 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		/* make sure it's valid */
 		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", NULL))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", &buf_prev))
 			result |= error(_("Could not setup %s"), buf.buf);
-		else if (opt_a)
-			printf("%s/HEAD set to %s\n", argv[0], head_name);
+		else if (opt_a) {
+			report_set_head_auto(argv[0], head_name, &buf_prev);
+		}
 		free(head_name);
 	}
 
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
+	strbuf_release(&buf_prev);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f..d99cd1d0aa 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -429,12 +429,51 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
+test_expect_success 'set-head --auto detects creation' '
+	(
+		cd test &&
+		git symbolic-ref -d refs/remotes/origin/HEAD &&
+		git remote set-head --auto origin >output &&
+		echo "'\''origin/HEAD'\'' is now created and points to '\''main'\''" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects no change' '
+	(
+		cd test &&
+		git remote set-head --auto origin >output &&
+		echo "'\''origin/HEAD'\'' is unchanged and points to '\''main'\''" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects change' '
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/ahead &&
+		git remote set-head --auto origin >output &&
+		echo "'\''origin/HEAD'\'' has changed from '\''ahead'\'' and now points to '\''main'\''" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects strange ref' '
+	(
+		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/heads/main &&
+		git remote set-head --auto origin >output &&
+		echo "'\''origin/HEAD'\'' used to point to '\''refs/heads/main'\'' (which is not a remote branch), but now points to '\''main'\''" >expect &&
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
+		echo "'\''two/HEAD'\'' is now created and points to '\''main'\''" >expect &&
 		test_cmp expect output
 	)
 '
@@ -453,6 +492,16 @@ test_expect_success 'set-head explicit' '
 	)
 '
 
+test_expect_success 'set-head --auto reports change' '
+	(
+		cd test &&
+		git remote set-head origin side2 &&
+		git remote set-head --auto origin >output 2>&1 &&
+		echo "'\''origin/HEAD'\'' has changed from '\''side2'\'' and now points to '\''main'\''" >expect &&
+		test_cmp expect output
+	)
+'
+
 cat >test/expect <<EOF
 Pruning origin
 URL: $(pwd)/one
-- 
2.47.0.7.g072c39eddb.dirty

