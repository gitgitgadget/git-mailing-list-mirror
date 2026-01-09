Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7B22FE0E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923180; cv=none; b=J8zwv1nmfVQBuwHAL8yT9iFELFGxxisnWhLzIDstK3/KbMzlvO2Q6FzMagEP+7UVB1kwTNMdkJDNplTULa6ysk3RHwLNWFIPAquuu00OikoKoTV7Q58hVx7sdNYMNr7yoP7u03yd1AJbLRAgnfC7jp45OedtPkoh/Hj5yJ0I7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923180; c=relaxed/simple;
	bh=TMCPjpLIF+qXoBerYKTB/eZJtl86gD1Ewa2LVFok3JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyDcxaoCEnLjZ4S2g0Cg39X1znHKTUMg7FYwj8obTZ7bWPeVT95bT+f9324shqeoXcJnGIicKvZ2q6EZgcSq2fxb/wPdrrB88taBRoGHs2yLOHid2dYzULH0P8qYcknJQFyTCLw1NtGSS7HOjE6f/ptsYCRGORBU/vXA6PbqX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GPmZZ14g; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GPmZZ14g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767923172;
	bh=TMCPjpLIF+qXoBerYKTB/eZJtl86gD1Ewa2LVFok3JE=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GPmZZ14gUusBdt1V4kt2J1pkMr2+0QF2KAu7awim8srixUdJZp8YHzRPXhInkklbH
	 Qd29yR25hPrILZ5XdxA8lM8qSZTJPpKqtBBdGj7S9yy+NGsEVcI/GIiznfB61gaw4E
	 Hff98IRqG7rmkGu15/wlpvToEYVTjKbkH5MHWQ3B9S2++v6KWr8rJYzfIql/tfNM4L
	 EkaNh0WSztkV+IAlLjlnoPkbNrCV2W32K+nIf3d3cVyGD8lblheuSy+JWZehZDBM8n
	 fUes7we2y7jQjruIHhZUrjLB2B9/d4miwQxpV9amoHy8Y4Y2pyMxpn11eq0Mlq5ovW
	 c8eaugNnxh89F9l4iJshbEJnVn5V75nE1bK+G/wi6F7s1c5+ktKTTOlzF+gX07bUY2
	 wjYjlr03aDWwP+NINO6snWEyN1i3NtV8v5C90iZ8Z4rhR6FRjpu4nHtfnSaj2fwNMr
	 GApK4MN5O7MRR5jXs4AJe7ybtd060rGs4oVlFTjv/QPp9Ty26p9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ae80:80f7:4179:f223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7563520031;
	Fri,  9 Jan 2026 01:46:12 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitfaq: document using stash import/export to sync working tree
Date: Fri,  9 Jan 2026 01:46:08 +0000
Message-ID: <20260109014608.42773-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git 2.51 learned how to import and export stashes.  This is a
secure and robust way to transfer working tree states across machines
and comes with almost none of the pitfalls of rsync or other tools.
Recommend this as an alternative in the FAQ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.adoc | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitfaq.adoc b/Documentation/gitfaq.adoc
index 8d3647d359..f6c9b9d9f7 100644
--- a/Documentation/gitfaq.adoc
+++ b/Documentation/gitfaq.adoc
@@ -233,14 +233,30 @@ of refs, such that both sides end up with different commits on a branch that
 the other doesn't have.  This can result in important objects becoming
 unreferenced and possibly pruned by `git gc`, causing data loss.
 +
-Therefore, it's better to push your work to either the other system or a central
-server using the normal push and pull mechanism.  However, this doesn't always
-preserve important data, like stashes, so some people prefer to share a working
-tree across systems.
+Therefore, it's better to push your work to either the other system or a
+central server using the normal push and pull mechanism.  In Git 2.51, Git
+learned to import and export stashes, so it's possible to synchronize the state
+of the working tree by stashing it with `git stash`, then exporting either all
+stashes with `git stash export --to-ref refs/heads/stashes` (assuming you want
+to export to the `stashes` branch) or selecting stashes by adding their numbers
+to the end of that command.  It's also possible to include untracked files by
+using the `--include-untracked` argument when stashing the data in the first
+place, but be careful not to do this if any of these contain sensitive
+information.
 +
-If you do this, the recommended approach is to use `rsync -a --delete-after`
-(ideally with an encrypted connection such as with `ssh`) on the root of
-repository.  You should ensure several things when you do this:
+You can then push the `stashes` branch (or whatever branch you've exported to),
+fetch them to the local system (such as with `git fetch origin
++stashes:stashes`), and import the stashes on the other system with `git stash
+import stashes` (again, changing the name as necessary).  Applying the changes
+to the working tree can be done with `git stash pop` or `git stash apply`.
+This is the approach that is most robust and most likely to avoid unintended
+problems.
++
+Having said that, there are some cases where people nevertheless prefer to
+share a working tree across systems.  If you do this, the recommended approach
+is to use `rsync -a --delete-after` (ideally with an encrypted connection such
+as with `ssh`) on the root of repository.  You should ensure several things
+when you do this:
 +
 * If you have additional worktrees or a separate Git directory, they must be
   synced at the same time as the main working tree and repository.
@@ -251,10 +267,11 @@ repository.  You should ensure several things when you do this:
   any sort are taking place on it, including background operations like `git
   gc` and operations invoked by your editor).
 +
-Be aware that even with these recommendations, syncing in this way has some risk
-since it bypasses Git's normal integrity checking for repositories, so having
-backups is advised.  You may also wish to do a `git fsck` to verify the
-integrity of your data on the destination system after syncing.
+Be aware that even with these recommendations, syncing working trees in this
+way has some risk since it bypasses Git's normal integrity checking for
+repositories, so having backups is advised.  You may also wish to do a `git
+fsck` to verify the integrity of your data on the destination system after
+syncing.
 
 Common Issues
 -------------
