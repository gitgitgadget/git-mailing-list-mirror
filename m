Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3981714CC
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725881; cv=none; b=gfwlxgiU6fUdo5tT7vHWKy+qhABT6Iw+lUlaP00BhVVSCfMPe4/BZBUgKTclPnKXfV9vs4WTf3PfB1hrs+WCS1zldBLIQ2IPCP8N+7EIhBJPIaFHCgTWTKb+nkPUhav5O/K7v2dzIm9p5+AO7O/9fbIpNFLks9S2nXD7C3YyVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725881; c=relaxed/simple;
	bh=MoAKJxvS9CdnhPkd/aZkKyWU+s5dsZJ9JnE6EnlbGNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gcfSGn43ceRjF1kaJl0H96nLxZQQd5PeiBtZrP6qZvgBBV0Y5LlpnyKsxjqHZcTEWOa4hp79sxp5RCsNU/eermOAtXxmQwyTtH8slyGclmMIhLc+fO5IiF1Jvf2MTCU+eeuc4dX634feIgUTMg+9RlNLmpW5JLNeshQ5tdO7VsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O/APWgJP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/APWgJP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B666231A2D;
	Thu, 15 Aug 2024 08:44:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MoAKJxvS9Cdn
	hPkd/aZkKyWU+s5dsZJ9JnE6EnlbGNc=; b=O/APWgJPrsZH8VwXEbFbSC6cp16X
	Xs3+63a4ZR3i1NJGFq9491erIS6WYxWrHVqKHALvpPDaQur53XROup3bawiZdXE4
	buRtbdK0+7ahe6+DwXk7UvhNrIteEhW2w012JVX5cNQ41S+hokXUBL/fbKBtP0xL
	EmN7+Brh7/O/j9g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AEE5331A2C;
	Thu, 15 Aug 2024 08:44:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3536931A2B;
	Thu, 15 Aug 2024 08:44:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
In-Reply-To: <12887914.4232362.1723695432887@mail.yahoo.com> (avih's message
	of "Thu, 15 Aug 2024 04:17:12 +0000 (UTC)")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com>
	<xmqqy15rzwi5.fsf@gitster.g>
	<2007960310.4114358.1723658954502@mail.yahoo.com>
	<xmqqfrr6yk73.fsf@gitster.g>
	<12887914.4232362.1723695432887@mail.yahoo.com>
Date: Thu, 15 Aug 2024 05:44:32 -0700
Message-ID: <xmqqy14yuf9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1FBDCBD4-5B04-11EF-9C22-E92ED1CD468F-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

avih <avihpit@yahoo.com> writes:

>>> Ping
>>>
>>> Reminder: I'll update this part to not-use $'...' and without
>>> fallback, but I'm currently waiting for comments on the other parts
>>> as well before I update this patch.
>>
>> Ping for others.=C2=A0 I do not recall having much other things to say=
 on
>> the series.
>
> Not sure I understand.
>
> Shall I ping the other 7 parts individually?

No, I pinged other folks, who are reading git@vger.kernel.org, to
give their reviews, because the prompt script is not exactly my area
of expertise.  I commented on it only because nobody else did, and
because I care about portability while keeping the complexity level
down.  Other aspects of the series are better reviewed by others,
not by me.

If you have updated series, resending the whole series with as v2
(e.g. [PATCH v2 1/8]..[PATCH v2 8/8], if there is no change in the
number of patches) would be good.

THanks.
