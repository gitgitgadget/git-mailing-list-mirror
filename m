Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B2148307
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133967; cv=none; b=Dik7HjLcjSrkDg6NBz9nYwWhY0/pqgyfEqrwR+sGrB4JqtO6d3HFrhosd0AkrkoRypJ+hsAMiR6nApN4jcVo0IoBMng8ZwK0iF70NBCcW7RvSJGn9Ry/Qwr+RIIwUG7H6YQPsroEwrIVDGx2ZA4yv85yFHveNY8fr5o6SsvH5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133967; c=relaxed/simple;
	bh=Xal4s/qkQzzj+Ajt+Kw0LkOXzTfFOikdPEq4/V1Ahds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uAy+vCBZgoRc56xf2pN7bZaIvmpwXo42udSHTaVFSnltfR2mL83GKaQvM7WjDCY0GVD54TKZCo6KUpTUqaxzBaz+XHHwdG71zp1LlTOQ3PTv4lLi11tPQv25qFhju3mPB0tncVSlfbQY0CwZ63eWrLJH7cBo252pPSBKiM/Zljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NwZOWlRU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NwZOWlRU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C7E733ABA;
	Thu,  8 Aug 2024 12:19:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xal4s/qkQzzj+Ajt+Kw0LkOXzTfFOikdPEq4/V
	1Ahds=; b=NwZOWlRUqbUZa+tv7c7Xs1DJjz7ZNL+7Q2CSN8eF0vlGNm12MS7umm
	pDaFRA5oVhVFg+1/dm35PZM2Ed0N47LC1L8voESRL+RG2iRdoW2rEvMi3MVd1COa
	J1bCE5pqKhsfhJCLA5eFmKxtFYzbVPQPlpTmX90wBQVzRz1lQD+xs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 656CC33AB9;
	Thu,  8 Aug 2024 12:19:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8897433AB8;
	Thu,  8 Aug 2024 12:19:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: punk.lion0906@fastmail.com,  git@vger.kernel.org
Subject: Re: Documentation bug (?) when describing `zdiff3` merge format
In-Reply-To: <a8bc907a-de6f-4b99-a72c-41dd885fde55@kdbg.org> (Johannes Sixt's
	message of "Thu, 8 Aug 2024 08:49:35 +0200")
References: <ab0fcc2e-936f-4d76-8059-fb2bc8a4f661@app.fastmail.com>
	<a8bc907a-de6f-4b99-a72c-41dd885fde55@kdbg.org>
Date: Thu, 08 Aug 2024 09:19:12 -0700
Message-ID: <xmqqjzgrj8cf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F421ADB8-55A1-11EF-B9A2-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> This is exactly the problem that zdiff3 has: There is no way to indicate
> that some line in the common ancester was resolved identically and is
> now outside the conflict markers. Do not use zdiff3 if you cannot live
> with this deficiency. This is in fact not made explicit in the
> documentation.

Yes, indeed that is a problem and that is not I personally do not
touch it even with a 10ft pole.  We might want to stress it a bit
more to warn potential users in our documentation.

#leftoverbits then?

Thanks.
