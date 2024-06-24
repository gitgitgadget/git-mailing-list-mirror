Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F4FBEF
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214418; cv=none; b=rmPhJyNLQLDj9wlB2jNIFNMyISFQBkyWWq173jHwMnAqc+bO/e7dRlriIIX24MmZPHijPAWq7zok6eId7N9Mv9eF48D3gWfd44XYkE8lMkLm7OEQF7Ja1lQt78WJaM3cvrx9L5iM7P9h9Zy+BaDvr3E7BbMGZZpIhv2Zg+umeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214418; c=relaxed/simple;
	bh=r3nm1FOkNIaheBBeUNDy/S/M0Oa7YGBVw3Kqyax28Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grBQVkyoVw3pmcOaZTPDTZOvNYkBMR/wtmmJgjMbLgRKvqq1In/CC7w5T38fMjKay1NNh5uu/PMvxLfBRvdaC4+OhK1/gyJrArnDTAR/fcm9kIutp76k7r2/bBViy6MH4YsL93OpDLN+ZFcyXbR7kM13XdHyNMKj+Mpe1E+MzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=BIt/lje5; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="BIt/lje5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1719214405;
	bh=n/SWwLJVACQAFKvUd9SeuQnGKuy0TPWFs02/wdPMrG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BIt/lje5Tzw4UE2HS5YTofSQMz8fadh7IL9pOHZl5kOYbWnLlcivRwAuBE3v39EiN
	 ReHq9bKf0yeBmT00G0prco5BkmHhpR4kh+2KX9vjQDrLE8hD2jl+w/B7TcLQPNoKmH
	 fAchYuPIXjdvLUy1hsFvCHnxr7m+341A8Vu4yyMvOnLB58T2SvzR/L/KQKYBeXWBm4
	 HFmCIqOSYEbTgN6J36D94rJ1zeowNsFJwk/UmoeO0dkkn0jqV83o/2EYma8wGuWxin
	 qflpO2+fUq5T5TmGCtVj5agdiTf1WEGLyL31xxqb4nyz/BRUGWKQXqtA1AsH0+JS78
	 x2uiSFCj+Vf1Q==
Received: from [192.168.42.22] (i5C74DC1D.versanet.de [92.116.220.29])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 470773C0F38;
	Mon, 24 Jun 2024 09:33:25 +0200 (CEST)
Message-ID: <0a948acf-ebe9-407e-8899-d714b6fcb528@haller-berlin.de>
Date: Mon, 24 Jun 2024 09:33:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thoughts about the -m option of cherry-pick and revert
Content-Language: de-DE, en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Git <git@vger.kernel.org>
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
 <xmqqa5jfoxvh.fsf@gitster.g>
 <dd58a60d-a551-4726-85a7-f47b851914be@haller-berlin.de>
 <6e71b1f3-599f-49c3-be37-e499f28983cf@gmail.com> <xmqqv822ntkh.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqv822ntkh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 21.06.24 18:34, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I can see why people want to revert merges but cherry-picking them
>> always feels strange to me - what is the advantage over actually
>> merging the branch and seeing the full history of that commit?
> 
> One case that comes to my mind is when you failed to plan ahead and
> used a wrong base when building a series to "fix" an old bug.  You
> built a 7-patch series to fix a bug that you introduced in release
> 1.0, but instead of basing the fix on maint-1.0 maintenance track,
> you forked from the tip of master that is preparing for your next
> feature release that is release 1.4.
> 
> Even if you realized that the fix is important enough to warrant
> applying to the maint-1.0 maintenance track, you cannot merge the
> topic that houses 7-patch series down to the old maintenance track
> without bringing all the new features that happened since 1.0 on the
> master track.
> 
> A kosher way may be to rebase the 7-patch series to maint-1.0 and
> merge the result into the maint-1.0 track (and upwards if needed).
> But cherry-picking the commit that merged the original "fix" topic
> into master _may_ be simpler, as you need to resolve a larger
> conflict but (hopefully) only once, instead of up to 7 times, once
> per each commit on the "fix" topic while rebasing.
> 
> But of course if something goes wrong, it makes the result
> impossible to bisect---exactly the same reason why you should think
> twice before doing a "merge --squash".  In addition, if you somehow
> figured out why the cherry-picked fix was inadequate, you'd now need
> to forward-port the fix for the fix to the master track or whereever
> the cherry-picked-merge was taken from.
> 
> On the other hand, if the original "fix" branch was rebased on
> maint-1.0 and then further fixed, the result can be merged to
> maint-1.0 as well as all the way to the master track.
> 
> So, I can understand why people may want to cherry-pick a merge,
> I suspect it is a false economy.  Optimizing for picking, paying
> higher price when the result of (incorrect) picking has to be
> corrected later.

You may call this "failed to plan ahead", but for us it's a deliberate
decision to work this way. Developers work exclusively on main, and
merge their branches to main, always. Release management decides later
(sometimes much later) which of these branches are cherry-picked to
which release branches. We never merge back from a release branch to main.

And we prefer single-commit cherry-picks of the merge commits because it
makes the history of the release branches easier to read. Bisectability
is not an issue; developers bisect failures on the main branch. (Yes,
I'm aware that there may be cases where a defect manifests itself
differently (or not at all) on main than on the release branch, but
these are so rare that it hasn't been an issue for us so far.)

I'm not saying I'm very happy with this workflow, it wasn't my decision.
And in particular I'm not trying to argue which workflow is better than
the other; all I'm saying is that there are teams who decide they want
to cherry-pick merge commits, so git should continue to allow it. This
is only in response to your earlier "If I were simplifying this, I would
probably [...] disallow cherry-picking a merge".

(Side note: my main gripe about cherry-picking in general is, of course,
that it makes it impossible to use "git branch --contains" or "git tag
--contains" to find out which releases contain a given bug fix; but
that's a problem no matter whether you cherry-pick the merge commit, or
replay the branch on maint and merge it there again.)

-Stefan
