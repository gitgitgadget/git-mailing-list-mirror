Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C2DDAE
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239048; cv=none; b=ZdPq70b4nRwplpJe2rml7Rn0espKx0kF3bFDUHFpJ3uNvMBCjQEN19wI6Ye+SoNRsZDzWq6T89xLKDY/4kq9HOcQsvYtHVtabG5NWcRJhPjzI3xwp6gd5oENLGuTytgGXIsU5d/P2MHYJyaGNxhGhtNE8IDzmBohzt5S5IC6MQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239048; c=relaxed/simple;
	bh=Sra3V7UPT72sH5D9JP2XOMebxRVg8XRNJWR9DuwBsfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ToGGCITa5L5GWDFIMKYcGxtDhayEYyYu9MfEqiNQIanZJlULsus2MJShcaPCliNMUvx56wf3RrN71GuvclicK0NooO88pgIyFub2wUm5jGusEIKKOsEQiP1Jb+sUb7iUC6qUFUZ74bl6NvvXkZoayvVtw08cOiwMwRKtMJ2SMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yWeOtYiS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yWeOtYiS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C47423953;
	Tue,  6 Feb 2024 12:04:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Sra3V7UPT72sH5D9JP2XOMebxRVg8XRNJWR9Du
	wBsfo=; b=yWeOtYiSFbdlt47Yc83dwqKgNCWOiOMmfgbWpsoQrX6Wy7or1Y6DaT
	ctq82+fhBOOD31Uku4Pi+/hhN/VQ0tZKN6TYHNg8B8fPOag2gUlo0xZtz2nQ8Zlz
	Z4kdI2pcLAJuVJx0TYL6VaWP/Wu5yhcdNMH1plUlOV0FOIJ6LP2qU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 841E323952;
	Tue,  6 Feb 2024 12:04:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2028323951;
	Tue,  6 Feb 2024 12:03:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com> (Phillip Wood's
	message of "Tue, 6 Feb 2024 13:55:02 +0000")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
	<20240129113527.607022-5-karthik.188@gmail.com>
	<98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
	<CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
	<92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
Date: Tue, 06 Feb 2024 09:03:55 -0800
Message-ID: <xmqqle7xjzic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B7100314-C511-11EE-8708-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks I'd missed that discussion. I see that at the end of that
> discussion Junio was concerned that the proposed "" did not account
> for "refs/worktrees/$worktree/*" [1] - how has that been resolved?

Ah, that is an excellent point.

If we plan to never allow showing refs/worktrees/ hierarchy, then
the "there is a default pattern, refs/, that gets used when there is
no user-specified patterns" model would be sufficient to allow
showing things that are directly beneath $GIT_DIR and are out of
refs/ hierarchy, but that does not explain why refs/worktrees/ is
omitted.  I'll envision a design for a longer term later, but an
easy way out would be to add --include-worktree-refs option for
that, and at that point, adding --include-root-refs option for things
outside the refs/ hierarchy may become a lot more natural solution.

In the longer term, I suspect that we would want something similar
to the negative refspec magic (e.g., "git log ':!Documentation/'"
that shows things outside the named hierarchy) exposed to the API[*],
so that we can say

    $ git for-each-ref --format=... \
	refs/ !refs/heads/ !refs/tags/ !refs/remotes/

to show things under refs/ excluding the commonly used hierarchies,
and at that point, the current behaviour for "no limit" case can
again become explainable as having "refs/ !refs/worktrees/" as the
default.  It still does not explain why "git for-each-ref refs/"
omits the refs/worktrees/ hierchy, unless the default limit pattern
rule were something like "unless you give a positive limit pattern
rule, then we use 'refs/' by default, and unless you give a negative
limit pattern rule, then we use '!refs/worktrees/' by default".

It then gives an easy explanation on the traditional behaviour, with
"" used for "including stuff outside refs/", and is more flexible.

The use of dashed-options to include hierachies that are by default
excluded (e.g. "--include-root-refs" and "--include-worktree-refs")
feels limiting, but should be sufficient for our needs, both current
(i.e. I want to see HEAD and FETCH_HEAD) and in the immediate future
(i.e. I want to see worktree refs from that worktree), and I can buy
that as a good alternative solution, at least in the shorter term.

I still worry that it may make introducing the negative ref patterns
harder, though.  How does --include-worktree-refs=another to include
the worktree refs from another worktree in refs/worktrees/another
interact with a negative pattern that was given from the command
line that overlaps with it?  Whatever interaction rules we define,
can we easily explain it in the documentation?

Just like "an empty string tells Git to include everything" is a
perfectly reasonable approach if we plan to never allow
refs/worktrees/ hierarchy, "dashed-options for selected hierarchies"
is a perfectly reasonable approach if we plan to never allow
negative limit patterns, I suspect.  We should stop complexity at
some point, and the decision to never support negative limit
patterns might be the place to draw that line.  I dunno.


[Footnote]

 * Such an exclusion mechanism already exists and are used to hide
   certain refs from being seen over the network by "git fetch" and
   friends.  I do not think it is plugged to the machinery used by
   for-each-ref and friends, but it smells like a reasonably easy
   thing to do.
