Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D991D5ACE
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763168303; cv=none; b=apfykj+k7jIo0V7KnJA0Pm4wIRTcYnA5Z/FmobOtQJm0XM73HbW30KblgBVFul7p4fkqMuZDja9lYWtUCKKUaxjZuXJJcvtjmWdCToBbfNm797beIGaNPDcftrntofdvavDqWW37Zt+YNns09672p44Mh/1cpbNfuMhtkEAjIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763168303; c=relaxed/simple;
	bh=NNx5N0vzkm6RtqpAfQmS8qjkZ0MjfqaWgk3MH5Z2Nco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuQ9jmeVnMsW89nlYPMeyWJtGBjfp/UsyhTVKndcH+7KQPz9TGkA3nx53NasOjlbFPIqNsrQVN3O8vGdQ+lqkOHYY8jKwokNZuAeC0cd6lmB7nkb33JEiEbzL0BgH+I6aGRDnnGImnyT4FP5xEc/VPnHEDy6iNrQS6lP+4fpnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vJwZFe3i; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vJwZFe3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763168300;
	bh=NNx5N0vzkm6RtqpAfQmS8qjkZ0MjfqaWgk3MH5Z2Nco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=vJwZFe3iRsSCimRv7ixFBxUyoyLCdoRPxe1k5BZXhHQKHZAct2dfeG2yU4NjbKr9q
	 4uQLXhRPSsplRFyK6TumP6pQQ7O3vA12JbepGbRg4n+Z/iMH41y2KzxIi4x/t1xfil
	 aSxVxnbVeKPPYf1korEYbtjxOA1Gdnj5nJmGGSXvCkUJAJ+m8qk+qrmZyXDt5Wex/Z
	 xbVePp4ziccWtrQTmXnJS4e5RIAt/tmqLz8ZwlH19N9RVcZQWqGrhActX31eYMBxJK
	 WS7a51gUcd+Hte2a1oCf0moYKQMHJ5fODGGBQd2yaYY6mTR8XxwkMNNgutCJqmt/M8
	 nGRTwOBv3PDYJq5X3b/LOSnPgAxcKLUH6HezA8f3N52R7JEd06MaGpVC80T9egKwYH
	 gSHXj85jmnDhWVz9ru6Cbr8zYfCjwTr6nvr630n6zaApNkmmB79i3YQmFHV30acg3k
	 KzLLizeKkIchv7M4Rf9QJu3JC/ixzqP268zoqSpz9RfbO9Y3khq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d3f4:1fda:d3d6:71fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A8DC02012A;
	Sat, 15 Nov 2025 00:58:20 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Martin Wilck <mwilck@suse.com>,
	Adrian Schroeter <adrian@suse.com>
Subject: [PATCH v2 2/2] read-cache: drop submodule check from add_to_cache()
Date: Sat, 15 Nov 2025 00:58:18 +0000
Message-ID: <20251115005818.2271557-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251115005818.2271557-1-sandals@crustytoothpaste.net>
References: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
 <20251115005818.2271557-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

In add_to_cache(), we treat any directories as submodules, and complain
if we can't resolve their HEAD. This call to resolve_gitlink_ref() was
added by f937bc2f86 (add: error appropriately on repository with no
commits, 2019-04-09), with the goal of improving the error message for
empty repositories.

But we already resolve the submodule HEAD in index_path(), which is
where we find the actual oid we're going to use. Resolving it again here
introduces some downsides:

  1. It's more work, since we have to open up the submodule repository's
     files twice.

  2. There are call paths that get to index_path() without going through
     add_to_cache(). For instance, we'd want a similar informative
     message if "git diff empty" finds that it can't resolve the
     submodule's HEAD. (In theory we can also get there through
     update-index, but AFAICT it refuses to consider directories as
     submodules at all, and just complains about them).

  3. The resolution in index_path() catches more errors that we don't
     handle here. In particular, it will validate that the object format
     for the submodule matches that of the superproject. This isn't a
     bug, since our call in add_to_cache() throws away the oid it gets
     without looking at it. But it certainly caused confusion for me
     when looking at where the object-format check should go.

So instead of resolving the submodule HEAD in add_to_cache(), let's just
teach the call in index_path() to actually produce an error message
(which it already does for other cases). That's probably what f937bc2f86
should have done in the first place, and it gives us a single point of
resolution when adding a submodule to the index.

The resulting output is slightly more verbose, as we propagate the error
up the call stack, but I think that's OK (and again, matches many other
errors we get when indexing fails).

I've left the text of the error message as-is, though it is perhaps
overly specific.  There are many reasons that resolving the submodule
HEAD might fail, though outside of corruption or system errors it is
probably most likely that the submodule HEAD is simply on an unborn
branch.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c  | 2 +-
 read-cache.c   | 3 ---
 t/t3700-add.sh | 1 +
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8c43c52ed0..a7438b6205 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1662,7 +1662,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		break;
 	case S_IFDIR:
 		if (repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid))
-			return -1;
+			return error(_("'%s' does not have a commit checked out"), path);
 		if (&hash_algos[oid->algo] != istate->repo->hash_algo)
 			return error(_("cannot add a submodule of a different hash algorithm"));
 		break;
diff --git a/read-cache.c b/read-cache.c
index 032480d0c7..990d4ead0d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -706,7 +706,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 	unsigned hash_flags = pretend ? 0 : INDEX_WRITE_OBJECT;
-	struct object_id oid;
 
 	if (flags & ADD_CACHE_RENORMALIZE)
 		hash_flags |= INDEX_RENORMALIZE;
@@ -716,8 +715,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 
 	namelen = strlen(path);
 	if (S_ISDIR(st_mode)) {
-		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
-			return error(_("'%s' does not have a commit checked out"), path);
 		while (namelen && path[namelen-1] == '/')
 			namelen--;
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 9a2c8dbcc2..af93e53c12 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -388,6 +388,7 @@ test_expect_success 'error on a repository with no commits' '
 	test_must_fail git add empty >actual 2>&1 &&
 	cat >expect <<-EOF &&
 	error: '"'empty/'"' does not have a commit checked out
+	error: unable to index file '"'empty/'"'
 	fatal: adding files failed
 	EOF
 	test_cmp expect actual
