Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567F192B75
	for <git@vger.kernel.org>; Fri,  8 May 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244492; cv=none; b=baFGm4l3EO3sa3f0447l0G4tiDDT3KLtD4Uyf4vZCqW3ExQOa1sWcQogubNs1JwxzoPaumLfiqzFcSDVEjtVTayKDgTiZnbzPRpfTb2Gjm3+ztqgdUfP271x/ZePtiZ0//2HwfN7BmEWTTkVPtfkIn2PZl655UCM+e69AtZ/z8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244492; c=relaxed/simple;
	bh=wkQsoJrqRzFB/eWJjx/hVvgYDRfQX+9XjBs5oSWHJA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=jmTsKdAe4uzP6b6TgFgXqxHqAqYfg0D5JPEQJ4a/nmR0H/32f2nY9RJlRToiT02eW5M0ovWa9dugEZ71HoQC+i/zBROMKkkcjM/JUX/1zhJluXef92H3iOfPiP6gNUoqRfj/BSzbjb9oPSIa4G6EbA5u75GX6L6yKX5uCE13rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gBpnF4RDzzRpKt;
	Fri,  8 May 2026 14:48:01 +0200 (CEST)
Message-ID: <7cedf86c-5db7-45ef-b8d4-034b792f0def@kdbg.org>
Date: Fri, 8 May 2026 14:48:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
Content-Language: en-US
To: Vincent Lefevre <vincent@vinc17.net>
References: <20260506010927.GE5260@qaa.vinc17.org>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20260506010927.GE5260@qaa.vinc17.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.05.26 um 03:09 schrieb Vincent Lefevre:
> Consider the following two 5-line files:
> 
> file1:
> 
> 1
> 2
> 3
>  2
> 4
> 
> file2:
> 
> 1
>  2
>  3
>  2
>  4
> 
> On these files, "git diff --word-diff file1 file2" gives
> 
> --- a/file1
> +++ b/file2
> @@ -1,5 +1,5 @@
> 1
> [-2-]
> [-3-]
>  2
>  {+3+}
> {+ 2+}
>  4
> 
> instead of
> 
> --- a/file1
> +++ b/file2
> @@ -1,5 +1,5 @@
> 1
>  2
>  3
>  2
>  4
> 
> (e.g. as output by GNU wdiff 1.2.2).

This is expected behavior.

git diff --word-diff is not agnostic to whitespace; if you drop
--word-diff, you see the line-diff that the word-diff is based on. If
you want whitespace-agnostic word-diff, you have to add -w.

-- Hannes

