Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFACA40
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717843664; cv=none; b=Zo33pfbORNx0iD9XBGvQ9Az7rPAQAWvD3iID1IiFY4kZws/0RLXpyjOl6aToSTF7J8qbWVT2En9su5o7BbumNq8ZuSk5qrO2hwaem/lpJgYR5C9otDrYrDW2jQTL0lxoxI/YSwvqdtA8dHqT58tkmoI6/GM3VimIsJU/7jK2k2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717843664; c=relaxed/simple;
	bh=5obnoWskeQ3stT+h5rringGpa1C21jjiE91QZ8v1Rs8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P+hkyskcm+NoYKK9AgLGdriXukbw1OzC0hMXfa/rYOCHFWvpZfZS+SdR59+g55Kvk5UYQjNrYryXiAyGmOSSuv6tENkpDjsUhxKyJT6f+Ah966Us81klP4BdR7F7LuXRntYee/lxbRAW2YA2tL3QjyoHqa6khQEXTm7EO+hf73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=i1JjS4Tb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="i1JjS4Tb"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717843659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yY22BPKp8eiloOnVBviAuLy1VotIQ+IL3lcqDksN0SY=;
	b=i1JjS4TbDokAwtCJtwbjlCINyMtT8lt/L/iMrgBEIyotcCiif0Myvp65zFXkjfCZHxl7fz
	mT17cT5rCKlPTFO/XaE6Eqisf13TwIDBYDQSwrY6Fol60I8yU7b25feEM0SZ98MgdAnxZ2
	an4qutXNTQavvLAU3TTZq2c3N3jjh2Z6wBlfbY0JoXnN9wxXbHI5WGOXbSrB8/h6ac0I38
	qAVREKgOKczcmLZZnzrSVOJUid1/W+X+Q+CiaEMkNKynTe6jpW6mx2KFMVgClq5a6uAdYJ
	f29JV7N3QeVmC4z69+e7cJlugSLeRpA51Psb2da3edrfWkTZApZQMNcjhHZHWg==
Date: Sat, 08 Jun 2024 12:47:39 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christian Couder <christian.couder@gmail.com>
Cc: Konstantin Tokarev <annulen@yandex.ru>, git@vger.kernel.org
Subject: Re: Autosplit option for git add -p
In-Reply-To: <CAP8UFD3JM_h1BvK59R4wT1DeZyo6o-9T3GXGK8xE6vLnDMDCaQ@mail.gmail.com>
References: <20240607120530.74297526@yuvnserver>
 <CAP8UFD3JM_h1BvK59R4wT1DeZyo6o-9T3GXGK8xE6vLnDMDCaQ@mail.gmail.com>
Message-ID: <2a50a861804727da14f6a440bc335178@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-06-08 12:43, Christian Couder wrote:
> On Fri, Jun 7, 2024 at 11:06 AM Konstantin Tokarev <annulen@yandex.ru> 
> wrote:
>> Is there any option in git to make `git add -p` split hunks by
>> default, just like 's' was pressed automatically? If no, how would one
>> implement such an option?
> 
> It doesn't look like there is any option to do that. About
> implementing it, it depends if it would be a command line option or a
> config option.

To me, a new command-line option would make more sense.  Though,
perhaps a new configuration option could also make sense when enabled
for particular repositories, but that could also trigger the main red
flag, which is that a repository configuration can change the user
experience, so I'm not sure it wouldn't be frowned upon.

> Anyway I think you might want to take a look at the run_add_p()
> function in "add-patch.c".
> 
>> My use case: I've recently started working with big LaTeX document
>> having every paragraph as a single line. As a result, hunks quickly
>> become larger than screen, so that splitting is highly desirable.
