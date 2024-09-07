Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C454F20C
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725735110; cv=none; b=CljVCJcZ0FqzAZsTizqiGCNuX+kYwfxPb2PQ9+d3Vz04e8wlvJE06D54AzY2GHI4XFUCXhVvG3EKg1C5j1nL75GAsuvrJeUjW2R9c+FAuJbhg/1JrpMwmLNBtjwNQL7hCcizHE/y6TyaOu0gZGGQJdPcctcMRtIbFQiid+icAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725735110; c=relaxed/simple;
	bh=RCaO8Mnry0UsrEr7mdvK8vv5nbbf7k/PYFikv0vWbUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpRUsOfcQA61xZGZyBZoJ5X7yphQ2Wr8g8dMp54gHng2ty3ox7lO3gYbu+TgZZIs24cJXpqUEUwy8qfRgZ9Ji+9cfMv6s7wnRTjpmSVi4ORhFwZs5OwLSRcoryK14qPvaqhW+xTuedRSsJ9rmfm99Eb+bv/0ntHH4PvZu4auxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=and5Z2vD; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="and5Z2vD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202408171023; t=1725735103;
	bh=y9f61HmLNz3HWq91cFzES2qrIEXMfH2pp30MCsh8Gjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=and5Z2vDFeyDT+Ds32W0Jw8DM/ildupnu//txj1KZsMC5VOjNgCD0q0ag4+Xbs2J+
	 avgNxJlvsM11RTokSUq6+KIcYwUG/JniIj0l162Rw9VBwisf86zMt1mE3UReubeash
	 yAbZeJsW4eqRU+eIkaNogwkT6ggmlA9ofdHD5j/ku72TehAwJA62KF4OMVlRJoyur8
	 ZX8smpPG4MaotDonYqh+n2sB0lPcDPnXJzeUiL9zZK579pnxL9rBEriV2VA8bKFnmZ
	 AorELUIEgqeiXMPlFeHTaajdw/3RnqHzNQyV208inpoCw3xJnuR5hWvhzEWUlY3zut
	 958edvsZhXnQg==
Received: from [192.168.42.22] (236-98-142-46.pool.kielnet.net [46.142.98.236])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 9AE733C049C;
	Sat,  7 Sep 2024 20:51:43 +0200 (CEST)
Message-ID: <d97a69bc-85f0-46e3-8c99-0e5556ffdc9a@haller-berlin.de>
Date: Sat, 7 Sep 2024 20:51:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thoughts on the "branch <b> is not fully merged" error of
 "git-branch -d"
Content-Language: de-DE, en-US
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <bf6308ce-3914-4b85-a04b-4a9716bac538@haller-berlin.de>
 <xmqqy143wgao.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqy143wgao.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 07.09.24 18:59, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> I frequently get this error when trying to delete a branch that was
>> merged on github, and the remote branch was deleted through github's UI too.
>>
>> When I then fetch and see that "git branch -v" shows it as "[gone]"), I
>> will want to delete it, but at that time it is pretty random which
>> branch I happen to have checked out. If it's some other unrelated branch
>> that I didn't rebase onto origin/main yet, or if it is main but I didn't
>> pull yet, then I get the error; but if I'm on main and I have pulled, or
>> I'm on an unrelated branch and I have rebased onto origin/main, then I
>> don't.
>>
>> This feels arbitrary to me. It would seem more useful to me if the error
>> only appeared if the branch is not contained in any of my local or
>> remote branches, because only then do I lose commits. Any thoughts on that?
> 
> I think we check against the @{upstream} as well as HEAD these days.

Yes I know, but in the example I gave, upstream is already gone (maybe I
should have added that I have fetch.prune set to true, that's why).

> Having said all that, I do not mind if somebody wanted to further
> extend builtin/branch.c:branch_merged() so that users can explicitly
> configure a set of reference branches.  "The 'master' and 'maint'
> are the integration branches that are used in this repository.
> Unless the history of a local branch is fully merged to one of
> these, 'git branch -d' of such a local branch will stop." may be a
> reasonable thing to do.

This makes sense to me (if you include the upstreams of master and maint
in that logic, because the local ones might not be up to date).

I should have added that I'm looking at all this from the perspective of
lazygit, again. Currently, lazygit tries "git branch -d" first, and if
that errors (yes, it parses the error output, gasp), it prompts the user
and then uses "git branch -D" if they said yes. Since lazygit already
has a config for what the main branches are, I'll probably change this
logic to do the check on our side, prompt the user if necessary, and use
-D right away.

Thanks for the input!

-Stefan
