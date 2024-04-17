Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D413C675
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355235; cv=none; b=CYi+4nlzU8p+4cJQV/KMIl04tO00E5I58MXOGL3gJjTfYqBVVWffLbAZxrFXV+G0Dy15GHHdLTeccAKNphgr/QBy42+0EAlZF0HESbCXppPXPnYVvD958iC+2IYUXcoS8e89gugEpUrS0xMvj2IL3BDeIH2AvW2ydq8S0anhq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355235; c=relaxed/simple;
	bh=U7nHutBLV8XhRLMlbMw2nAJQclkAnNizsYFAUDQXt2w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=d2UiUkTVIZMzliA5wLGU4+vMfDl9TwMlNerfT1SSK/f4mvQNqH1Mg4SMwggYwvsl9lLWoB7gHx8yYSIo0L5nPBWBWSI9EvyVoEBjqUDC7QujshuVSd6A3XHVtJC4wwvBf0ilakmHEHAupbi/ReBMQ3MvdyTJpfyzgpe7PA/9HR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oXpmBTMh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oXpmBTMh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713355229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVOvQJwiqQfMJ8q4Dlf9TsFxCdGY4vSMstKUtpCO0n8=;
	b=oXpmBTMhdSxvonLOytkATDzl6by2euHuoak0heVSygi/06mx4AWCI52MOxVC0qcMjTDQpk
	W2RIEONTsP7vlSgvHjVqaAogxQv8ZgPjVH/RlxyHnAAORzpySsGEb6p+yg918o0RndXoTb
	55/xbgutBSFHQbf9xMyiGtpT9rfU7EpXy0s/+2NfkfBA9twryGKQKqVwmkNlAagUCpy9+r
	550DIiTX3ALYTRpAJJl0PE4YFBkOYcyAHOTnV7eSLQ31KuGu80kgZ9Jiwg+ehIp/IvMkSP
	XyxGIY9JmYqe6nJN/rjA+kP/GE/WpgJT03buRYkE3ZcnmfgfTcNpId5w4+dfqw==
Date: Wed, 17 Apr 2024 14:00:29 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
In-Reply-To: <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
Message-ID: <d2a4e3b3a5abbf1fe1e8a164b410edd8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:33, Kristoffer Haugsbakk wrote:
> On Wed, Apr 17, 2024, at 05:32, Dragan Simic wrote:
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index e37a1411ee24..e22c4ac34e6e 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -1397,6 +1397,10 @@ test_expect_success '--rfc is argument order
>> independent' '
>>  	test_cmp expect actual
>>  '
>> 
>> +test_expect_success '--rfc and -k cannot be used together' '
>> +	test_must_fail git format-patch -1 --stdout --rfc -k >patch
> 
> I don’t understand why you redirect to `patch` if you only check the
> exit code. (I don’t expect any stdout since it will fail.)
> 
> Although it would be nice with a text comparison or grep on the stderr
> output to make sure that the command died for the expected reason. But 
> I
> haven’t read the associated code.

Actually, if you agree, we should check both the stdout
and stderr -- the former for emptiness, and the latter for
the expected error message.

>> +'
>> +
>>  test_expect_success '--from=ident notices bogus ident' '
>>  	test_must_fail git format-patch -1 --stdout --from=foo >patch
>>  '
