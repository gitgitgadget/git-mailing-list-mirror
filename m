Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7B152E02
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730036704; cv=none; b=kbOMaljPX67XepyEmZStnH5tN6i1METz/xmZPkLIt7bdeDaPsI0gAyR/jak/Pde9VIX36BO4zIrOFWQwWLyhhOigmJx6gh5jXE8/yMhOqUvn90Oozjyd4IlkjjKoqv0tF644PcAhq5BJxcr+AaYGuQzoYWp+NRyr1SvoktX0c6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730036704; c=relaxed/simple;
	bh=VtfivwGzCahEZKLRz6FxwkJ9QJcAUWg0JZaDAxrpDE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hEmp1ibCpmvhdzeKrvCD1AdStEwkRNz6QYhnCIIl3AhuFAxLX6Zekz7zR4uEBzL6Ig3txq6xaV74FGG8lQn0bemFA7K2rM0n+ysK0s8+6UIYXW+RVcaA4BeSIkxAddMmO8xoaGTqxixY4gZeeKp0jE4d9ODnkGSF2sUt9Y2zD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4XbySW0RK2zRnlK;
	Sun, 27 Oct 2024 14:44:58 +0100 (CET)
Message-ID: <3701837d-d9d3-422e-82f2-567a6f832dca@kdbg.org>
Date: Sun, 27 Oct 2024 14:44:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] spurious failure when adding tracked file in ignored
 directory
Content-Language: en-US
To: Christian Sattler <sattler.christian@gmail.com>
References: <CALCpNBqfGRh3U6HpJDfUQyLOckz-hRJw2_2GRZfSFqXAyRY12g@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CALCpNBqfGRh3U6HpJDfUQyLOckz-hRJw2_2GRZfSFqXAyRY12g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 26.10.24 um 01:30 schrieb Christian Sattler:
> Adding a tracked file in an ignored directory causes a spurious warning and
> exit code 1 failure (despite actually adding the file). Example on 2.47.0:
> 
> git init
> mkdir dir
> touch dir/file
> git add dir/file
> echo dir >.gitignore
> git add dir/file
> 
> The last command fails with exit code 1 and prints:
> 
>> The following paths are ignored by one of your .gitignore files:
>> dir
>> hint: Use -f if you really want to add them.
>> hint: Disable this message with "git config advice.addIgnoredFile false"
> 
> Suppose we change dir/file before the last command.  Then after the last
> command, the change is in the index, despite what the warning indicates.

I cannot reproduce your claim "despite actually adding the file": the
file is not added. So, everything works as intended. What does `git
status` tell after `git add`?

-- Hannes

