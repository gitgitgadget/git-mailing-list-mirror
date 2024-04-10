Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8915DBB7
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776958; cv=none; b=RG9cEYeQ28/32nZC5G9IZ1ZK7LikL5aLO0iMQNSO85OMYVCItbzT2PG9qxWt+beQPFv9xMcsc9yEWQmKzB5WYpGUokQ7zPFt2IDobNVf/vbDsGDZepUAJXQKJgLlOWOLGIFj0wKPIteifj/aHnBiEQ4OwTRZM16uDDe9XP1YpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776958; c=relaxed/simple;
	bh=fF2YE0ZXJ6r1BzadAhX9ablC5nI5Dohs5OVmUGYzLdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOsdP/sftga6Q6mOTTQm11yp+syNU1f9zo8aUi8nTlDwo97LTg7SgbyBiesP/MvtleolmRGImL9pnYoy1zyvNYNp5qvAcu5Qy2kB18DGzTVKG3XbxJ0tAIi7bBj6HxmUiF1AhEWKg0fUgGBuXyDFPnGtBleyUZQlC5fC4cp/hTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=lq6kfFqA; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="lq6kfFqA"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id F11621A1F5AB;
	Wed, 10 Apr 2024 21:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712776952; bh=fF2YE0ZXJ6r1BzadAhX9ablC5nI5Dohs5OVmUGYzLdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lq6kfFqAo/xLgWxcBtdEUZDXXjy5pBm8uhf0F/csMb/87nMFHC53tOfU64LNEWJPt
	 SFgzTx8gkKvsdmvTUuq6xOhGZlNsV5re5RSo5JJFECRtInu7kk/qA8akjn9edjR3m4
	 cavNr/75mOkEwtPWPcWPnW4KnPKY6oXx/aEIiUbY=
Message-ID: <bb0dc4a7-e598-45f5-b707-e22de0890f26@schinagl.nl>
Date: Wed, 10 Apr 2024 21:22:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
 <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
 <d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
 <2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
 <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com> <xmqqzfu3dcl1.fsf@gitster.g>
 <116dd27e-2e30-4915-a131-6c71c999fccd@schinagl.nl>
 <xmqqzfu1upty.fsf@gitster.g>
Content-Language: nl, en-US
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqzfu1upty.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10-04-2024 18:47, Junio C Hamano wrote:
> Olliver Schinagl <oliver@schinagl.nl> writes:
> 
>> While completly orthonogal, I agree; it would be nice to have and
>> 'abuse' for the bisect-skip usecase. So if we ignore the fact that it
>> can be abused for this (which I don't think is a bad thing, it just
>> risks the recursive issue Phillip mentioned.
> 
> I do not see the "recursive" issue here, though.  If we had such a
> mechansim, those whose test cannot be driven by "bisect run" can
> still use the "--post-checkout" and "--pre-resume" options, where
> the post-checkout option names a file that has:
> 
> 	#!/bin/sh
>          if git merge-base --is-ancestor $the_other_bug HEAD
>          then
>            # we need the fix
>            git cherry-pick --no-commit $fix_for_the_other_bug ||
>            exit 125
>          fi
> 
> in it.  There is no "recursive"-ness here.  And then after manually
> testing the checked out stuff (with tweak, thanks to the post-checkout
> script), they can now say "git bisect good/bad/skip" and that is
> when their --pre-resume script kicks in, which may do
> 
> 	#!/bin/sh
> 	git reset --hard ;# undo the damage done by post-checkout
> 
> before the bisect machinery goes and picks the next commit to test.

Yep, that was all perfectly clear to me :) Though I do admit, I 
initially overlooked the 'not' in your comment on 'those whose test 
can**not** be driven by "bisect run"' bit.

> 
> Notice that I still kept the "exit 125" in the above post-checkout
> example?  That is where the "bisect next" that picked the commit to
> test, checked out that commit and updated the working tree, and run
> your post-checkout script, can be told that the version checked out
> is untestable and to be skipped.

This is where things got stuck for me. I had the 'exit 125' bit for a 
while, but couldn't figure out 'how to mark' stuff. Right now, it just 
calls the script, and if you are a bad user, you can call `git bisect 
skip` and things work as expected, albeit with the aforementioned recursion.

In the past, as I reported here as well, I tried to capture exit 125, 
the above would still be true of course, but exit 125 would be a way to 
'catch' this and respond accordingly. The 'accordingly' is where I get 
stuck.

See, the hook is named 'post-checkout' and thus, it runs after checkout 
has been performed. So we are now on the 'broken' commit we do not want 
to test, git should have skipped this already, and not checked it out.

So ok fine, we can call it 'pre-checkout'. But then what. I experimented 
with marking the skippyness just after `find_bisection()` here: 
https://gitlab.com/olliver/git/-/blob/post_search/bisect.c?ref_type=heads#L1090

with a simple
	strbuf_addf(&skip, "refs/bisect/skip-%s", oid_to_hex(oid));
	oid_array_append(&skipped_revs, &oid);

While this kinda worked, it failed when two (or more) commits in order 
where to be skipped and 'finished' with 'no possible commits to check'

So I kinda gave up here and went back to post-checkout.

> So such a post-checkout script can
> be treated as a strict superset of --skip-when script we have been
> discussing.
> 
> Needless to say, if we were to do this, we probably should let
> "bisect run" also pay attention to these two scripts.  They are most
> likely to become new parameters specified when "bisect start" is run
> to be recorded as one of the many states "git bisect" creates.

The way I've done it now is that it's called from `bisect_next()` here 
https://gitlab.com/olliver/git/-/commit/20dd6f5f0e2a55f940bab1e3aced0686d8dfd0c5#46324e17f99db64a67eb9a5983ffc3a680914ee3_672_717 
but as I said, checkout has already commenced. Doing it here seems to 
work with bisect run as well. Resume is done in `bisect_state()` here 
https://gitlab.com/olliver/git/-/commit/f9b14a66ea5c4c98f48236db119d3eb60427c1bd#46324e17f99db64a67eb9a5983ffc3a680914ee3_1001_1028 
which also happens in the run case.


The whole exit 125 and avoid recursion thing, is to me more like an 
additional 'nice-to-have' feature. Recursion wouldn't be a huge thing 
for modern systems generally anyway in the 'normal/common' case where 
you recurse 10-ish times. It'll of course get worse if there's multiple 
commits that would need to be skipped. So even if the recursion is 
20-ish, it's ugly, but not horrible.

In any case, if the recursion thing is considered bad and must be solved 
if a user does this, as I said before it's not clear to me how to 
trigger git to say 'oh, I have to go back and do something else; or, 
call git bisect skip internally, without causing the recursion; or 'put 
the commit in the queue to be skipped, before it's checked out (which of 
course is not a 'post-checkout' of course.
