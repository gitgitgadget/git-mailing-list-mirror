Received: from smtp.zfn.uni-bremen.de (smtp.zfn.uni-bremen.de [134.102.50.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F31AF0A4
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.102.50.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007824; cv=none; b=am01co//9t0l9WEC4pLZxIExyB310H9pkmDdBhU6qV8DDGEUevuqqmnvGrFRgapnK8lRXFbUrEWRVOS5WyW9dcJmK3iWoYF41siaUB0XmyrByyfn6ugCy0v5ZV9mtypUkO3Y9ojriOh4teOmY1TkZvMvOYjXGJYL9f7hMz+Dkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007824; c=relaxed/simple;
	bh=3e6BPxBSK0P1u2HZoGCMxZlloRxoFChtz8Nqrj1YwFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjvRpZWFBdA411ryBi1Na+ECPOIITlfhh6N9jk4ZXTanjKunNCM7FiTmw4T+S3NZgUSC8V6Figfvrb/sj/c05WNL2yAjASsh5BnYrWSPUmrU60KxWlBZIbMoXBbSHouzBQItXXJ9RCB/O+Eyq8BZQSoCkz/MqKANdSJH/PFPgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-bremen.de; spf=pass smtp.mailfrom=uni-bremen.de; dkim=pass (2048-bit key) header.d=uni-bremen.de header.i=@uni-bremen.de header.b=TuPZB1qg; arc=none smtp.client-ip=134.102.50.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-bremen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-bremen.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-bremen.de header.i=@uni-bremen.de header.b="TuPZB1qg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uni-bremen.de; s=2019;
	t=1739007817; bh=3e6BPxBSK0P1u2HZoGCMxZlloRxoFChtz8Nqrj1YwFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TuPZB1qgr6/l4mbnH3oCzRIrHafOHRWk0ywAKMSO80JBZcQWz9IzrlThJJftSl65o
	 /wYIPIRFMmYfCucfYRmiYcohn8Ca5cKPPH1Qa1gCppU+vdK4eUMtz/whtVwSDKdsgP
	 TNQsEHiPrYI1zGkD8i8DrMgGpb7cEas9JIUP3jfK+nmnePQ3Z9DTShPfs13JhUTbfG
	 VYYaqvEMkk0Pi5WbZna4Ky2/ZX4Xbc0JlMvrI5ff6Pg+VQCUuUTHV2rmgr+tj1UygP
	 tkcF3MOmDhrzNifzWhH3ztpAiiUZU92/mKpQaCVz6pE0JfPSeSemXekeg3yF9zgq79
	 KMV/3jx6QaMaA==
Received: from [192.168.1.104] (ip5f5bc496.dynamic.kabel-deutschland.de [95.91.196.150])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.zfn.uni-bremen.de (Postfix) with ESMTPSA id 4YqmB121qBzDCfb;
	Sat,  8 Feb 2025 10:43:37 +0100 (CET)
Message-ID: <111052b2-b64e-4146-b8eb-45ee27402ddc@uni-bremen.de>
Date: Sat, 8 Feb 2025 10:43:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git clean -Xdf affects parent and sibling directories
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <7d2cf91f-c4ac-41de-966d-3681ac549ef0@uni-bremen.de>
 <xmqq4j15fnx1.fsf@gitster.g>
Content-Language: en-US, de-DE
From: Jan Berges <jan.berges@uni-bremen.de>
In-Reply-To: <xmqq4j15fnx1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/25 22:24, Junio C Hamano wrote:
> The command should take the usual pathspec, so "git clean ." should work as expected.

Thank you for the explanations! I tried again with "git clean -Xf -- ." 
and this command still removes parent and sibling content. This seems to 
be at odds with the manual: "If any optional <pathspec>... arguments are 
given, only those paths that match the pathspec are affected."

As far as I can see, if <pathspec> is untracked and ignored, the command 
goes to the topmost ignored directory of the tree and cleans from there.

In the worst case, GIT_WORK_TREE=$HOME, GIT_DIR tracks dotfiles, and all 
other directories such as ~/Documents/ are ignored. Running the command 
in ~/Documents/path/to/another/repository/ would remove everything under 
~/Documents/. (This is not exactly what I did; I did not lose any files. 
In any case, thanks for the advice to always do a dry run first!)

Jan
