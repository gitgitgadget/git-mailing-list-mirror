Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571B139CFA
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663942; cv=none; b=TYHe/ssGYGvpk1fcVgevv/BtUV9F78+049frhnnmqzpZ2umPLnU5hknXI4qmvus1Uvb26aj037AHpv1NWhqj2KxU4BY4gS6BTo4ysNXLSXmBWbckK40uldOC4cw2cuwB96GX4no5ZXXBwDAYSr10WzWx0PF4G2xFCooTvtPxt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663942; c=relaxed/simple;
	bh=f8sqtLRSAhlM5YC2d7xLQnRLV7xc8XXFPizGYf1L7Nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksN/A2wxYSiMGWsDT0F04qsQ49jjAjjE8dlFRwJCG1Q65aj21j8WaF/qScMiPdkyBWdumrJGs1HNi6epXpjf+FSgWCOZsIisZI9+g0SUkRNdrwvsNJ4+bEm5/AeKMISDwkbihixpRb/5yhDvfAmmeDOu4C/9MVEJz5qBIJFXBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aubMkJn1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aubMkJn1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61D5D19D5E;
	Wed, 14 Aug 2024 15:32:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f8sqtLRSAhlM5YC2d7xLQnRLV7xc8XXFPizGYf
	1L7Nk=; b=aubMkJn15I+S2K4K8NSxiAu3wqOjWbE1wienIB+/tqx9LYC0IiwT4P
	HWxPBs+As//+oQC2spJBlKLkoxg+71gtr0T8zlXpIcY1ApLZnKcatANE9gHUBVTM
	AVWfmqQr0FWDRqqMNmhRL/rOGhE26vX/o7eEabDjD8qfC0dKNE5ug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 572B519D5D;
	Wed, 14 Aug 2024 15:32:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAFF119D5C;
	Wed, 14 Aug 2024 15:32:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
In-Reply-To: <2007960310.4114358.1723658954502@mail.yahoo.com> (avih's message
	of "Wed, 14 Aug 2024 18:09:14 +0000 (UTC)")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com>
	<xmqqy15rzwi5.fsf@gitster.g>
	<2007960310.4114358.1723658954502@mail.yahoo.com>
Date: Wed, 14 Aug 2024 12:32:16 -0700
Message-ID: <xmqqfrr6yk73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EABD9D32-5A73-11EF-B580-9B0F950A682E-77302942!pb-smtp2.pobox.com

avih <avihpit@yahoo.com> writes:

>  On Tuesday, July 23, 2024 at 11:25:29 PM GMT+3, Junio C Hamano <gitster@pobox.com> wrote:
>> > From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>
>> >
>> > $'...' is new in POSIX (2024), and some shells support it in recent
>> > versions, while others have had it for decades (bash, zsh, ksh93).
>>
>> I will not look at this series futher during the current development
>> cycle that is about to conclude, but ...
>
> Ping
>
> Reminder: I'll update this part to not-use $'...' and without
> fallback, but I'm currently waiting for comments on the other parts
> as well before I update this patch.

Ping for others.  I do not recall having much other things to say on
the series.

Thanks.

