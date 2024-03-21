Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F8132C0D
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040350; cv=none; b=msQrsch0l/nrPYKJucGSQXg7kdity1fCNSv02QnvPSRbE/T0a0FetR2TwpRym8XMl4LOR1nomdS0o3c3gRBgioP9pgAgCCo6cLijTVgq3Fq2EC9quoCqO5EOSf4c9Nh39eorHrBgx7wRypwbMbJAteW42w6U1Wz4nFo/YAC0Hmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040350; c=relaxed/simple;
	bh=WpgXTjIPVMjn7flM874sulNs9oexHYMNHKaEDDEt/6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VB6T3OFaIiZopg8comiRoIY1ud3xoxX3IT2M4Y+gDlG/Dg0RcyE7UNodmal9/lg9Yi1Owbu3ADoab3tmPbaR8W5sg4ZsTrJ7BT0k6Nih3SbLMRBMRMu6tlcWD4hoI5/LV9AKk2K05/uCru9JzZSFauvv+mf4l0o40SwIIGzsmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uRD/8FkD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uRD/8FkD"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C8082C544;
	Thu, 21 Mar 2024 12:59:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WpgXTjIPVMjn7flM874sulNs9oexHYMNHKaEDD
	Et/6g=; b=uRD/8FkDQqCKA7IpkH+UebiIhwB3YmqEVxumqsiibRQkVEPzZniA+3
	f3hNC+gWFTxtofXKij2ZZodv3sYn2KSshjI/t3vFwZ4g4i/yv4g4iOmOT01UTgVm
	GG8gF6cGBOtpJCxvDQECcvALgNgOBsZJBi991PLRxky20hyFPM9Qg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4510D2C543;
	Thu, 21 Mar 2024 12:59:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B75132C540;
	Thu, 21 Mar 2024 12:59:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Aryan Gupta <garyan447@gmail.com>,  git@vger.kernel.org,  karthik nayak
 <karthik.188@gmail.com>
Subject: Re: [GSoC] Discuss: Implement support for reftables in
 =?utf-8?B?4oCYZHVtYuKAmQ==?= HTTP
 transport
In-Reply-To: <Zfwv24OnsD0pDQ7D@tanuki> (Patrick Steinhardt's message of "Thu,
	21 Mar 2024 14:02:19 +0100")
References: <CAMbn=B7MtohTm=J+XL8iwx_CuWo47jM-v=e=p+k6hY2CKWX+Og@mail.gmail.com>
	<xmqqa5n1ak1f.fsf@gitster.g> <Zfwv24OnsD0pDQ7D@tanuki>
Date: Thu, 21 Mar 2024 09:59:03 -0700
Message-ID: <xmqqcyrna5d4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 52F755C0-E7A4-11EE-B5D5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The reason why I added this project is that I found it to be interesting
> as a thought experiment. The reason why we have "info/refs" is to help
> out clients of the dumb HTTP transport to figure out actual refs in the
> repository because they typically live in many separate files. But what
> I realized is that we don't actually need it with the reftable format
> anymore because we basically already have a definitive list of all files
> that a client needs to download to acquire all refs: "tables.list".

Yes, YES, YES!!!

> So theoretically speaking we can implement support for dumb HTTP with
> reftables by having the client download "tables.list" and then fetch all
> the "*.ref" files listed in it. Whether that is sensible may be a
> different question.

It is not even theoretical---I think it is the RIGHT way to do the
dumb HTTP walker if we had reftable from the beginning.  Having a
file at a known location where we can start "walking" from is
a very powerful thing [*1*].

If we do not have to change the server side at all, which I think
what you are saying, that removes the major part of the problem I
was having with this proposal.  I do not even have to worry about
speaking with the first-world bias and hurting folks with needs that
are only served by the dumb HTTP walker, either.

By the way, about two years ago, we have talked about making the
first step to deprecate dumb HTTP walker [*2*], but given that
nothing concrete materialized, we are ready to move further, yet.


[Footnote]

*1* With the filesystem backed refs, because there was no standard
    and widely supported way to ask a dumb HTTP server "what are the
    files and directories under this hierarchy?" and that was here
    the ugly "info/refs" hack came from.

*2* https://lore.kernel.org/git/f8639116d2d384a6d285c75830c52d8a8230ae6b.1647243509.git.ps@pks.im/
