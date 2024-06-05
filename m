Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781119D880
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613165; cv=none; b=ioCEujXcro9dBz5l/59J85H+/UZ4xkqFFJATdGSGyNcP+/sF8yIcaJHOZE16urp6DcUXq3udY64JAB6B76+Ui5MXEf3lS/ilgGYgkQN0zLJg5nVLJTbexxOQEWB+QxaPARjWIcfoI1NSxqz6GnE++Ef32e35ABbo7QHaTFDw3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613165; c=relaxed/simple;
	bh=0L5cyEb46j5IzJ2a7tiPVQ6tvywQl2NBtNAA/YJa8pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roIo9YPB1RVXAwSHe5PKfMuuDYQGr3HWAOdgX2bLvzNh7HTWIEhxLot350lxDAtOet1tIIBFnsaERQJZEzXmEmumS45TTzmcUIi2JS+qX9nWFat1uzL8n44I+FYSFkjCXQAJRNa9d8Xjei2dPtqyTo3kPXk6gFcIEVNMnnO5pjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKnOFnjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKnOFnjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6757AC2BD11;
	Wed,  5 Jun 2024 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717613164;
	bh=0L5cyEb46j5IzJ2a7tiPVQ6tvywQl2NBtNAA/YJa8pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKnOFnjE4QGauTrJAX+56eX78+mV4R33jGoxWFcVTX50u+APksqM1fi4e/q2MGQAF
	 r7magfKR8D4AQzs938j7ZX25Wo3fwj3SzO3cYXV3T8iRUw2s5sw0Bvjel+QxDRLAUR
	 Gy5QZN7j1j3q6ceqJ/qR5RuR0rXU9ypEdlufD8Vk=
Date: Wed, 5 Jun 2024 14:46:01 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: RFC: indicating diff strategy in format-patch message headers
Message-ID: <20240605-zippy-wildcat-of-recreation-8c644e@lemur>
References: <20240605-hilarious-dramatic-mushroom-7fd941@lemur>
 <xmqq5xuns10v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xuns10v.fsf@gitster.g>

On Wed, Jun 05, 2024 at 11:22:08AM GMT, Junio C Hamano wrote:
> > Would it make sense to have git-format-patch (and friends) include an
> > additional header hinting at the options used to generate the patch? E.g.:
> >
> >     X-git-diff-options: algo=myers; context=3;
> 
> I doubt it.  And newer version of Git _will_ try to improve how
> patch text appears to be more useful to human users, so you have
> more moving parts than you'd want to even think about enumerating.

OK, I was afraid that was the case.

> If you were to add a new e-mail header, wouldn't it make more sense
> to add a patch-id header and agree on the set of options to be used
> to generate that patch-id (which might be different from the setting
> used to format the real patch for human and "git am" consumption)?

That would be redundant with the message-id. Unfortunately, this doesn't solve
the problem of how to reliably map a commit to the patch from which it
originated, other than using the Message-ID: or Link: trailers.

I'm always happy to see a Link: trailer pointing at the patch submission,
e.g.:

    | Link: https://msgid.link/[msgid]

However, not all maintainers welcome them in commits (e.g. Linus was vocal
about it in the past [1]). It could be the case of "use them anyway," but
we'll still have a large enough subset of commits without this info and
increasingly without a reliable mechanism to map commits to original
submissions and code review systems.

I'm not sure if there's a reliable way to solve this.

-K

[1]: https://lore.kernel.org/lkml/CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com/
