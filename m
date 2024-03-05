Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85C127B67
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654376; cv=none; b=AyQq1ENmMVtyyCfBLk9b7oM3a9qdhVFrI9gFCljSFGpdaGifXep5mrP/V+NR+QwG/eOjvu5vA+XuVN/Mu83MJDH74cuLdWV6kFBqlqADi+2zHFDqo+o1Ym8kkJepK5XK87ZX1RiQK4DQR1EqVWZFenqxM1pNpRnYq+nDcFoSWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654376; c=relaxed/simple;
	bh=f3CR0+vTcLIcnwBA5j4lUVxe4Pj0/ybxWATXKA2C1YU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COZiBp0Epn0O908IXdSwAlLHXJmq0Z5P6WwHXff77wqJEYijKrodsBv6gZd4LoNefGAbHb1+kLK9TXdLozfvTCO8JVeadX0oc5tne4QzWt2FRjNnvof5slfBZoKrsTP2StW2nqJK98TIsPYCvqwqBerzjp3QOKc6H24udjQ7L0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ooFIcIoB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ooFIcIoB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC0341CCA8A;
	Tue,  5 Mar 2024 10:59:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f3CR0+vTcLIcnwBA5j4lUVxe4Pj0/ybxWATXKA
	2C1YU=; b=ooFIcIoBHcQCzZDKWogUJOu6RMjrhgkTddj8zmIoWwf864bA7yyOBv
	g/kfp6ULutGfcPQxg9Hhh7P1rLlzNTOQq0v7VR6Y/9P48VwMjzfzcJIl5tcqXSIM
	mGh/T2HqR+Z6HiUIQC86nWbAPDqO/z7W9gF41F12PgA+CacJ0crr0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C2A871CCA89;
	Tue,  5 Mar 2024 10:59:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30FF31CCA88;
	Tue,  5 Mar 2024 10:59:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Mike
 Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] refs/reftable: don't fail empty transactions in
 repo without HEAD
In-Reply-To: <ZecFXXqUdGEQ3YhC@tanuki> (Patrick Steinhardt's message of "Tue,
	5 Mar 2024 12:43:25 +0100")
References: <cover.1709041721.git.ps@pks.im>
	<95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
	<CAOLa=ZSycN0iYbBP-rXKW5=tNJLaSd0q8+Vm=CzNfsP2nR0sJg@mail.gmail.com>
	<ZeVtuqEAelfiA2J9@tanuki> <xmqq5xy2rmfy.fsf@gitster.g>
	<ZecFXXqUdGEQ3YhC@tanuki>
Date: Tue, 05 Mar 2024 07:59:31 -0800
Message-ID: <xmqqmsrc655o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5AF3A014-DB09-11EE-8065-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> So it's not uninitialized, it rather is stale.

What I wanted to say with "technically it is not" was that these two
are moral equivalents in the code around there after the early return
happened ;-).

> I can send a follow-up patch to remove the useless variable assignment
> in the test, but other than that I don't think anything needs to change
> here.

OK, thanks.

