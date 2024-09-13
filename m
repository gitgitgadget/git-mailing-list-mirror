Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4017581B
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213773; cv=none; b=giB+4meB/SRAv4587MrE6taZJKfwfSKMwfGkUJtCNRHRswoPKeyrkR0gvbN2i2HyhZglkb8aacT2g0rPBhibvNpkrRL6ffPuhD1lD58zY1jeBXDoMpnECA7DGMMglFQpRCRatBWbVpgTFKlLfRAXZ1sAdnMxr+6Ms5MzArmwLBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213773; c=relaxed/simple;
	bh=95bsFJWDedEgyUwBmjo7YKFJkDk6/2c6/QWmmThK1lU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CH+1zbZuuullTTTdK2FfJLoQic+d0p3Sqo/5zz0dT8dpQfrTnMYWZvZeqJ7NvTgXCIsE83tjzmHLWUMkSopW2Fu5EzzwXkeFl0YUZCiRsvLYhFpRFNxKSFRFqYipgSZeOFB4FPJFLGL1owtckIROrtkUSLOS127to/h/qVtsXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Received: by silly.haxx.se (Postfix, from userid 1001)
	id 9EBE866356; Fri, 13 Sep 2024 09:49:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id 9DFAE8006E;
	Fri, 13 Sep 2024 09:49:27 +0200 (CEST)
Date: Fri, 13 Sep 2024 09:49:27 +0200 (CEST)
From: Daniel Stenberg <daniel@haxx.se>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
In-Reply-To: <ZuPdfsbHwjQPDPXc@pks.im>
Message-ID: <565691o1-3451-o06o-2594-2750r90nqq6p@unkk.fr>
References: <ZuPKvYP9ZZ2mhb4m@pks.im> <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr> <ZuPdfsbHwjQPDPXc@pks.im>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 13 Sep 2024, Patrick Steinhardt wrote:

> In a nutshell:

Thanks, this is helpful.

>  - We then clone a repository from Apache with http.postbuffer=65536,
>    which makes us use a small buffer when POSTing data via curl. We
>    typically use 1MB buffers, and when changing it back to 1MB instead
>    of 65kB the test works just fine.

Is this a git buffer size or is this a value you tell libcurl in an option to 
set a buffer size?

> I've appended two curl traces, the working one with 1MB buffers and the 
> failing one with 65kB buffers. I hope that helps.

How are you feeding the data to libcurl? (callback or by setting the 
postfields option?) I noticed that in the working case log, the POST requests 
always have a content-length header while the failing case log shows that 
header lacking in the final POST request.

Is that on purpose?

libcurl should still handle it fine, it might just be a clue for me to narrow 
down my search.

-- 

  / daniel.haxx.se
