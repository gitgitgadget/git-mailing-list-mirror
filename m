Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB7181339
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099795; cv=none; b=PhUqOutNcJ8FUqec+g3vZEyYPMEIWNKSwoyLA2JryNrAwh0utfMqvu7ka9hlFOML2W+7ScRgbNRjBtL87DBpCveVzLzwAuuLKFh8AUw8fh9sJAiOrNcLj0GrBqEKTLqVdv/GROui8WIJycPw0kg736Fxt+5I85QbyyDtYtcD7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099795; c=relaxed/simple;
	bh=8qA/Q1hO/sPOsG6bd0GR9FJL2oucK7IwxiHrUiYXX5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=sfqUCnWKk8aJTFPz9FOW0eh/YCwoXlsxmCAPI91m5oJEkp8xseeq3n7UxCyRMHSq4pyDyVhaILv/u9AzbFWgmRQEdwf59Qzx9lyNxKUN8zwKIZBGiAsjUkECIOtX6wizzkMmtdumFoH4Mrj8Orkjs/wiAQiV70E4aPL1OzhCl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Wfd2J6RHqz5tv8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 08:49:44 +0200 (CEST)
Received: from [192.168.1.102] (213-147-164-183.nat.highway.webapn.at [213.147.164.183])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Wfd290qJhzRnmP;
	Thu,  8 Aug 2024 08:49:36 +0200 (CEST)
Message-ID: <a8bc907a-de6f-4b99-a72c-41dd885fde55@kdbg.org>
Date: Thu, 8 Aug 2024 08:49:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Documentation bug (?) when describing `zdiff3` merge format
Content-Language: en-US
To: punk.lion0906@fastmail.com
References: <ab0fcc2e-936f-4d76-8059-fb2bc8a4f661@app.fastmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <ab0fcc2e-936f-4d76-8059-fb2bc8a4f661@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.08.24 um 03:22 schrieb punk.lion0906@fastmail.com:
> The docs at
> https://git-scm.com/docs/git-merge#_how_conflicts_are_presented
> describe the following snippets in `diff3` and `zdiff3` style as
> equivalent. They do not seem equivalent to me, so either this is a
> mistake or the `zdiff3` style is counterintuitive needs a better
> explanation.

I don't think that the documentation wants to claim any equivalence. I
can only see it says that "diff3 shows the conflict like this", and
"zdiff3 shows the conflict like that".

> zdiff3 style:
> 
> ```
> Here are lines that are either unchanged from the common
> ancestor, or cleanly resolved because only one side changed,
> or cleanly resolved because both sides changed the same way.
> <<<<<<< yours:sample.txt
> Conflict resolution is hard;
> let's go shopping.
> ||||||| base:sample.txt
> or cleanly resolved because both sides changed identically.
> Conflict resolution is hard.
> =======
> Git makes conflict resolution easy.
>>>>>>>> theirs:sample.txt
> And here is another line that is cleanly resolved or unmodified.
> ```
> 
> The problem is that, I believe, the "or cleanly resolved because both
> sides changed identically." sentence should not be part of the
> **base** in the latter example, since that whole line was moved
> outside the conflict.
This is exactly the problem that zdiff3 has: There is no way to indicate
that some line in the common ancester was resolved identically and is
now outside the conflict markers. Do not use zdiff3 if you cannot live
with this deficiency. This is in fact not made explicit in the
documentation.

-- Hannes

