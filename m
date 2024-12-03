Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CB2905
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197331; cv=none; b=dCOkM4wGtHd3x25e7dNkeh17NKSbG4Ko/VJPjtviu+4qepiBYuUp+0fLA4zIF9fQKdviWjfPjIfgjk9cHeTq2HDs87mypGuAj0TVnaH43tk4DsY0sxDyNzcz1ddzcQ5gt7hZtB8AM5XKcjzmLWumI2pL7dF4r2hUber5iDFcQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197331; c=relaxed/simple;
	bh=MGwLSgdLbpNeHRSUdWr6ic9GoUedZC3drV02ksEhbdI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpzlT78h+0cjBiOFv31AtbT7mU9WXxbizgsL1Q0K47HTgzvY0zx5mQNJUY9UOa7MDiNORr3kCt8ZTR/zJxacb2fgR1DK97xqEZBxeGuedJcG1UDtY/4IGU+brFbIbQNt8JiO6LHDDXjQDT1Ubopw4GzD4sMasuyceEGhKSxUIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=azWRv7LP; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="azWRv7LP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1733197326; x=1733456526;
	bh=Cmf1MzIY9f3AI8tYnE9J16oS2mCxXjVDjtEETp4CUEo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=azWRv7LPqATTCqRnMh4YhINlBML63RCJd+seV3g2dfYCFLK3QJvaiHxvIMwTxH9yJ
	 EapFBtA2AJoMQirfXmxOA1lvP9UUVNKXI+TDdziok5b72stIKyzLz2LLiqRyYj+6hN
	 ip0yBp9SD1w/jPO7f76fG7z9rRkC/rGFosFRqSl8V1AvwR1aG9jiVAULnjmWpMrxwT
	 qPUmZLYGvoAzxxDoUwfHObdguWHQxMEDFrTmECYBijmVGkRT2zNoBpPO6b0bAdToy1
	 +/1eyhkcvv21sATpf0l7kAJ/7VC+eFCwofICDI70GuvUnEtgQqKWskyykhcbwU0CPw
	 6wfvgrgthXDtA==
Date: Tue, 03 Dec 2024 03:42:02 +0000
To: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com
From: Caleb White <cdwhite3@pm.me>
Cc: 'Eric Sunshine' <sunshine@sunshineco.com>, 'shejialuo' <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <D61R68MFWDIU.12PI8AA8S3G86@pm.me>
In-Reply-To: <xmqqiks1fqgl.fsf@gitster.g>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux> <xmqqed2pioff.fsf@gitster.g> <CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com> <xmqqo71tfsif.fsf@gitster.g> <025b01db4526$3b05ef00$b111cd00$@nexbridge.com> <xmqqiks1fqgl.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 1ac256351f5f5a65e9520741e4e1f148d6a989f2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Dec 2, 2024 at 8:30 PM CST, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
>
>>>Ah, yes, that exposes (and has to expose) the worktree ID.  It still doe=
s
>> not have to
>>>be unique across repositories (only has to unique among the worktrees th=
at
>> share
>>>the same single repository).
>>
>> I might be mistaken, but I think the intent of the worktree series being
>> discussed
>> deliberately wanted the worktree ID to be globally unique on a specific
>> machine.
>
> That is my understanding, but I do not understand why such a
> uniqueness is needed.  Repositories are not even aware of other
> repositories, in any sense to make it matter to know worktree IDs
> other repositories are using.  Until there is an attempt to link a
> worktree that used to belong to a repository to a different
> repository, that is.  At that time, names must be made unique among
> worktrees that belong to the adopting repository, of course, but the
> names used in the original repository for its worktrees would not
> matter at that point, I would think.

Perhaps I should've have come up with a better series name, I think
there's been a lot of hang-up with the term "unique". When I refer to
uniqueness in this context, I'm not advocating for strict, absolute
uniqueness in the sense of ensuring no collisions under any conceivable
circumstance, or requiring that repositories are now aware of other
repositories. Instead, I'm discussing uniqueness from a practical
perspective: the combination of a random 32-bit integer from a CSPRNG
with a worktree name should be "unique" for all intents and purposes.
The theoretical risk of a collision does exist, of course, but the
probability is astronomically lower than the current approach, rendering
it effectively "unique" in practice.

You're correct in that the worktree ids are only relevant within the
context of a single repository. However, I've already demonstrated that
it's possible for a repository to "repair" (i.e., take over) a worktree
belonging to another repository if the ids match (inferred backlink).
In my experience, there's some pretty common names for worktrees (e.g.,
"main", "master", "develop", "hotfix", etc.), and it's not uncommon for
multiple repositories to have worktrees with the same name. This can be
avoided entirely by introducing some randomness into the worktree id and
significantly reducing the probability of a collision (e.g., one
repository would have a `develop-54678976` id while another would have
a `develop-987465246` id), which is the primary motivation behind this
series.

As I've mentioned earlier, the concept of a suffix is not new and should
not be a breaking change. It's already possible to have worktrees with
a different id from the public worktree directory name, so users and
scripts should not just assume them to be the same (this is buggy
behavior), but instead should be querying the worktree id from the `.git`
file or `git rev-parse --git-dir` if they really need it (very rare).
As part of this series I did add the worktree id to the `worktree list`
output to make it easier for scripts to query this information if they
do need it.

Perhaps this "take-over" scenario is not that big of a concern in
practice, I just noted that this behavior was made possible in the
`es/worktree-repair-copied` topic and I thought it was worth addressing.
If it's decided that this is not that big of a concern, then I suppose
this series can be dropped (although I've made some other QoL
improvements that may be useful).

Best,

Caleb

