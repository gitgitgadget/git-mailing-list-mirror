Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB829A9
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178487; cv=none; b=tWl3/Xv53UumPALzOzgJHexHWUE8kCoTdayaoli2q9mcUwHK7pjzPzjUuRCqH80WjtVAo7bqT3S0kgNplNAhsXe4T8ZuszDWFJqStEFwWjCCgQkAekRUD2EEZyeKtU2Sui1u3RF/HtSifA9L9QLTS8rREwINMiWB1YGX2VP7DBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178487; c=relaxed/simple;
	bh=sGMLB5vz3EzPsltOsu9fD8EtnU5K1MI+WOCI5kLnGUQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WHJRP3eUw8Rr2FqCb1TPtAfap3AS9CcrQZOPSz7RZJZBw5HoiiniNvlz4TKPE1PIpereoWCuK4pVXesH9qcE2Wk0SCF8TTBdD/Tgk/gMt2R/6ZvE2qUzHf1Q0fpAfE9+uJo5KSzM0+BZzY6of/NJXlKWkmg9U/PGWrjGsQIbiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ofNwjf6M; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ofNwjf6M"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710178481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjQgW8y/WQ4xNeyBr2imHLW5MqlWP5FHdbCbkD9fk4Q=;
	b=ofNwjf6MqjXknYasUriqAS9OrpsTI/RV/sH+MUli1Vb6Ug6CQLLS48DriVX5S7rxZiXQCW
	v2ClITmSFES0tkY+QSbub8ARQhcAcgf7tTd6i/+yTILJ50PS0vo9FqfVLT71oprxxVL4SS
	iclrtcGUCpkt9zFK4ivhZmzVBsiC28Rh9Z27IQ3QAril8pGnYLMkszvUpPychBK3VBIKeo
	nK5enBsCrfno58ggCu1zvZRhIpZhOxJZ7HvOvJ6pBHntvY726CW6HISi8xHuhXhsFQ+GWU
	v9HPK8oVwgQEfePU0N1FeM3XBovRoTsrREzM/EZOlEGZcKAp+vBbAWr95I7e6g==
Date: Mon, 11 Mar 2024 18:34:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, rsbecker@nexbridge.com, Ralph Seichter
 <github@seichter.de>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <xmqqr0ggsmmw.fsf@gitster.g>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <xmqqr0ggsmmw.fsf@gitster.g>
Message-ID: <dd818f1709834ca6cb9050fb4ad0f4ea@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 18:29, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> On 2024-03-11 13:55, Junio C Hamano wrote:
>>> "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> 
>>>> From: Ralph Seichter <github@seichter.de>
>>>> Introduce the ability to append comments to modifications
>>>> made using git-config. Example usage:
>>>>   git config --comment "changed via script" \
>>>>     --add safe.directory /home/alice/repo.git
>>>> based on the proposed patch, the output produced is:
>>>>   [safe]
>>>>     directory = /home/alice/repo.git #changed via script
>>> For readability, you probably would want to have a SP before the
>>> given string, i.e.,
>>> 	variable = "value" # message comes here
>> 
>> Let me interject...  Perhaps also a tab character before the "#
>> comment",
>> instead of a space character.  That would result in even better
>> readability.
> 
> Depends on your screen width ;-)

Ah, screens are pretty wide these days. :)

> If you were trying to tell me that SP or no SP is merely a personal
> preference with the comment, I think you succeeded in doing so.

Huh, that wasn't my intention.  IMHO, a space character between "#"
and the actual comment is pretty much mandatory.
