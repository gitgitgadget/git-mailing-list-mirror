Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810E420868
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469769; cv=none; b=Nl6mKoE8QVKx78LSh1X7Y6V8PR8SXmIxsQ1TbiqbSQ2RwMafe6DROWBP0Wf5wM9bpL8DxzFGi/caG8btCzFtK+H6M/A6JfTE3OIZ4IB0IAbrfK7ue2A3o9yUTYi2cdxMIJIbH02z3F3/jEy09TvpmOwbY4FpHIFmiROkLLEm9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469769; c=relaxed/simple;
	bh=r7Ez09U7+MAQglTUhF7tsupeD2TgAVgUY7wuEhDi0TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWFUlTpFjfveIUyRs+yHlysUJs+551xU5cHzKCtXcQ9OHOls6wFmFN5lq1LRiOTzO6hJAA1OUUs3zkh/Bo4LV62mGBdBbk5fIB9FVOomI/3klmaN/wR1Ohy9IFGVDR0ikptFude67KtGgjgHy+Buj8qOpws92Lfou3zJSRBgQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=s/H/Codf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s/H/Codf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783469766;
	bh=r7Ez09U7+MAQglTUhF7tsupeD2TgAVgUY7wuEhDi0TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=s/H/CodfqrSZL7hJD6DsojTzLgXiswqJH8VXRTCBKR7X9I9T16K7YSE3VES/8BkL1
	 6Rp9KZRUTc7GkL5FZLfpnfv88KCPp9HCirl7KOiwr2R1sRKdd+gEIgCYPUdZtHy+KG
	 ZkQLeLAmodbU3uswxbyFsnPFVmwuIip29QOlQ3owOuXz9bUbOZ9TvMEmxytNgL5H06
	 WQSgkVooLTX1aRGyle5qknHDvxoL/+O71Bv8UAjSEcw2g0BotkpgTyE4EVBX/1cfD+
	 0S2GLZ/nzmK/eSlFFC3NcPtzeL3ZmZ8y0RpDCJlv3EuvXMg3dnQ4gkutxHFNJ61Ltj
	 PtaI0YMzQIfP6gJv8Xin7xUfP97FYALHd09UfC+FFdcKEyDlmxVoD7gt+Qvj6FbAI3
	 GDePU5SA/QMv5wOIUAr4XqsmZTLL70gX2bciuD7VbqV0Jj7qJCD2uUV3fr36c5jMc7
	 Jyls0rwCRwbup95b2sxGYG8VicWqXVnANtqEPtTVNNuBRBGNvDL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9470:51ef:86dd:bc22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 87E43200C0;
	Wed,  8 Jul 2026 00:16:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] t1517: skip svn tests if svn is not installed
Date: Wed,  8 Jul 2026 00:15:54 +0000
Message-ID: <20260708001557.3581080-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260708001557.3581080-1-sandals@crustytoothpaste.net>
References: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <20260708001557.3581080-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The svn tests currently assume that git-svn's option parsing will always
fail the tests because it exits 0 on --help, not 129.  However, in a
future commit, we'll expect it to exit 0 and the tests will then need to
be updated to succeed in some cases and fail in others.

We therefore need to have t1517 determine whether the Subversion Perl
modules are present, since if they are not, git-svn will die on start
and then it needs to continue to expect failure.  Add a stripped down
version of the tests in t/lib-git-svn.sh as a prerequisite we can use
here for our svn tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1517-outside-repo.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c557f2f55c..6421bdb3c3 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -4,6 +4,13 @@ test_description='check random commands outside repo'
 
 . ./test-lib.sh
 
+test_lazy_prereq SVN '
+	test_have_prereq PERL && test -z "$NO_SVN_TESTS" && perl -w -e "
+		use SVN::Core;
+		use SVN::Repos;
+	"
+'
+
 test_expect_success 'set up a non-repo directory and test file' '
 	GIT_CEILING_DIRECTORIES=$(pwd) &&
 	export GIT_CEILING_DIRECTORIES &&
@@ -138,6 +145,8 @@ do
 	case "$cmd" in
 	instaweb)
 		prereq=PERL ;;
+	svn)
+		prereq=SVN ;;
 	*)
 		prereq= ;;
 	esac
