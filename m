Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A54C6F
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709771482; cv=none; b=Vyv3kWdf06zyvgNGOEzmjUMngeMVhDj6whuz6BSHjucPx2UgDOELLV0AscF3ITX7pktMamZ22nnxESI1S3uJbIK+FPrnZFTGDt5n2ftMCKPdUyk6xRaDZlk6uyOTA6uc1uIxGM9EJh4jYwdM7ShlQ8dKGgHXC1xw4yFc7qtGocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709771482; c=relaxed/simple;
	bh=47gh3vUW/29bO3NZ8I1m7+3lHtPCep/8sGwBfh65nhQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YCR+bOpfsMjg6TFESbHQzZS9E9Y4LMPY3fmJZY+eLPqL/B6u0tUqHOAYPBK+yLxu09sTvfas0YTt+Sk44kStToFmBA6V1i/diAsZypjgP7kXDrKXsjzqxX/MNUywoJbs0Gpevq96hhMItQwJeUj0G3vt6e4zPGiOOgY2Wx7KPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rCHfCp2u; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rCHfCp2u"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709771471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPgLqSpndPa/Uqg6iKaHTKUrkXM4i1j5jCRy/axc/y0=;
	b=rCHfCp2uUTR4zHEY361XUVxC+Elut7zsj0Ss4E7MyUQZadZ/TPzA8TvLfQTl/2Kb9Xleht
	9OnsrMOmabqSHL71dv/HS6aQ1njRkygNOmhf3JekZq3BD4c6IkNsAOAHbPHC96L/5arKSi
	cNN1soQZjDyOMK9usJg1wFaErz5YhyFt982oKF94s4PnzUKdPTc0fzH7iFrHbBcKAXPe5h
	DGCi/3lGpAS/3RIiVkME4LYovQrc0qa8HaU027TZbI5MV0bi/TR+LIzj7NpuOZIWnw0qju
	iAKUIGSBu6UkmOO0gC5XLUwnvK8QQ8NdDKu3QWkrZL1O2Bmg3ziCugcbV/iGnw==
Date: Thu, 07 Mar 2024 01:31:09 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
In-Reply-To: <ZekAWSqr9qb8FIAD@nand.local>
References: <cover.1709724089.git.ps@pks.im> <xmqqil1zs327.fsf@gitster.g>
 <ZekAWSqr9qb8FIAD@nand.local>
Message-ID: <d3ccbb84bf3b6074d25668b2d0cd1b94@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-03-07 00:46, Taylor Blau wrote:
> On Wed, Mar 06, 2024 at 09:06:08AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> >   - `git config foo.bar` -> `git config get foo.bar`
>> >
>> >   - `git config foo.bar value` -> `git config set foo.bar value`
>> 
>> I actually have been perfectly OK with the above two, but I agree
>> that ...
> 
> Same here, though I think that we are probably both biased by many 
> years
> of familiarity with the existing syntax.

Ditto.  Though, having "get" and "set" commands will be nice, making it
all more self descriptive.

>> >   - `git config foo.bar value value-pattern` -> `git config set-all
>> >     foo.bar value value-pattern`
>> 
>> ... this was less than discoverable, and would be a good update.
>> This one ...
> 
> Agreed.

Also agreed.  Having the point below in mind, perhaps we could actually
end up with "set --all" instead of "set-all".

>> >   - `git config --get-urlmatch` -> `git config get-urlmatch`.
>> 
>> ... is a Meh to me, personally.  I'd not actively push it
>> enthusiastically, but I'd passively accept its existence.
> 
> I don't have strong feelings about this, but I wonder if `--urlmatch`
> (or `--url-match`) might be an argument to the "get" mode of this
> sub-command instead. Something like `git config get --urlmatch` feels
> much more natural to me than `git config get-urlmatch`.

Good point.  I'd vote for having "get --urlmatch" or "get --url-match",
because it feels more natural to me, it doesn't "clog up" the command
space, and such an approach, in general, allows git-config(1) to be
expanded later easier with more new arguments for the existing commands.
