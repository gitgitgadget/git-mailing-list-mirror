Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E013A265
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368299; cv=none; b=iVIio1GBuGkgXz4gGa1A0c5URWIjTq1x9inH9rUaSG4cCCU0vfDwe+UbUQPn4q+EX/she6yENqAW2nRflK8Y0X0PlfgclY9g3X/s4UIcOjZJJxfl4FqOMoTOrr4mZcf40XqIGaZsm664ANzXYNLRjFUdbIfoVDS4F5jj+5XSOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368299; c=relaxed/simple;
	bh=vc9x57ZXkzNH9rkYTi13j9eb8jXUgOBsMdpkfrg3dYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fpx47CizWJvseEkO4fH+A0nuRxdxOhDctaFumEQ5ULlaxETVFGUaQ+WRaIfAFQg30ABdp2Wv+eL5XulJQbDqMO3LOpEf+68S5ZRVRVgRc7EBPJmQ7jKG+8E8VpCwzCOL0pYQXGltL3mNSUsLRYbA/ctW2UNc6SmLvQsG58f42gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OmVhPP1m; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OmVhPP1m"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEB2D1DA899;
	Wed, 17 Apr 2024 11:38:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vc9x57ZXkzNH9rkYTi13j9eb8jXUgOBsMdpkfr
	g3dYA=; b=OmVhPP1m+KGHANYBP/47C3gIidGwVDYWXulJvFaHHJpE8wr/7FTRgz
	q5j+/NVpWwx+2WZB9CPpx3yp9SkvLoibtiPygXgT48zDrtjWsg/BA6GapIWc9e8V
	SQNtqer5KPj3KKcSCegW+rGPau6k4AmSg128miBHkATBdvJmJ71DA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E6A0D1DA898;
	Wed, 17 Apr 2024 11:38:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5356B1DA896;
	Wed, 17 Apr 2024 11:38:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] for-each-repo: optionally keep going on an error
In-Reply-To: <CAPig+cSjoGe7Eeynz=jGSaNYWXQ-VkvWv7mv1NDeCXPFEtdqOA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 17 Apr 2024 04:36:36 -0400")
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
	<6721e3ada5d125bd6c33561c694acb986b17b38f.1713342535.git.gitgitgadget@gmail.com>
	<CAPig+cSjoGe7Eeynz=jGSaNYWXQ-VkvWv7mv1NDeCXPFEtdqOA@mail.gmail.com>
Date: Wed, 17 Apr 2024 08:38:15 -0700
Message-ID: <xmqqwmow9ezc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 823E29D0-FCD0-11EE-926E-25B3960A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> This is undesirable, and points out a gap in the design of `git
>> for-each-repo`: We need a mode where that command does not stop on an
>> error, but continues to try the running the specified command with the
>> other repositories.
>
> s/try the running/try running/
> ...
>> +               OPT_BOOL(0, "keep-going", &keep_going,
>> +                        N_("stop at the first repository where the operation failed")),
>
> Isn't this help string opposite the intended meaning? Taking a hint
> from GNU "make --help", should it instead by something like:
>
>     N_("keep going even if command fails in a repository")),

Good eyes.  Thanks for carefully reading.
