Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D66BFA3
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246739; cv=none; b=K/ssnib+1CU2zz8ZZDZ0l6zvPNredoAJp9yGjVLJzT0cMpwHMRy6mSv4rtPXkuqCg1GLXmjDoZXEAAD7Ni4FjTcjDjzgGfARc84ePTYsydtzmKFAz7s5fAbvxuEHaAeuLfUMAu1ls82HUiJCaFwQU8Ax/+fiIoTtAKDYEjoY4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246739; c=relaxed/simple;
	bh=BhHhSNkk+WIRJCTRw296WVJJO3hyrPcT6iVA89nKBl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+fr2OS0n3BH9A0ZkmPwcRYxTumJSfYj/p2AcMIwvcg4IllR8bFE/lLJzn880UzoauaMBJylnMrNcU1gLBgdTBUu6z/wXQgJm2+Ua4/5JwNfxoYawy64YS2l9LVHf0zbaljsW8ld/iVXaaX6houLGde1MJgP3sgLJUNk9oKm8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l1L9tJvQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l1L9tJvQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7272A1F86A;
	Fri, 13 Sep 2024 12:58:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BhHhSNkk+WIRJCTRw296WVJJO3hyrPcT6iVA89
	nKBl4=; b=l1L9tJvQbgMuSpbPZYmvM4jcylg04MmaxW5FyTikPKG2Upb1I7hJ60
	fzrLD7jMKzr1waMyS1yYxdMDkNpstq94sCLK8iakbdmGUeF+p7sHaKFMN9yaLpNt
	XhxXQ2HEKjGIs+E2DhxuAIp1ZcL8aZbwDMww/WoIfWyKQiPGAunGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69AE71F869;
	Fri, 13 Sep 2024 12:58:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C85981F868;
	Fri, 13 Sep 2024 12:58:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Derrick
 Stolee [ ]" <stolee@gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
In-Reply-To: <CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
	(Shubham Kanodia's message of "Fri, 13 Sep 2024 11:46:24 +0530")
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
	<xmqqzfogsrqo.fsf@gitster.g>
	<CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
	<xmqq5xr4r818.fsf@gitster.g>
	<CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
Date: Fri, 13 Sep 2024 09:58:54 -0700
Message-ID: <xmqqplp7ze0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76595B4E-71F1-11EF-951A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> Ideally, a repository should be able to specify (say):
>
> remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
> remote.origin.prefetchref=refs/heads/main
>
> This configuration would maintain the normal behavior for fetches, but
> only prefetch the main branch.
> The rationale for this is that the main branch typically serves as the
> HEAD from which future branches will be forked in an active
> repository.

Oh, that is 100% agreeable.  All I wanted to caution you about was
what should happen when remote.origin.prefetchref in the above is
replaced to something like:

    [remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
        prefetchref = refs/notes/*

That is, if your refspec used for your real fetch (i.e. "git fetch"
without the "--prefetch" option) does not fetch anything from
"refs/notes/" hierarchy, prefetching from the hierarchy does not
help the real fetch.  I do not have a strong preference between
marking it as an error and silently ignoring the prefetch but
leaning towards the latter, and that is why my suggestion to
implement this new "prefetchref" as something that extends the
existing filter_prefetch_refspec(), which already filters out
refspec that fetches from the refs/tags/ namespace (and the ones
that do not store by having NULL in the .dst side).

> Regarding:
>
>> If prefetch_refs contains only positive patterns, then a refspec whose source
>> doesn't match any of these patterns is rejected.
>
> Simply rejecting a source refspec pattern in `remote.<remote>.fetch`
> wouldn't achieve our goal here.

I used the verb "reject" to mean "filter out", just like a refspec
with left-hand-side that begins with "refs/tags/" is filtered out
in the current filter_prefetch_refspec().  And that is exactly what
we want to achieve our goal here.

IOW, you would

 * read their ref advertisement, and pick only the ones that have a
   matching pattern in the left-hand-side of a remote.$name.fetch
   element.  With a more recent protocol, remote.$name.fetch may
   have already participated in narrowing what they advertise to
   begin with, but the end result is the same.

 * give it to filter_prefetch_refspec().

 * filter_prefetch_refspec() inspects the refspec elements, and
   rejects ones with no right-hand-side, and ones with
   left-hand-side that begin with refs/tags/.  The current code
   without your patch already works this way up to this point.

 * We extend the above filtering so that in addition to the two
   kinds we currently reject, reject the ones that do not match the
   prefetchref criteria.  This is what is needed to implement
   "prefetchref configuration limits the set of refs that get
   prefetched".

And what you quoted is a beginning of how "prefetchref configuration
limits".  It cannot be "add to what filter_prefetch_refspec() did",
like done by the implementation in the patch we are discussing.

If your configuration were this:

    [remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*

you would want a way to say things like

 (1) I want to prefetch everything I usually fetch

 (2) Among the ones I usually fetch, I only want to prefetch master
     and next branches.

 (3) I want to prefetch only refs/heads/jk/* branches, but not
     refs/heads/jk/wip/* branches.

 (4) I want to prefetch everything I usually fetch, except for
     refs/heads/wip/* branches.

The case (1) is the simplest.  You will leave .prefetchref empty.

For the case (2), you would write something like

    [remote "origin"]
	prefetchref = refs/heads/master
	prefetchref = refs/heads/next

So, when your prefetchref has all positive patterns, after the
existing conditional in filter_prefetch_refspec() passes a refspec
whose right-hand-side (i.e., .dst) is not NULL and whose
left-hand-side (i.e., .src) does not begin with "refs/tags/", you
further inspect and make sure it matches one of these prefetchref
patterns.  In example (2), if they advertised master, next, and seen
branches, refs/heads/seen would be filtered out because it matches
neither of the two patterns, so we would end up prefetching master
and next branches.

For the case (3), you would want to say something like

    [remote "origin"]
	prefetchref = refs/heads/jk/*
	prefetchref = !refs/heads/jk/wip/*

Now your prefetchref has some negative pattern.  When filtering what
the existing conditional in filter_prefetch_refspec() passed, you'd
inspect the refspec element and see if it matches any of the
positive patterns, and also if it does not match any of the negative
ones.  refs/heads/next does not match any positive ones and gets
rejected.  refs/heads/jk/main does match the positive pattern
'refs/heads/jk/*', and it does not match the negative pattern
'refs/heads/jk/wip/*', so it passes and will get prefetched.

For the case (4), you would write something like

    [remote "origin"]
	prefetchref = !refs/heads/wip/*

There is no positive pattern, so if you blindly apply the rule you
used for (3) above, everything will get rejected, which is not what
you want.  refs/heads/main does not match any positive patterns
(because there are no positive patterns given), but it does not
match any negative ones, so it passes and will get prefetched.

The condition to implement the above four cases (which I think
covers all the cases we care about, but I won't guarantee it is
exhaustive---you'd need to sanity check) would be

 - If there is 1 or more positive prefetchref patterns, the refspec
   element must match one of them to be considered for the next
   rule.  Otherwise, it will not be prefetched.

 - If the refspec element matches any of negative prefetchref
   patterns, it will not be prefetched.

