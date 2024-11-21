Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CB1DE2C5
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230616; cv=none; b=PW7anEQvS9CjXKtr+512Bc9ogzsMHVWKu6q4ZfkAzoOpQz2VIl4TNMlGUgQROBeEcz7bM57b79USasFGa0NIaEiNCklRzdwtKFTmKvtTBcgn+jnkszZ+LslakyqTp6MJXahxWYkoxXlkNQYL7B2X/LNHDqIMyQ+FvbwQOIq17ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230616; c=relaxed/simple;
	bh=K9a8KDeqo2XDMj5jVSmEkf9j7xCoyd2S6bHyoHrZHdM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=fA7YCGSQYbUCT0LPx0KMISOyLr6vAa5jAnXFrT0kKqMdNyBiSRdBvnSWprkI3+PFQgUDXVSLs+mIHItgozzOt/k2tDcGBVGqffqlPsEekMPUC3iGUXhp7rGgDhyQ/1FvkenKdfjU8IZk3KUtwlwA0OCu5wavuTyxWUC3ShZkB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=PkgzGlnN; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="PkgzGlnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Xgr6G2F8tJPqAAPxjhSD/Y301HZR/vIfXtLH0Zdgew8=;
 b=PkgzGlnNqB6m8pCWN/rLMJxaKntPlFUeCJXoP0H+3FW0WtNxXSekWU/akFGY7eFUMWQhd3LgXVhN
   bqxhtHeGtYGCUMACM/FmRe9htyyCqVh0HtGH9K9ufYx85kaQZ3DMKDIfmyZjssHhRRHlscopeef0
   FOHmtTKXOe1sN1vLVZbljRaQAYLJOyiIHMZViZna9mSMgxcSUCzxteh/hymPQXwhFTvWvYEzbd83
   UqWgY/LP+KeSkanBW78rB/lgxQMpiDszV9GhrPmBm8aoJajPxFfKnCy8Kjar3K4f4nizqOdDBsF8
   mAmruiWDJIvlGKUwfDZILyTUalSRm7+YR343dg==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB005L5PP05Z50@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:12 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 02/10] t/t5505-remote: test failure of set-head
Date: Thu, 21 Nov 2024 23:55:02 +0100
Message-id: <20241121225757.3877852-3-bence@ferdinandy.com>
In-reply-to: <20241121225757.3877852-1-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGcL/GPtO++bdrGzpnjJgdWKUrU5hjCqV9PMW4f5UekgmcxBbymtZ7nkK9a10hj
 I8Ibett0fHO+HpGtaPPXqs8Gnixm5Ys23+ld8CZsSl4nV/6NGSDI/8zpK2Zd+4Xz
 lJtSTx12R7Q6+jZ5RW2UNTffFvWiSo0zL930x84QU3a19Kvwr9RiRwQRm9ljOm8Z
 3Kz18oThfyPNA50zztRxbc/zdqcUuDz/XrUm1dABTeFWHxuczc0ixeLe8Rc6Z0Ww
 yr9x5wgWG6LAA5iWxC+DY1NGZe9cXlaEMCcy5XT4LcjoWtADmHp+jiwnKas0BV+p
 QehV+27hsoAzz8dQ4doH569dQG9YtxhObhMAvR7GrHHbF3CVyVrLebAGm6HEBTTa
 KCT+GYL+JZCUU61WoD3M6jPlyHZ7LTbdPtWss4tik5ogaq1+lqUpq2RkCeqTXVwk
 pAjSfTCMor5yKsVgYkabpCmOEAkNe0zI+KIQkrSzUT2YfBiMKSMjvew=

The test coverage was missing a test for the failure branch of remote
set-head auto's output. Add the missing text and while we are at it,
correct a small grammatical mistake in the error's output ("setup" is
the noun, "set up" is the verb).

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v14: new patch

 builtin/remote.c  |  2 +-
 t/t5505-remote.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 76670ddd8b..8a182439f2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1445,7 +1445,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
 		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
-			result |= error(_("Could not setup %s"), buf.buf);
+			result |= error(_("Could not set up %s"), buf.buf);
 		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 9b50276646..4e127bf5b8 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -432,6 +432,18 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
+test_expect_success REFFILES 'set-head --auto failure' '
+	(
+		cd test &&
+		touch .git/refs/remotes/origin/HEAD.lock &&
+		git remote set-head --auto origin 2>errormsg ||
+		tail -n1 errormsg >output &&
+		rm .git/refs/remotes/origin/HEAD.lock &&
+		echo "error: Could not set up refs/remotes/origin/HEAD" >expect &&
+		test_cmp expect output
+	)
+'
+
 test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
-- 
2.47.0.298.g52a96ec17b

