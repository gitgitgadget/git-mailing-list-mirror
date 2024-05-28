Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF7224D1
	for <git@vger.kernel.org>; Tue, 28 May 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917870; cv=none; b=pdNMz85yNCp789RCSOpYVAXEe7Q/KGY/Lq55sg75Eh8hO09z5YTfr8sGjZbGga/5p2BM2Lul0WhdsS7mCeM3pJAkeWbr4MbPPpryHZIMGemELjR4v78qR5shljUGgGqwZ3TE0+sjLCCJdjwDfaVcx6EMukkuSUWWxKc08X0yaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917870; c=relaxed/simple;
	bh=iG9Goo3pZaZQ/x+bLWEglqX+Of3S7/FB3/QJiYrydKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pgiOJGf75Cvt0ugv0ZFoZ9YIhz+s7Ma95YUEwOMUZcJMZThDJS5Kny0GBJc7lvJ39I5AN/D83G6HrFst56KTEywmrOllSBFv0EdJXgday8wFHWlXjpqaqD8RE5Pj37RI3qAZgYGnMvAsIQryP2SEM8UzbKxtsgAx5PnI40Rr6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EbmLpZ4S; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EbmLpZ4S"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CF5A722581;
	Tue, 28 May 2024 13:37:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iG9Goo3pZaZQ/x+bLWEglqX+Of3S7/FB3/QJiY
	rydKI=; b=EbmLpZ4SAuNBQHK9PYn2Hah9/9AWUBIus0mW26M59aXX9ZA5Z3v3Zu
	ApJuGWZT9I1TPpgjGF9SQJph7SnZRZTiA1S2hiTiUhsjWmLZcuYZNmNMGAFgCohp
	haJ3SdzUfRhKGQUcbYzU2cBEElS6VPX47fnXNKjHTA/iKLiruZjdE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C64E122580;
	Tue, 28 May 2024 13:37:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED1932257F;
	Tue, 28 May 2024 13:37:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 2/2] apply: do not use the_repository
In-Reply-To: <ZlYS4zHmjKrzFtF6@ncase> (Patrick Steinhardt's message of "Tue,
	28 May 2024 19:22:43 +0200")
References: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
	<36b44eb4c18cfd805ccecd8df695b0d5ee9c409f.1716877921.git.gitgitgadget@gmail.com>
	<ZlWHgBROsPBrmM0D@tanuki> <xmqqh6eh7v7g.fsf@gitster.g>
	<ZlYS4zHmjKrzFtF6@ncase>
Date: Tue, 28 May 2024 10:37:44 -0700
Message-ID: <xmqq7cfd6dnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE9C03B8-1D18-11EF-A75F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> If we had a USE_THE_REPOSITORY_VARIABLE macro that guards declarations
> of:
>
>   - `the_repository`
>
>   - `the_hash_algo`
>
>   - Functions that implicitly rely on either of the above.
>
> Then you could prove that a given code unit does not rely on any of the
> above anymore by not declaring that macro.

;-)
