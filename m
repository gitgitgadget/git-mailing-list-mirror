Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22D40DB32
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366553; cv=none; b=M1N1SOtlAcc2uu7iAXrpGWwLPVslBhqYZ5Ub3w00hSani7GHOlQAEadkYrzTopshtLuh1fLWWPlRxG6KyF6x/AopAHoG5UUJbVMWt6XBe4u4TVKVtALmOhuOzn7LHxt0uMwlRBJfl1GA/kaPk2cy2BEPjVt3capnv3SwtJe49tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366553; c=relaxed/simple;
	bh=WyQ+oW5pq9s2y7cAR6FKVYHck1sGYitNDlhs4+WHo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts8/B8fMJf8dPtIVrJioEzDkjCBGOdiJ7K/9ZIhM0wpKbRn9KhgeqfBYKLA1CSgjRGqQutLnmrH+SS/GqKBhYkq9LAR1pDzKxH1Qa8OsXtcNTfT03FeM+xjMYDLIexTZabFrxHzOhjNxLakWW1PGb4gspwMutGzhBSv31Yu/I+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XjGmCIK3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XjGmCIK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785365989;
	bh=WyQ+oW5pq9s2y7cAR6FKVYHck1sGYitNDlhs4+WHo0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=XjGmCIK3s4yXL0ygZWMfSmnaHC8axpTxqrhBdk0qbKpcOfK3wcCJpV65VbVRgV5H9
	 pPXNP8jBeVRcTkrINdbBdk8OiqXd1xdoRuldihevKLyOZlAsCjq/3QzdeC20zgU/94
	 K1OXvlAYZRF4llWIe+C9009+PuMyDabLAIfiFvz8UFWI14/2MCHelUf8wT6hSKS3t6
	 DuLkr1PUEXgyd36wBa69lNlROFogniEHr9CiUPgCr2hdeL0kkM7tcbTK/NjYmX3XXs
	 0lO36ISdV977LrkMd8Jlke2fioFi7WUp2E5zZGYbx5MnnLVOu+bI5ycdHgZsJ77HrE
	 CIF3uAmr04ycGC6wsc4pyWX1PYwScSoeEVjsniEn4+H0dx0a2DdY36JNrc8tm2u4z7
	 rLTdEcP18meqb3a5asR0RvFLOt69pvJZdk6mnCfXGuLe53kylEX2UY+X8ZWDS9rCwY
	 kGmpiOGgcvchB+Fms46p0cUc9nIx/vAqqhuN4hcBqfI57096oNn
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c292:4852:9051:fdce])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1D6A920083;
	Wed, 29 Jul 2026 22:59:49 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH] Makefile: read configuration earlier
Date: Wed, 29 Jul 2026 22:59:44 +0000
Message-ID: <20260729225944.1364947-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260728135532.GA11894@coredump.intra.peff.net>
References: <20260728135532.GA11894@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building with WITH_BREAKING_CHANGES, we need that option set before
we generate the list of binaries to build, since it affects whether
git-whatchanged is built.  That in turn, affects whether t1517 passes,
since it does not if we are in breaking-changes mode and git-whatchanged
or git-pack-redundant exist.  Load the configuration settings earlier in
the Makefile so that we properly honor this value when building.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I noticed that Peff's patches didn't quite fix the problem for me and I
think we need this on top to make the tests pass properly.

 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 98e995e4be..6bfa461aeb 100644
--- a/Makefile
+++ b/Makefile
@@ -781,6 +781,10 @@ clean-perl-script:
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
 
+include config.mak.uname
+-include config.mak.autogen
+-include config.mak
+
 SCRIPTS = $(SCRIPT_SH_GEN) \
 	  $(SCRIPT_PERL_GEN) \
 	  $(SCRIPT_PYTHON_GEN) \
@@ -1050,10 +1054,6 @@ GIT-SPATCH-DEFINES: FORCE
 		echo "$$FLAGS" >GIT-SPATCH-DEFINES; \
             fi
 
-include config.mak.uname
--include config.mak.autogen
--include config.mak
-
 ifdef DEVELOPER
 include config.mak.dev
 endif
