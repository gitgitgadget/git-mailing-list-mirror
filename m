Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9E29B224
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004395; cv=none; b=itZiG0mUqmxgyUPY0pLa3a8m8MA97ZuzXM9VtkAP1Wpo8aOk84VDhC1gMdI3KaygAdyDMnHPRHYYGlU+bit+EeY30LQJndPMX23mslJLfFhF8hvO0snWqRSmoB5dXrZdwm0lOzbjQl3VztHeM1oQzWBk7Y/Hflp4TrmgDVJWEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004395; c=relaxed/simple;
	bh=oJye1j5COMrsy45wBfSD9YiqbCBdf//sHhjEiKHDUu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4YOTSriAEY0YkZbY6eRjhYVilLSDBpTNa0hoC7HgrBHeOFzkprMEXXmnurNPfuojnobbq+FBg6c0iDV1mPIQ9nxXkc5IiHhu0tNXQknLDYeMGDvumLXZXe/qekIfSGQJlTgKgude3W3yXtoWV042LlNk27RCT9MugRwUCh6b44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Vh1JBadB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Vh1JBadB"
Received: (qmail 504852 invoked by uid 109); 13 Nov 2025 03:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oJye1j5COMrsy45wBfSD9YiqbCBdf//sHhjEiKHDUu0=; b=Vh1JBadBAjNEAoeD4sCoHR70kb/gPsKesI5gC+YCdj1Rw9bN4l+zktrDa441rOhktVoD5va6c8uN8qqO0NzcDuH3Ek8egJCExnZ3H8TGBbamBvYPRpasiu8S/iP+VTW1anTnlSA2tQyMImTGbC7/aHJICfMbX9duryITRXMWGRsDDw8ty5ylS+UU7WfMgOFnlhBmO2TQW/AjubFRJilYLwWAbh/xUzarMxNSWOosCl/V5WjEneolrQvfuHEZWgsw/X4AMU0MG+aCYcchFXS9qqzmOYG5A3daltR4qkzBPbiTMN1xL7U7Ry3EoNXxflpXE81I9+e3EyaP7FRWszz90Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Nov 2025 03:26:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 798165 invoked by uid 111); 13 Nov 2025 03:26:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 22:26:24 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 22:26:19 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Wilck <mwilck@suse.com>, Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH] object-file: disallow adding submodules of different
 hash algo
Message-ID: <20251113032619.GA1739649@coredump.intra.peff.net>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <20251112235434.1499699-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112235434.1499699-1-sandals@crustytoothpaste.net>

On Wed, Nov 12, 2025 at 11:54:34PM +0000, brian m. carlson wrote:

> Since this cannot work in the general case, restrict adding a submodule
> of a different algorithm to the index.  Add tests for git add and git
> submodule add that these are rejected.

This makes sense. I had meant to follow up on our conversation and patch
from last month, but it was still on my todo list. Fortunately that
earlier attempt gives me something concrete to compare to. ;)

> diff --git a/object-file.c b/object-file.c
> index 4675c8ed6b..8c43c52ed0 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1661,7 +1661,11 @@ int index_path(struct index_state *istate, struct object_id *oid,
>  		strbuf_release(&sb);
>  		break;
>  	case S_IFDIR:
> -		return repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid);
> +		if (repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid))
> +			return -1;
> +		if (&hash_algos[oid->algo] != istate->repo->hash_algo)
> +			return error(_("cannot add a submodule of a different hash algorithm"));
> +		break;
>  	default:
>  		return error(_("%s: unsupported file type"), path);
>  	}

OK, you're checking for it here in index_path(), whereas my earlier
attempt did it in add_to_index(). For the most part, I think your spot
makes more sense, as it is at a lower level. add_to_index() eventually
calls into index_path(), and so do some other code paths.

That does leave two interesting oddities:

  1. In add_to_index(), we have this code:

          if (S_ISDIR(st_mode)) {
                  if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
                          return error(_("'%s' does not have a commit checked out"), path);
                  while (namelen && path[namelen-1] == '/')
                          namelen--;
          }

     which is run before we hit index_path(). So it may get an oid
     result with an unexpected hash. I think that's OK, because nobody
     ever looks at it (which would be a lot more obvious if we declared
     the variable inside the conditional block here).

     This whole lookup does feel a little funny and redundant. It comes
     from f937bc2f86 (add: error appropriately on repository with no
     commits, 2019-04-09), and the main goal is making the error message
     better. But should we just improve the error message from
     index_path() for this case (in which case the resolve call above go
     away)?

     I think this is mostly orthogonal to your patch and we can ignore
     it for now. I only bring it up because now it's weird that we are
     trying to catch the hash mismatch, but have this unchecked extra
     resolve.

  2. There are paths in add_to_index() that _don't_ hit index_path(). In
     particular, intent-to-add entries. So with your patch, even though
     a regular "git add" is forbidden:

       $ git add repo
       error: cannot add a submodule of a different hash algorithm
       error: unable to index file 'repo'
       fatal: updating files failed

     I can still do this:

       $ git add -N repo
       warning: adding embedded git repository: repo
       $ git ls-files -s
       160000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	repo

     which skips the hash check entirely. Which kind of makes sense,
     because the resulting index entry does not have a real oid in it at
     all (it gets the empty blob oid). But it does have a real 160000
     mode.

     Can we make things worse from there? If we try to update it, for
     example, that will fail:

       $ git add -u
       error: cannot add a submodule of a different hash algorithm
       error: unable to index file 'repo'
       fatal: updating files failed

     So...maybe this is OK?

> +test_expect_success 'cannot add a submodule of a different algorithm' '
> +	git init --object-format=sha256 sha256 &&
> +	(
> +		cd sha256 &&
> +		test_commit abc &&
> +		git init --object-format=sha1 submodule &&
> +		(
> +			cd submodule &&
> +			test_commit def
> +		) &&
> +		test_must_fail git add submodule &&
> +		test $(git ls-files --stage | grep ^160000 | wc -l) -eq 0
> +	) &&

Makes sense. Purists might complain about "git ls-files" on the left
hand side of a pipe, but I think it is OK here. Though you can golf away
a few subprocesses at the same time with:

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b075eb9b11..6a1d4e2659 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -547,12 +547,10 @@ test_expect_success 'cannot add a submodule of a different algorithm' '
 		cd sha256 &&
 		test_commit abc &&
 		git init --object-format=sha1 submodule &&
-		(
-			cd submodule &&
-			test_commit def
-		) &&
+		test_commit -C submodule def &&
 		test_must_fail git add submodule &&
-		test $(git ls-files --stage | grep ^160000 | wc -l) -eq 0
+		git ls-files --stage >entries &&
+		test_grep ! ^160000 entries
 	) &&
 	git init --object-format=sha1 sha1 &&
 	(

but we are getting into nits there.

Is it worth checking the stderr of the failing "git add submodule" call?
Adding a repo directly via "git add" is already something we generate a
warning for, and it's possible we might eventually make it an error. In
which case the command would fail without even hitting your new code,
but we'd have no idea. Adding in a test_grep for "cannot add a submodule
of a different hash algorithm" would at least make sure we're hitting
the error we expect.

-Peff
