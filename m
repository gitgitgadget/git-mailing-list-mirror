Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9F210B
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="O5cEKzAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1704109355;
	bh=E+xXAgRB5kjtQ+diSkKXlYm3QLprNooS7l+lZhRDOFg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=O5cEKzAdqSSWjweC47OO7iYzw4Gnbc77YyCoU7ma010PJUGE+eJwZlIFOyn4AWQ/B
	 G1K5Nls3X/OvZWxTKnAtXZmDREGhiOf9FpAu9LGga6yY176zhUjeVIA7cW+evF0Yal
	 l+XKViSa5WkfLrsTISuKNwD0epvrixo+sKZsPY63lGLZtlhxZHgtC1vOlUcQUEudEB
	 hqE28nLEQ8cMFKx4e0v5VDNH3qPwEyaCxnvHcfcaQGGB0fTidhOh6IQFiBnfxcwavv
	 RhXWI2gsTh0I5g9QXjAjZzMo+I3jYaclhKDk2cK5k1Med2l5/RSH45cDOrsWTcS12R
	 BWcxxIWQzuiDQ==
Received: from [192.168.42.22] (195-97-142-46.pool.kielnet.net [46.142.97.195])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id CA57D3C0316;
	Mon,  1 Jan 2024 12:42:35 +0100 (CET)
Message-ID: <08e4527f-3e1d-488c-8857-a40b65a71a3c@haller-berlin.de>
Date: Mon, 1 Jan 2024 12:42:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concurrent fetch commands
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
 <9b5ff583-f8b9-42dd-8829-2fea74bc2057@haller-berlin.de>
In-Reply-To: <9b5ff583-f8b9-42dd-8829-2fea74bc2057@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 01.01.24 12:30, Stefan Haller wrote:
> But it does sound like --no-write-fetch-head will solve our problem,
> thanks!

Actually we saw another problem recently that I suspect might also be
caused by the concurrency between fetch and pull, but I'm not sure. I'll
explain it here in case anybody has any idea.

What happened was that a user tried to pull a branch that was behind its
upstream (not diverged). They got the error message from
show_advice_pull_non_ff ("Need to specify how to reconcile divergent
branches"); the log then showed that the background fetch was ongoing
for the remote of the current branch while they initiated the pull.

Trying to pull again after the background fetch had moved on to the next
remote then worked.

I read the code in pull.c a bit, but I can't see how it can become so
confused about being diverged in this scenario. Any ideas?

-Stefan
