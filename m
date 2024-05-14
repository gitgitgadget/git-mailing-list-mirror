Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158FED8
	for <git@vger.kernel.org>; Tue, 14 May 2024 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649293; cv=none; b=ohYenW59GV+mEvjhuvzai22WU4oGSEFtKgr44oLZXQang2ZlP6QhGtRdVF/oQODrP/JqDG2RzMvxfedVEHf5L17LaFhtXV1+yg8uyUEGGjhLrdDUalQOtRgNb9WiIB0/fRBwow1QnkRfyg4o+FvlHo9J4NYO7S4ybPbxcfpgevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649293; c=relaxed/simple;
	bh=oYr8Oqnu4MezpIunZaO7dlaBxQxTQH7/B1+n9FmeDKQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLyE20d716QIud5Lw2F3dO+VxG4tJaN112wxofqyzDQLKi7Jv/jBsijds2xAOeZKoiLXbrQBn9WM6jAEM882Yt1lBBjocveXrO9QJI096nfq+tC+VA8xh//Xz+/ABS8HF1NgV5EDg6vpbcx47PanVRJ/H9X+szsUo6l6klXBkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A/NAvB5K; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A/NAvB5K"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 236B737F8C;
	Mon, 13 May 2024 21:14:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=oYr8Oqnu4MezpIunZaO7dlaBx
	QxTQH7/B1+n9FmeDKQ=; b=A/NAvB5KcXSGo4oTgFk7Ir/5dtlky9V9OMyQGOhQW
	rJ/yxlCwe/WFyyhoyFnz6Hh+Q1cJ5IymjtbE5I0pNCO6Wvp9u9U3WzgekOndRMl7
	LxivfRfD1cQnfPZtkujOMVhiZd+hz+HooUbEMOYFzTWqyUkpCzR5kYOdyKthbbGI
	OA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AD4B37F8B;
	Mon, 13 May 2024 21:14:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8395937F8A;
	Mon, 13 May 2024 21:14:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 2/5] t1517: test commands that are designed to be run outside repository
Date: Mon, 13 May 2024 18:14:34 -0700
Message-ID: <20240514011437.3779151-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240514011437.3779151-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240514011437.3779151-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 5CBAD69E-118F-11EF-A51D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
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

