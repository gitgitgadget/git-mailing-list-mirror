Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F836A026
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338462; cv=none; b=jj8p/c7OdDYyCk0g/wPko60wXJ7xp97Dpw0bhSxARg4/9w5vJhr8CTZDVYcMJsfSu2G9dcZrbRu5H8ID+0CmoVVxZ2O5QfLpReYyeue2lbjC+mNS4Hj1ax7eOQ8zu0Gv8i5cQIsxTa28wv0FzR4FnSpiAlGrwasaRX8CGRymXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338462; c=relaxed/simple;
	bh=16XE1Ug/EhsswMtO2KfZxfT1un73u4TML+ECpN8U/1k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GnOm33ezfu9Dwf5EDEJiYKi2w7LISIG0fKM2SjXKLySUX0uh4XCjgE3uI+5P4bugHVwpz22RGRXchs0G8dGraxS2EMr3FMWKx7INvhxmjrI2DKLtGjZr/2lG89sOctF/13JdBHNZLtadoYjKrd0cQY2Hh35/f3IzPddfN0uGL8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fs003G/8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fs003G/8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713338458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9thZk+wLITGCCphmkrjT0yIoCrvah/CUBZ8bct0Y1o=;
	b=fs003G/8/asGwDZ8gGJn/2kZsGG7fa0qrvVg+X5VHJArYAilyQlNRiGY4czW47P8ZLCXOH
	TgzL+ryZsQJUDViZjSwHMggi0iZzo+hioARE+mg1f9aqbQbOHgdeQdPmB2wfSm8waqGXf8
	IC7SmhAgNeDNkAHI2NP2QUZbZMHAvm+CsPZTs44+De+UocvM2ZZ9lza0+9LM9iwl1a3NDU
	a0+TUaOe5G/JVj3+9MNWD4L0xrIbVKiPZCjx0jiGOApzyDhR4mqB7+t8HS9DXK2UEKx14O
	Gy34MyByVvQMpFiMOmBPoJOXDbf3Ggc77h+mCWcpD1zpdSZWukbEseURO6BPxw==
Date: Wed, 17 Apr 2024 09:20:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] t4014: add tests to cover --resend option and its
 exclusivity
In-Reply-To: <CAPig+cRBjosyadQHO03fcCz7YBc=T04ytHkpt9UU87tLaiSOgw@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <42865d6c6694b9e6b745c328d717ed244dc25a1a.1713324598.git.dsimic@manjaro.org>
 <CAPig+cRBjosyadQHO03fcCz7YBc=T04ytHkpt9UU87tLaiSOgw@mail.gmail.com>
Message-ID: <82846020aedfdc5eadf5bc8349575ec1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:48, Eric Sunshine wrote:
> On Tue, Apr 16, 2024 at 11:33 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Add a few new tests to the t4014 that cover the --resend command-line 
>> option
>> for "git format-patch", which include the tests for its exclusivity 
>> with the
>> already existing -k and --rfc command-line options.
> 
> I'd recommend squashing this patch into [3/4] which introduces the
> --resend option since it's easier to review the tests when the code
> which is being tested is still fresh in one's mind. (For the same
> reason, reviewers like to see documentation added in the same patch
> which changes the code since it's easier to verify that the
> documentation matches the implementation while it's fresh in the
> mind.)

I'm fine with that.  Squashing these two patches together might also
be good for bisecting later, if need arises.

>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> @@ -1401,6 +1401,43 @@ test_expect_success '--rfc and -k cannot be 
>> used together' '
>> +test_expect_success '--resend' '
>> +       cat >expect <<-\EOF &&
>> +       Subject: [PATCH RESEND 1/1] header with . in it
>> +       EOF
> 
> In all of the new tests, since it's just a single line body, it could
> just as easily be created with `echo`:
> 
>     echo "Subject: [PATCH RESEND 1/1] header with . in it" >expect &&
> 
> On the other hand, if you're following precedent in this script, then
> using a here-doc may be just fine.

I agree that using "echo ..." would be nicer.  Though, I just wanted
to follow the already existing tests for consistency, which may actually
outweigh a nicer approach.

> At any rate it's somewhat subjective and not worth a reroll.
> 
>> +       git format-patch -n -1 --stdout --resend >patch &&
>> +       grep "^Subject:" patch >actual &&
>> +       test_cmp expect actual
>> +'
