Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773118493
	for <git@vger.kernel.org>; Fri, 24 May 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573037; cv=none; b=a4y61Ejk8+tZJ/RpzAkDc6N0EeSnauMgvg4Iz2AIz9qjK/Xq2nDy/5ZGQ/8eWLrE2tK8CLMu0YP0NdqDoXp2XBUbNo7UWegDM5OgQC9PIEpgaRHX+tEK1VOnvbXp9sIKU93a1iE1IQCLWNdhSnSNtMEC/r6V0wCQJa+dag1K3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573037; c=relaxed/simple;
	bh=IDKxmUL6ntvEP5TxUTunCfsR5KPSeL0t+pvpPJnbWVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pkvu4bl9hp+II+ZDEipIt0Ewkt2kyLUv19XSbNlRE0e6Kd8HWYr9/9AYsf9qCu2kKIzIK/1PnL2+3vxnPr/zvzw+jx/zB8dDSa/ck5HOhZcMkEJtcfBBShA9OnD881wxeToJQSRzcbk1obMc6jSV5ZRtQgz1+alXumYOZA4yx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yhoILIO2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yhoILIO2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 518151B0C4;
	Fri, 24 May 2024 13:50:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IDKxmUL6ntvEP5TxUTunCfsR5KPSeL0t+pvpPJ
	nbWVg=; b=yhoILIO2U8tBLsmwfW03j1327p63XdUnoEDFBSIvD88OmII06beqGZ
	CF/czRDl6UN0zqNdvaptLCTw6+S9SL0kcPk3wMcCxQxVu3mF8XeLAsPypwX0+JOl
	Sg/1c8dbjCroiiCQkxijnJ8PyuBUzUjrccCqZuS9bZWAnOWj7RrYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48DA41B0C3;
	Fri, 24 May 2024 13:50:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A04AE1B0C2;
	Fri, 24 May 2024 13:50:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
In-Reply-To: <Zk_ip35jHUj_5M94@fedora19.localdomain> (Ian Wienand's message of
	"Fri, 24 May 2024 10:43:19 +1000")
References: <20240523042143.1220862-1-iwienand@redhat.com>
	<20240523043806.1223032-1-iwienand@redhat.com>
	<20240523043806.1223032-3-iwienand@redhat.com>
	<xmqqpltcwnqm.fsf@gitster.g> <Zk_ip35jHUj_5M94@fedora19.localdomain>
Date: Fri, 24 May 2024 10:50:33 -0700
Message-ID: <xmqqo78vksk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1F218124-19F6-11EF-A3E8-25B3960A682E-77302942!pb-smtp2.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> On Thu, May 23, 2024 at 08:29:21AM -0700, Junio C Hamano wrote:
>> ... if the reader truly understands "the alias gives the command and
>> its leading arguments, to which the invocation can supply even more
>> arguments", the reader wouldn't be writing such a command line to
>> begin with, no?
>> 
>> So I find the example a bit suboptimal.  Hopefully additional
>> explanation in patch 2/3 stressed on that point well enough with
>> much more stress than it talks about the implementation detail of
>> using "sh -c" and "$@", so that readers who read it would not even
>> dream of writing such an alias in the first place.
>
> Right; I was seeing this in a more convoluted way via our tool but
> essentially the same issue.  I was just looking for the simplest thing
> that also gave the syntax error output, which I thought was something
> people might search for (the "unexpected "$@" stuff).
>
> Should I just leave as is?

If I found as-is would be good enough, I wouldn't have been
commenting on this.

Even in this third iteration, I still didn't see the added
documentation talk about the principle behind the design, i.e. what
you write after the "git your-alias" are appended to the command
line to be used as additional arguments.
