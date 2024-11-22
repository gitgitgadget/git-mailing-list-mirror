Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB81158848
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278769; cv=none; b=IaTU8O3y9u0UaWy7OFNKfiXiUHUItrXd63dNnArJgjN3RuaSkZYLteS0es806bxWtlWNmVcPqSCIZIt730whaA3tdnUCmKNJJG8mM3i7lr4FcFInRk1UEjJdAqRnbV4/r9spGpr4lNH91s5U+CaozX4YO6Qtmw++gHHfvZO+tBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278769; c=relaxed/simple;
	bh=r0EhpFOX2i1klYG/AC6S4WwWU8kfogF6xeP5FZcikLw=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=EGv0sxL/W1guBE2RBUmBkGEeuvtAfo2F+j1ssN6iw31zB1KfZHKzUQCOHMnPgn9rjZ7sQejj6njksmYg7cZ6UWwHLwz952YsWf6AENNb93LuzOicQITjX/vBa3oEZXciyMzVn9MK21PDI8ge/JVL9FvM7abCU5vlJmpQMZCZuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=VFbaoo59; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="VFbaoo59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=E+MOM+pOHVlonkZ/wSAer0AQTgl8WddkKS96eFU7KXM=;
 b=VFbaoo59Tf5km8uCDALndkNms60PNk7aett/MohF+Ht2sjq4gWRLsHx9ckgiLE6PvtBRjqn5HJJ9
   t5D0qR8uEf092V1PtxrqUPsFD9+rQ7d0mk50u63YbQH6A+03aweR2aqOoocKB2dwkOEEG0e5ZBTk
   8lAqVviRpspnJrYHR/cxtVDlX2y4YpLvJThodTDB1ExsZUYfnzY3BNLGwjf+I8cU6DPFROi5sWwq
   jVEDJxmjIUfueuXoG9c0kPrKN7G9tJLBb+ffzxZ1zkaj+BohzIJS3YqPoZkopSOjhZwPTIeDotnE
   6xmAJH1W8uD/lMR5cNFeF2wCXNnfn8XTsg276A==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00FQ6QUMVB90@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:32:46 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 02/10] t/t5505-remote: test failure of set-head
Date: Fri, 22 Nov 2024 13:28:43 +0100
Message-id: <20241122123138.66960-3-bence@ferdinandy.com>
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
 04gdTC0WXFhQikV0a2whcJrH+DS0/QWikdgXqrWEUtBRvaOD3Z7Mu/WrnsAVT9WX
 PoYBvAVwawLMKmajYpxeWvtpUebCrR8FDu+sCfAfwp2mpzMFox3WOG/HggXTK5ud
 pI15C2eFW5BCp39Ei/WOJ5pSwehL3Ru8wBHowd8gCPBfDIv+yMpU57LmTGz86QkQ
 FNaIuExrMRn+8ajI+RdYzaqgMjXkb2DYYXHv+OngIVMxoc1fruWRzxZ5OpEW18Q0
 rGPwXnv4Kbih4wOikhSRK/PDBECkG/Sv//KJdQ6bI33P96BRF/LObDUJCBaFdgrF
 WXD/ZMdYMkjJ61BVgZGEfgPxKOGQ8Hp1KOYhFo2pqVXlO8UN9uy4eX16vFziK8Wy
 ohrd+z8RXycnpwzBF7YcZip07vT6+aSlcUK8iH6xr03ZuPWKqSBKDnA=

The test coverage was missing a test for the failure branch of remote
set-head auto's output. Add the missing text and while we are at it,
correct a small grammatical mistake in the error's output ("setup" is
the noun, "set up" is the verb).

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v14: new patch
    
    v15: - use test_must_fail and test_when_finished

 builtin/remote.c  |  2 +-
 t/t5505-remote.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9093600965..8bca3fb04e 100644
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
index 9b50276646..61e3ecc1af 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -432,6 +432,18 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
+test_expect_success REFFILES 'set-head --auto failure' '
+	test_when_finished "rm -f test/.git/refs/remotes/origin/HEAD.lock" &&
+	(
+		cd test &&
+		touch .git/refs/remotes/origin/HEAD.lock &&
+		test_must_fail git remote set-head --auto origin 2>err &&
+		tail -n1 err >output &&
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

