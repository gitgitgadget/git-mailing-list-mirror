Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305F417369
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341486; cv=none; b=YWaNnZmj83+8LrUxN0hvgPSmnqfI6sxgcuOfq23qyagzmicFmkyxTD0+cwDJjuBn8Abcy/1RfW8Iw6vzcyyKpE6WH9QIyLmi3C6J/iHu+pGkO/vIiBgCzypQAy8nkTsXUemQJzcUyp8fYHVtIIzTebZN6x7b7jIh7fGtDwhCXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341486; c=relaxed/simple;
	bh=Sd991CViyuNXIbwoxhhot8L55OsDe6gfVcChH4Tx3bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtwPXTCj7BExvpc316+42hn4iOS2IDxPZ/mFaAtGz3nOn8u5KA3CrDTPYl4hZffaNWQZf6yzbUZb/KD7am8n97PQaava7pgaZ1o+GIRV8D4saLQ6I94DvN/xOl1KKTtkcw5t+OZwuydU3CklZUqfgMCuymDLPUvNcLFFHPVzklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=2PB1so4c; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="2PB1so4c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=l.chiark; h=DKIM-Signature-Warning:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=txpjH+HwSVIPKDUfi/xOJeJrgUa1W3I4vkU1Y4JB7Jo=; b=2PB1so4c4pxuldZPAMQOELxEC1
	rbB1pJcq2fc7Rb0KnBvJ0erbDFhjeBTLw+EJCtUGJB9kPEqGgw1ibitDtn0uiLjqTFHYwfPYzbm3j
	7wo+j/nEuNi4uFzrnWxg/QWL0TXD6QXAgOLtSe0cvEGq51g3OldDf/X/mL9ntUMus/aJoC6IYZfif
	w7UFgOOmSn58XCgej6/N+XmgcqAsPWkBR9ocHYChIlYghdyonFTdDllMScYkfnVvb+mNvDDiUDer1
	Je7sk7YGMXwamOB3dV5qHfFoaVlhxC/BKrPuacKMcv1lvLNU9T/R1NDRNEX3CDlFN0zVKAy7UkfAN
	ZSs5kMIg==;
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
	by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with esmtp
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wghy2-0000qE-BD; Mon, 06 Jul 2026 12:58:30 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
To: git@vger.kernel.org
Cc: Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Colin Stagner <ask+git@howdoi.land>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite
Date: Mon,  6 Jul 2026 12:58:15 +0100
Message-ID: <20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/26/2626ff584df1644c89bafcc8f3c9745f.pem

This is going to be forward compatible, but not backward compatible:
projects are expected to adopt the new tool, but not go back to this
old one.

CC: Colin Stagner <ask+git@howdoi.land>
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 contrib/subtree/git-subtree.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 791fd8260c..e9c7ca7cf5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -278,6 +278,20 @@ main () {
 	"cmd_$arg_command" "$@"
 }
 
+# Usage: reject_if_v2_config REV
+#
+# Bails if we find .git-subtree/config.  This file is used by the RIIR
+# git-subtree, which can read data from this script, but which generates
+# data that this script cannot cope with.  So if we find that the user's
+# project has already been processed with the new tool, we stop, to
+# avoid generating broken output.
+reject_if_v2_config () {
+	local config=.git-subtree/config
+	if git rev-parse --verify -q "$rev:$config"; then
+		die "fatal: tree contains $config: has been processed with new standalone (Rust) git-subtree; use that tool instead of this one.  See https://codeberg.org/diziet/git-subtree https://crates.io/crates/git-subtree"
+	fi
+}
+
 # Usage: cache_setup
 cache_setup () {
 	assert test $# = 0
@@ -846,6 +860,7 @@ process_split_commit () {
 #    Or: cmd_add REPOSITORY REF
 cmd_add () {
 
+	reject_if_v2_config HEAD
 	ensure_clean
 
 	if test $# -eq 1
@@ -934,6 +949,8 @@ cmd_split () {
 		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
 	fi
 
+	reject_if_v2_config "$rev"
+
 	# Now validate prefix against the commit, not the working tree
 	if ! git cat-file -e "$rev:$dir" 2>/dev/null
 	then
@@ -1034,6 +1051,7 @@ cmd_merge () {
 	then
 		repository="$2"
 	fi
+	reject_if_v2_config HEAD
 	ensure_clean
 
 	if test -n "$arg_addmerge_squash"
-- 
2.47.3

