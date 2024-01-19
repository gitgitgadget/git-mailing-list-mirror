Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587017C8
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705633603; cv=none; b=dpYdKLgCpUEu4HpZ/OPUMJ/jWnOWquS7KUw2sVXeTxoCR9OfSSk4/F4FhwmSp9cfVASG4bNuuyzjQqfxikWB1XllXXwoZXXxH6jFPpRe/txUJwfBBPiSwCGxJ5jd5eSPnaYmSk36vW+T1K/dWU3FIQ2tgCy/xeufawas+Fj9Ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705633603; c=relaxed/simple;
	bh=GjRwcvjVYm5eESKn2q9n1oVCORzTkers0unCQzLZt7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MDVePqRSjRG/BKVUjkc9UVdPFZq/BrK4PTU8QfhYSnsJn4fuPcrzPXCr+S8q5d+Vte3QXAbJ1kIpH2a2XJJ1fKT/vRsjqlNJkLsbllZ91nX1Kfp1JQaQkzK6wqati2laPuqY3m/dfW0zvoSlr5HH8S3Wcs0zyRxxOGO3GtkS5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VqtrJw74; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VqtrJw74"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C68AE1CF3BE;
	Thu, 18 Jan 2024 22:06:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GjRwcvjVYm5eESKn2q9n1oVCORzTkers0unCQz
	LZt7s=; b=VqtrJw748lof8Bspl29e8ahZqpHy9Ag852O0J3M9hPSDxFwL0j4KE6
	O7xnEby2HrWv1e6YfmvPmunoezelCJpJnqzZY+8+2owBWuo9gWP5Bkxoj7cKBY6d
	QnGiboxscJzNKpxtQZPGAAvZF5MBCQ8AYTURVBpDxIxawvV8Z799k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B06711CF3BC;
	Thu, 18 Jan 2024 22:06:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 040E01CF3BA;
	Thu, 18 Jan 2024 22:06:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
In-Reply-To: <CABPp-BEaYkAPphh06R1HrfD03WTv5uy-2q-T0ZMZaxo9hfXv-g@mail.gmail.com>
	(Elijah Newren's message of "Thu, 18 Jan 2024 17:54:00 -0800")
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
	<xmqqedenearc.fsf@gitster.g>
	<CABPp-BGp0NMQKLYg=OxJgnVxARffNF57B_N2bLmwT2R2EZqhdA@mail.gmail.com>
	<xmqqil3x69dk.fsf@gitster.g>
	<CABPp-BEaYkAPphh06R1HrfD03WTv5uy-2q-T0ZMZaxo9hfXv-g@mail.gmail.com>
Date: Thu, 18 Jan 2024 19:06:36 -0800
Message-ID: <xmqqjzo6m37n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C2C8A1C8-B677-11EE-BECA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> Heh, I was hoping that we should be able to use "diff --name-only".
>>
>>  $ git mv Makefile Breakfile
>>  $ git diff --name-only -M HEAD
>>  Breakfile
>>  $ git reset --hard
>>  $ git rm Makefile
>>  $ >Breakfile && git add Breakfile
>>  $ git diff --name-only -M HEAD
>>  Breakfile
>>  Makefile
>>  $ git reset --hard
>
> I guess we could, since the only thing in this repository is a file
> which is being renamed, and we can then deduce based on the setup that
> the change we expected must have happened.
>
> However, I didn't like the deduce bit; since --name-only only lists
> one of the two filenames and doesn't provide any hint that the change
> involved is a rename, it felt to me like using --name-only would make
> the test not really be a rename test.

Hmph, I am not quite seeing what you are saying.  If the "mv" from
Makefile to Breakfile in the above example is between preimage and
postimage that are similar enough, then we will see "one" paths,
i.e. the file in the "after" side of the diff.  But if the "mv" from
Makefile to Breakfile involves too large a content change (like,
say, going from 3800+ lines to an empty file, in the second example
above), then because such a change from Makefile to Breakfile is too
dissimilar, we do not judge it as "renamed" and show "two" paths.  I
do not quite see where we need to "deduce".


