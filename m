Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8132250BF2
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186725; cv=none; b=mwdd1t28x/ryAqs2uMztwqTvCSsY5aTz4TiiHrtDYGy9TkFjlJBJ/IzoQpQXO/iH9SG7x9DqPvzynPCg1PFF7xnjayVQ3LbRcrOBVPAkpXVBRe/l2+hLVYDLGZJ5eKg9X9hW90CMOMy6iF3NAmlN9sy9y+oCBmB0B8kWZMYUwhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186725; c=relaxed/simple;
	bh=n9ETZv9hY51e3jVlAJJNaNdxo+/0YkKqt+GPmjGNDY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bm6R0EV+7CBIPiN7Lvko5sg9EnJd6lclgu5MORGHct/n4isjWKPzV2CCwdXF/XJBn9D/KNlBcmvhDcgG+PqWWYnVXOGjOlyazolQKi0hBTa9XUKfg3kfpDB5Rc5KbzXbBfD3JjOd/o3DuvnF8x5k41etPGQ0vguq8txi1ul5FlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=KtQOgnku; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="KtQOgnku"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZf-008AnY-U9; Sun, 15 Feb 2026 21:18:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=P9LAG/UYQJoxFhd97h76zjm04m+e84IQINY6bMD2agA=; b=KtQOgnku+JSO479Kl18Z8UP76r
	SHiciTpXw7YbIAKB8Y5W7Z8qFM5a1Y1rqoPk9aavEqcnWiwiUWJnx2aOmMNBRkJ74tQdJkegAoNEC
	C60ScHzHwg6Pw7QIwxmvIpkGZ3KLgRoe11aXQj3RUWDRozm3QvSGuay6EJFFzzaJX5pKObVYQQi5D
	oewwdKoHQlWJfSslAZzaJplkO+DajWldfVWIOdM7LzLgIDrhT7lObHzK+YNpK5Rtidl67kq/NJUG5
	ireP8ZRLavdyFEpSIbvqNO5J9IMADp8s+/H2AemdezrG5J/e9srbWKt06/7yCqS/BeuNVrD45SLfe
	FSuC99ew==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZf-0001Cn-HM; Sun, 15 Feb 2026 21:18:35 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vriZb-00E3Gq-2n; Sun, 15 Feb 2026 21:18:31 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	Christian Heusel <christian@heusel.eu>,
	george@mail.dietrich.pub
Cc: Colin Stagner <ask+git@howdoi.land>,
	Christian Hesse <list@eworm.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] contrib/subtree: reduce recursion during split
Date: Sun, 15 Feb 2026 14:17:45 -0600
Message-ID: <20260215201748.889866-4-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215201748.889866-1-ask+git@howdoi.land>
References: <20260215201748.889866-1-ask+git@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Debian-alikes, POSIX sh has a hardcoded recursion depth
of 1000. This limit operates like bash's `$FUNCNEST` [1], but
it does not actually respect `$FUNCNEST`. This is non-standard
behavior. On other distros, the sh recursion depth is limited
only by the available stack size.

With certain history graphs, subtree splits are recursive—with
one recursion per commit. Attempting to split complex repos that
have thousands of commits, like [2], may fail on these distros.

Reduce the amount of recursion required by eagerly discovering
the complete range of commits to process.

The recursion is a side-effect of the rejoin-finder in
`find_existing_splits`. Rejoin mode, as in

    git subtree split --rejoin -b hax main ...

improves the speed of later splits by merging the split history
back into `main`. This gives the splitting algorithm a stopping
point. The rejoin maps one commit on `main` to one split commit
on `hax`. If we encounter this commit, we know that it maps to
`hax`.

But this is only a single point in the history. Many splits
require history from before the rejoin. See patch content for
examples.

If pre-rejoin history is required, `check_parents` recursively
discovers each individual parent, with one recursion per commit.
The recursion deepens the entire tree, even if an older rejoin
is available. This quickly overwhelms the Debian sh stack.

Instead of recursively processing each commit, process *all* the
commits back to the next obvious starting point: i.e., either the
next-oldest --rejoin or the beginning of history. This is where the
recursion is likely to stop anyway.

While this still requires recursion, it is *considerably* less
recursive.

[1]: https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#index-FUNCNEST

[2]: https://github.com/christian-heusel/aur.git

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/git-subtree.sh | 56 ++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7a62ef7504..54d7151a50 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -312,6 +312,46 @@ cache_miss () {
 }
 
 # Usage: check_parents [REVS...]
+#
+# During a split, check that every commit in REVS has already been
+# processed via `process_split_commit`. If not, deepen the history
+# until it is.
+#
+# Commits authored by `subtree split` have to be created in the
+# same order as every other git commit: ancestor-first, with new
+# commits building on old commits. The traversal order normally
+# ensures this is the case, but it also excludes --rejoins commits
+# by default.
+#
+# The --rejoin tells us, "this mainline commit is equivalent to
+# this split commit." The relationship is only known for that
+# exact commit---and not before or after it. Frequently, commits
+# prior to a rejoin are not needed... but, just as often, they
+# are! Consider this history graph:
+#
+#              --D---
+#             /      \
+#         A--B--C--R--X--Y    main
+#                 /     /
+#          a--b--c     /      split
+#              \      /
+#               --e--/
+#
+# The main branch has commits A, B, and C. main is split into
+# commits a, b, and c. The split history is rejoined at R.
+#
+# There are at least two cases where we might need the A-B-C
+# history that is prior to R:
+#
+# 1. Commit D is based on history prior to R, but
+#    it isn't merged into mainline until after R.
+#
+# 2. Commit e is based on old split history. It is merged
+#    back into mainline with a subtree merge. Again, this
+#    happens after R.
+#
+# check_parents detects these cases and deepens the history
+# to the next available rejoin.
 check_parents () {
 	missed=$(cache_miss "$@") || exit $?
 	local indent=$(($indent + 1))
@@ -319,8 +359,20 @@ check_parents () {
 	do
 		if ! test -r "$cachedir/notree/$miss"
 		then
-			debug "incorrect order: $miss"
-			process_split_commit "$miss" ""
+			debug "found commit excluded by --rejoin: $miss. skipping to the next --rejoin..."
+			unrevs="$(find_existing_splits "$dir" "$miss" "$repository")" || exit 1
+
+			find_commits_to_split "$miss" "$unrevs" |
+			while read -r rev parents
+			do
+				process_split_commit "$rev" "$parents"
+			done
+
+			if ! test -r "$cachedir/$miss" &&
+				! test -r "$cachedir/notree/$miss"
+			then
+				die "failed to deepen history at $miss"
+			fi
 		fi
 	done
 }
-- 
2.43.0

