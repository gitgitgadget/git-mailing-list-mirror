Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A6197558
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482758; cv=none; b=JSW7J9YICBUEznPY9LeXOiM3mz8UkujPVtpVTMLqR6PrfmDNUqsIzXzpz88x2oTxPbCIQ/4Di6hkGw3zq/LcaV55xHQziRCgXVlWdwKakPLPxN97YU4TKaAc+KPO15ls+8N4PwNbfaTb1QWogk0LByF63tUzGNexZH09PtYyWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482758; c=relaxed/simple;
	bh=iCCKoqGzHHBMFavR7N1BO2Jza7Ir2p6DJLAYF5ywEsI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=cvbnp4FymbYy5ygLGStgXV4l8APwz2YPGo2TcYGqXinAihOi3C1xp8vRZYSN0naMUqub1N1UAbIBG8/YxxDcTjC7Ykp+r3dNfnWXAu4Qv1NrDCXQnmeJYk18GKSroSTI59mK/5fudDvknWPYJpt0Jt3pGyItZONIFbAg1DXkR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=nJ7osQxt; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="nJ7osQxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=sss2DM6dige8xdpRbcqfd2nYdUzlzOCXHwBBWmglWeE=;
 b=nJ7osQxtNBGvgZyW3BBskq9YOSumN3AHt9uUrW8Fqs+p6ZupxGQCAbzz76h8lPAdshCMQ7pPad/P
   6qNGFftOPuYgyrn/pcypbSP2WPYbEQNSPSq9Ju64OWfzbSq+bmKoZOZtAyfo7Q7rzq736RNkMrJe
   dtWsEF28oAlzwoGd/XOMt4LToA7KmUdOM8uWQTknnZabYiP5X04Oxa9VpzuI2+pZiMVE19XQ9kjw
   +YUFCTcUUoKxisacegligSsv63H/9AsrjyHQkrt41u3BQRRQLe/Vfv0OnbVnyO4qELZYcFT9Ktmv
   3acLU0zUFjLG0HvM+qfgGN1LFa8pReQlhfhVQQ==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL300EFNDLA0O80@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 09 Oct 2024 14:00:46 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v5 3/6] set-head: better output for --auto
Date: Wed,  9 Oct 2024 15:57:25 +0200
Message-id: <20241009135747.3563204-3-bence@ferdinandy.com>
In-reply-to: <20241009135747.3563204-1-bence@ferdinandy.com>
References: <xmqq1q0xhu13.fsf@gitster.g>
 <20241009135747.3563204-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG7AXgI+F0lVbj0qOZrZu5geLv/cPsRGpU29FYt2F9fQFQ7eNjlMrpRVyvf6Yz3
 S7PaSdFqm9HAxGxeEcYWIoiaTRNCP/z+6fYMvACk10WUJWh1euzITDKeFhuhUY+Y
 oNG95BtmW76ihkYApgmcl+xtpSQ6eeSvJfBujClSAdokOJ7h/F/7mzDyXh49HxDg
 RQ4/0jmNKh+hjMbbFhyR/tTiiW2NN+dlcPeNAtQp+Lbs9LLfkjG3ak2XQk41Hdzt
 lcQOTDMxCtWt+rWQGXp5dfnk9wB18Uk9gEAJ0B5bufrvbY0N26NM9dK5d5FIIfWp
 jWqiyUBrBS7u9xupspLXwM2GsbbhTp1fiS7qqoAyil4avlP3EvtQYh4DE3VyP89h
 yiRIqdCLWrcX+dHP4T9orSaCEKv3SzQPFzPAlwsT7CQDM8DuYmgbLtNnH2/VAB3p
 GZ6TByQoKkHBOpmsS2rvkxE3vr4o6a5uUmXJA5KhiefjC0tvHHzU0Vo=

Currently, set-head --auto will print a message saying "remote/HEAD set
to branch", which implies something was changed.

Change the output of --auto, so the output actually reflects what was
done: a) set a previously unset HEAD, b) change HEAD because remote
changed or c) no updates.

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

 builtin/remote.c  | 30 ++++++++++++++++++++++++++----
 t/t5505-remote.sh | 13 ++++++++++++-
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 353ffd2c43..2480128b88 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1399,10 +1399,30 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static void report_auto(const char *remote, const char *head_name,
+			struct strbuf *buf_prev) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head;
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
+	else
+		printf("'%s/HEAD' is now created and points to '%s'\n",
+			remote, head_name);
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
 
@@ -1445,15 +1465,17 @@ static int set_head(int argc, const char **argv, const char *prefix)
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
index 532035933f..262a4de0aa 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -434,7 +434,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "two/HEAD set to main" >expect &&
+		echo "'\''two/HEAD'\'' is unchanged and points to '\''main'\''" >expect &&
 		test_cmp expect output
 	)
 '
@@ -453,6 +453,17 @@ test_expect_success 'set-head explicit' '
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
2.47.0.6.g9542df9767

