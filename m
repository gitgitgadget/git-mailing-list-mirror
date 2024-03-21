Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2142AF19
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710997302; cv=none; b=fvFlGsSosaietAUDY6+A9bMBIRsFUgh4makn4z9a8JyUjeVUOOkKHmtHMR43ztyWTqbJTK39LYgcgi2NunDhpezY58D8/KJKnLwVyihnq4RE341T9fF+tI6zRpfSM2IUh1oQiHWHk/Y+Z5fN9NB60X2UkaBfv+NV8M5oSC+qjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710997302; c=relaxed/simple;
	bh=jAtinuhvltzRy/EPpY9kVJq2f89NsWUG9mx+7YABDE4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tAuII993fAYGojOLqUGkb8CYH8Pmd0mz56vc/IXkrAcq/TxI9cm1cVyDCo6bbwpDOu8KUD1ie7BKyzVNTPqEaisiJRTnYFo/V9FrU49DEjL2qCf+0HMo7xbQg6nFzfBFV60pOHwVrv0bkBF1AjzelV+PzICopEZ/FKka3Dx+u3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=W52s4IhU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="W52s4IhU"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710997297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xi6sNaqaiJjFLic1rlX5Nh64gTNxdhRP0dWGIL2M6jU=;
	b=W52s4IhUSe89gXqzwxLo59vBuF0c8vgnKEYbjJusbg9/todt96RVeUKtyeXBBNSjARK6nk
	Mvpy2g/CoLuGLZFYmkWHizL6mKdQtNaq/XrrbHBcKYWWochE8gWNM7reqmPQXP2UXouBI9
	f4vffdHeE6SFPrSyQXz6kCqu6fFrMlFhQABGv1OcZyn9mTc27W4oCpdg5aJphoMmkb06vK
	tcb7Qo04q7V6O3p70sKwdXpRhPBVgNO/opJAsy8XO+cs0eFM661AzOSv+EMU0E8ENVe228
	E531ILTT4gDLtSf5Hx+2YFBsI69JRedi0NMUXFxQXyV8vdSDXWohFgeTrjXr8w==
Date: Thu, 21 Mar 2024 06:01:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v4 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cQekOLrpcK_NcL951SRZAg-1Y1aFzE0-i-uCTK_XuiajQ@mail.gmail.com>
References: <cover.1710994548.git.dsimic@manjaro.org>
 <688128d8ef09589712634888074ffd71a192a7aa.1710994548.git.dsimic@manjaro.org>
 <CAPig+cQekOLrpcK_NcL951SRZAg-1Y1aFzE0-i-uCTK_XuiajQ@mail.gmail.com>
Message-ID: <4c1d28fddc0e7277154cff51c0f0fde1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-21 05:55, Eric Sunshine wrote:
> On Thu, Mar 21, 2024 at 12:17 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Add a handful of additional tests, to improve the coverage of the 
>> handling
>> of configuration file entries whose values contain internal 
>> whitespace,
>> leading and/or trailing whitespace, which may or may not be enclosed 
>> within
>> quotation marks, or which contain an additional inline comment.
>> 
>> At the same time, rework one already existing whitespace-related test 
>> a bit,
>> to ensure its consistency with the newly added tests.  This change 
>> introduced
>> no functional changes to the already existing test.
>> 
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> @@ -11,6 +11,98 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +test_expect_success 'setup whitespace config' '
>> +       sed -e "s/^|//" \
>> +           -e "s/[$]$//" \
>> +           -e "s/X/\\t/g" >.git/config <<-\EOF
> 
> Representing TAB as `\t` in the sed replacement is not necessarily
> portable and (as far as I can see) we don't rely upon that in any
> existing tests. It probably would be safer to employ a literal TAB
> character in `s/X/ /g` as Junio showed in his example[1].

Hmm, I actually saw using a literal HT character as a disadvantage.
Thanks for the notice, I'll send the v5 with this fixed.

> [1]: https://lore.kernel.org/git/xmqqzfutjtfo.fsf@gitster.g/
