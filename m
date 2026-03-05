Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE86262FD0
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755008; cv=none; b=DdcDwmsVD5tLJm/tP5gfgL181fchOqMPEiIBmC/lt0s54R4zN2PRoPjJFK58/lr8kS88UcHMcsAZC4rlqvERgD1ilB0AttqUoy0X2oAcy4ZXrfsQqJG9GO7QZ5qfM+vsH68LNSGFmMaNsudyQ1EkGEdQnJkuOPYNTzq+oXklh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755008; c=relaxed/simple;
	bh=nTSCiYb3kRfRvDs/9CGu1eItWNdMGkNDOOA/q8r99io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3/Tn7/51YJ5RXcLJWvhtWn+RD1zreA8RanTfSrJFaQ94Hs59nd50lfdGUFnVaSJVN1uJu1zm6/U14ziUmy9mqRTj0Yk2E8J6U36cehRwiPNyUmVvJbUmcQxftn3RNAq9qXLuge3ZzKL18LSCSdgKY3/Hkpk87/tF/SdRKS4fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=lznMCFGX; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="lznMCFGX"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYf-00167w-B8; Fri, 06 Mar 2026 00:56:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=NN494qP15M5uqYmI4dw8Ak7tn9EDzjE4jwDNsfKqTKE=; b=lznMCFGXM1KNJywoxOLL9Wti6x
	zcgfIGJzuhBW8WMbkv4c21qa5+0ffvjonh+zJ0k8IHJqFuI91BINVAQevoOzSp+Als8xHRpnm5DCI
	t4/y9XGEJJem08mRFIPgRW0OsuRbom4acLKjLqy5GVsKdGV9aDEHDECGSXZob0X2ZVRW1/bDx0Wsr
	gOdh7FII86SnsEjaf5gofXddAXwxWGx1QyMEpIOsEJBJF6+oBbiiwu3BlrKdgN7LInsIPDDF8MMIy
	6U0KOSn9FmS1+Cq1UXv1m65At6150ofG549TNwXoYVQSm/Y7LdAArdcmbpw2POsWSWniotwidGKJi
	FdZXnpLw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYe-00040L-Nw; Fri, 06 Mar 2026 00:56:44 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIYO-000JoT-Az; Fri, 06 Mar 2026 00:56:28 +0100
From: Colin Stagner <ask+git@howdoi.land>
Date: Thu, 05 Mar 2026 17:55:48 -0600
Subject: [PATCH v2 2/3] contrib/subtree: functionalize split traversal
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-cs-subtree-split-recursion-v2-2-7266be870ba9@howdoi.land>
References: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
In-Reply-To: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
To: git@vger.kernel.org, Christian Heusel <christian@heusel.eu>, 
 george@mail.dietrich.pub
Cc: Christian Hesse <list@eworm.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Junio C Hamano <gitster@pobox.com>, Colin Stagner <ask+git@howdoi.land>
X-Mailer: b4 0.15-dev

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
index bae5d9170b..c1756b3e74 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -519,6 +519,31 @@ find_existing_splits () {
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
@@ -976,12 +1001,11 @@ cmd_split () {
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
 		process_split_commit "$rev" "$parents"

-- 
2.43.0

