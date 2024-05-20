Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553014AEF0
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246885; cv=none; b=EmoXrTKjKrG8Zqv9iY9Ym2dyeXTkRf2tl0LT/PP9LSDWFxZULVfqKAJLvfQTlWbYGlcelNNKRZT5puQ4u+EOZq06hH8eQ9ei9uNFYIB9pKbS39uhBGfoCY+9pi0fhcYPeLTxSOPFwUUK6z54CVJv2DL2r3jfm5CAfx2VgkIPpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246885; c=relaxed/simple;
	bh=82+XFtDiQJR+h/JUUQeEhipq7cUqmKbY6TBqC+qdfAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPm14wY4D5snme/BCMWh2orSATecGeUczTHfN6DmZftPOvlb10seaHmNTwnq0xQQXBr5CMhgeO0fyYXcWNRwxZvbUi27hv/NSizr/yy+oYNEIa9q7x9BSTDfCyxNWIxj223+Sh7wJp8/OJlWWksCN96dIWmTtfZY8a7V3s2ohuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KMBMCDQb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KMBMCDQb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A47B629EE7;
	Mon, 20 May 2024 19:14:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=82+XFtDiQJR+h/JUUQeEhipq7
	cUqmKbY6TBqC+qdfAQ=; b=KMBMCDQbukqorBqUwuI6l+7FwnreAEEPWlnT1WJTG
	kNXW5uGzmAWn3bGZd9P1gsG1Wi8BatX4JxUtfzTcw9cX2cvVTx2pGvP5djLVICxs
	poRaMDohYxHvFaisudK1c1lsA9t6e4/E+qMRDVfCHCA36JVJKFqjAEWG97Uini7Z
	ug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4280229EE3;
	Mon, 20 May 2024 19:14:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 439EE29EE1;
	Mon, 20 May 2024 19:14:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v5 2/5] t1517: test commands that are designed to be run outside repository
Date: Mon, 20 May 2024 16:14:31 -0700
Message-ID: <20240520231434.1816979-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240520231434.1816979-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240520231434.1816979-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 BBF8C35E-16FE-11EF-9A9D-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

A few commands, like "git apply" and "git patch-id", have been
broken with a recent change to stop setting the default hash
algorithm to SHA-1.  Test them and fix them in later commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1517-outside-repo.sh | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 t/t1517-outside-repo.sh

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
new file mode 100755
index 0000000000..389974d9fb
--- /dev/null
+++ b/t/t1517-outside-repo.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description=3D'check random commands outside repo'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
+. ./test-lib.sh
+
+test_expect_success 'set up a non-repo directory and test file' '
+	GIT_CEILING_DIRECTORIES=3D$(pwd) &&
+	export GIT_CEILING_DIRECTORIES &&
+	mkdir non-repo &&
+	(
+		cd non-repo &&
+		# confirm that git does not find a repo
+		test_must_fail git rev-parse --git-dir
+	) &&
+	test_write_lines one two three four >nums &&
+	git add nums &&
+	cp nums nums.old &&
+	test_write_lines five >>nums &&
+	git diff >sample.patch
+'
+
+test_expect_failure 'compute a patch-id outside repository (uses SHA-1)'=
 '
+	nongit env GIT_DEFAULT_HASH=3Dsha1 \
+		git patch-id <sample.patch >patch-id.expect &&
+	nongit \
+		git patch-id <sample.patch >patch-id.actual &&
+	test_cmp patch-id.expect patch-id.actual
+'
+
+test_expect_failure 'hash-object outside repository (uses SHA-1)' '
+	nongit env GIT_DEFAULT_HASH=3Dsha1 \
+		git hash-object --stdin <sample.patch >hash.expect &&
+	nongit \
+		git hash-object --stdin <sample.patch >hash.actual &&
+	test_cmp hash.expect hash.actual
+'
+
+test_expect_failure 'apply a patch outside repository' '
+	(
+		cd non-repo &&
+		cp ../nums.old nums &&
+		git apply ../sample.patch
+	) &&
+	test_cmp nums non-repo/nums
+'
+
+test_expect_success 'grep outside repository' '
+	git grep --cached two >expect &&
+	(
+		cd non-repo &&
+		cp ../nums.old nums &&
+		git grep --no-index two >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_done
--=20
2.45.1-216-g4365c6fcf9

