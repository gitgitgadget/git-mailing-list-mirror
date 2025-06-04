Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A23C463
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065128; cv=none; b=B/ysPhaJv3baSnQpHPypifzItqGRizld/oD2SD+DW3u72NPw6caVZtC98sfPMne6+395JZJ+01fR7ykabDUhj8/XFN36xzRG2raM1ll2vkRNnWhcKoZl1XFR53D8+uEox3pS8KcLdxWS29UitcbvlIS1k3/qtsz57hXw9cUHWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065128; c=relaxed/simple;
	bh=s2uMYn/6TVGb5Ar1GN0yjN2iXzjCCNEZppKl7T8pvSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUlsUuVj7PgAFU54UJeb/ZDc0c0WHd1G8fAzmZFllmgZ1mWHAe4IEg3n5KMO5oOkm7W/5dINXeH8eoYG9sTlvGN/Brp11RviDggT66NOElyRNhCALB/HiAlIxnxDq8JFEKO9Zj7M5JNFdBOdJg5XFRiBuD0/OiLCAzWN8LGiNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4bCHbd0PvJzRnlK;
	Wed,  4 Jun 2025 21:25:16 +0200 (CEST)
Message-ID: <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
Date: Wed, 4 Jun 2025 21:25:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
References: <xmqqsekgn4gk.fsf@gitster.g>
 <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
 <007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
 <aEBPdFXpIca7lMls@teonanacatl.net> <xmqqjz5rcz90.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqjz5rcz90.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.06.25 um 17:17 schrieb Junio C Hamano:
> So the build procedure for git-gui (but not gitk) has changed rather
> extensively after we tagged the preview before -rc1?  Honestly, I
> would have preferred to see a change with this impact go through the
> regular 'seen' to 'next' to 'master' way before -rc0, but that is
> water under the bridge.

I don't think we ever had such a cycle for gitk and git-gui. I carry
inofficial branches 'j6t-testing' in my repositories that interested
parties could track instead of 'master'. I would be happy to hear that
people actually do use them.

> I do not spot anything obviously wrong (and it is not expected that
> I would---we wouldn't have this code sent to me in the first place
> if this is something I can immediately notice).  git-gui/Makefile
> sets ALL_LIBFILES to $(wildcard lib/*.tcl) and then does
> 
>     $(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)
> 
> So the error message in Becker's message, i.e.
> 
>> /usr/coreutils/bin/bash generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS 
>> usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE> [<LIBFILE>...]
>> Makefile:200: recipe for target 'lib/tclIndex' failed
> 
> suggests that $(wildcard lib/*tcl) expanded to *nothing*, which
> sounds horribly wrong.  They are source material and should exist in
> an unmodified checkout or a tarball extract.

I don't see anything wrong, either. I can easily verify your theory that
the $(wildcard) produces an empty list by modifying the pattern.

Randall, would it be possible for you to find out why $(wildcard
lib/*tcl) produces an empty list in your case?

-- Hannes

