Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F36740A9
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k4w1QIbK"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CABBA1ED38;
	Mon, 18 Dec 2023 15:19:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZaPX6bkSKV91YW9QznGFYX8pToZctBnfVfa0bR
	8/SVY=; b=k4w1QIbKtWoCi/ii5najxPdQIfcO/V5KhpjNh+GWco2of9HtGWApkg
	XEsb39W+LLHvD7JpLdlUEQpQIRXkHEaPspxOPvQ3fngXR0+1adrdU5hHJsalr9AT
	yXXsi2Bh/PICbSYQNlzlpUo5jVomnhlRLiBoMDxBQiP13rkbbkA/s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C38301ED37;
	Mon, 18 Dec 2023 15:19:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDD6F1ED36;
	Mon, 18 Dec 2023 15:19:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org,
  AtariDreams via
 GitGitGadget <gitgitgadget@gmail.com>,  Seija Kijin
 <doremylover123@gmail.com>,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] git-compat-util: convert skip_{prefix,suffix}{,_mem} to
 bool
In-Reply-To: <b7a56625-46d5-4d77-b4bf-5595a6fb2aef@gmail.com> (Phillip Wood's
	message of "Mon, 18 Dec 2023 16:23:19 +0000")
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
	<20231212200920.GC1127366@coredump.intra.peff.net>
	<8bea38fe-38a3-412a-b189-541a6596d623@web.de>
	<20231213080143.GA1684525@coredump.intra.peff.net>
	<4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
	<20231214220503.GA3320432@coredump.intra.peff.net>
	<99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
	<2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>
	<b7a56625-46d5-4d77-b4bf-5595a6fb2aef@gmail.com>
Date: Mon, 18 Dec 2023 12:19:49 -0800
Message-ID: <xmqqa5q7e00q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC3F3328-9DE2-11EE-87A3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for the comprehensive commit message, I agree that we'd be
> better off avoiding adding a fallback. The patch looks good, I did
> wonder if we really need to covert all of these functions for a
> test-balloon but the patch is still pretty small overall.

I do have to wonder, though, if we want to be a bit more careful
than just blindly trusting the platform (i.e. <stdbool.h> might
exist and __STDC_VERSION__ may say C99, but under the hood their
implementation may be buggy and coerce the result of an assignment
of 2 to be different from assigning true).

In any case, this is a good starting place.  Let's queue it, see
what happens, and then think about longer-term plans.

Thanks.
