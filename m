Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29BA31
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725773614; cv=none; b=QeRBmR3r7/mbD9LtOSR9db/bUoGgZMOMerGGv1A2e6Ttw/XIoqq53VKnGDnNqLY9jZMR6J0x+H27O2imOICz+ppp6jHMxVXFbjSuBDn6gOylLoZqqgquCSs6P5+AiEdhxpicu1Iz0q2zHK5qVIa1o1F+2O90QtntBO2B9z9M8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725773614; c=relaxed/simple;
	bh=I2yc7qayAcncQHAHroQ/93WJ8KJjz+mNSpe40jeb0Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvFx5orTpYX8bUxC1Ad+Y9xATwjoFV78Bcht4Zin8WPak5UNTdxrqZTqCgDj4fSZUHlLWP4zVHt1vmqIR1Ry8divFUN1J+IgY3xq5KDCRoHn6E9AwYXif6k1V4WqpmtQo4rT5jKPfcHLtby7P5a/aFrddyIsskpwKBkaMs0sdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=FVP6LwjU; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="FVP6LwjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202408171023; t=1725773607;
	bh=nsCEh0RfQ2ueUaQR4yd8+jscHzDPdyb9s/gfcxVqJc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVP6LwjUp6CW4HQF9daf99FkVqw9TpDUlcmkC8mkj8Eyg+WZ/V81Bb9yU9UPSIm4G
	 qgCZz3kuL9jHTIH1ofii6ZOvroJQ8eGTT8zEhi560dPuHRcQ7RALRhb8+0iMQOsrcI
	 lzYBgJRf9nTPSyT7hU4hq9meIL1apMfb6Y/RFXCX5e0CfjfQD/uBduiLbhkRK+ywrn
	 dJf45iusEohwhrYJkoxSgmpbTnXbRqQutF2+Exp+jzQB1/6MUo4nDdlmMMOF+qqYWc
	 V2MbCjG8SLdmgx7Hw1J0svZFqjKiBuydL3rBA+Iv6+0/MiaW5G/o1TvtunCoT2j/gI
	 IF67ZMSF9Ge0A==
Received: from [192.168.42.22] (42-96-142-46.pool.kielnet.net [46.142.96.42])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 3563A3C0306;
	Sun,  8 Sep 2024 07:33:27 +0200 (CEST)
Message-ID: <a2bdec84-541a-490b-9456-e99adf400b1c@haller-berlin.de>
Date: Sun, 8 Sep 2024 07:33:26 +0200
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
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <bf6308ce-3914-4b85-a04b-4a9716bac538@haller-berlin.de>
 <xmqqy143wgao.fsf@gitster.g>
 <d97a69bc-85f0-46e3-8c99-0e5556ffdc9a@haller-berlin.de>
 <xmqqmskjw7wr.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqmskjw7wr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 07.09.24 22:00, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>>> Having said all that, I do not mind if somebody wanted to further
>>> extend builtin/branch.c:branch_merged() so that users can explicitly
>>> configure a set of reference branches.  "The 'master' and 'maint'
>>> are the integration branches that are used in this repository.
>>> Unless the history of a local branch is fully merged to one of
>>> these, 'git branch -d' of such a local branch will stop." may be a
>>> reasonable thing to do.
>>
>> This makes sense to me (if you include the upstreams of master and maint
>> in that logic, because the local ones might not be up to date).
> 
> I get the idea behind that statement, but I do not think it is
> necessary to make Git second guess the end user is warranted in this
> case.
> 
> If refs/heads/master builds on top of refs/remotes/origin/master,
> and if the user is worried about the former being not up to date
> relative to the latter, then the user can say "'branch -d' is safe
> if the commit is merged in refs/remotes/origin/master", instead of
> telling the command to check with 'refs/heads/master'.

Ah sure, if that configuration takes full refs, then yes, let the user
configure exactly what they want. I thought it would take just bare
branch names. (That's what we do in lazygit, we find this more
convenient. It does take some heuristics to see which of these actually
exist, and whether to use the upstream or local one, but it makes it
easier for users. I'm not proposing to go this way with git.)

-Stefan
