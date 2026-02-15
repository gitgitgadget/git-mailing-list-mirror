Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57B21ADB7
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186724; cv=none; b=sNC6Qd2yfNCMY7mqJfF40LutD7jFU9HvtT9ML/AShX099gcRIwW0+ghBJY+tTx/igOYrUvHmhIEXcdmamjqgRx8Ip1WNvkUAk3HXELPTC4tEQkA5Pm4eXdQqiIWBeCnLRR77qEF7z0Q9z0Ry5RTYIVqXHbNhIxtdVdV/NUcuuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186724; c=relaxed/simple;
	bh=hsOox4lG/bcqdh/rFQkJb6r3SKrDHwTUgd0TK7kYu1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbVer3PngRtUhPrHpdasmYIOyMgLZkhDf+tSontMnJT9Z5lOvgJSQ4FszXV9ySgyXN3Q5pdqaQ2MqdQsvMlScFLsahdg3XWSNjW6OEvsDyFfGn5vZoWdgv6Ntct7u1YaS+PngoAAMb5eiSQVt95ZJSGm2A3r9adRNHtXtrbo380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=GM7iDr72; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="GM7iDr72"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZd-008AnF-2E; Sun, 15 Feb 2026 21:18:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=a5P1w9Ni3mKVf/X2yZKGgB4xR3iLcotfUYA/r9IniiM=; b=GM7iDr72iQrUXL42Co98OGHNVN
	g+YyWpn9JiyauqSsY+3UV4YcxgB3z7LOrHdOAWjZWiWvnikYcB1C/RkJxzl2sYhBeBlLgXeaQzFcO
	ueGqe7loQUeqMOCqsFehjc0pxbG2mGhnJ7hYPDbVT+SIHha9iAsi8aJ1R5ftpjE45WWoAWY977Xd7
	wE520la6u2zSPH3pidC6x1y5rxaMpR2G19eh3sTC292A4J/ATC4tnHSBYijTc0oO+mbTcmAEuwPoC
	wdsVGgkHKES9B0JTVvcS02r3gTzHvWFvrVlbHwfIH2vAclr6t8UQ97k9TxwRazpiqBA+wt2punlrr
	4uAgV4gQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZc-0005i3-P0; Sun, 15 Feb 2026 21:18:32 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vriZW-00E3Gq-M9; Sun, 15 Feb 2026 21:18:27 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	Christian Heusel <christian@heusel.eu>,
	george@mail.dietrich.pub
Cc: Colin Stagner <ask+git@howdoi.land>,
	Christian Hesse <list@eworm.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] contrib/subtree: functionalize split traversal
Date: Sun, 15 Feb 2026 14:17:44 -0600
Message-ID: <20260215201748.889866-3-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215201748.889866-1-ask+git@howdoi.land>
References: <20260215201748.889866-1-ask+git@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git subtree split` requires an ancestor-first history traversal.
Refactor the existing rev-list traversal into its own function,
`find_commits_to_split`.

Pass unrevs via stdin to avoid limits on the maximum length of
command-line arguments. Also remove an unnecessary `eval`.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/git-subtree.sh | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1cdf39a481..7a62ef7504 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -516,6 +516,31 @@ find_existing_splits () {
 	done || exit $?
 }
 
+# Usage: find_commits_to_split REV UNREVS [ARGS...]
+#
+# List each commit to split, with its parents.
+#
+# Specify the starting REV for the split, which is usually
+# a branch tip. Populate UNREVS with the last --rejoin for
+# this prefix, if any. Typically, `subtree split` ignores
+# history prior to the last --rejoin... unless and if it
+# becomes necessary to consider it. `find_existing_splits` is
+# a convenient source of UNREVS.
+#
+# Remaining arguments are passed to rev-list.
+#
+# Outputs commits in ancestor-first order, one per line, with
+# parent information. Outputs all parents before any child.
+find_commits_to_split() {
+	assert test $# -ge 2
+	rev="$1"
+	unrevs="$2"
+	shift 2
+
+	echo "$unrevs" |
+	git rev-list --topo-order --reverse --parents --stdin "$rev" "$@"
+}
+
 # Usage: copy_commit REV TREE FLAGS_STR
 copy_commit () {
 	assert test $# = 3
@@ -1003,12 +1028,11 @@ cmd_split () {
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
-	grl='git rev-list --topo-order --reverse --parents $rev $unrevs'
-	revmax=$(eval "$grl" | wc -l)
+	revmax="$(find_commits_to_split "$rev" "$unrevs" --count)"
 	revcount=0
 	createcount=0
 	extracount=0
-	eval "$grl" |
+	find_commits_to_split "$rev" "$unrevs" |
 	while read rev parents
 	do
 		if should_ignore_subtree_split_commit "$rev"
-- 
2.43.0

