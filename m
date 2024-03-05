Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F912EBC6
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674012; cv=none; b=AahSttjpO/8ouXTDvxczyHjZiqNVfhggFJqMqZC7ehnA+k06zBjZfRwwAxAdx6Y18A4+Hej7FKbApiBMJXRSxKHbtwpchLgA7rV8czlDXMSr/wyJyJ2J3UAWEbLfq9qQj/bHWzrsPh+FfvO58cKHoQRzg6OOBrfZJNA3yQu3rdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674012; c=relaxed/simple;
	bh=Ka5Cjs70+6pU9eIPGJj+hJfBDJq6YqNeVh3vxWfJhYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXNSk+II7Hles5nBnFbFlAE6Gx4jD1kMQEq0CrBpaQRz2I54kZREvGH6777oxfofWri/nznH65ejMQ0BoRzZ+F6VdavNpJ4I+ho+JuCxx7itIXlqQVi+wtWage2ezRhadP0wGex1ndMUdl2p0wsC91xdTkVB3faqpqtEB6/eNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJE-000000002UW-1rAz
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:48 +0100
Received: from [10.20.10.230] (port=36162 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJD-006Kie-15;
	Tue, 05 Mar 2024 22:26:47 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 0101B18012F;
	Tue,  5 Mar 2024 22:26:45 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:45 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 20/22] t/t9*: merge "grep | sed" pipelines
Date: Tue,  5 Mar 2024 22:25:19 +0100
Message-ID: <20240305212533.12947-21-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t9118-git-svn-funky-branch-names.sh | 2 +-
 t/t9350-fast-export.sh                | 2 +-
 t/t9824-git-p4-git-lfs.sh             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index a159ff96b718..d3261e35b818 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup svnrepo' '
 # SVN 1.7 will truncate "not-a%40{0]" to just "not-a".
 # Look at what SVN wound up naming the branch and use that.
 # Be sure to escape the @ if it shows up.
-non_reflog=$(svn_cmd ls "$svnrepo/pr ject/branches" | grep not-a | sed 's/\///' | sed 's/@/%40/')
+non_reflog=$(svn_cmd ls "$svnrepo/pr ject/branches" | sed -ne '/not-a/ { s/\///; s/@/%40/; p }')
 
 test_expect_success 'test clone with funky branch names' '
 	git svn clone -s "$svnrepo/pr ject" project &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d86d07a79d4f..1eb035ee4ce5 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -537,7 +537,7 @@ test_expect_success 'full-tree re-shows unmodified files'        '
 
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f main &&
-	HEAD_TREE=$(git show -s --pretty=raw HEAD | grep tree | sed "s/tree //") &&
+	HEAD_TREE=$(git show -s --pretty=raw HEAD | sed -n "/tree/s/tree //p") &&
 	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
 	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
 	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index fd430403d716..80c8c31e320f 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -18,7 +18,7 @@ test_file_in_lfs () {
 	sed -n '3,3 p' "$FILE" | grep "^size " &&
 	test_line_count = 3 "$FILE" &&
 	grep "size $SIZE" "$FILE" &&
-	HASH=$(grep "oid sha256:" "$FILE" | sed -e "s/oid sha256://g") &&
+	HASH=$(sed -ne "/oid sha256:/s/oid sha256://gp" "$FILE") &&
 	LFS_FILE=".git/lfs/objects/$(echo "$HASH" | cut -c1-2)/$(echo "$HASH" | cut -c3-4)/$HASH" &&
 	echo $EXPECTED_CONTENT >expect &&
 	test_path_is_file "$FILE" &&
-- 
2.44.0

