Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DFB667
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171699; cv=none; b=XDOXFpa4fZWHyL0ZZw6m5vr4V0hs2VPHX4f2b4h6At2fAeCCwseg4xYSgZ7IM+VQJbg7HeivRSa/WlyA4nzoLHOiHGMMh/cnAIuaEELe/150S2v4McmoTHuBeeMqzgVIHd66uEIgZxUbbd1rypAoXXjxvq9Te7Ws1a2pkLZMOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171699; c=relaxed/simple;
	bh=+HhSZcs5bWYxgEtNB400l4Xk5/4jjgboQkeI1jWGJLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL1UrGTrjczylsyNyCKhSsrdcEQWJOxRayzcq45ylR4iZ/oJrG0kl9IEbkatJqdQIeG6iiKMbT0aheymoBbgglwRQsSZA9olFI+sA8adLvc3Cbmr9ganHJlqrFn1/NilO8v3R1NSjeF92YytAU6+Ebfn4I+tgphsYDMPYFc8KbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sd6C0FoF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sd6C0FoF"
Received: (qmail 16597 invoked by uid 109); 2 Dec 2024 20:34:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+HhSZcs5bWYxgEtNB400l4Xk5/4jjgboQkeI1jWGJLQ=; b=Sd6C0FoFLCwFrjdLVkNmkAK96nyjy80Bw36imhHzWC/xbaV8KI8dEGkRFtAe2tKmf/xHMWlaHnz6AiiBeEcRCy+ClKBKEgVfywQYpFkkbo6S9NNcHjO9tRi4/MEkNzaOWhXtiFGwAHS9goBy1Ibrv9qGvn86O79OiPI06zQAy9lq+XI1Yx/YjlZbsA4vlhWcwn6MUgPiix/XhgY8h43SFj8bGetz9xXT/zEgEuRezHf3DVA361aLOE7B0bxJOeE0MAJxQyhnkNIe1rIwE1e6vNr2Ui/x0bxK0ptAzaTPSo+hmxBZwW2ZSNSlisCck8jNpgNm0E6jlrwOq1JpnQELjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 20:34:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26150 invoked by uid 111); 2 Dec 2024 20:34:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 15:34:52 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 15:34:51 -0500
From: Jeff King <peff@peff.net>
To: Dmitriy Panteleyev <dpantel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
Message-ID: <20241202203451.GA776185@coredump.intra.peff.net>
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net>
 <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net>
 <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>

On Sun, Dec 01, 2024 at 03:24:35PM -0700, Dmitriy Panteleyev wrote:

> You are right, Jeff, I needed to run one more bisect. But it does point to
> the commit I linked above. The bisect result is:

Thanks for checking. I'm still puzzled how this commit:

> 04fb96219abc0cbe46ba084997dc9066de3ac889 is the first bad commit
> commit 04fb96219abc0cbe46ba084997dc9066de3ac889
> Author: Jeff King <peff@peff.net>
> Date:   Thu Nov 17 17:37:58 2022 -0500
> 
>     parse_object(): drop extra "has" check before checking object type
> 
>     When parsing an object of unknown type, we check to see if it's a blob,
>     so we can use our streaming code path. This uses oid_object_info() to
>     check the type, but before doing so we call repo_has_object_file(). This
>     latter is pointless, as oid_object_info() will already fail if the
>     object is missing. Checking it ahead of time just complicates the code
>     and is a waste of resources (albeit small).
> 
>     Let's drop the redundant check.

could be the culprit, though. The diff is just

diff --git a/object.c b/object.c
index 8a74eb85e9..16eb944e98 100644
--- a/object.c
+++ b/object.c
@@ -287,8 +287,7 @@ struct object *parse_object_with_flags(struct repository *r,
 	}
 
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
-	    (!obj && repo_has_object_file(r, oid) &&
-	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
+	    (!obj && oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;

So it is actually doing _less_, though what it is removing is going to
just be a pack .idx lookup (or maybe a stat() call if the object is
loose).

> I am not at all familiar with the standard process for this, but the way I ran
> the test is:
> 
> (0. cloned test project into /nfs/proj/ and made a change)
> 1. cloned git repo (from github) into /tmp/git/
> 2. ran bisect in /tmp/git/, starting with v2.34.1 (good) and v2.43.1 (bad)
> 3. ran `make all` in /tmp/git/
> 4. in /nfs/proj/ ran `/tmp/git/bin-wrappers/git commit -m 'test'`
> 5. repeated 2-4

That sounds reasonable. I'm still not sure what's going on. It's always
possible that commit introduced a problem, but I just don't see it. So I
still have a suspicion (especially given that your symptom is a bus
error) that the problem might not be deterministic.

I wonder if building git with:

  make SANITIZE=address,undefined

and running the same test might yield anything useful.

-Peff
