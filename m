Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600415FCE5
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231649; cv=none; b=TfjP1oldBl3CoBEdCwrml5TD0aXDW+Gst01i95rTK4QSVyym0BeO8nEZXO/H4Sy8kpkns407v66COj3mudZGmvkw4t9RXUFv/7a6++cXZR+rznkyBhktKCPMmlmeRRXEUHrH0MSqoyo4uXDom+wF4/QOowaReeF9hdNVAjAocTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231649; c=relaxed/simple;
	bh=pnj7Xykjiehxxms5OULjbhNp583r0fLusEb8jQoyu2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lwsmPZ8eaOOcH1UwUKVMaIUj8F9Oqpz6n0RO63r3/VuEWGAykAone7+JZx3dshFb2nahixRsJLmhA4Iz2uX16Bp9L2NKYuCjQkMoiHSgZnvTh/Sa94/CdJRYe6ufLSucVP45nQd+QQufIKNGkNxUxOX7Nix3S0yfoPPZ4mUwrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rCVQ5tVg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rCVQ5tVg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDAEF1CE7A;
	Fri,  9 Aug 2024 15:27:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pnj7Xykjiehxxms5OULjbhNp583r0fLusEb8jQ
	oyu2w=; b=rCVQ5tVgVVJortpXY4w+W+fLfALfasOniYA/6hGN5XYSWn/G8wVne6
	Y/RYrxPwwl2xV2JgjwPHqrWKX3sdd0QMreikvXc5R6lMzhEjVIaBpiZcVvyV842v
	ondLsJwjfyJtbtQou1vp2sgMbR9ze1H+dJCykmxOHlZpa9C6DuiLQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D52511CE79;
	Fri,  9 Aug 2024 15:27:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C4281CE78;
	Fri,  9 Aug 2024 15:27:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,
  "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 3/3] send-email: teach git send-email option to
 translate aliases
In-Reply-To: <328fb497-d16e-4af1-a816-7b4aeb531504@intel.com> (Jacob Keller's
	message of "Fri, 9 Aug 2024 12:12:34 -0700")
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
	<20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
	<xmqqttfufzkj.fsf@gitster.g>
	<328fb497-d16e-4af1-a816-7b4aeb531504@intel.com>
Date: Fri, 09 Aug 2024 12:27:25 -0700
Message-ID: <xmqq7ccpcx9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68D6BB88-5685-11EF-A57F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> Dump aliases handled this by checking @ARGV and immediately bailing if
> there were anything remaining after the call to parsing its inner
> options. This works but does not work for --translate-aliases because it
> needs to treat all the remaining arguments as aliases.

When GetOptions returns, shouldn't these "remaining arguments" be
visible in @ARGV and you can iterate over them yourself, perhaps?
