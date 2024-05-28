Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6B24B2F
	for <git@vger.kernel.org>; Tue, 28 May 2024 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918430; cv=none; b=My4hJGkD9ptUFS/XPXoeUo5cTrpBUWz2BY7DghpOrQM2NN8AMIOP27ezco2/tUX1PP2mmuMK5MLa4y2/jnjaQikLLE+xM3lNZsHift2LiukRxBUUCcagyFffiDjmllDOzcUs18/vaNKqFmspIxw9vX2S+cAjc/eKkxikbKDtt28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918430; c=relaxed/simple;
	bh=24tnT8tSv25E5DOoZgKQPvHRXDidc2IK0mAVd6+PFEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jKjE0jsLHXu1jEyS+va4PNtsMeEARde1Fq5ldQYl5GaA7k3oKQ4ATFZAgr/am1MqmZluZEGW6M6dwf2a/VwfF/U1c+mEpwyqlFw5K+Zsk1CI57jNMtiHrXIzrOIc/X27aA30YdupmOU3AtKpb3BK1bexo1YvD8800cntqKrah74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RzTKmx9G; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RzTKmx9G"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E6B4E225D3;
	Tue, 28 May 2024 13:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=24tnT8tSv25E5DOoZgKQPvHRXDidc2IK0mAVd6
	+PFEA=; b=RzTKmx9GC9nsftgPBRTUKi5su/GRuKERPlMh/zCflJomvuhMaroxp2
	dJOaKPDnQ6EDsWZZK1o87403/d9cOWdrK9IUNJv4BsOseY30oykyKRyxb6M2ILAV
	ySvNY+R7a+Jy6mOZ6SNUMtvvZtpLgefTa1UEiaBAVvDYobik9syO0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DF14E225D2;
	Tue, 28 May 2024 13:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0AD23225D1;
	Tue, 28 May 2024 13:47:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Joey Hess
 <id@joeyh.name>,  git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
In-Reply-To: <8353645a-a684-417a-8b0e-d8cbd7da6b5a@gmail.com> (Phillip Wood's
	message of "Tue, 28 May 2024 16:02:37 +0100")
References: <20240521195659.870714-1-gitster@pobox.com>
	<Zk3ChIHr5amGh8Mt@kitenet.net> <xmqqv835xekc.fsf@gitster.g>
	<Zk9vafYPijqyWpXv@kitenet.net>
	<99225123-70f0-3546-a6fa-b6d1f981b41d@gmx.de>
	<8353645a-a684-417a-8b0e-d8cbd7da6b5a@gmail.com>
Date: Tue, 28 May 2024 10:47:04 -0700
Message-ID: <xmqqzfs94ynb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C70FEEE-1D1A-11EF-9841-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> And there is a good reason _not_ to write stuff inside the `.git/`
>> directory unless you happen to be, well, Git itself: Git makes no
>> guarantees whatsoever that you can write into that directory whatever you
>> want. A future Git version might even write a file `.git/annex`, breaking
>> `git-annex`' assumptions, and that'd be totally within the guarantees Git
>> makes.
>
> This seems a bit harsh - many tools store their state under .git/ and
> I think it makes sense for them to do so as it avoids creating
> untracked files in the working copy. I would hope that we'd be
> considerate of widely used tools such as 'git annex' when adding new
> paths under .git/

Yes, a .git/annex file _can_ happen, but between civilized developer
groups, such a thing would not happen without a good reason.  If we
have no good reason (apparently you and I did not think of any) to
create such a file, "it can happen" is a poor straw-man, as we would
be aiming to work well together.

Yes, when we have a symbolic link as a tracked content, updating the
target of the link when we need to update it is simply a bug, and it
does not matter if it points at a file inside our own repository, or
a file inside a different and unrelated repository that is owned by
the same user, or a file in the user's home directory.  Our own
repository is not all that special from that perspective, and a
change to penalize symbolic links that point into our repository
specifically probably did make a bad choice.

Thanks.

