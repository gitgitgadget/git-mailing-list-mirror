Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BDEBA39
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721222; cv=none; b=czGdpTUmTMKPPBK4LONkVvLdAfw+iVRyViSX59b8V511MAGw0ZBpla334bg4fAVNwGOOz0z4/CxxWXOwPwQhVqZWwJHyZRESSLJkmmYCXHASixjjdvsu+m73fNn5fjSkuCK//HfbJbhwGfx5klxb7Ez992fUVrF2trMLFl3/WAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721222; c=relaxed/simple;
	bh=pcS3Jsh4x5il2iW6+gJsNi6pSbxCUVhrfsErOV4Np34=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bMWO9IZo5Gur/9QdsOWenKOzj58K65SFt2TKPYxmk8TH71N9bt8d3maztWjG8JuR7iud9a4fH63wHAC/cysTroEe4cmrag1IB3betxmtwbsZnAxZib/sAq7Ltz/oggPdKJctJ35jUTQeRaSh/jQz/4ahNQjy6Bqu2e7hQTRh7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=E1QrNUiD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="E1QrNUiD"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712721216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1Aa/deNT/s6KKUFPD49WJ576vYbeVTcnjo6U0hnX1o=;
	b=E1QrNUiDFS8IE2BiB8SSezAVCTxtkFXY5SFGen1cBerWzved7YbEdpOP1H2oVFOeWysYBe
	hR4IvzmeWP50RYTT8gxJuXoQvBHn3ZD0k7/NoZ/HsoElJQOv4JvCwilL0FwV5EdkryFziQ
	+204WASnz+cSzhzuxLXyyOUn1WY2bOwhHn1gu0NsgoPCrNpPcbUmDIsDAxlMWicoXVm1HY
	+r7lpRs40N8TDCBwGaZYknPVlQvJYY0EwoOfvMVVVdj11Au3R7a524VvijJTHqPuD9aj+q
	kxoDHFu5qkRAWI5+37Yf6qvw4jtTxdx8wnVDrETUkwD4n2wgJ5ZUlIr2YMkVdw==
Date: Wed, 10 Apr 2024 05:53:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v5 3/3] send-email: separate the confirmation prompts from
 the messages
In-Reply-To: <bc3998b1c9bbdbc75287735b42013f52@manjaro.org>
References: <cover.1712486910.git.dsimic@manjaro.org>
 <7b99e5c7c0b0c8d3d7eaaae169e650ebe81964a1.1712486910.git.dsimic@manjaro.org>
 <xmqq1q7fa6u7.fsf@gitster.g> <bc3998b1c9bbdbc75287735b42013f52@manjaro.org>
Message-ID: <feabd3a4b4fc6f03d31b59340bc238cc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-09 05:25, Dragan Simic wrote:
> On 2024-04-08 23:21, Junio C Hamano wrote:
>> When $confirm is set to 'never', you have both $needs_separtor and
>> $prompt_separator set.  Would it mean you'd have two extra blank
>> lines for that message?
> 
> Actually, there are no unneeded blank lines in that case, which
> I've also tested before sending the patches.  One of the blank
> lines (the one for $needs_separator) goes after the patch messages,
> and the other one (the one for $prompt_separator) goes after the
> prompt, which is displayed before the patch messages.

Actually, there's a much, _much_ simpler solution for everything,
which also works as expected when running "git send-email --quiet"
with sendmail.confirm set to "auto" or "never".

I need to test it a bit more, and I'll send the updated patches.
