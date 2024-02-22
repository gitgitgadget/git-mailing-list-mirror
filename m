Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756712D219
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626469; cv=none; b=pkQ2J1XY+bE0TJPH33jrEo/nqBnGBTM79o4uRpLNB+80W3DZgTPqR2irJ2ilx5aF2SMuZDi225T1ICoBq0NdJrVvOrqH/et6pN0hsOR3EMPrXBA6q5Ghq5scKiwsd9qBXyQfaligp5yD5IKVffLq1+AP17WPyNCTKKjEnD8ALXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626469; c=relaxed/simple;
	bh=VwTr91xARjHjdSwUcv/Nu1CiYyd39TNgXNpMaPEPH7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0hyGT/tmqBpi2/jsaqLKOjWUBZMQetuUPaLpW9gUZotKdE6rx69BSgumVBLlT0BM2glCqWDE5SX63TppcBf+KOj/x6g7+2eDg3wMLDISVDVf7bnAzMsJjLyYK8zMWZOxibVZ8IFrePFc0cNU/BmPraNKpezMI3G1SkGOPm9ucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dtFJvweD; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dtFJvweD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 811931D6842;
	Thu, 22 Feb 2024 13:27:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VwTr91xARjHjdSwUcv/Nu1CiYyd39TNgXNpMaP
	EPH7Y=; b=dtFJvweDjc3+GHnDJo0sBmOtVKMcuDwRnN4hJNFSdeOEv8WiM6/DdZ
	/Num3nTRTa34ZFS91BrrI/g2goxUJRktSUq5AjN9HKsj9McW/UcSChbWnUcovKgc
	gxkpLmva3JDOcm91eQga15VmbEIpkmjEGUEmJFPS+7z2FL7HyncV8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 790C41D6841;
	Thu, 22 Feb 2024 13:27:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA45A1D6840;
	Thu, 22 Feb 2024 13:27:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org,
  newren@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 3/8] rebase: update `--empty=ask` to `--empty=drop`
In-Reply-To: <9f16544e-b6cc-414f-81e5-aac9e076f8df@gmail.com> (phillip's
	message of "Thu, 22 Feb 2024 16:34:22 +0000")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240210074859.552497-4-brianmlyles@gmail.com>
	<9f16544e-b6cc-414f-81e5-aac9e076f8df@gmail.com>
Date: Thu, 22 Feb 2024 10:27:44 -0800
Message-ID: <xmqq34tke4m7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 130D1E54-D1B0-11EE-AD4E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

phillip.wood123@gmail.com writes:

>> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
>> Reported-by: Elijah Newren <newren@gmail.com>
>
> I think we normally put Reported-by: and Helped-by: etc above the
> patch authors Signed-off-by: trailer.

True.

Teaching how to fish, the rule is to try emulating chronological
order of events.  Elijah reported and then the patch was written,
and the "seal on the envelope" is what the author's sign-off
attached at the end of the chain of events.
