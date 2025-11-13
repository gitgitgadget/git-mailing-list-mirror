Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CA7E0E4
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006178; cv=none; b=b4kns/pCFXER8RFH9nBJOusnImLe4EALyBmcwqlmOiKl6HCJmKKGcQNYqPMsGn2Bsf7jClkA23UmZ3zPwT6Z9eSnOy5MJWrquktxgEHoBwJ3iX7+jrJ4oGdqZ+jMyqA4Pq1wkuiIlhXw+06Jjc0Gjp57GCDOl9tt8RCJGBJWJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006178; c=relaxed/simple;
	bh=MUfkiNKEF4M6y4/LXRfV4TLnhTd7LiBh77xP3GpujDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+ifzXkMLQ0ejTwI5cxnQcdAYIq1szEVZMoh3VoGHhBdCLg4zQ7wd97IUOq//CZIVsAS5qvAwMyXXRZDNPMfYQLDhl0sPTM+YEsLh9CyQBkbLESsO3uLDf8fWq7jyfjx2WxWAVsrKQz52e4t+cBagWmcNBgWUQJdeT9v8ZHf2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Nwz6dq0g; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Nwz6dq0g"
Received: (qmail 504947 invoked by uid 109); 13 Nov 2025 03:56:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MUfkiNKEF4M6y4/LXRfV4TLnhTd7LiBh77xP3GpujDI=; b=Nwz6dq0gJNhMMPGkcdMpNrFelQwu2Xzmyr18gajKW/AuZQo3AFr39FbeB67Fb39Tu1NALuwoxE/8WixY0cKZaVFkCH5Sl7+mGjdKKSTYc0HkTVDpoKtmffSmfLNUcnkipoffxVcgDMVYqy4RDAs+/lVfhfwocVXnqiKzba5eXJS9V7u+3m9GUl3cvvZTF8BemxGWih3fZhVvzvdJvj9GtDdNjS3HgcEGtTP5M5dTmzrAcjxO/sIiCH9DMH08naQe2PcxcPX/ZhRcfQlGDowMTCDhi5Z5nz/LKbSo6EmKGFn0g+h+/zuAqbUGzm9xH17riexs4EmQ8nFyx5mK3wZf4Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Nov 2025 03:56:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 798401 invoked by uid 111); 13 Nov 2025 03:56:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 22:56:14 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 22:56:14 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Wilck <mwilck@suse.com>, Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH] object-file: disallow adding submodules of different
 hash algo
Message-ID: <20251113035614.GA1758009@coredump.intra.peff.net>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <20251112235434.1499699-1-sandals@crustytoothpaste.net>
 <20251113032619.GA1739649@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113032619.GA1739649@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 10:26:24PM -0500, Jeff King wrote:

>      This whole lookup does feel a little funny and redundant. It comes
>      from f937bc2f86 (add: error appropriately on repository with no
>      commits, 2019-04-09), and the main goal is making the error message
>      better. But should we just improve the error message from
>      index_path() for this case (in which case the resolve call above go
>      away)?
> 
>      I think this is mostly orthogonal to your patch and we can ignore
>      it for now. I only bring it up because now it's weird that we are
>      trying to catch the hash mismatch, but have this unchecked extra
>      resolve.

So this is what I'd propose on top of your patch. I can hold onto it for
later if we don't want to muddy up what you're trying to do.

-- >8 --
Subject: [PATCH] read-cache: drop submodule check from add_to_cache()

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
index b075eb9b11..d8cc0e4c66 100755
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
-- 
2.52.0.rc2.237.g020256b90a

