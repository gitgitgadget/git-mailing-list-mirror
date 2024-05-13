Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF957CAE
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628084; cv=none; b=CYpXUeP8vwWiwPD2D9DbL/B6Tkdk6OfSY7WJC5hf5JEzXYwSTvGWzUfaHTPGM3jKjiFM7NEARe5LGRoX7Uha9cpl7NfssWtebLZBXd+WeCZjd+ki6kAl186RRuMr3jTmb90aaEz0fAhiHRKHnSTQ9O6HCVgBLaNMJiapk4QmOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628084; c=relaxed/simple;
	bh=oYr8Oqnu4MezpIunZaO7dlaBxQxTQH7/B1+n9FmeDKQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjlXETD1X2gg98dyVZk7YcpLrN/q2twIkz/tNlOZqP0WjyH09ExmHlBQrzHOjtjXh7l5KVu4MiCoRjfHBU0RG7y3rQQe7hh7WkN9CEz5Z7IhswU7QxAojTCmfboaRJptcZ6kR7tOJ+LWzbyfQez0dDNli5Yoms4KgjiZidJo/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vkWVHrfr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vkWVHrfr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D9A35A9F;
	Mon, 13 May 2024 15:21:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=oYr8Oqnu4MezpIunZaO7dlaBx
	QxTQH7/B1+n9FmeDKQ=; b=vkWVHrfrpEPYAI2QqKKIRENjLCtlf8adTED71OqN+
	2lkwVNCPtA6h7n6NjFmf+KcN87az3hJ90VkRF2WzHCDs5cmxTm0unPg4ROkIk0n9
	zbitSpui9NdfrKnEkkdjkIS7NfzVlaNmDS+kGO8Gy21YAoJes0sixyZuKN7ml+QQ
	wo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12CA135A9E;
	Mon, 13 May 2024 15:21:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79D3035A9D;
	Mon, 13 May 2024 15:21:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/4] t1517: test commands that are designed to be run outside repository
Date: Mon, 13 May 2024 12:21:10 -0700
Message-ID: <20240513192112.866021-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240513192112.866021-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240513192112.866021-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 FB28375E-115D-11EF-A593-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

A few commands, like "git apply" and "git patch-id", have been
broken with a recent change to stop setting the default hash
algorithm to SHA-1.  Test them and fix them in later commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1517-outside-repo.sh | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100755 t/t1517-outside-repo.sh

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
new file mode 100755
index 0000000000..e0fd495ec1
--- /dev/null
+++ b/t/t1517-outside-repo.sh
@@ -0,0 +1,61 @@
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
+test_expect_failure 'compute a patch-id outside repository' '
+	git patch-id <sample.patch >patch-id.expect &&
+	(
+		cd non-repo &&
+		git patch-id <../sample.patch >../patch-id.actual
+	) &&
+	test_cmp patch-id.expect patch-id.actual
+'
+
+test_expect_failure 'hash-object outside repository' '
+	git hash-object --stdin <sample.patch >hash.expect &&
+	(
+		cd non-repo &&
+		git hash-object --stdin <../sample.patch >../hash.actual
+	) &&
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
2.45.0-145-g3e4a232f6e

