Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B51C9DC1
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567137; cv=none; b=XWMGVFnhGS6yYVFY/4T08rte2MVrT0gFlUarV0uM2WfQqqta0j5LaNbeOk26gLo/FQVFAA0icmC5EYU+EbsJLOqgLd/8saTsbxBZdA0eWU4qTmY7/XiGV420mR4pKKRBVAa11KP3aPBNtKaUfshAeYcnBqbNOPh7h+nJZgfH4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567137; c=relaxed/simple;
	bh=G5QjMlw6P5uTFXX21zjsHM0s6NANM6A5C6jtJJcONvQ=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=khJIVfRGqf7TjGMIiwzeCis3j3oMEkIsxvA9Hn7ozLomKDdfM80spUs5ZLj4Fp/HiMvVPDcUvSG8qbFocrdHJtY3Usq6erFfrcXmIwU60KzuEXCq8Wk6oulVIyQMxNTybThhj9dbh0vCjdKr0eMm55IDfh0x8Yq2CFXZk5//5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=bhlRoJQd; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="bhlRoJQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=+YJrJT1CSa7WJg5lwQrwdQfMqp1FFNeOPktQR2I1Ips=;
 b=bhlRoJQdUguVtUP7XlssjlxlQpaZHXw7eX4o57r/KsfdYszsSRBA5IvCIinPdo2IXmuah0+/3lw6
   f/CBkKmMp6aPuLXal64QCttPZnF1kpXQX5sz8pzEXTmJhibigiZGGnu+t4U/1vR4P8hfo8ES6xXb
   LqDTnDNHus66KyipvCoeMoeArEqpGS0m9He6Ey9E8dXYXCk33qRMRI/M7Wtrvz1kvuzx+qVIeNDk
   yhqLTmLHU71wV+obz7mHtkptd0Stk54GdA74B7W6WQ4gPVfulv89ejdCgIDeIvV71uBjMVAQOwiW
   5J/MsHhQOiA8DEU1pW7zdTRndDbyiX9+HGaIbw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL500AXS6XPVA30@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 10 Oct 2024 13:32:13 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v6 3/6] set-head: better output for --auto
Date: Thu, 10 Oct 2024 15:29:58 +0200
Message-id: <20241010133022.1733542-3-bence@ferdinandy.com>
In-reply-to: <20241010133022.1733542-1-bence@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFYTbWyjGb9yUF5xbtDw9zkPnsxLZJUATDZgLb0C7HxB7jf8X+HY+16Fs59wBRn
 XB0CFIAggFeYyDhoeAqFE5oDtcrcitFKjrTVc9TCd7VjCgM5GzJntUi3841OES5A
 mRySKYXnQIva8+ge9EVOV8tL89aWvQ4z12aMY6HXml8Kd1d0ohtT9mmNRkT8yLr5
 l+4ZWp1ipLqCYGELfdtTkp7noc4hzYlC6VJjAAsskK2wWpT0uY1TU77DUQ7qhQHD
 WGh63hNmt5kf1QY5r4+xrYOS+GrG6IPspFTVYCIZMX6hiQK2VxW2nG8x3aMyPOf+
 HXZSoQtMYhec76zRKrpn41hGfXDgAMOF9BQLqrToFikuuGM26kbk99KHHw5AEAPe
 4JHkjlcLnaYdwOJIIArRQl/z9/M1b6DH3nYyBfUNGAKZj2yGvOSH7MUD9LwKTfIs
 9KwXTktRCseesWCRuhZVaGdbaZd2fUbPp2y7cApmMExOsLMDy7uRU9c=

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

 builtin/remote.c  | 34 +++++++++++++++++++++++++++----
 t/t5505-remote.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 353ffd2c43..24f9caf149 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1399,10 +1399,34 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static void report_auto(const char *remote, const char *head_name,
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
+	else if (buf_prev->len == 0)
+		printf("'%s/HEAD' is now created and points to '%s'\n",
+			remote, head_name);
+	else
+		printf("'%s/HEAD' used to point to '%s' "
+			"(which is unusual), but now points to '%s'\n",
+			remote, buf_prev->buf, head_name);
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
 
@@ -1445,15 +1469,17 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		/* make sure it's valid */
 		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", NULL))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", &buf_prev))
 			result |= error(_("Could not setup %s"), buf.buf);
-		else if (opt_a)
-			printf("%s/HEAD set to %s\n", argv[0], head_name);
+		else if (opt_a) {
+			report_auto(argv[0], head_name, &buf_prev);
+		}
 		free(head_name);
 	}
 
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
+	strbuf_release(&buf_prev);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f..77c12b8709 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -429,12 +429,51 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
+test_expect_success 'set-head --auto detects creation' '
+	(
+		cd test &&
+		rm .git/refs/remotes/origin/HEAD &&
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
+		echo "ref: refs/remotes/origin/ahead" >.git/refs/remotes/origin/HEAD &&
+		git remote set-head --auto origin >output &&
+		echo "'\''origin/HEAD'\'' has changed from '\''ahead'\'' and now points to '\''main'\''" >expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success 'set-head --auto detects strange ref' '
+	(
+		cd test &&
+		echo "ref: refs/heads/main" >.git/refs/remotes/origin/HEAD &&
+		git remote set-head --auto origin >output &&
+		echo "'\''origin/HEAD'\'' used to point to '\''refs/heads/main'\'' (which is unusual), but now points to '\''main'\''" >expect &&
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
@@ -453,6 +492,17 @@ test_expect_success 'set-head explicit' '
 	)
 '
 
+
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
2.47.0.6.g07cb02250a

