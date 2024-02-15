Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE4131E5F
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018407; cv=none; b=IlwceMwucxPEKqgWk/RpWUWBwgirP5EQvnOIlPVs9SoHrpzslAU+XfDOWWxtlT9BC58zpSpk4tq3UDM1Jj26gIHwUeNB6U/UwxsIiLyMNRFqMEzJIy8QRf1l+IRusu8j6CUzB/bP5S4ND8vuL7Ag1WJNglgqysPt2STqer95rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018407; c=relaxed/simple;
	bh=b9o0+2HSd4kKLIbMbdHnNlWcbSsZy1kjoPdryaL2yLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deedG8aLQ6HZSDW8CbWeyZcxzsr7U4hmhwZXCDZM3+h8HMv02FkW0KX0WhdKlw10+8NIpdRqmXF6cMvuIk3kfi2VtsPVhSUt48ZDzbFKQpn6vqBUErKAc/ggTsi/MOE9UL5FCqblR3kRLweyevb48j/DtgBIodmOSwILgJTLMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XNVVp3o6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XNVVp3o6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3EB41DE1B0;
	Thu, 15 Feb 2024 12:33:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=b9o0+2HSd4kKLIbMbdHnNlWcbSsZy1kjoPdrya
	L2yLA=; b=XNVVp3o6Bmp0hYONPfT2uCl7ULi3IfHPG6LIa1++EFEqPrPiw7ygWg
	8t8QSuXJNR8+ZaglpnZebNguU45vKWq3NTjidaW7WnoCW0Meb7Ckqpwfd97Wo7pN
	qRTmc86jBTEeRVIK5Uis5wdQc3lJwwA3rLHAsUodUIIolsouAZcKs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BA361DE1AF;
	Thu, 15 Feb 2024 12:33:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E03AF1DE1AE;
	Thu, 15 Feb 2024 12:33:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] use C99 declaration of variable in for() loop
In-Reply-To: <20240215094243.147057-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Thu, 15 Feb 2024 10:42:42 +0100")
References: <20240215094243.147057-1-gitter.spiros@gmail.com>
Date: Thu, 15 Feb 2024 09:33:22 -0800
Message-ID: <xmqqcysxskd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 51DEA4A0-CC28-11EE-9C55-25B3960A682E-77302942!pb-smtp2.pobox.com

Elia Pinto <gitter.spiros@gmail.com> writes:

> With the exception of cbtree.c, which would need initial
> reworking to remove the usage of goto, it expands the
> use of variable scope reduction in for loops as
> permitted by the C99 standard, which was first introduced
> in the git codebase with commit 44ba10d6.

Thanks, but ...

Our test balloon may have proven that nobody will be inconvenienced,
and it does mean we can be liberal using it when we add new code or
update existing loops "while at it", but I personally do not think
such a code churn is very welcome.
