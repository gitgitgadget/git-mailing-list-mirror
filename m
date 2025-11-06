Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD122A817
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453683; cv=none; b=Q75MiOKLXHh0gGAcLS/ozS9FRqCnUvw5CU1C/AWULtCO+CTc7jvMdWsXLW9Qw1EkILJq01n06xRlBq9Pi7n8L79XHHx69u7r+G2rNvspgKSgAL6iRbxmkOT8VUS4Y1YOGNo2xYLeIcZWwDH/PMz4+dQtWj7LqdpG+wIfydgBXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453683; c=relaxed/simple;
	bh=2ieZVxrqS/7LlZ17ENgfDJ6XEEfNepUH63MVr29txbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKZPNwILeJGqebL4bMM896sPo5W82I5uNKW9cTtnQgVl6PlY3M8SQsRrlzwYFYV7sR4Zrg6d+iiAQ4j9cItsJKcPsrvaHGZ57zW9eF/XF9bQ2YtrGzpzcK6kjwcXWNpnffJULLYDiyj0Lv8YAIcQ7mCjkzL0KgIe6tkH+lJZv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4d2Vzy05b7zRnlJ;
	Thu,  6 Nov 2025 19:27:57 +0100 (CET)
Message-ID: <bdba6156-e286-492f-a64d-52bdcf074ea1@kdbg.org>
Date: Thu, 6 Nov 2025 19:27:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.52.0-rc0 test failure on cygwin
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>
References: <f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com>
 <aQx-RnNX28BPU2cS@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <aQx-RnNX28BPU2cS@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.11.25 um 11:53 schrieb Patrick Steinhardt:
> On Tue, Nov 04, 2025 at 11:49:46PM +0000, Ramsay Jones wrote:
>> So, not really an answer, but I have noted several times over the years
>> that cygwin seems to delay setting some file attributes until after the
>> process has exited ... [yeah, I don't see how either! ;) ].
> 
> What? That's horrible if true. How doesn't this cause more issues?

Unlike POSIX write(), Windows's WriteFile() doesn't update the
modification time stamp immediately. It's only updated when the last
file handle is closed.

https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile

> When writing to a file, the last write time is not fully updated until
> all handles used for writing have been closed.

-- Hannes

