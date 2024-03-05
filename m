Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22A1862F
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674651; cv=none; b=sSs+iEnXWq8+j/f8Y2mkRkT3cKVzRnxdem4Mldz9ug7ISILFWpuYOWb34kOs6NGEeOrbwOITKgbxUcpaW/E40zif36HB+Qz+yFV0XVeE2iCV4ZB0YPTabw1FRca++s/HJDNFl0uHjvTZUE9CNcWwj1S/2ku2FJtb9IxQYy8wbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674651; c=relaxed/simple;
	bh=2W2sSsa+Vz9eRsbooM8weA1Y1PScVL/KDAElqwvkfiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=puTM1drS62ouMyXz09+9ifH4KW5sltErJs4u1drIRxj7ihVN1YG/JojHcCxDh+PRBGlgJp2PMwLJ4c7vDfo8CLkBJvHmsJ5KOJQ1uzRkBd4meDPcocXz0blY0dhd93u8LntFt5/0UmFa/jxoqdyv2o2IIIZAJdvx3mD3WwTQp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s8CNw+vX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s8CNw+vX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A9F41FACB;
	Tue,  5 Mar 2024 16:37:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2W2sSsa+Vz9eRsbooM8weA1Y1PScVL/KDAElqw
	vkfiQ=; b=s8CNw+vXKPE3PmGC+IJYCqo1ITdS6Ii+1VUkRpWn51gMzTWsdDecyr
	WsQB5oQ+ZBXQVh8ttBBTXCDKYxuFoNyLBdHgcxFxsLIkJ2tzqoSjlc9ye4nYAEQq
	Bc9Mmu7UCNiugxlGGdeItrShy16hXGi5eNo8oWeBMn4iy123YyWrI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E1351FACA;
	Tue,  5 Mar 2024 16:37:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F0BC1FAC8;
	Tue,  5 Mar 2024 16:37:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: also define CXX environment variable
In-Reply-To: <75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 5 Mar 2024 13:11:59 -0800")
References: <cover.1709673020.git.steadmon@google.com>
	<75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>
Date: Tue, 05 Mar 2024 13:37:24 -0800
Message-ID: <xmqqv860z7fv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F1D65D0-DB38-11EE-B8A2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> In a future commit, we will build the fuzzer executables as part of the
> default 'make all' target, which requires a C++ compiler. If we do not
> explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
> lead to incorrect feature detection when CC=clang, since the
> 'detect-compiler' script only looks at CC. Fix the issue by always
> setting CXX to match CC in our CI config.
>
> We only plan on building fuzzers on Linux, so none of the other CI
> configs need a similar adjustment.

Sounds fair.  It's not like we as the project decides to never build
fuzzers on macOS and will forbid others from doing so.  Those who
are not part of "we" are welcome to add support to build fuzzers on
other platforms.  So perhaps

    We only plan on building fuzzers on Linux with the next patch,
    so for now, only adjust configuration for the Linux CI jobs.

may convey our intention better to our future selves.

Thanks.
