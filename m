Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509431F922
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529992; cv=none; b=pj0rk0VEiSjtR6ZvQJGX94Qsa+h4OsEAsrLH6olYPRhdr/UQOdpSw5H8E5Ons5ALT+rPOA0dFNRFyDaZ0udQvQydHFkyX5B7lAdVtiXe48v6RcnBCUI1oAMu6pNpPBRng7riN4LOw2FXLUOQikf+kVHuYgjX5n438L7XrEuDYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529992; c=relaxed/simple;
	bh=pLMKeqPUybI9TLMdE8maISja8ulQ4DSpFdH9ITU1NQI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HkITD0vLvSTz1OLsGaS9Dg/c91zk4h6jkXC6WJMvKS8kWPVyvTv01WERyNvPL5FD+Bu7uCkzSgcvVHOo4Nx4EFiF+1TSn6BUOtbdc/G3vCeOjLwo99iNOF3CohxB/J59BCxbRI5IPqyXZd+xZgRvsxbekIk+jHoCes2QfR56MlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BdSISNpX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BdSISNpX"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710529987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=terTZT5VmzWqx2DxYpylRI5I9XQfzp7zDlHaQBT4dro=;
	b=BdSISNpXEke9ONEb6N1V9Q0MZH9Mz/Jez7NDqe2Pke8adAuz2xBjUOMFAbW5HqTW0DBXk1
	UBS9Kw0n8waBpkeDSx7dA+uPsIR0Fu0rbJlYmE7hL+qfTjxpjCJ87HS1M8dlk4FzfZ8Pt6
	BOVw8mXB5jp4VuXybyM14fuMllE2nAC7pbzWG+6UwIgPpWt6LggoShZfd+xnOezm1nl30m
	dDQlSvn1Px7rDOEUOC5NoLaGPoHk12q8gOwTDEK2Ro5K9vr4/cHzg6FnYiMzXW2kyXBgwv
	+UFag2LN8CTM+itY7oD/uNbpnEqyYOEq0w/qoXWC2Ib7PTF4O7Cj+8UKF1iNHg==
Date: Fri, 15 Mar 2024 20:13:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, git@vger.kernel.org, David
 Heidelberg <david@ixit.cz>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <xmqqy1ajqvkb.fsf@gitster.g>
References: <20240315055448.GA2253326@quokka> <xmqqy1ajqvkb.fsf@gitster.g>
Message-ID: <fab333caad7ffe3e4264e1fdf163511e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-15 18:00, Junio C Hamano wrote:
> Peter Hutterer <peter.hutterer@who-t.net> writes:
> 
>> Allow the default prefixes "a/" and "b/" to be tweaked by the
>> diff.srcPrefix and diff.dstPrefix configuration variables.
>> 
>> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>> ---
>> Changes to v4 (as pointed out by Dragan):
>> - copy/paste-o fixed in the dstprefix test
> 
> This one I understand is an improvement
> 
>> - reworded the description for the tests as suggested
> 
> Moving from "diff src/dstprefix" to "diff.*prefix" feels more like a
> regresison to me, when it is about interaction between {src,dst}prefix
> and other kind of prefix variables like {no,mnemonic}prefix.  I
> would have understood if the updated title were more like:
> 
>     test_expect_success 'diff.{src,dst}Prefix are ignored with 
> diff.noPrefix'

That would be even better, thank you for pointing it out.  If possible,
I'd suggest that your wording becomes merged.

> I am tempted to queue v4 with the z/ -> y/ fix from this round,
> without any other changes from v4 to v5.
> 
> Thanks, both.
