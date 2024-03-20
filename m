Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DE1DA4D
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917963; cv=none; b=Pl0s//+6Sqq4wECUTnbRTLXm3c4AqJ6k24sC+X8ddpgEwyrIjtF2CiRsRw08LMJgG4URTCTzpbt9cGO9PgO1bOchKzMSnN9aWUpgvUpYp/QEnGWn4P6Uw1MHg89jnkzACSOpjUWkVvQsB8CtOl0scRCxIzdv6XE5izTOPj5TLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917963; c=relaxed/simple;
	bh=rkQPyIptNQ8SNjP8+Yw9kyPtKSzqgtOC4x6JbmcJMWQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DhZbGmpTqIkXMPN7Hs1E16f/A/zdqB4qBu/tHDDZL/SsY+r9g5IYUy0GvsOO0UIqeUJQzBf/yVW5HAceLLOQBqirWXgzo4hRAG2PqOkowT9OXa/Xvg/NTJkhmQ2dF9VuuWahRF4EyLtRLLy6XxCMYu7Uxo9NoipYGyYORdRcNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LnCBguDs; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LnCBguDs"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710917959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd//pEJtUYABYyqVdfBB6ukKPB43DXMR5h3LeDBZNBA=;
	b=LnCBguDs9WRFGE9GLISW+OWGexhOdsTQHm15QGXpdg4FI69yqRiAMQWq0+AyDIPHTZQTAB
	aBvZSTp+4tkrXXQYUmHsJEpj+0eOLGgLXORsm31agrj9OyU2C+mtz1mLJxI8RRuVSruapd
	/X5Cm2H5UM0y9UUn8CNCu+LR+hWu46s9UcB328tgkwZPBkDyTR53sZjQimq3/7Nh8epJDV
	7NT8RttXluxf3m5snICUho7fpqYZOzmuFFljzz3WTW/XqHp1DxLWYNBw78AT00KU7RIrPQ
	S9wX0Z2Rw/GydJ7asq9Kwatoq9AL6dPcI2CtXhFHzPMdD6J5df3fuiRre2Saeg==
Date: Wed, 20 Mar 2024 07:59:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de,
 sunshine@sunshineco.com
Subject: Re: [PATCH v3 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <32c4718d09ff6675e37587e15e785413@manjaro.org>
References: <cover.1710800549.git.dsimic@manjaro.org>
 <92ddcd1f668906348e20a682cd737d90bb38ddc6.1710800549.git.dsimic@manjaro.org>
 <xmqqzfutjtfo.fsf@gitster.g> <32c4718d09ff6675e37587e15e785413@manjaro.org>
Message-ID: <c5736219057c73a3a344237257534bdc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-20 07:46, Dragan Simic wrote:
> On 2024-03-20 07:42, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> +test_expect_success 'setup whitespace config' '
>>> +	tr "X" "\011" >.git/config <<-\EOF
>>> +	[section]
>>> +		Xsolid = rock
>>> +		Xsparse = big XX blue
>>> +		XsparseAndTail = big XX blue
>>> +		XsparseAndTailQuoted = "big XX blue "
>>> +		XsparseAndBiggerTail = big XX blue X X
>>> +		XsparseAndBiggerTailQuoted = "big XX blue X X"
>>> +		XsparseAndBiggerTailQuotedPlus = "big XX blue X X"X
>>> +		XheadAndTail = Xbig blue
>>> +		XheadAndTailQuoted = "Xbig blue "
>>> +		XheadAndTailQuotedPlus = "Xbig blue "
>>> +		Xannotated = big blueX# to be discarded
>>> +		XannotatedQuoted = "big blue"X# to be discarded
>>> +	EOF
>>> +'
>> 
>> If you want to write tests where leading and trailing whitespace
>> matter in them, making these invisible characters visible is a good
>> way to convey your intention to your readers.
>> 
>> 	sed -e "s/Q/	/g" \
>> 	    -e "s/^|//" \
>> 	    -e "s/[$]$//" <<-\EOF
>> 	|[section]
>> 	|	solid = rock  $
>> 	|	sparse = tab and space Q $
>> 	EOF
>> 
>> This is still true even if we assume there is no patch corruption
>> while the e-mail is in transit.  It is safe to assume that the
>> receiving end of your patches uses "git am --whitespace=fix" and a
>> common way to protect against it is to use the opposite of "cat -e"
>> as a convention, additional to the "'|' is the left edge of paper"
>> and "Q stands for HT" conventions.
> 
> Agreed, will make it so in the v4.  I already had some thoughts
> about protecting the trailing whitespace, and making obvious it
> wasn't included by mistake.
> 
> Though, I'll have to use 'X' istead of 'Q' for HTs, because the
> option names already contain 'Q' characters.

Oh, I just saw that you've already picked this patch up in the "seen"
branch.  Would you prefer if I make this change and submit the v4, or
to perform the change in the already planned follow-up patches, which
would also clean up some other tests a bit?
