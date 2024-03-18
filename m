Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8654BE3
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781207; cv=none; b=PSeB9uIr4Q/0wm3k7Ake7mjaTk4y9/Pp/JF8577Y7WM9OXajAfUWoopwax1tA5aLerjqaFtjVuz2OPN94BJakbB9gjJ46746Q7hNoMa8VT5mO7tEZT+cyZcER1lWMzKFdN/Lw66x2HofZYGVSNCIW0jSIdwCcs2nbUrVqk3mOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781207; c=relaxed/simple;
	bh=fcMgSv86o17DBZZ4/csfWra5FUEM/T/yrqEngSmjB7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cqhb4loM71a2suiuAURnPw/K4tVistwaxfZynZT4Ljrl8wvGWlutDLiPfH/ZVEs1CDYT/CJ2+rtIV983AD6rDzpSBIcaPNRwqcCCCMHLby884zENC3W0pkoBJVWp4gnC8Rahh3JidtzG1L6T+qpwJtRqHTexlIVCXDSLLs7SUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qSR8ii0n; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qSR8ii0n"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6990920F30;
	Mon, 18 Mar 2024 13:00:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fcMgSv86o17DBZZ4/csfWra5FUEM/T/yrqEngS
	mjB7s=; b=qSR8ii0nGDSyTw/vRUebJJ5IeLTKQVLfCyEdDOMPA/4AyXJDWgbzqI
	3RHj6PSzq9eN7DI4AqE8c3KPMw8RpeObIOj4lfNOamXGmd7fqTnICRWKOBYQTR+D
	tXUDt9ntfWewvqbmovheJPCHyJW8S71rDGH8NdnG6xKMnud6Y+y6k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 623F920F2D;
	Mon, 18 Mar 2024 13:00:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5D47F20F1C;
	Mon, 18 Mar 2024 13:00:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #04; Fri, 15)
In-Reply-To: <20240318085208.GA604917@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 Mar 2024 04:52:08 -0400")
References: <xmqqedcbnhsq.fsf@gitster.g>
	<20240318085208.GA604917@coredump.intra.peff.net>
Date: Mon, 18 Mar 2024 09:59:59 -0700
Message-ID: <xmqqzfuvh3w0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F580CE4C-E548-11EE-B924-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Mar 15, 2024 at 05:26:13PM -0700, Junio C Hamano wrote:
>
>> * jk/doc-remote-helper-object-format-option (2024-03-10) 2 commits
>>  - doc/gitremote-helpers: match object-format option docs to code
>>  - t5801: fix object-format handling in git-remote-testgit
>> 
>>  The implementation and documentation of "object-format" option
>>  exchange between the Git itself and its remote helpers did not
>>  quite match.
>> 
>>  What's the conclusion of this one???
>>  cf. <20240312074513.GA47852@coredump.intra.peff.net>
>>  cf. <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
>>  source: <20240307084735.GA2072130@coredump.intra.peff.net>
>
> Expect a re-roll for this one. After the discussion in the thread, I
> think we can clean up the code a bit, too.

Thanks.  I was waiting for the discussion to see a resolution, which
we now seem to have.

