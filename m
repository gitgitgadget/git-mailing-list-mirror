Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4532182
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334055; cv=none; b=hHjbKvdo0g20G35npbvWVG9PPbQviFEhpRRenr2QDjAIYhvNKcSTIgf8B74xhq4cB+3fsyfqgoWdGlpV46uWXfvARTMaDLly1v4CyTO0buWJLo/XiDdjfdT7snkLt1f/4RpkutKmF24PMR7b/hlxccnAHgeS0SY+RzgxhVTbObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334055; c=relaxed/simple;
	bh=V4xn6gy9/cBpBxpsJyv/3KQ7QbNqmCbdHCilDxi19eE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=V7IEM+QRRtTP/0MuQyIidBc8HAhdrrcQ7IJLyQHNvxaZydNshXWdhJuMUspRnqbZCQJl9l/u3vzvS58q8ESZwa6xysU0uW35fPMMmRHk6lne2lGdDbgxDjt3Gg8KfSWv1BGeUYqKbNLfnDziR7bIs7STa698bkxAmL3zA943Mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Kn9/+ZJ5; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Kn9/+ZJ5"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713334049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWwARNo14q/XAK5f+HsRFHusf9KkyLoRXykNeX9hQWc=;
	b=Kn9/+ZJ5qKzmutBRX1RD0Cz45p1mr8eAIKOVoQqbPETs2fMo59izfwg2gnTLgbJ2KwGMHd
	VozoNUZ8yg8975Cd6avD2K+nw15lqxIxBmXwARTcAL9IJsTLKltj7qntKStRUlog10Xa7q
	mvXAjKCI5VI6laN/dQTahcWXWIiipPjRGQ2vZ/Ko7A4K82PQxqCg/iCMKCon6tH/SH6NK1
	PKhZKRwVD0Xjx7lgTjZfHpOQ/5RfB/q2dKW8zhfjKtmGofMnz5BbkTZINJHmSe7zrUDTfY
	DVi3o5YPCoh1SHPKa+9YeVr5jrDyprYEWDoTnIwAi7cSdPKsrgKI/SxGsu5kuA==
Date: Wed, 17 Apr 2024 08:07:29 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] format-patch: fix an option coexistence bug and add
 new --resend option
In-Reply-To: <CAPig+cRkrMDkQKnwaTGY4djwgC6mGqngB-4HfGQm1TNCq4Q4+w@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <CAPig+cRkrMDkQKnwaTGY4djwgC6mGqngB-4HfGQm1TNCq4Q4+w@mail.gmail.com>
Message-ID: <36c4a1e23653c2844a52fd994501287d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-04-17 08:02, Eric Sunshine wrote:
> On Tue, Apr 16, 2024 at 11:33 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> This series fixes a bug that allows --rfc and -k options to be 
>> specified
>> together when running "git format-patch".  This bug was introduced 
>> about
>> eight months ago, but it has remained undetected, presumably because 
>> of
>> lacking test coverage.  While fixing this bug, also add a test that 
>> covers
>> this mutual exclusion, for future coverage.
>> 
>> This series also adds --resend as the new option for "git 
>> format-patch"
>> that adds "RESEND" as a (sub)suffix to the patch subject prefix, which
>> eventually produces "[PATCH RESEND]" as the default patch subject 
>> prefix.
>> This subject prefix is commonly used on mailing lists to denote 
>> patches
>> resent after they had attracted no attention for a while.
> 
> I'd recommend splitting this into two series, one which fixes the bug,
> and one which introduces the new feature. Otherwise, the bug fix is
> likely to be held hostage as reviewers bikeshed over the new feature
> and opine about whether such a feature is even desirable[*]. As a
> result, the bug fix may take much longer to get applied than if
> submitted as a standalone series.

Thanks for the suggestion!  I'll wait a couple of days for more
feedback, and I'll then split the series.

> [*] For instance, my knee-jerk reaction is that we don't want to keep
> piling on these special-case flags each time someone wants their new
> favorite word as a lead-in to "PATCH". In addition to --rfc, and
> --resend, the next person might want --rfd or --tbd, etc. More
> palatable would be a general-purpose option which lets you specify the
> prefix which appears in front of "PATCH", but even that can be argued
> as unnecessary since we already have --subject-prefix.

Makes sense, but in that case accepting the --rfc option, back at the
time, was actually some kind of a mistake, if you agree.
