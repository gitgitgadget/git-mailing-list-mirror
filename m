Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90321344
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707519250; cv=none; b=gYsqweYiHZ9LkxyTOJQ3SIGm0D5aLfSIWD3eEir0My92/e4xs7Nr/6POayNfAFDLWUpf8WW0C4pFNqmWrDYZOrME3hNZo6Y2IRgvcBgx2PgTKRd1e2cLgIQMK55GC6y3YzMGSedfnrygwEjei9UapLZc5+TlirurxbW7WFTzgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707519250; c=relaxed/simple;
	bh=XaxeZfBOrp21N+fuVU6n+I+finPOD52aQkcjTF7xxoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFl9wiiv8XhEM42SlEPogLD+VbIRSYHnHwixVxvVBHNSzOuSoUvvjkX35knYaAgnAb0n+hRmZb/pMi7koOkZ8OJdhPyDZrgCaxxvX6fj1NMPQHPZdkN+3bIM0kdigoZQcubC3lbNBl1Hyh212xKeeH4t7tl4HNqcRjnqYzN8hhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lTmvwiKq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lTmvwiKq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 485CC1C5542;
	Fri,  9 Feb 2024 17:54:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XaxeZfBOrp21N+fuVU6n+I+finPOD52aQkcjTF
	7xxoM=; b=lTmvwiKqjE3Rpk8ZRXE2CCvloyhC1g9vi4cUnL0Ke1iPQ4uRQr42vc
	WxfcLxL6nXqLv7AW6ZbUfRFpiT49gl2yAcsOGdXkPby9Ssu5yorCMGLQHOwioAvy
	bcMiVc94jai6VMqMx/sHlyPvtQpHGiYeW6i3t+YybTXeS4K50pINQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EC571C5540;
	Fri,  9 Feb 2024 17:54:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52D7C1C553F;
	Fri,  9 Feb 2024 17:54:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Hesse <list@eworm.de>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>,  Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
In-Reply-To: <xmqqil2xcl9e.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Feb 2024 14:42:37 -0800")
References: <20240209222622.102208-1-list@eworm.de>
	<xmqqil2xcl9e.fsf@gitster.g>
Date: Fri, 09 Feb 2024 14:54:05 -0800
Message-ID: <xmqqeddlckqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 20C4C0EA-C79E-11EE-BC81-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Christian Hesse <list@eworm.de> writes:
>
>> From: Christian Hesse <mail@eworm.de>
>>
>> We had this fixed in 3307f7dde2ae8f5281d0782f7291a073c9b1cdc2,
>> and it broke again in eea0e59ffbed6e33d171ace5be13cde9faa41639.
>
> Thanks, already reported and fixed, I believe?

Oops, missing link:

https://lore.kernel.org/git/pull.1664.git.git.1706833113569.gitgitgadget@gmail.com/

