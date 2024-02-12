Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1093E498
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756218; cv=none; b=SHMoC+kTFbWrvx9bHgEaBfI01S1KcwqDLg7grPDq6M7yuEm8cEF/qLTFWTWRNMQsYSt0qwimrEU7zLTRMG8U2FlDHHm6pN/5Pu3SZYBjdUCYbQzIbIt168gsicnX+h/Ex99CRofVmHgLY6p4d+nR8l1n/9JceyT2s5bVu/BYYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756218; c=relaxed/simple;
	bh=u6ewB6C7Hv24zz6CZycj71kIcz/d0To/eFyv4nVS4iU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JAoM/77m4vhfo/K7FZQSSfYGA7g3eIKK/p52B7/o5SrzBD+Iz5uQJofc8kafr3ZSAQ0RU3eduLnFkSPpp7Fz20ygn3VnsIJgFURkia4esfpHpyA+x1oFv6YsJr77Q1w9Ag8hOMW1DzwZZB2buA+hmnRjAPihYP5mDiXfYCJVawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aQivXdrw; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aQivXdrw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05E031F2F3C;
	Mon, 12 Feb 2024 11:43:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u6ewB6C7Hv24zz6CZycj71kIcz/d0To/eFyv4n
	VS4iU=; b=aQivXdrwojfuIX5Yy61mtWgH+iMD7IQ5SVZSCaqA1730MOyK5OGuo4
	x6sHieN2K2eCk0Obi8mEXAsRmmg4s0oiz6HUPetYvsz9R1Eg5iHJB3AHEj4E//jp
	tYxC+8TOunS4K2+dPYO+/QHxQmXGnhENYO/gwX10Hve5FLI5n5k0E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F19F41F2F3B;
	Mon, 12 Feb 2024 11:43:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58A6E1F2F3A;
	Mon, 12 Feb 2024 11:43:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] git 2.44.0-rc0 t0080.1 Breaks on NonStop x86 and ia64
In-Reply-To: <00fa01da5dcd$5b060150$111203f0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 12 Feb 2024 11:05:47
	-0500")
References: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>
	<xmqqbk8nbvqy.fsf@gitster.g>
	<002a01da5c94$a1bc5340$e534f9c0$@nexbridge.com>
	<00fa01da5dcd$5b060150$111203f0$@nexbridge.com>
Date: Mon, 12 Feb 2024 08:43:27 -0800
Message-ID: <xmqqzfw57hw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9232B80-C9C5-11EE-99D2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

>>This looks like a good plan.
>
> This might be trivial, but I cannot tell. The #ifndef should be changed as
> follows:

https://lore.kernel.org/git/xmqqttmf9y46.fsf@gitster.g/

