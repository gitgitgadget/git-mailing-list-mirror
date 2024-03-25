Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07F1CD2C
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396421; cv=none; b=Sfhzc7keVsrBBJxbfhEy0cgdzR44DsMK/CWUyEYAbNhrPhie1IsPFjH9GcISav9BJ/mzVHspwptQrNS4r2/dmLR2IzNbXjp4Pq6KyPFqVwGIsmUeKemmQRrsArYu0GrBji+fQOHXv3rLqLPM3ud8Wbwx5K62tEQBzso0LQitnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396421; c=relaxed/simple;
	bh=g592n9wfZALFsUNd/4iYcEwvhQvEggX/4q67jUBOYCU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=imnCY1tgtR0PrZLrQCzL+kMAmwnGW9UYqQB2a+3H7LWVsIKamXL88y1nWT+gw40/cVqKv45FIu4V5SBXW9eU/J92uJlqDAklWhtAr0uGxd+tZea7dqJUq5asb33zo0FUha53/V+E8kwtrc/4kha4Jvqo7mJEpOIbeVR+koWDKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HaiM+cIr; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HaiM+cIr"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711396416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFtmQwKw7SGE7wTHRpZb/xraQxRX9jEq6Kgp2uvNvvU=;
	b=HaiM+cIrZb01wOvVMrx3GMi9bM1h8j9ZUP5+tara3NE2p6pEquqpzAv0g6DIb3uDbAXl7P
	c4NjnXHZ8Sq0yzRC/Vo4TEfZbl2l92c//QHDgqz9ymrilqqURcvAeyoxTYeVWE56pJx78p
	l5y/RHrTna/TKdgF4eHLVhCpdJKoAelVPL1LotBspIVaSXhh0OJkz0eEkR/WCMI0MQuxoo
	V5IMfgY0DSfbV7wxyAjwstVoG77HDSArHP3crslAdgAzpM0MXoZ9U+qCXdSuHmcHY/khqI
	h4uLGD/zVQlaRAWGdrlRFsmmToZNVG5j/Qo9DwLCl9aUG7F9QXMGD4frAmj0Fg==
Date: Mon, 25 Mar 2024 20:53:36 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jn.avila@free.fr
Subject: Re: [PATCH v2 3/3] grep docs: describe --no-index further and improve
 formatting a bit
In-Reply-To: <xmqqa5mmjf2f.fsf@gitster.g>
References: <cover.1711302588.git.dsimic@manjaro.org>
 <a7e5151fa615d572ab4ed05519dd277048ce935c.1711302588.git.dsimic@manjaro.org>
 <xmqqa5mmjf2f.fsf@gitster.g>
Message-ID: <d741fe83f01b0a7b19ba5e1871855737@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-25 20:18, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> +--no-index::
>> +	Search files in the current directory that is not managed by Git,
>> +	or by ignoring that the current directory is managed by Git.  This
>> +	is rather similar to running the regular `grep(1)` utility with its
>> +	`-r` option specified, but with some additional benefits, such as
>> +	using multiple worker threads to speed up searches.
> 
> Sorry for not mentioning this earlier, but I do not think
> multi-threaded grep has to be something we own and others cannot
> implement.  A richer pathspec globbing [*1*] and logical operation
> on match results may be better examples of "additional benefits" if
> we really wanted to mention why people might want to use
> "--no-index" in a directory that is outside Git.

No worries.  Furthermore, multi-threaded searches may actually not
be faster for some workloads, or on some systems (the resulting speed
depends heavily on the I/O speed and available CPU power, which not
all systems have plenty of), so I agree that it's better not to mention
it.  I'll send the v3 with adjusted wording.

> [Footnote]
> 
>  *1* When you want to look for something in files whose name begins
>      with "g" but does not have "rc" in it, you'd do
> 
>      $ git grep --no-index -c . ':(exclude)*rc*' 'g*'
> 
>>  --threads <num>::
>> -	Number of grep worker threads to use.
>> -	See `grep.threads` in 'CONFIGURATION' for more information.
>> +	Number of `grep` worker threads to use, to speed up searches.
>> +	See 'NOTES ON THREADS' and `grep.threads` in 'CONFIGURATION'
>> +	for more information.
> 
> I actually do not think adding ", to speed up searches" is an
> improvement.  But referring to NOTES ON THREADS is a good idea, and
> by reading that NOTES ON THREADS section, readers can tell why it
> sometimes does not speed things up or even slow them down.

Agreed, as noted above.  Will be adjusted in the v3.

> Other than that, looking great.

Nice, that makes me happy. :)
