Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AA8480
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004045; cv=none; b=qyv+ONlGnmKVRffEPyLZmPesK3HVy63dJvyC7psBHiQwX9obpj4X5kNxQRiP3kZ5lKFk+e3N32+wOcGmUTP/GwW3QbtoW54ovtHDggs5YyZmER5WAj9hazCUBCG/AMtsNiMJWQTnjyrOCm1gblM4eVebYBtXuCLgbbTVZmidJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004045; c=relaxed/simple;
	bh=tBe9nUnvlDVNb/Kdg49/x/l4qm1ABDKkbTM8jztoQRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HSbIZjs6kILC0Z2OHlC2H6yEWF/b7J3Hcpuh1Hg6tfNmfvl0PvXXcrqu03AONuraf/0XwjKyMOpEvhT5KKSUq+4qDaeGxfTNaV9bdG8FS5b/iN+21MlD5Y6LZa5aTtFGt8tRvMXQJzX48Y27+UUYzHxtX3sDzArVpo7GVSCXWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gq3qTQKp; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gq3qTQKp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CC4C32288F;
	Mon,  1 Apr 2024 16:40:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tBe9nUnvlDVNb/Kdg49/x/l4qm1ABDKkbTM8jz
	toQRA=; b=gq3qTQKpWuZwPysrUc8tPflCxxpQg0QnDmEQW2YlOFAw8dSEY+lwHY
	pj0FL188bTDd6T0YQsdnqZ592mcKgMzklIfc5rdyWI81HKHFcNu10ZtKStbMR4WE
	/KlO4as/eaPo5jaRdB4CR+YytEsYDfsJxte9oNKhaSBCbsMJFFVrM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C4EA22288E;
	Mon,  1 Apr 2024 16:40:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CB122288D;
	Mon,  1 Apr 2024 16:40:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
In-Reply-To: <xmqqv851awgq.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	01 Apr 2024 09:17:41 -0700")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240330224623.579457-8-knayak@gitlab.com>
	<xmqqy19yf40l.fsf@gitster.g>
	<CAOLa=ZTLv39b4Q=AAUA39tXKgOSuu54xk3-r9OUenzxR-6qcag@mail.gmail.com>
	<xmqqv851awgq.fsf@gitster.g>
Date: Mon, 01 Apr 2024 13:40:38 -0700
Message-ID: <xmqqsf0495q1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A3E7A02-F068-11EE-A7A4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> But this still means we need to think of the best output for the
>> reference transaction hook (following commit).
>> ...

One thing I missed.  We are not currently reporting symref updates
to these hooks.  Are they prepared to take such extra input?  If not,
are they going to barf when they see "symref-update" while expecting
to see <old-oid>?

We may need to make it possible for Git to tell which variant of the
hook script it was given somehow (the easiest cop-out is to introduce
ref-transaction-hook-v2 as a separate hook, and use it if exists, or
fall back to the reference-transaction hook, and report symref updates
only when we are using v2, but there may be better approaches).

> But this is not an end-user input that tells Git "I do not care
> about precondition, I did not even bother to learn the current state
> to give you as <old-something>, just force it".  The input to hook
> is what we tell the hook what we are planning to do (so that it can
> decline), and we do not need the ability to say "I do not know what
> the current state is".  So I do not think you need any "zero" value
> in the input to the reference-transaction hook.  And I do not see a
> need for the "symref-update-forced" variant, either.

I misspoke here.  We do need "zero" value to indicate that "this
update is a creation event" and "this update is a deletion event".
What I meant to say is that there is no need to make the "zero"
value distinguishable from a "missing optional" value, which was a
problem on the "--stdin" side with "-z" format, where each command
is in a format with fixed number of parameters, unlike the textual
format, where a missing optional argument can be expressed by
omitting SP before the value and the value itself and it can be
differentiated from an empty string as an optional value that is not
missing.

Thanks.
