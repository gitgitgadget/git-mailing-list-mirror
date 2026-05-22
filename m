Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6672BF3F4
	for <git@vger.kernel.org>; Fri, 22 May 2026 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427704; cv=none; b=J84WoHaOrsK71uPEhGEp1PSED6JbrlFHgCTjWmwa9oAXxgRTUDpj3agnGexeVSwHCn2CPTc2F6u/0Hmluu4GOs2faZaolLjm4StqcrPytK7p8yc8JE1FtWe9YVHJ0tSdX8QaR4co55jFYWc4i5oQ5C2KWMMHeX7e7BevOrIlH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427704; c=relaxed/simple;
	bh=kVUGa7Je+ijKTKMTFnUiSdV8n57Ccs7pkfVp1QOks1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buHAWg4NhXAD4I7iOFQsKwDbAQLNAUp6H5Ku+O/fLJ8OLk+wby98OTZRNxvb/Hi2MPsRtK5QENRnyNrNzzQzGOvdCNj0Rfji02rW/XHrhcjFnsnjaqZ2x0tHePtJG3WWdV1L51PcP8IO5orfxKIJS6TE9TfClxOZawDWyA0Gd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YzDBpth9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YzDBpth9"
Received: (qmail 47146 invoked by uid 106); 22 May 2026 05:28:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kVUGa7Je+ijKTKMTFnUiSdV8n57Ccs7pkfVp1QOks1w=; b=YzDBpth9DOIcu/QTmUASWU8RrpYegsgOt+9CDG5KHEFO54UOKysMnFUFVldcOqM+oxwnwwGZ+YTNyjKmtK8SKetyu71cxsbs7WYnYJXvdRHAPBZlUQN27vQHIX63iKa7i/+mkz8pFfjg8/OGTw00TfQCiRx2UqndmTbYVMKjNGFjYoZsZKo+zvh/QKWqXEgE5IuytrD1ajFOATYuUoy12rko8vayzjanPeO8BOPfmmjqZA+KBF++6waQ9/tHcD1m/g3xzGnno0lmVkNCn+pUpufX/TEihJ74LcgEg1er/0Lqat46gx2c2Ero1TWLHvHl1W4sUFKKZcYBwQS+oNVPHA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2026 05:28:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99140 invoked by uid 111); 22 May 2026 05:28:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2026 01:28:25 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 May 2026 01:28:21 -0400
From: Jeff King <peff@peff.net>
To: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Greg Hurrell <greg@hurrell.net>,
	Erik Cervin Edin <erik@cervined.in>,
	Junio C Hamano <gitster@pobox.com>,
	Greg Hurrell <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH v3] git-jump: pick a mode automatically when invoked
 without arguments
Message-ID: <20260522052821.GC861761@coredump.intra.peff.net>
References: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
 <pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com>

On Thu, May 21, 2026 at 01:45:09PM +0000, Greg Hurrell via GitGitGadget wrote:

>     Changes since v2; all of these in response to feedback from Junio:
>     
>      * Removed stray # from README.
>      * Don't both teaching "auto" to select "ws" mode, because it is always
>        subsumed by "diff".
>      * Update usage string to make clear that git jump --stdout foo is not a
>        synonym for git jump --stdout auto foo, because distinguishing
>        between foo as <mode> and foo as <arg> is fraught with ambiguity.
>     
>     In answer to Junio's question:
>     
>     > If more than one interesting cases apply, what happens, and what
>     > should happen?
>     
>     it's an ordered choice (merge > diff).

Dropping the "ws" mode from auto makes sense to me. It could be slotted
in between "merge" and "diff" (a whitespace problem always implies a
diff, but a diff does not always imply a whitespace problem). But would
that actually be useful?

My impression of the "auto" feature is: I am too lazy to type, so just
take me to the interesting bits. And interesting in my experience with
git-jump is either "I am merging, take me to the conflict" or "I am
writing new code, take me to what I already did". Limiting the second
case just to whitespace violations (assuming there is at least one)
would probably be more confusing than helpful.

You could perhaps argue for one more layer of "interesting", which is:
if there are no unstaged changes, take me to the staged ones. Looking at
staged changes can be misleading if the working tree file has moved on
(since by definition we are dumping the editor into the working tree
file, not the staged contents). But if we know the diff between index
and working tree is empty, then that is not an issue.

I do sometimes use "git jump diff --cached" explicitly for that purpose.

If sounds like Greg has been living with "auto" and finding it useful
for a while. So I'm mostly inclined to take the patch as-is, and people
can experiment with it and suggest changes after using it in practice.

But here's my one final thought. The hierarchy of "merge > diff > diff
--cached", etc, makes me wonder if we could simply concatenate the
outputs.  I.e., show all of the merge conflicts and all of the diffs,
whitespace changes, and so on. But I guess you run into two issues:

  1. There will be duplicates. Every merge conflict is also a diff. And
     every whitespace violation is also a diff. So at the very least you
     need to de-dup these (which might not be entirely trivial, as they
     may overlap rather than starting at the same line).

  2. When resolving a merge, I'm not sure if the diffs are actually
     interesting. Usually I git-jump around until there are no more
     conflicts, and then I see if it builds. But I almost never want to
     jump to the other changes introduced by the side-branch. There are
     too many of them, and they are probably uninteresting. So adding
     both "merge" and "diff" elements to the quicklist would be
     annoying.

-Peff
