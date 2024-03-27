Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4204171C4
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520780; cv=none; b=TISEQ8pCWtdWf3ylHxMlA5VVVxcPh9x7Ffxpsqzcg/utwb+T4Fhso8j4f54HyZMhdIrFTjY4f1b73fliNWWqNVPR17YuzKKRi52Q0BTDmvauKcFQ/wV32PFuSP2DCWJjk0fhNbRXazxGKbKuo9nJ+VmBzkeFRV/3163HLcIJfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520780; c=relaxed/simple;
	bh=wXEx+qKolObVheLqzXVe98IoMuM7G4z+NjmFc41I+1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oNmUOyBjYzylR7oHfxbPsU3OYzF7AR0JSJ9745VnOu4al0T6/TldZeXerbm+8ZLCuvJWvPwhyUjcPvvxUWJ+NELia4w1Ny8fraELGDoiTnYMKoFUiQjnSrzz2Zh+0PmcMnoExmFd47S0lzUDsVLEvuyhCP8DHQy2FttrdIO2B4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=bW4nJkyI; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="bW4nJkyI"
Received: from localhost (ip-109-42-178-117.web.vodafone.de [109.42.178.117])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42R6Q0S0022779
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 07:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711520761; bh=wXEx+qKolObVheLqzXVe98IoMuM7G4z+NjmFc41I+1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bW4nJkyIpRlDzrHDfSvDBZQkhZiwbT8zK1guEY5tqa/0nE6GauI53RVp8x7EVM4nN
	 /f5ArYIutE7H3eYkdS7dOhqwcXzag3xO7HLYh1Yd772XdsDu7Uj4aIEhHu4gPah7nQ
	 au4ftBGEemfZcJA4g2BALYS7x+KjNAJ93Ao/zMwI=
From: Dirk Gouders <dirk@gouders.net>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v4 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
In-Reply-To: <ezbbu7ibxxrzogb4w46qvqgtwowtaf7e5o5y5dcb53gq7ko33c@g6eror27glzn>
	(Kyle Lippincott's message of "Tue, 26 Mar 2024 18:04:39 -0700")
References: <cover.1711368498.git.dirk@gouders.net>
	<20240326130902.7111-1-dirk@gouders.net>
	<ezbbu7ibxxrzogb4w46qvqgtwowtaf7e5o5y5dcb53gq7ko33c@g6eror27glzn>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 27 Mar 2024 07:25:55 +0100
Message-ID: <ghttkstclo.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kyle Lippincott <spectral@google.com> writes:

> On Tue, Mar 26, 2024 at 02:08:35PM +0100, Dirk Gouders wrote:
>> The 4th round of this series.
>> 
>> Chances are that I just waste your time with my attemt [4/5].
>> My appologies in advance, should this be the case.
>> 
>> Recently, there was a discussion [1] on the groff mailing list and I
>> guess I couldn't resist to try to practice what I read in the linked
>> resources ;-)
>> 
>> [1] https://lists.gnu.org/archive/html/groff/2024-03/msg00014.html
>> 
>> Could be that the remaining controversal part of [4/5] should just be
>> left untouched, because it is consuming so much time -- I summarized
>> all those versions, so that all incarnations can be compared in one
>> view:
>> 
>> * Original:
>> 
>> Asking `traverse_commit_list_filtered()` to populate the `omitted`
>> list means that our object walk does not perform any better than an
>> unfiltered object walk; all reachable objects are walked in order to
>> populate the list.
>> 
>> * v3:
>> 
>> Note that this means that our object walk will not perform any better
>> than an unfiltered object walk; all reachable objects are walked in
>> order to populate the list.
>> 
>> * Junio's suggestion (with minor rearrangement):
>> 
>> Note that our object walk with this function will not perform any
>> better than the previous unfiltered walk, because all reachable
>> objects need to be walked in order to populate the list of filtered
>> objects.
>> 
>> * Kyle's suggestion:
>> 
>> Note that requesting the list of filtered objects may have performance
>> implications; all reachable objects will be visited in order to
>> populate the list of filtered objects.
>> 
>> * My new attempt (v4):
>> 
>> This list of filtered objects may have performance implications,
>> however, because despite filtering objects, the possibly much larger
>> set of all reachable objects must be processed in order to populate
>> that list.
>
> I agree with the issues Junio raised on this phrasing, and trust in Junio's
> judgement to get to a clear phrasing :) I'll be unresponsive to email for at
> least the next two weeks, so please don't block awaiting my response on any
> future rerolls.

Thank you.
