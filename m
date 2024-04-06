Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807E1772F
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712393773; cv=none; b=dqJ+WoxU1+IylT2NePspJ81wMaELO5nO5ucc+VZoxoKjkiLxVJPJIMhKxSRLSrKCiBoZWxzApAoR0yrbJD0lAtaEWOo/mggB0Bzbi5klotPKEkO4d2nKPxagMf36TBqhKBVB7ZXxk5hj4nShDXS7OyRcUlgGV2TSoExNdq88tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712393773; c=relaxed/simple;
	bh=nROJKlK+v5Wi1vvyu60umx1lXmehynSwcYaiwk28DXs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ux6bV5/vJLJBgPoTP+l5JFcgQnDOjGMv3YlMdLLSqc/Dv93SrL5Q4OQO008exOCBSlCXn6zuSS8LQmLEeE+0Kaj7EeInVBDJaR3CSgOUGwSStKOv8xb4F0HZIZGTOd3NjNns8h4J9HMV3BoSUuj4sA2U2TGID+xTBS81ttTcqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KcSvI2au; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KcSvI2au"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712393768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UhWLcxaMYSoOHl/7dImzap9fhdut/UvFL8CCW2FBoE=;
	b=KcSvI2audh6z1yHPL6cjWBpIdh4gGVqrtOqMYiCZ9wy+fRavj0pys7v6kwQR8DXKejXL/9
	dxlbTjSsxwkCgaY4hTnRIKkxbp7x3pyHjCisSyexGB6+W7SB1pBZRnMCUJNQCwC/0zZ2cL
	Vz7GV3eRV4Sm4a7b94oVWEpNVt+K5vrdKPbYXBigAHXsOY65tYNMBT7fPB5cTENmOYwdYS
	7VVvTY0b5XqBs8emLGWF0blyrXTTL2X5BFtNKC7PzbypUwGMnPixhm4V/XdSPXZlxsJODe
	g8+eGssAnlHt8xFLfCT+GEceBgNb9SlKEU6xaNH05YRByofvbeJNUhtH9UUkPg==
Date: Sat, 06 Apr 2024 10:56:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v4] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqqwmpbm4lp.fsf@gitster.g>
References: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
 <xmqqwmpbm4lp.fsf@gitster.g>
Message-ID: <e90f6c80be33b2b54e20992f19e417dc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-06 07:40, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Following the approach of making the produced output more readable, 
>> also
>> emit additional vertical whitespace after the "Send this email 
>> [y/n/...]?"
>> prompt.
> 
> Hmph.  I'd prefer to see you try not to endlessly extend the scope
> of a topic.
> 
> By including the above change, the patch no longer is small and
> focused enough, which was the reason why we said that the "let's
> move the final newline out of the translatable string" can be done
> as a "while at it" change.
> 
> Besides, because of the switch to separator semantics, that hunk
> lost the reason to exist as part of the "use a blank line between
> output for each message"---the change no longer is needed to support
> the feature.
> 
> Even though it is a good change to have, and it deserves to be
> justified by its merit alone.
> 
> The whole thing deserves to be a three-patch series, the first one
> being a preliminarly "let's move the final newline out of the
> translatable string" step, followed by "let's have a gap between
> output for each patch sent out".  Perhaps another "even during
> sending a single patch, we may want extra blank lines when use of
> editor and other user interation is involved" patch on top.
> 
> I haven't formed an opinion on that last step, and I do not think I
> can spend any time to think about that new part of the feature for
> some time (others can review that part and give their opinion on it,
> of course, while I'll be working on other topics).  It would mean
> you are adding yet another feature to delay the base improvement to
> stabilize.  You really do not want to do that.

Quite frankly, I think all these changes are small enough and
understandable enough to be fine for being squashed into a single
patch.  See, I love perfection and I'm also kind of a perfectionist,
but such an approach can sometimes actually become counterproductive.
That's what I usually refer to as being pragmatic, in the sense of
making things a bit less perfect but still fine, in the interest
of "getting things done", so to speak.  I hope it makes sense.

However, if you insist I'm also perfectly fine with splitting this
patch into a three-patch series.  That would make it perfect, there's
no doubt about it, but would it be a pragmatic approach, worth the
additional time and effort?  Perhaps not.

> In any case, this [v4], as a single ball of wax, is not something I
> can confidently say "I reviewed this and looks OK".
