Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1AB1684A0
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461155; cv=none; b=GYlXQN/PPOP3Yt+07PqJ3xHeAIWo8K/ETcUxzmZEFHotlMkSygoOTXnBigPw7ojZk6q55nxzlM0VFSWx7JXA/tyVtUmjk9pAx5n1uEURlGaVyR/ZUgxVSTBK3AA1LxcoZ4xjmnuipl/X6dwNa/xqvvi3yfnWWp9ddAigxsD461c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461155; c=relaxed/simple;
	bh=3SoP8x8m5o9y7LnNjfPUjFXp2N0IEr7pkwnQ5VpRQP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAp3dl+iYG/lvnofmmtMIPhzRzRYyhl7q0BEZCsKulhwfLnhx2mB8Ym0OjkoH6pL6UhASGWC83G4lNs0QpudrNxzZHGj+soXn49rx7CxhHzrI0iwpEVj8qcY+6eE9qAzHV6PABV3cfGOq2TIhwODO9TVnVv9OBmFhV+HZxhFnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZNPAPsmO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZNPAPsmO"
Received: (qmail 28018 invoked by uid 109); 1 Nov 2024 11:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3SoP8x8m5o9y7LnNjfPUjFXp2N0IEr7pkwnQ5VpRQP4=; b=ZNPAPsmOQjIxa1LX+pNSQ5t7ilBAC5LsDzBAlzvfas5MkodK8Tw1LLxKHQLtmdWPly503QtKiN+ZTOCGIrI6Ac/55gO176uZvMz2e33Uvaem7Bvy3UY31EbRlB7vr7BupQamrLAJqOXEsZuWcS6MYsWjYHZuEivMSj2YAupM/HwYkGwyfQQxUHfLghQtTjfuYghhSY21ZltkJREogGLqMHFVvJz7f5UGf/NUjG0Zm9kCyUcGRGl5Ltf/bNYuOkH77R+G1JPmbwvX7Qqaft1nSC2lAbaYEk+dOQIZKvJA/9/OdxOe6Ae1HYPzFyotiGpKa/0rfRRW2wwykrTGbDJ6vA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Nov 2024 11:39:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12296 invoked by uid 111); 1 Nov 2024 11:39:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2024 07:39:11 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 Nov 2024 07:39:10 -0400
From: Jeff King <peff@peff.net>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	git@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
Message-ID: <20241101113910.GA2301440@coredump.intra.peff.net>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
 <20241031114210.GA593548@coredump.intra.peff.net>
 <20241031122456.GB593548@coredump.intra.peff.net>
 <8734kbjlrq.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734kbjlrq.fsf@prevas.dk>

On Fri, Nov 01, 2024 at 11:23:05AM +0100, Rasmus Villemoes wrote:

> Perhaps we could on the kernel side replace the "git describe --match"
> calls with a helper, something like this (needs a lot of polishing):

Yeah, if you are describing off of a single tag, it may just be easier
to query things about the tag directly. Though I do still think
git-describe should be faster here. I'm still pondering what to do about
the disjoint history tests, but otherwise have a polished series to
send.

> ===
> # Produce output similar to what "git describe --match=$tag 2>
> # /dev/null" would.  It doesn't have to match exactly as the caller is
> # only interested in whether $tag == HEAD, and if not, the number
> # between the tag and the short sha1.
> describe()
> {
>     # Is $tag an annotated tag? Could/should probably be written using
>     # some plumbing instead of git describe, but with --exact-match,
>     # we avoid the walk-to-the-start-of-history behaviour, so fine for
>     # this demo.
>     git describe --exact-match --match=$tag $tag >/dev/null 2>/dev/null || return 1

Probably "git cat-file -t $tag" is the simplest way to see if it points
to a tag.

>     # Can it be used to describe HEAD, i.e. is it an ancestor of HEAD?
>     git merge-base --is-ancestor $tag HEAD || return 1
> 
>     # Find the number that "git describe" would append.
>     count=$(git rev-list --count $tag..HEAD)
>     if [ $count -eq 0 ] ; then
>         echo "$tag"
>     else
>         echo "$tag-$count-$head"
>     fi

You can query both of these at once with:

  git rev-list --count --left-right $tag...HEAD

That will traverse down to the merge base and give you two counts. If
the first one is 0, then $tag is a direct ancestor. And the second one
is the count of what's in HEAD.

At first glance, it seems like you'd waste time counting the HEAD side
when the --is-ancestor check could have rejected the tag earlier. But in
practice I think the time will always be dominated by walking down to
the merge base in all commands.

> I also don't know if either the --is-ancestor or the rev-list count
> could end up doing the same walk-all-commits we're trying to avoid.

It shouldn't. In all of those cases we'll generally walk breadth-first
down to the merge base. They're also operations that can take advantage
of other optimizations that git-describe never learned about. E.g.,
generation numbers in the commit graph.

We can even do fast --count with reachability bitmaps, though I wouldn't
expect most dev repos to have bitmaps built. Also, it looks like
"--left-right --count" does not support bitmaps. IMHO that is a bug. ;)

-Peff
