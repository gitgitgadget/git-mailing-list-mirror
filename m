Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613FAD27
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110702; cv=none; b=W6y8iYsv6BosRi//UAulHRrqR8DrHILFy08BXdHrVxuGxp7s04/TXhLgGqUSSGKUnK8lVzw7NpfhtkwwT/lLqkIAhPsZui+yDVHkKjS5WH30JLw1RYygFzgF/H6HLRxVmFy3se3miwUoenRPugjNttRe8SikAI8g0UNi4xdhb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110702; c=relaxed/simple;
	bh=DE1rcE/ItsJONIlBHddSZYTvr4TNwoODmPIQ8ZeJKjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfPpDeaUybKAndMosmhwODWsYJnsvmlcGoaFThNkplJWv6CNkRfifIot0C4iXLsIRf1w1Xcq6u9HYH81fsqeV3vxkf33iOcGxybnngiPxBZ11IvTcUYNkHtwYjREszkx3CNW5kg1UnxzKcNvOgjYbnCbu+GEIl3wxFYc0N1pcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=P7uB+I0i; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="P7uB+I0i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1732110695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8X07hJcS5tQAVKBjOiWEmErmAJjBlJ8wfsQYIekcjws=;
	b=P7uB+I0ilArfS9ea1WGxWDoQ3Nplp5qrUMODMfT5WJTW5koKlR1EpnCp+G5qE+CiFcGAvh
	oq1b6CmfvkbHexvF6zgAxLA9KGUpdKddBtqlE6Ab1//5wWm8E0lxcT9e0uNFdouVPrzypi
	0q2gWeZ2RbY8bi/5DZdlEaD9yXsKw+E=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>, Elia
 Pinto <gitter.spiros@gmail.com>, Usman Akinyemi
 <usmanakinyemi202@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>,
 Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] test-lib: move malloc-debug setup after $PATH setup
In-Reply-To: <20241114013912.GA1155455@coredump.intra.peff.net>
References: <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home>
 <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
 <Zy-IYwjb_RO5NW-s@teonanacatl.net>
 <20241109190012.GA588841@coredump.intra.peff.net>
 <xmqq7c9aihvx.fsf@gitster.g>
 <20241111070134.GA675125@coredump.intra.peff.net>
 <87zfm3iggu.fsf@iotcl.com>
 <20241114012729.GA1148710@coredump.intra.peff.net>
 <20241114013912.GA1155455@coredump.intra.peff.net>
Date: Wed, 20 Nov 2024 14:51:21 +0100
Message-ID: <87ttc2rp2e.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> Originally, the conditional definition of the setup/teardown functions
> for malloc checking could be run at any time, because they depended only
> on command-line options and the system getconf function.
>
> [...snip...]
>
>  if test -z "$GIT_TEST_CMP"
>  then
>  	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
> -- 
> 2.47.0.527.gfb211c7f3b

For what it's worth, I've tested this patch and I wanted to quickly
confirm this works as expected.

-- 
Toon
