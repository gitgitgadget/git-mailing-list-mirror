Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5F6A333
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337865; cv=none; b=huS2vthk5rEdTpeJ6R8XFCvewOSU3RddMFYdNgYKGPAMfSJJ7ABbY3f6XW1l75NQTfb4fHRWXZkOx/XuGqGclW9Hbxok9+EQxH/IqacNk4WdsJQpvQqlOdnPD7Zko+jd6TxKU/dC84VAPmPOgJkO5G+e9y6BsVZv+1CrpUgtQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337865; c=relaxed/simple;
	bh=cG82aYtEg3Hv1NMkPh/jc0qPbKbrVB178AzhpK2+Umc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=puhcMiX64FAvKNfOMU8d50QtS6ojwYwcBrpb069I57D9j2kNJWPXRy8hwtlyU3ExhX8I5NEYq2Jy5EjPJOZj79i69jbmb8+mMxgNOsikM0PSOOSED2y2DRzwf6QFIFsoy3gNZ76R5y7VBH3x4p8kisD0yehEI1zA/4lJrrH45Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CspCr+iW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CspCr+iW"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713337861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqqq8BhsjfPpYkQ6RldDMx9Ty71zVqq5SOztVUvLfD8=;
	b=CspCr+iW8m81mxT4tL9y6/WxL43veFmC8kYXiE/DvGbSI8Vno1FCBMzmH4zS35EQ1CNL1b
	p+NqJUPYY9pQq5zpULEtUlQ5WYUjWhYuMuotzG8umESADf/gbOA4WQUsZK51WUHsgy1IVj
	eeBeSAvPm4H3A2fLKHqPGUFOhl2s6XWyUx6F0JuPY63j4CMxJ9CuIq1ELaUX5fC+PG6PnY
	8WDhtkNNzdOYQTq12j126UOHZ4eaNl06GMMN2KBPdS7J6s5hveMmE5UYSxEmUWkpW9j89Q
	bsqatvp+csYnUZF+kggy/z7LfHW0cS6eKHwpJLgt3jtllNFZaTD6yOk33U+p4Q==
Date: Wed, 17 Apr 2024 09:11:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
In-Reply-To: <CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
 <CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com>
Message-ID: <9a6a9cb1d9dd07bbbbc47616c510779a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:40, Eric Sunshine wrote:
> On Wed, Apr 17, 2024 at 2:34 AM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
>> On Wed, Apr 17, 2024, at 05:32, Dragan Simic wrote:
>> > Fix a bug that allows --rfc and -k options to be specified together when
>> > executing "git format-patch".  This bug was introduced back in the commit
>> > e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets"),
>> > about eight months ago, but it has remained undetected so far, presumably
>> > because of no associated test coverage.
>> 
>> I don’t think speculating on why the bug is still there improves the
>> commit message.
>> 
>> This paragraph could perhaps be rewritten to
>> 
>>   “ Fix a bug from e0d7db7423a (format-patch: --rfc honors what
>>     --subject-prefix sets, 2023-08-30) that allows --rfc and -k 
>> options
>>     to be specified together when executing "git format-patch".
>> 
>> The extra sentence in the original doesn’t really explain anything 
>> more
>> about the commit. Except the “eight months ago”, but here I’ve used 
>> the
>> “reference” style (not the Linux-style) which contains the date.
>> > @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char
>> > -     if (rfc)
>> > +     /* Also mark the subject prefix as modified, for later checks */
>> 
>> I think the code speaks for itself in this case.
> 
> Apparently we're thinking along the same lines since we both said
> essentially the same things in our reviews.

Two votes, so the comments goes away. :)

>> > +test_expect_success '--rfc and -k cannot be used together' '
>> > +     test_must_fail git format-patch -1 --stdout --rfc -k >patch
>> 
>> I don’t understand why you redirect to `patch` if you only check the
>> exit code. (I don’t expect any stdout since it will fail.)
> 
> I had the same question but left it unwritten since I noticed that
> this new test is modelled after the test immediately following it in
> the script, and the existing test also redirects to "patch"
> unnecessarily. So, if it's done this way for consistency with existing
> tests, I don't mind letting it slide.

Yes, I also wasn't super happy with this new test, as I already noted
in one of my replies, but improving this and the other similar tests
is most probably something best left for a follow-up series.
