Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAAA381AE5
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601264; cv=none; b=LlgVvMdM9pSSVsSt3RUcQouDq2y3jVuh91qAXrnVEaVTeoZ91pcXNGMU43Jz4Kwq2sG4u7ghgHAK7RS8STJUbxiHsuWBGRlDH7OUdm1IH9FITxGk/xMHEiiJsuUjyrAi7QGcG1ykt9F/q8lGzCC8lUMu1Kt1EtYe7wZosAT3ZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601264; c=relaxed/simple;
	bh=vdW2VFXZMPbi8Hy4t2WiJti9THxsJw1zM0CCqv7CtyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr1zepi/cInU7yPdpp+s9UHzx0w1j5hsgd8B1woq76vw2KdnXaaqpmuDJU/JCKHuppvpkzTf8Iuk1h27aC/jBdGp6k9RVzsnOM5RcMn7/axVq+ue11HGfqMcDoWG8feon8zlMeVH4z0ixrQckFb+ffVOyVUhXuaOGClzHV3dAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eToGN1+J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eToGN1+J"
Received: from MacBookPro (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 65B7820B7168;
	Wed, 12 Aug 2026 23:07:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65B7820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786601237;
	bh=GjKwf2sSmQZGxQrA6TYzRnVZO+SIlG1yFqP4U1zDzzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eToGN1+JL4vbLXpxElr9clVhZbzp8u3tyaBz532mLYathF2M5kpvDOHGwQmzLIs8W
	 R74SKin07A0LOvG5mZdISXl8dFX+mgqsiiW7vkwqZNoGagudq4sIGGUf9EBaLOgVTe
	 bGnXt98CQkV9zcbjS0iQbU3QNKOTPIf/7H/HWRuA=
Date: Thu, 13 Aug 2026 16:07:08 +1000
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Nils Fahldieck <nils@fahldieck.de>, 
	git@vger.kernel.org
Subject: Re: [BUG] git config --global: doc and behaviour disagree when
 ~/.gitconfig and XDG config file coexist
Message-ID: <an1dekUM_fsM_l8d-delilahwu@linux.microsoft.com>
References: <xmqqo6fojkds.fsf@gitster.g>
 <336EEC18-98D3-4068-8C5C-476749959814@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <336EEC18-98D3-4068-8C5C-476749959814@gmail.com>

On Fri, Jul 31, 2026 at 09:14:07AM +1000, Ben Knoble wrote:
>> Le 31 juil. 2026 à 05:35, Junio C Hamano <gitster@pobox.com> a écrit :
>> ﻿Nils Fahldieck <nils@fahldieck.de> writes:
>>> 2. The reading claim is outright wrong.
>>> 
>>>   The docs say --global reads from BOTH files.  The code reads from
>>>   ONE.  git_global_config() selects a winner and frees the other
>>>   path.  There is no code path under --global that reads both files.
>> 
>> The documentation needs to be corrected, I think.
> 
> Agreed based on recent thread <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>
> (subject « git config: unintuitive behavior with - -global and - -no-includes »

A previous thread [1] said this behavior could be a bug. So, last year,
I submitted a patch series [2] to align behavior with documentation,
changing `git config` to read from both files. We gave time for the
community to comment on whether we should change the behavior or the
documentation, but there weren't any strong opinions [3]. The only
responses were a correction to my cover letter and a technical review of
my patches.

Since then, I've addressed most of the review feedback. I have a draft
v2 series [4] almost ready for reroll. I only work on it during "side
project time" [5] at my workplace, but I'll try to have v2 ready soon
for further discussion/review.

[1] https://lore.kernel.org/git/xmqqmt5lezi3.fsf@gitster.g/
[2] https://lore.kernel.org/git/pull.1938.git.1760058849.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/xmqqtsysfakt.fsf@gitster.g/
[4] https://github.com/gitgitgadget/git/pull/2196
[5] https://en.wikipedia.org/wiki/Side_project_time
