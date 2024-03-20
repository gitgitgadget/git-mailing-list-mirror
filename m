Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B21799B
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917207; cv=none; b=HtpcZb1vsAJql2/e7Lz+oOgy5x/YoaiJ0uZfQ2UcRB4Kp5027j0hfv2vZ6XqRzz8V/hyx2puYSsNOpDiw33e9ditAT4jRth0v+8JuAoCVsX0p2354hamPy4dlNonBt2wFN5YzjVNdenSU319K0e6GisFWgp5t0/MxgOYfscylZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917207; c=relaxed/simple;
	bh=zNnQkPhnyOiR5LX5HwBwtocsQKw2zSLZNnLunL1hdc8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=poTECe/2TcjrWHn3qJC7RHYUT764VF0RuWY1QuN53BwL7JI7gE3GMF2fhtXJxse3IDGnxcgWKz9bb9uZhCvS3dv9J0wxOI/D9ZIODdTAUo9AKWmTIp3OJM5CAQIUaKPKYuZNYqFNtsxdfmuv1HyIvOqc2VMdOd1WkRKBkiG2jW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YlkDf+Dl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YlkDf+Dl"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710917201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9cXtaxwlwJ/+WNQGcJKEqoxGr9uBkIxPfzfmKdBaO4=;
	b=YlkDf+Dl+ZESfSMmMt0XY50wzjXboR6WgS6+4SjU6oWcQJGVPcBGKnW82P+jigbDaXAvK6
	VkwxT8hr1hMImKO9GkBCUN/gNlG2nUbqUo/l35R+Xs4BJS8Clu0dVGjtHaEUpwEAqplcLl
	oUlYcSfo4BOvAER+kKKRp0zGdcHQqiKSA90CsRMclpm9N7c/AnIDWKtwfyfo5te0w1jyWs
	uitZI3p9dtXivzw4n5b7IFavLtj683S/E7hLh3oQ/TM0UCM9cuGxPylhkClv0m8q0OLThE
	5WW3cBY/UmdXaHmomzD6MS08Y8mO7pLE+1G/G5JO0KV9BwMYdSMrd7b8/nhNWg==
Date: Wed, 20 Mar 2024 07:46:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de,
 sunshine@sunshineco.com
Subject: Re: [PATCH v3 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <xmqqzfutjtfo.fsf@gitster.g>
References: <cover.1710800549.git.dsimic@manjaro.org>
 <92ddcd1f668906348e20a682cd737d90bb38ddc6.1710800549.git.dsimic@manjaro.org>
 <xmqqzfutjtfo.fsf@gitster.g>
Message-ID: <32c4718d09ff6675e37587e15e785413@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-20 07:42, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> +test_expect_success 'setup whitespace config' '
>> +	tr "X" "\011" >.git/config <<-\EOF
>> +	[section]
>> +		Xsolid = rock
>> +		Xsparse = big XX blue
>> +		XsparseAndTail = big XX blue
>> +		XsparseAndTailQuoted = "big XX blue "
>> +		XsparseAndBiggerTail = big XX blue X X
>> +		XsparseAndBiggerTailQuoted = "big XX blue X X"
>> +		XsparseAndBiggerTailQuotedPlus = "big XX blue X X"X
>> +		XheadAndTail = Xbig blue
>> +		XheadAndTailQuoted = "Xbig blue "
>> +		XheadAndTailQuotedPlus = "Xbig blue "
>> +		Xannotated = big blueX# to be discarded
>> +		XannotatedQuoted = "big blue"X# to be discarded
>> +	EOF
>> +'
> 
> If you want to write tests where leading and trailing whitespace
> matter in them, making these invisible characters visible is a good
> way to convey your intention to your readers.
> 
> 	sed -e "s/Q/	/g" \
> 	    -e "s/^|//" \
> 	    -e "s/[$]$//" <<-\EOF
> 	|[section]
> 	|	solid = rock  $
> 	|	sparse = tab and space Q $
> 	EOF
> 
> This is still true even if we assume there is no patch corruption
> while the e-mail is in transit.  It is safe to assume that the
> receiving end of your patches uses "git am --whitespace=fix" and a
> common way to protect against it is to use the opposite of "cat -e"
> as a convention, additional to the "'|' is the left edge of paper"
> and "Q stands for HT" conventions.

Agreed, will make it so in the v4.  I already had some thoughts
about protecting the trailing whitespace, and making obvious it
wasn't included by mistake.

Though, I'll have to use 'X' istead of 'Q' for HTs, because the
option names already contain 'Q' characters.
