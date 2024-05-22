Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E754C9A
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404782; cv=none; b=TwohgwTuPIkfU+VmRmPNYygcPmoKf7dAzIIOXrFoheexqzLUdvOrefV3i0stR9p5z4waRDzsncKVz+78oH9jXYQE45p7l7Cp/1pTB2gBXhROfFSxo008dpdHRAHxVkiyw/9Rs8u+Q+8ROif6il2hzQzSZlsk3gVHbsnND14X+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404782; c=relaxed/simple;
	bh=c/pnl5gIB5RPbAO0cRph4b0KFje6FDMMAoaV4T4dXbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K2QbZTAxVzgMwjhsWaivkDg5ITiN5hczWWrCWEhq8C0HE5KSBYgH9cW536bulp0aAANsxGMiPlNLFlxbcW6EORqkrj7g5vlmHnls+pc/QdOi5v6SsjX0lIM6zvfbJPrzD5zwdxWrl0fThy+railsp5KPqNWX122kN2Wj2JGHL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bSbFw89l; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bSbFw89l"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA5A119339;
	Wed, 22 May 2024 15:06:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c/pnl5gIB5RPbAO0cRph4b0KFje6FDMMAoaV4T
	4dXbM=; b=bSbFw89l/qu7S3o2ws9Aw7t3e1PEoWmD3RbAaFdeh5P46hmlbqZGQB
	lBvMMHMpJ1aMCxcXhptOV+Jg8vBBNEfNv4SWhcDFDWdDVCiX1GboBi/oOtaJzcQ4
	nMstuIvAKJc0T3OHV8Xf8D4rFKIXK5nErPWhedXYoBerK2m3u88ts=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B32DF19338;
	Wed, 22 May 2024 15:06:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1C6919337;
	Wed, 22 May 2024 15:06:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] setup: fix bug with "includeIf.onbranch" when
 initializing dir
In-Reply-To: <D1G4BWOMJD3E.2CNXHMRZQ12FW@protonmail.com> (Heghedus Razvan's
	message of "Wed, 22 May 2024 10:58:08 +0000")
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
	<cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
	<D1G4BWOMJD3E.2CNXHMRZQ12FW@protonmail.com>
Date: Wed, 22 May 2024 12:06:16 -0700
Message-ID: <xmqqcypd4qfr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E3A81B4-186E-11EF-BF5C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Heghedus Razvan <heghedus.razvan@protonmail.com> writes:

>> Reported-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> I can confirm it's fixing the issue. Feel free to add:
>
> Tested-by: Heghedus Razvan <heghedus.razvan@protonmail.com>

Thanks, both.
